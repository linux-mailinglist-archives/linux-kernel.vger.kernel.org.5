Return-Path: <linux-kernel+bounces-68413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0968579EB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED210282639
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED171BF5C;
	Fri, 16 Feb 2024 10:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="jIprcEar"
Received: from refb01.tmes.trendmicro.eu (refb01.tmes.trendmicro.eu [18.185.115.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1D71BC2A
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 10:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=18.185.115.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708078071; cv=fail; b=N0BP1UohhK+96H/yfYRL5UbgpoJdxbFTknWE6kE/AueNpoEn0ZMxh+zkdYDwshOFT3wGpTCl9Iv/BDxTWyCnA8mpYlI1EoMreU/3ns1pAXWf1ggxiHZEdhd9hAhsfe/GWnp6HFGno4tKJqaemYEV09ZfR/xT0jT9Z7uCYNZTcN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708078071; c=relaxed/simple;
	bh=l6zek2Py8Yqa9njHsCzaxukuhOlrEzCOSXWIQsdv3mQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=dTNeRkx6VYOyK2Dg/8NQXqVgPSmreHjJcepaEYCZSGvYrnEL84duyohO8QswxO94c7PV7NWZZmV8b2IERHvzbla9pJSfmSxzfh/ppsXsW4ptMXBspxSZgPIk1OCOT6Cm8ACAFD8+b07XOI8lYEdkOHKsoTv7+RBF2Ft/I2jn8Q8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com; spf=pass smtp.mailfrom=opensynergy.com; dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b=jIprcEar; arc=fail smtp.client-ip=18.185.115.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Received: from 104.47.7.169_.trendmicro.com (unknown [172.21.10.134])
	by refb01.tmes.trendmicro.eu (Postfix) with ESMTPS id 4518C10053F30
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 10:07:41 +0000 (UTC)
Received: from 104.47.7.169_.trendmicro.com (unknown [172.21.168.141])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 9B99210001752;
	Fri, 16 Feb 2024 10:07:34 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1708078023.684000
X-TM-MAIL-UUID: 48a7f490-4bfc-4c10-8c9b-8b39c8f27e12
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (unknown [104.47.7.169])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id A73D61000128C;
	Fri, 16 Feb 2024 10:07:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KiTbvtrOhg65QHR+cqhjd68NHx9p6Gu1QMji1lgJC0dmwTGCcuE3hWuAPECHHuShPN1UjEvkO8GXqbKg+eXkb+Z7olWpF5fCKyKvczp2nQPJ8RHObzE9lCsaFHTuHZiVuQ30EO5ii2KjkJM35YBrSYz1J7U2PKsnCwplxuYzZelG3FXSFp8Y91o+R724d0qtFJu2XhZyAAJljiCqFoF/ihZw9TYylEzOF7GqQSf0CMefkQ8PvcndQ4T9iEq/+kmLpMYVy/IgU+BBPYLm0uE5GBnqh+66wJ03T9/L4Q51E7b4ZHoes/agc7JLDOnAx2HHqqzDwHoZ3NDT+AGE+iBD0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HE0jL9M9QVaUs8zzkQhxJzC+O+G/NljfyGALdz4tB8s=;
 b=a209xJ8ybHUBeQZytggDzkYOmCGDG5zf+ziDav6Pt4qfoo+E2z14594A6NqYYpT4QlPf9/yHdY5wzYUZwgBMI/JTJjlAv+oFiWUeR4Af0dkuh1mXbfCGdl+4Es3j0j9SplKaG++Evivpwjf2MZnTfsTGGC2cba8goMYHMEwsadd9q+NrLbK1GgtEQlXENXkSXUzTTSQbdnwqf9hpkwflpTWTn7HJy7GrROJ3Jyi85joUfcxrXDyEPyj9a9Fu5d35twlXuZ7lKDEI+DOkJKe4bAnpivJY3H5wFCUh2fxr26+NLvIEWxyC12g++OKBDn1FQ6xNxhZzYSnXXyosMaAAUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 217.66.60.4) smtp.rcpttodomain=alsa-project.org
 smtp.mailfrom=opensynergy.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=opensynergy.com; dkim=none (message not signed);
 arc=none (0)
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 217.66.60.4)
 smtp.mailfrom=opensynergy.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=opensynergy.com;
