Return-Path: <linux-kernel+bounces-93664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6027873307
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7F23B270E2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E525DF17;
	Wed,  6 Mar 2024 09:48:45 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2095.outbound.protection.partner.outlook.cn [139.219.17.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22D9433C5;
	Wed,  6 Mar 2024 09:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709718523; cv=fail; b=CfCN18M9VRVZDxiUIsFKn5+ltDRm9np6PfD/2jFJUvzyg7ewnEoUavNYbeKG8+PxdthWqSE6L91SMxpyIV0yOcYzEU6Wsrx6LaELB/Sxq5NK4rUn18q87Zf9OjHI5DJfZsfvdSt4T8eMsJM3RJfUISED0VkQC9iy8Xfb21qYazc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709718523; c=relaxed/simple;
	bh=YWW++HTYAUe5Tt2qqogtcavuBdXlxoAA9LfpGSiroSY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=aap3ZPBYSiEV/sLiAWAbdQc0R9Cj6hUNqiuq5EydOmUW3DBWlT8Z2XsguFlf/hqtzes3U7wXO0RV8RHznZgTmRw3ibXaRlMZULhevlrp7xgX8qYpEEntshS8GlkAS+UNnX1uz9/XKIbipOUHhtp1B2Fl4dbuff+XzYqrBJCfujs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=izVTigAql5sww5at71mhT+8ci6YcUfC6BqNwka5yAD8AfgKwy6UphMMvTvdYf2N91BMe1UXgSs+9BX3SRscGGa6QzZa6xK5N8n9fN+S5JDKa36LZTOapGSNrZCgRQQpA6Hx/66oRcmquyctJkmos23UI2C+ozuVhXF7h8LoxwoP2QcpbOvnQx+w97LPFQvoe1Pp4FxrS+y04frxDRBCHFoLUTuW43NkbUCKxcIqVgbKd5kd6UB2Ywfvx4ucLg/fMdG+NpevEvScTmR3ETfmInrure/NCZ1kYZGaRSIPFnNio1hSyOLkLvb/hTLkDIuRkb8BvzvzCIDzX8WIbk/2EHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ys2I0cI5CF4a9PhgKPpCljqauPS5NnZOHj2IXOCauk4=;
 b=UyC5RoeTgx/pAeb0eCWCYvTtQHjgTqcGXM9+zhzo2gKcYGCOKkpJwdm/p4bXDRd+UzWUiMN0tna6bhVIH6qxIlxC56EqwSdDwaIrkpcvOFKT9IVNyQxDsUJYXjrCqBZ0LyhM0VhyjvGhPeGGkqM0EeKi/d+LDUVOcllBJDfwLtJApqC3CJjLaBL/HItFCuw1Yz/rhWnb9/SDctjwQPOo5RnLXmeHKgvKCp72UFE8GIwlxG8uNKxq/O8ma8wOShg4eDz6Ro+BCFqkLy+RoM9HxXrwafkw/ObzBaFDNd08jlzhj9RC00T+xjlU2K3n2i/4UHvsIHzTRfWG28QK9n+Fww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0765.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.51; Wed, 6 Mar
 2024 09:33:42 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%6])
 with mapi id 15.20.7249.041; Wed, 6 Mar 2024 09:33:42 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Jack Zhu <jack.zhu@starfivetech.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: [PATCH v1 0/7] Add ISP RAW for StarFive
