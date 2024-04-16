Return-Path: <linux-kernel+bounces-146977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E83328A6DC8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DC46282A57
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B9D12F373;
	Tue, 16 Apr 2024 14:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="tEbgyan5"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FBC12D1ED;
	Tue, 16 Apr 2024 14:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713276923; cv=fail; b=uspIwNWjsHPvY5VW5in0s5qISWob+dqV/3Njg3SwSVbmdhq4+AWMcTcE5dSgB1vf0KU54DUbhg5Zg/1yktU/oDv/GaGKT/R6Tz36aJFepAeyjnsJZ2PruUBjzlvi6RGBjA8zUs85am6tdsrBomtMU+nIzZ0R+sMjkXPxm84s4yI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713276923; c=relaxed/simple;
	bh=hFRZB3zl/8XR0PlGrhK4LvC0DLEaL1TwaAc7z5AyihQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l0y/m53WbPywyXfbbFv1APgHGfb5j0z4Veak5L5ozj0+s/WxiGZsv9GDMJFM8nsViXYUUc2DkRhnZb04WJvdsaP/6I82Hx3iygCDpojOcdQYDJtomLQOcxeHlFyQsDQ8RHxr5lOD/1QBOG3BnJuvn/k+nU0HkcHuJ2t8eWI+0TE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=tEbgyan5; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43GDXNdA023938;
	Tue, 16 Apr 2024 07:14:43 -0700
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3xhm1ehgmh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 07:14:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NA5VTzrk7qvomftJtU2b1yiHfW7NfxDFO6PAmcN6m44MZMM4f1xxcFqoZZt3RyIPxWm2RDl6EHJy5k8yIhFc4i5d3gR29Dop1ZDx6RosrL1ddYVjCt2UMETu0SeVfcNiBnv7iYRd50uLNL2ybLUO2gPV92U0VSyGbrDFHR7SAmRxCRpQWTbtTC6M4FeB+wuetDP2NbstpuO48v2bjsSIs/z9PT3reQS86u7Hw0aB8AjzQHdjiGAC34pMV6T9CWB1uFvAC2fL3IuAJKdo3h4LX6PM5hvfAmVnc3o4xyat5mZB5odX/w9wlGl/Xyxejv21Oi3XK1QQym1tYiIFZM1mUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFRZB3zl/8XR0PlGrhK4LvC0DLEaL1TwaAc7z5AyihQ=;
 b=bnMFJxxezPnwmLDmugBIYDWmQ+ZVZBzlysjC2PKCQrWJyzazvaigj3u9wJJsF7TYtLoKZHALyHDN1t4xLHssEFkEfIi0QJ0snfGGgdo9pgXY5d+9ZWx7nu4MR4W5ZtR88B+XTHWRwaEMB21zA0ss951ooD+RBNgIQj07CIJhKzBsgEKQ9F/je0XkeRYsD5Oc/otVbXQG75ZGyfSl8s6x6Bg0YnA15kP8IAklGYO2uMfwDVPkAO7V6oTvptybAe0clSRLryK9L/yJxOq689eNid6byC5lSNvokoUbPLm8nbK1KftikG8DkDvOs8WnroKdjgnCMn82vCxgfhE+Udg+Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFRZB3zl/8XR0PlGrhK4LvC0DLEaL1TwaAc7z5AyihQ=;
 b=tEbgyan55FMXG/HMF4JL/GzlU7S8WGgD6qK86K7ybFzhuOCnpulPq7Yffpgi1k5lRPD8TLAfxLTO5QZoknO/Z/4xtuvs9wuzRNS5X4lUymn9XQs6Y8NGItGEPfDLb5ZpyLrqZ39GDLETUEoXVpkiWVuYSdpURhINcagy6eRY1gc=
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com (2603:10b6:a03:430::6)
 by SJ0PR18MB3883.namprd18.prod.outlook.com (2603:10b6:a03:2e5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 14:14:38 +0000
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::86bb:c6cf:5d5b:f3b0]) by SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::86bb:c6cf:5d5b:f3b0%5]) with mapi id 15.20.7452.046; Tue, 16 Apr 2024
 14:14:38 +0000
