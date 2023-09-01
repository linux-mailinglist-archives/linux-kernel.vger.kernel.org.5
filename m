Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E13F790332
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 23:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjIAVvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 17:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350847AbjIAVqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 17:46:23 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B813E19A5;
        Fri,  1 Sep 2023 14:14:48 -0700 (PDT)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 381IdCo2017643;
        Fri, 1 Sep 2023 14:14:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=Qi6koF96Mqfi96olaU9KX0K5R1rJmYuqiHGfdnTexwc=;
 b=o5myvLKKMhDmw8P87y21OqaI3/a2wJ9lMlTgiPYKsh1N3GFItg0v5z4Tge4Hqy5qnLyd
 CPj+bVwaRecp6/vt1ooNxcMXU5Pw9LlEOLpsCSxccaS1EwWCq9texh6s/whRCmWfk8ea
 Jhpdt6DTrtlJcjwzAbR05siGE3rnfSxnyWG+dPAv7/jYaQGnpFgiJ7OHECogMcn10Idp
 iGQHzBFFpv1hQwuglsYAbBllgeF4hEqe9ODmtOXHPogjcq/kAgSIzh7AJKfS1dmd/R5c
 wIFKDrEmYurhXrrh3Pwz3EBsA1g5Ej+wa666gc7JNxtsG+D5+1IRnEVBjg6L7LofCfpL 1Q== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3sqgdmy64v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Sep 2023 14:14:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1693602867; bh=Qi6koF96Mqfi96olaU9KX0K5R1rJmYuqiHGfdnTexwc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=O00ThHOjZinvr90RSB42c9by/3MNdaJWM9jOIdI3oGcKpgtLMfnfI2abs+7CProqQ
         yobMV0hGgkeJyMGRsSO6m/nYd6ja8BQOOarEjHsihC3v4K1yWKwSc99nU3aOgGSkFv
         qACi5yLVDna6zSbAEdHEfH/D2HO6FPj9M27VG8m+/FWEGluJsY4CxPk8Z8lcLhq7zB
         Wyt4RjQ5dmjCBjU/kTKpRcsm4IMOpII5NdSKD+ugR1qajmn8Lnvh9GDeXKCZa7FDRL
         zkFbqO0o+4kAWR2rH5p1cJdzphcaFxoZXkYEXnR0nOjiVd8h0FHjOE4B74bBIi5WPb
         24ZnR1im7/8GQ==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id EBD21401D0;
        Fri,  1 Sep 2023 21:14:26 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id AEC5EA007B;
        Fri,  1 Sep 2023 21:14:25 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=L19d+czq;
        dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 851B84013F;
        Fri,  1 Sep 2023 21:14:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eDA6hycncsoXIlTiTudhAAo4OQFfRlNXCesRl+LeEVzjmFZx6f+rKii59i7sWwfL7gMAMlv1XwxCOFBKI5ptMTZbQfcCOZCN4dXrKDUQFz9sU4bLNER316GJpjBFK9CspMIBaZXqaW+8o5J8JuPwqiDxLJEmAY1JXqEob/qCtcMZsc9wjCa/vjWzRANTVCe+vFDqRUDSlZ1WmpdtMEIm+rUHa3PNXgO6BSUFTXHZUPG9v6kHb9m8vLyQtskThbniwMN7AdJu4/Lr8rY5X34Aej5U97KVsPYboM6VBVuRzC/d0C/buyKz24P7ftPFeEM8oaCTxDO5WASJ2aLNxp4Zqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qi6koF96Mqfi96olaU9KX0K5R1rJmYuqiHGfdnTexwc=;
 b=JaXxmwaUBx1de6Zkk7pXgD3fe8eUNN3Rqrlhs3fCTkA2M7g27JbyzbUfqmTSgl7WOG3PEdOxrSpzy7LQnp3hAZZ82khUySZ4wJLS37cHTOT+R2521p3xvhK4QqqVGRMfTYBi8AOP+WJim3rVAeinE2NP4B389SbGXC9JhDdWG6zw/zJSj+2+Z9WgUOHDaR4qz4x2N1OY/MUrRd/kalKgXl6LxtN6GkrPw3DtllRLdFlhiKtxvlnBtYH4qnEQquIwvoBYfQVd8MnMYuGzSZ52KOKsamgq5+fLn/IvYC9FyH4Fl+CK3iC/Tg0sqL3gHSc+CFqDDL3rYthmTQxuCzc1mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qi6koF96Mqfi96olaU9KX0K5R1rJmYuqiHGfdnTexwc=;
 b=L19d+czqL+RG3+peMeVj/6XIU3iSbBH3YaR17R39okT/QuWmBXoMic8/YTpwtUN8xLElaR8acRkY6CMKX4LyQxYEYBShOElJzuxS7LaXxalF+vqPQruxvN+7gljHhsdGeLIDJl7gGCJESdJlRy1ko/Tu7nNDGuBRThg8pf+Ugyo=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by DM4PR12MB6423.namprd12.prod.outlook.com (2603:10b6:8:bd::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.27; Fri, 1 Sep 2023 21:14:20 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::548c:ae3:537f:ca2f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::548c:ae3:537f:ca2f%5]) with mapi id 15.20.6745.026; Fri, 1 Sep 2023
 21:14:20 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: dwc3: unusual handling of setup requests with wLength == 0
