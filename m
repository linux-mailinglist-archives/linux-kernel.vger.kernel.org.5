Return-Path: <linux-kernel+bounces-127680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EE3894F61
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03C781F22016
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0865F59165;
	Tue,  2 Apr 2024 10:00:39 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2136.outbound.protection.partner.outlook.cn [139.219.146.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA2359162;
	Tue,  2 Apr 2024 10:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712052037; cv=fail; b=GvHk7tVtBjYWW07cLRyxdLWSHhA6fbPA2/Ff2wjgLsN2qYDSuBaE+hftorfnQ9P9ZFH/LPnbk01aNfbWv3ufGrzskIvYbwoqPwpUcoiZE8khb5zCSoxioUqQVUc6gEZAxQKwigye1un2Ml9d7Q5SoNOc9JVLvDjSwHhwEIv78PM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712052037; c=relaxed/simple;
	bh=t1wwbQ6En8xUXhYzYmqq2z+9zQPy9336ZooTFcLUpVk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Ckay7Mp34ESQLQuTY6QPdH8upjlzg96h4INSq9VNwG9pJtBrmY7Dr/0OByQXmCpC2A8JmciuHTAZMFinXNNIjOWiX2Z81Tbqm1AtM/ZU8YshS0X/qAUNjZaKdv9fzbPyCi8DLpwSYd5LdUZBFzymQ5qJwixOubc3Zb5jtdw7Skg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cB8u03jktxbf1eFAPJy7dXf5zeCTsOlUPknH7rSl5eO7Snznqw4uSHYbdh79dgAL5vYFi3XeGYXwUmUj519ZrwurQJPUKL+8gh/rXP2Axs66fg4lFgTdo+pc8Sna23Le4DRWk0JQMWSxKX33jNcwVMbvkaLIzauW2jxet4l8xzjDMzqjkZEW6lVDu1n4h7Lx/FPvWUKOSHDaUF3MdVoG/ZnzEgouAkaxZ4T7WqEi6HQmmW1H/op97PbFPAN5L+U4/ERatWGcXEHCEG4hsK+SGq2+F5SUG8hO6FJZlOZESVE71ZuwEIGmCpPPXbutPzt4B60CPntTE0tuzBRT0zCfJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0SuzOU7rufU47RLfAuhVOhvViAzDEF4dAKF43OMPY7U=;
 b=FRU74htstj+1Pt57lYmTIdJcWWScR+qMiuKL6rbERxtI8Dw4hlBVLQCKP4M8T/WEr5AueXRyj6+FmbgWsN2FV6u+oiRDVq7fo40SxC43e+a1tj1hWCXcBgdUF94n9G5KKUQTmPitt/Mh/PzDLAmQ8NQW0DsgpvbkAFN/M9MKkUOwiJncaF+ZyyT64DGx/BHLnDq+0kTOK0BPHewZP/7pnCoocR2Jk0nh5u1v4DTVG/8ZewEVZmKS6lZiRjPl7QXvzXSh5/TNcveGldfAYcSTE2ortD7LwVbk7B08PhXl1JglYv9Ciu9GDYgqIS2Rlf1OkrwsHVMEdWp4hOQgyUrRpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0669.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:27::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.40; Tue, 2 Apr
 2024 10:00:20 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%7])
 with mapi id 15.20.7409.038; Tue, 2 Apr 2024 10:00:20 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Ming Qian <ming.qian@nxp.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
	Mingjia Zhang <mingjia.zhang@mediatek.com>,
	Marvin Lin <milkfafa@gmail.com>
