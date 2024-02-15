Return-Path: <linux-kernel+bounces-66317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D83EC855A3B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 06:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63B6B1F2532D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 05:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36658BE65;
	Thu, 15 Feb 2024 05:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="mFTN0mf/";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="nyn1DJfB"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6BFDDA5;
	Thu, 15 Feb 2024 05:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707976435; cv=fail; b=ZsJQvOlTy7pMfRiR6vLKvuDsL9QFBigj497w13eX0CxYJQKrOMhaagK8TloA5WKkY8u+rRtOOnsQ0qGk1YAwRgLVxyT/KSK6NmHtp+OLcWKuXlTJdeYpMegZFxfEXpn9yT/V9XN99YX+4B5Sob6SjjnuAWvgJXYJFg8GFdZO/0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707976435; c=relaxed/simple;
	bh=1Wp0qECFEeCgJeIKeom3lLkidlslCu7+nKolOR0xRJE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GLnsAvrsf4kC7qwd3QsVI91U517bVrLcLsyZH7kHKG8CofZydtmR29yFFLRTgqoay2c37dVHca9zXf9akfEIaFgMp0yG7eU+QEjnC43Q8kF7Voipn+ZFuTo6+ay5csr6dAK0xm8TgvDRTX5bAe8QNA309cyyylmqcxABMKdDRA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=mFTN0mf/; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=nyn1DJfB; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 941a3b84cbc611ee9e680517dc993faa-20240215
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=1Wp0qECFEeCgJeIKeom3lLkidlslCu7+nKolOR0xRJE=;
	b=mFTN0mf/3mcWJxEXBwaEEUaxW1ASVV9UPqqUzZ7NPv9R/xFUq4PEC7zIdUhuCV7vB3WjuPudkCjsw77iyKjaiNif7+Ky0SrJU6/H5DIHtNcZ9D3nNxnJxfU73B407mvhFN/Dbz/kPuTHqXY1sWxvTa0oYCvoHyhCNZ6CZam+OLY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:e3f0008c-4a77-4ea3-9558-7ab3df76c6ba,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:e9b7cdfe-c16b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 941a3b84cbc611ee9e680517dc993faa-20240215
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <peter.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 555237687; Thu, 15 Feb 2024 13:53:44 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 15 Feb 2024 13:53:42 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 15 Feb 2024 13:53:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bEJJRHBa70eOpyuc+AMQDSJ6KvtieimrMj8ibG6ZSMi/1sfl2dSk7VvEh67B5ABHUe4V6VCjN3pcIARQRqU+mdwxd02K09uFtwDqA1YdO9DLwpY3di36YjH19SJNdeiED/kJAHEAb2yyq2AA09wrUAbWJe3XRs1+Dto253XIC7i7ttA0huQqc86MbnlKKCttXLKxNeteKYZg3BwhHgxxcnd9q49bRd7OuJsAaZ95JXqpYWXMxyBELAMdyJ7ArMo8qzsJXGOiUL7qbVchg1SXxi8+8YJ7pjCMwuvZyHiuu5zdbX93T/o5zVdcFwm5y8KCEkTQVutE3oTnvgGXkXIBwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Wp0qECFEeCgJeIKeom3lLkidlslCu7+nKolOR0xRJE=;
 b=PJWEpLwF73YY9/akbv/EqDMmr1IFIFg7opFgS6fIBXbXUKG7M9aq5/3Ea5znIKJID/avrtUz+PtYstzWP2HuAgdQXEeY7ZKUN7AK87zkOQR2zV6XgGXemsAL0r23gLQIyAZ5DcR3ABIATIyNvylcLOqhVQSvhd/flB8oMirh66rhVeNz/2bKIUalOYejZK7yfG63jPnqwdSkTcHoCRNtpUtr9M46mL4fHQqv+yHsSEk61A2LIhr/DS1pNleU3RZP+XCTJxlO3viqLeUcU7tbpHoDcLygLJXD+WN0mkbe9CCJAhjc8+0FfK06OuOKO6seNAurTKNnuZ2msmhGAq74Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Wp0qECFEeCgJeIKeom3lLkidlslCu7+nKolOR0xRJE=;
 b=nyn1DJfBsNHOhszcmWgKYZVeKp8ovmfG7yynzLiYs2Hq08hxRmknhE4vvWoJO9Ztz9xNAhMkypPFXW6WUXQprAhYMfhTFPDBF8mik2VwUHDCtpvHU50Zp0RIfH9XONULdCjsUu78yTDH7P4JMPZA9uoFl4u9rKcAzvkdY2vg2vU=
