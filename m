Return-Path: <linux-kernel+bounces-67556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A53856D6C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6FD3B2387C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BAC13957E;
	Thu, 15 Feb 2024 19:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VhUx9xu5"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791BF139564;
	Thu, 15 Feb 2024 19:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708024365; cv=fail; b=pRKaxGh3sjV4iG683hKrAPDmDemVDmPjvPkR1ugcAEdJLgjnmBkxg/oaWV4+esjCLpOqWKv6ZoCHhM+leeFjU/YOP7eJuO4WAAvE+L+xq+tDk1PhaFFEqiE4Hgyjr68eKDKmRuEvZGqhF6ojoVZLLPF+L8moBAAHYkFtD/bYJYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708024365; c=relaxed/simple;
	bh=TXT/HWcYyXxoPzhkL+yrdXgI4ayP+9PRmKNXfysZfrc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FU2542H1ZBsKiwe7lsKVh2fsyhF02ObMA3WAbISe9YOLQwjKHw/tZhvpwuX/linyogCsVoHGPmK6WfrYz82pZSydGiULFUBcrp8UMW2Ko7w1OKgXEBsjjDTUUl0hr+fKouw8pWr8YK2dNbB34mo05ofj+4ARdbR0Mia0T9VZx1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VhUx9xu5; arc=fail smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41FG3VMH002327;
	Thu, 15 Feb 2024 19:12:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	qcppdkim1; bh=ZC23+fuw6s3zocA84cnn5pvExH3Tc9Jq0/3y+LxN/Ew=; b=Vh
	Ux9xu5Y4FOrea1SuAE/qx9X656+P74wn8kZSdGaTAMJlJMotlvtkY8sIT1Z0zBgK
	7Lbky8+Xkh4xr1ChmhErxmKPc+FMFPkLX3ZxF60ArD00LaKxNnJ6kvDJSPc2tpIP
	9MAeuCmE6pB+Js62Pakb3q8gB3Z2ZZV9QM42crHIllk+VYKDbIZtVA99VSAdTkny
	7z56jGFUzXNcdKOfC68rcp8an1ocTta6in2XR5w6tCzxyA+0H4ysuiLqPDVOLdxg
	p6Rw/9iZ5iCTT6zeVyb27ODY52kKUIOKMCul9YKfnOuJQA7l5dSgHk/Nzm67+n/n
	8+pkQ0FG/Jtzsl6qr5rw==
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w96c3tnqq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 19:12:42 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=StVJDH9EY4BYPGxuXSES8EQ11keCDx/u/okF0fCBhZgqbuVF+uPTTjYL/lLRfFVX+Z4W78pnSwUBjA9iIUyl+pOI/9M8K4xichAcWID1KBh3twEj1YQHiA4JYODrmc93S3ewDNvl/UtE55SkPxBOGKFY24A/MDqtFnGkjCtHg3LSlLbbQ6W/APUwH1quvM1HQGznDqrFd3UBQZmQv3ljbwv1BtA0OS4AW2Y7zTTcnYdDIVtwCb/5iLmgPsIgfTnJxH0m0m3IvDPaO+bS2PfowkipRvB5T3h4umrriOk7OSR/321sfIKBQUQO4YwWnYz6lQvW7RWR1cOFULKwTl44xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZC23+fuw6s3zocA84cnn5pvExH3Tc9Jq0/3y+LxN/Ew=;
 b=Ebymtj/tl9PdpnU41d5mI9SFa1JIAxLZ3Xt58YY8VHFS2lKNUktoHskst2IjOF2lbMg+OYJTPlVjxvlNywWbKZzdTeIVte1jNvR8jonYcbG3a49/AFqY8ZGx73kSg3OWR+DnCbe46i/wmz2xDZJUbzGud5dkbbCJwdS3zxJrziFQ3Nw3zHB9pOMAPQcPuZO/77pODU3+EKQOCpj3hV/Kkks20Nbdz8RDdNBBoImSWmEYmRqhRuPmoPaW3HXzV+WdnAHExI4ODYaMaaOW5yVUfxzBq+q+zuEBND9EupiLEn9fp1xIqm3WdNBpOBKu7VKTcVnn9nqVsNB67PLsMaznVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from CH3PR02MB10247.namprd02.prod.outlook.com
 (2603:10b6:610:1c2::10) by CH3PR02MB9212.namprd02.prod.outlook.com
 (2603:10b6:610:14f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Thu, 15 Feb
 2024 19:12:38 +0000
Received: from CH3PR02MB10247.namprd02.prod.outlook.com
 ([fe80::aeb8:113f:f7ec:f9b2]) by CH3PR02MB10247.namprd02.prod.outlook.com
 ([fe80::aeb8:113f:f7ec:f9b2%7]) with mapi id 15.20.7292.029; Thu, 15 Feb 2024
 19:12:38 +0000
From: Brian Cain <bcain@quicinc.com>
To: Masahiro Yamada <masahiroy@kernel.org>,
        "linux-kbuild@vger.kernel.org"
	<linux-kbuild@vger.kernel.org>
CC: "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] hexagon: select FRAME_POINTER instead of redefining it
Thread-Topic: [PATCH] hexagon: select FRAME_POINTER instead of redefining it
Thread-Index: AQHaYBhjk5QXHtSJRECy3JJhSYFt/rELxaaQ
Date: Thu, 15 Feb 2024 19:12:38 +0000
Message-ID: 
 <CH3PR02MB102474087819FEC83FA6C08AEB84D2@CH3PR02MB10247.namprd02.prod.outlook.com>
References: <20240215140702.1910276-1-masahiroy@kernel.org>
In-Reply-To: <20240215140702.1910276-1-masahiroy@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR02MB10247:EE_|CH3PR02MB9212:EE_
x-ms-office365-filtering-correlation-id: 812d765b-8f1e-41a6-5062-08dc2e5a1314
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 atTZt37mriwhvdBBTHxkjBj+9Sl4ayv4JLguYkoM1D2knbGySNEMLu/fYdy25oRzaPir2uZ+o/okHtpA/p4h1uDUHIGz9z1W2vL3RrzEFkmM2MKVmZh4qJP4e8DXC3s6mUrV5BPvkz4/sB2TIpH7qwEHHv/f6c39cI8ebqQZJb4+0S2wAQwVxcVfkO7W1UhcLaDyI2M0RHVxIAcDpBgwnYQN3bt0+cS8oQrlIzbrr9tY1n3upxfJy7Oz7jJ2vpiQrr/Sq/yjOAxfCO9ua0r/m8WvviNv5PAeuY+K0l8xV2yjGwhZiLKlBJ/h28eAKuCQ14xnfVj+fU10ahChkbz8vTWrhBnZ0FiTvKIGjx0XBFa3EjbEzhr+gUPfRoD34gYRR5jixMbSJIAg1oJ7asfpHb68zJMLEo/qvc8KVZaaVR3Qy7r5CS+pNRlQx21UYoRvZ7Qnk9kiag2zxQmQcT4b23Lc0ZcsxGvIELN8FglAHn5NGRzwzxW6I5WNXQTcHY97AUBb6YOoxdpNPxdj6RnIZS/GpOZ5Mo4W7qynFpN5Qoc0BHUcUyLGVf4qM/UvtzQ1UTrzrglObcFvgBiCUVgPSPyIjQV5+NaHozg1R6jmuk5x6LmgauGY5Hwfa86psaN/
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR02MB10247.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(396003)(346002)(366004)(230922051799003)(230273577357003)(1800799012)(451199024)(64100799003)(186009)(53546011)(52536014)(2906002)(8936002)(4326008)(5660300002)(8676002)(7696005)(76116006)(66476007)(33656002)(83380400001)(122000001)(86362001)(38100700002)(6506007)(71200400001)(38070700009)(110136005)(66446008)(316002)(64756008)(66556008)(66946007)(54906003)(478600001)(9686003)(41300700001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?Z6TTiQxZT93Mdw2JBAa7Q+r8DSvtV43DCb36RanlRdXmhqI8QQW9AyPPAtfR?=
 =?us-ascii?Q?KILP8y5vQrsXTYQA+5k2IjrHE6AIYbOu5YWY0MR8dKzOu7n9FRbAM00wff2Z?=
 =?us-ascii?Q?9p6hRm8ytwmU7J2m2fm2H5tCG5RxNuIo12HYk38V5De0XYdEtXj+eBb8uNxE?=
 =?us-ascii?Q?xGLjjurLpEkNORAtAMUmJXKygp7UlZDwNF223BI50X2ihKWoV5b8gu399B3X?=
 =?us-ascii?Q?C5YZMB1TMF/wk9NaqcMIEg0gqfpZnJLi58rsHq1Ap2oh0vs+nSkN/gADX+kP?=
 =?us-ascii?Q?3gOPZ5JKjg2KqBwbNjLQVnMTu4+73owFr5FMxsRQoTdZLlXHruBOn+sO/srl?=
 =?us-ascii?Q?5olSJiUCBJ57oRy+L4QUNEg5oT6jTti5Fz9uT4J7rJwCIZel3nARo3FBPMrw?=
 =?us-ascii?Q?i5mzDgYue8BwFknQqbwG26Wl0YzKpciEmiz6CaXd9xLhQpuHLnmJtBkUD0rM?=
 =?us-ascii?Q?SIseCSLsm+9Yl40ZcPRGjr0ThZ1QRC31Wooqa6pD8qSIhutSRFXVp7cntG0p?=
 =?us-ascii?Q?KuPv7NuQKkk/yJB634kWJ8faqcn+K6kPHatBw6sC3Fx3bjL8Wt6QROjDQiMv?=
 =?us-ascii?Q?fDC13rOwst0Hw/2nFLa3aHni+4+uvuMmLOrbFU1nuETDwnQXrDCXxSh8YnEA?=
 =?us-ascii?Q?jSDkLc1eL1r/pD99kVIX1Sh/d7kejbHIlfwHVG+HFsVgOfgIrynHdUzrDWz0?=
 =?us-ascii?Q?RrzXoK7cEYiwkZRwVfcIGwSfc3ZvIVP1W1G25JziEuY/NAYVsRDTVEmwYkeD?=
 =?us-ascii?Q?Jc748O2G3tPSIE7SRC0tf8/VHXgh4G4xARDRp6L1yOF5AEUdAd1+VbGCcg3R?=
 =?us-ascii?Q?OzksnV2RhzltaVFM4qyJBYE0rxfk1FyTJku7nUw1MCi2FhngG+fYSEagXqzQ?=
 =?us-ascii?Q?Q8DXa4RXKw0iJMTJ6ikQtZqOrv5TfO7VZuIgAPfGjHV4jJigy4bKuYuIHLJz?=
 =?us-ascii?Q?UdpUPmztoZ3pWF5gZJY15gaypW/2YZVLzo3p7LDQJgIk6ZmX7olNPfmKUI8b?=
 =?us-ascii?Q?hJIU2AiceLdCt7n4tQenIp/wZ3mDBWvUyFuxXoomekc9rGCY873+FcIdDplX?=
 =?us-ascii?Q?uQ3KG8ILBVIMpg8POcaUJuYUnRxeLTZhLborjU/Q9LRZoMvToO2hcSgdJYzH?=
 =?us-ascii?Q?ZMu6Y37DV5xMdbpouaEDHl9FuNGdJUcfOJ3kOD+Oc6uHpjaR69fVT9V4wh3G?=
 =?us-ascii?Q?wH2tsgCVzEE6ubXIrgWr+eZB/iwj8ashWZa7GNHbwxfqfbxeTrYtCSzBvPlV?=
 =?us-ascii?Q?f3msihEz4ktmxPZoiE26QmUrnpaqkaTpjoDZ7EtgPCaDLuw6X3Swp/IPNWKg?=
 =?us-ascii?Q?Xa+ULZUgxMrJ3t/CfUAI8bcX7w4ZcFIX4Fwy6kYe7ZmnekRmwBmrkGlqFXZk?=
 =?us-ascii?Q?rSb6WeIw9ZU4R2wXg6hIyLm+tzNTC/pwTi4PVyCyySUpcUHXkHuwUhBBI/An?=
 =?us-ascii?Q?9y+sHZ8raAhWz8rREdvnB4X8jWwWRYAc0OXgKMePD79vWLy6pFblXOpzMrg5?=
 =?us-ascii?Q?d+BDhJ58PqMI9BiuGDxxfAxv2p5LknIXXfrdAeBEWwdZ0v/v+pEu+MdkO8rJ?=
 =?us-ascii?Q?z6bOX9Tw0Qt20U827y5Kc3riRh1UOGip6HtGa5ZrEf6li/DdhovGTXb3ywgF?=
 =?us-ascii?Q?wxtXqpLlgRDnSMqPpMotHT0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	tMnFUgltFDZXYrar6GTtsTTD3pO94uK1xyS8+12Y2XJa+4595lDxntBUgsTVq7ApczyX3o7P9zYTdULbsdiiiHIwlpR/CNvQ2LJZ1FDG2Uj2yACjMds+GyRnJYAOw24SsKAUo7DkwvZ+Ovk8oKsGvuXhVakUHl9OQKnEnMSUez3O3SpmBcQ4vDFaNhW2gT6KQ126VXI5UX3uFp2yCVMCt+B16e4aZmPBpn6XGCsiv4iklg2zlsCAu27nb8xvBrD5t67B6jJ3aS6Z8THJwwN9dDLGXKWnIaf+t1EfotIiftzjSMKfi0llHdAPxnOLeWFIpj8ZqxBpzhoDq8pMaD9WTEj/hGwHY7xKlpSkNEKIuQzA/26A2l8lQnNreXbhWDyhM5qrVYv91k2K5Rdc1Y55pGxYzrmGI1QPExQGH4aPzrv/7m5irBg7i1CMZ9H+xInZSL8bLliIUXkNdC6o3II9k/guPpBWfPxN536A+X/DuD2a5QAUUX8K5MSTKePJCJtSFIksfmszHhAuo4Hf6KKMD8q8/R34aQQfoQi8Zp73VU1XRnNPJjsYHV5jY7MindQH6xZ87My3e/AsxB0zjDqLdcoaRddChw/rFEqib4/mc0pefFIFRVatXE/hC/X2Zppa
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR02MB10247.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 812d765b-8f1e-41a6-5062-08dc2e5a1314
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2024 19:12:38.1625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3Vj+YxpbCbTDVUWN5ruX7WGBKSEPc6TvicszoATGOhWR/C1EIJafXlUhhv+2ak1vJk1AnskLILrMo3mp0ExQ3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9212
X-Proofpoint-ORIG-GUID: depU6vlbniuiam8OYXPgcviZESWQY9WH
X-Proofpoint-GUID: depU6vlbniuiam8OYXPgcviZESWQY9WH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_18,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 impostorscore=0 adultscore=0 mlxscore=0 mlxlogscore=595 malwarescore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402150154



> -----Original Message-----
> From: Masahiro Yamada <masahiroy@kernel.org>
> Sent: Thursday, February 15, 2024 8:07 AM
> To: linux-kbuild@vger.kernel.org
> Cc: Masahiro Yamada <masahiroy@kernel.org>; Brian Cain
> <bcain@quicinc.com>; linux-hexagon@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH] hexagon: select FRAME_POINTER instead of redefining it
>=20
> WARNING: This email originated from outside of Qualcomm. Please be wary o=
f
> any links or attachments, and do not enable macros.
>=20
> Because FRAME_POINTER is defined in lib/Kconfig.debug, the arch Kconfig
> should select it.
>=20
> Add 'select FRAME_POINTER' to HEXAGON. ARCH_WANT_FRAME_POINTERS
> must
> also be selected to avoid the unmet dependency warning.
>=20
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>=20
>  arch/hexagon/Kconfig | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
> index a880ee067d2e..e922026fef09 100644
> --- a/arch/hexagon/Kconfig
> +++ b/arch/hexagon/Kconfig
> @@ -7,7 +7,9 @@ config HEXAGON
>         select ARCH_32BIT_OFF_T
>         select ARCH_HAS_SYNC_DMA_FOR_DEVICE
>         select ARCH_NO_PREEMPT
> +       select ARCH_WANT_FRAME_POINTERS
>         select DMA_GLOBAL_POOL
> +       select FRAME_POINTER
>         # Other pending projects/to-do items.
>         # select HAVE_REGS_AND_STACK_ACCESS_API
>         # select HAVE_HW_BREAKPOINT if PERF_EVENTS
> @@ -43,9 +45,6 @@ config HEXAGON_PHYS_OFFSET
>         help
>           Platforms that don't load the kernel at zero set this.
>=20
> -config FRAME_POINTER
> -       def_bool y
> -
>  config LOCKDEP_SUPPORT
>         def_bool y
>=20
> --
> 2.40.1


Acked-by: Brian Cain <bcain@quicinc.com>