Thread-Topic: dwc3: unusual handling of setup requests with wLength == 0
Thread-Index: AQHZ0WkxsEX2ZGMtZEmcF1gvP2WuTK/vPhuAgAAY0oCAAAlogIAACMGAgAEOQgCAADc1AIAAELKAgAKA6gCAA+wcgIAA2rMAgAAtNoCAABaOgIAAMuwAgABCyQCAAxO2AIAAHuQAgAYtxwCAAN5PAIAAx/iAgADZEoCAAKLNAIABECkAgAA8jAA=
Date:   Fri, 1 Sep 2023 21:14:19 +0000
Message-ID: <20230901211410.u444xy5rou6ibg2d@synopsys.com>
References: <20230823222202.k7y7hxndsbi7h4x7@synopsys.com>
 <9b175f9e-ab70-47a3-a943-bfd05601aa23@rowland.harvard.edu>
 <20230826012024.mboftu3wk7fsrslp@synopsys.com>
 <ba06679f-93d2-4cb4-9218-9e288065bdfb@rowland.harvard.edu>
 <20230830013222.ukw5dtburjnrrjko@synopsys.com>
 <61cf24db-9dbb-4bf3-aafe-d515fc37cca8@rowland.harvard.edu>
 <20230831024345.lwd6ehcbjdlczjpa@synopsys.com>
 <1a66bb8f-9680-424a-a051-27353b8a4130@rowland.harvard.edu>
 <20230901012322.rwpj32rx36xjtlb6@synopsys.com>
 <4e67f96d-250a-4ee1-9f2c-ad321fa50fdc@rowland.harvard.edu>