Received: from PSAPR03MB5605.apcprd03.prod.outlook.com (2603:1096:301:66::6)
 by SEZPR03MB8268.apcprd03.prod.outlook.com (2603:1096:101:191::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Thu, 15 Feb
 2024 05:53:41 +0000
Received: from PSAPR03MB5605.apcprd03.prod.outlook.com
 ([fe80::b3e8:3d9c:baa1:fe29]) by PSAPR03MB5605.apcprd03.prod.outlook.com
 ([fe80::b3e8:3d9c:baa1:fe29%5]) with mapi id 15.20.7292.029; Thu, 15 Feb 2024
 05:53:40 +0000
From: =?utf-8?B?UGV0ZXIgV2FuZyAo546L5L+h5Y+LKQ==?= <peter.wang@mediatek.com>
To: "dan.carpenter@linaro.org" <dan.carpenter@linaro.org>
CC: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"quic_nguyenb@quicinc.com" <quic_nguyenb@quicinc.com>, "jejb@linux.ibm.com"
	<jejb@linux.ibm.com>, "quic_ziqichen@quicinc.com"
	<quic_ziqichen@quicinc.com>, "beanhuo@micron.com" <beanhuo@micron.com>,
	"avri.altman@wdc.com" <avri.altman@wdc.com>, "bvanassche@acm.org"
	<bvanassche@acm.org>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, "alim.akhtar@samsung.com"
	<alim.akhtar@samsung.com>, "manivannan.sadhasivam@linaro.org"
	<manivannan.sadhasivam@linaro.org>,
	=?utf-8?B?U3RhbmxleSBDaHUgKOacseWOn+mZnik=?= <stanley.chu@mediatek.com>,
	"athierry@redhat.com" <athierry@redhat.com>, "quic_cang@quicinc.com"
	<quic_cang@quicinc.com>
Subject: Re: [PATCH] scsi: ufs: uninitialized variable in
 ufshcd_devfreq_target()
Thread-Topic: [PATCH] scsi: ufs: uninitialized variable in
 ufshcd_devfreq_target()
Thread-Index: AQHaXqe1EVIPo+NsAkiNEG3WvZB5h7EK6VcA
Date: Thu, 15 Feb 2024 05:53:40 +0000
Message-ID: <c83762bcdafd9547f73ffd998adcd2bb338bbe05.camel@mediatek.com>
References: <c787d37f-1107-4512-8991-bccf80e74a35@moroto.mountain>
In-Reply-To: <c787d37f-1107-4512-8991-bccf80e74a35@moroto.mountain>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5605:EE_|SEZPR03MB8268:EE_
x-ms-office365-filtering-correlation-id: 7371dc29-d8a7-439d-639a-08dc2dea7633
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R6KQdfZYgSlMYgbP2tcMwgPj1oQ+bMwMZWOnf0ZpzqY00dufxtjNJTRxuepiJ5svmcGyZDCHVHCHk/t6M3thc5ldfCd6RcRnipgXLdg1+8shmQ9+1bqcPUgNWaOHjALBRY0MO6mEcqFkClp7dzAwovo9Z7XnI4s3nlJPXjFD0KQEl601Ystg6Llu9DiT7jYLQqTKVXWNqwFnXMKEPRlsFwDuF5pPzrpeR/m+VGKEaLkwWXfICc5hFLT70MoDZDk7jYJApSQMOlRxUEGJ5XOhoTdODvUsBl6sFevuo05+QWkZFF+QmQeoeS3frDuv+7ERNK2f9zy/gO38p93NNZR8ttfJo174vsa70J79puf8awe2ParcPF6D5NzkOHfwHcWbqtwECq3/OO2RL2nxAqlrFpbrOH3vHndnjE65GKMM7B1XabEKaCXS+CI/e87ynP3U4yU9zmEo5davsXl4D+2Fui6FzQo9SDSmDqFwtSacgUG3LCzKh9/ifajSRRcnYfVbCuqBziCVbhVJlUN91dg1xXr/hHpDc49jEtmgoMl3M+lnssazjjSui4e5Vo5A6GhlhjrWJL1g7HuwaJF7X7trDmjKPlorMYsixOgHTY02I9vT2pL2phjjpYt9LMU0uxD2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5605.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(396003)(366004)(136003)(230922051799003)(230273577357003)(64100799003)(451199024)(186009)(1800799012)(71200400001)(6512007)(6486002)(478600001)(41300700001)(5660300002)(2906002)(4326008)(8936002)(8676002)(7416002)(4744005)(6506007)(316002)(6916009)(66946007)(76116006)(66446008)(66476007)(64756008)(66556008)(54906003)(2616005)(83380400001)(86362001)(38070700009)(26005)(38100700002)(122000001)(85182001)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d2diajNqV0pTakEwMXBLNldKZUJlbTNHcFVuVHRENksrWmwzWnJYd1FDK2ZG?=
 =?utf-8?B?aDlnQTdVWHJhTmtsQjlTVUlodlpVQmZ3Z1I3U0loRnJXYmcwcjliOXY1YkRp?=
 =?utf-8?B?bEZJc1JTRWdEKzY0TldzUE1jMlh6b3V2S0FkUkZReVdKYWtrM2RmQ0o0WSt4?=
 =?utf-8?B?Rm91Qkk2emMvVVhuR1UzbGw0dWJwcWc5Q09hRmgxRlgvRU1LMVFXT1J4MkhG?=
 =?utf-8?B?K3UxRzdtdmtSTE1DU0M4SUhrR0Z4dGlQZjVJWjh3eXZXTWlQNGxFMlplT1JV?=
 =?utf-8?B?N1B2OFNsS3d4QUNUeXhCcm8vbGRvc2Y2OUVUZHU5SFJFTDQ2T0g2RUljcHdM?=
 =?utf-8?B?OVo4OTU0TjVNNXVMOHpFd3R6U2d5dDd5L3R3bk5iU3h0aHBJN0JaSEQ4TWta?=
 =?utf-8?B?TmRBZXpVZ0s4WkNFY01WdVQ5Yzg1OTl1TEx4Y2JxcXFjYzdiTjVHQUdCcUQ5?=
 =?utf-8?B?WU9IQW45WEI1TUhFMjRFcTBIZG1CNDk4Wm4zUGFlTzRDUkpUakpPazl1bGlu?=
 =?utf-8?B?K3JDTnVJbzZXRkhPdWNhaVFiUmJkaEZaTEkzWmZURkc1ZCt2U2NsSE9RN2JZ?=
 =?utf-8?B?ckVOc0xFVXUrTXFuSGpoSU9taUFuNjVUc2tWeDJtWG4zRmxTaFNRMDJFYWNw?=
 =?utf-8?B?bnYwTFhsVUVxbnJrMVRKcG5qNTZaMXR3U29uWlRISzlhWmJYeEpiZ1F2WWxr?=
 =?utf-8?B?SUFIa1owVkVKLzVCcVJiY0k3VGVQWWdQc1htRXZ1N2UvZXBScDJHT1FpWnFi?=
 =?utf-8?B?SDBkZUw2cG05MzN3djBpbkZjYUdiVVFRMmNOTHZqaVVTcEJ3cGlaRUc2ZUs0?=
 =?utf-8?B?MGF0cEFxQjFlMUNUWUVHK2ViMjJMRWF6MXZkTFZnVDlGMEw3OThER1JCKzIx?=
 =?utf-8?B?U29HL0lZUlVvZEZCM2EyUWlrSHZ4YklJMUdkTFQ4RC9JMGEzbXhLaDgrTnZ3?=
 =?utf-8?B?Y0dOMkl2WVl2MmM1ZHNFNzlodTRqSjk0RVpQOUVLWGNiQUNSRnlkTjBMaXlR?=
 =?utf-8?B?T1U0bXJsRXRDaFpNd2V6WnhlU1IzZFViMElDODdWZ2UyK3V4TFFPRzN0dkdE?=
 =?utf-8?B?aFUyR0hlSjJwU0JRdmpmQUJEcXBjUDZ6NWROaUZjaDNuTmE2QUkyTUdkWCtH?=
 =?utf-8?B?c1BGbXRFZVZMdXVNVCt4L09KaU00NFV1dlVSNm1DRzJsb2hDY1JTRHA0dHo2?=
 =?utf-8?B?L1ZzeUVva1J6N2ZiNFg5V2VlRy9Ob0FDSEhoSFYrQm9Xcms3ckZzZ0RLUDNu?=
 =?utf-8?B?eUczTmkwY0RwWkVVc2NnN3NaK3V5N3FoaThjYS9NNVhVUlA0OS9LUFpkd2NK?=
 =?utf-8?B?VnFLT3ByWGNxZjAzbTZJOVFYMXVDWEkxN1I0M0t4VlgvS1IzRUtyZ3ZydmF5?=
 =?utf-8?B?NUJGRHRLdlJYY1hJOC9SaG1DZnpKY2NrbnRNU2kybFozWnpSYWk3TUgrUEM0?=
 =?utf-8?B?Wk1zeitHNkZ4YU4wcHNtaGJIQ0NMcHR4WkJZT0FQalEzQU9FMUgyK2JPL1NI?=
 =?utf-8?B?dWRoeE0vZFhmdnAvWG9OUWxnb1hxVXJLK2FQOTl6azJtN1doQUdEWE5DOHBU?=
 =?utf-8?B?ejJuS1VTZFFjSUZRWlVVME1veUMyL09EMnAvdmhHQkRqaHU2Ti9HbXVFREYw?=
 =?utf-8?B?NDhZQUVyNjdsK0dGSnZjeGFCVzM5UzJVWGgydER6eFBPZjF1bzE0TlhDaFRl?=
 =?utf-8?B?Y3N0RWttRU5wQkZLUUJJblJKRGJmdUVZS3hzQ01na0FWM2k0SU1QcmxnL3J5?=
 =?utf-8?B?cUFkRDd5Z2w4NmFDS09UVTl3dk5xZ1BxWEZ6Z3JjQ201ck03NHRHYmlyQlEv?=
 =?utf-8?B?b1NnQUkyTXMvYkhMYnhsRVBUQXg2bG9PRVhsK2xteHlKK0lBbWwyUnpqTXlj?=
 =?utf-8?B?aHhXTVJaeERnTFNPbDMvRmpXazhoN2JZYjZPUGpMN0xDbmxjSGlXdlp1amY2?=
 =?utf-8?B?c2orZUQwUllhaTRwVFp4VkhhWjAyUDNkYTlibDhhZ0NTenFKSFJWelZHTG1k?=
 =?utf-8?B?VG5ZQjZsZWc2dTltTjJ4dGQvZVRya2I1SEh4WWpsWTFyUm1IbXJkYUJoY0l3?=
 =?utf-8?B?dUtGWk01UDJJSDNTS3ZibllzK0dUTi9yMHp2c0tkV09rbGpuTjNWV0duVnNO?=
 =?utf-8?B?Z2JCWktlQXpCQVVjTWFmbEx5YlA0WktCQ3BMTHlTK002YzhzVk5sNmt6VG5Z?=
 =?utf-8?B?R0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C72BF31D840EF418E01DFFE61ADBB5F@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5605.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7371dc29-d8a7-439d-639a-08dc2dea7633
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2024 05:53:40.8107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +qRZYBJmfQCJDP/ljKNiSZZta86ksEb4qgRdrrGMBK1muYBHkXVOMXXxkJyRdFKebP3rzVgSYBqh5W85ExXbxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8268
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--9.640400-8.000000
X-TMASE-MatchedRID: h20DFeLkM8/UL3YCMmnG4ia1MaKuob8PCJpCCsn6HCHBnyal/eRn3gzR
	CsGHURLuwpcJm2NYlPAF6GY0Fb6yCth8848Kmd8CNCWPXerN72kZKp0SZ4P+dZiiJ0OtYmgDrhO
	hST9pKbUbTjFqSkJMGUoy5WLoLWsKQv21zJNl0CyDGx/OQ1GV8mO2yVLTADmtZsCGLUmGln7kwj
	HXXC/4I8prJP8FBOIarSdZzh8cl04aL/xhC4tRptowI+YzA3CqDLcBV853TvWineIA8mOfKsC+k
	sT6a9fy
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--9.640400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	520A2387E8B2D5C1665ECBBE1B85B25F215CF9344C9DB5995A8D7477B94C0C8F2000:8
X-MTK: N

T24gVHVlLCAyMDI0LTAyLTEzIGF0IDIxOjA4ICswMzAwLCBEYW4gQ2FycGVudGVyIHdyb3RlOg0K
PiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9w
ZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0
aGUgY29udGVudC4NCj4gIFRoZXJlIGlzIG9uZSBnb3RvIHdoZXJlICJzY2hlZF9jbGtfc2NhbGlu
Z19zdXNwZW5kX3dvcmsiIGlzIHRydWUgYnV0DQo+ICJzY2FsZV91cCIgaXMgdW5pbml0aWFsaXpl
ZC4gIEl0IGxlYWRzIHRvIGEgU21hdGNoIHVuaW5pdGlhbGl6ZWQNCj4gdmFyaWFibGUNCj4gd2Fy
bmluZzoNCj4gDQo+IGRyaXZlcnMvdWZzL2NvcmUvdWZzaGNkLmM6MTU4OSB1ZnNoY2RfZGV2ZnJl
cV90YXJnZXQoKSBlcnJvcjoNCj4gdW5pbml0aWFsaXplZCBzeW1ib2wgJ3NjYWxlX3VwJy4NCj4g
DQo+IEZpeGVzOiAxZDk2OTczMWI4N2YgKCJzY3NpOiB1ZnM6IGNvcmU6IE9ubHkgc3VzcGVuZCBj
bG9jayBzY2FsaW5nIGlmDQo+IHNjYWxpbmcgZG93biIpDQo+IFNpZ25lZC1vZmYtYnk6IERhbiBD
YXJwZW50ZXIgPGRhbi5jYXJwZW50ZXJAbGluYXJvLm9yZz4NCj4gDQoNClJldmlld2VkLWJ5OiBQ
ZXRlciBXYW5nIDxwZXRlci53YW5nQG1lZGlhdGVrLmNvbT4NCg0K

