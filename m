Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971007A96B3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjIURBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjIURBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:01:15 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F3E10E7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:00:38 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-52c88a03f99so1342786a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695315599; x=1695920399; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=y2cRr9MR3inkHivewxgnnyGI8y8gUo1y4W6FkvAgzTY=;
        b=N+M4LAQxuCquzHz1SgAh1XErcvaztpevF2SXbObbCRblS+Dacxl+Gn3j7HEp9eV6xt
         eMV1BiO96mbXNFy8EdTQdyiwgWj8xWVstXTozABnIQDXl/kn+NSuXBqbSOFPw/Qd8oMx
         0oCVNe5p/MP8CokI7PwhMUQoKvBXJsLxxcJFW28WBKv9xRf2yX9/s7fOK67gNjuMFSVC
         h4C66sJ/ABjbBSfbndEP7uYIszHPVfYV4J8s+L58Mv9EICxjLWXyu4sYlpnHO7RY22Xq
         MbV0hc7wpsNzsYPelWptrYEeHIheXfKDRM9zCWiFHY4z4CvrZbfshx+gCw4zMDn/u0MX
         nwlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695315599; x=1695920399;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y2cRr9MR3inkHivewxgnnyGI8y8gUo1y4W6FkvAgzTY=;
        b=YyGvpSVeRWYmgPEbedZoGIjlk//2PSelLQRHdtwgHiaFBqihjUmqRrNYS6AmqMsUJ5
         FIh4MXn/agIXd5+/WDgnVtzk4c3DBmP+I2U0b7oVOxRr/hn1bOGYil6z4ZQIvSdndBXU
         +Ko321E60zzQRGiNYT/FyGJN93ss76ZND8XY8iFTbiQlSf+2htSlVqM0ZuylkLANw1no
         gHdo+9vqxRxws8PgRnZCgpR8yZghkWWcsGUDCJsJa3Ol3HNmOGS/hjnkgfQzgL8aLR/p
         mB6N09wm7VrjKQI/hIfsF0+VWXFe79pnn7Yzlv9xeC0uI+/7Pphd4Na8xUPMbW1AI8Ub
         ybXA==
X-Gm-Message-State: AOJu0YxjraO1C3hD6xNkBW6NdXolenhwGAOPDuG8qUJlRTl2B7VD8vTC
        nYdWNuV9Gs+ylqw7ShAU//BAGmfvmdwVTHFt
X-Google-Smtp-Source: AGHT+IHcq103dNlblMZBQY/j6iBfw4bjgl3Ly21aJcgJdHUNGAfybxeqKUdIET9dZUi0Y+dCo0YrMg==
X-Received: by 2002:a05:6512:2813:b0:503:3803:9e99 with SMTP id cf19-20020a056512281300b0050338039e99mr6882214lfb.15.1695308390088;
        Thu, 21 Sep 2023 07:59:50 -0700 (PDT)
Received: from ?IPv6:2600:1700:7c80:b060::49? ([2600:1700:7c80:b060::49])
        by smtp.gmail.com with ESMTPSA id l29-20020ac24a9d000000b00503258fa962sm316840lfp.199.2023.09.21.07.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 07:59:49 -0700 (PDT)
Message-ID: <ae875c6cd54089a108007f6d32aca2c8e61c0c2e.camel@gmail.com>
Subject: [PATCHv5] ALSA: hda/realtek: Add quirk for ASUS ROG G533Q
From:   Abelardo Ricart <aricart@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Date:   Thu, 21 Sep 2023 10:59:47 -0400
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
--
2.42.0

