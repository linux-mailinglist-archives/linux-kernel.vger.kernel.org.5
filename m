Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9F1804432
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 02:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343833AbjLEBnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 20:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjLEBnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 20:43:40 -0500
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C743EB4;
        Mon,  4 Dec 2023 17:43:46 -0800 (PST)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4JAVGm005594;
        Mon, 4 Dec 2023 17:43:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=FEgPWsPvfusLMFTfTUrfxqdM515bjQgRkvZgZPulAvM=;
 b=EGgluzw4A6DVJCPd+2RMylP8ksAsLTwBGW8/Gw8Af+wTyFNNq7e/FZfaPyt6vqOReAqo
 GE4B/dS1jl1V5b1j2ByKPwy17DgaJfGj8aU2TlP8QxNowhj55fiQJwQcwV+PdIoBX0h9
 9a0//1YFXLu7TzMhKm/xGL4B1wqkNwAGw7AXnm3N7BJTHj65KvTEIqGRkcKOZyqsu+CP
 568JrUrzMjkAVgcy8jwCpSd7U1XFxcJ2Z79aGrMOSWRAotiq9fPYbB/JLsxMGFmDWkUn
 s3eRLEyuomxSf/P3dIydr/D8wZBdWW8iviFF1svg4bPTII5Jp55BJPUqgPCbZl3Slw37 ZQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3ur43m9g3s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Dec 2023 17:43:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1701740623; bh=FEgPWsPvfusLMFTfTUrfxqdM515bjQgRkvZgZPulAvM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=fWmMHW6vyl/LjAfz4oq4iPd3Rvrb8s+KsH6Uw5GgzEvLxa2JN4s+fUuIwOr+WR92Q
         R4t5D7ozlbU0SlbwuCFFVxLjCoQ7akPVxxSCZzINA16+48OJG6nD935Fl6l04hh2X0
         KOWRaM/mTbga3AiEIhUve5agFrORJfoNw208FKXYb4P0xb3NMFnpISuTRJv+1hEymR
         XSMHt4rqnytkF7hya6u5uBmD5l55/0zqzQk2RmqG1tJE2tDUOa5fjyAGA5tozi4dSY
         PZKgIYrrAqkUQZGAQKd4NEUf8rmKUiZKbbAuPUQ3mrcbmo7ZlHtsdlodmZKAQbUIL9
         nDE2NwS9UJwAQ==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id F230E40362;
        Tue,  5 Dec 2023 01:43:42 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 98B58A0071;
        Tue,  5 Dec 2023 01:43:42 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=BhI+PcKM;
        dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id B9DAF40408;
        Tue,  5 Dec 2023 01:43:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QPGTCYqhr85msj6l735MS0WhJjsRYcgYoqB/dsmM8zqHA+QRW7FujQDThqFGexqHozDMX/VXUSGLxxdt1SeAWQuzX1y2tEB2g0VAmljJkCMpX7lcBlTEnwLP0HmwquIUGiTjCcZTOcs19OTcKlfiwbR81K2xSR0q3eqABvD6JWMzOIGuhHx7+vzdTuaNGxW8LHfi7WWDf2GXAGbq2nXKaej1mCRNtX32vilJb/kj5wjHccNhWyH5ABTILsj4K5o6DCgUGpiokEGcdyVMg2r0Do4YQFtHhmDm4YKKJ3kv4HZlCvs4RTPS/JP8rj6gZPiBhE8ZDuJclU2D82XcVDIaHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FEgPWsPvfusLMFTfTUrfxqdM515bjQgRkvZgZPulAvM=;
 b=h+xzf3qrTa9vCgj9UdH6IzNKEVuAr1BblGx84Diw5GozltmTabUMZtMS8Do7U2MeELS1z8jJFH1NQocv0zPjuq0iQoMF00l6z/rupSM/FqpTpWqbDQw5DcjIiuz99D2lckhFe0aHxrkzhjJ5jCniCcvW0DMKl5UblrpN+J+9YDpD4vM0m8TdzoAEKVUXtAaAf1r9MWu/wGbhx8F5BqaJjo3zVdEhLcSwisP70enqttRoTblynscREWURupPtSDuTVgmCcQTgK0shQixVWVO49WK9HCspMMM5ihE85KsAjYcerwlwhO0YtrNw4IXmllQFGHKW6A1AqHooC9RRgwoYbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FEgPWsPvfusLMFTfTUrfxqdM515bjQgRkvZgZPulAvM=;
 b=BhI+PcKMRf/Ga6/PdmVBarG721UgcPmd33GK91HLrALiWj2qoeL6ZzVwuBWYpx7KvX6d9QIlu8WL0HYrgrMPSybkmyuCKCB5qJRpWMaFs0LI3yLGKAnWhA1f+lDv04N9W7LYvSGwLDmiLh3rci2V6AXNJ12rin5czgApTQSErOI=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by IA1PR12MB6436.namprd12.prod.outlook.com (2603:10b6:208:3ac::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Tue, 5 Dec
 2023 01:43:38 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::4e1a:5b9b:db11:b40e]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::4e1a:5b9b:db11:b40e%5]) with mapi id 15.20.7046.033; Tue, 5 Dec 2023
 01:43:38 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Uttkarsh Aggarwal <quic_uaggarwa@quicinc.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [RFC] usb: dwc: ep0: Use -ESHUTDOWN in dwc3_ep0_stall_restart
