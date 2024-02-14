Return-Path: <linux-kernel+bounces-64986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFC085463A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11B7A282BEE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F9F12E76;
	Wed, 14 Feb 2024 09:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="Twpw/uu9"
Received: from refb01.tmes.trendmicro.eu (refb01.tmes.trendmicro.eu [18.185.115.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A98125C2
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 09:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=18.185.115.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903517; cv=fail; b=VrjmgtdGVXrEYnPG6ump+b6cABava8yZeElHdZHJKr7FDUQJufEWqIUMkNO+7GJwMhjrmMVQrPrlNlswSI3Sac2q8PhTq5bITMSEn2nJK7t6R4MDCRwCsybNtvfePiYFLNr2QR01OJh2HrQBeB1oVB8YgL3P17wZ2PavMgyyo4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903517; c=relaxed/simple;
	bh=zi8TyyId7zdcTgy5ByebS2pkzrN6dVMCm0mEOv2I2lU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=gzAj55lPUjBUSeDCDDAFfFYMQeS5Xg/Uy9ZnKtNpe8SVV5jC6LF5pV9hwMLy6v27uPKO7veM/w3umziZXkwX6clHELWrmmjlIiQEnIpXQ1hPKUxSEqnPWzMXiiyh6Phos3fAmehIXmuEk9effJqfHFi5VsN43uQFx95cqeLKlYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com; spf=pass smtp.mailfrom=opensynergy.com; dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b=Twpw/uu9; arc=fail smtp.client-ip=18.185.115.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Received: from 104.47.11.169_.trendmicro.com (unknown [172.21.9.37])
	by refb01.tmes.trendmicro.eu (Postfix) with ESMTPS id 5D90E10058068
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 09:38:33 +0000 (UTC)
Received: from 104.47.11.169_.trendmicro.com (unknown [172.21.199.136])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 31A2610016AC1;
	Wed, 14 Feb 2024 09:38:26 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1707903505.521000
X-TM-MAIL-UUID: c6205d0d-b439-45c9-a48d-614fc24f8fb2
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (unknown [104.47.11.169])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 7F66210001297;
	Wed, 14 Feb 2024 09:38:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hOG9gzdlunrpYR9eEG1VBOk+CH2B7ZAB8QbSpgiSNdE54UEzOwZPecF7VkwmpjD5TtX5EwGBkciFk+vsx+ZFAgW8xMUU5eWGJSkcQlAjVuDv1XjuS+5XF2z7FU8tyllBYGd/gY9VyqxyZhQ9RKedmarEJ2AvwYxAxMIueeQz2Asz9xaI6JiTGCdgeo7lYfU5LhcSp+BWTRgZZcwKArzHpRC9u+GN1q5XuDVCzpx81ForrL+/uNAzPF64Ao8U+hde8l9QcqZ+RnJoOr3wCGeBFYE0Z9gfecIOn1NCZXlXswwM5nXt5Hoq3GiJLGipLpQECFj0ot0W33JMtc4P1RuNYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/QRXNfD7h7qGAgiy2nS8fLn8dHSS7bhLFivdaFpFmqU=;
 b=ny8zaI0qnjEKLwLk3h5SKA71GzIqPbpAq/3Xz89VAA2xB8f6QU0gq3FrxXtRzAwtVqak1007fegMgoG5yuCLC4S1L/rcafhCR2Ouf9/cmbozVyYhOuRrK4oQU2f0UNIQhEOG9OeKob7/XKciYtWY6p/00fa6SGGtmDi//WU/8yLzp8yIVJ/a3QmoGKU2II8tMC39bHppxr5pQmpDTtcQ37voN+5N66UgOB+fdCKGb7P/PahJFcOlKY210mpoGDqak0FheeBBSAeN/BXF0auYTr/ge0Bpqoko4LI9lxre5bVc0WllYgY73Ro6DRsqfQFLAbNOABjTKcGfMaAxTc+mNg==
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
Subject: [v2 PATCH] ALSA: virtio: Fix "Coverity: virtsnd_kctl_tlv_op(): Uninitialized variables" warning.
Date: Wed, 14 Feb 2024 10:38:13 +0100
Message-Id: <20240214093813.578906-1-aiswarya.cyriac@opensynergy.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A6B:EE_|FR4P281MB3449:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8fbcafdd-786c-41ee-aaa4-08dc2d40b070
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pcIeJRBFcjfg/L8PRkdDOdtpd8HCmckomQY73Xjit2aKeeDBPMSz+J2X9v3v8PU1vWlLiCFiPOgrfYWSobHC7gaayVTb3KG8gDP70j2B38iYFvmqOMpJXZ3/2J5gub+WdwIiuH/zxsmM+pRXzqDqfP2YEiFch+H0fkxe9dc9bZwwcpwZ24coPq9jPRnshVP5ss65tif1qmmteLO3v16MVitbYvsmi8oWmewmgSh7UqXz4mopXMPx63dh7j0cyl8+ixHXr6r/MVYDASJsMOvp8nrOKEKOvG0Q36UAv0XnOWoGrI08tj+NvhE4QGOoz/S8adZCi+bCKVMmuG15qiQ5HI/aUbuENetWDPoaxS0wWU7HbP5Z2jGzHe09EMCbYLqgLVWDxHeCsghUir5yJ3MHg3zwTODsR+Nt14XWxtLy7le26PJtW/yyLFnXmhbiW/nDDDlqQEmGc4zyXQXho6g+I8piLWaOL09ij7nxr3d2cjcayzogHkLWBTbVAuDUZ+vM2IpnOzPE0wQwQdwgrLrgcO5YB0uxfexFM08fol9vVDduT3k3YMcYgVYtamvnfD1Dz17U+Mcavdy5M0+VYJAwbhkQ2jUXzS+E3VsAt/Bcsn8=
X-Forefront-Antispam-Report:
	CIP:217.66.60.4;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(346002)(39840400004)(376002)(396003)(136003)(230273577357003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(82310400011)(46966006)(36840700001)(44832011)(5660300002)(8936002)(8676002)(4326008)(70206006)(70586007)(2906002)(83380400001)(26005)(1076003)(336012)(81166007)(36756003)(86362001)(54906003)(42186006)(316002)(2616005)(41300700001)(478600001);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 09:38:24.0473
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fbcafdd-786c-41ee-aaa4-08dc2d40b070
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[217.66.60.4];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A6B.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR4P281MB3449
X-TM-AS-ERS: 104.47.11.169-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28190.006
X-TMASE-Result: 10--9.394100-4.000000
X-TMASE-MatchedRID: IVNJzyZeXh4m6W0B8rdIY/bi+YTr2htSkUTOyGwQKEcG1bmUGNW4DRKy
	wsos70CFgYfoPrmJSwc0MlZvaRoxGO5pF8IH54mMiu6u4shZ+fE304eoJbTN0Rw72DTAhdU77hX
	WJUuROzeNk6CnOOT0tJ4u7onx25Mlk/dA6P3T5FsZD7bjq+6lMGzY00haS8QoYcKx85MjSJVz3h
	/NOzc2C1aH2Ww5mg7njnZ7ULZGdtPt1Qm1UP4H3bo2KXQsvVZSR/Lj9ymbWRKLlRtHfK5Nk+k8T
	n8qScCE31w1NnIhFDKV1h6ijsb1eK0AyU/iBF0WfHZ4iVAbWwx8LgjA4u/K5/+gZM0aHrd/IlQ2
	Q2u3mv3f7qT3sazIOMmngP9RbA2Gek66q4St1YszG22WPtozUnVXYrS4nzkTUpD9C5CYK00=
X-TMASE-XGENCLOUD: f047a65c-4aa9-44d1-be1d-7fd823ffc862-0-0-200-0
X-TM-Deliver-Signature: 6EB0B460C135D74A72E9266240592764
X-TM-Addin-Auth: FfV4VFjiqOvf0hL8p/v/tO6V8jFW4jCP9+rZ3hyRMz40U3AN4r457IWMJ2O
	ri9JmRNNatUx5M0vYPLKoJIj1WVWiqx6nGMe7zG4BCxXNO6E7C7axk2MasSbqXvngicCoYIIxhp
	YC8GpLPJO/w6Woboa43TGQLCHIeqqVzo9Z6KRIe/YlhiQG8FbbO3nN4A5s0q5HqIm9qfYhe2ZFp
	FLspF98STfaKtr8gy9dwNvw7Cpb4ivmTN4nM77cehd2uxLJf2I5DueTcHZTDG3Ykp3Ie70lQ8wg
	pRUdONOW95330CL/CVGVtf2qY2ToGgXzrXTN.xb0G/EvtBgUe++fJbqve6A7PeedsNJ2etGTmpN
	/nqoK92NFu3hf82PY73MR9bFgh9G3pvd1dhgYPa2tSYbc0zzXdN5Hshk3vOXPLe7L/a31WuCbjE
	v1u+9FaKRhuBkHTW7vHckOyBbtkoHhUSEYKc8D4jr+i9Fdh/FyP6jByVmxOxKjVSq5iuN8M4EaH
	YSTYzNSSEfljqI7Q7D+NjXpK7QTr6Upwi1KTShDvvcU2iZSgauTfP3l6dmgC92myD/avk+PWJSi
	piHhYss56Zbtt6LxEBv6p8qzssjBNdXpmrIyNGEJm602ExAd+NoteHBh5ME2bZJ2DxqkIyGlmaI
	r0RA==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1707903505;
	bh=zi8TyyId7zdcTgy5ByebS2pkzrN6dVMCm0mEOv2I2lU=; l=2825;
	h=From:To:Date;
	b=Twpw/uu9unP9Kc/7e+nbOmeRyCVkdFe9dZlc+trzYpkBYFZ/qQc+5HnT4ihXrCfmz
	 gsPWKZ/6QsY4nVocF64KRr8ts1vgUL3qdFC8cM3n5KkmmI5GyiZMP8DlZgmO6JjuZ4
	 ijafDHlN9SrGAk4q2aRZDFTzOGFk7m7y1hycVnory5wRIQ8Sb/NCggeBoqXPG1WjPU
	 BNPJYKyvuzlME0K4S3bT9TDJZYznzrwOQ9Gy2EQwSFuA0ucGPhgB7zCnyJHbMmpOe9
	 +blIv+HZJEgKIxP55EyWLqYtG4lWwscLwpqRluds+8WXvqr7bfIwvNKARsf3mPlUGH
	 uAyTdseUS2h9A==

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
 sound/virtio/virtio_kctl.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/sound/virtio/virtio_kctl.c b/sound/virtio/virtio_kctl.c
index 0c6ac74aca1e..89e29a496dbe 100644
--- a/sound/virtio/virtio_kctl.c
+++ b/sound/virtio/virtio_kctl.c
@@ -253,8 +253,8 @@ static int virtsnd_kctl_tlv_op(struct snd_kcontrol *kcontrol, int op_flag,
 
 	tlv = kzalloc(size, GFP_KERNEL);
 	if (!tlv) {
-		virtsnd_ctl_msg_unref(msg);
-		return -ENOMEM;
+		rc = -ENOMEM;
+		goto on_cleanup;
 	}
 
 	sg_init_one(&sg, tlv, size);
@@ -266,6 +266,11 @@ static int virtsnd_kctl_tlv_op(struct snd_kcontrol *kcontrol, int op_flag,
 	case SNDRV_CTL_TLV_OP_READ:
 		hdr->hdr.code = cpu_to_le32(VIRTIO_SND_R_CTL_TLV_READ);
 
+		/* Since virtsnd_ctl_msg_send() drops the reference, we increase
+		 * the counter to be consistent with the on_cleanup path.
+		 */
+		virtsnd_ctl_msg_ref(msg);
+
 		rc = virtsnd_ctl_msg_send(snd, msg, NULL, &sg, false);
 		if (!rc) {
 			if (copy_to_user(utlv, tlv, size))
@@ -281,14 +286,25 @@ static int virtsnd_kctl_tlv_op(struct snd_kcontrol *kcontrol, int op_flag,
 			hdr->hdr.code =
 				cpu_to_le32(VIRTIO_SND_R_CTL_TLV_COMMAND);
 
-		if (copy_from_user(tlv, utlv, size))
+		if (copy_from_user(tlv, utlv, size)) {
 			rc = -EFAULT;
-		else
+		} else {
+			/* Same as the comment above */
+			virtsnd_ctl_msg_ref(msg);
+
 			rc = virtsnd_ctl_msg_send(snd, msg, &sg, NULL, false);
+		}
+
+		break;
+	default:
+		rc = -EINVAL;
 
 		break;
 	}
 
+on_cleanup:
+	virtsnd_ctl_msg_unref(msg);
+
 	kfree(tlv);
 
 	return rc;
-- 
2.43.0


