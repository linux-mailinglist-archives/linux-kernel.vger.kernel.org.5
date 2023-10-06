Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB0637BB0F9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 06:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjJFEtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 00:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjJFEs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 00:48:59 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB51E4
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 21:48:58 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a4c68a71b2so27266417b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 21:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696567737; x=1697172537; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JxejygH5qmziLoyCgFqVOSem9ij83WNjHKlHtGyea/0=;
        b=WCuTswS0hfWm2KQuLF6pNQFSUG5pmT9yA6Qvy741rKtY7NSunuLTnYzDiECtzbvrn5
         eJmTXU4zXHzQFC4s0sLLI0GpIbiAtMj7HEVbcVcooc9Do8+A5R2DVpi4S6+fBcOQI2Zr
         oOjzo60uC6UdLDGnrCSDW8P/L/pgFS/A8PbI/19sZuQE7a4nxTJQaX9bVT+PFHWMRXRM
         obwPirPtRfXdsuO4D6zoxPJCTUeqf7rssoZl57EBN+mtIsX6z2J0aZJhWp2L1QW+MAbH
         x7yGBySNgcBZEyRak1THHC44GqG3pPJ9od8QcOQ0FYZVeBWPfYZ8jNCarvCF2SAJLH02
         5R3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696567737; x=1697172537;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JxejygH5qmziLoyCgFqVOSem9ij83WNjHKlHtGyea/0=;
        b=iLlTca+l7z+IfbirHdtGsN9AIHl6B5ipoZnOoHULZkRo3fPadfEOxBSjoS4Qc3OqWK
         U7o9Q2xJHCTh//1V4USNvnYSnOUm6KdU1MSLuJLmLNwzH8/V2lifAYGBfvL7I3F4m0Pl
         k3MP1gzj0jDiKmDZ2OCzlgEbFmjnjwBS1yhcARd+7/2h7sGwy4KlRbr/b/jejrdPqfuk
         Jbo0FI2vCSSBhgf73DNdaWiJf0vWQSsEVCmlnMZvOdf5N+v5Bg9rhCuUZYqTNlVVPdlv
         zpLSLucdiSC4xHJg2dtV5l/OfirMBzmToVf8arIae4iYm+hkrWg0rXBPc/JzntapRYgQ
         u7ZA==
X-Gm-Message-State: AOJu0YyuEHEl01ZWG/wtJAfbaL9IHODw6GDkZnry1csylKQEHhZhYHYQ
        vPQip1bStyHzmjnMg8OSnNzKO8IbNpzCaZ1FPAZRhw4Rj1Sk6uvRvMXjE4UImrt7LMwtbrLy/Uj
        XO/+Ohp+Fx52EJ3+aTw7x0MKC7salnIdL/oNMV5b7OF6IQnk48Pzjbj5iwzbTBWg8/VgWecZid9
        J0IF0=
X-Google-Smtp-Source: AGHT+IFwu0d3ihn4gfb24LNDEvVO/zpZNwaYH6ZkrM4PBSQoFA0Ivz14Dz2lcssbOLr0V1WOd8lY2nHVMkCIGmTr
X-Received: from whalechang-p620.tpe.corp.google.com ([2401:fa00:1:17:2858:46bd:751:759d])
 (user=whalechang job=sendgmr) by 2002:a81:aa4d:0:b0:59f:3cde:b33a with SMTP
 id z13-20020a81aa4d000000b0059f3cdeb33amr126492ywk.6.1696567737168; Thu, 05
 Oct 2023 21:48:57 -0700 (PDT)
Date:   Fri,  6 Oct 2023 12:48:49 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Message-ID: <20231006044852.4181022-1-whalechang@google.com>
Subject: [PATCH] ALSA: usb-audio: Fix microphone sound on Opencomm2 Headset
From:   Whale Chang <whalechang@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     WhaleChang <whalechang@google.com>, Ai Chao <aichao@kylinos.cn>,
        Jaroslav Kysela <perex@perex.cz>,
        John Keeping <john@keeping.me.uk>,
        Jussi Laako <jussi@sonarnerd.net>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: WhaleChang <whalechang@google.com>

When a Opencomm2 Headset is connected to a Bluetooth USB dongle,
the audio playback functions properly, but the microphone does not work.

In the dmesg logs, there are messages indicating that the init_pitch
function fails when the capture process begins.

The microphone only functions when the ep pitch control is not set.

Toggling the pitch control off bypasses the init_piatch function
and allows the microphone to work.

Signed-off-by: WhaleChang <whalechang@google.com>
---

 sound/usb/quirks.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 598659d761cc..d4bbef70d2f7 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1994,7 +1994,11 @@ void snd_usb_audioformat_attributes_quirk(struct snd_usb_audio *chip,
 		/* mic works only when ep packet size is set to wMaxPacketSize */
 		fp->attributes |= UAC_EP_CS_ATTR_FILL_MAX;
 		break;
-
+	case USB_ID(0x3511, 0x2b1e): /* Opencomm2 UC USB Bluetooth dongle */
+		/* mic works only when ep pitch control is not set */
+		if (stream == SNDRV_PCM_STREAM_CAPTURE)
+			fp->attributes &= ~UAC_EP_CS_ATTR_PITCH_CONTROL;
+		break;
 	}
 }
 
-- 
2.42.0.609.gbb76f46606-goog

