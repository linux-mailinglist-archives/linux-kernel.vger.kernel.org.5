Return-Path: <linux-kernel+bounces-98726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36807877E73
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EFDBB21A29
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4768B383A5;
	Mon, 11 Mar 2024 10:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b="MIsB2fA5"
Received: from SE2P216CU007.outbound.protection.outlook.com (mail-koreacentralazon11020002.outbound.protection.outlook.com [52.101.154.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F652EB08;
	Mon, 11 Mar 2024 10:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.154.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710154597; cv=fail; b=j+H/1YG3sYVzVSfE/1ZYPc0djGtjRuJirhLDFHq48dWMjqSabXus87Wn1xyx3NodJN4/sAlr3H4353UQz2/SqMcCPVoACO05sjCPzHluRQ0aDCbehB1k9y73/3yEhTVmdpcw/fZ812umDoDq3GZrxO9UEeJkbjanFRjwMZGPgCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710154597; c=relaxed/simple;
	bh=rel3W4jNfSelzleHRVuystkw0FojF3ZC1rDAHx5VVP0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Iu59L+t1ASDISEmuaNSdhV086N0fVBrafZ+dJ8zciK5NbwylDiqA63wLqRycdY7jUp6x+s2SKTAombfXGWthIcHqxAA/UhJXMpnVDvxSSsfPXBLoWVU8zB5HIeLJlxkgCA0k7ouAwQb1k5+YzE7sELC4oOtqTXuyE0sXNH6gw+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com; spf=pass smtp.mailfrom=chipsnmedia.com; dkim=pass (1024-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b=MIsB2fA5; arc=fail smtp.client-ip=52.101.154.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chipsnmedia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJ3hKMR+ZajDaJIyx2yhGtnRoH9sJhTxBNejCvdhaYPBtluUoO1bET7XjgIVUttdiuHsm+999CUIltLPqez99o9h/xlIeVQCYAmvmKwLpsjzFc0q/4jtFLLlYG78E/SGQvs4MItz8qcyP5lTMHziVhQG5aDcHnY9hdeh8+/CNIdrgud264mizXkRc7vSlPORh10ZmZYgWI1LXh/nZZcu/Pqoi/AkUEDAvUFEfGmr3dKooqfVAW9XfyTTlvJKm7f5Ie2BySuva4tdbdBjm8hQYkg6oowSwkqKly5wmdyM0U0m3csz301BABKjZvl4Jh465KCWXy+j/9PAOlel4Edosg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ddoMB4WxeS2Duf+6ZkNjPrXqWgXjqYHKeoADcB+9nYA=;
 b=d2Ma4iaSa1EOuCGogihW2SPhATgQ9wRJufPLAKZ04UiLitrA0TrJkwkmEoKeWTlH6IW5Gm0HFy9GnnibmPTMrJ3c5WLNaUq7ins6TKmOrJSoTbmz/IByVMBmj/eNP7ixHMYunVHcGx8wqgStmB9GTrPGxFwe5AWici3QyQhkvxpUH6WLPgMk6AxKkCfh+qRKpdIiN0KNTWUszz15PlRFVPo96/5m1SKC4+QQ1i9mwz6qiPLyuo/Jpvu39BDPbD7ejstBdneIiiXdejiM76XSFXT7xJKDBg7iMIU171z4LTJqxMVjXD53zX13Uqp+Pz0Dr5t76+mUS19AJ+mc209UpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chipsnmedia.com; dmarc=pass action=none
 header.from=chipsnmedia.com; dkim=pass header.d=chipsnmedia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chipsnmedia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddoMB4WxeS2Duf+6ZkNjPrXqWgXjqYHKeoADcB+9nYA=;
 b=MIsB2fA54Wi8C8MLe4cV6Mt9vHKCTKtHhjs+T08S0bPD7e85PVeZHhRHkKQRYcth/AuAMZ44R/ZJL1vr7VMw/rhAePbWRjtpFCnTpEh5/hg/3KcWzIhy5XK4AY4EfeJrTyseE3DuZ+hNnl2W7g6UirrumC26CSfvSU9Vij9d3Jo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chipsnmedia.com;
Received: from SE1P216MB1303.KORP216.PROD.OUTLOOK.COM (2603:1096:101:15::5) by
 SE1P216MB2024.KORP216.PROD.OUTLOOK.COM (2603:1096:101:15b::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.36; Mon, 11 Mar 2024 10:56:30 +0000
Received: from SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
 ([fe80::ebb8:2043:fd53:303a]) by SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
 ([fe80::ebb8:2043:fd53:303a%3]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 10:56:30 +0000
From: "jackson.lee" <jackson.lee@chipsnmedia.com>
To: mchehab@kernel.org,
	nicolas@ndufresne.ca,
	sebastian.fricke@collabora.com
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hverkuil@xs4all.nl,
	nas.chung@chipsnmedia.com,
	lafley.kim@chipsnmedia.com,
	b-brnich@ti.com,
	"Jackson.lee" <jackson.lee@chipsnmedia.com>
Subject: [RESEND PATCH v2 0/4] Add auto suspend/resume,YUV422 format,SPS/PPS generation for each IDR                   
Date: Mon, 11 Mar 2024 19:56:19 +0900
Message-Id: <20240311105623.20406-1-jackson.lee@chipsnmedia.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0127.KORP216.PROD.OUTLOOK.COM (2603:1096:101:1::6)
 To SE1P216MB1303.KORP216.PROD.OUTLOOK.COM (2603:1096:101:15::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE1P216MB1303:EE_|SE1P216MB2024:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ca91856-b412-48d7-b818-08dc41b9e86f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nCz4gtxChEsr/uzbFeM96kX10pOJpDXtCbio99tTFTNbAuRqDux8QRlKbTSlrZdjQaOtom0HEjMPkL3LleVqL/ySvA+bcCzPJmD5eggs5g8ihf57cHdRnhUKZe163VYmOS37mkUXxnGTJNHQ+PoryK1H8ziCMAoSX5RMGF4Jc4QUwn5vb8nQRbYusPoe04XKkSguBdxEniNq7TR6dQWEJPIagnZZ/zcpD8uFKhe41wLF8pDYB1+uRmKJOrK+Ne5RiRnC3WgP7XH3LQ6H+Egm6U6tjuEjYpNJxP0gKmiqsK+8y506WowrYHrYHZdDCtdgIHmYQRZtmToNBsdSOtNYJO1s3UqW1FP85xwWhQ5aJ47Eqvbk7roo4BdUZapEQ2VkWMm/kfI8soDsKRi+NuNCFBjIBXWs//4C6UMk0H6ETG1nIQH9SJv/CkYmVKd3qlljF1mdwfHPp9B6K+OVtgtp9JwqKhGyayTd+aS7pY7FxwBH8WJ21hCGlHkhvTV/DiQPeDe7omvXUqdTcMvfn4XyL23DzZeKNE5DViIiKSTGaRzxcwNu09GGUzD9LuWDRL5/6uriszSmXu6Pk1GO5XkIAmNJzYHnsY0uHY/mlmySHFxSwZhVH3Zvg96LVOUZ0KCtq+lXxvSbqil/4G0nRAe+dJG0nTOFvIPuw36K+HXuQNC+i/Vr+EiQ9ysR1ygaRJ9eRp/FoLSayqSm+TqbwRLqyBb/TVWBy963rkoI977WSUg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE1P216MB1303.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5URl2ho/TEk14BD0Cy9XzTErFlIFmKKJnOBVma1gMwLY2W2H+ysw1Vo1epJF?=
 =?us-ascii?Q?ah46zqQNatqNaFxoXrvyqdhtTlHwFLt3HDumsgPT3GrgGxPjTI1vLQLenfRQ?=
 =?us-ascii?Q?F+Wv81EGdEiaQnf0NBcHfsvHhaDEiyfhYvXlZhqIBr/bHzal7ziam+l80EaD?=
 =?us-ascii?Q?7T+l+zItYDzhh1f35twYfuFLo2Ud6D6ASWxkbYYVh4qNFZvC4mLRQFqm+yqw?=
 =?us-ascii?Q?GaReZww7t+U92UVF946I2Uu6m9zv4HSxx4Ebn30FCCBZCaWaXlNuMEEeiH02?=
 =?us-ascii?Q?HCYdkt7WZd1t2+bf+9ikaWFzdHHKF/MUYwpuxROfFyi5Ry1fgko1YcHdLotG?=
 =?us-ascii?Q?4rIdEhY71tcyW2Qa1pOWXwlIxpIhRD4IQihr2rPkN3Ny2RnqsLRscM5Bi3I+?=
 =?us-ascii?Q?xgqtlQx6qnKly5d7eejlZYDalD86M2+YlXXNYI0SblnVeLRRCs9OG3GJLsjn?=
 =?us-ascii?Q?rqXIQma68uRc7qC8Soog4aU9uY6UrV6dbVKlQUi07zIxg0fTwGWi0gSSEm6Z?=
 =?us-ascii?Q?lTmfCrM5PFlGrbwyyxKOD/Tifb8pUVnOpG/Ml3fjiZ1OoHo8YQTnTWxBG02P?=
 =?us-ascii?Q?AaLesv6D5HGJoEHTgJiu7LQ1qJ6vJ1mYvtMzY4P5xxmMAOtcGxD3eSu7O5eB?=
 =?us-ascii?Q?M9hpFXgawlKXdNVFesIT3NXTotWc4w1epcgcHmPBcABa75Llm3IYJK2sLMvB?=
 =?us-ascii?Q?7evT5ufxBVaI5fReXH3vLMg0xCqPI9LBReFOiyfo06y7g0FcG01jMmFLZekM?=
 =?us-ascii?Q?Sa2yoeKzISqqLFzmCFn3ie3qxcl81ESer4KdBwkBbOQMg9fPRfbD4aBNThbL?=
 =?us-ascii?Q?AmggukJ/s2voQq2Z1VZV0uu2FL3nvDqz31uRyqibwZcBlEU9okDPNbyAO1bm?=
 =?us-ascii?Q?6bjGZcSFDIyprBGEl0pEz50Vx6CMGcn7eW7KxO9gUKWZtksZt+Wp7GRBVBLs?=
 =?us-ascii?Q?cwFpPSf8UL1O11iYZJg40cp5+E3b0z/CvWojCxiTUVgHWR9vng/tUvuUi5fa?=
 =?us-ascii?Q?OaSqW6VHCLJ3Y2qvrI3eGgAvMLdl1ZznBnZFV2/mdQeGowZdyutaIFTGXJ2R?=
 =?us-ascii?Q?ieugu7hJw0Jrvp3KP6Z3Dq5pOD1mjcc6SkdZxmk+MCs9Xxz+AMHePd6cZ0Fv?=
 =?us-ascii?Q?eH/srsJDXcK8BihQIr/UVoMJ8HnR2wGyo9Gor2gPUM1cqtejHtzEJ9pURoB6?=
 =?us-ascii?Q?AtKEiW27rtnwHtitbsFY/yANF45TbEANoBbsJbedk6jfluuPpdygnF4yKlXc?=
 =?us-ascii?Q?rcUT8oQlrhchspCPhWcumuoTTUXEBiYClYtpREwOzesmqCnhuYmRtUHpeENw?=
 =?us-ascii?Q?eUUSQrmcpHoD7GUFT8BR0TapAqQ9rdhQxmh6cmX743rz+jA4bmUjNffJ3JuL?=
 =?us-ascii?Q?BI3+w0J8VT3yKcCCCrT4VjgZeIDX3yvFUmjIFZL9bjHarqqVh3HYgvND5Fol?=
 =?us-ascii?Q?ok5pbengqnxBdQvlFNHKTXFTZjL9mA0pNDzqxXDGAzb1nZ23a5F+YnqNu2LF?=
 =?us-ascii?Q?dviwtzcyWepEV4PCN9YgomhyNjnkUouocBgIq0Gi9Su3LClF0BuJ3xPmNpll?=
 =?us-ascii?Q?rMW9HCRSr0h1Wuel8nuKHiMj6uZydq3SVu2wBPq0d8tBTUHShW8KpHie0Psb?=
 =?us-ascii?Q?uw=3D=3D?=
X-OriginatorOrg: chipsnmedia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ca91856-b412-48d7-b818-08dc41b9e86f
X-MS-Exchange-CrossTenant-AuthSource: SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 10:56:30.5509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4d70c8e9-142b-4389-b7f2-fa8a3c68c467
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qdgfK8HF4V2RzhoLaBbp7EsPQpyZiMoRetZ4lOmVEnjZXzynGBeWCe/FGheLY47dwB/q8Tb6UM2NCQ8eO/l+zCOnZdhQuyi5Y/mI0YoKzpY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1P216MB2024

From: "Jackson.lee" <jackson.lee@chipsnmedia.com>

The wave5 codec driver is a stateful encoder/decoder.
The following patches is for supporting yuv422 inpuy format, supporting
runtime suspend/resume feature and extra things.

v4l2-compliance results:
========================

v4l2-compliance 1.24.1, 64 bits, 64-bit time_t

Buffer ioctls:
            warn: v4l2-test-buffers.cpp(693): VIDIOC_CREATE_BUFS not supported
            warn: v4l2-test-buffers.cpp(693): VIDIOC_CREATE_BUFS not supported
    test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
    test VIDIOC_EXPBUF: OK
    test Requests: OK (Not Supported)

Total for wave5-dec device /dev/video0: 45, Succeeded: 45, Failed: 0, Warnings: 2
Total for wave5-enc device /dev/video1: 45, Succeeded: 45, Failed: 0, Warnings: 0

Fluster test results:
=====================

Running test suite JCT-VC-HEVC_V1 with decoder GStreamer-H.265-V4L2-Gst1.0 Using 1 parallel job(s)
Ran 132/147 tests successfully               in 94.782 secs

(1 test fails because of not supporting to parse multi frames, 1 test fails because of a missing frame and slight corruption, 2 tests fail because of sizes which are incompatible with the IP, 11 tests fail because of unsupported 10 bit format)

Running test suite JVT-AVC_V1 with decoder GStreamer-H.264-V4L2-Gst1.0 Using 1 parallel job(s)
Ran 77/135 tests successfully               in 37.364 secs

(58 fail because the hardware is unable to decode  MBAFF / FMO / Field / Extended profile streams.)


Chnage since v1:
=================

* For [PATCH v2 0/4] media: chips-media: wave5: Support SPS/PPS generation for each IDR
 - define a macro for register addresses

* For [PATCH v2 1/4] media: chips-media: wave5: Support runtime suspend/resume
 - add auto suspend/resume

* For [PATCH v2 2/4] media: chips-media: wave5: Use helpers to calculate bytesperline and sizeimage
 - use helper functions to calculate bytesperline and sizeimage

* For [PATCH v2 3/4] media: chips-media: wave5: Support YUV422 raw pixel-formats on the encoder
 - remove unnecessary codes

Change since v0:
=================
The DEFAULT_SRC_SIZE macro was defined using multiple lines,
To make a simple define, tab and multiple lines has been removed,
The macro is defined using one line.

Jackson.lee (4):
  media: chips-media: wave5: Support SPS/PPS generation for each IDR
  media: chips-media: wave5: Support runtime suspend/resume
  media: chips-media: wave5: Use helpers to calculate bytesperline and
    sizeimage.
  media: chips-media: wave5: Support YUV422 raw pixel-formats on the
    encoder.

 .../platform/chips-media/wave5/wave5-helper.c |  24 ++
 .../platform/chips-media/wave5/wave5-helper.h |   4 +
 .../platform/chips-media/wave5/wave5-hw.c     |  23 +-
 .../chips-media/wave5/wave5-vpu-dec.c         | 261 +++++-------------
 .../chips-media/wave5/wave5-vpu-enc.c         | 260 +++++++++--------
 .../platform/chips-media/wave5/wave5-vpu.c    |  43 +++
 .../platform/chips-media/wave5/wave5-vpu.h    |   4 -
 .../platform/chips-media/wave5/wave5-vpuapi.c |  14 +-
 .../platform/chips-media/wave5/wave5-vpuapi.h |   1 +
 .../chips-media/wave5/wave5-vpuconfig.h       |  25 +-
 .../media/platform/chips-media/wave5/wave5.h  |   3 +
 11 files changed, 329 insertions(+), 333 deletions(-)

-- 
2.43.0