Cc: Jack Zhu <jack.zhu@starfivetech.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: [PATCH v4 00/13] Add ISP 3A for StarFive
Date: Tue,  2 Apr 2024 02:59:58 -0700
Message-Id: <20240402100011.13480-1-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0005.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::11) To SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0671:EE_|SHXPR01MB0669:EE_
X-MS-Office365-Filtering-Correlation-Id: df0b0aa3-2916-4aa0-869c-08dc52fbb46f
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EMmWUmK9H4DxP6RUVrXm5NtbZSgs4XB8WE7iAOYnKjCRifMaN5P3nRG9OJXv3fLhIIm4puoyVIz3F8bu7LwJCL4na7D8BPdoT2B6SQl58fkNbV64e/1r7P1Y+IXTF1Ecq2WL+LAm/1T6wn8VZICIWKOaZEKB79eoc54bIGmikoohjZsulFPECg1oBzR2mzRAbnnIQD0OsCS1h3jLgpzEh0fHWeysApmf8tvv+LFqVFA/eXrY+cYs3WT++vg4qGyds00+LXH31XppzYJWAtoDqfPPqA++B2Vfrul9TQeRfdUQXSDpM77e07OHyQFzKuAJT1TflXFosM9f2d1Iw/D4P2Wy5ksAEz9bx4giUR5OS3H4OQ1m9cwMT8ypx08Uw/qMACpx/PB1ziu6Xw8oP2Yx30eBPhBpPjkBS6QkEKiuGRK3nXHzoM7S9ghgAS50XuPRJEqs7Gkc34PfSXffxyuUrzgPt2b1xgLm0l6IYTZ0TV4xEbptdj5S3YnZQFv0Pmx8vvlwIdkObBV1pSpNOpOUFe0cqLu5UJCXbkgshspUOuGrlwrd7YwSyo8ZNneslH7LZeo89Yks3hT0gcXbBNmIGZ1EnSe4McNVt7vSu2Fnt3coDmOQbGkWPT33bu8Wx23juBYyY+aS1mSh7KDVZzn17A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(366007)(1800799015)(52116005)(7416005)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YY+4SVn6ORk0WXH7Get6D7zmhnEb06oMzLYUuu6lc3SFSjE+X2uLk6Zl0u/S?=
 =?us-ascii?Q?6ufxn+Kg+FpXi0yO7zrfztQRMwEgm9L+8Np070J1YN1XyuEOuQtrkuGiD+P+?=
 =?us-ascii?Q?YxSdHhTLzDjkr5ZZA5FYKyNLRAZmf87S2Yk8MXRixD/UD4m4yZ0XE3ccu7nO?=
 =?us-ascii?Q?DyOQDvQJhX5Uipw3OHeWr8qlyPtFfVXRWmegbHWe0Z2gPCJE7hNwuGtLUs0X?=
 =?us-ascii?Q?PAYzeu1enIjl9B5M0lMK8Hu9lqq71D8vDcQ+zKbo27jmSESvmx8yGdLSBL5K?=
 =?us-ascii?Q?sWT+yFUBmu9Oyd6kHxe9ZFUdQMym7V/oYmtIiwcbp8KmFXuwVXOeu4k3dqwv?=
 =?us-ascii?Q?UPiKT3tUyPLTM9vD4XpVX5+xMLB0PsRIHMNTOUwivd16FMJPNJ+INJNw2WOA?=
 =?us-ascii?Q?XIVsXkIMh89F/bRDpLvTpKuoWJJbZm3DpVe4kux5S85prpyT35AWXfgL6PCA?=
 =?us-ascii?Q?3QzrzEZQk1CbantrqbabBIIGBFRO1pDDWZiPAF7qJX1hpZ7jqzUt4T1WmDJo?=
 =?us-ascii?Q?sMARsLgBc6VHOC0DbEYiVuXE9byGuMOVJBmZL1wbYOIQu4rqAWZSCK+neK9P?=
 =?us-ascii?Q?cI605W2BWnODSBl9tJyVa7KkWNFITKkbWnjBgWTAUbg8Q9qK246C/uiDOVMR?=
 =?us-ascii?Q?w6t4L0xJ7lPGKHJ3TjM74XFKkYlfaD1JsY4O03zYcd7paOYEzAukCpJoQE7K?=
 =?us-ascii?Q?MfHaITN3rJ6EtmKsu39A5OnrSGZWtyzlQyxvdVTql5sFp4Pk3e682lLmvyHr?=
 =?us-ascii?Q?gFCdNtG2hc+FFw5ezZfrk8wbx7IyjuzHNemwUsNBcbdFM23i1MtoA4gEvbid?=
 =?us-ascii?Q?yVE1XsQVbwn1UEtB2WYpbaJECW5aGmATGgku9EP2iZQCdPceS/7+0yo4ISKX?=
 =?us-ascii?Q?hGlHHPMCkDkLrM0aHoTUWwfSOYGOwN8P2CGXox+k60US/U4bQpeqBP71TWGJ?=
 =?us-ascii?Q?4P5g9vLrgI4fjbUZAg7yWYKq6zJ08vsdIP905Uv452DWbcPaVVCUJV+uqeVj?=
 =?us-ascii?Q?cLoo8KP40sWEB0d9oT4iD8TY4dDRytJHZz1u4I/z7JM0VwNWBPW0laSeiCAq?=
 =?us-ascii?Q?VMxUFsy1ZKmJlKO+tLPNMD5Ye1lQmm8kER3O4sV3ufYK+GUk+t3AGMghAhgC?=
 =?us-ascii?Q?jz9Of7OxMTebPeCG8yf67Tw+rpmBhJRcLNhdpppYhmr+6GhHLIP+LIBMw8Mg?=
 =?us-ascii?Q?0a0QcHMnrN8uOqkfrfx8hzCrYIpw/SQ49sfZPlNtXR8m3szxTAZ2GCnams6J?=
 =?us-ascii?Q?sDJ5XiVJ63SNjbB4PBYu5uYPBoCJFRjFPEiErrVrzhXHJlCYV0mtE29JPELQ?=
 =?us-ascii?Q?dYVJd2sUlyuczOhResEdNkWeE0i0wyMw2CSnrAPounpOrgRn+IpD2xlkrIXu?=
 =?us-ascii?Q?IY7HaPELeBSNqmXnpTr4Y61u2orf1nk1Crp4Y+1sxDy1FPi+lUY7boK5UdKW?=
 =?us-ascii?Q?ZVT5OiW5vys0+HhSwNE9n8SUW4i133xp1x1Pr23A960meK5wzJRJERjo4b0Q?=
 =?us-ascii?Q?wtCw/ZzOdWIttyXlECJGQMmVkMjh+e/Kkf8m8iEwgAIYNc8HuldaOv/SNwE8?=
 =?us-ascii?Q?tWJxooiPz0Kjx2rEqkXlNRHqvV5+O6nRic5vGb2tIayH44IeD5FVzJBp0tXy?=
 =?us-ascii?Q?sBsGBppaflQyCMQqoFU8abA=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df0b0aa3-2916-4aa0-869c-08dc52fbb46f
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 10:00:19.9769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O6aezZVid2cT5qo9OEgt/8oMgFFNz9JJzepEpNoCjJ8rDG30FReOhCk40uecwrw/MNX+0yfrh0dobPH176jp7GidEA45aqj2khyBUEQ6ZytuXxWjSbcrpY9akslg4nxu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0669

