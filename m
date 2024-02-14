Return-Path: <linux-kernel+bounces-65314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBDC854B00
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D3F41F23124
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705D25821A;
	Wed, 14 Feb 2024 14:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="P53Ksp8v"
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu [18.185.115.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655C25812B
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 14:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=18.185.115.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707919293; cv=fail; b=CPmpbIeW/A+jvKg9nBvThNvbZaBULAsmYEXfij85WKrpLHz8iXZMBL5ymQv/zZfEEfQ51ABPEZtVSYqd5+NNoEWEn+MYU/JG00FRCDkKNPOqyW53YsF0jG60HmxPeaDR6djKfParkCCqSVfLNkP0uKYMEqwfd0qh0plaNSqNuYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707919293; c=relaxed/simple;
	bh=N26grMB+4hXsM7TWuNxB0YdYIKHjCb8DKQT86+uu9gc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=fe8Ol8+rtH5U9AZpoogMKAWCRcj7TvwfX23E1fl0bq3+izWsqskM72qPV3KaEHWKYql4KuU7YyZofSc3Le2u9jwRD7qILvydIhreAx7GsieqIKefIctp+hzaLIKBgkcSqazi95YMEIEYNSkAl5Lw/CxmzlroBJ453oI0liaKFhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com; spf=pass smtp.mailfrom=opensynergy.com; dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b=P53Ksp8v; arc=fail smtp.client-ip=18.185.115.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Received: from 104.47.7.169_.trendmicro.com (unknown [172.21.165.80])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 642A11000134D;
	Wed, 14 Feb 2024 14:01:23 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1707919282.939000
X-TM-MAIL-UUID: 530a122a-9c7a-4970-93cf-20d8f174c5ea
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (unknown [104.47.7.169])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id E573C100003D3;
	Wed, 14 Feb 2024 14:01:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B/0UvTeeEqWqgYbvSh66FBRCONVXpn6VV/yZl0OfP/bqlGofvfsAjDvSHiu7IRLxE4sP8nnH8sM8nHAKwLUsx2tkLd7/UQgVYd2p3By5QxpbaJpn2ichboCECkp4IxJceU6HUVjhGmPq41Jc6kmS3P4jLH2+8wWf1nEfJ3pYizfa6nUXWys7jbcGIdES27A4dIhMtdh7X56lG3Z2nqwBqulijmA6C2G/q3e4gcMdHekQCwlF/qYElYChp+lG4aJbJfoSF7dEd8HVehA/84QIObcTFh9L32ygwP7p++EP5mVDgi6A4PQ4P0M3K2wd4n922X9gpefyEnYGaofl4RtiUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mkMdCTqKzl4fqR8xrB/NO/gH1H3XFr6FUGGs2cMnrmA=;
 b=b5A7GQoKvEVn0avRlpGHO1YScrvV234MDXC4JP2vrSSU5r51FwYT/59wzVnbl9ZpEBUBKN0QttBJCnVNX6B0VIvDyIXPRVgOE4yNhwz2t9k3G3KaZ7IfC8x3VMdtmq46odw01a9Rppco3IobNYMTDvQ7DI6O9Q7h4gAkTG9f1v/Mopdub2uLlL6/uqa0bes859xh2035haqdUWoOBYUMeM7T9kem2l1s6wxFzQ5NlVNByiLqTpWZW/W+mGddY0tqYFQNaAgQACeCZSCNepF70JN1eb1St3yzlZFC5sTfZiIlJ4k1I/qlkJ/0eJTCHcTyYsAO/nbFUG8rWVcrxugP6Q==
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
Subject: [v3 PATCH] ALSA: virtio: Fix "Coverity: virtsnd_kctl_tlv_op(): Uninitialized variables" warning.
Date: Wed, 14 Feb 2024 15:01:10 +0100
Message-Id: <20240214140110.606171-1-aiswarya.cyriac@opensynergy.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A8:EE_|BE1P281MB2856:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 81327a0a-1ee0-44c5-6a30-08dc2d656c03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QQIvB27O0AArrRjFTl8Y8Lwql2aOhHFqZX7MWoTKd97Mjbg0LOeJum7E0rujwq3Az47dKTdsO2Gbx4G4lobVPY3ZVBHxCS9faN1rp/GY30EYnreJJE3I7GOAXgD21XrQ29cpR/etEmP17cy87A9p0jbpNA/tybnCnoKIt8IQi3r8c2t+xmq8s/6rIXp3aAvqrSVC9Q52mjNKScIDNrpBmn0GKRwjk5V0TQJeY+bfBmiE1mP4u2XFXgpSvRHkLoWrVd/J+FlYHNw9LM0xReFSLjf7vI7wQR1bfTYwaXe5C8QaR08zB72RE3DiEvfWKH12K6pKHWVAankaE4YrZmgNUaQHdvGi28D1Pfb9dSJgNPMrBYE3MrQcDHAXU1X3QzBUXtb63W67awg4I3feuNNq+E3DkCUkDspYt56DfsvA8lKqU03WpFM74+Q++gbbB860RXF1fXFes2T81tJxzn4Z4GCt0vWZWUiUhtKgs/0ComeYIzR79Dkc/s2Cdn9T45tFou+xUhYoqJb27qhjhnvZmY6pMXuv0g3YvbmH0E+kqQRPlEGBgB88hzOM7zNsVBtXIZpe1EMxQ1qiliXhDweAPs5vQxacVBoCUYE5zoSMbT4=
X-Forefront-Antispam-Report:
	CIP:217.66.60.4;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376002)(39840400004)(136003)(346002)(396003)(230922051799003)(230273577357003)(64100799003)(1800799012)(186009)(82310400011)(451199024)(36840700001)(46966006)(478600001)(2616005)(41300700001)(44832011)(2906002)(5660300002)(8936002)(4326008)(8676002)(70206006)(70586007)(54906003)(42186006)(316002)(1076003)(26005)(83380400001)(36756003)(86362001)(336012)(81166007);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 14:01:20.6096
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81327a0a-1ee0-44c5-6a30-08dc2d656c03
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[217.66.60.4];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A8.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB2856
X-TM-AS-ERS: 104.47.7.169-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28190.007
X-TMASE-Result: 10--9.394100-4.000000
X-TMASE-MatchedRID: IVNJzyZeXh4m6W0B8rdIY/bi+YTr2htSkUTOyGwQKEcG1bmUGNW4DRKy
	wsos70CFgYfoPrmJSwc0MlZvaRoxGO5pF8IH54mMiu6u4shZ+fE304eoJbTN0Rw72DTAhdU77hX
	WJUuROzeNk6CnOOT0tJ4u7onx25Mlk/dA6P3T5FsZD7bjq+6lMGzY00haS8QoYcKx85MjSJVz3h
	/NOzc2C1aH2Ww5mg7njnZ7ULZGdtPt1Qm1UP4H3bo2KXQsvVZSR/Lj9ymbWRKLlRtHfK5Nk+k8T
	n8qScCE31w1NnIhFDKV1h6ijsb1eK0AyU/iBF0WfHZ4iVAbWwx8LgjA4u/K5/+gZM0aHrd/IlQ2
	Q2u3mv3f7qT3sazION7HrpZ+w8gTuCLAbM1KPMWlJOuQIPs6Xwd6ds9tOCD/YC7712GQvJA=
