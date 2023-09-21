Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E8F7A9AF2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjIUSwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbjIUSv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:51:26 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4745AA85
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:36:03 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-98377c5d53eso155534566b.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695321361; x=1695926161; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KjZaZ7zAEzwqaT5nxaHvHNLjCmzhZbs2PkjAyL466o4=;
        b=NDMUw4rt+MCc6fC1bFq4UED7xj4PbRsgt8jYpNkHM5a8GT6A/7TwBaIMdh2xS1zMVh
         F5R0vWzm5eUBCYZTbMl18Opr3tfOYIbWn0SP0zlXkNkp29MKQfdFCqUYEet1RQuCz+OH
         HWGfY1uiEudDYpAhcBG5l5Jw2JRBG3CSln5WmS2UgRxeStMiLvmVM2ex5z4S/+ukJNG4
         f0mKmRxhxPyUUrQ6MAeu5leM+Sxf1IQ/zbAgBstgHB7cjOtbfSh5kgl187XHZCyGhXVJ
         I02wBFt1e5SAo+jpUC78+CjvffKid346iQL/unVg8dS+B6ShFkYvLgs5HlS99PT6VQB3
         Frzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695321361; x=1695926161;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KjZaZ7zAEzwqaT5nxaHvHNLjCmzhZbs2PkjAyL466o4=;
        b=WlHfFVFgjv89smGZQ3oOTKwohEE8GekMgWtTcYZoJAMtK5Ol40M5Z+yJVjoBFkkkXj
         QtW/pv/Qjuvbt6ycJYwkj++eHAmktsiHhKyR+7ADGcR/Zbvb65blDa+BKGbR7odjLj0W
         6NDN6Lfji7jTW3cFeC9bZc5WalSHzg0uWcGoaDQP4fKWuxoI6Av+6u74A48MkAs8xm5G
         X1gpREMwun8S4sT2Rd2vjb/LzZe5S0Q5hSu7wvIxHAdWbloNvxX//YpZa5sQHbN7EfAL
         lEQKQCdMvx4tnxzA4dKw2IhGRH6uxEnED90foIVQbfmDk4k0g01nUtVFgrJq4Bqm7Aq1
         6UXg==
X-Gm-Message-State: AOJu0Yza41Y/zjTCn7TOweWZYrfDoxipH5Cum4Ca43Hn1hHf7f2wTTJg
        lN33yAHkgx93nzCWG2CIqDEJkdFCkoGc312d
X-Google-Smtp-Source: AGHT+IGT63FwGKdynnM2iEy/g6DQL7yDfrmNAZ1/rqqsjMjHjUOOYUOpBD2RAr8FsqOin8zAXkzHtQ==
X-Received: by 2002:a2e:874f:0:b0:2be:4d40:f833 with SMTP id q15-20020a2e874f000000b002be4d40f833mr4315798ljj.18.1695284702608;
        Thu, 21 Sep 2023 01:25:02 -0700 (PDT)
Received: from ?IPv6:2600:1700:7c80:b060::49? ([2600:1700:7c80:b060::49])
        by smtp.gmail.com with ESMTPSA id r24-20020a2e9958000000b002b6e15ccf88sm219377ljj.135.2023.09.21.01.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 01:25:02 -0700 (PDT)
Message-ID: <bd1a20e08c492c2543006e4edcba3b025c527066.camel@gmail.com>
Subject: [PATCHv4] ALSA: hda/realtek: Add quirk for ASUS ROG G533Q
From:   Unknown <aricart@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Date:   Thu, 21 Sep 2023 04:24:59 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The same quirk applied to the ASUS G533Z is also applicable to the ASUS G53=
3Q (of which I am an owner and have thus tested).

Signed-off-by: Abelardo Ricart <aricart@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index b7e78bfcffd8..7bb3c1e05bf2 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9781,6 +9781,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] =
=3D {
 	SND_PCI_QUIRK(0x1043, 0x1493, "ASUS GV601V", ALC285_FIXUP_ASUS_HEADSET_MI=
C),
 	SND_PCI_QUIRK(0x1043, 0x1517, "Asus Zenbook UX31A", ALC269VB_FIXUP_ASUS_Z=
ENBOOK_UX31A),
 	SND_PCI_QUIRK(0x1043, 0x1573, "ASUS GZ301V", ALC285_FIXUP_ASUS_HEADSET_MI=
C),
+	SND_PCI_QUIRK(0x1043, 0x1602, "ASUS ROG Strix G15 (G533Q)", ALC285_FIXUP_=
ASUS_G533Z_PINS),
 	SND_PCI_QUIRK(0x1043, 0x1662, "ASUS GV301QH", ALC294_FIXUP_ASUS_DUAL_SPK)=
,
 	SND_PCI_QUIRK(0x1043, 0x1683, "ASUS UM3402YAR", ALC287_FIXUP_CS35L41_I2C_=
2),
 	SND_PCI_QUIRK(0x1043, 0x16b2, "ASUS GU603", ALC289_FIXUP_ASUS_GA401),
--=20
2.42.0