This series implements the ISP 3A function to the Camera Subsystem on StarFive
JH7110 SoC. The series has been tested on the VisionFive 2 board. It should be
applied after the patch [1][2]:
[1]: https://lore.kernel.org/all/20240311120309.5389-1-changhuang.liang@starfivetech.com/
[2]: https://lore.kernel.org/all/20240312024520.11022-1-changhuang.liang@starfivetech.com/

This series is based on top of the master branch of media_stage repository,
which is tested with a v4l2-compliance compiled from the git repo
(git://linuxtv.org/v4l-utils.git).

changes since v3:
- Rebsaed on  top of the master branch of media_stage repository and patch [1][2].
- Replaced "stf_get_isp_scd_type" with "stf_isp_get_scd_type" in PATCH 8.

v3: https://lore.kernel.org/all/20240205090424.40302-1-changhuang.liang@starfivetech.com/

changes since v2:
- Rebsaed on  top of the master branch of media_stage repository.
- Add helper function "media_entity_remove_links" in PATCH 8 and PATCH 11 to cleanup links.

v2: https://lore.kernel.org/all/20240111084120.16685-1-changhuang.liang@starfivetech.com/

changes since v1:
- Rebsaed on  top of the master branch of media_stage repository.
- Documentated ISP submodule.
- Add new ISP parameters format and document it.
- Add a meta output video device and link to ISP subdev.
- Replaced control with meta output video buffer for write ISP parameters.
- Separate buffer operation which can use for capture and output device.
- Drop ISP frame sync event.

v1: https://lore.kernel.org/all/20231214065027.28564-1-changhuang.liang@starfivetech.com/

The following are the media graph for the device and the v4l2-compliance
output.

==========================================================================================

[the media graph]:

digraph board {
	rankdir=TB
	n00000001 [label="{{<port0> 0 | <port1> 1} | stf_isp\n/dev/v4l-subdev0 | {<port2> 2 | <port3> 3}}", shape=Mrecord, style=filled, fillcolor=green]
	n00000001:port2 -> n0000000e
	n00000001:port3 -> n00000012 [style=dashed]
	n00000006 [label="output_params\n/dev/video0", shape=box, style=filled, fillcolor=yellow]
	n00000006 -> n00000001:port1 [style=dashed]
	n0000000a [label="capture_raw\n/dev/video1", shape=box, style=filled, fillcolor=yellow]
	n0000000e [label="capture_yuv\n/dev/video2", shape=box, style=filled, fillcolor=yellow]
	n00000012 [label="capture_scd\n/dev/video3", shape=box, style=filled, fillcolor=yellow]
	n0000001c [label="{{<port0> 0} | cdns_csi2rx.19800000.csi-bridge\n/dev/v4l-subdev1 | {<port1> 1 | <port2> 2 | <port3> 3 | <port4> 4}}", shape=Mrecord, style=filled, fillcolor=green]
	n0000001c:port1 -> n00000001:port0 [style=dashed]
	n0000001c:port1 -> n0000000a [style=dashed]
	n00000026 [label="{{} | imx219 6-0010\n/dev/v4l-subdev2 | {<port0> 0}}", shape=Mrecord, style=filled, fillcolor=green]
	n00000026:port0 -> n0000001c:port0 [style=bold]
}

[v4l2-compliance test]:

# v4l2-compliance -m /dev/media0
v4l2-compliance 1.27.0-5174, 64 bits, 64-bit time_t
v4l2-compliance SHA: d700deb14368 2024-01-18 12:19:05

Compliance test for starfive-camss device /dev/media0:

Media Driver Info:
        Driver name      : starfive-camss
        Model            : Starfive Camera Subsystem
        Serial           :
        Bus info         : platform:19840000.isp
        Media version    : 6.9.0
        Hardware revision: 0x00000000 (0)
        Driver version   : 6.9.0

Required ioctls:
        test MEDIA_IOC_DEVICE_INFO: OK
        test invalid ioctls: OK

Allow for multiple opens:
        test second /dev/media0 open: OK
        test MEDIA_IOC_DEVICE_INFO: OK
        test for unlimited opens: OK

Media Controller ioctls:
        test MEDIA_IOC_G_TOPOLOGY: OK
        Entities: 7 Interfaces: 7 Pads: 14 Links: 13
        test MEDIA_IOC_ENUM_ENTITIES/LINKS: OK
        test MEDIA_IOC_SETUP_LINK: OK

Total for starfive-camss device /dev/media0: 8, Succeeded: 8, Failed: 0, Warnings: 0
--------------------------------------------------------------------------------
Compliance test for starfive-camss device /dev/video0:

Driver Info:
        Driver name      : starfive-camss
        Card type        : Starfive Camera Subsystem
        Bus info         : platform:19840000.isp
        Driver version   : 6.9.0
        Capabilities     : 0xac200000
                Metadata Output
                I/O MC
                Streaming
                Extended Pix Format
                Device Capabilities
        Device Caps      : 0x2c200000
                Metadata Output
                I/O MC
                Streaming
                Extended Pix Format
Media Driver Info:
        Driver name      : starfive-camss
        Model            : Starfive Camera Subsystem
        Serial           :
        Bus info         : platform:19840000.isp
        Media version    : 6.9.0
        Hardware revision: 0x00000000 (0)
        Driver version   : 6.9.0
Interface Info:
        ID               : 0x03000008
        Type             : V4L Video
Entity Info:
        ID               : 0x00000006 (6)
        Name             : output_params
        Function         : V4L2 I/O
        Pad 0x01000007   : 0: Source
          Link 0x0200001a: to remote pad 0x1000003 of entity 'stf_isp' (Image Signal Processor): Data

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
        test VIDIOC_G/S/ENUMOUTPUT: OK
        test VIDIOC_G/S_AUDOUT: OK (Not Supported)
        Outputs: 1 Audio Outputs: 0 Modulators: 0

Input/Output configuration ioctls:
        test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
        test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
        test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
        test VIDIOC_G/S_EDID: OK (Not Supported)

Control ioctls (Output 0):
        test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK (Not Supported)
        test VIDIOC_QUERYCTRL: OK (Not Supported)
        test VIDIOC_G/S_CTRL: OK (Not Supported)
        test VIDIOC_G/S/TRY_EXT_CTRLS: OK (Not Supported)
        test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK (Not Supported)
        test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
        Standard Controls: 0 Private Controls: 0

Format ioctls (Output 0):
        test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
        test VIDIOC_G/S_PARM: OK (Not Supported)
        test VIDIOC_G_FBUF: OK (Not Supported)
        test VIDIOC_G_FMT: OK
        test VIDIOC_TRY_FMT: OK
        test VIDIOC_S_FMT: OK
        test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
        test Cropping: OK (Not Supported)
        test Composing: OK (Not Supported)
        test Scaling: OK (Not Supported)

Codec ioctls (Output 0):
        test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
        test VIDIOC_G_ENC_INDEX: OK (Not Supported)
        test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)