Date: Wed,  6 Mar 2024 01:33:27 -0800
Message-Id: <20240306093334.9321-1-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0010.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::17) To SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0671:EE_|SHXPR01MB0765:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a065442-e32c-4b8a-927c-08dc3dc0831d
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VvZfWHk0olO1RcgrvvblOIPe30GwT4vYTuV3cFUuc99KMgtu2gSkyn6xqEu+PGG8ABbCUzcrRlGobgJIdHF0x4vojFc0yuO2AjnMvv2ha4nIyoNpKpNRl0ZKEk9RHDd3AXY+c93uJSU94a4lcPL1WsrCllWZPJa92sbMmULAVc7kMLu7Mqu53XKVy9VxTd5LGt2+66m+fBxXu3b4esL5T1ttpXQV6ClH8ngypTB7J5Z5DMYofwZ1C062tSsUhnzGkJvmAAKGQDzVu/BrEmZ5GrmIhUeObEf5ZdKqOYxHayZD8D/je7+dhMjxeMTeQyJzMJ5HWN/+zSNtNh7U/ZuTFONgIv0a94CO32u1ygqkfmhq0zFC1bXEyVLFFzGP3FuGrh/W93cE4nVL4Ws3XMd0RO5vpFz42o/x0epSFYvDmJZl1B4i2Skq4MGnwJLOdc/wzcmnl1lMJ2SbZxCsMlaWGJ1v1usurFQgWYLuHG+0GOUk+mExA+/e8Dotl31/DV8gTYqrGkMBINwyHym+v746AVE+wpfAmyn42yv3GgTLphaibRMjOJZGawo1Da5O5nXizfx2nZaTqygI35YiW2a7y/Yjtq/JsOAKRukK0jqssGjuA0pHEWQntB42LAYQlHFH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6s4HaSdefLkDhjVyQbE0RewxSGvTJ28UYedvsqjOPaufGTxgUcWj0wHURZH5?=
 =?us-ascii?Q?ZurlLDcOTER8wBQ785OReUyDXvbN0QLWg34Id785jhd65GpTck4ErpDoyNk8?=
 =?us-ascii?Q?xk4ZNVuJjCZjvSdbvVYh7sfrtACdmMPRgR5Zqn0+dN9iSkP4iFwg8YtgEOGq?=
 =?us-ascii?Q?eO8xukfrKY1ensTDIsUz/4l7HBiJkrz1ofmzKZJkWgZrifDyDzb1y8Rlop66?=
 =?us-ascii?Q?45UF0BP2AZ8BMsawRgpHnY4HU7GN7PIPt8418j/ZTbX+fewXMUWufIXj/JEY?=
 =?us-ascii?Q?9XX/a/1xbL2hcVbykrH1ICq418bT1Ky4sd0P/Gby9N4A/UhlRC2J/a2DuJf5?=
 =?us-ascii?Q?cKjhsN279b4AMCuBrkPYBZQE99HDYspD4iGT1L/RqqSJChlwWjL83mV4QNSs?=
 =?us-ascii?Q?yFLUCXLDHO8nJ9Pyxzbk6q2VUNlszdt3eY06j95D1y+Jdf6iAJArHqNwea4i?=
 =?us-ascii?Q?iZwQ2JQuTPEF/DQTenAhDXMzfPu2l2hywbqfuePTNziMiYl7UxyINKmYKwnz?=
 =?us-ascii?Q?6XlR2cNDY6guNq7wJ/yMRo72z4fUwKnMJkJAcebCzbKMCmZAGqF+HSitlnPz?=
 =?us-ascii?Q?k0trv/v6TYKeEzJggenAxtYMNVad8G3FgDdhJPRnmpCQVjeJinfm1q8E6pjr?=
 =?us-ascii?Q?MmSxSX6HI07DjCjCuXcczaP9Umxb+l3YXdNazzdpWmOicnQeVU4xzPQ1D6Xz?=
 =?us-ascii?Q?erjVcyp99R3muFO4xaKoAIqh+Ar3zOh6RsyNaifLoByWHlhdn3QzSdemzp2F?=
 =?us-ascii?Q?i8u++h/PmDIji0/w4L/DDLt4V5TEpZmmKykDPgU8920c5eH4qH5z0LIUHNJX?=
 =?us-ascii?Q?bwca4iBH5VqTTCwuUDxVN++EkFd3eMIjCY5L5ftzwf9acEmSBPG0kzUssbFY?=
 =?us-ascii?Q?siqGlhfPyOYr32aVPchAD6bzSVnEhjPwtAC0AZoBoQic35Mr5Ok6Xh2B/ErE?=
 =?us-ascii?Q?fMVOpSz2oVToXCMlv9JY0M1+i0uOXFcPqvP8MkevMh0hJYtJQh9M958bADpf?=
 =?us-ascii?Q?VB+pR9aihLNVKYfmxJUUlirW/HzH7vl9ggUdNtOwAQ18xMV9CpxjjVFibJbB?=
 =?us-ascii?Q?Vw2j1pjElhjkAkOoxwU7PEJzsGU/V1nOeyV/gd/4hxv+dWdZmSq4NIWfkBfC?=
 =?us-ascii?Q?UbaFdjMkUYPh/+ZFAk4H4uwAwcRKxDhptcjGpmb1JhuDujdOAuknZ08NKwSp?=
 =?us-ascii?Q?C1+NSXXP8aX87ZI6yD2NpXEBCs035eG3Ty4BrUGB9KRP0h2GFVadKYMDqTn+?=
 =?us-ascii?Q?JF6CrDBZo9YAycq8YwZNlbOdL2hhnaqczZuznEeNzQGHh+kCmb9fpna6PGOM?=
 =?us-ascii?Q?9D6V1IyRpW9nrryIidqm1aEP14/8JllJpt1kEW81LmUZCtXMkPsiUhfgX8/U?=
 =?us-ascii?Q?ZtKpwSyrxm7jL/z4O3McrVNZXIYLTDrpowjECuTBtNBt2Ng/K+qj28CxX8dK?=
 =?us-ascii?Q?7jFfWQW32W8yvHIK0pOHJq0Yd9YSGezbXL3D3T27v+BFbzXN8Hk2yb90Uy4V?=
 =?us-ascii?Q?WhEAlILYGu7HdPU84RkD5rK2mwozqCb3cZt/ewh/R4sESAxhEOstGICxaLcu?=
 =?us-ascii?Q?fB/f35H1HvjJMRFdh8LpliA6xjZjM7vghNFR6cjdk3+6BC3FatNS6b8z0sCt?=
 =?us-ascii?Q?B55q1lzon0sK6oZKrJV+h2U=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a065442-e32c-4b8a-927c-08dc3dc0831d
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 09:33:42.4420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DpNs4YNTyFoxnb2kHAEmcBVKL0LcJOjBEP7bZS1n5gBSYumYnIpIm+nCU4Kxt4NsryE6UqrZo3zd1m210GuOc+zulshxH3Pwl8QgY687SIv4WyZquMqLpUuacKCNAero
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0765

This series implements the ISP RAW function to the Camera Subsystem on StarFive
JH7110 SoC. The series has been tested on the VisionFive 2 board.

This series should be applied after the patch [1]:
[1]: https://lore.kernel.org/all/20240301070025.11144-1-changhuang.liang@starfivetech.com/

This series will conflict with series [2]:
[2]: https://lore.kernel.org/all/20240205090424.40302-1-changhuang.liang@starfivetech.com/

The following are the media graph for the device and the v4l2-compliance
output.

==========================================================================================

[the media graph]:

digraph board {
	rankdir=TB
	n00000001 [label="{{<port0> 0} | stf_isp\n/dev/v4l-subdev0 | {<port1> 1 | <port2> 2}}", shape=Mrecord, style=filled, fillcolor=green]
	n00000001:port1 -> n00000009 [style=dashed]
	n00000001:port2 -> n0000000d [style=dashed]
	n00000005 [label="capture_dump\n/dev/video0", shape=box, style=filled, fillcolor=yellow]
	n00000009 [label="capture_yuv\n/dev/video1", shape=box, style=filled, fillcolor=yellow]
	n0000000d [label="capture_raw\n/dev/video2", shape=box, style=filled, fillcolor=yellow]
	n00000015 [label="{{<port0> 0} | cdns_csi2rx.19800000.csi\n/dev/v4l-subdev1 | {<port1> 1 | <port2> 2 | <port3> 3 | <port4> 4}}", shape=Mrecord, style=filled, fillcolor=green]
	n00000015:port1 -> n00000001:port0 [style=dashed]
	n00000015:port1 -> n00000005 [style=dashed]
	n0000001f [label="{{} | imx219 6-0010\n/dev/v4l-subdev2 | {<port0> 0}}", shape=Mrecord, style=filled, fillcolor=green]
	n0000001f:port0 -> n00000015:port0 [style=bold]
}

[v4l2-compliance test]:

# v4l2-compliance -m /dev/media0
v4l2-compliance 1.27.0, 64 bits, 64-bit time_t

Compliance test for starfive-camss device /dev/media0:

Media Driver Info:
	Driver name      : starfive-camss
	Model            : Starfive Camera Subsystem
	Serial           :
	Bus info         : platform:19840000.isp
	Media version    : 6.8.0
	Hardware revision: 0x00000000 (0)
	Driver version   : 6.8.0

Required ioctls:
	test MEDIA_IOC_DEVICE_INFO: OK
	test invalid ioctls: OK

Allow for multiple opens:
	test second /dev/media0 open: OK
	test MEDIA_IOC_DEVICE_INFO: OK
	test for unlimited opens: OK

Media Controller ioctls:
	test MEDIA_IOC_G_TOPOLOGY: OK
	Entities: 6 Interfaces: 6 Pads: 12 Links: 11
	test MEDIA_IOC_ENUM_ENTITIES/LINKS: OK
	test MEDIA_IOC_SETUP_LINK: OK

Total for starfive-camss device /dev/media0: 8, Succeeded: 8, Failed: 0, Warnings: 0
--------------------------------------------------------------------------------
Compliance test for starfive-camss device /dev/video0:

Driver Info:
	Driver name      : starfive-camss
	Card type        : Starfive Camera Subsystem
	Bus info         : platform:19840000.isp
	Driver version   : 6.8.0
	Capabilities     : 0x84200001
		Video Capture
		Streaming
		Extended Pix Format
		Device Capabilities
	Device Caps      : 0x04200001
		Video Capture
		Streaming
		Extended Pix Format
Media Driver Info:
	Driver name      : starfive-camss
	Model            : Starfive Camera Subsystem
	Serial           :
	Bus info         : platform:19840000.isp
	Media version    : 6.8.0
	Hardware revision: 0x00000000 (0)
	Driver version   : 6.8.0
Interface Info:
	ID               : 0x03000007
	Type             : V4L Video
Entity Info:
	ID               : 0x00000005 (5)
	Name             : capture_dump
	Function         : V4L2 I/O
	Pad 0x01000006   : 0: Sink
	  Link 0x0200001d: from remote pad 0x1000017 of entity 'cdns_csi2rx.19800000.csi' (Video Interface Bridge): Data

Required ioctls:
	test MC information (see 'Media Driver Info' above): OK
	test VIDIOC_QUERYCAP: OK
	test invalid ioctls: OK

Allow for multiple opens:
	test second /dev/video0 open: OK
	test VIDIOC_QUERYCAP: OK
	test VIDIOC_G/S_PRIORITY: OK
	test for unlimited opens: OK

Debug ioctls:
	test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
	test VIDIOC_LOG_STATUS: OK (Not Supported)

Input ioctls:
	test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
	test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
	test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
	test VIDIOC_ENUMAUDIO: OK (Not Supported)
	test VIDIOC_G/S/ENUMINPUT: OK (Not Supported)
	test VIDIOC_G/S_AUDIO: OK (Not Supported)
	Inputs: 0 Audio Inputs: 0 Tuners: 0

Output ioctls:
	test VIDIOC_G/S_MODULATOR: OK (Not Supported)
	test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
	test VIDIOC_ENUMAUDOUT: OK (Not Supported)
	test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
	test VIDIOC_G/S_AUDOUT: OK (Not Supported)
	Outputs: 0 Audio Outputs: 0 Modulators: 0

Input/Output configuration ioctls:
	test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
	test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
	test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
	test VIDIOC_G/S_EDID: OK (Not Supported)

Control ioctls:
	test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK (Not Supported)
	test VIDIOC_QUERYCTRL: OK (Not Supported)
	test VIDIOC_G/S_CTRL: OK (Not Supported)
	test VIDIOC_G/S/TRY_EXT_CTRLS: OK (Not Supported)
	test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK (Not Supported)
	test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
	Standard Controls: 0 Private Controls: 0

Format ioctls:
	test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
	test VIDIOC_G/S_PARM: OK (Not Supported)
	test VIDIOC_G_FBUF: OK (Not Supported)
	test VIDIOC_G_FMT: OK
	test VIDIOC_TRY_FMT: OK
	test VIDIOC_S_FMT: OK
	test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
	test Cropping: OK (Not Supported)
	test Composing: OK (Not Supported)
	test Scaling: OK

Codec ioctls:
	test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
	test VIDIOC_G_ENC_INDEX: OK (Not Supported)
	test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)