In-Reply-To: <4e67f96d-250a-4ee1-9f2c-ad321fa50fdc@rowland.harvard.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|DM4PR12MB6423:EE_
x-ms-office365-filtering-correlation-id: c043d5eb-fb74-4b7f-95ea-08dbab306838
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QbWTqgVrKpX7SHl+LtfAskO44oc0i3CCSwvAlGJJWtyh86qrJ45Mbi7fZfhQCBKG+5xF5U8Opn+OHHu6pnwjydpXtWJw4lctlW3fZTg1gD5Kt9QwTFvTXyhGNvoekIeBNqXkTe29SlAuLAMhAgFWQ4ybbEgCwY2hupWMFaMUxpq9wuLUE4aBi2HdcMlEvPs63AhUZ8dfQPhPMgNKykcqasGCMyO1zuuMLFKDZcw+axVSx9bnUKZUL+TdxbHSXdR754CX+Y2I1/+tLEpvzzZyy8sHWZ3O7vA3de2Kc8FnO8VmVfiEhaM2ShBcYYYB91PEUiIELRRy9W+V6RmLDjAOvJFREeR+ff+hevyKEgKlhc5rKWh7d6VrboVzLXePECTxRUo9hK/lYqXOXaCBgHdwq4+uKyid0EAm+8n0drfVrZmiGcsYQrSTssmgNavuWlH1UdjMS0cHrIq/h2ChYreIIRnHDKmNxtENaFrsO8OlIhyHUQ8TLdz/5nk24RTG8qjsI2HRoehMZaIPiyL6zmRqjrGcLn73F7CpCf38mcb/fQTLdNSEAVl5YmQ/+l+HFtE/5HNwG7ovI4Ir/jSgpKBJ+05MnQy8qKiTptknApIsEr/TMou0bUUVkElnM4ouawhi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(136003)(366004)(346002)(186009)(1800799009)(451199024)(41300700001)(83380400001)(36756003)(316002)(2906002)(1076003)(2616005)(26005)(38070700005)(38100700002)(122000001)(5660300002)(8676002)(71200400001)(4326008)(6916009)(8936002)(6512007)(478600001)(6486002)(6506007)(86362001)(76116006)(66556008)(66446008)(64756008)(54906003)(66476007)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UEFVenNEb014OTIyb0dodWRuZFhIZmZSR01vWDhSbE9Cdzh4a2hJWVZZTnVJ?=
 =?utf-8?B?andjZk5GR0w0Mjl6cmhzUHp1bGdCOExoellYTHhyY0ZBL0JPdFFMMENwSUhY?=
 =?utf-8?B?UzllOUNuQW9XN3lodjZUb3ZiZVRDS245TWZsdzVRYjlQWmYvRFVhMEZJSzFQ?=
 =?utf-8?B?UklZTVlqdUNkSDJRRC9sR3VhdDhocHczekMxUHpqZ0dNU2R1WG9veDNUbE9T?=
 =?utf-8?B?ZnVjOWZCS2RoZFVleHU4bGhBb0F3VnAwcElWa2NuMGNkZklQWHVqTXgrNnZj?=
 =?utf-8?B?SVZsZWNUTUlWMkFFcGdYd1FaV1lyM20vNk56NXdIUElwTzRaYzlyYlFxV2hF?=
 =?utf-8?B?VnQ1amhEa3p5K2lRZHduVmpUZTI3dURmaWhWRllEazdTWGhZeDBLVHVneDF0?=
 =?utf-8?B?L3V2OGYvU2UyaUdaQ2NCS3JjblpsMUE5TkQ4RGUwQ1hLMFJWRzFUai84WmdV?=
 =?utf-8?B?NTBrZ3pTdWljZ2xhQXlFeW5hZEVvUDlxYmUydnhobzc3ZDhucXZrM0ZVaGdD?=
 =?utf-8?B?UVZ6c0ozL0ZjbXhUTWVOMXh6SzJxYVF2amthY3ZRVGU4S0UxSmxBNXJWdWZj?=
 =?utf-8?B?cHAweDNYVzhBWDVrS3pxQUZjbTNxSzJDaFhQWk1vWndEMWROK0E1OWxMZ2pn?=
 =?utf-8?B?SnUvNDRvOGh6clZmdnMwdUU4ZWFrVTlNV1Rwb3FKNnk1RGc3UjFTRHBHZFNV?=
 =?utf-8?B?QlBOQWNzM2hvMWU3ekRmTXFybDBBeTV3SnRKcWdLWmtxZDhNcUlyZlM4WHE3?=
 =?utf-8?B?dWhmYWNzSFBvcUpwNWdUZmpxNW1aWkNqL1hSTHBaMTVNM1hITlMybUplUlQr?=
 =?utf-8?B?OG0wSEljSnF5ZmlmclhrWGxLMENNM09JSmh4RzRBYVdmVWcvMEJsWUdMTlZn?=
 =?utf-8?B?VjVVRm1xcHFwUkl6eTQ4SThMRnlpejlWZ2FLSXNucVZmR2tPNnUrOENHMnZO?=
 =?utf-8?B?eVpPVndkYXZVVjJZcXFqclIrcTR0aGFOSUFsQ0JVZldxdUF5Zi9BRkM4dU5p?=
 =?utf-8?B?a3d4QzY2RGdmQ2lxWTllbUV1dWVDaUxlejh5WXVTUUhJNEJjRS9KNW0xdnR3?=
 =?utf-8?B?Nk0zRUJHR3BwMENUUXNvZXNCcE8vNFNOZDZPTW9BbVByS0M5dWJXaFhUY0c5?=
 =?utf-8?B?KzJHcnI1cnZSekgrYWhWVysxL29TOTZnYWlQWTlQTHFIVzIzVjlIcGx5TW9U?=
 =?utf-8?B?M1EvVUIxUVYzQURORmdHa29RVUxtL1FiazdJQndkZlNONkgwOFFGYTFVMjhj?=
 =?utf-8?B?UEQvUUsvVGZjMW9MSnVNQlNvRUxtYlE0RXFxaFJFU1RGajl4K1RTZXdPR2Q3?=
 =?utf-8?B?VXVpL3BuelpsWjJuUVhTd0RrWFZ1QVZSR3lTczQraXR2c1hvWk05SWdlYXZl?=
 =?utf-8?B?ZFBWdSt1dHNVMmZvZXVuVno2TnRIdXBTRGY0ZlJSdG0rN2pIb2FjaThOaVV6?=
 =?utf-8?B?Z0VUaFhPOUtoRmxVbFF1M0JtMTRaOUtOS3hZWTlwRUkrSXBPU2pkbkNVSFUx?=
 =?utf-8?B?eTMydzNjb250Q2FkemZpaVljcENBbEtTTG1MRUVqaVJYbXV1Q0w0WjN1OW1B?=
 =?utf-8?B?Q2FMVkd6eG02K1pqc0VENXpNTFRIWTFsVENjc2xUcSszVnZDTUx3TGNsdDJM?=
 =?utf-8?B?dm9QOVRUQWwyS3JJZmpxSnZkVkQ1VmlJT0QyRlZDWUZ1ekNNTDlsL3hPSVI2?=
 =?utf-8?B?MXU4NEpjOEtIUTI3NldhZWY5M3pCNGVDUUtrcm9IZmdKaU9rcHJqT2dKMzFx?=
 =?utf-8?B?Z2tQdnZLQlBGcXlYVTlydDdGSFh1TjY4Z2pEVFczNUlBRDN3a2FRTWlucTBP?=
 =?utf-8?B?YUQ2QWJCWVdsSUwvK1ZxVkdwRWFyRXJ6YWlDaXVKZ29nNVNQLy90Rk5EZldM?=
 =?utf-8?B?bEptbXdiSnVkY0h0U3J0cWlaR1MwZTBUeW5OaXg0VFczYldGMENlZ0RCQ0VG?=
 =?utf-8?B?TGlVczVVUUtEcXBmYjJwL1o0dTA3TlhzaHdDRDJINEpiZmtkcVl3aU15dVQ4?=
 =?utf-8?B?bk50ekE4bUtiUDZEdWhqSlF2T3RrQk93alRkQ0ZidXVJRFRLL3JNZHU2TitQ?=
 =?utf-8?B?b09McGNaV2YvMUpmZmpLT2hzcjVrbHdnLythUFNUOW5DVndwcWNyZHJQZW9Z?=
 =?utf-8?B?RlpDNzVhanpBU0w4bEc2Q0JRR1B3Z05kT1dSZzdvb2doNWN5Z2FwamZWNlFK?=
 =?utf-8?B?a0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3086E75894F1784B9BB4991AC7D0C9B9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?bGp0VVBCRDlTNEk4aldWajR2MDdQdUNkY05QYzlpM3NINm1CYis1Z0F3R2dB?=
 =?utf-8?B?Si94OUR6NVZtTEZEbUFZZ1R6OThMNHVSNmFPTThCSk5HVGQrTzBDQng3dnpH?=
 =?utf-8?B?Y0ZvdXprS0o3ZUJFM0Jrby9sUDJrME9VWWhkUnBSaytTZUhjY2JCTG5Ha0lL?=
 =?utf-8?B?dTNabWcxSWdGcWRpSEdIWlMwN0NFdVQyZlY0dGtFbEFsNnFYajY4a2ZvUUN0?=
 =?utf-8?B?Z2Iyaml0VmxydlNVK1pKWHpyQVJscE1YT3J6T1p2bUoxMjZBRkJNaHhpZmNW?=
 =?utf-8?B?Z2ZtcmZnVnp5L2I2WnA4SnlPdTBtaWJQbHhGeVYxUFdNTkUrWlNtSFlmWlJw?=
 =?utf-8?B?eEpRT0pwTm4rYXUva2FzZXhSQWp4aXdEY1FVVURuMkcxM2g2LzVWZW8vbFFj?=
 =?utf-8?B?TFdIWUp2azc3YTdLTllwSzBuMWwveDk4U1RlYUVZd2Z6NktrQmNRK3dlNFY4?=
 =?utf-8?B?NVhtVUhrZld6VVU0QXJDRDdyN3NUZm1OZVVPWTFqd05pVEVoZnNmOVJEcEFB?=
 =?utf-8?B?a1FHeE1mdlk4TDNVYVJ0bTU0OWlGNzU4WE9lQWlVRUd3ZVhLOGlrSUNIR0dz?=
 =?utf-8?B?N1JFR3F1L3BrMVNIbjNNZFpWZDJjSDlQSElQMm5LZmlDWlo0dEQ3SEN4enRn?=
 =?utf-8?B?UUFiTTRUVkpvVCtLejZseW43ZG96UUszN0NiU3VlMDlvTmhmRnZEM2xLcDRy?=
 =?utf-8?B?VnYzK1RKSi9CbWJoM2RqM1EwSEhBbHZLNGdPR3JoSXB3ZDNyQXRQa2Rnd09M?=
 =?utf-8?B?RnY4T3BtVnJFOEc2YXp0ZVR1b0NVMHRNcVNRdkk1S2RmOTBvZFdVQnNaQnov?=
 =?utf-8?B?SjBhalJhOHJPSEwxMG1IbXNISUxwVmhPNFgzQnlOOTBOWlEybzYrMmpLalJj?=
 =?utf-8?B?RUFvTlRJTDN4QUpWQ2M0ZkczSTNFV2lXNllvUFMyWFRFdXl2VWVzd3lCMkNw?=
 =?utf-8?B?S3BUU1lPcjErUVJRcUZ4dXV6emxxRWc4RXVrSmczOWJmWUNpMTQ0eFRIWUc1?=
 =?utf-8?B?VlRMREZmeU5QMHF5UjlnWWU0azl5T1dJTDFzc25MNCsvdE5VRkMyN2o2NG1h?=
 =?utf-8?B?ZVcyUUx1VFJiRENhS0dwWTc5MUlTSENQN2wwbmJaK2Y2MmhoQng5bVBjeHBz?=
 =?utf-8?B?VUVndHU3SktGSTdWWFlSMjdGR2FkMVhpRjdxWEg2NkhvajJsY081RHJ0NzZk?=
 =?utf-8?B?VzlTVmNLck1SYmlCTmoyUk55akFnWTRUa2YvUXJjYnJ6SVhsajdTc0I3ZDFa?=
 =?utf-8?B?SDZMUGN3dHhWc1hHTWtYQTQzVHJNY05iMGhodlF5TXIweDFrZz09?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c043d5eb-fb74-4b7f-95ea-08dbab306838
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2023 21:14:19.8139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r7DMQbSw9nUfSAQlruf6xZb+w/4FnySWuxjM4KDzmh/Tounxhld4oOetGY845mD1dEuvxgH1RYteMwRQtFrgpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6423
X-Proofpoint-GUID: vLwWE3ncg2YpKWQnFoby1ib0JNRJkf4H
X-Proofpoint-ORIG-GUID: vLwWE3ncg2YpKWQnFoby1ib0JNRJkf4H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-01_18,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 adultscore=0 mlxlogscore=514 impostorscore=0 bulkscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0 mlxscore=0
 phishscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2309010198
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBTZXAgMDEsIDIwMjMsIEFsYW4gU3Rlcm4gd3JvdGU6DQo+IE9uIEZyaSwgU2VwIDAx
LCAyMDIzIGF0IDAxOjI3OjM0QU0gKzAwMDAsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiA+IERv
ZXMgV2luZG93cyByZWFsbHkgd29yayB0aGlzIHdheT8gIERvZXMgaXQgbm90IHNlbmQgYSB0YXNr
IG1hbmFnZW1lbnQgDQo+ID4gPiByZXF1ZXN0PyAgVGhhdCB3b3VsZCBkZWZpbml0ZWx5IHNlZW0g
dG8gYmUgYWdhaW5zdCB0aGUgaW50ZW50IG9mIHRoZSANCj4gPiA+IHNwZWMsIGlmIG5vdCBhZ2Fp
bnN0IHRoZSBsZXR0ZXIuDQo+ID4gDQo+ID4gVW5mb3J0dW5hdGVseSB5ZXMsIEkgZG9uJ3Qgc2Vl
IGFueSBUYXNrIE1hbmFnZW1lbnQgcmVxdWVzdCBhYm9ydGluZyB0aGUNCj4gPiB0cmFuc2Zlci4N
Cj4gDQo+IElzIGl0IHBvc3NpYmxlIHRoYXQgdGhlIHBhY2tldHMgYXJlIHRoZXJlIGJ1dCB5b3Ug
ZG9uJ3Qgc2VlIHRoZW0gYmVjYXVzZSANCj4gb2YgdGhlIGZpbHRlcmluZyBvciBkYXRhIHByZXNl
bnRhdGlvbiBkb25lIGJ5IHRoZSBVU0IgYW5hbHl6ZXI/DQoNClRoZXJlJ3Mgbm8gVGFzayBNYW5h
Z2VtZW50IHRyYW5zZmVyLiBBbGwgdGhlIHBhY2tldHMgYXJlIGNhcHR1cmVkLCBidXQNCml0J3Mg
bm90IGVhc3kgdG8gc2hvdyBpbiBhIHNpbmdsZSBlbWFpbCBhcyBJIG5lZWQgdG8gbWFudWFsbHkg
ZXhwb3J0DQp3aGljaCB2aWV3IHRvIHNlZS4gU29tZSB2aWV3IGxldmVsIChzdWNoIGFzIFNDU0kp
IHdvdWxkIGdyb3VwIHRoZQ0KdHJhbnNmZXJzLCB3aGljaCBtYXkgbm90IHNob3cgdGhlIGVudGly
ZSBwaWN0dXJlLiBCdXQgaXQgaGVscHMgd2l0aCB0aGUNCmhpZ2ggbGV2ZWwgdmlldy4gSWYgdGhl
cmUncyBUYXNrIE1hbmFnZW1lbnQgY29tbWFuZCwgdGhlbiB5b3Ugd291bGQgc2VlDQppdCBmcm9t
IHRoZSBTQ1NJIGxldmVsLg0KDQo+IA0KPiA+IEhlcmUncyBhIHNuaXBwZXQgY2FwdHVyZWQgYXQg
dGhlIFNDU0kgbGV2ZWwgZnJvbSBTYW1zdW5nIFQ3IGRldmljZQ0KPiA+IHJlc3BvbnNlIHRvIENM
RUFSX0ZFQVRVUkUoaGFsdC1lcCkgdG8gSU4gZGF0YSBlbmRwb2ludCBmcm9tIGhvc3QNCj4gPiAo
V2luZG93cyAxMCkuIFNpbWlsYXIgYmVoYXZpb3IgaXMgb2JzZXJ2ZWQgZm9yIE9VVCBlbmRwb2lu
dC4NCj4gDQo+IEhtbW0uICBUaGUgU0NTSSBsZXZlbCBtYXkgbm90IHByb3ZpZGUgZW5vdWdoIGRl
dGFpbC4NCj4gDQoNCjxzbmlwPg0KDQo+IA0KPiBJcyBpcyBwb3NzaWJsZSB0byBzaG93IGFsbCB0
aGUgZGF0YSBwYWNrZXRzIChub3QgdGhlIHRva2VuIG9yIA0KPiBoYW5kc2hha2luZyBvbmVzKSBm
b3IgYm90aCB0aGUgY29tbWFuZCBhbmQgc3RhdHVzIGVuZHBvaW50cz8gIEknbSANCj4gcGFydGlj
dWxhcmx5IGludGVyZXN0ZWQgaW4gc2VlaW5nIHdoYXQgc29ydCBvZiBzdGF0dXMgbWVzc2FnZSB0
aGUgZGV2aWNlIA0KPiBzZW5kcyBmb3IgdGhlIGZhaWxlZCBjb21tYW5kLCBhbmQgd2hlcmUgaXQg
b2NjdXJzIGluIHJlbGF0aW9uIHRvIHRoZSANCj4gb3RoZXIgdHJhbnNmZXJzLg0KPiANCj4gSSB3
b3VsZG4ndCBtaW5kIHNlZWluZyBhIHN1bW1hcnkgb2YgdGhlIHBhY2tldHMgb24gdGhlIGRhdGEt
SU4gZW5kcG9pbnQgDQo+IGFzIHdlbGwuICBOb3QgYSBkZXRhaWxlZCB2aWV3IC0tIG11bHRpcGxl
IDUwMC1LQiB0cmFuc2ZlcnMgYXJlbid0IHZlcnkgDQo+IGludGVyZXN0aW5nIC0tIGJ1dCBqdXN0
IHRvIHNlZSB3aGF0IGhhcHBlbnMgaW4gdGhlIHZpY2luaXR5IG9mIHRoZSANCj4gdHJhbnNhY3Rp
b24gZXJyb3IuDQo+IA0KDQpBY3R1YWxseSwgc29tZXRoaW5nIGVsc2Ugd2FzIHByb2JhYmx5IGhh
cHBlbmVkIGhlcmUuDQoNClNvbWUgY29udGV4dDoNCiogQnVsayBPVVQgZW5kcCA0IGlzIGZvciBj
b21tYW5kIGVuZHBvaW50DQoqIEJ1bGsgSU4gZW5kcCAxIGlzIGZvciBkYXRhIGVuZHBvaW50DQoq
IEJ1bGsgSU4gZW5kcCAzIGlzIGZvciBzdGF0dXMgZW5kcG9pbnQNCg0KX19fX19fX3xfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXw0KVHJhbnNmZXIoMjYxKSBMZWZ0KCJMZWZ0IikgRzIoeDEpIEJ1bGsoT1VUKSBBRERS
KDMpIEVORFAoNCkgVUFTUCAgQ29tbWFuZCBJVSANCl9fX19fX198IFRhZygweDAwMDIpIExvZ2lj
YWwgVW5pdCBOdW1iZXIoMHggMDAwMCAwMDAwIDAwMDAgMDAwMCkgU0NTSSBDREIgDQpfX19fX19f
fCBSRUFEKDEwKSBUaW1lKDE4NC41MTAgdXMpIFRpbWUgU3RhbXAoMTAgLiAwMDUgNzkxIDEyOCkg
DQpfX19fX19ffF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fDQpUcmFuc2ZlcigyNjQpIExlZnQoIkxlZnQiKSBHMih4
MSkgQnVsayhJTikgQUREUigzKSBFTkRQKDEpIFN0cmVhbSBJRCgweDAwMDIpIA0KX19fX19fX3wg
VUFTUCAgRGF0YSBJTiBCeXRlcyBUcmFuc2ZlcnJlZCg1MjQyODgpIFRpbWUoOTQ1LjY1NCB1cykg
DQpfX19fX19ffCBUaW1lIFN0YW1wKDEwIC4gMDA1IDk3NSA2MzgpIA0KX19fX19fX3xfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXw0KVHJhbnNmZXIoMjY2KSBMZWZ0KCJMZWZ0IikgRzIoeDEpIEJ1bGsoSU4pIEFERFIo
MykgRU5EUCgzKSBTdHJlYW0gSUQoMHgwMDAyKSANCl9fX19fX198IFVBU1AgU2Vuc2UgSVUgIFRh
ZygweDAwMDIpIFNUQVRVUyhHT09EKSBUaW1lKCA0Ny4zNzAgdXMpIA0KX19fX19fX3wgVGltZSBT
dGFtcCgxMCAuIDAwNiA5MjEgMjkyKSANCl9fX19fX198X19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NClRyYW5zZmVy
KDI2NykgTGVmdCgiTGVmdCIpIEcyKHgxKSBCdWxrKE9VVCkgQUREUigzKSBFTkRQKDQpIFVBU1Ag
IENvbW1hbmQgSVUgDQpfX19fX19ffCBUYWcoMHgwMDAyKSBMb2dpY2FsIFVuaXQgTnVtYmVyKDB4
IDAwMDAgMDAwMCAwMDAwIDAwMDApIFNDU0kgQ0RCIA0KX19fX19fX3wgUkVBRCgxMCkgVGltZSgx
NjEuNDU0IHVzKSBUaW1lIFN0YW1wKDEwIC4gMDA2IDk2OCA2NjIpIA0KX19fX19fX3xfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXw0KVHJhbnNmZXIoMjcyKSBMZWZ0KCJMZWZ0IikgRzIoeDEpIEJ1bGsoSU4pIEFERFIo
MykgRU5EUCgxKSBTdHJlYW0gSUQoMHgwMDAyKSANCl9fX19fX198IFVBU1AgIERhdGEgSU4gQnl0
ZXMgVHJhbnNmZXJyZWQoMTQ2NDMyKSBUaW1lKCAgMi41MTkgbXMpIA0KX19fX19fX3wgVGltZSBT
dGFtcCgxMCAuIDAwNyAxMzAgMTE2KSANCl9fX19fX198X19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCg0KDQojIyBU
cmFuc2FjdGlvbiBlcnJvciBvY2N1cnMsIHRoZSB0cmFuc2ZlciBzdG9wcGVkIHNob3J0IGF0IDE0
NjQzMiBieXRlcw0KIyMgaW5zdGVhZCBvZiA1MTJLLg0KDQoNClRyYW5zZmVyKDI4OSkgTGVmdCgi
TGVmdCIpIEcyKHgxKSBDb250cm9sKFNFVCkgQUREUigzKSBFTkRQKDApIA0KX19fX19fX3wgYlJl
cXVlc3QoQ0xFQVJfRkVBVFVSRSkgd1ZhbHVlKEVORFBPSU5UX0hBTFQpIHdMZW5ndGgoMCkgDQpf
X19fX19ffCBUaW1lKDE2Ni4zMjIgdXMpIFRpbWUgU3RhbXAoMTAgLiAwMDkgNjQ5IDUxNikgDQpf
X19fX19ffF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fDQoNCg0KIyBIb3N0IGlzc3VlcyBDTEVBUl9GRUFUVVJFKGhh
bHRfZXApDQoNCg0KVHJhbnNmZXIoMjkxKSBMZWZ0KCJMZWZ0IikgRzIoeDEpIEJ1bGsoT1VUKSBB
RERSKDMpIEVORFAoNCkgVUFTUCAgQ29tbWFuZCBJVSANCl9fX19fX198IFRhZygweDAwMDIpIExv
Z2ljYWwgVW5pdCBOdW1iZXIoMHggMDAwMCAwMDAwIDAwMDAgMDAwMCkgU0NTSSBDREIgDQpfX19f
X19ffCBSRUFEKDEwKSBUaW1lKDE1OC44NDggdXMpIFRpbWUgU3RhbXAoMTAgLiAwMDkgODE1IDgz
OCkgDQpfX19fX19ffF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fDQoNCg0KIyBIb3N0IGNvbXBsZXRlbHkgZHJvcHBl
ZCB0aGUgU0NTSSBjb21tYW5kIHdpdGggdHJhbnNhY3Rpb24gZXJyb3IuIEl0DQojIGRvZXNuJ3Qg
cmVxdWVzdCBmb3IgdGhlIHN0YXR1cy4gU2luY2UgaXQncyBkcm9wcGVkLCB0YWcgMiBpcw0KIyBh
dmFpbGFibGUuIE5vdywgYSBuZXcgU0NTSSBjb21tYW5kIGNhbiB1c2UgVGFnIDIuDQoNCg0KVHJh
bnNmZXIoMjkyKSBMZWZ0KCJMZWZ0IikgRzIoeDEpIEJ1bGsoSU4pIEFERFIoMykgRU5EUCgzKSBT
dHJlYW0gSUQoMHgwMDAyKSANCl9fX19fX198IFVBU1AgUmVzcG9uc2UgSVUgIFRhZygweDAwMDIp
IFJFU1BPTlNFX0NPREUoT1ZFUkxBUFBFRCBUQUcpIA0KX19fX19fX3wgVGltZSgyMDcuMDA2IHVz
KSBUaW1lIFN0YW1wKDEwIC4gMDA5IDk3NCA2ODYpIA0KX19fX19fX3xfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0K
DQoNCiMgVGhpbmtpbmcgdGhhdCB0aGUgcHJldmlvdXMgVGFnIDIgY29tbWFuZCB3YXMgc3RpbGwg
YWN0aXZlIGFuZA0KIyByZXNwb25kZWQgd2l0aCBhbiBPVkVSTEFQUEVEIFRBRy4gVGhpcyBwcm9i
YWJseSBjYXVzZXMgdGhlIGdhZGdldCB0bw0KIyBjYW5jZWwgdGhlIHRyYW5zZmVyIGFuZCBkcm9w
IHRoZSBjb21tYW5kIHNvIGl0IGNhbiBiZSBpbiBzeW5jIGFnYWluLg0KDQoNClRyYW5zZmVyKDI5
NSkgTGVmdCgiTGVmdCIpIEcyKHgxKSBCdWxrKE9VVCkgQUREUigzKSBFTkRQKDQpIFVBU1AgIENv
bW1hbmQgSVUgDQpfX19fX19ffCBUYWcoMHgwMDAyKSBMb2dpY2FsIFVuaXQgTnVtYmVyKDB4IDAw
MDAgMDAwMCAwMDAwIDAwMDApIFNDU0kgQ0RCIA0KX19fX19fX3wgUkVBRCgxMCkgVGltZSg4ODQu
MjE4IG1zKSBUaW1lIFN0YW1wKDEwIC4gMDEwIDE4MSA2OTIpIA0KX19fX19fX3xfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXw0KVHJhbnNmZXIoMzEzKSBMZWZ0KCJMZWZ0IikgRzIoeDEpIEJ1bGsoSU4pIEFERFIoMykg
RU5EUCgxKSBTdHJlYW0gSUQoMHgwMDAyKSANCl9fX19fX198IFVBU1AgIERhdGEgSU4gQnl0ZXMg
VHJhbnNmZXJyZWQoNTI0Mjg4KSBUaW1lKDU1NC42NDggdXMpIA0KX19fX19fX3wgVGltZSBTdGFt
cCgxMCAuIDg5NCAzOTkgODg2KSANCl9fX19fX198X19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NClRyYW5zZmVyKDMx
NCkgTGVmdCgiTGVmdCIpIEcyKHgxKSBCdWxrKElOKSBBRERSKDMpIEVORFAoMykgU3RyZWFtIElE
KDB4MDAwMikgDQpfX19fX19ffCBVQVNQIFNlbnNlIElVICBUYWcoMHgwMDAyKSBTVEFUVVMoR09P
RCkgVGltZSgxMjcuNTE1IG1zKSANCl9fX19fX198IFRpbWUgU3RhbXAoMTAgLiA4OTQgOTU0IDUz
NCkgDQpfX19fX19ffF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fDQpUcmFuc2ZlcigzMTUpIExlZnQoIkxlZnQiKSBH
Mih4MSkgQnVsayhPVVQpIEFERFIoMykgRU5EUCg0KSBVQVNQICBDb21tYW5kIElVIA0KX19fX19f
X3wgVGFnKDB4MDAwMikgTG9naWNhbCBVbml0IE51bWJlcigweCAwMDAwIDAwMDAgMDAwMCAwMDAw
KSBTQ1NJIENEQiANCl9fX19fX198IFJFQUQoMTApIFRpbWUoMjc4Ljc3MCB1cykgVGltZSBTdGFt
cCgxMSAuIDAyMiA0NjkgMTA0KSANCl9fX19fX198X19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NClRyYW5zZmVyKDMx
NikgTGVmdCgiTGVmdCIpIEcyKHgxKSBCdWxrKElOKSBBRERSKDMpIEVORFAoMSkgU3RyZWFtIElE
KDB4MDAwMikgDQpfX19fX19ffCBVQVNQICBEYXRhIElOIEJ5dGVzIFRyYW5zZmVycmVkKDUyNDI4
OCkgVGltZSg1NTQuMjM2IHVzKSANCl9fX19fX198IFRpbWUgU3RhbXAoMTEgLiAwMjIgNzQ3IDg3
NCkgDQpfX19fX19ffF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fDQpUcmFuc2ZlcigzMTcpIExlZnQoIkxlZnQiKSBH
Mih4MSkgQnVsayhJTikgQUREUigzKSBFTkRQKDMpIFN0cmVhbSBJRCgweDAwMDIpIA0KX19fX19f
X3wgVUFTUCBTZW5zZSBJVSAgVGFnKDB4MDAwMikgU1RBVFVTKEdPT0QpIFRpbWUoIDQ5LjQwNiB1
cykgDQpfX19fX19ffCBUaW1lIFN0YW1wKDExIC4gMDIzIDMwMiAxMTApIA0KX19fX19fX3xfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXw0KDQoNClNvLCBmb3IgdGhpcyBzY2VuYXJpbywgdGhlIGhvc3Qgd2FzIHByb2Jh
Ymx5IHN0YXkgaW4gc3luYyB3aXRoIHRoZQ0KZGV2aWNlIGR1ZSB0byB0aGUgb3ZlcmxhcCBjb21t
YW5kIHRhZyBpZCBjYW5jZWxpbmcgdGhlIHRyYW5zZmVyLiBJJ20gbm90DQpzdXJlIGlmIHRoaXMg
aXMgdGhlIGludGVudCBvZiB0aGUgV2luZG93cyBVQVNQIGNsYXNzIGRyaXZlciwgd2hpY2ggc2Vl
bXMNCmxpa2UgYSBub24tY29udmVudGlvbmFsIHdheSBvZiBzeW5jaHJvbml6YXRpb24uIFBlcmhh
cHMgaXQgd2FzIGRvbmUNCmJlY2F1c2Ugc29tZSBkZXZpY2VzIG1heSBub3Qgc3VwcG9ydCBUQVNL
X01BTkFHRU1FTlQoQWJvcnRfdGFzayk/DQoNClJlZ2FyZGxlc3MsIGlmIHRoZSBob3N0IHJlc2V0
cyB0aGUgZW5kcG9pbnQsIHRoZSB0cmFuc2ZlciBtdXN0IGJlDQpjYW5jZWxlZCBvdGhlcndpc2Ug
d2UgcmlzayBkYXRhIGNvcnJ1cHRpb24uDQoNCkFsc28gd2hlbmV2ZXIgdGhlcmUncyBhIE9WRVJM
QVBQRUQgdGFnIGVycm9yLCBXaW5kb3dzIGhvc3QgdGFrZXMgYSBsb25nDQp0aW1lICh+MSBzZWMp
IHRvIHNlbmQgYSBuZXcgY29tbWFuZCAoY2hlY2sgZGVsdGEgdGltZSBvZiBUcmFuc2ZlciAyOTUN
CmFuZCAzMTMpLiBJZiB0aGUgZ2FkZ2V0IGRyaXZlciBjYW4gYmFzZSBvZmYgb2YgdGhlDQpDTEVB
Ul9GRUFUVVJFKGhhbHRfZXApLCB0aGlzIGltcHJvdmVzIHBlcmZvcm1hbmNlLg0KDQpCUiwNClRo
aW5o
