Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED2B78046C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 05:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357571AbjHRD0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 23:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357566AbjHRD0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 23:26:31 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13542684;
        Thu, 17 Aug 2023 20:26:30 -0700 (PDT)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37HKUWli030801;
        Thu, 17 Aug 2023 20:26:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=rqQvhFT8zTZjxKiu2ll4hTXPD4WqTxDe+5z/5JP+5rM=;
 b=B4Mc7lRKrlC9fL1fqFxKwqRhnr/9tSSXSKtX7HNUrlEwjb8+D2zMm5o3XTvL74KzjioY
 nl4mgtdkorrdt7LxM3AF1BYT9+17BAd6kyNLxwmbhZ0SQnLTyLKGx7Pbw2fsNxcF0DEb
 zzpunigRVuGn170htxgKtel3V/zdjs/6rGmDBfgufjFxFCj9JzTAHAMLkA+/HtTf7mw1
 79v0jSLKPWW3b/0hVqyehaNt4Ifrp0O59ZdvtJZoUwXzo8K5vpzZE1nJet6/yKq13jjq
 aJv8wrOhI97RTsDcxrfJlmCtkf98MKlIv3us1t+VdWqobZsVENiDlxqrc83K1Ig4aAH0 ng== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3se93ksvg0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Aug 2023 20:26:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1692329176; bh=rqQvhFT8zTZjxKiu2ll4hTXPD4WqTxDe+5z/5JP+5rM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=ekwkfVc/i3vsE2fm26/dHRhlZjKii72Mx52FdCwmE9FEssqi1aEpfAO/qxmXVrJNL
         sRAZhzDcRk23r4CWk3IbReEZVM86FARzQVMNysg/ulUjwMK8oIl8tnPBl8GiRWrhxZ
         WMp+ESpXZqu6IFTtorpw6cBN/QgI2jBHxk77DlcjOoygvKnFLz5e75lLnMtMGFB7lM
         kAPtbLr4LBWMFLB3R4sxLXIToRjBbWxpW2/AmhhpVvK9VXIXlaT4k7kWNym/mi3D5d
         +VbhrA1ATmUbmImvpi+lIQLrrRE6oPJ5xR+v5VScpfS6ksdb81Vt/XuiF/aEnsfyb4
         nFKW1928KHr5w==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A15EB40355;
        Fri, 18 Aug 2023 03:26:16 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id B9E14A005F;
        Fri, 18 Aug 2023 03:26:15 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=YbSzXWkP;
        dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id C63E740359;
        Fri, 18 Aug 2023 03:26:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lohawaLdVh8yIUW6WWnu39AKu0yvMmoYu6iWW15w2FDrSPBxziY6BFADEIbOCeBoXiY8xywY9VXcaf1IzsI/G0JSUnBGAUWhZ+K6PXWC3T+nHLXjtHBOBvYfiJgHUhhUbRf31s1Y8y4sLeyi8BAqlQ2vgwDqXYw5SeRhmjxg9OFiYcC5HI24UjmQWaOUxltBWhoOPcLw1H3oyJH/p22NX/4kaUyzL4gaFCdd9c6IMJhrb2vXvEwbWjUOQnW+xDFv+D1lZ+hCHOeCecgMber/i4RjRPKuKFsPlfQZ0y7J078XPnFIyPzYZlJI+J10byo89TeSuh18vzg3EdLvsmAK6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rqQvhFT8zTZjxKiu2ll4hTXPD4WqTxDe+5z/5JP+5rM=;
 b=MGRGlHMYUHwYMvu7APFhpChiumN5W2SwNrQXOtSF4v9PUWXewbsUTk/8HrnlY/3knJQvgIbLd/kTltMClfpmNDtOePDPWJBdTtgL4wjQHnavYwoRRsbh6GO3URsdeJ/kp+WId2TkTtPjONvjpNQH+bUu7Gb65AoKlxyE0RsZLYstZfz/0UtenOrQr61sCYJX4adPDPmoR/LZORpHCK2k07B6d4dwZZv32NKnufPFA1EqiOr3B2CSnhWub9KaWPHyWSFEqztEq+/RP3cTWz0+lNJ6mUAC4W4nXYoiU76Bpqtomd/lIl5Du+NPVOONiA0/dKqTmm9tgZJMZWA8CXFdSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rqQvhFT8zTZjxKiu2ll4hTXPD4WqTxDe+5z/5JP+5rM=;
 b=YbSzXWkPfQFy9zLslaFuwRhq+XiKgRhfyRC/Th4AGQMpce6RYojVT10MojqdaEnw+R/VHnFWxw3OwuBD6AcwMPlY8PuCO7mW5RyXLs/AvzqaQbQq1V0ObeI8wput7W/PQqm/TG+AjHW914lOXQeBYPMkINhEZJvytVQZgF4eTeg=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by MW3PR12MB4364.namprd12.prod.outlook.com (2603:10b6:303:5c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 03:26:11 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b18d:912e:908a:5952]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b18d:912e:908a:5952%4]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 03:26:11 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Andrey Konovalov <andreyknvl@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: dwc3: unusual handling of setup requests with wLength == 0
