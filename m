Return-Path: <linux-kernel+bounces-138216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFA789EE36
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10A4CB232B3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEEA155723;
	Wed, 10 Apr 2024 09:10:49 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2137.outbound.protection.partner.outlook.cn [139.219.17.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76611552E8;
	Wed, 10 Apr 2024 09:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712740247; cv=fail; b=LAH9B/iVkFfpXYylTKHzvWhreNCLLPfKVrLN8JgTkBG+UCqePGUfPebtk91N56aKRTCoCWY9ul3YIAhqna1NCG/RUkXiRct/K0VQyW5BvKvSdEREjK0Bixk+t9JDJLwPNPgMe0OdaYEK1nrfgMODroSL81/xwGdzpG+kssaKNS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712740247; c=relaxed/simple;
	bh=MawmOle5h1wO6yMEeU0ol49am7elAXtWYMEFsY9inm0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=QRbdycvAxTfxRNxV4r5gYgGpXqdIP2uTZyBbVvKp3hFhgt+n6BEEZXRvHFJU10zlLc1R808/JIcv7KdqgRnT9SKHtMEf5XIPVoSIRUOxyyIWqM+kQyfNIqlCW6ZaXmxrWLsHm2eK6uNjQfq28DwtzUqCPFYmndAPBBSq6w9nu3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bvGGAZydnkD/l/Ibv99U1iI09SqRpj0FkqnefXunJ2P48muNeUc0MaJ/LOaWrKzG+CYseJ5WQIaUr23qFsO8DF0d6QQy6xBXyVB+ahahunjrAUYZex605p3ywY73fQYyrpe+XMr+g7hC6Dt+E1WyIkH0cu8ATxXLOXeynctE5lAuqaUNl9poAdsH8BtafnedT7PxulY87pACgVZpQOtRaSDxByFCqkOpoHiLHMkvBfep8DQDfuTJgKXB27CaoB3ZVU3/0IjGZGHayG3RYxK4ElAiKpDyV0XBO9KewVyPWxEjI8EfVTn0CRYhSc7cBCqxCS9yJcos5snDl8Th/Ekexw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/60cu+zqjOw3/d7uw8UZy0/7quBCthwdHoonyL8jsQ8=;
 b=IpF+WZkMQo6mXcU/3dvvUXnmvVmdDtnsqpoMPZiuDRVXNmoGgXUBlWVFf3iODIne/B365x4PubPOm9uhXciJHuL/Xbjb6CRxGlobDjr9jEfpq81NM5v1Z3ieuhATUIw5Sypbk2KPcCoUWJ7lO/zONvZa9QhVuqD81dlbRolAKMzdESlt4nd7eULiQUJRDiFLKWm10MytdJ1CEvmn+ufr+XdPh4MTFszx8CWvYrqjJndMkvWnve3G12zLWNRQHSRTiaCHpuol558uvADj3S3neumtvkBpS71p6VOLzSRNmifYHFxPttFjipWisVjJCQpMJEKX+ugTA7gbNZrC4zRAgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0896.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 10 Apr
 2024 09:10:34 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%7])
 with mapi id 15.20.7409.053; Wed, 10 Apr 2024 09:10:33 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Jack Zhu <jack.zhu@starfivetech.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: [PATCH v2 0/8] Add ISP Bayer for StarFive