Buffer ioctls (Output 0):
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
        Driver version   : 6.9.0
        Capabilities     : 0xa4200001
                Video Capture
                I/O MC
                Streaming
                Extended Pix Format
                Device Capabilities
        Device Caps      : 0x24200001
                Video Capture
                I/O MC
                Streaming
                Extended Pix Format
Media Driver Info:
        Driver name      : starfive-camss
        Model            : Starfive Camera Subsystem
        Serial           :
        Bus info         : platform:19840000.isp
        Media version    : 6.9.0
        Hardware revision: 0x00000000 (0)
        Driver version   : 6.9.0
Interface Info:
        ID               : 0x0300000c
        Type             : V4L Video
Entity Info:
        ID               : 0x0000000a (10)
        Name             : capture_raw
        Function         : V4L2 I/O
        Pad 0x0100000b   : 0: Sink
          Link 0x02000024: from remote pad 0x100001e of entity 'cdns_csi2rx.19800000.csi' (Video Interface Bridge): Data

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
        test VIDIOC_G/S/ENUMINPUT: OK
        test VIDIOC_G/S_AUDIO: OK (Not Supported)
        Inputs: 1 Audio Inputs: 0 Tuners: 0

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

Control ioctls (Input 0):
        test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK (Not Supported)
        test VIDIOC_QUERYCTRL: OK (Not Supported)
        test VIDIOC_G/S_CTRL: OK (Not Supported)
        test VIDIOC_G/S/TRY_EXT_CTRLS: OK (Not Supported)
        test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK (Not Supported)
        test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
        Standard Controls: 0 Private Controls: 0