Thread-Topic: dwc3: unusual handling of setup requests with wLength == 0
Thread-Index: AQHZ0WkxsEX2ZGMtZEmcF1gvP2WuTK/vPhuAgAAY0oCAAAlogIAABEuA
Date:   Fri, 18 Aug 2023 03:26:10 +0000
Message-ID: <20230818032607.prgavrozuq6p4r4x@synopsys.com>
References: <CA+fCnZcQSYy63ichdivAH5-fYvN2UMzTtZ--h=F6nK0jfVou3Q@mail.gmail.com>
 <20230818010815.4kcue67idma5yguf@synopsys.com>
 <bb470c47-c9dc-4dae-ae3f-c7d4736ee7e9@rowland.harvard.edu>
 <20230818031045.wovf5tj2un7nwf72@synopsys.com>
In-Reply-To: <20230818031045.wovf5tj2un7nwf72@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|MW3PR12MB4364:EE_
x-ms-office365-filtering-correlation-id: d269aec0-f4eb-4c03-6073-08db9f9ade7a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GKSxs5bBBR4EEnHiARXoXc+0KGMW8XNjG0L1R24AeL0BCN9OKerpMb2AyQKIocEH1NHNTfmlNg0dNjJZrwlREPxsPDMm0qvpjcs+axhMAaIwIaeBg4XEamC/w7xx2N3Q5YwIy6ZVaeuyZPMTk9IlrVmITlUgTj6hMbaPY4w+rjshhF0/NDAAr4OTTJLyiqTRsX7k3LAPdyxt6sdDZvOVHgGyxfoyu6u5jmNL9j8BWozfNPeMhvXLHq8zrIM+gfaTlZh2t7pwjUihGuLPna5FaHNfHK/ub+vII9wTkfCgqRUmKMlmc5KhRIyw/dNjmr5+PJMp2+G++jqDYwpXbhXzqZOKR74xe6mvHgFHHrd8aQHovBmOGloIut+fcrYRZJs4StYCoSkwuY3HzeQsTb8mP1VPXJtA43LY6uRbBIvlHfDLed9ADmxHt6seXjNt5cAfwNXj1YReZwZBhrWpkQI1iyeFjUQ9YTO9C1Ukt3AAQWOpR/TaiGcfZG/74Z48rsBhFJVMKV0ltT35scv1TUA6iWvNp08Q+jNyf2Ma77dGLWOBJq/AaKzxBIaNVjd1xxTAd7+7K4UgQuDSc2okd7DvLs1Pt9kMGHlQ3/IxVILi8dG+nyYEsJ7UNdbCpsD2oL6O
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(346002)(136003)(396003)(451199024)(186009)(1800799009)(86362001)(36756003)(83380400001)(8936002)(8676002)(4326008)(5660300002)(2906002)(41300700001)(26005)(1076003)(6506007)(71200400001)(6512007)(6486002)(2616005)(122000001)(478600001)(76116006)(66476007)(316002)(6916009)(64756008)(38100700002)(66946007)(38070700005)(66556008)(54906003)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3JEeFNPNDNRbFg3YXYxeWh5TlBSSVZFcnlaMHFmRzV1UFRiTXROYnFRVVpz?=
 =?utf-8?B?UU52OHhadVVYTGFOcjZZQnJ2cVpDdHprRnJLRldPc3llc0szalh4d2JCbUxE?=
 =?utf-8?B?MDBkVjVqQVJTSURGY1h3Nk0weW9WSE5LWDYrZTJMMjRKc0kxanI5WE5yYlNi?=
 =?utf-8?B?aE0vSE9zVm9PeDZnY2oxZUVQZitVTGxLS1N6eVViKzlyWk9PZmIxVlhRdy9o?=
 =?utf-8?B?TDFjdHgvUWd0aWpOU2xvYWJ5YmdneWNBY1BZZ0RwTmdmemVDTEpITTB0SnBa?=
 =?utf-8?B?aE1wSVdsckJ6ZSthajZWTG1SMnEzRXNuRUZkZ2JJUDdjZnlCK2lncUdaMTh2?=
 =?utf-8?B?MEg5L3FpazlYaWtNRmtvdFBVYTc4K1NPSXNQZkdKdHRNV0FOTUtzWjV3KzFU?=
 =?utf-8?B?L2xDQUdYRWxGYVZTQkp6S2NNQWF1WllQY2tYNStzUnZxK1JvSFE5SC90SDNi?=
 =?utf-8?B?NGZBMkw0Q3d3U1QvZlRYeE4wM2s4U0NZVDlFL0VuTlV1VlNwNEw5U2RFOEIx?=
 =?utf-8?B?c1pHWStYdUZJMTZKeDlhOCtudyszeUhkUUdyeHJkbEtLMWVOenBHbmEwdTdI?=
 =?utf-8?B?Yi9kOHc4T0M3NjgzL2twVVBmSWZwY252RzFxYkxaMkFBUnVOVzJ2bGFkdnVV?=
 =?utf-8?B?Z0xKOWk5OS9zc1FFK2VscUxUZGMzNnZ4RXR4cTRvTlJKNnpvTVVMeWozNDl1?=
 =?utf-8?B?eDk0QkVlaUFSa3dhTVdNcnpyMjFrVlBLaWw0bWlBVVNUK3o3SzEyVVpBc08v?=
 =?utf-8?B?UGxlVGlzeFFJeGVtaDVkWjFOVXBlMFVzTkpGekhlMzVqU1lVSkVlUFUxUGZo?=
 =?utf-8?B?SUJSOXRCd091cHVYdElsWm5xamdoVHRZYXFhSEtVV1gwUWJoOXdhRENyTnVN?=
 =?utf-8?B?TU04dkcwVFNnQnZ6aXNvZ3BVVzFVWHh0SnZCaUNyaUdsSDFvLytEYzhMT3BV?=
 =?utf-8?B?MlZJeURXVkcvN3MrdVJHcUR0MTZWOUZGbVcxeTAwdHF3TVBCcXJyaUR2ejdz?=
 =?utf-8?B?bUx4b2pFZHR6TXhJSTNXTSt6dEkxNklGRzNOV1dad1NmOWl4ZlhEWnRyUjBm?=
 =?utf-8?B?dkRwc3NpOXNWdXZKSlhmNmdreW9DUS91UUZiOTN2WHJ3NVdjc2ZsRjN2alNz?=
 =?utf-8?B?bjlnYnJ6MkU5NFR4eURTWFdDRXhRN0l3dXBZL3c0OStOQTdsaS9GZDNjeHpl?=
 =?utf-8?B?anBGNlNIbjRWelJGUnB4eWJOZzNqY056NkNBSjBiWGx2cFF3LzJDcFNWZG5l?=
 =?utf-8?B?cHJJelk2cXVjOGJuelhSSk9YbEVIQXl3b0pCN00vdXc4MVRpZW14U1N5MG54?=
 =?utf-8?B?N1RYbjdQWCtzSjRPNmxvT2xBRU1JVk5MbzMzc3ErUTB3RDExanluTlFwVitL?=
 =?utf-8?B?cXVtcXNiR0VMTkpoTHBoTmZxUTR1djVza3ZmeTJ1QUJSaGNQbGJIeUJNWFpt?=
 =?utf-8?B?V1A5UWVCYW5wNnVFMXBZU3cwcVNUNWRWZkZUcGh3TDlmT0d6Y2cvVjRxVkZ2?=
 =?utf-8?B?WGkxdEZncTRNVTdNRDlvaDlPQ3R0NVlMTThSNzl3eU9uWm9DdVAvZkN2VktG?=
 =?utf-8?B?eSt4ZVJMZmVlNENtVEdYYUJQQVVtc1gycGJ4Z2N3K0VUMzc4enVHT3AvZ3Rv?=
 =?utf-8?B?YjdMalpmbmFjTGoxSHhFSmhLK21kYXBpWXIzVXRxM2VXRldPSW83K0FnRzgr?=
 =?utf-8?B?Qnp2WnMxTEpJN3prc3J3N0dheUdJVi9KRzZNTGtJTmQrbUxrbXRIWWRnVENJ?=
 =?utf-8?B?dEVZQ1N5QjRZSlNsNGhhY1ZtSjgyS2gxSE9RUjRxcTBxTkdObllkM09wYysr?=
 =?utf-8?B?M3laRWplZ2JCNDNrN21LSmJxb1pLUm1UcVNYYXFhM1lHcjI0MFpnT0NmU01T?=
 =?utf-8?B?M1NDeVFLWGViUTdJUFdpa1JYMEtic0FHQlR2NmQvaWloc28xUjlBaVpzcE1J?=
 =?utf-8?B?Z0RRc1hFNkRQa0t4MGcvdXBxbVFVbm51NGtNb0hrbUZoRWNiNjNEU3pRa2Zv?=
 =?utf-8?B?Y3UvTkRoNWVxSnJMQ3ZHVlZNaU10NURVUWdCeklOSUIrM294NEtJeVNXMUc0?=
 =?utf-8?B?SWd4VEo5VGNNYVRzNFF5T1hUYWhkYzBhaHhDUS8zV3A0bTJ4MDhhSmVTdUVl?=
 =?utf-8?Q?MXv+JajuYU5JJq+TZd3zLUiLK?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <69EC8F1B84553F419FAF7E39BDF4B04A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?WmFkUld1eVBuY055bFNzekhEa25zc29CeU5TZFk3aFE3YytUaEQ1V0w5ZHZU?=
 =?utf-8?B?eXNNN3hMaFZXUHgvdG5ycEpvUTdDaXo4UDZVbjNjdTgyWHFmRW5TSTBUR2I4?=
 =?utf-8?B?bU82ZWhidEJ3dnpLVmRndVBjeVM0djU4d1IrQ0lRZitNbUE1QXh0czZKQWsx?=
 =?utf-8?B?c05EZ01vWnRsVWFLTkZNdzdVejZlVUVzK0h5ZGI5RWNZcFlMNlVnaUo4VWNC?=
 =?utf-8?B?VWlhZEx1Z3lFbmRwUzQwajc3dWdjM3JxM3RXaEFkQmc4eVUwUm9SNGpYWEdj?=
 =?utf-8?B?dmNpQmZkVFFoRkVxSkFLZVdna0Rsc0hQU2pMTG5rVW5YYTkxRzJYWmlYdlpv?=
 =?utf-8?B?Z2x2enJtRXlPV1NjYXc5YS9aV0Zra09PU1ZHRXhvTEVxRFRQSjM0cTFTYnRa?=
 =?utf-8?B?YUx5c09rZU1DdElBWUxIaSt2R0ZQTUk4dUoyR0lReGdTaG9rSTZFaXBmUmI4?=
 =?utf-8?B?QklpUGsybkR4QStGc3FKV0wxVW1hWWxKTCt0ZHhlQzFuYVdiWTFtUWo0RXZ1?=
 =?utf-8?B?VlY3UHFZRmt1cVg3ckM5NGRjc3I3Nnp5dTFCaEkzeWU3NzVEZ2MrcXlXVkIr?=
 =?utf-8?B?aVc3VjQ2RXFaUXM3S1pHeDB3dVB3T0FQTHZIY3FRREdBcjAvQXFMSFFXTElJ?=
 =?utf-8?B?WTFnTlVnY1VXLzY1ZFF2OHMwR29RcEhCUTFvZzNGR2dsWFNTNlA4cXAya3NM?=
 =?utf-8?B?Q1FCQVcrQkpwMEQ4SFhTSi9ueC9vOHlneEpmOEtqVklMUFZqOWN2aWFVWExS?=
 =?utf-8?B?Y2lFZDNrbUI2d2hCQndZNkM4ZXhCRExGVldieGhVVDkrQnZNMUpNazdqdzBu?=
 =?utf-8?B?QjI1clNpYUFDaGVjL3JYQnV1bDNLUTZZRFU4YlBsYzlXbVMwMmg4V3ZoMEQ4?=
 =?utf-8?B?clkvZ0xvZHp3Q3J2b2w4MCtLVFhBcE1mbmNsd2NUZmNHWDNYakswRUxCZkxG?=
 =?utf-8?B?eGFQZ05YWWh5VHNPaWZ2VFJJYkRlc2xoT2N0ajNvOGhyTlZ2dE95Wm1YZXFZ?=
 =?utf-8?B?Yk90d2taK2ZpMDNRd2R5V2tuMkdRTzg4MGVFZkNhbEQwSzBLZk1MZUQ5cHlU?=
 =?utf-8?B?NUtqTVp5TXBnVU1rRStMdEl1N24vMkpZYlhmQlQwWFgzTGRJc0JFMHBHb0tx?=
 =?utf-8?B?UTk4c0ZQWHdJS0VCZjZidExJYzRDWmdwMG44cHZMN0RyVFZkNHI2L01IK2cz?=
 =?utf-8?B?bzBZSzdJd3lMNG1sYlBOdFpwMXlTNTZJTFRtWGpUeVd1TEE0b3pnMDZnMjY3?=
 =?utf-8?B?dFRTNGRuT01JV3VNQTV6MTNKdEx5TlhZaEF1bEVUVVV3cENZQT09?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d269aec0-f4eb-4c03-6073-08db9f9ade7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2023 03:26:10.9272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oqTKNrAmF+7yFTqGQuIEUhjPBJI0iBwl1FSADKBbo2RAvxsSSE25f1Lu3gqhoereNizgXxfrR1ST2fv9khNkiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4364