Date: Wed, 10 Apr 2024 02:10:18 -0700
Message-Id: <20240410091026.50272-1-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJSPR01CA0005.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:c::17) To SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0671:EE_|SHXPR01MB0896:EE_
X-MS-Office365-Filtering-Correlation-Id: 76ef6e4b-02d8-48f2-5596-08dc593e13ed
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	H4yDV2S6hRN00M6oOTMhnwG49e5JF4YKR3p6XsxmNZmuuEcjVX78CQ/2PIBd/IgpkNZRZWAEUMrWvtmfbpjYZLRtY3UviTSd0CLEJSL1i45qMh/3uuRD3j39zmWPks/J4huaGgOBrMHh4k2Qx1aKiCCPb0yBHyd8fpqlpme7gbtpIkTZIgc5lAFDWvunGzKE9pAwu7aLWJnsPItu8Vd1nMGu7VpmaVJTUcZUHzs/kLu6ePYOEfUrkrjTHnngeSzTWh5f2cAaDaJeElyN64db8gd3aXoyCzygC5Vv8ZdL0gkzBbrcAiSZCztCfrqIG3pKCYfPlo/IxvcqFYsAXFaW6Yb8CWCyKPpR8ivafyFGwGIMOBZEoq/sPmDkwjJnSlvRNTryV3xvglQiXy3uItsd/xJ7fq1cYhHXYYTKbNNGwIIIBj06LyubAZFYx0R1+bvDTtqgwp4OIOOl6L6HWwG4NQMOQ1enr8ZKO1f8ehCFM9L3xkdGpcMMUewAwSVlxW0uTdNaNBMgSB5HCbobpyeDDR/R7AZ05U4rVCthHikmMXin59KC2wHDoX/Yxh+GTV4tz2vsEExTiHRk2nHKWTrpots2eOdPc9aYXeir01neNi7+6fyjiKWs72ascKBRBVYk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(366007)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?54O3OyLWBbnNkRwY6F2884UZzml6eG5Z2NfEg4GM4rFoOR0WpuqlJWhcpVYy?=
 =?us-ascii?Q?u3yCfJpEliRuOm//qs02yQ34j/i7DcL5uAf9n2tpkSa70U3mWXh7P6ZsbgTf?=
 =?us-ascii?Q?5VNH8UWfNy88/xPH1x2ddIHIRIzKFV1ZSozNvHjXO5gR3Xe+XexpKIoRdjnc?=
 =?us-ascii?Q?+b4e8qq8bzGtuuwmmyZ4hKwxtF3t+p15SqplPpxJd/zabH6x0kstPKa8RUZC?=
 =?us-ascii?Q?d17JZQHuFpRK+bj3iwSjsTk8nN0f/+qKb6LeYgn4XtMB273+Wc4cqLOFGa+q?=
 =?us-ascii?Q?eYLiFgK1DmGXRDbhXIGF2pEodMEEyLShJkIUUO4gLrm1fezUVLjXTDQ7KS/i?=
 =?us-ascii?Q?Xu3Bf+F1qF0+992z18Q6q8tPENxUlVuOh0FBSjrgDtEwu1jIDDjEW+mtRFP9?=
 =?us-ascii?Q?GY2LS956d+gqSQxf0pZjMoFXpX7465Ow/ZJVz4ykm+EKWSo7fTnn9DDlOtNo?=
 =?us-ascii?Q?kzjpx4JiPw5WBbnPUOtb38+9CCmfwcPavFZ+1uh+yiFEBGM3GF1j/t5YKJaw?=
 =?us-ascii?Q?WRCz+1hSe8M09BTpvGV42mmJalpbnNosIJHniLHZ3+Tr8EN+fJohg/8IkGMT?=
 =?us-ascii?Q?7ufHUi+4h+52e/oEhNaSwlZiYmac2udjYslWwVvnicNKs533oK647XGXB1Ic?=
 =?us-ascii?Q?6APT+vZoKOzq1g8OJVtozj2TwjcvTGosk/nJmSKSbWlW19VaWVj37N5v0KBX?=
 =?us-ascii?Q?vU7fnb1gfXiA6l6sP4qTvYR08AnYVHMlnzXZjBJjUiTjAGVIhRmN0Q4Jazcd?=
 =?us-ascii?Q?OEWl2xG0iiUK7KUBVNlmsyAmAtlVYAxYg6+VabnbRDlp/8UGr8P5cLAJKFp1?=
 =?us-ascii?Q?5YSU/ophar3e+k7vWMA1pQX1w7E2XVHbY+gtvxBs1XqhLVxYg+N6LrZZcSz6?=
 =?us-ascii?Q?t2g6NIgy2i6ME55CgPptDZ7cyZCqvBBSRDYrVLjiMS5KLUtzTkWJl4thvnJh?=
 =?us-ascii?Q?mNKeI8yyukKqqMgXZtyYHOjCBbgrvGMimUAxa2d4DxGSIxw7T5Z+u2zxbWhX?=
 =?us-ascii?Q?OqeAO0IXz/2OkWV6zLsdfvriQWqoKk1jCXCP4TLCu4CU+020+CWGZUM3KNOZ?=
 =?us-ascii?Q?JISQ0L0fnB9y6TlE5i29Yz9LqGqFcQQq8VdzkqlcyPwmbQ6SorPyg406SHt4?=
 =?us-ascii?Q?y3xiUdBP9hMev74CWx+8YQpsYCebPOECc3nvm0HR5TZU/S+uOLqVqnft22TU?=
 =?us-ascii?Q?OWYVdVoU5a91z0nU217x8Y2oDis/5DfxauwRjyl5rum3fLpnBwANclQpD/O6?=
 =?us-ascii?Q?+bxs+FKf4lOd+h1nG/cfU83BhR2xyRk1TMQSmMWtxoLVgAEYoYTH1ShuzPUZ?=
 =?us-ascii?Q?EKcnRw19A0MBuLdjzIwVGxH386zXAFWy10ALP4cJFa0h6xVE+Tfvg19fYbM9?=
 =?us-ascii?Q?y9nMOTlNS5Ben0WBTz3mt++MCZwao67DUXV0Tjc5EtI7aygMwQcozrUHRMsa?=
 =?us-ascii?Q?9dGgIVwoJT2MH+f9SonFdE0T3uxdrW2qzIQp+vFpH47KGx9bMvsi8ne7cKdJ?=
 =?us-ascii?Q?zEbLTRaC+MLNy7Kd0A6ycjVmWVG3a4LUpwcvhAJHa60bjctobFosug5bWib+?=
 =?us-ascii?Q?d2UgKfIPgJUPPFWwDGluvULDHkw/L20HoOgm6B3H/BLaWE2JWtczNDW3iPTB?=
 =?us-ascii?Q?0KoPTSYK2lgQNijjWY0F3zU=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76ef6e4b-02d8-48f2-5596-08dc593e13ed
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 09:10:33.8946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VW2bDZpjyAKWWx2UqC83SmqnG5z3PeV0o3nPNoI86F/0K9DHQb03B67iSXj1ESeVBLhSgHW4W0alpwB2z1m0Dbfhbgrwf0DqlgI4iPxOecMLKGHzqDErFnmM8849aTv0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0896