Format ioctls (Input 0):
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

Codec ioctls (Input 0):
        test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
        test VIDIOC_G_ENC_INDEX: OK (Not Supported)
        test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)

Buffer ioctls (Input 0):
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
        Driver version   : 6.9.0
        Capabilities     : 0xa4200001
                Video Capture
                I/O MC
                Streaming
                Extended Pix Format
                Device Capabilities
        Device Caps      : 0x24200001
                Video Capture
                I/O MC
                Streaming
                Extended Pix Format
Media Driver Info:
        Driver name      : starfive-camss
        Model            : Starfive Camera Subsystem
        Serial           :
        Bus info         : platform:19840000.isp
        Media version    : 6.9.0
        Hardware revision: 0x00000000 (0)
        Driver version   : 6.9.0
Interface Info:
        ID               : 0x03000010
        Type             : V4L Video
Entity Info:
        ID               : 0x0000000e (14)
        Name             : capture_yuv
        Function         : V4L2 I/O
        Pad 0x0100000f   : 0: Sink
          Link 0x02000016: from remote pad 0x1000004 of entity 'stf_isp' (Image Signal Processor): Data, Enabled

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
        test VIDIOC_G/S/ENUMINPUT: OK
        test VIDIOC_G/S_AUDIO: OK (Not Supported)
        Inputs: 1 Audio Inputs: 0 Tuners: 0

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