Received-SPF: Pass (protection.outlook.com: domain of opensynergy.com
 designates 217.66.60.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.66.60.4; helo=SR-MAIL-03.open-synergy.com; pr=C
From: Aiswarya Cyriac <aiswarya.cyriac@opensynergy.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	virtualization@lists.linux-foundation.org,
	virtio-dev@lists.oasis-open.org
Cc: Aiswarya Cyriac <aiswarya.cyriac@opensynergy.com>,
	Anton Yakovlev <anton.yakovlev@opensynergy.com>,
	coverity-bot <keescook+coverity-bot@chromium.org>
Subject: [v4 PATCH] ALSA: virtio: Fix "Coverity: virtsnd_kctl_tlv_op(): Uninitialized variables" warning.
Date: Fri, 16 Feb 2024 11:06:43 +0100
Message-Id: <20240216100643.688590-1-aiswarya.cyriac@opensynergy.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D13:EE_|BEZP281MB3092:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3a2fd6b1-6498-4c90-b6cc-08dc2ed704b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LJOBHZ4bn/kMSF+H5w8It71ZVnxd/UnIZM74rpOVXwJDG3byVP6qX69gWRXGCxQvLhOXcoeqBn3+2cCRDlvAQAI8blRz3goAZgOLT5zHx7MzXCQCR1DxETi2qHungPqztnzIeqQL51XKT4EHXp3vGNRcI2X3ic+ZNicPiOwgYgXtBtwk7h0nBa57rIhGZ1qTXpR7LcbM9b46HOmEkNTbOLuvRwnBqAdc8yk5UQCf4Xblf9q59fGQ+fVS460atS5lfggjXERPCnYFxR5NpfDZYDaRq6tGVnQItAeYREGiII2Rk++2JrIn5DDqIQ93/HxL2JHsHkrED9+r6SaHTZSKyWZK6CmhcAMG9X8KyVZ+LhD9xpjjmpkvmSYQ1/N0JAhfwLMlWg+D/V6oDNteZJVoqV+k6SfuXHjOrqw9qsLfrR1q4rcPYPyVhBPn0zWdbzxIAQgTi/RSq8SLBFRpI8phJMobcRb89NICIDehi2+Fp2owSxvIVjrl6M7m897rSMDK5j06L9oqkLOn4S1HXdManZXOU0mijtxnoghiMyGP5OkjdAlRJAKwS8v8g9Yg6M/eJVqjEwSUlUHjIL2LZU4ribRspvgaDzJelV0oLY4fIOyh1yDDB/Xh7MLmhOQCwT9VGDlTivHrCLWkz0U/1YAS+f7qUfwu4IHL9fEhjShJ7VA=
X-Forefront-Antispam-Report:
	CIP:217.66.60.4;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(39840400004)(136003)(230922051799003)(230273577357003)(82310400011)(64100799003)(186009)(451199024)(1800799012)(36860700004)(46966006)(83380400001)(478600001)(2616005)(336012)(1076003)(26005)(5660300002)(2906002)(42186006)(70206006)(70586007)(54906003)(316002)(44832011)(8676002)(8936002)(4326008)(36756003)(81166007)(86362001)(41300700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 10:07:01.0341
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a2fd6b1-6498-4c90-b6cc-08dc2ed704b2
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[217.66.60.4];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D13.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB3092
X-TM-AS-ERS: 104.47.7.169-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28194.006
X-TMASE-Result: 10--6.073000-4.000000
X-TMASE-MatchedRID: yLHOPqhdQyUm6W0B8rdIY/bi+YTr2htSkUTOyGwQKEcG1bmUGNW4DRKy
	wsos70CFgYfoPrmJSwc0MlZvaRoxGO5pF8IH54mMiu6u4shZ+fE304eoJbTN0Rw72DTAhdU77hX
	WJUuROzeNk6CnOOT0tJ4u7onx25Mlk/dA6P3T5FsZD7bjq+6lMGzY00haS8QoYcKx85MjSJV7ZP
	o4/uRLKdjkA7ZIeC0hSsHaTC+tV4yT+faG0UZYkbF+GhWADCGDcnxszfxH2Cl7wQPQv9XohUiWq
	V2CUL6T2HlzhM3zNtns9WQVYycKfw3lGTiQlxzIqDtmjlQ4FGmiWLhmiI4dP34gKq42LRYkLQsA
	4Lf47hfQyG0Im0vQFRYVjN3ayo9ftrLio4OQIpt+3BndfXUhXQ==
X-TMASE-XGENCLOUD: bb9067a1-5a4d-4378-86da-fc05fbc94867-0-0-200-0
X-TM-Deliver-Signature: 38AB2E0AAE7BF7D54D21C43B51702617
X-TM-Addin-Auth: e7Mwzoh2XWMygMHTd7pOSJ1N8aTN+6kV8/kvETaVr1NvWYWI1jSBpAChZEI
	yuT+KKOjfCj9OtFB1kiAOGV3JUDDy0JiGZ21/eoessHfDN7avmSChM7XibdZFH9gpnuI/5a3+gL
	3yA/NG97L04aQZk1qRENR1cBNwzZFQlYvKwUOuajwteNr4XbKMxpQcA+WQRQWy3cITPMsp9Ey5M
	7j4oygRtPhAwWbiTIGJRB3RYR056eyQZd4dzp6smQP85gY6H3bxS50OT2uTetoPbhIEWfGEr+GO
	LKsztdRVBs1JcixDoKbpZ9fHjPa8u+VLdfL4.PvpLRZDEfqKALqs7WCWi2pAhmxgx1BZr5va9P1
	fjKIp3AfF2jFsnz71KeoZjjXSQ2YTLK08lOeKBRIspN/DrztGUqid/wRfgXVXVN/bPVfQNVZFLQ
	rQYunqPGTDoYX/Q+nLGJes2ApQD4mMye19Voysl1vD1HXsKJzJeTLLsPHkBuSsMXP3dCv2jEvqT
	EFJQzyXHViFKSlGXO0tp+S9F1Rwm60Z7cJp3D/KrbxcnBCMl+equQuXXJIQtg15r96YSq9Frz8d
	w1ov9lMYw5u+JUFEeLlVFPJ3PYPzCTGiGRn7Qm3eK77P/EEFsJ15MzKwThmwn/f/6rG8gHpRDvy
	MVvA==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1708078054;
	bh=l6zek2Py8Yqa9njHsCzaxukuhOlrEzCOSXWIQsdv3mQ=; l=2414;
	h=From:To:Date;
	b=jIprcEarY/HWk4SwH3P/twppjkkUUABQFJFj/gvojpikTdXA0cJOV8k/UksOxj368
	 GTPBxhn9riulSL16tmgo2cIsSCiC6LyKsszNTHOuN8lsvZr2MqzV54+C2JCX/ZYMn9
	 rkxIqtv4PihCFv9kyNM/qukjNv7uUw1k2yyJYSOTLgZR3xZ6MiQv64bWeyHNTqYeVq
	 +ZD1Wx73FrpYHIjuQ+x9iLFAdnserf2MZcF4/BvKoPKti63Of3/ofQLSX2gCTTMTvB
	 GVRXUbVzkLdzTov0C12mdLRGcz95M2ENCsGhXzB89YlBo1A8UptTu5wxEarGDyGvg7
	 3Tk4NMuX5zCZA==

This commit fixes the following warning when building virtio_snd driver.

"
*** CID 1583619:  Uninitialized variables  (UNINIT)
sound/virtio/virtio_kctl.c:294 in virtsnd_kctl_tlv_op()
288
289     		break;
290     	}
291
292     	kfree(tlv);
293
vvv     CID 1583619:  Uninitialized variables  (UNINIT)
vvv     Using uninitialized value "rc".
294     	return rc;
295     }
296
297     /**
298      * virtsnd_kctl_get_enum_items() - Query items for the ENUMERATED element type.
299      * @snd: VirtIO sound device.
"

This warning is caused by the absence of the "default" branch in the
switch-block, and is a false positive because the kernel calls
virtsnd_kctl_tlv_op() only with values for op_flag processed in
this block.

Also, this commit unifies the cleanup path for all possible control
paths in the callback function.

Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Signed-off-by: Aiswarya Cyriac <aiswarya.cyriac@opensynergy.com>
Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1583619 ("Uninitialized variables")
Fixes: d6568e3de42d ("ALSA: virtio: add support for audio controls")
---
 sound/virtio/virtio_kctl.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/sound/virtio/virtio_kctl.c b/sound/virtio/virtio_kctl.c
index 0c6ac74aca1e..7aa79c05b464 100644
--- a/sound/virtio/virtio_kctl.c
+++ b/sound/virtio/virtio_kctl.c
@@ -253,8 +253,8 @@ static int virtsnd_kctl_tlv_op(struct snd_kcontrol *kcontrol, int op_flag,
 
 	tlv = kzalloc(size, GFP_KERNEL);
 	if (!tlv) {
-		virtsnd_ctl_msg_unref(msg);
-		return -ENOMEM;
+		rc = -ENOMEM;
+		goto on_msg_unref;
 	}
 
 	sg_init_one(&sg, tlv, size);
@@ -281,14 +281,25 @@ static int virtsnd_kctl_tlv_op(struct snd_kcontrol *kcontrol, int op_flag,
 			hdr->hdr.code =
 				cpu_to_le32(VIRTIO_SND_R_CTL_TLV_COMMAND);
 
-		if (copy_from_user(tlv, utlv, size))
+		if (copy_from_user(tlv, utlv, size)) {
 			rc = -EFAULT;
-		else
+			goto on_msg_unref;
+		} else {
 			rc = virtsnd_ctl_msg_send(snd, msg, &sg, NULL, false);
+		}
 
 		break;
+	default:
+		rc = -EINVAL;
+		/* We never get here - we listed all values for op_flag */
+		WARN_ON(1);
+		goto on_msg_unref;
 	}
+	kfree(tlv);
+	return rc;
 
+on_msg_unref:
+	virtsnd_ctl_msg_unref(msg);
 	kfree(tlv);
 
 	return rc;
-- 
2.43.2