Buffer ioctls:
	test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
	test CREATE_BUFS maximum buffers: OK
	test VIDIOC_EXPBUF: OK
	test Requests: OK (Not Supported)

Total for starfive-camss device /dev/video0: 47, Succeeded: 47, Failed: 0, Warnings: 0
--------------------------------------------------------------------------------
Compliance test for starfive-camss device /dev/video1:

Driver Info:
	Driver name      : starfive-camss
	Card type        : Starfive Camera Subsystem
	Bus info         : platform:19840000.isp
	Driver version   : 6.8.0
	Capabilities     : 0x84200001
		Video Capture
		Streaming
		Extended Pix Format
		Device Capabilities
	Device Caps      : 0x04200001
		Video Capture
		Streaming
		Extended Pix Format
Media Driver Info:
	Driver name      : starfive-camss
	Model            : Starfive Camera Subsystem
	Serial           :
	Bus info         : platform:19840000.isp
	Media version    : 6.8.0
	Hardware revision: 0x00000000 (0)
	Driver version   : 6.8.0
Interface Info:
	ID               : 0x0300000b
	Type             : V4L Video
Entity Info:
	ID               : 0x00000009 (9)
	Name             : capture_yuv
	Function         : V4L2 I/O
	Pad 0x0100000a   : 0: Sink
	  Link 0x02000011: from remote pad 0x1000003 of entity 'stf_isp' (Image Signal Processor): Data

Required ioctls:
	test MC information (see 'Media Driver Info' above): OK
	test VIDIOC_QUERYCAP: OK
	test invalid ioctls: OK

Allow for multiple opens:
	test second /dev/video1 open: OK
	test VIDIOC_QUERYCAP: OK
	test VIDIOC_G/S_PRIORITY: OK
	test for unlimited opens: OK

Debug ioctls:
	test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
	test VIDIOC_LOG_STATUS: OK (Not Supported)

Input ioctls:
	test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
	test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
	test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
	test VIDIOC_ENUMAUDIO: OK (Not Supported)
	test VIDIOC_G/S/ENUMINPUT: OK (Not Supported)
	test VIDIOC_G/S_AUDIO: OK (Not Supported)
	Inputs: 0 Audio Inputs: 0 Tuners: 0

Output ioctls:
	test VIDIOC_G/S_MODULATOR: OK (Not Supported)
	test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
	test VIDIOC_ENUMAUDOUT: OK (Not Supported)
	test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
	test VIDIOC_G/S_AUDOUT: OK (Not Supported)
	Outputs: 0 Audio Outputs: 0 Modulators: 0

Input/Output configuration ioctls:
	test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
	test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
	test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
	test VIDIOC_G/S_EDID: OK (Not Supported)

Control ioctls:
	test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK (Not Supported)
	test VIDIOC_QUERYCTRL: OK (Not Supported)
	test VIDIOC_G/S_CTRL: OK (Not Supported)
	test VIDIOC_G/S/TRY_EXT_CTRLS: OK (Not Supported)
	test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK (Not Supported)
	test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
	Standard Controls: 0 Private Controls: 0

Format ioctls:
	test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
	test VIDIOC_G/S_PARM: OK (Not Supported)
	test VIDIOC_G_FBUF: OK (Not Supported)
	test VIDIOC_G_FMT: OK
	test VIDIOC_TRY_FMT: OK
	test VIDIOC_S_FMT: OK
	test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
	test Cropping: OK (Not Supported)
	test Composing: OK (Not Supported)
	test Scaling: OK

Codec ioctls:
	test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
	test VIDIOC_G_ENC_INDEX: OK (Not Supported)
	test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)

Buffer ioctls:
	test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
	test CREATE_BUFS maximum buffers: OK
	test VIDIOC_EXPBUF: OK
	test Requests: OK (Not Supported)

Total for starfive-camss device /dev/video1: 47, Succeeded: 47, Failed: 0, Warnings: 0
--------------------------------------------------------------------------------
Compliance test for starfive-camss device /dev/video2:

Driver Info:
	Driver name      : starfive-camss
	Card type        : Starfive Camera Subsystem
	Bus info         : platform:19840000.isp
	Driver version   : 6.8.0
	Capabilities     : 0x84200001
		Video Capture
		Streaming
		Extended Pix Format
		Device Capabilities
	Device Caps      : 0x04200001
		Video Capture
		Streaming
		Extended Pix Format
Media Driver Info:
	Driver name      : starfive-camss
	Model            : Starfive Camera Subsystem
	Serial           :
	Bus info         : platform:19840000.isp
	Media version    : 6.8.0
	Hardware revision: 0x00000000 (0)
	Driver version   : 6.8.0
Interface Info:
	ID               : 0x0300000f
	Type             : V4L Video
Entity Info:
	ID               : 0x0000000d (13)
	Name             : capture_raw
	Function         : V4L2 I/O
	Pad 0x0100000e   : 0: Sink
	  Link 0x02000013: from remote pad 0x1000004 of entity 'stf_isp' (Image Signal Processor): Data

Required ioctls:
	test MC information (see 'Media Driver Info' above): OK
	test VIDIOC_QUERYCAP: OK
	test invalid ioctls: OK

Allow for multiple opens:
	test second /dev/video2 open: OK
	test VIDIOC_QUERYCAP: OK
	test VIDIOC_G/S_PRIORITY: OK
	test for unlimited opens: OK

Debug ioctls:
	test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
	test VIDIOC_LOG_STATUS: OK (Not Supported)

Input ioctls:
	test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
	test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
	test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
	test VIDIOC_ENUMAUDIO: OK (Not Supported)
	test VIDIOC_G/S/ENUMINPUT: OK (Not Supported)
	test VIDIOC_G/S_AUDIO: OK (Not Supported)
	Inputs: 0 Audio Inputs: 0 Tuners: 0