Control ioctls (Input 0):
        test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK (Not Supported)
        test VIDIOC_QUERYCTRL: OK (Not Supported)
        test VIDIOC_G/S_CTRL: OK (Not Supported)
        test VIDIOC_G/S/TRY_EXT_CTRLS: OK (Not Supported)
        test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK (Not Supported)
        test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
        Standard Controls: 0 Private Controls: 0

Format ioctls (Input 0):
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

Codec ioctls (Input 0):
        test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
        test VIDIOC_G_ENC_INDEX: OK (Not Supported)
        test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)

Buffer ioctls (Input 0):
        test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
        test CREATE_BUFS maximum buffers: OK
        test VIDIOC_EXPBUF: OK
        test Requests: OK (Not Supported)

Total for starfive-camss device /dev/video2: 47, Succeeded: 47, Failed: 0, Warnings: 0
--------------------------------------------------------------------------------
Compliance test for starfive-camss device /dev/video3:

Driver Info:
        Driver name      : starfive-camss
        Card type        : Starfive Camera Subsystem
        Bus info         : platform:19840000.isp
        Driver version   : 6.9.0
        Capabilities     : 0xa4a00000
                Metadata Capture
                I/O MC
                Streaming
                Extended Pix Format
                Device Capabilities
        Device Caps      : 0x24a00000
                Metadata Capture
                I/O MC
                Streaming
                Extended Pix Format
Media Driver Info:
        Driver name      : starfive-camss
        Model            : Starfive Camera Subsystem
        Serial           :
        Bus info         : platform:19840000.isp
        Media version    : 6.9.0
        Hardware revision: 0x00000000 (0)
        Driver version   : 6.9.0
Interface Info:
        ID               : 0x03000014
        Type             : V4L Video
Entity Info:
        ID               : 0x00000012 (18)
        Name             : capture_scd
        Function         : V4L2 I/O
        Pad 0x01000013   : 0: Sink
          Link 0x02000018: from remote pad 0x1000005 of entity 'stf_isp' (Image Signal Processor): Data

Required ioctls:
        test MC information (see 'Media Driver Info' above): OK
        test VIDIOC_QUERYCAP: OK
        test invalid ioctls: OK

Allow for multiple opens:
        test second /dev/video3 open: OK
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
        test VIDIOC_G/S/ENUMINPUT: OK
        test VIDIOC_G/S_AUDIO: OK (Not Supported)
        Inputs: 1 Audio Inputs: 0 Tuners: 0

Ostf_isp: =================  START STATUS  =================
utput ioctls:
        stf_isp: ==================  END STATUS  ==================
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

Control ioctls (Input 0):
        test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK (Not Supported)
        test VIDIOC_QUERYCTRL: OK (Not Supported)
        test VIDIOC_G/S_CTRL: OK (Not Supported)
        test VIDIOC_G/S/TRY_EXT_CTRLS: OK (Not Supported)
        test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK (Not Supported)
        test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
        Standard Controls: 0 Private Controls: 0

Format ioctls (Input 0):
        test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
        test VIDIOC_G/S_PARM: OK (Not Supported)
        test VIDIOC_G_FBUF: OK (Not Supported)
        test VIDIOC_G_FMT: OK
        test VIDIOC_TRY_FMT: OK
        test VIDIOC_S_FMT: OK
        test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
        test Cropping: OK (Not Supported)
        test Composing: OK (Not Supported)
        test Scaling: OK (Not Supported)

Codec ioctls (Input 0):
        test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
        test VIDIOC_G_ENC_INDEX: OK (Not Supported)
        test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)

Buffer ioctls (Input 0):
        test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
        test CREATE_BUFS maximum buffers: OK
        test VIDIOC_EXPBUF: OK
        test Requests: OK (Not Supported)