Thread-Topic: [RFC] usb: dwc: ep0: Use -ESHUTDOWN in dwc3_ep0_stall_restart
Thread-Index: AQHaHSPyM2h1qWO1FkWPKGKKX0bzCrCZ/psA
Date:   Tue, 5 Dec 2023 01:43:37 +0000
Message-ID: <20231205014328.j2xpojjqbeafsfii@synopsys.com>
References: <20231122091127.3636-1-quic_uaggarwa@quicinc.com>
In-Reply-To: <20231122091127.3636-1-quic_uaggarwa@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|IA1PR12MB6436:EE_
x-ms-office365-filtering-correlation-id: f94a7d48-851b-41df-ec77-08dbf5339a15
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0iq3kVM+S/iVHxQrc5GFr/gIQgD13hy4QVxAOzaa46HUDf2THZxji9H/BDtJg6VW2W9NLjrgaq3z408P7ZGjHispsE5W0GYDPNm04lFRwD+ZJr61ehjZobPYStDPPYb7YFLxSrqdtn+x+EYLAGl51iyUTDDaxoc+qc1fHg3xotUxqiyoJgSfkeFZ4vK9wCTvdlIOiA+0cZBI4BXAuCi1ArGZ2ID7XItMKaQ+8OIME9VvVEDT8lC7EcYXgR7yRhD7s49e7Q7P/KJ7d77hawVxHK5FaU7FuI1dZtiwq4yEoTTXQoPXsu2cWc3evuPl6XAM/qL3+OP9KEBW/3rN4Fv+LDN6JS269vU4k+I+ecPBZROH9onfeG2epGRaTRBvB35QRr9Rpt5wBnIvnjbAkeEKOWVTKtCfs1Lt2I1NJbXyDIFw11pDnTvQxIUdm7cyZh2aVq/oNJMD9AyuUsoDkd241UEpzMofCo6Mq7DdxEhVv19lUx0rWLx6QuUALKEJl0jgrDqTUBJXwtKjuiskop8X3wiDfBegusy3mpJ0Z+IR0M/6q5FjVc6VT8+Q5ulurhkJSnchxc/uxsHUZOzYXrwOwTeToWb6m8+DkML9txFxV+vtMQMKz4sjlAzk/LohZyBO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(376002)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(6916009)(64756008)(54906003)(316002)(8936002)(86362001)(8676002)(66476007)(4326008)(66446008)(66556008)(478600001)(76116006)(91956017)(6486002)(66946007)(41300700001)(36756003)(2906002)(5660300002)(38070700009)(122000001)(26005)(2616005)(1076003)(6506007)(6512007)(83380400001)(71200400001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SDVoY2ErZmZqVHFOdFRPRkUvejh6QzZlc2ZoMzBWMmJsd080UGlSM1BUSmxZ?=
 =?utf-8?B?ZmdLbDBRN3NCaFBKa0s2dzRQbVZGUTErTUJZRVJPNW95bU90eVVGTFd0WFJ0?=
 =?utf-8?B?bU5jZkNxY1ZDdzVMRGh6cVhWdlpkN1dpVnJadi9BWXRvZStBc3l2NS9VVVBl?=
 =?utf-8?B?MzRnZTVqUmhHMVAzRHNGdDJLd0hSWGc0MmhxUkRxcm52MTZyMHJyVUxYMEww?=
 =?utf-8?B?YThoVHV3YkZMS3Y4VCtUMnJRcEU1b3pja1krTFZNSlh1eXhoME50QXdhVEFh?=
 =?utf-8?B?dWRLUm4rS2l3Zmc1MThLVXRMS0VlV0xlYnRTdFBHQ2QySFcwREFYcjVyTWgz?=
 =?utf-8?B?UXo2bSszSHgxdXR5ZFRZWUpSM0tTMExrVXNnMGFVMHNmV3k3bys5WkVsVUVU?=
 =?utf-8?B?QXU4ak5zb2oyWUowMUpJYWJvWUVjRG91OE1idll5a0JqaWx6UVFWdXcyYXI0?=
 =?utf-8?B?dG1ZWkRyMjR4WWpnNzBCdklsaXJEd3hUQ1pBUU9LSFc2U0FlbEplYlF2YlNu?=
 =?utf-8?B?Vm9nNHI4VXFBOUt1d3I5RUdYQVppbU5SdVRrOHVkMGVTNVpVUFJuZGRrM01L?=
 =?utf-8?B?bFNMTW5WODRHQ2dXcnBoeW9HRUhpdDlEalNuaWU5Y0pmOStrckNpbWlFSXFa?=
 =?utf-8?B?WnhsM00zblltYStBYThTYkQ0L2NoUmFrU2JCMFpESkM5S1FBZ2hqdVkwMTdi?=
 =?utf-8?B?SnpZR29IV0FremhkcDdPMjF5Y0NvdXpiUXEzN1pCekdFYkpaRXVDaUpjU2t2?=
 =?utf-8?B?RzU0b3ZycGV1alJFQnQxUXRMbDRzcEhKclg4aVQvNHQzRDRRSElmNXJsTmJ6?=
 =?utf-8?B?OThnWWx1VTF3TVczQ3JrMXJQbU55S2ZFSVdwOWRCYXQ3YmsxblAyTmRnOW9W?=
 =?utf-8?B?NGozUmRYamRDRDYrb3lIZmE1bUZEZ1ptaS9IcGlvT2xSeGZ1a28rUVJjYUky?=
 =?utf-8?B?NXd0b2RNMHpGUU9HamlwVXFUMmhnMWU0bmNKMnF1bURoeE5ZY1lndll4dDBS?=
 =?utf-8?B?ZTJKaW5wOUJwSllQQlRHdStyR0hXS0hPMi9MSGY0OEg5c09zZlJCMG9KdnZV?=
 =?utf-8?B?alNRSG1ER3dSTDBkM1czNXJsWWRkVEFHYXBmY3RQTnkrR1dTdiszVGVXM2Zt?=
 =?utf-8?B?QzlDUzJFRG9Qc3E5UThXYzFHL3FZcWIxU1h4anFPNlh2VHFTSzczNEJ0b1Rm?=
 =?utf-8?B?M0dSR01PTmxrNGw5dGhEL3BnZ2xFR2Y3aTBnbS9uU2JvNkZvaUZNd3RFQlo5?=
 =?utf-8?B?L0poUG9EOWh2clZIdmI1SEJONll6aWJnZjNtUXBCQnJwamVFSjlJdS9SWG5E?=
 =?utf-8?B?ZGNIdk1CbDBFb1MySXAzMnhGT2ZjNUQ3VzNuVE9mdGFEd0I2UEtoeFlaOEdC?=
 =?utf-8?B?OUdiVXNWaU9lS1V5blNjQzJtc1dMR3ZnbW8yV1MvODZCcU1WUWdGQU5jQjYv?=
 =?utf-8?B?Z1BvQWFnMTVwcDRPeHRKQ3JQOFVpMzdNY1hnV3NXeWZzQ1pPUEE0NjZoUkEx?=
 =?utf-8?B?bjdLNGFGb0pOY2xVWHpRazZmWURlZzRkb2crMXA0YmJvTFd3cUV2Wi9OMzRu?=
 =?utf-8?B?NHhxeU5xSXpxNW1wOHBHWXJTUVBhOTVPa1c0Y1h5TnpQTnpDbVUyUWx5TWdM?=
 =?utf-8?B?Y1ZSZm91UUNrcWZteGFtdkZmMVpCTjRHNDNianFPRGpIM01ienZtdXpicHdB?=
 =?utf-8?B?NzFkNWlJL1pNd3VtRHZZd0JIaGhGbmJnMmxJTVQxak1LV2ZBeS9CTzZjWHRI?=
 =?utf-8?B?S3lTcG95SjVLeURHQlI4TlhvbVRpUXA5dXpQVnc5a20zOVUyOWlvd21HWDBt?=
 =?utf-8?B?WnhtSGQ3d2liWFduN1h0T3VzdUx2YTVwbTdoYjJCdXpWOUxReWM0R0d1aEUw?=
 =?utf-8?B?TG52TW1jYUlSSmVDd1pQazVPa0lGZUY3OHVxWHpkNEhMU21tVGJjRkhnanR0?=
 =?utf-8?B?R0MwbUtsRmZXQ2dVV1ZQcWF1SkM4MnRLZXVXQVY0M25YeHk5dTNpU0R1VXFL?=
 =?utf-8?B?SWZIUWw3TDdzcWRvRjhGdHFZd3BUcnV0U0I3NjlpTzg3THcvbHkySEJ3eFNh?=
 =?utf-8?B?VVROUzRZSHVTRFFuencwR3lJcm9Oc2t2MVpJZks5VkovM3Rva2FDeFFSQ3Mr?=
 =?utf-8?Q?qBOMBkXOERJLS9tw7QNdu8nRN?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <969A8640A916CE4AB015C9522A006714@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fzobQww5m9o52cuta77vQappK0s9/yiMMPyyEtx1AirgeNHbOXYA/nHJ2HpAWjyobsIA7+0KLXhiHrGd+0JNjUwB43oeVHUFaK2qooGJ1dA9mqLnN/O/K0wRWqhj4rOqvXakdUfg7F0NCOn/VTvjGt211w2bUTSI+Tk9HHn5eiMuwG1SoxGwgQK2jU0OF+PR48tVtxTqL9rDsbRhr3XFa5Wv0hATY5OGXH36BxjoruqQX0VCkTL5io0MP2Yz3xUZhSNMmGlUx8dvaLaROPAfpVj2CEOHowxt4PRVwvps9mIFE6B2d6s3uxcWzzKS9e/LXseJFSm9yOB2aFzkzEls9yrNv4z9nZAoOIv1VQO+cVd7gxY+gLvwGOEVfmnxNDui96qn2cLF96CDmg6uzAfo+eB4azv8GGbDCOL+WLnKyVzrjS5fBm7aFTddAoGFfKLFp7F81lXCHYUR107A4o1tVehVDN9YbahJHvn2HtfP3BzcCayH4GzypDE2ngOtqTCOiaCXtnqGeqOnk2khrzR9kbXmiF6xnXbvgc3Vhrjcm+LOJjU1m4mjUkaufE4fCsA02ALbqVlS5BIff1c56Zp5CjYeH36nSKl+1kzMG2JkAiocMpO5L/ER/egAQzSyLBp2Vj6hZ/DzXstpSseBrKLX5Kk3rkzVZyq+wkc31U31HzP3FGojv5uqk7K1u0Sbzc94XavkQSJCQD+xMJ+/q/65vmXW0MFhL6r4EkrOlbow1QZ+BD0f3KuvepfjJ8dNL6g3uB/y96+iH6UkhTzqGnpClMjggPN9Rwx0s76dIqUYZ2lcFL6kC9YUIlYUQXkliTmOzZHLo1YgaIMRcvku7hAy9ItUsGmJdeiCuJt4zsmzTJR0GFz/36CCuRa3QKKp7VBD5dh0UILYHHct9IfHBBMuIw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f94a7d48-851b-41df-ec77-08dbf5339a15
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2023 01:43:37.9807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dnxw34RkiEZ0Dwhn8FW6yFrw+RWfKiRqCGnf8eg/ieZ54b7F24WaulZfn7xeGJpX7pYzgqYBLFPZb/rxwUSssA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6436
X-Proofpoint-ORIG-GUID: h4TrY8PL0TLkxjWuEC-1JGWdMipM0R0n
X-Proofpoint-GUID: h4TrY8PL0TLkxjWuEC-1JGWdMipM0R0n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_24,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1011 spamscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 mlxlogscore=703 suspectscore=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2312050012
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBOb3YgMjIsIDIwMjMsIFV0dGthcnNoIEFnZ2Fyd2FsIHdyb3RlOg0KPiBDdXJyZW50
IGltcGxlbWVudGF0aW9uIGJsb2NrcyB0aGUgcnVubmluZyBvcGVyYXRpb25zIHdoZW4gUGx1Zy1v
dXQgYW5kDQo+IFBsdWctSW4gaXMgcGVyZm9ybWVkIGNvbnRpbnVvdXNseSwgcHJvY2VzcyBnZXRz
IHN0dWNrIGluDQo+IGR3YzNfdGhyZWFkX2ludGVycnVwdCgpLg0KPiANCj4gQ29kZSBGbG93Og0K
PiANCj4gCUNQVTENCj4gDQo+IAktPkdhZGdldF9zdGFydA0KPiAJLT5kd2MzX2ludGVycnVwdA0K
PiAJLT5kd2MzX3RocmVhZF9pbnRlcnJ1cHQNCj4gCS0+ZHdjM19wcm9jZXNzX2V2ZW50X2J1Zg0K
PiAJLT5kd2MzX3Byb2Nlc3NfZXZlbnRfZW50cnkNCj4gCS0+ZHdjM19lbmRwb2ludF9pbnRlcnJ1
cHQNCj4gCS0+ZHdjM19lcDBfaW50ZXJydXB0DQo+IAktPmR3YzNfZXAwX2luc3BlY3Rfc2V0dXAN
Cj4gCS0+ZHdjM19lcDBfc3RhbGxfYW5kX3Jlc3RhcnQNCj4gDQo+IEJ5IHRoaXMgdGltZSBpZiBw
ZW5kaW5nX2xpc3QgaXMgbm90IGVtcHR5LCBpdCB3aWxsIGdldCB0aGUgbmV4dCByZXF1ZXN0DQo+
IG9uIHRoZSBnaXZlbiBsaXN0IGFuZCBjYWxscyBkd2MzX2dhZGdldF9naXZlYmFjayB3aGljaCB3
aWxsIHVubWFwIHJlcXVlc3QNCj4gYW5kIGNhbGwgaXRzIGNvbXBsZXRlKCkgY2FsbGJhY2sgdG8g
bm90aWZ5IHVwcGVyIGxheWVycyB0aGF0IGl0IGhhcw0KPiBjb21wbGV0ZWQuIEN1cnJlbnRseSAg
ZHdjM19nYWRnZXRfZ2l2ZWJhY2sgc3RhdHVzIGlzIHNldCB0by1FQ09OTlJFU0VULA0KPiB3aGVy
ZWFzIGl0IHNob3VsZCBiZSAtRVNIVVRET1dOLg0KPiANCj4gQ2M6IDxzdGFibGVAdmdlci5rZXJu
ZWwub3JnPg0KPiBGaXhlczogZDc0MjIyMGIzNTc3ICgidXNiOiBkd2MzOiBlcDA6IGdpdmViYWNr
IHJlcXVlc3RzIG9uIHN0YWxsX2FuZF9yZXN0YXJ0IikNCj4gU2lnbmVkLW9mZi1ieTogVXR0a2Fy
c2ggQWdnYXJ3YWwgPHF1aWNfdWFnZ2Fyd2FAcXVpY2luYy5jb20+DQo+IC0tLQ0KPiAgZHJpdmVy
cy91c2IvZHdjMy9lcDAuYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZXAw
LmMgYi9kcml2ZXJzL3VzYi9kd2MzL2VwMC5jDQo+IGluZGV4IGI5NDI0MzIzNzI5My4uODMxN2Zl
ZGRhMWMwIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2VwMC5jDQo+ICsrKyBiL2Ry
aXZlcnMvdXNiL2R3YzMvZXAwLmMNCj4gQEAgLTIzOCw3ICsyMzgsNyBAQCB2b2lkIGR3YzNfZXAw
X3N0YWxsX2FuZF9yZXN0YXJ0KHN0cnVjdCBkd2MzICpkd2MpDQo+ICAJCXN0cnVjdCBkd2MzX3Jl
cXVlc3QJKnJlcTsNCj4gIA0KPiAgCQlyZXEgPSBuZXh0X3JlcXVlc3QoJmRlcC0+cGVuZGluZ19s
aXN0KTsNCj4gLQkJZHdjM19nYWRnZXRfZ2l2ZWJhY2soZGVwLCByZXEsIC1FQ09OTlJFU0VUKTsN
Cj4gKwkJZHdjM19nYWRnZXRfZ2l2ZWJhY2soZGVwLCByZXEsIC1FU0hVVERPV04pOw0KDQpUaGVy
ZSBhcmUgb3RoZXIgY29uZGl0aW9ucyB3aGljaCBzaG91bGQgcmV0dXJuIC1FQ09OTlJFU0VUIChl
LmcuIGludmFsaWQNCmxlbmd0aCwgZGlyZWN0aW9uLCBnb3QgY2FuY2VsbGVkKS4gRm9yIHRoZSBw
YXJ0aWN1bGFyIGNvbmRpdGlvbiB0aGF0IHlvdQ0Kd2FudCBmb3IgLUVTSFVURE9XTiwgSSB0aGlu
ayB5b3UgY2FuIHVzZSB0aGUgZHdjLT5jb25uZWN0ZWQgZmllbGQgdG8NCmNoZWNrIGZvciB0aGF0
Lg0KDQpCUiwNClRoaW5oDQoNCj4gIAl9DQo+ICANCj4gIAlkd2MtPmVwc1swXS0+dHJiX2VucXVl
dWUgPSAwOw0KPiAtLSANCj4gMi4xNy4xDQo+IA==
