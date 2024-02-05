Return-Path: <linux-kernel+bounces-52244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 756BC8495DB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A8F11F2061E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5598C12E71;
	Mon,  5 Feb 2024 09:04:56 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2114.outbound.protection.partner.outlook.cn [139.219.146.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60CD12B6E;
	Mon,  5 Feb 2024 09:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707123893; cv=fail; b=lJUx7AtPY0cV6jbRXUpXQqRbPfHbq77B09kpRYy/LZPMTRlqKaAKzfUvXQOJvKW10BILd/gcN8fYvIRICoAP5SIrwq/6AKv0wmqP+t8czSj8Nt4wG/e4TmbxQOpU6njnc6+Bd1nufyTOklgT/1yhgzr0I140cRYN/W8Mm0jIPWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707123893; c=relaxed/simple;
	bh=bqYNC0k2Oc5WoG8kQVO3vv/H6dbsjdXINtlVtnl0NtQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Gx41mLOiUqx4PBlJeUw88cTRfDdyX1qkk58hRBnRCJI1L78pi2Z/c06fJIGhRocKQamE5MjYsGslgtzmdOFLx/0a/zcnwEie5GLZd0sDsGp4iyByirAG8VxQcF47FiknIWwPudqIji0ZDEHdiCFkLRCPqZadeBjPa/jFni7LewI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SpqoEIvFyXcz1jc2KPscVfBCMwnZk316/tdoHiGNIgpjLARFjx6mvtFT8MTGFzt42lxAbMs0DxB9gg0txDIDcWcVpnz9IFQXpjzrEtxg+n+NDB2sFJgOOtXWxbgH7Kfdu0oYz7Ce/SNBUoibycVmlVP2ZhFiGdOCt0niJFCL5Qp/XAx1wOcNspj3InX2ID30u7moY7gKOL/8Gu3wORvQzCnquXPfVJvvKeWgqylYGQIkiY+6TKJT9TB3Nu2Ae+IcJxaco1UmotZsW5F74dOb5eUcXwhJm7zP1ZRmBsju89mCfJHNaBvGwIx+x2oMNqdIT/Je49SvcAtuEoxi1q1SYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q6gOgl7IRwhmiAG4SWWFFfu2lpFY+PhoEnkVSWfhAKM=;
 b=iDZXpIPm6M0r8Ysky+bz9tWpXjqCgFcGY5jF142+z+Lqp/XiUDOPlZ/SOO2TXmqJy3Van9Bocu6ldeHR3SUfULvAfieVnbtlToStnJW5g+9PyOACUFljwELg5HZQph7tgiWws836KkSd9BnD8CMPZkY8QeqHcnqtxZSvtACvHT0IJG/GLBJEGfmvgSAYAigfUZPz648SfLpauhTd3CRabLN6U9hGNXqfXh/6KE6HZAeoqDHRNeE3kZ/lkGkWhKxRE4LBb8eJiJXSM4vsQfb4bSD3kCAVcKYHkvpD+IQdCdcVGGAbyshI/wGb7Ah0ecN9yUaYXyZx1Asa/pyDzTRDdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0751.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:24::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Mon, 5 Feb
 2024 09:04:33 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%6])
 with mapi id 15.20.7249.025; Mon, 5 Feb 2024 09:04:33 +0000
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
Subject: [PATCH v3 00/13] Add ISP 3A for StarFive
Date: Mon,  5 Feb 2024 01:04:11 -0800
Message-Id: <20240205090424.40302-1-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0022.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::23) To SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0671:EE_|SHXPR01MB0751:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f528a2d-0b6a-4174-d9e5-08dc26297800
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MmwZVfvZcm0ej7NY+zyYclvecYiUtCGLvXxxaX5i0jQc+cpN1xcmNZprXWdFgjfA11UTjI/ZIEri62Mp3HU2XrMTDiVZme8upiL2qpZ85OcdWogrmREa9bhrKuMRl9OgM33rV11IIqSrT2wRbJ8EDy2/ZKqLrgi/2/T45SCTYVxa1zlhHiYYHlFPAPDEJgRIzZYQFEGkkrU7NzqCN/DTIsSCD0OgyHmHOqGFwNoTfxmR7rY1VJOSiIG7Xv/ziZDMmiajTPlc7n7QdosFxvWC1pRExCneq9/6/1+jChOSyt0AgNdseiI5Td8LErkwUIQb02rWC7LydLYtP6Sa2JUSl+X4ZszAVG87ed6l0JhSF+uzPx8Mx6h2ckdy63LWGd8OT/qCIWfeztkTzkDA7/o76C8LBFJ4YtqXUMFE5aScawLBDLhrwS64NHcKa9H0WB8bOGMfsFBLEpWn6eclnAo/ryZF9R20ee/s3WasorgVMoPb90DlH9R7dIHWgfpUYjzUU2EYPUEc1KGU20HUhCvq5eaZR73Z2L/tF5f1aTn9LJ1ftKCrfYB98W3KnZe3iEp2MJteqOKQBJGfihj+Q2eqFw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(136003)(39830400003)(346002)(366004)(396003)(230922051799003)(230273577357003)(1800799012)(64100799003)(186009)(451199024)(8936002)(8676002)(44832011)(4326008)(5660300002)(54906003)(66556008)(2906002)(66476007)(66946007)(7416002)(30864003)(110136005)(41320700001)(921011)(508600001)(966005)(26005)(2616005)(52116002)(1076003)(36756003)(38350700005)(83380400001)(6666004)(40180700001)(41300700001)(86362001)(38100700002)(40160700002)(579004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nuI2y4T1d4Us3FwsbNVBy5c7E0E5MHpinpbuaiU5OcqyPj7lJ4RQ6Qw5qFSU?=
 =?us-ascii?Q?duYJhwGR0W3HlQy+oDX2HXYAFjEqD4yUhrvfsJJ9C7Jbh5Z4jByYAVGOyICD?=
 =?us-ascii?Q?O+jAWuM00ZXVEWS/Kt/tGAUzReIpvw0tXmtnot/xYlKq5YuPhuziDnVY9QIX?=
 =?us-ascii?Q?Tq7Q62UqGqDOXvpahFjnq8gnUnEk75qWzg0MQCnDgNOdx6T3tdOOxwHsEvgC?=
 =?us-ascii?Q?b9TG1xgDvMYcl64CvOCqSdRwUS+LTJIvV8dO3mtbsHzIc/634hXHPhC1iU6a?=
 =?us-ascii?Q?4WknEtMRbSUO3F8ePojiWC6oTeVDg1kK86gcvepwaeOSZ4uERalyhRkioVlz?=
 =?us-ascii?Q?84mS5ZVS4zLXwayE/nrhv4vGWl4wlmBfy6Yi8vgmcSGMZpiPtZlL4Xo0JCf8?=
 =?us-ascii?Q?ffAmcGLdsDcSty4MzU3Wrhf+8/LMIDC+Sugx4WBSep5ceOFyxAhmmGkPMH9N?=
 =?us-ascii?Q?vyclVxzVVI/TjcBsAhVUQD8o5wuOQY3sEuAFzDToZ+yW5z0hfoqHKfRyIUpO?=
 =?us-ascii?Q?5qcEX5AzqB1wX5ncVmivrul2bAyxE1x9MgXMdjXTVqlsvNewZlrIisAd3bYp?=
 =?us-ascii?Q?f2KIxfqdKUzOLn3D+6Cyppg/771XH0+5zRWiKtK4RKRR3IwxqgE41rmWrXqC?=
 =?us-ascii?Q?fjCge1GsQQYO7rxmBlTV7CspGIVZL5k35fHxnBlgv662vhGgdrQOv6fmbrhc?=
 =?us-ascii?Q?pq6+kzPkbpwUc8t+kMUmexgD3wNllULFsQZYKkerKKVPjKgMGQ0Igcuo9IO7?=
 =?us-ascii?Q?ZyGSmnumUFYkruseS+YV2BzOnJKhcc+9ca+FBvmufGfw8E4EyDNFQY68WiQF?=
 =?us-ascii?Q?OsQF7a5X66tTeG2nDsYVVaMK+KMRL61gl4QoxGqYklNpZwLRcWqBlgLBlmjs?=
 =?us-ascii?Q?QGjB6Hj0GofGeBYYv7CRVnz+9EA7yrTv3vrtqKtI7D75YuAEoPzgbppH+zmB?=
 =?us-ascii?Q?M0EtwwenVcU29jnt4AeJ4wzSDFfkPY9t8M+sJRgowmj8lENd2WkL2iuWBEhv?=
 =?us-ascii?Q?FEHrTjxZ3TR8fAx+Egk3KSVUYaY8QOeEsVVFiaWtb7V84cPiEcjzTr08Mmc+?=
 =?us-ascii?Q?XQHrlPqRaFQoH/8z6HZ4/JC9CDbC2blU2msqU1Xxmya8tAp5DTVIKMR68uUj?=
 =?us-ascii?Q?HH2DIxVudlmR78Zb2lp3ejPIF2w1828xPDoJp+linob2PFTYZf4/aFRG0zuA?=
 =?us-ascii?Q?74FRCJ6fdIxANfVj/Ee3ViT/ykYckFgO9vi6RjsTaLsVYh62S0baS3nM5Cj7?=
 =?us-ascii?Q?f7C7hmHDsmDi9xDrEwqfzfYHHSdfK75bLIW/y+6Ic/d6mmSCwnzUwPvDGOO0?=
 =?us-ascii?Q?W8A3MR37AVXlA7NrTk9Mvub6A6M4qPIUH9XwPpBNOc438+NOej9SfO99DWlw?=
 =?us-ascii?Q?NFpshjYm3xcTCIBWisClX8hyplYB4gkBp+hI3vt/xO8rHTRBLQO7sne2UD0I?=
 =?us-ascii?Q?qg2z8dLpEfOQHo1poBuX7f4mCZD48wlUWo/NlH6OOWn3sgZCUcz8l8Pga0qY?=
 =?us-ascii?Q?JuvkcGC8j7hcD5fONFl2xq9cB4igpuDHhKY5Mib/9UAWRbk3Y4YwaWlqqARS?=
 =?us-ascii?Q?UFZLKjMVtyrr7H10UGeg4U/66z5//DuDM68zZGrcDEMmunSe2dbXt1wCsAVQ?=
 =?us-ascii?Q?8Okdcy4/20ckIhKwdKSK+9g=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f528a2d-0b6a-4174-d9e5-08dc26297800
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 09:04:33.1423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wN6YLWX0YJrLMKPmb7DjL3RP7mGohVbWOTMjjGrLwzesTi/xBYDeL4w4nPwsZzfuylAd5ETXnDyeFFcOt805rJLunboShKuHfS7rU3AEnflPeU6MITYGe0/AJynwBF/A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0751

This series implements the ISP 3A function to the Camera Subsystem on StarFive
JH7110 SoC. The series has been tested on the VisionFive 2 board.

This series is based on top of the master branch of media_stage repository,
which is tested with a v4l2-compliance compiled from the git repo
(git://linuxtv.org/v4l-utils.git).

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
v4l2-compliance 1.27.0, 64 bits, 64-bit time_t

Compliance test for starfive-camss device /dev/media0:

Media Driver Info:
        Driver name      : starfive-camss
        Model            : Starfive Camera Subsystem
        Serial           :
        Bus info         : platform:19840000.camss
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
        Driver version   : 6.8.0
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
        Media version    : 6.8.0
        Hardware revision: 0x00000000 (0)
        Driver version   : 6.8.0
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
        Bus info         : platform:19840000.camss
        Driver version   : 6.8.0
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
        Media version    : 6.8.0
        Hardware revision: 0x00000000 (0)
        Driver version   : 6.8.0
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
        Driver version   : 6.8.0
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
        Media version    : 6.8.0
        Hardware revision: 0x00000000 (0)
        Driver version   : 6.8.0
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
        Bus info         : platform:19840000.camss
        Driver version   : 6.8.0
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
        Media version    : 6.8.0
        Hardware revision: 0x00000000 (0)
        Driver version   : 6.8.0
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
        test VIDIOC_Sstf_isp: =================  START STATUS  =================
_HW_FREQ_SEEK: tf_isp: ==================  END STATUS  ==================
[32mOK (Not Supported)
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
        Driver version   : 6.8.0
        Capabilities     : 0x00000000
        Client Capabilities: 0x0000000000000002
interval-uses-which Media Driver Info:
        Driver name      : starfive-camss
        Model            : Starfive Camera Subsystem
        Serial           :
        Bus info         : platform:19840000.camss
        Media version    : 6.8.0
        Hardware revision: 0x00000000 (0)
        Driver version   : 6.8.0
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
        test VIDIOC_G_FMT: OKdns_csi2rx.19800000.csi-bridge: =================  START STATUS  =================
m (Not Supportedcdns_csi2rx.19800000.csi-bridge: ==================  END STATUS  ==================
)
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
        Driver version   : 6.8.0
        Capabilities     : 0x00000000
        Client Capabilities: 0x0000000000000002
interval-uses-which Media Driver Info:
        Driver name      : starfive-camss
        Model            : Starfive Camera Subsystem
        Serial           :
        Bus info         : platform:19840000.camss
        Media version    : 6.8.0
        Hardware revision: 0x00000000 (0)
        Driver version   : 6.8.0
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
        test Try VIDIOC_SUBDEV_ENUM_MBUS_CODE/FRAME_SI^[[?6cZE/FRAME_INTERVAL: OK
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
-----------------------------------imx219 6-0010: =================  START STATUS  =================
----------------imx219 6-0010: ==================  END STATUS  ==================
-----------------------------
Compliance test for starfive-camss device /dev/v4l-subdev2:

Driver Info:
        Driver version   : 6.8.0
        Capabilities     : 0x00000000
        Client Capabilities: 0x0000000000000002
interval-uses-which Media Driver Info:
        Driver name      : starfive-camss
        Model            : Starfive Camera Subsystem
        Serial           :
        Bus info         : platform:19840000.camss
        Media version    : 6.8.0
        Hardware revision: 0x00000000 (0)
        Driver version   : 6.8.0
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
 .../staging/media/starfive/camss/stf-camss.c  |  41 +-
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
 22 files changed, 2606 insertions(+), 286 deletions(-)
 create mode 100644 Documentation/userspace-api/media/v4l/metafmt-starfive-isp.rst
 create mode 100644 drivers/staging/media/starfive/camss/stf-buffer.c
 create mode 100644 drivers/staging/media/starfive/camss/stf-buffer.h
 create mode 100644 drivers/staging/media/starfive/camss/stf-isp-params.c
 create mode 100644 drivers/staging/media/starfive/camss/stf-output.c
 create mode 100644 drivers/staging/media/starfive/camss/stf-output.h
 create mode 100644 include/uapi/linux/jh7110-isp.h

--
2.25.1