Total for starfive-camss device /dev/video3: 47, Succeeded: 47, Failed: 0, Warnings: 0
--------------------------------------------------------------------------------
Compliance test for starfive-camss device /dev/v4l-subdev0:

Driver Info:
        Driver version   : 6.9.0
        Capabilities     : 0x00000000
        Client Capabilities: 0x0000000000000002
interval-uses-which Media Driver Info:
        Driver name      : starfive-camss
        Model            : Starfive Camera Subsystem
        Serial           :
        Bus info         : platform:19840000.isp
        Media version    : 6.9.0
        Hardware revision: 0x00000000 (0)
        Driver version   : 6.9.0
Interface Info:
        ID               : 0x0300002a
        Type             : V4L Sub-Device
Entity Info:
        ID               : 0x00000001 (1)
        Name             : stf_isp
        Function         : Image Signal Processor
        Pad 0x01000002   : 0: Sink
          Link 0x02000022: from remote pad 0x100001e of entity 'cdns_csi2rx.19800000.csi' (Video Interface Bridge): Data
        Pad 0x01000003   : 1: Sink
          Link 0x0200001a: from remote pad 0x1000007 of entity 'output_params' (V4L2 I/O): Data
        Pad 0x01000004   : 2: Source
          Link 0x02000016: to remote pad 0x100000f of entity 'capture_yuv' (V4L2 I/O): Data, Enabled
        Pad 0x01000005   : 3: Source
          Link 0x02000018: to remote pad 0x1000013 of entity 'capture_scd' (V4L2 I/O): Data

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

Sub-Device ioctls (Sink Pad 1):
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
        test Try VIDIOC_SUBDEV_G/S_SELECTION/CROP: OK
        Active Stream 0
        test Active VIDIOC_SUBDEV_ENUM_MBUS_CODE/FRAME_SIZE/FRAME_INTERVAL: OK
        test Active VIDIOC_SUBDEV_G/S_FMT: OK
        test Active VIDIOC_SUBDEV_G/S_SELECTION/CROP: OK
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
        test Composing: OK (Notcdns_csi2rx.19800000.csi: =================  START STATUS  =================
 Supported)
        tecdns_csi2rx.19800000.csi: ==================  END STATUS  ==================
st Scaling: OK (Not Supported)

Codec ioctls:
        test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
        test VIDIOC_G_ENC_INDEX: OK (Not Supported)
        test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)

Buffer ioctls:
        test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK (Not Supported)
        test CREATE_BUFS maximum buffers: OK
        test VIDIOC_EXPBUF: OK (Not Supported)
        test Requests: OK (Not Supported)

Total for starfive-camss device /dev/v4l-subdev0: 73, Succeeded: 73, Failed: 0, Warnings: 0
--------------------------------------------------------------------------------
Compliance test for starfive-camss device /dev/v4l-subdev1:

Driver Info:
        Driver version   : 6.9.0
        Capabilities     : 0x00000000
        Client Capabilities: 0x0000000000000002
interval-uses-which Media Driver Info:
        Driver name      : starfive-camss
        Model            : Starfive Camera Subsystem
        Serial           :
        Bus info         : platform:19840000.isp
        Media version    : 6.9.0
        Hardware revision: 0x00000000 (0)
        Driver version   : 6.9.0
Interface Info:
        ID               : 0x0300002c
        Type             : V4L Sub-Device
Entity Info:
        ID               : 0x0000001c (28)
        Name             : cdns_csi2rx.19800000.csi
        Function         : Video Interface Bridge
        Pad 0x0100001d   : 0: Sink
          Link 0x02000028: from remote pad 0x1000027 of entity 'imx219 6-0010' (Camera Sensor): Data, Enabled, Immutable
        Pad 0x0100001e   : 1: Source
          Link 0x02000022: to remote pad 0x1000002 of entity 'stf_isp' (Image Signal Processor): Data
          Link 0x02000024: to remote pad 0x100000b of entity 'capture_raw' (V4L2 I/O): Data
        Pad 0x0100001f   : 2: Source
        Pad 0x01000020   : 3: Source
        Pad 0x01000021   : 4: Source

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
        Driver version   : 6.9.0
        Capabilities     : 0x00000000
        Client Capabilities: 0x0000000000000002
