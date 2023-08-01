Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09A276A5C1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 02:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbjHAAuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 20:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjHAAty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 20:49:54 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC821A3;
        Mon, 31 Jul 2023 17:49:53 -0700 (PDT)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VJpvic021541;
        Mon, 31 Jul 2023 17:49:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=p1KuR7aj02dATylguMaCqWN11gV3zFVdJrEV7vIsJeg=;
 b=YJI3H8kKZ8GQwwm559iRSDNwqBjzvuMZ1eqV0crKEagkHFK9gnJ3VdShjMhM1omxkshJ
 iPnUsbPTpg5YgaQz9lGX4fnf6odOtt4dkbVuvQyIyOuaSoZgJt3GnyKaQz7ysvCVjcCY
 oBp9FdD0qok9dZ1okD5hXbGAqCLfKgqwy+e/MZdSB3hlX/C7EfFe3iarbnCJzp2rneyj
 4cVZdepNAI3HO1ans4fBLS4Y3RmeSc0EhpjP0lpE6GxqXnTWIFVVd+wBrsJjsz/43nKg
 JQFF8Y1QenFrEvUiYVRPYR1HN8LNpmJHWWXVAdryEA+4W+n5TAWNnk7IwTTgC/auKrIT OQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3s51sps2rg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 17:49:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1690850974; bh=p1KuR7aj02dATylguMaCqWN11gV3zFVdJrEV7vIsJeg=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=IRutFgeZoEZsykXy1tXhnordQ1n++NA2Ld069APHfAZx/JTIjyEMDPBiSq435L/e6
         1rzihUtAS9/O+wTp+q+6sPW2Kghhl2NMszRL74Ldcv+4aqdyxjKmRjVRAAtHLfwEUX
         ClP47GFM/RSXPEaZHifSp+vNF+2HERYCFqccaFN9l45tYERE9nZu8bjMcT2bOtqyoh
         DHAjNSM6KrknU8aeT7Wg4yzSa/w0xU5UhWM5p6s0rUlQS2a9BWpfoBPqkMEje5/AGk
         fpkxbCHmNC2hpvIumPQPEBOTwymxc1X5d36RwIDtp6tOgyM2QReaDFc7fXmNHyU0nR
         YP1gg0rPlC+Sg==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 55A2E4013C;
        Tue,  1 Aug 2023 00:49:31 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 21827A0077;
        Tue,  1 Aug 2023 00:49:29 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=gkZDN5W7;
        dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 50200401CB;
        Tue,  1 Aug 2023 00:49:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AEHYToil2gINu3GzSUK6Nh+7gP26s+i4WFHtfNfyRIaWG9AlPBxpb2vvvqoPVcpYHb7w6zY4/uTeIOBuHe6DJ9I4qbMleAwStQP+u8RFYBOAOfsEFzHUdDgB5Y1F46Z2C+dYKirf2Oiqp9H8I6ckbtyWJbCbFgoeZl784X1PgDIB3G+fkYbaprLyDPLJ9mi3iKc1myMspyhlTZzxq5XM/CvidG0MQbsq3ikU1+mQFTYBvXjEnCgnb/Zc2/Gx/7xH9M3GDwpHVa8SkI/IOR/2jFnOoR66ZJjdnAofjRxNS8PmyAL2ojf6eINQTQ7By04MpyR/jNAJOGTTegfzqNz9Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p1KuR7aj02dATylguMaCqWN11gV3zFVdJrEV7vIsJeg=;
 b=ddds+LrfOaqUnTU7AEn+COUJ5HPrE4ppL6KRt7OAPQ+FcNxRn1wd2ohwPEu+/JSJGnLG8XRtXfH/yGHxM78VxLgjYg09OXhupMlZzu5XcXErHkpjLXI/8LD+X99jvpEphvYPJGTjYOshHwCAGbIiBPE/HOweYvguCGPCFEZQE4Q2PAwYqKf39mrL2zZnq0meRJIX2cktWUwJjQvI04HiZulCOkw7s/9pYgk0JuGGW4oRuWSaB3eMRztCJmyHU7FGy4FJys1d7gZAP9/QJqWqmr4QQsipnL/UWJ9xsluyCS3b/Vd0UCWZfBpuaStk4oUX2Lqo4+ZEZzMdYXex2/gbWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p1KuR7aj02dATylguMaCqWN11gV3zFVdJrEV7vIsJeg=;
 b=gkZDN5W7/vfmDu/MckW48SqMWUSZsahEg7nmBXxpCBg+Ggt8CoRJkAkM9QhHQtQMCulE9OLYmaoSUMHkQ6rFalP4537a/vf0AlQ+MrZ9si/sVYm4/U4InOoTzsawb3wTGCrTKgWyiUb2T6eitPb/b43odIwAr4nwpYepx/UWRrw=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by SA3PR12MB7904.namprd12.prod.outlook.com (2603:10b6:806:320::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Tue, 1 Aug
 2023 00:49:24 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::138d:ed63:a424:1f33]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::138d:ed63:a424:1f33%5]) with mapi id 15.20.6631.042; Tue, 1 Aug 2023
 00:49:24 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Surong Pang <surong.pang@unisoc.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Orson.Zhai@unisoc.com" <Orson.Zhai@unisoc.com>,
        "Chunyan.Zhang@unisoc.com" <Chunyan.Zhang@unisoc.com>,
        "Zhiyong.liu@unisoc.com" <Zhiyong.liu@unisoc.com>,
        "Surong.Pang@gmail.com" <Surong.Pang@gmail.com>
