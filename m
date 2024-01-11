Return-Path: <linux-kernel+bounces-23256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 958AA82A9D4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF5A61F23D64
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8232013AC5;
	Thu, 11 Jan 2024 08:56:14 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2063.outbound.protection.partner.outlook.cn [139.219.146.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A581AFC0E;
	Thu, 11 Jan 2024 08:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gEnjmNeL2cCOk2LFMuDpoh7T8nfE3Kxx9sUUjUcVq8BW00mOBi46zbJb8MZcKlXK7cErGtdx5wOOXNbHrqcEXDqKLsC/6gtrbIGqTfKMipZHAKxsEwOAp0BvfDcHKevgyhZsfPkc43nE3L9+jhHD30atV7wllh6uH36LQrH47LnGxz2ntgHAUwM9vz+GmplbtlYtNHyPtTg/r5JRGUmTah9Dsx6iDRVtwPA9bqqXPhx+lTyPmUeknUkgvRlzgCuJZhRaz4qQ3RhBBe7Wj1fDO/N16wq9xbhXN4IiqL8jMqCjKDLb/4U1MSxm/t/9oE7M2MXkUAnOOYpNfdyQ1w32vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vwDolsvXpAoy5p1L1hvgmE+BWfdmMH0psJ6Y1SGUKXw=;
 b=Cn3AO5AGKJB3qc+UmPd35ieLKU7CNEa7BLPq0sAKWjuYXkmZouli5LeCI1WeGKdU1DytKtVqpeBibZ0yyc9lscoDrTD6heDOBAmrT2lklVkUNRzpZGeDnxMFRw1GUMdeQJDWRlBZYFyMk/wQayY+qZgKWskeDwXig8pfXmlmHkyWp1XXGozvGlNpqu2/r0Q+6/wnNtxT2w2LZfhDjEJKE5poBx2DecNYJWU4gHD1Zq96APK7tAQy4Z1QV4FCsT2ulA1tiipaN51Zg9bifZDsnxqUzHdnsJg9VGyLaXEH8Pa4gJbiCqXfl/uEGoV4vyYxBQmYaaNlDdEz/XENCr5Chg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::21) by SH0PR01MB0747.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:21::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.33; Thu, 11 Jan
 2024 08:41:27 +0000
Received: from SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn
 ([fe80::e255:98f3:ba27:8c7d]) by
 SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn ([fe80::e255:98f3:ba27:8c7d%3])
 with mapi id 15.20.7135.033; Thu, 11 Jan 2024 08:41:27 +0000
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
	Mingjia Zhang <mingjia.zhang@mediatek.com>