This series implements the ISP output Bayer format function to the Camera
Subsystem on StarFive JH7110 SoC. The series has been tested on the
VisionFive 2 board. It should beapplied after the series [1][2]:

[1] Add ISP 3A for StarFive:
https://lore.kernel.org/all/20240402100011.13480-1-changhuang.liang@starfivetech.com/
[2] Add StarFive Camera Subsystem hibernation support:
https://lore.kernel.org/all/20240326031237.25331-1-changhuang.liang@starfivetech.com/

This series is based on top of the master branch of media_stage repository,
which is tested with a v4l2-compliance compiled from the git repo
(git://linuxtv.org/v4l-utils.git).

changes since v1:
- Rebased on series [1][2].
- Replaced "raw" with "bayer".
- Added a new patch 7.
- Upadted title and description for all patch.
- Upadted ISP stream count record to avoid duplicating call subdev s_stream in patch 4.

v1: https://lore.kernel.org/all/20240306093334.9321-1-changhuang.liang@starfivetech.com/

The following are the media graph for the device and the v4l2-compliance
output.

==========================================================================================

[the media graph]:

digraph board {
        rankdir=TB
        n00000001 [label="{{<port0> 0 | <port1> 1} | stf_isp\n/dev/v4l-subdev0 | {<port2> 2 | <port3> 3 | <port4> 4}}", shape=Mrecord, style=filled, fillcolor=green]
        n00000001:port2 -> n0000000f [style=dashed]
        n00000001:port4 -> n00000017 [style=dashed]
        n00000001:port3 -> n00000013 [style=dashed]
        n00000007 [label="output_params\n/dev/video0", shape=box, style=filled, fillcolor=yellow]
        n00000007 -> n00000001:port1 [style=dashed]
        n0000000b [label="capture_raw\n/dev/video1", shape=box, style=filled, fillcolor=yellow]
        n0000000f [label="capture_yuv\n/dev/video2", shape=box, style=filled, fillcolor=yellow]
        n00000013 [label="capture_bayer\n/dev/video3", shape=box, style=filled, fillcolor=yellow]
        n00000017 [label="capture_scd\n/dev/video4", shape=box, style=filled, fillcolor=yellow]
        n00000023 [label="{{<port0> 0} | cdns_csi2rx.19800000.csi\n/dev/v4l-subdev1 | {<port1> 1 | <port2> 2 | <port3> 3 | <port4> 4}}", shape=Mrecord, style=filled, fillcolor=green]
        n00000023:port1 -> n00000001:port0 [style=dashed]
        n00000023:port1 -> n0000000b [style=dashed]
        n0000002d [label="{{} | imx219 6-0010\n/dev/v4l-subdev2 | {<port0> 0}}", shape=Mrecord, style=filled, fillcolor=green]
        n0000002d:port0 -> n00000023:port0 [style=bold]
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
        Entities: 8 Interfaces: 8 Pads: 16 Links: 15
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
        ID               : 0x03000009
        Type             : V4L Video
Entity Info:
        ID               : 0x00000007 (7)
        Name             : output_params
        Function         : V4L2 I/O
        Pad 0x01000008   : 0: Source
          Link 0x0200001f: to remote pad 0x1000003 of entity 'stf_isp' (Image Signal Processor): Data

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
        ID               : 0x0300000d
        Type             : V4L Video
Entity Info:
        ID               : 0x0000000b (11)
        Name             : capture_raw
        Function         : V4L2 I/O
        Pad 0x0100000c   : 0: Sink
          Link 0x0200002b: from remote pad 0x1000025 of entity 'cdns_csi2rx.19800000.csi' (Video Interface Bridge): Data

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
        ID               : 0x03000011
        Type             : V4L Video
Entity Info:
        ID               : 0x0000000f (15)
        Name             : capture_yuv
        Function         : V4L2 I/O
        Pad 0x01000010   : 0: Sink
          Link 0x0200001b: from remote pad 0x1000004 of entity 'stf_isp' (Image Signal Processor): Data, Enabled

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
        ID               : 0x03000015
        Type             : V4L Video
Entity Info:
        ID               : 0x00000013 (19)
        Name             : capture_bayer
        Function         : V4L2 I/O
        Pad 0x01000014   : 0: Sink
          Link 0x02000021: from remote pad 0x1000005 of entity 'stf_isp' (Image Signal Processor): Data

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

Total for starfive-camss device /dev/video3: 47, Succeeded: 47, Failed: 0, Warnings: 0
--------------------------------------------------------------------------------
Compliance test for starfive-camss device /dev/video4:

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
        ID               : 0x03000019
        Type             : V4L Video
Entity Info:
        ID               : 0x00000017 (23)
        Name             : capture_scd
        Function         : V4L2 I/O
        Pad 0x01000018   : 0: Sink
          Link 0x0200001d: from remote pad 0x1000006 of entity 'stf_isp' (Image Signal Processor): Data

Required ioctls:
        test MC information (see 'Media Driver Info' above): OK
        test VIDIOC_QUERYCAP: OK
        test invalid ioctls: OK

Allow for multiple opens:
        test second /dev/video4 open: OK
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

Codec ioctls (Input 0):
        test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
        test VIDIOC_G_ENC_INDEX: OK (Not Supported)
        test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)

Buffer ioctls (Input 0):
        test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
        test CREATE_BUFS maximum bufferstf_isp: =================  START STATUS  =================
s: OK
stf_isp: ==================  END STATUS  ==================
        test VIDIOC_EXPBUF: OK
        test Requests: OK (Not Supported)

Total for starfive-camss device /dev/video4: 47, Succeeded: 47, Failed: 0, Warnings: 0
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
        ID               : 0x03000031
        Type             : V4L Sub-Device
Entity Info:
        ID               : 0x00000001 (1)
        Name             : stf_isp
        Function         : Image Signal Processor
        Pad 0x01000002   : 0: Sink
          Link 0x02000029: from remote pad 0x1000025 of entity 'cdns_csi2rx.19800000.csi' (Video Interface Bridge): Data, Enabled
        Pad 0x01000003   : 1: Sink
          Link 0x0200001f: from remote pad 0x1000008 of entity 'output_params' (V4L2 I/O): Data
        Pad 0x01000004   : 2: Source
          Link 0x0200001b: to remote pad 0x1000010 of entity 'capture_yuv' (V4L2 I/O): Data, Enabled
        Pad 0x01000005   : 3: Source
          Link 0x02000021: to remote pad 0x1000014 of entity 'capture_bayer' (V4L2 I/O): Data
        Pad 0x01000006   : 4: Source
          Link 0x0200001d: to remote pad 0x1000018 of entity 'capture_scd' (V4L2 I/O): Data

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
                fail: v4l2-test-subdevs.cpp(528): sel.r.width == ~0U
        test Try VIDIOC_SUBDEV_G/S_SELECTION/CROP: FAIL
        Active Stream 0
        test Active VIDIOC_SUBDEV_ENUM_MBUS_CODE/FRAME_SIZE/FRAME_INTERVAL: OK
        test Active VIDIOC_SUBDEV_G/S_FMT: OK
                fail: v4l2-test-subdevs.cpp(528): sel.r.width == ~0U
        test Active VIDIOC_SUBDEV_G/S_SELECTION/CROP: FAIL
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

Total for starfive-camss device /dev/v4l-subdev0: 80, Succeeded: 78, Failed: 2, Warnings: 0
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
cdns_csi2rx.19800000.csi: =================  START STATUS  =================
        Hardware revisicdns_csi2rx.19800000.csi: ==================  END STATUS  ==================
on: 0x00000000 (0)
        Driver version   : 6.9.0
Interface Info:
        ID               : 0x03000033
        Type             : V4L Sub-Device
Entity Info:
        ID               : 0x00000023 (35)
        Name             : cdns_csi2rx.19800000.csi
        Function         : Video Interface Bridge
        Pad 0x01000024   : 0: Sink
          Link 0x0200002f: from remote pad 0x100002e of entity 'imx219 6-0010' (Camera Sensor): Data, Enabled, Immutable
        Pad 0x01000025   : 1: Source
          Link 0x02000029: to remote pad 0x1000002 of entity 'stf_isp' (Image Signal Processor): Data, Enabled
          Link 0x0200002b: to remote pad 0x100000c of entity 'capture_raw' (V4L2 I/O): Data
        Pad 0x01000026   : 2: Source
        Pad 0x01000027   : 3: Source
        Pad 0x01000028   : 4: Source

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
        test Try VIDIOC_SUBDEV_ENUM_MBUS_CODE/FRAME_SIZEimx219 6-0010: =================  START STATUS  =================
/FRAME_INTERVAL:imx219 6-0010: ==================  END STATUS  ==================
 OK
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
interval-uses-which Media Driver Info:
        Driver name      : starfive-camss
        Model            : Starfive Camera Subsystem
        Serial           :
        Bus info         : platform:19840000.isp
        Media version    : 6.9.0
        Hardware revision: 0x00000000 (0)
        Driver version   : 6.9.0
Interface Info:
        ID               : 0x03000035
        Type             : V4L Sub-Device
Entity Info:
        ID               : 0x0000002d (45)
        Name             : imx219 6-0010
        Function         : Camera Sensor
        Pad 0x0100002e   : 0: Source
          Link 0x0200002f: to remote pad 0x1000024 of entity 'cdns_csi2rx.19800000.csi' (Video Interface Bridge): Data, Enabled, Immutable

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

Grand Total for starfive-camss device /dev/media0: 455, Succeeded: 453, Failed: 2, Warnings: 2

Two warnings are from the imx219, can ignore them.

Changhuang Liang (8):
  staging: media: starfive: Get rid of current_fmt
  staging: media: starfive: Add bayer pad for ISP
  staging: media: starfive: Use PAD_SINK instead of PAD_SRC for crop
  staging: media: starfive: Introduce isp_stream
  staging: media: starfive: Add ISP bayer video device
  staging: media: starfive: Fix bayer output stride configuration
  staging: media: starfive: Move the struct media_pipeline position
  admin-guide: media: Update documents for StarFive Camera Subsystem

 .../admin-guide/media/starfive_camss.rst      |  8 +--
 .../media/starfive_camss_graph.dot            | 28 +++++-----
 .../staging/media/starfive/camss/stf-camss.c  | 12 +++++
 .../staging/media/starfive/camss/stf-camss.h  |  2 +-
 .../media/starfive/camss/stf-capture.c        | 41 +++++++++++++++
 .../media/starfive/camss/stf-isp-hw-ops.c     | 42 ++++++++++++---
 .../staging/media/starfive/camss/stf-isp.c    | 52 +++++++++++++++----
 .../staging/media/starfive/camss/stf-isp.h    |  9 ++--
 .../staging/media/starfive/camss/stf-video.c  | 30 ++++++++---
 .../staging/media/starfive/camss/stf-video.h  |  2 +
 10 files changed, 184 insertions(+), 42 deletions(-)

--
2.25.1