Subject: Re: [PATCH] usb: dwc3: gadget: Let pm runtime get/put paired
Thread-Topic: [PATCH] usb: dwc3: gadget: Let pm runtime get/put paired
Thread-Index: AQHZw1eMAo0F1UevnEeZ1ZzK9omr8q/UnVeA
Date:   Tue, 1 Aug 2023 00:49:24 +0000
Message-ID: <20230801004923.mcmkgoliy2qlwtah@synopsys.com>
References: <20230731023323.16046-1-surong.pang@unisoc.com>
In-Reply-To: <20230731023323.16046-1-surong.pang@unisoc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|SA3PR12MB7904:EE_
x-ms-office365-filtering-correlation-id: 4a4ac9b9-f285-4915-5bbd-08db922926e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YA21h8LMTBztSP6SZQcPv3fFtV4Xy+q9WlOR50c2e56lxnHK7CqqfXzOLLg51rFUvmyfnwkUVy8gsUmrpStYHNIVhpC0QtGKmWlFSGXerkjSIrycwLbaDmstP1FjQ4eBa0+TU3Wk6FqdBA2aQVt0W/4wQd9HRs4z8hS7Ugvo0YVYyLH3hl1ohYxfwwVUjVwYOXUqts3fPl9uI7xOkJQTMCXNXV9RdlccmQzMWqUi9pqLsENEkNGZDwe/e227XsYlnCe1oMCaw8+l39OfMtLos3GEcmIdC5uWVEMplwgLTQ6c79BKPP8smx+QiAdITT/GtjqYqPHZ/AoFQTctGkalW4UoFY3jvyBfpJmP1IEa1j6OI6hQ/lDvdaZge7nznp8Ygww23hBhy51pjz8Y3PZqntD13lOpEgndamnP5x0/pqxoQgdMm1PgHKoIE7rlLDmiwE6neJ0L595KqZ5dTwMjJGqdxVPlAjpWKSCZlgJje5q1haF7XAihQalohrhYkTUdhEemSs1bPrOD1KNlU9ReHdG2kHv3YXHcb7wuJqFGxQcZcZxdQldYpayqeEJsX0gIwbZ5BiTZswFtOTKPIQntgoyiUHcu+FtIZGNZJGtDjKZEkJI1KJZY8/2GrzVbvuBU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199021)(6512007)(6486002)(36756003)(2616005)(6506007)(26005)(1076003)(186003)(76116006)(66946007)(66556008)(54906003)(122000001)(38070700005)(41300700001)(38100700002)(86362001)(66476007)(316002)(5660300002)(66446008)(6916009)(4326008)(8676002)(8936002)(64756008)(2906002)(71200400001)(478600001)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?djVDcUhVbXJGeUhnY2xIckhiM1FrRGV4bnpQalJtR2FDT0p3QlpTTjJ3azBw?=
 =?utf-8?B?QkFKYjd1RTczTFYwcm5LVVlMejNBQmEvd2k0alJQdDlYWkhCVzJiRWxFRHJG?=
 =?utf-8?B?NUg2UDcwNmpWR1doMTBsY1lhNU9kdTJnUnpxS2tBS1U0RXllaXJsU1UxemQ1?=
 =?utf-8?B?dkk0ajJWOHA4aFBsZlNyT094SkRpVTRJbDZwYkNXODlFSzVpamtZVWttR05K?=
 =?utf-8?B?emhtU1ZpS1FQUldZOE1qU0hxWTV1WEwvaVpaeWJOdzVsdFNKSmNMV1hDNVlD?=
 =?utf-8?B?bDNhTjhWTkhET24rZkYzb1krdG9ZVGhBNmhJZWRRM2RyN0JsbkQyRUlJaU9E?=
 =?utf-8?B?MHk4SEtTWWlvZWp0WGRUSm9XbTVjdEl2TGk3b2dhd083T3UvU3h0VWZZcWlC?=
 =?utf-8?B?NFR4NlNJM05zTjNDUEVURVNyb1NJc1NVNXhYaWIwOUNjc3ZCclV0bTRiM0Rn?=
 =?utf-8?B?V0pMd0lwTzJtMjdWTVV6VXBJZTg0NkU4MzJSUFl4R2l3K0NyUmU4UEhudnRZ?=
 =?utf-8?B?alp6TEQ0KzBRK2I3YnhRaWoxVU5MR0x4TVRWZEI0RVpsLzI2eXFPNzZlL3dz?=
 =?utf-8?B?VXBMYk1BUnVNM3lMcm5hcjV1L1JUS3JlNFVJeEIxdGxrdFBWb2ZSNG5hM0Nr?=
 =?utf-8?B?aWR2TnpoQVNxUkZFRWh0WW1ZWkIrclJRdkN4amNjNkt6TmdOY3FVdkw1cWUy?=
 =?utf-8?B?bm11c21nRWtoV3g2NEcxRVB3M1lHU0s4bFkyTWZiOWp5QUg4YnpxbVN5bHJN?=
 =?utf-8?B?Q2llaEpKOWRoRlgydE1Xajd1ZVQ5ODZVK0E0V2hTMXZocWtBbjVwam9kbVhD?=
 =?utf-8?B?Q1p3YUswVnljNDJzbWJ5dXN4Y1U1K0ZweEdxaW8vb2V5SGlTcmp2K1RuaHNa?=
 =?utf-8?B?SVAwTDd5M2Z4WU5EV3BWVGkrbUJwcS93K1FKMlNCb01tY2dRa0NJL3F2SnFO?=
 =?utf-8?B?TVNJZVpJNzg4QVpmbk1MQ1B6QXl0ZDlhTzlGUGthR2owVWR3T0RNQk9OR1lw?=
 =?utf-8?B?MHE0NFNQMXhHS0hGRFM3blIwc1hFWFlTVFE4T3ZHSlViWkp6NVpxa1loSTlS?=
 =?utf-8?B?OXZjQU5HbzdSTHNHY1NCRGFwQTVsNXdEdG1WL0c1a252cDlwTFBoT2FrYjl3?=
 =?utf-8?B?VHQ5dWxVaTNWRXlqSWFjNWVjS3VEeUM5enJBTDI4UVY4eDd0OUowaDVuMStk?=
 =?utf-8?B?eUZVV1c1RGEvaUxpbFBNenpBL212SWVpVWZXZExyeXBVeVNHbGNMa3h3dE9G?=
 =?utf-8?B?RjlJVDlPRlVyT0VsSlc5ZWlxai9tdnp6Tm1KUjRaVFpISlNkQjYrQlBoMDZh?=
 =?utf-8?B?V25uY1FaK2xPb0U4bFY3cVhwdm9RQnAreStBVlZQMVlFRmt2eGw5SkpyR3ZS?=
 =?utf-8?B?Qm1BU0VlaXpWZndXRmkyQ1Vxcmw2Y2tDQzZyNjIwaGZZbldLTTAyR3ZQZ3Ez?=
 =?utf-8?B?TU1FZk9zQTVucWJLOTJNNUwzeHg5MUtkbDZTY0o4R2k1VE5XcEdCRy9tdEU0?=
 =?utf-8?B?ZTd4bXBkUkN1RWw1dzRVMWRGL2hMVlZIRERpa2o0ZDBJTit2cDk4b0doNzRx?=
 =?utf-8?B?aTJ4L0tYVUV1eWV0clR6ZFlRWHYwZm1oM21YeWR4TFlmOWFXbEJHTm40TkNt?=
 =?utf-8?B?dUxKb1BnWWgyd1lZSmwzWE9Qa20yRkwycUg4cjFrT21GYzJqd2xZc051dUw3?=
 =?utf-8?B?NGtMTXZnbzFyNG5tUkZOdjF2Zzg1UElBVTczVlljOUY5MHlJZEFmVThsUXRH?=
 =?utf-8?B?L2N5MGtoaC80d1RDaWc5NTdNdmdQQ1U1ZlVGSkVKSnQxdExjSlFuRDlqMzhC?=
 =?utf-8?B?c2kxcldMTGxiYlpLd2IwSldraXFMQ1Z3dmpRblJpQk1xU1NDbVl0MkdoYXY2?=
 =?utf-8?B?SUdZME83ZXNrNTBOWlNpeGhYSW1DNHpjOWVhTm9IRjI3VEhIU3BoWk5VSTY2?=
 =?utf-8?B?UHlPdk8yWDFPV2R6M3Qvd3BvNmRSYU56VDdIV2VDYjRveU5Pa0d2ZURncVBC?=
 =?utf-8?B?YW9aUXdFY2FLSGdHNGNISSs3UHhYZnFoSHNnVGRHN3RFUEdUT2tvN25xazgv?=
 =?utf-8?B?cjBGZUpqb2kyTU9rdzJPVVM1MEV0U1pkbHA0R2JCM08vODF2dW00VGFWM3VD?=
 =?utf-8?B?MGlBczZiZFM0V1RzSUt4ZzRPbUdLT3ZsRm0wcjdENXJYdkJ6Zm9YTlg3NGZj?=
 =?utf-8?B?bWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3159B72EA745C04CACC3C87F5F6C44AC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ZVdOMjI4b3BRVW4rSWZkMC9HMzd0cFUvYllkeEw3V2JzSWVtWlVmY2ZVcFI3?=
 =?utf-8?B?MitXSnNYcjkvRHBkSXVqdm50WjFXSzR5SWIxcWZ6dkRnR1RjWUNaaGdnS0dh?=
 =?utf-8?B?R0JsTncwOWdYVGE4RXoxclhQbG9rSDcrUS90K0d6ZWFNMTBhNzFTU0tlVW5P?=
 =?utf-8?B?R1drbVlUNjgyMEVlTythNGJjeE5tS2tLRWd3TkVlMmhYS0I5NTJYRFdoTW5U?=
 =?utf-8?B?SU1icnh6R0U5M1JraUJ0emZxS05JY3c2ckVkcWFvQ2diUHgwM2E5ZWhZTHht?=
 =?utf-8?B?RnBSTExJSzE0UjhDcTFTdnFpY1RiMHR4TXJZd2xWQlBreU4yV2xxdHFWeXMz?=
 =?utf-8?B?dUV4aG4zOEJrNHU1NEJucFFmeWV4NTJPQWd2U0hFT3cxbVZRcnQwc0wzWWdB?=
 =?utf-8?B?TWZvRXlGa2hRTE45KzNsWWdOWHNodmV5MEo4dzF4Y2d0MFlGY0xNTldJZSsy?=
 =?utf-8?B?MGlHS01yb2ovejNzeng0bzRralMvdzlpTWkwTzNnclpkZmQ1UVFFNE1WOS9J?=
 =?utf-8?B?NlBFQmhCTmJNTzhnVzVkWXVKWUcyN0JRR2xScS9lVjN0ZW44WitSNjV6dklv?=
 =?utf-8?B?ZTVUVk5oMzN6ZXRlSnVHQmc3alpFWjBuWHpMZTFuek5JdUo3V0FsS0hkU09U?=
 =?utf-8?B?djZTcU5OS3lUbzgxenJ5Q1JqbVR4OGMwVUp1U0JRanJmN0tiU2VXU1YxQ09l?=
 =?utf-8?B?UW1qaVFGLzZadmFwNkVSU3hueGdVajY0S25GTHZReFdqTlVjOW96d0ZkcVpL?=
 =?utf-8?B?VVgzTi9Sb0hqeUx0ckI5NHBsZjdUWjdMb1lja1NvYmQ2a1RXVmZJeWl4azQ3?=
 =?utf-8?B?dTFMK1J0MEhHbW55dFJqbVVLcVlyMm1BeTFzMjFKVDExS25IQUJxbUYxK3Jv?=
 =?utf-8?B?OXYxWm1ML2h2d1JmVEdMYmVoenpGdGNVTEttbE1HMXBWQWFwNE1PUTZJT3hr?=
 =?utf-8?B?ZWQ1Nm1DWng0Q0ZWRDdRSFQwWXE4M1lBdFVJTmtGdzZxZkZpbmVUTk9BNGpo?=
 =?utf-8?B?QU81ZlFKcTBRMU5SSUlCSzh1ZFV5UWdzOWVlV1A3Z0NwYmIxdFJ4SURrNllh?=
 =?utf-8?B?V09SZGtlUjN3b2tiK0tWbVhxTGI3MnhOMXVBd3BjWkpBUWtqMnRXYkxUQXh4?=
 =?utf-8?B?ZWkwTXp6bDRkOVVkbE5BbHM2VUtFakgrMTV1eTJ6a2pLckNNNGVrWmZpVUV2?=
 =?utf-8?B?Zld5dUxOZ1RyejlTamRaa2RjRndDVGs2bXFBa0d4N3J2cE9RTkxtbkd6RWxS?=
 =?utf-8?B?Yy9yZCtxZFJ2QWZKUmpsSVB5K1AyUlVhVGNzYlQ4NjlXSlFzQT09?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a4ac9b9-f285-4915-5bbd-08db922926e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2023 00:49:24.6583
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KnqyL8e4iJN2FSK8L05FLMbn2Vrp3mUlhT8ohMsGXhr5IoYKdNfqXf3kebi3AhpkztcZXEuqCzAEyDzK/KIfKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7904
X-Proofpoint-ORIG-GUID: POr7_D4Oufy9Id4jaepnMxCCAXYhcR-v
X-Proofpoint-GUID: POr7_D4Oufy9Id4jaepnMxCCAXYhcR-v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_18,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 phishscore=0 clxscore=1011 spamscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 mlxlogscore=751 malwarescore=0 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308010005
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk9uIE1vbiwgSnVsIDMxLCAyMDIzLCBTdXJvbmcgUGFuZyB3cm90ZToNCj4gUG1fcnVu
dGltZV9nZXQgaXMgY2FsbGVkIHdoZW4gc2V0dGluZyBwZW5kaW5nX2V2ZW50cyB0byB0cnVlLg0K
PiBQbV9ydW50aW1lX3B1dCBpcyBuZWVkZWQgZm9yIHBhaXJpbmcgd2l0aCBwbV9ydW50aW1lX2dl
dC4NCj4gDQo+IEZpeGVzOiBmYzhiYjkxYmM4M2VmICgidXNiOiBkd2MzOiBpbXBsZW1lbnQgcnVu
dGltZSBQTSIpDQoNClBsZWFzZSBmaXggeW91ciBGaXhlcyB0YWcuIFJ1biBjaGVja3BhdGNoLnBs
IGJlZm9yZSBzdWJtaXQuDQoNClRoYW5rcywNClRoaW5oDQoNCj4gU2lnbmVkLW9mZi1ieTogU3Vy
b25nIFBhbmcgPHN1cm9uZy5wYW5nQHVuaXNvYy5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy91c2Iv
ZHdjMy9nYWRnZXQuYyB8IDEgKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyBiL2RyaXZlcnMvdXNi
L2R3YzMvZ2FkZ2V0LmMNCj4gaW5kZXggNWZkMDY3MTUxZmJmLi45YzgzNWM1Zjk5MjggMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gKysrIGIvZHJpdmVycy91c2Iv
ZHdjMy9nYWRnZXQuYw0KPiBAQCAtNDcyMCw1ICs0NzIwLDYgQEAgdm9pZCBkd2MzX2dhZGdldF9w
cm9jZXNzX3BlbmRpbmdfZXZlbnRzKHN0cnVjdCBkd2MzICpkd2MpDQo+ICAJCWR3YzNfaW50ZXJy
dXB0KGR3Yy0+aXJxX2dhZGdldCwgZHdjLT5ldl9idWYpOw0KPiAgCQlkd2MtPnBlbmRpbmdfZXZl
bnRzID0gZmFsc2U7DQo+ICAJCWVuYWJsZV9pcnEoZHdjLT5pcnFfZ2FkZ2V0KTsNCj4gKwkJcG1f
cnVudGltZV9wdXQoZHdjLT5kZXYpOw0KPiAgCX0NCj4gIH0NCj4gLS0gDQo+IDIuMTcuMQ0KPiA=