Cc: Jack Zhu <jack.zhu@starfivetech.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: [PATCH v2 00/13] Add ISP 3A for StarFive
Date: Thu, 11 Jan 2024 00:41:07 -0800
Message-Id: <20240111084120.16685-1-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0009.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::19) To SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SH0PR01MB0667:EE_|SH0PR01MB0747:EE_
X-MS-Office365-Filtering-Correlation-Id: 815d9910-d713-407d-4319-08dc128119ff
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LU+NkmGng+z7B7JHtM8LPXviZayIbtqawnZCBHsg3FxKzzpPwhBNT1XruwfNmAl7NRrZjRA2/j7XmBy0fGwstzyGNMykXj4zA33nL6Ny9mxKHA6uu60EPvtWrqVEOpeTDiyQYj8yEuZ3/5p56/6XBxjP7eY43FAxnKVVQxSWgpMsBMLH6neI1V3NFbT5mP9erAZYU02P80s8RV6rc1U57Idz7XHGCfegadqjXYI/Kyvg8ZT/v1h5t8l+fookg+OvhzZdGN8tttr8OAZZAtB7S2aMX3pct/IT8LQJ2yB2TisrvLsNO/e5eQthx772nEtt3+IPaEJ2h9DgN7qcbAJBgejn+Jz2iORRg8r4IKfNXG469S2AY9F5ZRQAmv4wEAhPf93lYkzp8d+2t+FRHrlmKoFNflJCaDmO4cGDFuzKPbrlzCNS1aw3rmQ3jmvOIlR9DyENNtzaXW+0jt1S311canGAdgqm9hOc4qGIyI4dYkwPFye97CZ+WR4QrpFSDALR8g3rPFpm1XnA8dArF43XoRhRBortxiiY8AHCXxnhOyj5/bQCRrcfxtW16VBRw8qow5jGC9vAIhdUSwaYAYy78uKzTr7JLgaL0DYjbZhGqJQ84jrKFfX7Df7hZSxhKS5q
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(136003)(39830400003)(230273577357003)(230173577357003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(6666004)(52116002)(966005)(41300700001)(2616005)(508600001)(38100700002)(40160700002)(1076003)(26005)(86362001)(36756003)(921011)(38350700005)(83380400001)(110136005)(54906003)(66556008)(66946007)(66476007)(8676002)(8936002)(41320700001)(4326008)(44832011)(2906002)(40180700001)(5660300002)(30864003)(7416002)(579004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y3tIMSNdBJvK55Rg2JjD0xQYpwND4PUpGi/YynNY2sx1PGLFvSlWxabB0sBG?=
 =?us-ascii?Q?unxcHnmVS6YSthqtiDj9hjAyyxGnB0gTz2wnzSs1PY3bFtl0ELl+F2VmXCMG?=
 =?us-ascii?Q?F8Ie4ZRb2VYeBQs11G1WgAQ2UE/XO4OKMHtQJ1BYk/5EaCCApDlspN7Es9WD?=
 =?us-ascii?Q?8yfu/cWQAuOExHidg87G0cdQK8U4loTOTfxnBtula5NBY2GIOb5yfVGLL7Lv?=
 =?us-ascii?Q?Zlqo39gAu1XxfP7pn/31VQg5yUADLDaWMxr7aCBMvZS79hliPcj3EmNFCTxW?=
 =?us-ascii?Q?7zPqdli3s2XDfByLpbpITyt/HAhvLVqYRNOQrg2IiO7Ts8IP1fbCmI69rk2k?=
 =?us-ascii?Q?WHqjx2027rLVr54lI/8y3NBdrxEt9b6ntVG+9KMoh8Dr9nwciEPAU9Amg+3q?=
 =?us-ascii?Q?0nrxAP+hjT+i+CQFf5br02L5WsChlFMcSVClW8D+HlND0iRzOIBvLwKXTL0x?=
 =?us-ascii?Q?Yitdi0fLGWdLV4Io0Korji3zqHtCkd9CDTH8y7u/rS8DkddP/dGohSZsLfOl?=
 =?us-ascii?Q?+zjORr1jbACd0EV81PXrhAVg8nLpHDgI7x2n3GIWbnpTdmKsonSqD6LARiV2?=
 =?us-ascii?Q?sDSBanE7hTNe7M12C3Eja5UE8NKTMIjKciKekb4uhkPiHds4UupY4MyobChV?=
 =?us-ascii?Q?ysZwpAHN/N18JPv43dK/J+zFyAHgScE6TvSXelwwN1MCnVRFrYGPkudKvtSO?=
 =?us-ascii?Q?hHRN7hxZDUjp2KWAsMICpqZq8y7nF+ZYftOVQQ6A5GDk5YNDZNpdK0jUzYcN?=
 =?us-ascii?Q?c4wItfdsjqpRUEXeGRUvQ+NjbxzjQJtMRvQWFesT7jr8Y+fkA7uIrDJxsMpa?=
 =?us-ascii?Q?9eF4GNbg+K0A6KU0b5wsvqSYQo8bFdsdIStojQqMvs7TQVglAs1vxhMfEl/+?=
 =?us-ascii?Q?6v5wY5hkTKxW4NwsxJyfrFpPyL2t8im6cbDXn27PjHPKbO/YGlX0b7epPGGD?=
 =?us-ascii?Q?EVs6ps1ff8YnUzfCVAEhxhWt/+8qI2XxK2eYxcftzMHRlCeIV8LTjofEZ1c/?=
 =?us-ascii?Q?sri/klggwvcJLYULKcbtC/BD+iJPlidvGng0D4pzygKwN8dKOSMAcC6CBBCV?=
 =?us-ascii?Q?odrvr+Tbvt1KRquprJwGEEncziEZzdmVsoiJF0ASnsLv07r2zG+0a4F8AmAP?=
 =?us-ascii?Q?vkPq/IQ09r3npibhabCHnFlXMmxv3EcoxjwohmNEZbJBmt5H0BI10MHQ/kWv?=
 =?us-ascii?Q?T7U5gbn9Pq3DfgB+sofVCxSHRXCcRm0F5NaO43qf7H/qVhLfB02BWbApvGpl?=
 =?us-ascii?Q?JXVeVh7ixp8YFqpYVbhgHyly/LllUsCmjFwXS+9xTsxt0aE8Jp/4SurvWuAr?=
 =?us-ascii?Q?vnJ+oRPe4dWqFqRWDSwP7nQYBRH6HNHmaZBem1lkf19vJy8ZLrs7NZzmAmzX?=
 =?us-ascii?Q?JVZS+Rmmbf7jobDQh58QHcb71I8tnrZRf4asGPTUxfGzNT69p5wMBHC0pi1t?=
 =?us-ascii?Q?Tpddk7+z3VRYOjOzuWxi0PdvSPQptKfJoXdWBF1ZD9eTW/m5NiV61gBWKFO/?=
 =?us-ascii?Q?TV7gArycWHvl3jqZzLKLyYT78w7qkNddpehujt1iT4AnaQWB0FBckpbr8To8?=
 =?us-ascii?Q?If+oXn5h4Wi+J5y1UY4vUNwzyayKCAPqQhoNdHSFq6OQ9RPZNMqKyV4KnZRV?=
 =?us-ascii?Q?VQPsZls8cpoMlI62TSA9wk4=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 815d9910-d713-407d-4319-08dc128119ff
X-MS-Exchange-CrossTenant-AuthSource: SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 08:41:27.7557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8AFa7F4OawTrXRt/YySTsCY5xV4HmcuZmgNpp4ZdeQouvH7gjuwyI6QRKZ4KtfLLuO9e2B/1ecXVLJvJESRB5pqWRvHkHS20OqeaGGsYQkTKajFwBeZgkt2X6VUYF3N6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SH0PR01MB0747

This series implements the ISP 3A function to the Camera Subsystem on StarFive
JH7110 SoC. The series has been tested on the VisionFive 2 board.

This series is based on top of the master branch of media_stage repository,
which is tested with a v4l2-compliance compiled from the git repo
(git://linuxtv.org/v4l-utils.git).

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

# v4l2-compliance  -m /dev/media0
v4l2-compliance 1.27.0, 64 bits, 64-bit time_t

Compliance test for starfive-camss device /dev/media0:

Media Driver Info:
        Driver name      : starfive-camss
        Model            : Starfive Camera Subsystem
        Serial           :
        Bus info         : platform:19840000.camss
        Media version    : 6.7.0
        Hardware revision: 0x00000000 (0)
        Driver version   : 6.7.0

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
        Bus info         : platform:19840000.camss
        Driver version   : 6.7.0
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
        Bus info         : platform:19840000.camss
        Media version    : 6.7.0
        Hardware revision: 0x00000000 (0)
        Driver version   : 6.7.0
Interface Info:
        ID               : 0x03000008
        Type             : V4L Video
Entity Info:
        ID               : 0x00000006 (6)
        Name             : output_params
        Function         : V4L2 I/O
        Pad 0x01000007   : 0: Source
          Link 0x02000016: to remote pad 0x1000003 of entity 'stf_isp' (Image Signal Processor): Data

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
        Bus info         : platform:19840000.camss
        Driver version   : 6.7.0
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
        Bus info         : platform:19840000.camss
        Media version    : 6.7.0
        Hardware revision: 0x00000000 (0)
        Driver version   : 6.7.0
Interface Info:
        ID               : 0x0300000c
        Type             : V4L Video
Entity Info:
        ID               : 0x0000000a (10)
        Name             : capture_raw
        Function         : V4L2 I/O
        Pad 0x0100000b   : 0: Sink
          Link 0x02000024: from remote pad 0x100001e of entity 'cdns_csi2rx.19800000.csi-bridge' (Video Interface Bridge): Data

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
        Bus info         : platform:19840000.camss
        Driver version   : 6.7.0
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
        Bus info         : platform:19840000.camss
        Media version    : 6.7.0
        Hardware revision: 0x00000000 (0)
        Driver version   : 6.7.0
Interface Info:
        ID               : 0x03000010
        Type             : V4L Video
Entity Info:
        ID               : 0x0000000e (14)
        Name             : capture_yuv
        Function         : V4L2 I/O
        Pad 0x0100000f   : 0: Sink
          Link 0x02000018: from remote pad 0x1000004 of entity 'stf_isp' (Image Signal Processor): Data

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
        Bus info         : platform:19840000.camss
        Driver version   : 6.7.0
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
        Bus info         : platform:19840000.camss
        Media version    : 6.7.0
        Hardware revision: 0x00000000 (0)
        Driver version   : 6.7.0
Interface Info:
        ID               : 0x03000014
        Type             : V4L Video
Entity Info:
        ID               : 0x00000012 (18)
        Name             : capture_scd
        Function         : V4L2 I/O
        Pad 0x01000013   : 0: Sink
          Link 0x0200001a: from remote pad 0x1000005 of entity 'stf_isp' (Image Signal Processor): Data

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
        test Scaling: OK (Not Supported)

Codecstf_isp: =================  START STATUS  =================
 ioctls (Input 0stf_isp: ==================  END STATUS  ==================
):
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
        Driver version   : 6.7.0
        Capabilities     : 0x00000000
Media Driver Info:
        Driver name      : starfive-camss
        Model            : Starfive Camera Subsystem
        Serial           :
        Bus info         : platform:19840000.camss
        Media version    : 6.7.0
        Hardware revision: 0x00000000 (0)
        Driver version   : 6.7.0
Interface Info:
        ID               : 0x0300002a
        Type             : V4L Sub-Device
Entity Info:
        ID               : 0x00000001 (1)
        Name             : stf_isp
        Function         : Image Signal Processor
        Pad 0x01000002   : 0: Sink
          Link 0x02000022: from remote pad 0x100001e of entity 'cdns_csi2rx.19800000.csi-bridge' (Video Interface Bridge): Data
        Pad 0x01000003   : 1: Sink
          Link 0x02000016: from remote pad 0x1000007 of entity 'output_params' (V4L2 I/O): Data
        Pad 0x01000004   : 2: Source
          Link 0x02000018: to remote pad 0x100000f of entity 'capture_yuv' (V4L2 I/O): Data
        Pad 0x01000005   : 3: Source
          Link 0x0200001a: to remote pad 0x1000013 of entity 'capture_scd' (V4L2 I/O): Data

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
        test VIDIOC_SUBDEV_G/S_FRAME_INTERVAL: OK (Not Supported)

Sub-Device ioctls (Sink Pad 1):
        Try Stream 0
        test Try VIDIOC_SUBDEV_ENUM_MBUS_CODE/FRAME_SIZE/FRAME_INTERVAL: OK
        test Try VIDIOC_SUBDEV_G/S_FMT: OK
        test Try VIDIOC_SUBDEV_G/S_SELECTION/CROP: OK (Not Supported)
        Active Stream 0
        test Active VIDIOC_SUBDEV_ENUM_MBUS_CODE/FRAME_SIZE/FRAME_INTERVAL: OK
        test Active VIDIOC_SUBDEV_G/S_FMT: OK
        test Active VIDIOC_SUBDEV_G/S_SELECTION/CROP: OK (Not Supported)
        test VIDIOC_SUBDEV_G/S_FRAME_INTERVAL: OK (Not Supported)

Sub-Device ioctls (Source Pad 2):
        Try Stream 0
        test Try VIDIOC_SUBDEV_ENUM_MBUS_CODE/FRAME_SIZE/FRAME_INTERVAL: OK
        test Try VIDIOC_SUBDEV_G/S_FMT: OK
        test Try VIDIOC_SUBDEV_G/S_SELECTION/CROP: OK
        Active Stream 0
        test Active VIDIOC_SUBDEV_ENUM_MBUS_CODE/FRAME_SIZE/FRAME_INTERVAL: OK
        test Active VIDIOC_SUBDEV_G/S_FMT: OK
        test Active VIDIOC_SUBDEV_G/S_SELECTION/CROP: OK
        test VIDIOC_SUBDEV_G/S_FRAME_INTERVAL: OK (Not Supported)

Sub-Device ioctls (Source Pad 3):
        Try Stream 0
        test Try VIDIOC_SUBDEV_ENUM_MBUS_CODE/FRAME_SIZE/FRAME_INTERVAL: OK
        test Try VIDIOC_SUBDEV_G/S_FMT: OK
        test Try VIDIOC_SUBDEV_G/S_SELECTION/CROP: OK (Not Supported)
        Active Stream 0
        test Active VIDIOC_SUBDEV_ENUM_MBUS_CODE/FRAME_SIZE/FRAME_INTERVAL: OK
        test Active VIDIOC_SUBDEV_G/S_FMT: OK
        test Active VIDIOC_SUBDEV_G/S_SELECTION/CROP: OK (Not Supported)
        test VIDIOC_SUBDEV_G/S_FRAME_INTERVAL: OK (Not Supported)

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

Total for starfive-camss device /dev/v4l-subdev0: 73, Succeeded: 73, Failed: 0, Warnings: 0
--------------------------------------------------------------------------------
Compliance test for starfive-camss device /dev/v4l-subdev1:

Driver Info:
        Driver version   : 6.7.0
        Capabilities     : 0x00000000
Media Driver Info:
        Driver name      : starfive-camss
        Model            : Starfive Camera Subsystem
        Serial           :
        Bus info         : platform:19840000.camss
        Media version    : 6.7.0
        Hardware revision: 0x00000000 (0)
        Driver version   : 6.7.0
Interface Info:
        ID               : 0x0300002c
        Type             : V4L Sub-Device
Entity Info:
        ID               : 0x0000001c (28)
        Name             : cdns_csi2rx.19800000.csi-bridge
        Function         : Video Interface Bridge
        Pad 0x0100001d   : 0: Sink
          Link 0x02000028: from remote pad 0x1000027 of entity 'imx219 6-0010' (Camera Sensor): Data, Enabled, Immutable
        Pad 0x0100001e   : 1: Source
          Link 0x02000022: to remote pad 0x1000002 of entity 'stf_isp' (Image Signal Processor): Data
          Link 0x02000024: to remote pad 0x100000b of entity 'captcdns_csi2rx.19800000.csi-bridge: =================  START STATUS  =================
ure_raw' (V4L2 Icdns_csi2rx.19800000.csi-bridge: ==================  END STATUS  ==================
/O): Data
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
        test Try VIDIOC_SUBDEV_ENUM_MBUS_CODE/FRAME_SIZE/FRAME_INTERVAL: OK (Not Supported)
        test Try VIDIOC_SUBDEV_G/S_FMT: OK
        test Try VIDIOC_SUBDEV_G/S_SELECTION/CROP: OK (Not Supported)
        Active Stream 0
        test Active VIDIOC_SUBDEV_ENUM_MBUS_CODE/FRAME_SIZE/FRAME_INTERVAL: OK (Not Supported)
        test Active VIDIOC_SUBDEV_G/S_FMT: OK
        test Active VIDIOC_SUBDEV_G/S_SELECTION/CROP: OK (Not Supported)
        test VIDIOC_SUBDEV_G/S_FRAME_INTERVAL: OK (Not Supported)

Sub-Device ioctls (Source Pad 1):
        Try Stream 0
        test Try VIDIOC_SUBDEV_ENUM_MBUS_CODE/FRAME_SIZE/FRAME_INTERVAL: OK (Not Supported)
        test Try VIDIOC_SUBDEV_G/S_FMT: OK
        test Try VIDIOC_SUBDEV_G/S_SELECTION/CROP: OK (Not Supported)
        Active Stream 0
        test Active VIDIOC_SUBDEV_ENUM_MBUS_CODE/FRAME_SIZE/FRAME_INTERVAL: OK (Not Supported)
        test Active VIDIOC_SUBDEV_G/S_FMT: OK
        test Active VIDIOC_SUBDEV_G/S_SELECTION/CROP: OK (Not Supported)
        test VIDIOC_SUBDEV_G/S_FRAME_INTERVAL: OK (Not Supported)

Sub-Device ioctls (Source Pad 2):
        Try Stream 0
        test Try VIDIOC_SUBDEV_ENUM_MBUS_CODE/FRAME_SIZE/FRAME_INTERVAL: OK (Not Supported)
        test Try VIDIOC_SUBDEV_G/S_FMT: OK
        test Try VIDIOC_SUBDEV_G/S_SELECTION/CROP: OK (Not Supported)
        Active Stream 0
        test Active VIDIOC_SUBDEV_ENUM_MBUS_CODE/FRAME_SIZE/FRAME_INTERVAL: OK (Not Supported)
        test Active VIDIOC_SUBDEV_G/S_FMT: OK
        test Active VIDIOC_SUBDEV_G/S_SELECTION/CROP: OK (Not Supported)
        test VIDIOC_SUBDEV_G/S_FRAME_INTERVAL: OK (Not Supported)

Sub-Device ioctls (Source Pad 3):
        Try Stream 0
        test Try VIDIOC_SUBDEV_ENUM_MBUS_CODE/FRAME_SIZE/FRAME_INTERVAL: OK (Not Supported)
        test Try VIDIOC_SUBDEV_G/S_FMT: OK
        test Try VIDIOC_SUBDEV_G/S_SELECTION/CROP: OK (Not Supported)
        Active Stream 0
        test Active VIDIOC_SUBDEV_ENUM_MBUS_CODE/FRAME_SIZE/FRAME_INTERVAL: OK (Not Supported)
        test Active VIDIOC_SUBDEV_G/S_FMT: OK
        test Active VIDIOC_SUBDEV_G/S_SELECTION/CROP: OK (Not Supported)
        test VIDIOC_SUBDEV_G/S_FRAME_INTERVAL: OK (Not Supported)

Sub-Device ioctls (Source Pad 4):
        Try Stream 0
        test Try VIDIOC_SUBDEV_ENimx219 6-0010: =================  START STATUS  =================
UM_MBUS_CODE/FRAimx219 6-0010: ==================  END STATUS  ==================
ME_SIZE/FRAME_INTERVAL: OK (Not Supported)
        test Try VIDIOC_SUBDEV_G/S_FMT: OK
        test Try VIDIOC_SUBDEV_G/S_SELECTION/CROP: OK (Not Supported)
        Active Stream 0
        test Active VIDIOC_SUBDEV_ENUM_MBUS_CODE/FRAME_SIZE/FRAME_INTERVAL: OK (Not Supported)
        test Active VIDIOC_SUBDEV_G/S_FMT: OK
        test Active VIDIOC_SUBDEV_G/S_SELECTION/CROP: OK (Not Supported)
        test VIDIOC_SUBDEV_G/S_FRAME_INTERVAL: OK (Not Supported)

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
        Driver version   : 6.7.0
        Capabilities     : 0x00000000
Media Driver Info:
        Driver name      : starfive-camss
        Model            : Starfive Camera Subsystem
        Serial           :
        Bus info         : platform:19840000.camss
        Media version    : 6.7.0
        Hardware revision: 0x00000000 (0)
        Driver version   : 6.7.0
Interface Info:
        ID               : 0x0300002e
        Type             : V4L Sub-Device
Entity Info:
        ID               : 0x00000026 (38)
        Name             : imx219 6-0010
        Function         : Camera Sensor
        Pad 0x01000027   : 0: Source
          Link 0x02000028: to remote pad 0x100001d of entity 'cdns_csi2rx.19800000.csi-bridge' (Video Interface Bridge): Data, Enabled, Immutable

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
                warn: v4l2-test-subdevs.cpp(541): VIDIOC_SUBDEV_G_SELECTION is supported for target 0 but not VIDIOC_SUBDEV_S_SELECTION
        test Try VIDIOC_SUBDEV_G/S_SELECTION/CROP: OK
        Active Stream 0
        test Active VIDIOC_SUBDEV_ENUM_MBUS_CODE/FRAME_SIZE/FRAME_INTERVAL: OK
        test Active VIDIOC_SUBDEV_G/S_FMT: OK
                warn: v4l2-test-subdevs.cpp(541): VIDIOC_SUBDEV_G_SELECTION is supported for target 0 but not VIDIOC_SUBDEV_S_SELECTION
        test Active VIDIOC_SUBDEV_G/S_SELECTION/CROP: OK
        test VIDIOC_SUBDEV_G/S_FRAME_INTERVAL: OK (Not Supported)

Control ioctls:
        test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK
        test VIDIOC_QUERYCTRL: OK
        test VIDIOC_G/S_CTRL: OK
        test VIDIOC_G/S/TRY_EXT_CTRLS: OK
        test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK
        test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
        Standard Controls: 20 Private Controls: 0

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
 .../staging/media/starfive/camss/stf-camss.c  |  27 +-
 .../staging/media/starfive/camss/stf-camss.h  |  12 +
 .../media/starfive/camss/stf-capture.c        | 248 +-----
 .../media/starfive/camss/stf-capture.h        |  22 -
 .../media/starfive/camss/stf-isp-hw-ops.c     | 720 +++++++++++++++++
 .../media/starfive/camss/stf-isp-params.c     | 238 ++++++
 .../staging/media/starfive/camss/stf-isp.c    |  87 ++-
 .../staging/media/starfive/camss/stf-isp.h    | 188 +++++
 .../staging/media/starfive/camss/stf-output.c |  83 ++
 .../staging/media/starfive/camss/stf-output.h |  22 +
 .../staging/media/starfive/camss/stf-video.c  | 143 +++-
 .../staging/media/starfive/camss/stf-video.h  |  11 +-
 include/uapi/linux/jh7110-isp.h               | 739 ++++++++++++++++++
 include/uapi/linux/videodev2.h                |   4 +
 22 files changed, 2592 insertions(+), 286 deletions(-)
 create mode 100644 Documentation/userspace-api/media/v4l/metafmt-starfive-isp.rst
 create mode 100644 drivers/staging/media/starfive/camss/stf-buffer.c
 create mode 100644 drivers/staging/media/starfive/camss/stf-buffer.h
 create mode 100644 drivers/staging/media/starfive/camss/stf-isp-params.c
 create mode 100644 drivers/staging/media/starfive/camss/stf-output.c
 create mode 100644 drivers/staging/media/starfive/camss/stf-output.h
 create mode 100644 include/uapi/linux/jh7110-isp.h

--
2.25.1

