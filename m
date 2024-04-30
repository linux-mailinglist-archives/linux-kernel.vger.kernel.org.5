Return-Path: <linux-kernel+bounces-163239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B512B8B678C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 03:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 449261F23661
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 01:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AE7D2E5;
	Tue, 30 Apr 2024 01:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b="HfRbR16M"
Received: from SEVP216CU002.outbound.protection.outlook.com (mail-koreacentralazon11022018.outbound.protection.outlook.com [52.101.154.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496A91FB2;
	Tue, 30 Apr 2024 01:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.154.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714441158; cv=fail; b=EBtGspo+02rOBrFWjQfuFnaikAv/LD4fwZ7sSJQfXNXPYOKFc65F+AAeKDl7dSjD2ONFIWhNvmzUx/SDiF1UMUhXZSbQaqFgSOXsrCxIZKDr5z1Z2GmmPZ6N9dkfCZuFKD6ZgvG9n8/x11tcE+WZN1FAlnghNqWrbX6SCBFpas4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714441158; c=relaxed/simple;
	bh=lNQnUOxfTvAcCbYd+3b3Y+q9VwBHcO6cZjnGN/mCEhk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=PvaJgaZZlDXmb9v9ZB1CNN2lY4EUOXawdNB9BZXirvfEuh7qAhXt42ZY7k9BTBrfIQaHa6E7vwPAN5aP04YVxPA51sVwp0CN2nzLd736t4FKVFLc+/fYUjJeG4SIvpKnHj/1kFJtpl7THD4uQpY2cocVpgwu/JUyvLSvfyVgTiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com; spf=pass smtp.mailfrom=chipsnmedia.com; dkim=pass (1024-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b=HfRbR16M; arc=fail smtp.client-ip=52.101.154.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chipsnmedia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dNXe/vBaXKT7qohXkl8G3PacWxQbWHunUfm0hDZNZjQNVgHLB8TmQALg7vmQ0nIrZdbn4gBw3yTJASK5Rx3L2d2DoeGmTFW37WjexDDO7RMc6HpncIwevIKxOXXxNFD1JQ6rZ08tGdXAer/bbP3asWUuyfpSsR8l8M9yUTWgONrztStFcxV4C0AuqkmDgaP81MHXhGQZlJfjbAcfK5N3lKOY4a2E4CuxosoPPwqEFIryd+bv/ZwuEZLCt1PDFbfd6PLzo/2eQCQ/DIikT/6Oz7cGwru+XrV0dzZknsNO75tWNXRE/9qTOVHsBVvdloN+9g6WzrrJkmkdC2EFZg3vBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7yGVI2G+v6D/ndicEFLt2U1li4ddXfDTXigVpwQt8BI=;
 b=gRnfKyVQb085wqhSe69iqDw6JlhhU+gE31LIGUbYVG4zBzait6NFCdffss4BSnesK74sYly8p7p5abZek+gCPNMlzNyLbI9z32SIhf7L29TlAfEHwb1VibX6EoW9zb/vtOQ9sQrt7H/L9tGUgVEWUa9eXJkKWToJnl2Sl2ScrouFKC6n4ifoQNuBP3C7laOo6wXUP//y/990qqZRcgSBXkdK+IPIcwG/dV6n77Am0gQyImhmaQexGNvc9u0TqepiJXPF5tK0lxX/ZnW5o7T59JCR7Q+g5agftDNAr5Gzf+N8gcnTAlTZmhcdzUbz2Hw8dncYpoMlQm8IcY5e+GmUnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chipsnmedia.com; dmarc=pass action=none
 header.from=chipsnmedia.com; dkim=pass header.d=chipsnmedia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chipsnmedia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yGVI2G+v6D/ndicEFLt2U1li4ddXfDTXigVpwQt8BI=;
 b=HfRbR16MUC9EVhQ6WatAuWtwhY28ReeFusdwkNYTP4NbHo7QBnnVdm9KuYd0bTfBa3vhaIqRwnflbEZfoxNIBcTN5DLWu8hcLbUvyBt8wLLWji8oovlNrSd1XrZCP+rNFQIUqKoXz3maaCOI17VCJMO504yyjjtLbaiuORsNGcc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chipsnmedia.com;
Received: from SL2P216MB1246.KORP216.PROD.OUTLOOK.COM (2603:1096:101:a::9) by
 SL2P216MB2195.KORP216.PROD.OUTLOOK.COM (2603:1096:101:150::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.36; Tue, 30 Apr 2024 01:39:09 +0000
Received: from SL2P216MB1246.KORP216.PROD.OUTLOOK.COM
 ([fe80::5b8:35f1:821f:4f57]) by SL2P216MB1246.KORP216.PROD.OUTLOOK.COM
 ([fe80::5b8:35f1:821f:4f57%2]) with mapi id 15.20.7519.035; Tue, 30 Apr 2024
 01:39:09 +0000
From: Nas Chung <nas.chung@chipsnmedia.com>
To: mchehab@kernel.org,
	nicolas@ndufresne.ca,
	sebastian.fricke@collabora.com
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hverkuil@xs4all.nl,
	nas.chung@chipsnmedia.com,
	lafley.kim@chipsnmedia.com,
	b-brnich@ti.com,
	jackson.lee@chipnsmedia.com,
	"Jackson.lee" <jackson.lee@chipsnmedia.com>
Subject: [PATCH v3 0/4] Add features to an existing driver
Date: Tue, 30 Apr 2024 10:38:56 +0900
Message-Id: <20240430013900.187-1-nas.chung@chipsnmedia.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0211.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:19::19) To SL2P216MB1246.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:a::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SL2P216MB1246:EE_|SL2P216MB2195:EE_
X-MS-Office365-Filtering-Correlation-Id: 369f4953-fa5a-4942-9dea-08dc68b654b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|52116005|376005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1rLtyeXztDAGZNlTOCHxN2zb+Ttmv6t0Wdc6iqUWpWCJ/FcGTYVrvBjHhb/J?=
 =?us-ascii?Q?0mEVBpJ5AYF/q494VxbZZp70L1gdvV9AdKDrC492ZCWOKl9Ptf/7dQ9sDR09?=
 =?us-ascii?Q?pYZ5v//D0LeMJ5pq/98o54B455XvLrUpLBlMlttzSxFGjDIVctND2zZO3kVJ?=
 =?us-ascii?Q?fTT8xbAgfj39Lf6C9oMx7nhNGWaOieh1wwGOTrZGjacCBhaMJCmbDLjIKoot?=
 =?us-ascii?Q?C5B/OC/61ba3Izxdnes01OnecVzFz43XLfCpunt65asY3oZDkpyr9S8E5AsR?=
 =?us-ascii?Q?3C1JLxyikEz11SdGNzPOmuUtAXVRWHPLnYUL7X5+m9gXeRNVskRy4GESFDY3?=
 =?us-ascii?Q?gwzJneHjcOipdNUOCOvdImA3maH6vlKjg9B4BFFyfX0U6rvHeCGmOeLpD22j?=
 =?us-ascii?Q?n899xoNt/JCjAcY1Vnh/AZjpXV79RHNQJQU4iVZb8soHTaoXTDZIKouBcnd7?=
 =?us-ascii?Q?sY5pSdYghXylrqo/w5ywUL92g4J+vFx1NDvAEQq48tFTGRqVzjYdaRVC7nkl?=
 =?us-ascii?Q?TnCnjZOVc/viBM7FSBYlNxo3C8uSogQVZ1IEn6jue5vqmLSkVxOevjdvftTt?=
 =?us-ascii?Q?xY9wvGN8r/75MV2JMQJcnoYLcTOJPcuvgT/luUnwokGn6irksJe9cl2CWYxU?=
 =?us-ascii?Q?Q6Y4skgPDd54X3HD3KD+eNOb0PuUQQaKRlAU7yPS8tZ6/VJToHGlIUi/L51s?=
 =?us-ascii?Q?K1wi1CGg90rgakBHovnnyUz/SFj0alnJTXTG05iK682Lm1RNEcVw3tJRdJRw?=
 =?us-ascii?Q?bepumWFQeECZzRSKKBmbWlwfMcy3i+RejNDihA+8ZYdTZbT9IWO8XBGL3kT5?=
 =?us-ascii?Q?ZD73nx6U8KoqG3JTD4C653zwg4aBWD6AbDeAfvlUp2UE8CeVqlXh7LN3lEhE?=
 =?us-ascii?Q?VnfAFfrT0nuHBnHpovXgoBrcdK21viUQ0RScnHe86JGE3d1KJ8BCTh9YRSE2?=
 =?us-ascii?Q?KhzeFC5F9Mk0kHHm19ItNQS2Dn0LdksuK0W27Cn6y/615RwVZDjANJfoZQnU?=
 =?us-ascii?Q?Zoe6fHBFbkK/fiPhkICkjbR5Vq/0ERO6403TmAMBOkUNXYg8ZSZf+Wrv/Eqr?=
 =?us-ascii?Q?w4G6TzLQTc/d9wSWrjrSuubyZlGrB8mrVLGrr45aP6t4Hms241WpoIZ8cHS5?=
 =?us-ascii?Q?IGg49xrl865XcGesmPdixLvWwz8DzcYnI9mOkQRV0h7orqX3l5vl1LcFALIj?=
 =?us-ascii?Q?AkrrJccNh13269d9M38I9zBdiDDuR5FkfuOT95O9FAiewM6pA+2as+uFHr2h?=
 =?us-ascii?Q?xVuRcqnD9mTF7immNASsk5nMVFQFk26kr3CGFWbw1XDI0yAqQ7wvRxec6S7u?=
 =?us-ascii?Q?TWvTQ72Y4niKqIu9FQtiiz6apF+kL174GjbN8x7rD9dVhQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2P216MB1246.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ked5KDPO4+esmwPT3g00k8ZJeOC0JGdxh9z90w3orJCn5e8kSoYzWxLwTGTt?=
 =?us-ascii?Q?zXuA/acXNCKRfaQs+tVznccwGRbBYxp16QTLZQI3zlSSSEv8itFirvhEL2WI?=
 =?us-ascii?Q?yrjlwANl+milCIs569YaBs2VS0wlUomShwH41kCUWlB+DAVN9GDNKp4xTlCI?=
 =?us-ascii?Q?ujxc1tRotLnmOeghyP0a4MqRt/Kh2vqWLcB9RFFzwsPuZkUWvFP/3VE/A+RR?=
 =?us-ascii?Q?Ypx4BnlBmG44Gzo20d47J5YwhWWHLIc3V+/HqKYJOim3Dt2lgNA5GXpqDVro?=
 =?us-ascii?Q?C10/I+Q2YSDdmN0ODjxfvcVfbNCuRZO7+SFEd57khkgjhLNMJxelMX8fKKET?=
 =?us-ascii?Q?5PVyaNVDOqbcr0f3RMRlf6J22DDSSR/nKbh4tMUJ8nuJBcozXq3IorMf8w8e?=
 =?us-ascii?Q?d2IxaNwGD5bs0ol2DSC26DChQi5pISoXUvA6dKMVfaW++RUPlDQtxMh4gK3Y?=
 =?us-ascii?Q?xY/MsnKa/f4q3ZjSL7N5N3WWG8QrD3Tv3saipUYXr8diPQH8HRmXj170Yz7l?=
 =?us-ascii?Q?mwRtCOPuqyWuKqjJbS/34HA0jiFGgvZy5CeGuuV6jet/rnyAoa8lCqZbRw+f?=
 =?us-ascii?Q?ZMOxmhszXaG1hysgAHjewp/ug7a/ld+OHF5tkfzcIunGR3qulgExo7N4JRqn?=
 =?us-ascii?Q?Sq3OlZxM4wZi4aaSVHa0f9O2WdV0nx4/CxdVhTWniysb/BAcQK2HlpmCOTh6?=
 =?us-ascii?Q?nTiOQPVGQ0oSRNR7cDl+FHnINg3Is0stnxE5kX6lh10kg4tyQ7kVLZT2izhJ?=
 =?us-ascii?Q?9sFOXJZ9KTeshM5Jui5bZS0TT+rzS+tw513gOb88SbBVgzpiYO0cnbn4yy41?=
 =?us-ascii?Q?0lxQCYQGAwqOU0Mdxe8rnVvAopt4mbCJDOT3kewQDw5324xBb90WLVbmgjqj?=
 =?us-ascii?Q?IFc+v8bwoX8HR8hf5xQc8RG/MnhiJoeKxsQb0H7NEMa740w+qn8dlm9iW6FZ?=
 =?us-ascii?Q?jCbSRDLPJ6eNE+4ikM9e9lKMkwF5oIuw1LuJNivfXne2ilm69QTYCP4E/LKj?=
 =?us-ascii?Q?dK8Gj4bZ270jCvqcfEYg/jXvtYTCrNyBeeM5VxUlMFrZd5z2oLoA1Fdjkze/?=
 =?us-ascii?Q?vXciG+NLA+cJ4nsHLONZQybxzRsSiTePu3giLmeq20T1eDsT2iwYqkv1y9ov?=
 =?us-ascii?Q?njLyk8qwOVIfk0qP+jUdSywO1qbnXCRd5ehe9lpi9qZUVMgc5vsInOi3wEY8?=
 =?us-ascii?Q?E7HReVJWA+kPYBopK60gXABBQNEg6DSdtH9EAHbiG6twGOaEPxeHLggGe5TU?=
 =?us-ascii?Q?CMLVGEIgu82/mmz0SDt8hjr/XwzjEiiXwkkfbOjMMqrKx0A/81yt7kMXmc8Y?=
 =?us-ascii?Q?WO8E8BPgaFv7I3F0F06DkTugFMyW4NYYNMNqRV3Ix2mLWkkO8KUpZ+v/LXnn?=
 =?us-ascii?Q?xycEyjlrsHEJkKqT7cyTckkBQ3RnyhOZSvHdgh29MiQWScaqei61DrK/kauZ?=
 =?us-ascii?Q?fo2Rth4giYBdXiZrf3duIeVNK+6YmZ+LFgoygveGsRd/aWr/NUk2oyBqoz+a?=
 =?us-ascii?Q?lRxvsmGELlVl6eBWHxdbSWX/Z+6rRZIRTZ4YynUhhydbw8fmJkcUGbgAAeVv?=
 =?us-ascii?Q?Qd+NO1LM+JmeQY+ZDeQF1hCLml/Uz39IhnGSg9KH9izVRpreDzxAEex0aWha?=
 =?us-ascii?Q?Zw=3D=3D?=
X-OriginatorOrg: chipsnmedia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 369f4953-fa5a-4942-9dea-08dc68b654b3
X-MS-Exchange-CrossTenant-AuthSource: SL2P216MB1246.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 01:39:09.5993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4d70c8e9-142b-4389-b7f2-fa8a3c68c467
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J53Dh8+pulTKClR4wTYTyGU7sofeH8qFo6d2SP1/lHXbMfPvzorLZXsMaqR+/HGL4K+34XCgtbBSFh+8c4MngUHXMWv9LCI/I1CAa6QFwZw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2P216MB2195

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
Ran 132/147 tests successfully               in 95.949 secs

(1 test fails because of not supporting to parse multi frames, 1 test fails because of a missing frame and slight corruption, 2 tests fail because of sizes which are incompatible with the IP, 11 tests fail because of unsupported 10 bit format)

Running test suite JVT-AVC_V1 with decoder GStreamer-H.264-V4L2-Gst1.0 Using 1 parallel job(s)
Ran 77/135 tests successfully               in 38.079 secs

(58 fail because the hardware is unable to decode  MBAFF / FMO / Field / Extended profile streams.)

Change since v2:
=================

* For [PATCH v2 0/4] media: chips-media: wave5: Support SPS/PPS generation for each IDR
 - add the suggested _SHIFT suffix

* For [PATCH v2 1/4] media: chips-media: wave5: Support runtime suspend/resume
 - change a commit message

* For [PATCH v2 2/4] media: chips-media: wave5: Use helpers to calculate bytesperline and sizeimage
 - add pix_fmt_type parameter into wave5_update_pix_fmt function
 - add min/max width/height values into dec_fmt_list 

Change since v1:
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
 .../platform/chips-media/wave5/wave5-helper.h |   5 +
 .../platform/chips-media/wave5/wave5-hw.c     |  23 +-
 .../chips-media/wave5/wave5-vpu-dec.c         | 314 +++++++-----------
 .../chips-media/wave5/wave5-vpu-enc.c         | 278 +++++++++-------
 .../platform/chips-media/wave5/wave5-vpu.c    |  43 +++
 .../platform/chips-media/wave5/wave5-vpu.h    |   5 +-
 .../platform/chips-media/wave5/wave5-vpuapi.c |  14 +-
 .../platform/chips-media/wave5/wave5-vpuapi.h |   1 +
 .../chips-media/wave5/wave5-vpuconfig.h       |  27 +-
 .../media/platform/chips-media/wave5/wave5.h  |   3 +
 11 files changed, 403 insertions(+), 334 deletions(-)

-- 
2.43.0