From: Suman Ghosh <sumang@marvell.com>
To: =?utf-8?B?QXNiasO4cm4gU2xvdGggVMO4bm5lc2Vu?= <ast@fiberby.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "David S.
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sunil Kovvuri
 Goutham <sgoutham@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Hariprasad Kelam
	<hkelam@marvell.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: RE: [EXTERNAL] [PATCH net v2] octeontx2-pf: fix FLOW_DIS_IS_FRAGMENT
 implementation
Thread-Topic: [EXTERNAL] [PATCH net v2] octeontx2-pf: fix FLOW_DIS_IS_FRAGMENT
 implementation
Thread-Index: AQHajNGATCjHSUc50EKnmt4IKi8YjLFq9u4A
Date: Tue, 16 Apr 2024 14:14:38 +0000
Message-ID: 
 <SJ0PR18MB5216B2D0FE09C7BCDE5A1286DB082@SJ0PR18MB5216.namprd18.prod.outlook.com>
References: <20240412120258.233970-1-ast@fiberby.net>
In-Reply-To: <20240412120258.233970-1-ast@fiberby.net>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR18MB5216:EE_|SJ0PR18MB3883:EE_
x-ms-office365-filtering-correlation-id: 899448e5-27a2-43e1-34bf-08dc5e1f8d14
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 =?utf-8?B?anQ1bmttRHYwZllUSDZXeWxkZkEvZVZUdGVTNFl3bDdkU3J3QitVemJqd0hM?=
 =?utf-8?B?WFJNbnhkR1dId3ZZdjdJenVUQUNKc1NtU0xySVlrSnRLcFBXbFNraFdxSS9W?=
 =?utf-8?B?OHhkNG9ab281VnBTeHJ1TkhHbGJjSTZUSGlKRjI2Q3BtOEsvRUVQVHVkdFVw?=
 =?utf-8?B?QWMvRHRZU1FUejRxK3kxZXJybzRGTml2QTFheS8xcFRPRXVkQzI2WVNQRjNq?=
 =?utf-8?B?S0xnTnNjRGF3UmNyQVlDZTNUSWcwSmM3QVMydjI2WlkyaHJnZk5TUzU4cUdu?=
 =?utf-8?B?SVhzTEpaaXJSNjFyS25CSHcyT2JKYkIxQ0M5TEVxcFVFazQxSlhZejlXbFI1?=
 =?utf-8?B?ZTV1ajIwZnJkN0syalF1bGRUazRYV2dXOEtNZVIzcnBrUEdiQWZXRzl0a2pK?=
 =?utf-8?B?WmVYT1BPRE1rd2RhUmhZTXVLWFd1NFBUU29sS3ZGM2ZnWDllYzVTL3ZSRFdC?=
 =?utf-8?B?ZmFXbDdTTCtvK1JOSVVQTWZDelhqNEU0SGhyU1VJbkNmTUpWcU9MamdyeDM5?=
 =?utf-8?B?amZnbjRlMmNYYVA1YnNJODZhSE5udVZpWHM1cVV6ZktDZTJrVWlYWjE0S05O?=
 =?utf-8?B?cmZnekllanZFN0NDeHhhL0NPbkttekpvQTZkRVpEeHRTYkl6K0hQY2IveU0v?=
 =?utf-8?B?OGdveGIxUU9UNTVrZGV6ZlJkZUExWWdXS3ZncnV4cC9LTURJV3ppVGMrNGFB?=
 =?utf-8?B?bWxDeFdSNnY1VW1vQnBuZ3FDajJxZ0VLTEtOaFdrbDhFbSsyT2tJZUU1OXN5?=
 =?utf-8?B?UjRLdTZFUU5sUkQzUE1wby9FNkdqSmlBd3MwTmgzV1IrbGhiMWovUWlLbHBv?=
 =?utf-8?B?YXd0VHVvZThLVktHVTlVTXlYelBZUlJJc1J3aUxsNUk3aVoxSlVDQldvRjNG?=
 =?utf-8?B?REEyUXhDOTdsakdYTWxRWjJBWE5qUWlOSnovbmd4dWpYTm92UmFPNFRtbTNo?=
 =?utf-8?B?dUI2Q1YxcVhPVjZiV2NFZyt5WnVWdVNUdW03ZVoyM0E3cmlOZEFrRS9OM0Ft?=
 =?utf-8?B?WVh6RWV1Z1hhODdpVFFSOGE4MWtPOWNQUFlxSGtkRGJDQkJvRVJMRmI0WTRP?=
 =?utf-8?B?aWFjV1hvZGNJWXUvd3djRkVnelA4ZEQyZFhJUW5VTThhMXhUN016NC9JaDZ4?=
 =?utf-8?B?Sms0d1hXUXhxQkFuMDNqNUFqbnZQU2NLNkNLbXM0MlJJQ1g2UVlUSk5WRTNa?=
 =?utf-8?B?M2oySnAzUStPaXVFcHVGUGpTRDlLYy9aUm94Vit3TnYyWXllZUJKUUVEK1Vv?=
 =?utf-8?B?T2JQalNyRHpualg1cCtyUW1jNFE5b2NhaWd2blVZK05WdmJGeU1KRjZVWDcw?=
 =?utf-8?B?Tmo1ZFlPUGhodk54WTRYRGcvZ3NXMTNDRFU2OE81aHZhMEd3WWdtY1dkZkxE?=
 =?utf-8?B?eWFUZithUEdYMXZjUStjVnQ1bTFCa3RvWEVDdzF1bk9WZHNqd0NVNk5sTUZY?=
 =?utf-8?B?UzF0MXBiejF1S09HL0YyTnpNWXE4RFpXcU5BeEFnQ3dFbFNXc29zblI4RGsv?=
 =?utf-8?B?UkpFdTVTa29GNXk1UHdJRm5PVzhvZVF1ZGwzUjR4K09SWHNoZTBpWnhUd1pY?=
 =?utf-8?B?VG43KzJoRnZrTWpqUnlER3lzelk4WnRYK3ExR205Unk3bW1ybEFaMVM5YUJx?=
 =?utf-8?B?Vkx4Z3FpLzA4cW1iQWFiaFh1WHhUbEtZQVNsVTh5YnVweStkRWtlbVl1M3dH?=
 =?utf-8?B?c0t6NGlTZldBWXlWQzVwTFFqTVVCcElBaXp0bHZEemE0ckNveVlWN1J3PT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR18MB5216.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?aXQxS3JXVXdvTjdGQUs5UUpCR3M4WXR3OCtTcWJ4ZVpVTC9ZVGJ0R05VSkhJ?=
 =?utf-8?B?VXN0WTM1L1BBQWRJK3AyNkh5c29IRWZsTDdQaVkxTHBWY3dtUGFJNXFKQ2Fs?=
 =?utf-8?B?dlBOQXp2QmFxV1M0eGdZeTJHakZCV2xzVHRnTmlVUzNQL3FYNTg1Z1JwVnlo?=
 =?utf-8?B?c2QrL1dQbGgvSmVZR2E1ZDZzV243bHByS1VKZTE0QWsxeXpCVFpNelFvVVRX?=
 =?utf-8?B?WWlGMjJOWllLTXBIRXVlNzdvNkFzYU9IS2NCeWsveU14QWNoTEx5ZW8vaUZz?=
 =?utf-8?B?VC95NG11Sko2ZUg5eXBjdW9BekZPL1l6VVRmdTZFbS9ET3dHdUZqaUEySGNs?=
 =?utf-8?B?WjhYM2NSOHhRYmdDL290cWZwVGY3cUZqUGR3OU9nTzQ4bHpXazJqZ2RFTG5I?=
 =?utf-8?B?dVB1SUltVzhHWHA0Wnp2UElFekRtZS9NeVo0TVZ4aGhuYTkrbDZ3SERqZnlM?=
 =?utf-8?B?dUlPQTdpcWoxWi9ETnhqQ3l4Q0FCNFF0SkdKeVdqTkUzOWVRZXFCcTdzSFBT?=
 =?utf-8?B?elpwdnZ3N081ekRUSWx6OGdjQjFaSmUzaDFxcktXWUQrbGE5WGNzRUc0S1ZK?=
 =?utf-8?B?WjdJS3l4Wmx6VjdSYUNQaVFzMDJTdHJkN0U1NGw0ZkNpWngwYmxXTmR0ME0y?=
 =?utf-8?B?Rmx3ZUVjeDdmNmhuMXlIaGRzMHdCYzMxcWhEUnVRa0NCTVJiVi9lZU1Xb2pG?=
 =?utf-8?B?RkpySXRMOGtqRTFuODZpQkl2U3p1WC9nOUtVQUJlQkdiQlMxZGhBT1VjMFVO?=
 =?utf-8?B?VUdFV0JyeFIzbFd5bU9RVXN1SFVQTGMyalQzekFHeXFJQkswcGI4a3UxVWgx?=
 =?utf-8?B?cHRSTFphU2xGQlE4TlFrVGl3ekR6NG5HY2lJUGxhSmV1QnlFaXRGWkxjRUR2?=
 =?utf-8?B?Rkl4T1g3WEdkMmRpTzh2dm5tMDkwcUwvVUxIcEk1SkY1UGFibXFzSTVpczJZ?=
 =?utf-8?B?dDVsaEdjZUJ5NzUySE5VRGFIQWU1NkZCZk9idVFSRUNoZW9WTG5pNEtkbS95?=
 =?utf-8?B?S3Rza0NyRy9RcExQdEdvSm03OFVkcjlIMU9mTXkrcCtYeTVVUEJvRFRrVDVU?=
 =?utf-8?B?OUZqeGxtT082TC9JMWFQeEtKTCs0WHBhYm5jcUE5dnNzMkxEQndweWtGM0E2?=
 =?utf-8?B?QzFRY2VidCtBN3VoU0dXSE9vcWVqRERvZ3hlV0JVc1JrN2QvY0ovdG1Ua0pQ?=
 =?utf-8?B?WEVOdHJzZGxwSTF1V0JPVGoxUW5nL0pCUkV5eUdqOGtBeUkwdE9NM3AvZ3dG?=
 =?utf-8?B?UU4xa3cwQ01pUUgyYnZINTAzQWY1MWU5Skd5RW13ZEJLVlFtM2ViQ0Ivb0dR?=
 =?utf-8?B?NTdvRGpnM2taRnlYQ2VCRDNYQ1R0V3I2YStRTnQwamJCRnZlZmlKNjd2eWVV?=
 =?utf-8?B?bEE1czdEM21ZY0srcUtkRWVGdm5qVnNuVHZEdDgybUlkYjF2SWV4dGVUYURm?=
 =?utf-8?B?NlpGM3FKRlBPWFFxbkxnWW9BSVIvcytvVnZVUWNYTzhkNTZDakRVc0dtdFkz?=
 =?utf-8?B?T1VERnJ0V1NEWHM5SnRiaXM0NzBwaVAzcWljWVZ2RVpUZFAvS0wxcFl5R0hX?=
 =?utf-8?B?aEwxZ2IrLzE3SzllWi9iTzZuNDZpOWdBRFA3c1pkNjFFUnNaTU82WVdVazJK?=
 =?utf-8?B?NlliM2gzTEN4bUVkT3hEYjFETExvaHRnYVJSYkpVVWtGandKZU4vUWNYS3Z3?=
 =?utf-8?B?ZXlzUlc3SGthdzY2OUlHT0c5Vk81cmVXSkpiRUdOTmxhWnF5V3pSRFNuNVVv?=
 =?utf-8?B?ZHpBamRUM01LbU1GQS9UNGs0V3Iza1JKRDhxWENuSitEaFZrdXpUY01FUjV3?=
 =?utf-8?B?K29GSU1Uc3RpaWNvd05lSVJyV204KzY3cE56K2s4U0tWUFRFMHhraG81MjRR?=
 =?utf-8?B?OC9kdlo3SzJwN3FJdElaL09hRFNRVW55ZG1xenVxcmh0TUNwN29nRDdqLzRN?=
 =?utf-8?B?M1RsUTlUcTdzUE8rV3lDQVZ1blhMbEIzYVlMRmJTSStVOG1VNk1iRzMzMk1Y?=
 =?utf-8?B?R2tzVnJ6K042ZEVLRTBVT0NQeVltVno3WDNRZ3BycGRRYkd2OHo0b0I1bU1J?=
 =?utf-8?B?aEFaaVU0ZEtsYlpoRXJPQ0F2UmxlTWNtY3g0ck92Z3hHMlhCR0JzZENTemx0?=
 =?utf-8?Q?EnXQzlxsqCSIR0FBX86Zu/FWJ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB5216.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 899448e5-27a2-43e1-34bf-08dc5e1f8d14
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 14:14:38.3405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kHfY18HxV0MNFgsuS8GZXe/9zuOGL1Q0TdECrp49X8g8aWEi9WpBxpz2cp1YjYifAtT6Zkz2wsQ5TUlr0HoxuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB3883
X-Proofpoint-GUID: RQmiF4M5c0d4zh69Unu-ZX9kLbKa5vdD
X-Proofpoint-ORIG-GUID: RQmiF4M5c0d4zh69Unu-ZX9kLbKa5vdD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_10,2024-04-16_01,2023-05-22_02