Output ioctls:
	test VIDIOC_G/S_MODULATOR: OK (Not Supported)
	test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
	test VIDIOC_ENUMAUDOUT: OK (Not Supported)
	test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
	test VIDIOC_G/S_AUDOUT: OK (Not Supported)
	Outputs: 0 Audio Outputs: 0 Modulators: 0

Input/Output configuration ioctls:
	test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
	test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
	test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
	test VIDIOC_G/S_EDID: OK (Not Supported)

Control ioctls:
	test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK (Not Supported)
	test VIDIOC_QUERYCTRL: OK (Not Supported)
	test VIDIOC_G/S_CTRL: OK (Not Supported)
	test VIDIOC_G/S/TRY_EXT_CTRLS: OK (Not Supported)
	test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK (Not Supported)
	test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
	Standard Controls: 0 Private Controls: 0

Format ioctls:
	test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
	test VIDIOC_G/S_PARM: OK (Not Supported)
	test VIDIOC_G_FBUF: OK (Not Supported)
	test VIDIOC_G_FMT: OK
	test VIDIOC_TRY_FMT: OK
	test VIDIOC_S_FMT: OK
	test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
	test Cropping: OK (Not Supported)
	test Composing: OK (Not Supported)
	test Scaling: OK

Codec ioctls:
	test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
	test VIDIOC_G_ENC_INDEX: OK (Not Supported)
	test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)

Buffer ioctls:
	test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
	test CREATE_BUFS maximum buffers: OK
	test VIDIOC_EXPBUF: OK
	test Requests: OK (Not Supported)

Total for starfive-camss device /dev/video2: 47, Succeeded: 47, Failed: 0, Warnings: 0
--------------------------------------------------------------------------------
Compliance test for starfive-camss device /dev/v4l-subdev0:

Driver Info:
	Driver version   : 6.8.0
	Capabilities     : 0x00000000
	Client Capabilities: 0x0000000000000002
interval-uses-which Media Driver Info:
	Driver name      : starfive-camss
	Model            : Starfive Camera Subsystem
	Serial           :
	Bus info         : platform:19840000.isp
	Media version    : 6.8.0
	Hardware revision: 0x00000000 (0)
	Driver version   : 6.8.0
Interface Info:
	ID               : 0x03000023
	Type             : V4L Sub-Device
Entity Info:
	ID               : 0x00000001 (1)
	Name             : stf_isp
	Function         : Image Signal Processor
	Pad 0x01000002   : 0: Sink
	  Link 0x0200001b: from remote pad 0x1000017 of entity 'cdns_csi2rx.19800000.csi' (Video Interface Bridge): Data
	Pad 0x01000003   : 1: Source
	  Link 0x02000011: to remote pad 0x100000a of entity 'capture_yuv' (V4L2 I/O): Data
	Pad 0x01000004   : 2: Source
	  Link 0x02000013: to remote pad 0x100000e of entity 'capture_raw' (V4L2 I/O): Data

Required ioctls:
	test MC information (see 'Media Driver Info' above): OK
	test VIDIOC_SUDBEV_QUERYCAP: OK
	test invalid ioctls: OK

Allow for multiple opens:
	test second /dev/v4l-subdev0 open: OK
	test VIDIOC_SUBDEV_QUERYCAP: OK
	test for unlimited opens: OK

Debug ioctls:
	test VIDIOC_LOG_STATUS: OK (Not Supported)

Input ioctls:
	test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
	test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
	test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
	test VIDIOC_ENUMAUDIO: OK (Not Supported)
	test VIDIOC_G/S/ENUMINPUT: OK (Not Supported)
	test VIDIOC_G/S_AUDIO: OK (Not Supported)
	Inputs: 0 Audio Inputs: 0 Tuners: 0

Output ioctls:
	test VIDIOC_G/S_MODULATOR: OK (Not Supported)
	test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
	test VIDIOC_ENUMAUDOUT: OK (Not Supported)
	test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
	test VIDIOC_G/S_AUDOUT: OK (Not Supported)
	Outputs: 0 Audio Outputs: 0 Modulators: 0

Input/Output configuration ioctls:
	test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
	test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
	test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
	test VIDIOC_G/S_EDID: OK (Not Supported)

Sub-Device ioctls (Sink Pad 0):
	Try Stream 0
	test Try VIDIOC_SUBDEV_ENUM_MBUS_CODE/FRAME_SIZE/FRAME_INTERVAL: OK
	test Try VIDIOC_SUBDEV_G/S_FMT: OK
	test Try VIDIOC_SUBDEV_G/S_SELECTION/CROP: OK
	Active Stream 0
	test Active VIDIOC_SUBDEV_ENUM_MBUS_CODE/FRAME_SIZE/FRAME_INTERVAL: OK
	test Active VIDIOC_SUBDEV_G/S_FMT: OK
	test Active VIDIOC_SUBDEV_G/S_SELECTION/CROP: OK
	test Active VIDIOC_SUBDEV_G/S_FRAME_INTERVAL: OK (Not Supported)

Sub-Device ioctls (Source Pad 1):
	Try Stream 0
	test Try VIDIOC_SUBDEV_ENUM_MBUS_CODE/FRAME_SIZE/FRAME_INTERVAL: OK
	test Try VIDIOC_SUBDEV_G/S_FMT: OK
	test Try VIDIOC_SUBDEV_G/S_SELECTION/CROP: OK
	Active Stream 0
	test Active VIDIOC_SUBDEV_ENUM_MBUS_CODE/FRAME_SIZE/FRAME_INTERVAL: OK
	test Active VIDIOC_SUBDEV_G/S_FMT: OK
	test Active VIDIOC_SUBDEV_G/S_SELECTION/CROP: OK
	test Active VIDIOC_SUBDEV_G/S_FRAME_INTERVAL: OK (Not Supported)