X-Proofpoint-GUID: uvl_OsTMsfrwdxyYxZYFH__xCrF1_6GC
X-Proofpoint-ORIG-GUID: uvl_OsTMsfrwdxyYxZYFH__xCrF1_6GC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-18_03,2023-08-17_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 mlxscore=0 priorityscore=1501 spamscore=0 mlxlogscore=498 adultscore=0
 clxscore=1015 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308180031
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBBdWcgMTgsIDIwMjMsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gT24gVGh1LCBBdWcg
MTcsIDIwMjMsIEFsYW4gU3Rlcm4gd3JvdGU6DQo+ID4gKEFub3RoZXIgZGVzaWduIGZsYXcgaXMg
dGhhdCB0aGlzIGRlc2lnbiBkb2Vzbid0IHNwZWNpZnkgd2hhdCBzaG91bGQgDQo+ID4gaGFwcGVu
IGlmIHRoZSBVREMgcmVjZWl2ZXMgYW5vdGhlciBTRVRVUCBwYWNrZXQgZnJvbSB0aGUgaG9zdCBi
ZWZvcmUgdGhlIA0KPiA+IFN0YXR1cyBzdGFnZSBjb21wbGV0ZXMuICBCeSBzZW5kaW5nIGFub3Ro
ZXIgU0VUVVAgcGFja2V0LCB0aGUgaG9zdCBpcyANCj4gPiBpbmRpY2F0aW5nIHRoYXQgdGhlIGVh
cmxpZXIgY29udHJvbCB0cmFuc2ZlciBoYXMgYmVlbiBhYm9ydGVkLiAgDQo+ID4gUHJlc3VtYWJs
eSB0aGUgVURDIGRyaXZlciB3aWxsIGNvbXBsZXRlIGFsbCB0aGUgb3V0c3RhbmRpbmcgcmVxdWVz
dHMgDQo+ID4gd2l0aCBhbiBlcnJvciBzdGF0dXMsIGJ1dCB0aGVyZSdzIGEgcG90ZW50aWFsIHJh
Y2UgaW4gdGhlIGdhZGdldCBkcml2ZXIgDQo+ID4gYmV0d2VlbiBxdWV1aW5nIGEgcmVxdWVzdCBm
b3IgdGhlIGZpcnN0IHRyYW5zZmVyIGFuZCBleGVjdXRpbmcgdGhlIA0KPiA+IC0+c2V0dXAoKSBj
YWxsYmFjayBmb3IgdGhlIHNlY29uZCB0cmFuc2Zlci4pDQo+IA0KPiBJZiB0aGVyZSdzIGFub3Ro
ZXIgU0VUVVAgcGFja2V0IGNvbWluZyB3aGlsZSB0aGVyZSdzIGEgcGVuZGluZyBjb250cm9sDQo+
IHRyYW5zZmVyLCBmb3IgZHdjMyBVREMsIHRoZSBwZW5kaW5nIGNvbnRyb2wgVFJCIHNob3VsZCBi
ZSBjb21wbGV0ZWQgd2l0aA0KPiBhIFNldHVwX3BlbmRpbmcgc3RhdHVzIGluZGljYXRpbmcgYWJv
cnRlZCBjb250cm9sIHRyYW5zZmVyIGZvciBkd2MzDQo+IGRyaXZlciB0byBoYW5kbGUgdGhhdC4N
Cj4gDQoNClRoZXJlIG1heSBiZSBvbmUgc3BlY2lhbCBjYXNlIHdoZXJlIGR3YzMgVURDIG1heSBo
aXQgYSByYWNlIGlzIHdoZW4NCnRoZXJlJ3MgYmFjay10by1iYWNrIFNldHVwIFBhY2tldCBoYXBw
ZW5pbmcgZmFzdGVyIHRoYW4gdGhlIHN5c3RlbSBjYW4NCkRNQSBvdXQgdGhlIFNFVFVQIGRhdGEg
b2YgdGhlIGFib3J0ZWQgY29udHJvbCB0cmFuc2ZlciBmcm9tIHRoZQ0KY29udHJvbGxlciBGSUZP
LiBCdXQgdGhpcyBzY2VuYXJpbyBzaG91bGQgYmUgdmVyeSByYXJlIGFuZCBzaG91bGQgb25seQ0K
b2NjdXIgaW4gc2ltdWxhdGlvbi4NCg0KQlIsDQpUaGluaA==