PlVwb24gcmV2aWV3aW5nIHRoZSBmbG93ZXIgY29udHJvbCBmbGFncyBoYW5kbGluZyBpbiB0aGlz
IGRyaXZlciwgSSBub3RpY2UNCj50aGF0IHRoZSBrZXkgd2Fzbid0IGJlaW5nIHVzZWQsIG9ubHkg
dGhlIG1hc2suDQo+DQo+SWUuIGB0YyBmbG93ZXIgLi4uIGlwX2ZsYWdzIG5vZnJhZ2Agd2FzIGhh
cmR3YXJlIG9mZmxvYWRlZCBhcyBgLi4uIGlwX2ZsYWdzDQo+ZnJhZ2AuDQo+DQo+T25seSBjb21w
aWxlIHRlc3RlZCwgbm8gYWNjZXNzIHRvIEhXLg0KPg0KPkZpeGVzOiBjNjcyZTM3Mjc5ODkgKCJv
Y3Rlb250eDItcGY6IEFkZCBzdXBwb3J0IHRvIGZpbHRlciBwYWNrZXQgYmFzZWQgb24NCj5JUCBm
cmFnbWVudCIpDQo+U2lnbmVkLW9mZi1ieTogQXNiasO4cm4gU2xvdGggVMO4bm5lc2VuIDxhc3RA
ZmliZXJieS5uZXQ+DQo+UmV2aWV3ZWQtYnk6IEphY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJA
aW50ZWwuY29tPg0KVGVzdGVkLWJ5OiBTdW1hbiBHaG9zaCA8c3VtYW5nQG1hcnZlbGwuY29tPg0K
Pi0tLQ0KPg0KPkNoYW5nZWxvZzoNCj4NCj52MjoNCj4tIEFkZGVkIFJldmlld2VkLWJ5IGZyb20g
SmFjb2IgS2VsbGVyLg0KPg0KPnYxOiBodHRwczovL3VybGRlZmVuc2UucHJvb2Zwb2ludC5jb20v
djIvdXJsP3U9aHR0cHMtDQo+M0FfX2xvcmUua2VybmVsLm9yZ19hbGxfMjAyNDA0MTAxMzQzMDMu
MjE1NjAtMkQxLTJEYXN0LQ0KPjQwZmliZXJieS5uZXRfJmQ9RHdJRGFRJmM9bktqV2VjMmI2UjBt
T3lQYXo3eHRmUSZyPTdzaTNYbjlMeS0NCj5TZTFhNjU1a3ZFUElZVTBuUTlIUGVOMjgwc0VVdjVS
T1UmbT1VZk1yVm5EVTVKQnNhVkNwMnFGT3FaUkdrRHlCdG9ReThRQ1ZqcmQNCj56b2lQeTRTVWhw
dnJPRVMzZzNZbEFoTUNhJnM9VzNTc0lWYVJXbUx3RjBWRlNSckhMSWNBM3JlSE9MMXFHTlpkLWFH
cmZ0ayZlPQ0KPg0KPiBkcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9uaWMv
b3R4Ml90Yy5jIHwgNyArKysrKy0tDQo+IDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pDQo+DQo+ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21h
cnZlbGwvb2N0ZW9udHgyL25pYy9vdHgyX3RjLmMNCj5iL2RyaXZlcnMvbmV0L2V0aGVybmV0L21h
cnZlbGwvb2N0ZW9udHgyL25pYy9vdHgyX3RjLmMNCj5pbmRleCA4N2JkYjkzY2IwNjYuLmY0NjU1
YThjMDcwNSAxMDA2NDQNCj4tLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVv
bnR4Mi9uaWMvb3R4Ml90Yy5jDQo+KysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9v
Y3Rlb250eDIvbmljL290eDJfdGMuYw0KPkBAIC02ODgsMjIgKzY4OCwyNSBAQCBzdGF0aWMgaW50
IG90eDJfdGNfcHJlcGFyZV9mbG93KHN0cnVjdCBvdHgyX25pYyAqbmljLA0KPnN0cnVjdCBvdHgy
X3RjX2Zsb3cgKm5vZGUsDQo+IAl9DQo+DQo+IAlpZiAoZmxvd19ydWxlX21hdGNoX2tleShydWxl
LCBGTE9XX0RJU1NFQ1RPUl9LRVlfQ09OVFJPTCkpIHsNCj4gCQlzdHJ1Y3QgZmxvd19tYXRjaF9j
b250cm9sIG1hdGNoOw0KPisJCXUzMiB2YWw7DQo+DQo+IAkJZmxvd19ydWxlX21hdGNoX2NvbnRy
b2wocnVsZSwgJm1hdGNoKTsNCj4gCQlpZiAobWF0Y2gubWFzay0+ZmxhZ3MgJiBGTE9XX0RJU19G
SVJTVF9GUkFHKSB7DQo+IAkJCU5MX1NFVF9FUlJfTVNHX01PRChleHRhY2ssICJIVyBkb2Vzbid0
IHN1cHBvcnQgZnJhZw0KPmZpcnN0L2xhdGVyIik7DQo+IAkJCXJldHVybiAtRU9QTk9UU1VQUDsN
Cj4gCQl9DQo+DQo+IAkJaWYgKG1hdGNoLm1hc2stPmZsYWdzICYgRkxPV19ESVNfSVNfRlJBR01F
TlQpIHsNCj4rCQkJdmFsID0gbWF0Y2gua2V5LT5mbGFncyAmIEZMT1dfRElTX0lTX0ZSQUdNRU5U
Ow0KPiAJCQlpZiAobnRvaHMoZmxvd19zcGVjLT5ldHlwZSkgPT0gRVRIX1BfSVApIHsNCj4tCQkJ
CWZsb3dfc3BlYy0+aXBfZmxhZyA9IElQVjRfRkxBR19NT1JFOw0KPisJCQkJZmxvd19zcGVjLT5p
cF9mbGFnID0gdmFsID8gSVBWNF9GTEFHX01PUkUgOiAwOw0KPiAJCQkJZmxvd19tYXNrLT5pcF9m
bGFnID0gSVBWNF9GTEFHX01PUkU7DQo+IAkJCQlyZXEtPmZlYXR1cmVzIHw9IEJJVF9VTEwoTlBD
X0lQRlJBR19JUFY0KTsNCj4gCQkJfSBlbHNlIGlmIChudG9ocyhmbG93X3NwZWMtPmV0eXBlKSA9
PSBFVEhfUF9JUFY2KSB7DQo+LQkJCQlmbG93X3NwZWMtPm5leHRfaGVhZGVyID0gSVBQUk9UT19G
UkFHTUVOVDsNCj4rCQkJCWZsb3dfc3BlYy0+bmV4dF9oZWFkZXIgPSB2YWwgPw0KPisJCQkJCQkJ
IElQUFJPVE9fRlJBR01FTlQgOiAwOw0KPiAJCQkJZmxvd19tYXNrLT5uZXh0X2hlYWRlciA9IDB4
ZmY7DQo+IAkJCQlyZXEtPmZlYXR1cmVzIHw9IEJJVF9VTEwoTlBDX0lQRlJBR19JUFY2KTsNCj4g
CQkJfSBlbHNlIHsNCj4gCQkJCU5MX1NFVF9FUlJfTVNHX01PRChleHRhY2ssICJmbG93LXR5cGUg
c2hvdWxkIGJlIGVpdGhlcg0KPklQdjQgYW5kIElQdjYiKTsNCj4tLQ0KPjIuNDMuMA0KDQo=