Sub-Device ioctls (Source Pad 2):
	Try Stream 0
	test Try VIDIOC_SUBDEV_ENUM_MBUS_CODE/FRAME_SIZE/FRAME_INTERVAL: OK
	test Try VIDIOC_SUBDEV_G/S_FMT: OK
		fail: v4l2-test-subdevs.cpp(528): sel.r.width == ~0U
	test Try VIDIOC_SUBDEV_G/S_SELECTION/CROP: FAIL
	Active Stream 0
	test Active VIDIOC_SUBDEV_ENUM_MBUS_CODE/FRAME_SIZE/FRAME_INTERVAL: OK
	test Active VIDIOC_SUBDEV_G/S_FMT: OK
		fail: v4l2-test-subdevs.cpp(528): sel.r.width == ~0U
	test Active VIDIOC_SUBDEV_G/S_SELECTION/CROP: FAIL
	test Active VIDIOC_SUBDEV_G/S_FRAME_INTERVAL: OK (Not Supported)

Control ioctls:
	test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK (Not Supported)
	test VIDIOC_QUERYCTRL: OK (Not Supported)
	test VIDIOC_G/S_CTRL: OK (Not Supported)
	test VIDIOC_G/S/TRY_EXT_CTRLS: OK (Not Supported)
	test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK (Not Supported)
	test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
	Standard Controls: 0 Private Controls: 0

Format ioctls:
	test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK (Not Supported)
	test VIDIOC_G/S_PARM: OK (Not Supported)
	test VIDIOC_G_FBUF: OK (Not Supported)
	test VIDIOC_G_FMT: OK (Not Supported)
	test VIDIOC_TRY_FMT: OK (Not Supported)
	test VIDIOC_S_FMT: OK (Not Supported)
	test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
	test Cropping: OK (Not Supported)
	test Composing: OK (Not Supported)
	test Scaling: OK (Not Supported)

Codec ioctls:
	test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
	test VIDIOC_G_ENC_INDEX: OK (Not Supported)
	test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)

Buffer ioctls:
	test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK (Not Supported)
	test CREATE_BUFS maximum buffers: OK
	test VIDIOC_EXPBUF: OK (Not Supported)
	test Requests: OK (Not Supported)

Total for starfive-camss device /dev/v4l-subdev0: 66, Succeeded: 64, Failed: 2, Warnings: 0
--------------------------------------------------------------------------------
Compliance test for starfive-camss device /dev/v4l-subdev1:

Driver Info:
	Driver version   : 6.8.0
	Capabilities     : 0x00000000
	Client Capabilities: 0x0000000000000002
interval-uses-which Media Driver Info:
	Driver name      : starfive-camss
	Model            : Starfive Camera Subsystem
	Serial           :
	Bus info         : platform:19840000.isp
	Media version    : 6.8.0
	Hardware revision: 0x00000000 (0)
	Driver version   : 6.8.0
Interface Info:
	ID               : 0x03000025
	Type             : V4L Sub-Device
Entity Info:
	ID               : 0x00000015 (21)
	Name             : cdns_csi2rx.19800000.csi
	Function         : Video Interface Bridge
	Pad 0x01000016   : 0: Sink
	  Link 0x02000021: from remote pad 0x1000020 of entity 'imx219 6-0010' (Camera Sensor): Data, Enabled, Immutable
	Pad 0x01000017   : 1: Source
	  Link 0x0200001b: to remote pad 0x1000002 of entity 'stf_isp' (Image Signal Processor): Data
	  Link 0x0200001d: to remote pad 0x1000006 of entity 'capture_dump' (V4L2 I/O): Data
	Pad 0x01000018   : 2: Source
	Pad 0x01000019   : 3: Source
	Pad 0x0100001a   : 4: Source

Required ioctls:
	test MC information (see 'Media Driver Info' above): OK
	test VIDIOC_SUDBEV_QUERYCAP: OK
	test invalid ioctls: OK

Allow for multiple opens:
	test second /dev/v4l-subdev1 open: OK
	test VIDIOC_SUBDEV_QUERYCAP: OK
	test for unlimited opens: OK

Debug ioctls:
	test VIDIOC_LOG_STATUS: OK (Not Supported)

Input ioctls:
	test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
	test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
	test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
	test VIDIOC_ENUMAUDIO: OK (Not Supported)
	test VIDIOC_G/S/ENUMINPUT: OK (Not Supported)
	test VIDIOC_G/S_AUDIO: OK (Not Supported)
	Inputs: 0 Audio Inputs: 0 Tuners: 0

Output ioctls:
	test VIDIOC_G/S_MODULATOR: OK (Not Supported)
	test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
	test VIDIOC_ENUMAUDOUT: OK (Not Supported)
	test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
	test VIDIOC_G/S_AUDOUT: OK (Not Supported)
	Outputs: 0 Audio Outputs: 0 Modulators: 0

Input/Output configuration ioctls:
	test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
	test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
	test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
	test VIDIOC_G/S_EDID: OK (Not Supported)

