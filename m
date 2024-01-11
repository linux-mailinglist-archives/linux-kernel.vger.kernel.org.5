Return-Path: <linux-kernel+bounces-23257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CB882A9D7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54EAE1C2548A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5147213FF4;
	Thu, 11 Jan 2024 08:56:15 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2063.outbound.protection.partner.outlook.cn [139.219.146.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D57F12B86;
	Thu, 11 Jan 2024 08:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QTbbRBbQyBQyds4ejwxMTEa9zXH9BEVqlhVV5/aOaOV0n87Ur6JVF4AImnMNCqQwH8XXV++grWTeLKbaVUHsJO2qbSYPR/UaURk87D9HyRIVD9xtniY1u3JjGwxVuft2mn6FtYDHaLLQyy9CSHR+CRG+fI+InKI5q9UAl2N1nr2CkA1N0nX1Db5avAkOUUm0KL2UJFKTK81fXr08N4N3PKq5s++lU1sjqcxuX9oJVsI61xi8OBE28QqR1di7fJMOXZKE0FD4VmfPmjeCRxNpBbqrohrEmpFtc0mpAdMigOgVaMCEGXcNCnhoVaEEk3VBIIVoN+1C70bMZyrMEgSwUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tys5cIxMnn7dQx/nl7KwEcmxWT/25exDuxXWIufoanU=;
 b=h/GLpJAOwQw8xWanBZ2eiz3k0cvOHXlDlWtpR5On1kfJK6iH3awX84CbZqe32RZQwAAUc9ZIqjwfnML7XqQgdcSMRx7S4szXFb9XGu9TiJZM3kGuJ2mDRkhXrDJvQNvVjvom1dOgjXoyPxHc9DfLAjmdg6nSBPfsobZdTmQ4p+c91aJ0YYCjo4xA3AIRST8Dl4YOl/iZFrdsA//10SHDEkgowCLvc1HqYm7OovhKHIT3qyRiXCnejtARhxWgRVIU/6d+9h3XwZa0aKEJDwMcUJXHsxH6zHu1VU6jkAoMvjPhVQqjUpsrmhFI3zxN0bUUtgBBpqjpzd+EV7iUJW+E8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::21) by SH0PR01MB0747.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:21::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.33; Thu, 11 Jan
 2024 08:41:31 +0000
Received: from SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn
 ([fe80::e255:98f3:ba27:8c7d]) by
 SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn ([fe80::e255:98f3:ba27:8c7d%3])
 with mapi id 15.20.7135.033; Thu, 11 Jan 2024 08:41:31 +0000
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
Subject: [PATCH v2 03/13] media: videodev2.h, v4l2-ioctl: Add StarFive ISP meta buffer format
Date: Thu, 11 Jan 2024 00:41:10 -0800
Message-Id: <20240111084120.16685-4-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240111084120.16685-1-changhuang.liang@starfivetech.com>
References: <20240111084120.16685-1-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4753559a-f14a-4735-166d-08dc12811b7f
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	odQ0NRy7d/+5qSuGziey4e8xlz0V9qg6aL7oCZbwobU7HvNWMCd0eYz5g3XyTAEQQ7MNnokrRF4dOsKtLgv7wf58Dxa+sHFjYI8uLRDTb37cludffOu1mNsZhBQJCT52eo1Rmgnst/dOBRC06kQwJQHM2BvmgBPtW7bSutFtvXCDYPK5cIYvY4hN612Gv1yHS6k8P8tpnpGastsiNkunAZ2iUWURkEwYZ4+FKyv8dO2zeLc1WAB6i6iAC5/sZvZePiIRH8KLQYgxPDhfZpsnzjT58AcSHMK8KQcMvrRY8gkD96FDYXySgWZ6Qlx6CvHhWwya4HVABFqH+7jq+JEqaFIaF6BATn3v9SLOtBWvon7Ey7ZfbnCLntI9IEElbrMXNCIuV7LFbfb8yMUGU+dlW+77jSp6AmsdvbXRcKo4kSp15uKxMO7ukj+7suzVUqfoOmRlngmkyICCiYKu/IHGdtT2rW3NWr5EgGGkYKzXpA0keDUpyrbGmW+oh64Okk+j9oPExYarhxTzvf2vDaKRkKjjw8Lsy56r9EP/Pwy2tmo/ud9ltlVyiU5jctZur/z5uPcq0xDYaAj6xyCeXlcmVg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(136003)(39830400003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(6666004)(52116002)(41300700001)(2616005)(508600001)(38100700002)(40160700002)(1076003)(26005)(86362001)(36756003)(921011)(38350700005)(110136005)(54906003)(66556008)(66946007)(66476007)(8676002)(8936002)(41320700001)(4326008)(44832011)(2906002)(40180700001)(5660300002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CixQOzLsnF8soZDW9cM8f5pjr+1AI2+qPqt5KyUmhao7Mm+tahgJTraL6+NL?=
 =?us-ascii?Q?10JdgN7eokhboumNZtob2PD2YPKRPnCZ8lzjZw4UKBfng6yVbaHxi5STiMOP?=
 =?us-ascii?Q?TchiVwv0tyGq/sEn0cBXtDvHwJs/2ECBq82aDpe/6RvHKgjVoNmLTLN4pgS+?=
 =?us-ascii?Q?Pp+cDXpEe3Tltk5YST+FQfELyoS0D6uuevQmI+dI3dbuFlfL4NXXxThBu/UJ?=
 =?us-ascii?Q?DpOJ58CGSXUqoy3JXHa2CMvQHpAK2J9RcZ9+5FfvTFt46OEx/RPXhWLZWz2B?=
 =?us-ascii?Q?QSskaiYZ9tQWlstWEBRwLsDa8kPD0I1B3+o8GeSbJwYzE5qc6HP71Exs/I8L?=
 =?us-ascii?Q?qYNzaG43gEjwC5bz07TvQcgLrIezGmrw8dHCaiD8FMPwG6a0sEDRSaU0Iv7A?=
 =?us-ascii?Q?91KhuCDyVb/iTG1aUgT7oDAMLQ4RJb7fp8Cc6rVeOpl5CJQ2Ci5I8ufHfTKV?=
 =?us-ascii?Q?G/K1dHExGC2oIS0B2klZ9xys3U4KUNT2QYCR48q2r6BCdEKP5b9ucaQsrcOC?=
 =?us-ascii?Q?rkw07uq4goFjGImraIV4+aukc4QKkG8hhIDGbCUkMzBI9aSLf+e2GReVDDFW?=
 =?us-ascii?Q?66on+uoy7HK43VD28DyHAHjuJTj+EWNlP9B2LAT4tLia1Kj64ikWPN988wlp?=
 =?us-ascii?Q?buCfGeHFhFiZzmMkakklyURyBto9QNtQxNl0KaRRN4LpOXmCUe3J9Aq47M/1?=
 =?us-ascii?Q?ZHZDtcJXjeaejY8P5HNU+bc+VobCgOAwFFCA+AOqX5uwR0NRrLnPUVP0ttJt?=
 =?us-ascii?Q?GVhMTHSHzKQc7+MgxeX3Cd2NxFutstU0xebPpJz1Mqb1VouWOa8ygIC6CEEf?=
 =?us-ascii?Q?/pFpnGISky5dMx8eDNhYrnEuLma2QAUKu8JU/t/l0M/UhKsWsyFwPW+xdXyy?=
 =?us-ascii?Q?x5QeLphSZKYybVk92ZXkqOU1niAdQTtF0fmUpS2yAmtXBsEge6p8brWotdyY?=
 =?us-ascii?Q?3fbJMpoExYR3EOkgFmJCrGKKGHb/nT2mVrmhCyvvH8fCF0N2jDkA+8TQHDnV?=
 =?us-ascii?Q?Ff0GYJ6joFDelQueDkVcOa/mvP3eOjw/HCbQ7wQia+E5vutT0lJnzbAPJwa/?=
 =?us-ascii?Q?JNCyESDDAgW85RrHUl5M0ts/1MypiRi2eV1iBWrhzcOF0i/ey+E2vLE6fv5q?=
 =?us-ascii?Q?YXuWLEG9gcT99hjZs+6kcKwteoWQqqW7V3hUy3vsAQsCGnez6Ps9EzqzCwXN?=
 =?us-ascii?Q?UTrz6PQYjO4UyYTWcPjB7rozn98JUECbFxceciMkFPMOyxJRUWCPSJI6nEo2?=
 =?us-ascii?Q?O7j0yB7lXav8Mnqi2+dmRvRwnfKe/oEmY7WelxziZK8FDojtuCkA6aNs7qIx?=
 =?us-ascii?Q?SO8PKBZLetyuZTS3tdvNCtXRtFwiQUVnciT7hJqHu+8YZ/5mTD5Y+1Eor9jo?=
 =?us-ascii?Q?xQa5CWEB1zMLKubEe6a6dJLwvNlq20WRrymhmgsCP2pYUQWKcKnfrFf2TgWa?=
 =?us-ascii?Q?3cFtUq9dBaH43IsJMZZrF8Mi++WvplWCVWhDOOw1xFRNSLqnF3fYDqw3E24j?=
 =?us-ascii?Q?Jk5wXJfNvL8XzKKw4bL+wC3d2UfzfyvY7Q0hvrR//nccD306/HPfcN9bkg4K?=
 =?us-ascii?Q?236YV/a7ke7BQIK58Ud+HqrQeB9/YuFaWclPn68qUKukmRbLiuLV0IwqS+MA?=
 =?us-ascii?Q?s84UfL7sV/UTZs/SzNms8R0=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4753559a-f14a-4735-166d-08dc12811b7f
X-MS-Exchange-CrossTenant-AuthSource: SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 08:41:30.2400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q1kt6PpbjHZBs8w/FEf/RU5Rbvx/2ypxUOkgGy97y1XGCAAZPY9W+QuC+pbUAaV8UfpE/OVz9P0o76t+tsf6MuJNEe5nU6CClsvtoBzgM/uLtwnMy19xxWOQ+za1Y9+Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SH0PR01MB0747

Add the StarFive ISP specific metadata format
V4L2_META_FMT_STF_ISP_PARAMS & V4L2_META_FMT_STF_ISP_STAT_3A for 3A.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/media/v4l2-core/v4l2-ioctl.c | 2 ++
 include/uapi/linux/videodev2.h       | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 33076af4dfdb..12c2104a3626 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1445,6 +1445,8 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 	case V4L2_META_FMT_VIVID:       descr = "Vivid Metadata"; break;
 	case V4L2_META_FMT_RK_ISP1_PARAMS:	descr = "Rockchip ISP1 3A Parameters"; break;
 	case V4L2_META_FMT_RK_ISP1_STAT_3A:	descr = "Rockchip ISP1 3A Statistics"; break;
+	case V4L2_META_FMT_STF_ISP_PARAMS:	descr = "StarFive ISP 3A Parameters"; break;
+	case V4L2_META_FMT_STF_ISP_STAT_3A:	descr = "StarFive ISP 3A Statistics"; break;
 	case V4L2_PIX_FMT_NV12_8L128:	descr = "NV12 (8x128 Linear)"; break;
 	case V4L2_PIX_FMT_NV12M_8L128:	descr = "NV12M (8x128 Linear)"; break;
 	case V4L2_PIX_FMT_NV12_10BE_8L128:	descr = "10-bit NV12 (8x128 Linear, BE)"; break;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 68e7ac178cc2..349bb8efe28a 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -839,6 +839,10 @@ struct v4l2_pix_format {
 #define V4L2_META_FMT_RK_ISP1_PARAMS	v4l2_fourcc('R', 'K', '1', 'P') /* Rockchip ISP1 3A Parameters */
 #define V4L2_META_FMT_RK_ISP1_STAT_3A	v4l2_fourcc('R', 'K', '1', 'S') /* Rockchip ISP1 3A Statistics */
 
+/* Vendor specific - used for StarFive JH7110 ISP camera sub-system */
+#define V4L2_META_FMT_STF_ISP_PARAMS	v4l2_fourcc('S', 'T', 'F', 'P') /* StarFive ISP 3A Parameters */
+#define V4L2_META_FMT_STF_ISP_STAT_3A	v4l2_fourcc('S', 'T', 'F', 'S') /* StarFive ISP 3A Statistics */
+
 /* priv field value to indicates that subsequent fields are valid. */
 #define V4L2_PIX_FMT_PRIV_MAGIC		0xfeedcafe
 
-- 
2.25.1


