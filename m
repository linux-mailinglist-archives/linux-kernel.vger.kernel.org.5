Return-Path: <linux-kernel+bounces-98771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83144877F1E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0CCC1F21DE8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0CE3B79F;
	Mon, 11 Mar 2024 11:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="imLa5gJs"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726363BBC6;
	Mon, 11 Mar 2024 11:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710157001; cv=fail; b=T98KfZSLBE69C5ycESJcgL0EXB3fxEgIlA1ZQaGWaEjjwFm5+IUvU8Viscf1dSOYlmmbdD3yl/+4lAkEEV83nOXTWqcz2Z0v2YpKBnvA8WqKCUv/IthgIbRAt8rTkszk8i+UgZeGQ4j5Xh58DnDPqheo8T4P4VJJt20xc8oyB3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710157001; c=relaxed/simple;
	bh=m8QgQTmDegO8An9xir5Hw21repN4MGRNVrVh/0V1Gcg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kkqTbXizqipli/wX/VsdGbCtbXifTVYEn39M/ELTVQm1wwWGNzBUJ/uaeSRqxdBZm71MmEUkHGz3KFf8X2/p0t2R9OwYlpx7IQ/ZfbFxcRzpZHgcAia2IpaLOEIgfYWl/Kxfj29IgN9DN5ynIursHpHUFSkyFLZALpG+rU9wB/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=imLa5gJs; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42B9mVmJ015527;
	Mon, 11 Mar 2024 04:36:17 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3wsynb097j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 04:36:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EwYYGcVkpCvv/t12tytAWZ5vHjdwpaIz3WijTZq7uGf8tLFGrsmi3QV2Pe6wU/K0rxvWNTiN3U3coS8xfdlwiqAQzF0xDMYeTM2Mv1LZO1K6D6Dff4BVYWBTpSEUeDNMrCyfly2RexVk3WBZPlsR5g9AAYw3vSHxMacGB9o9InVyPq7dVNSzCyvE8Y9vSub+xkXIgCHlU9nqfegmiOPoGTIpXFGplUyifex3+5mbQSySi4dqCx0/TcretOtwGI0URFiqY2Zk7lijNxRNyrIYUilsQybPBFlCly2LRKaZqtqUy/qbuPyEtHJm2tuq7EJx9/3Af7MG/UB3XCCRM1OvsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m8QgQTmDegO8An9xir5Hw21repN4MGRNVrVh/0V1Gcg=;
 b=h2+Y1d8BASjqvxGRHJGrndZ2Xi2qKrCqFvZb1n1yba6SFGQ59dpVX2N4WvTON1M0+3als+RUhzUBcM336NpayT2bkqjuku3CcH7QyqD4ETD3ePtUHEdivypfFZ+8wDmirj1wh1Wz5gBaRW1ZhJZIZs6VcfeKCHf1cD2JUGjrgDv9JhU7Kpyb421MumhoFQyimH/Q7pDrXJud6Z2NMiAsCNq0D+B82bDRBO74BIVHrjNd607CmOl1wq0JnL+KYFFp31cEDUIAm1N3zU8jBHYGlpsK8mJRbIe6DRJEtixtbGxe8pIG0VBGmSwjbf6HPudmJnrjqT3qHfmXM9lTmHppsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m8QgQTmDegO8An9xir5Hw21repN4MGRNVrVh/0V1Gcg=;
 b=imLa5gJsFmqICdhOZi8WXLSa+qryl50sM5eecrUGOsQx9f1v1PgFC1PM0aU0GkdfWG7xqAw1W25ZCrLBP6J7OCvQKMiMa6PJQ0+8y8rXeeRWr+doqxJGvlnOJZ3BcGukIUlqPSajnb1EIth+UjrxyqGVJ67FrArX7ksRzzw5nh0=