Sub-Device ioctls (Sink Pad 0):
	Try Stream 0
	test Try VIDIOC_SUBDEV_ENUM_MBUS_CODE/FRAME_SIZE/FRAME_INTERVAL: OK
	test Try VIDIOC_SUBDEV_G/S_FMT: OK
	test Try VIDIOC_SUBDEV_G/S_SELECTION/CROP: OK (Not Supported)
	Active Stream 0
	test Active VIDIOC_SUBDEV_ENUM_MBUS_CODE/FRAME_SIZE/FRAME_INTERVAL: OK
	test Active VIDIOC_SUBDEV_G/S_FMT: OK
	test Active VIDIOC_SUBDEV_G/S_SELECTION/CROP: OK (Not Supported)
	test Active VIDIOC_SUBDEV_G/S_FRAME_INTERVAL: OK (Not Supported)

Sub-Device ioctls (Source Pad 1):
	Try Stream 0
	test Try VIDIOC_SUBDEV_ENUM_MBUS_CODE/FRAME_SIZE/FRAME_INTERVAL: OK
	test Try VIDIOC_SUBDEV_G/S_FMT: OK
	test Try VIDIOC_SUBDEV_G/S_SELECTION/CROP: OK (Not Supported)
	Active Stream 0
	test Active VIDIOC_SUBDEV_ENUM_MBUS_CODE/FRAME_SIZE/FRAME_INTERVAL: OK
	test Active VIDIOC_SUBDEV_G/S_FMT: OK
	test Active VIDIOC_SUBDEV_G/S_SELECTION/CROP: OK (Not Supported)
	test Active VIDIOC_SUBDEV_G/S_FRAME_INTERVAL: OK (Not Supported)

Sub-Device ioctls (Source Pad 2):
	Try Stream 0
	test Try VIDIOC_SUBDEV_ENUM_MBUS_CODE/FRAME_SIZE/FRAME_INTERVAL: OK
	test Try VIDIOC_SUBDEV_G/S_FMT: OK
	test Try VIDIOC_SUBDEV_G/S_SELECTION/CROP: OK (Not Supported)
	Active Stream 0
	test Active VIDIOC_SUBDEV_ENUM_MBUS_CODE/FRAME_SIZE/FRAME_INTERVAL: OK
	test Active VIDIOC_SUBDEV_G/S_FMT: OK
	test Active VIDIOC_SUBDEV_G/S_SELECTION/CROP: OK (Not Supported)
	test Active VIDIOC_SUBDEV_G/S_FRAME_INTERVAL: OK (Not Supported)

Sub-Device ioctls (Source Pad 3):
	Try Stream 0
	test Try VIDIOC_SUBDEV_ENUM_MBUS_CODE/FRAME_SIZE/FRAME_INTERVAL: OK
	test Try VIDIOC_SUBDEV_G/S_FMT: OK
	test Try VIDIOC_SUBDEV_G/S_SELECTION/CROP: OK (Not Supported)
	Active Stream 0
	test Active VIDIOC_SUBDEV_ENUM_MBUS_CODE/FRAME_SIZE/FRAME_INTERVAL: OK
	test Active VIDIOC_SUBDEV_G/S_FMT: OK
	test Active VIDIOC_SUBDEV_G/S_SELECTION/CROP: OK (Not Supported)
	test Active VIDIOC_SUBDEV_G/S_FRAME_INTERVAL: OK (Not Supported)

Sub-Device ioctls (Source Pad 4):
	Try Stream 0
	test Try VIDIOC_SUBDEV_ENUM_MBUS_CODE/FRAME_SIZE/FRAME_INTERVAL: OK
	test Try VIDIOC_SUBDEV_G/S_FMT: OK
	test Try VIDIOC_SUBDEV_G/S_SELECTION/CROP: OK (Not Supported)
	Active Stream 0
	test Active VIDIOC_SUBDEV_ENUM_MBUS_CODE/FRAME_SIZE/FRAME_INTERVAL: OK
	test Active VIDIOC_SUBDEV_G/S_FMT: OK
	test Active VIDIOC_SUBDEV_G/S_SELECTION/CROP: OK (Not Supported)
	test Active VIDIOC_SUBDEV_G/S_FRAME_INTERVAL: OK (Not Supported)

Control ioctls:
	test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK (Not Supported)
	test VIDIOC_QUERYCTRL: OK (Not Supported)
	test VIDIOC_G/S_CTRL: OK (Not Supported)
	test VIDIOC_G/S/TRY_EXT_CTRLS: OK (Not Supported)
	test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK (Not Supported)
	test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
	Standard Controls: 0 Private Controls: 0

Format ioctls:
	test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK (Not Supported)
	test VIDIOC_G/S_PARM: OK (Not Supported)
	test VIDIOC_G_FBUF: OK (Not Supported)
	test VIDIOC_G_FMT: OK (Not Supported)
	test VIDIOC_TRY_FMT: OK (Not Supported)
	test VIDIOC_S_FMT: OK (Not Supported)
	test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
	test Cropping: OK (Not Supported)
	test Composing: OK (Not Supported)
	test Scaling: OK (Not Supported)

Codec ioctls:
	test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
	test VIDIOC_G_ENC_INDEX: OK (Not Supported)
	test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)

Buffer ioctls:
	test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK (Not Supported)
	test CREATE_BUFS maximum buffers: OK
	test VIDIOC_EXPBUF: OK (Not Supported)
	test Requests: OK (Not Supported)

Total for starfive-camss device /dev/v4l-subdev1: 80, Succeeded: 80, Failed: 0, Warnings: 0
--------------------------------------------------------------------------------
Compliance test for starfive-camss device /dev/v4l-subdev2:

Driver Info:
	Driver version   : 6.8.0
	Capabilities     : 0x00000000
	Client Capabilities: 0x0000000000000002