interval-uses-which Media Driveimx219 6-0010: =================  START STATUS  =================
r Info:
        Driverimx219 6-0010: ==================  END STATUS  ==================
 name      : starfive-camss
        Model            : Starfive Camera Subsystem
        Serial           :
        Bus info         : platform:19840000.isp
        Media version    : 6.9.0
        Hardware revision: 0x00000000 (0)
        Driver version   : 6.9.0
Interface Info:
        ID               : 0x0300002e
        Type             : V4L Sub-Device
Entity Info:
        ID               : 0x00000026 (38)
        Name             : imx219 6-0010
        Function         : Camera Sensor
        Pad 0x01000027   : 0: Source
          Link 0x02000028: to remote pad 0x100001d of entity 'cdns_csi2rx.19800000.csi' (Video Interface Bridge): Data, Enabled, Immutable

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

Grand Total for starfive-camss device /dev/media0: 401, Succeeded: 401, Failed: 0, Warnings: 2

Two warnings are from the imx219, can ignore them.

Changhuang Liang (13):
  media: starfive: Add JH7110 ISP module definitions
  media: Documentation: Add description for StarFive ISP metadata
    formats
  media: videodev2.h, v4l2-ioctl: Add StarFive ISP meta buffer format
  staging: media: starfive: Add a params sink pad and a scd source pad
    for ISP
  staging: media: starfive: Separate buffer from ISP hardware operation
  staging: media: starfive: Separate buffer be a common file
  staging: media: starfive: Separate ISP hardware from capture device
  staging: media: starfive: Add for StarFive ISP 3A SC
  staging: media: starfive: Update ISP initialise config for 3A
  staging: media: starfive: Add V4L2_CAP_IO_MC capability
  staging: media: starfive: Add ISP params video device
  staging: media: starfive: Add ISP parameters hardware configure
  admin-guide: media: Update documents for StarFive Camera Subsystem

 .../admin-guide/media/starfive_camss.rst      |  11 +-
 .../media/starfive_camss_graph.dot            |  22 +-
 .../media/v4l/metafmt-starfive-isp.rst        |  75 ++
 MAINTAINERS                                   |   2 +
 drivers/media/v4l2-core/v4l2-ioctl.c          |   2 +
 drivers/staging/media/starfive/camss/Makefile |   3 +
 .../staging/media/starfive/camss/stf-buffer.c | 166 ++++
 .../staging/media/starfive/camss/stf-buffer.h |  53 ++
 .../staging/media/starfive/camss/stf-camss.c  |  36 +-
 .../staging/media/starfive/camss/stf-camss.h  |  12 +
 .../media/starfive/camss/stf-capture.c        | 248 +-----
 .../media/starfive/camss/stf-capture.h        |  22 -
 .../media/starfive/camss/stf-isp-hw-ops.c     | 720 +++++++++++++++++
 .../media/starfive/camss/stf-isp-params.c     | 238 ++++++
 .../staging/media/starfive/camss/stf-isp.c    |  77 +-
 .../staging/media/starfive/camss/stf-isp.h    | 188 +++++
 .../staging/media/starfive/camss/stf-output.c |  83 ++
 .../staging/media/starfive/camss/stf-output.h |  22 +
 .../staging/media/starfive/camss/stf-video.c  | 143 +++-
 .../staging/media/starfive/camss/stf-video.h  |  11 +-
 include/uapi/linux/jh7110-isp.h               | 739 ++++++++++++++++++
 include/uapi/linux/videodev2.h                |   4 +
 22 files changed, 2599 insertions(+), 278 deletions(-)
 create mode 100644 Documentation/userspace-api/media/v4l/metafmt-starfive-isp.rst
 create mode 100644 drivers/staging/media/starfive/camss/stf-buffer.c
 create mode 100644 drivers/staging/media/starfive/camss/stf-buffer.h
 create mode 100644 drivers/staging/media/starfive/camss/stf-isp-params.c
 create mode 100644 drivers/staging/media/starfive/camss/stf-output.c
 create mode 100644 drivers/staging/media/starfive/camss/stf-output.h
 create mode 100644 include/uapi/linux/jh7110-isp.h

--
2.25.1