Received: from CO1PR18MB4666.namprd18.prod.outlook.com (2603:10b6:303:e5::24)
 by PH0PR18MB4972.namprd18.prod.outlook.com (2603:10b6:510:11f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 11:36:14 +0000
Received: from CO1PR18MB4666.namprd18.prod.outlook.com
 ([fe80::5087:a566:c473:1fef]) by CO1PR18MB4666.namprd18.prod.outlook.com
 ([fe80::5087:a566:c473:1fef%7]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 11:36:14 +0000
From: Subbaraya Sundeep Bhatta <sbhatta@marvell.com>
To: Breno Leitao <leitao@debian.org>, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo
 Abeni <pabeni@redhat.com>
CC: "keescook@chromium.org" <keescook@chromium.org>,
        Ido Schimmel
	<idosch@nvidia.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Amit Cohen
	<amcohen@nvidia.com>, Petr Machata <petrm@nvidia.com>,
        Jiri Benc
	<jbenc@redhat.com>, Beniamino Galvani <b.galvani@gmail.com>,
        Gavin Li
	<gavinl@nvidia.com>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH net-next 2/2] vxlan: Remove generic
 .ndo_get_stats64
Thread-Topic: [EXTERNAL] [PATCH net-next 2/2] vxlan: Remove generic
 .ndo_get_stats64
Thread-Index: AQHac6bXZtyIJKjPJ0W06FQgEfQfJbEyaStg
Date: Mon, 11 Mar 2024 11:36:14 +0000
Message-ID: 
 <CO1PR18MB4666DBAAE72E169E647528FDA1242@CO1PR18MB4666.namprd18.prod.outlook.com>
References: <20240311112437.3813987-1-leitao@debian.org>
 <20240311112437.3813987-2-leitao@debian.org>
In-Reply-To: <20240311112437.3813987-2-leitao@debian.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR18MB4666:EE_|PH0PR18MB4972:EE_
x-ms-office365-filtering-correlation-id: 271d2dfa-6371-4ee4-40b1-08dc41bf7564
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 4yp5E0s7QvUbFueAIxtEJNGeDnelDYaE9rEzNvRWVAxwR4yRNpkiYGxXHqr9RipARti4CyI5CBVNclTsUQrIxlopLJoRzhsCPGUCnkrZ96+ojieNB0reVtmibCl7MbdiXHLI6X29Pc3r50xOe7ic4KSTKUEPUPtUcZcEYSR9PjoC6IKQy9/8KmuXAPEEACvlvY3B47nddWXkC3KZOEWv+mW7bkQ6a5xpO6JDZABTnKMZxp0TNQV0e0QKXaMWxI5dYC6FXSDcnlrR8+3ruPkllxt2Jp+7OtIYXwE7XKvdbu73xmDuTxC20aPLVbgBDFfhjzY7j0+8XTBfNjlwZvH1OawqgjYwDk6/rLJYwlSaSRgtj003o2Uo6J5v+r2C+1RtBn2CwSpcp8vJVX44SyLvXvMxr+QLItlGdsZ7Z2QoeigF4A1x0jz1BzxarBX9Ax/HXNYgRL9K6Ou+tBXR02onFjt+I3KIwTk6RZf+JILNXWzIZZ093SdNTX2DVnhpKvUGQ72z+Op0AjUK854JmTz5P88OF2DeSfb1+zzZKkHKlOwULKVG9Dou4NgmPm2F6wPkTi2kmFHLyrPViRCVxBrmZr9EQiI7wo0Hn93F3WKXqLbv6nE4w6bT9Mab3alnisTjq9Mdq3suQ60pUDPf3WbW354Ec1b+U/L45q82P0iROCMi9FZwDMa7thfgW3HiXnG//THWJ2H4AFKzeE6Yn1kBOFS5AEO52jKSe9u33rp82Fg=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR18MB4666.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?iCftmHzvf3AWdeQA+/L1XTzeIEYJLpvtgWS2ooIy05B+iMvCTcuiE3ytfTu2?=
 =?us-ascii?Q?50LGqFd+XbLsRqq+9Nzl8KtZRITiYgeCEXBZCz21lRoTgE3pHcoVjiak9ut/?=
 =?us-ascii?Q?xXRH/tpjPA3qBzobj92bcU0vQdrn4ZHOq6mp1x+LSAl8rXPsUmB+xxRBuoRn?=
 =?us-ascii?Q?d77OVQPgPieZcVXr5CP0lEMTTiA67JNAq2wKeVesLBh+NrQa45tbnfySVhIo?=
 =?us-ascii?Q?8MStPeI1GSwBR9CZklTNHVTYO0xNtotyFeeS2np/Q2tDymuo9ird4s1GwTuX?=
 =?us-ascii?Q?hhOyo1nkSa9V3qJhDvloSC/ezH07V/ad92oko66tuYAjv28wZIBxWO8CeRVJ?=
 =?us-ascii?Q?uInC4BrlturOufxG86wH2hW04sqmdhi2kAymoeVRh2+08sNlMhlXIeMthvrW?=
 =?us-ascii?Q?LYvvroRdufB8q3teee+gcV2/OgP5Z3ZBDzE/H53muw4mULkNrH2mYz+a33kd?=
 =?us-ascii?Q?ROgg+OxViKiPXgPk03GS8peVEUuAozcevJiNp8rKEwF47HUAHDFw8NLsZp8n?=
 =?us-ascii?Q?Ht31VflsWd8d+3fUB8wfq97RQp6PMFp2fVhVaaNxnyMcXNi3ax4QsDni5RnP?=
 =?us-ascii?Q?2buKmoCM514ZHHoLy9DHBqyt4F9Ob3A51tmoKt8rXOfXqLWn7A6RluXZq1+K?=
 =?us-ascii?Q?DLpK7PjLuHVv23h/K0YDPkWAyMsfcF4QvTCrsuTHC5wB55P0gLPg+1hODxm5?=
 =?us-ascii?Q?7zOapbeiIzvcwj5yAItgnurVZ802nRb1S9VqL0EsorVLqROB6EvrR1t5ULNl?=
 =?us-ascii?Q?ALM2VCmaC0X/Zlv8XYxo1rvr5bazP0cYY/44EOZNjkceXksRtscET+GbEG/t?=
 =?us-ascii?Q?P/w3WKRPW2oMnkcFrdbiDpmKtFeA9M91jyqEqsB+qeKZ4UaIV4sPGfVBtwy+?=
 =?us-ascii?Q?ZFU/bao7K/fB6/CljfWWOB/zdR+UAOUcPiOHaWMXN1Cmzo2Omm9zrojpjd8j?=
 =?us-ascii?Q?DlDYpJ23ogi0gFIjEUsM2vBP2eqRAMvA6QApZMcEGmNuI0Eyyd0ca8Hd4RHh?=
 =?us-ascii?Q?014ztTe4Wvr28m9giEicQBnldRTj0MbMw82eo7wkkjMcrU2KrwrUvZhfd/Th?=
 =?us-ascii?Q?W6VTE8CZisnvLDTX1heR7TAVy51OyvAX3oIXORBq0xPj02QKNmGXMxLEdScr?=
 =?us-ascii?Q?DgfQ5G2a+AmOkP4/b78P2lpWhByzOcKqP2S5VTrf6bbrTfvbR2ECksrJtl6f?=
 =?us-ascii?Q?eM6W5FITU2oYqWeV2L1Hc6Xlk2ZwDp442xhCRNUqHLIP9VqQ1dHxPH+hGkkH?=
 =?us-ascii?Q?Rly+DrDgacKnRKsq+ADvHWWhTPJK7HIQVjtN9DWp4sLSljJz3hnclXPinaST?=
 =?us-ascii?Q?MKmMfN2IoJhLo9xtni1UqX4oaf3IOZQeBmlGZNZ7jOcrK9lz11/My1HfJuKM?=
 =?us-ascii?Q?9y1yY8LW+5ZUyn/wNZE94WoYgntDyH7h2Zhk6Yocm4B+2rD2+u9qt4SdmZgQ?=
 =?us-ascii?Q?Y7YTO2jlRQ0jGID3g9o4n+sixwRsft1ImmUb8z6+8LmGQNMcmzQ0eY+fq8gW?=
 =?us-ascii?Q?sLZNZHLXWqr8mRzDGiL65vlpVmvI7nNvomoqBMqZr4+vI7n1lb0YF5uk4lVc?=
 =?us-ascii?Q?iQkglbP621uG8brmKEPgTBOC4zuwjD5BqpDQm4rr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR18MB4666.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 271d2dfa-6371-4ee4-40b1-08dc41bf7564
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2024 11:36:14.3306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c6tlo/qbDGRhqTAAyWZ+ljaiJm9QihZvOoB4dYj9cdecQZARchYqrZWqRobP6HflncHCa0ftZfm50A6cXCrZJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB4972
X-Proofpoint-GUID: feAOewRNjEg4GUsbYZUUe8i7ZUqLcczQ
X-Proofpoint-ORIG-GUID: feAOewRNjEg4GUsbYZUUe8i7ZUqLcczQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_08,2024-03-06_01,2023-05-22_02



>-----Original Message-----
>From: Breno Leitao <leitao@debian.org>
>Sent: Monday, March 11, 2024 4:55 PM
>To: David S. Miller <davem@davemloft.net>; Eric Dumazet
><edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
><pabeni@redhat.com>
>Cc: keescook@chromium.org; Ido Schimmel <idosch@nvidia.com>; Nikolay
>Aleksandrov <razor@blackwall.org>; Amit Cohen <amcohen@nvidia.com>; Petr
>Machata <petrm@nvidia.com>; Jiri Benc <jbenc@redhat.com>; Beniamino
>Galvani <b.galvani@gmail.com>; Gavin Li <gavinl@nvidia.com>; open
>list:NETWORKING DRIVERS <netdev@vger.kernel.org>; open list <linux-
>kernel@vger.kernel.org>
>Subject: [EXTERNAL] [PATCH net-next 2/2] vxlan: Remove generic
>.ndo_get_stats64
>
>Commit 3e2f544dd8a33 ("net: get stats64 if device if driver is
>configured") moved the callback to dev_get_tstats64() to net core, so,
>unless the driver is doing some custom stats collection, it does not
>need to set .ndo_get_stats64.
>
>Since this driver is now relying in NETDEV_PCPU_STAT_TSTATS, then, it
>doesn't need to set the dev_get_tstats64() generic .ndo_get_stats64
>function pointer.
>
>Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Subbaraya Sundeep <sbhatta@marvell.com>
..