interval-uses-which Media Driver Info:
	Driver name      : starfive-camss
	Model            : Starfive Camera Subsystem
	Serial           :
	Bus info         : platform:19840000.isp
	Media version    : 6.8.0
	Hardware revision: 0x00000000 (0)
	Driver version   : 6.8.0
Interface Info:
	ID               : 0x03000027
	Type             : V4L Sub-Device
Entity Info:
	ID               : 0x0000001f (31)
	Name             : imx219 6-0010
	Function         : Camera Sensor
	Pad 0x01000020   : 0: Source
	  Link 0x02000021: to remote pad 0x1000016 of entity 'cdns_csi2rx.19800000.csi' (Video Interface Bridge): Data, Enabled, Immutable

Required ioctls:
	test MC information (see 'Media Driver Info' above): OK
	test VIDIOC_SUDBEV_QUERYCAP: OK
	test invalid ioctls: OK

Allow for multiple opens:
	test second /dev/v4l-subdev2 open: OK
	test VIDIOC_SUBDEV_QUERYCAP: OK
	test for unlimited opens: OK

Debug ioctls:
	test VIDIOC_LOG_STATUS: OK (Not Supported)

Input ioctls:
	test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
	test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
	test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
	test VIDIOC_ENUMAUDIO: OK (Not Supported)
	test VIDIOC_G/S/ENUMINPUT: OK (Not Supported)
	test VIDIOC_G/S_AUDIO: OK (Not Supported)
	Inputs: 0 Audio Inputs: 0 Tuners: 0

Output ioctls:
	test VIDIOC_G/S_MODULATOR: OK (Not Supported)
	test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
	test VIDIOC_ENUMAUDOUT: OK (Not Supported)
	test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
	test VIDIOC_G/S_AUDOUT: OK (Not Supported)
	Outputs: 0 Audio Outputs: 0 Modulators: 0

Input/Output configuration ioctls:
	test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
	test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
	test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
	test VIDIOC_G/S_EDID: OK (Not Supported)

Sub-Device ioctls (Source Pad 0):
	Try Stream 0
	test Try VIDIOC_SUBDEV_ENUM_MBUS_CODE/FRAME_SIZE/FRAME_INTERVAL: OK
	test Try VIDIOC_SUBDEV_G/S_FMT: OK
		warn: v4l2-test-subdevs.cpp(566): VIDIOC_SUBDEV_G_SELECTION is supported for target 0 but not VIDIOC_SUBDEV_S_SELECTION
	test Try VIDIOC_SUBDEV_G/S_SELECTION/CROP: OK
	Active Stream 0
	test Active VIDIOC_SUBDEV_ENUM_MBUS_CODE/FRAME_SIZE/FRAME_INTERVAL: OK
	test Active VIDIOC_SUBDEV_G/S_FMT: OK
		warn: v4l2-test-subdevs.cpp(566): VIDIOC_SUBDEV_G_SELECTION is supported for target 0 but not VIDIOC_SUBDEV_S_SELECTION
	test Active VIDIOC_SUBDEV_G/S_SELECTION/CROP: OK
	test Active VIDIOC_SUBDEV_G/S_FRAME_INTERVAL: OK (Not Supported)

Control ioctls:
	test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK
	test VIDIOC_QUERYCTRL: OK
	test VIDIOC_G/S_CTRL: OK
	test VIDIOC_G/S/TRY_EXT_CTRLS: OK
	test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK
	test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
	Standard Controls: 17 Private Controls: 0

Format ioctls:
	test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK (Not Supported)
	test VIDIOC_G/S_PARM: OK (Not Supported)
	test VIDIOC_G_FBUF: OK (Not Supported)
	test VIDIOC_G_FMT: OK (Not Supported)
	test VIDIOC_TRY_FMT: OK (Not Supported)
	test VIDIOC_S_FMT: OK (Not Supported)
	test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
	test Cropping: OK (Not Supported)
	test Composing: OK (Not Supported)
	test Scaling: OK (Not Supported)

Codec ioctls:
	test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
	test VIDIOC_G_ENC_INDEX: OK (Not Supported)
	test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)

Buffer ioctls:
	test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK (Not Supported)
	test CREATE_BUFS maximum buffers: OK
	test VIDIOC_EXPBUF: OK (Not Supported)
	test Requests: OK (Not Supported)

Total for starfive-camss device /dev/v4l-subdev2: 52, Succeeded: 52, Failed: 0, Warnings: 2

Grand Total for starfive-camss device /dev/media0: 347, Succeeded: 345, Failed: 2, Warnings: 2

Two warnings are from the imx219, can ignore them.

Changhuang Liang (7):
  staging: media: starfive: Replaced current_fmt with get from sd_state
  staging: media: starfive: Add raw pad for ISP
  staging: media: starfive: Sink rectangle set to ISP source pad
  staging: media: starfive: Add multi streams for ISP
  staging: media: starfive: Add ISP raw video device
  staging: media: starfive: Add raw output stride configure
  admin-guide: media: Update documents for StarFive Camera Subsystem

 .../admin-guide/media/starfive_camss.rst      | 11 ++-
 .../media/starfive_camss_graph.dot            | 20 +++--
 .../staging/media/starfive/camss/stf-camss.c  | 19 +++++
 .../media/starfive/camss/stf-capture.c        | 58 ++++++++++++-
 .../media/starfive/camss/stf-isp-hw-ops.c     | 23 +++--
 .../staging/media/starfive/camss/stf-isp.c    | 83 ++++++++++++++-----
 .../staging/media/starfive/camss/stf-isp.h    |  9 +-
 .../staging/media/starfive/camss/stf-video.h  |  1 +
 8 files changed, 178 insertions(+), 46 deletions(-)

--
2.25.1