X-TMASE-XGENCLOUD: 9d4a58d3-83d8-42ca-95a4-c5f1498b9725-0-0-200-0
X-TM-Deliver-Signature: 1D378BEEC179F66B9046C83A498F89D2
X-TM-Addin-Auth: VjYOf3/ABGdYnfpr7jRKvZszLrd73655spTHKdCnW0usDFMhwlalxki2nEJ
	+jwKG8bm1Ql7vqgAcehIBtPPct6gbawsGK7mQvfNTaW1sk3QIsD34LMkD+EM5QCdCZ5yu+J/Cf4
	PgsA251TywwQm+5Ly5ZjfqezcF+aYDcddcHwftOtomxDGl9VNZoXI0VJ27HAlf+4c9HKRll57eE
	BLnHst2sAyGPiemOSOswYqBl8ad5rWzgHorrdC2BbWoI7AJk57FqLjPjfGedyKsQifXDZ8CIhw6
	1htdLHOJ9dA9bQZYlDvWUesoeaGuPWhAJai/.rAQcqu6sd6itNjTXcICukKFSQHokSXsfGC2yUd
	dazLcmXAiEVfly/RUB3/sA7Q1qQP2TGlF+WbwxEdWRFtZB7SW1Yug4z+BqNLmn3PpH1psAJfgqR
	jfC+o874zuFn+OJJTj0BnEALrVkuiivnf/z9ZaFUjGckBHkTiWUzmGWdySPrTt24dTlzboQejHK
	CMS+cgKbFOKRlOBZSZZ7Zu/VEh647LMIPZWNpeDfzz12YPl2Gsjt6dJvT6Q9ElhUH72W+4NRStm
	5yTR5PFgnlmW0HzjuBm+glL5oBgNkr5xGGRSiGNtxWkgFrO89uNsgx/lfEw6uriAIiodfP9Bg/r
	tNjg==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1707919283;
	bh=N26grMB+4hXsM7TWuNxB0YdYIKHjCb8DKQT86+uu9gc=; l=2842;
	h=From:To:Date;
	b=P53Ksp8vyCoQ/fPpA0v0oo3Bz5ZxDuYs0bjyvmmBRBHNcL3qvdBQDi/mhdTLYXm6U
	 ZdMfnszJLQhydo1j0Q47hLCVGUkp9nPhRWXTQR/HAQSJvdvyQKZWxa8seSwptIewjE
	 AV4kz0NwyfLqecumj4Dtf7v/VJ/+aP2n5EhZ/+t0d/EeOQyxNxeMrIURlLUda/FKum
	 8LDa+ctmR9tNAcGK9CvLYePUUO1yCGN4LpZK7YqIX5jR7YcV1wBlEgsGxtw1FIZmpd
	 hiJxLrHrZAoPu/UedqrqNx+G6vZD6Frq9Q0yyYuyYToN0glGQKwblyrP1hvOyaGMPP
	 v10F8rpARKuzw==

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
 sound/virtio/virtio_kctl.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/sound/virtio/virtio_kctl.c b/sound/virtio/virtio_kctl.c
index 0c6ac74aca1e..40606eb381af 100644
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
@@ -281,14 +286,26 @@ static int virtsnd_kctl_tlv_op(struct snd_kcontrol *kcontrol, int op_flag,
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
+		WARN_ON(1);
 
 		break;
 	}
 
+on_cleanup:
+	virtsnd_ctl_msg_unref(msg);
+
 	kfree(tlv);
 
 	return rc;
-- 
2.43.0


