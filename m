Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2FA37AA268
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbjIUVQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233259AbjIUVPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:15:31 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB6CE38A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:07:51 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-32179d3c167so1058875f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695316070; x=1695920870; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJ24ZdmC3+/lt3MKiQj6DVhfuE70M1LQ8RFFhKZZS5Q=;
        b=m4h5oNxEhFnt0KEqrQrm+goetHUSxIGXh/x7Rql3jDFVzUBo9iwyXN9lwuOMWZq4+f
         4ZFg5fdh7R+bNKsvbe92Lex2ggGf4rUOTPh6/cJsynoeGLRs1p8i2xIpN4QrRW8Mx82u
         0MsjIhNvMEHgv0FGZ70O7uB9nGee8s4DRKrzu/xjMrs62nf17A60GynHraNFe69uvb96
         S8Gt6tWIJ4fSwL2Pc4wMK77EtFknr0biiMO92AZ1vblILT+qYAO8WqSRAZr2diPcuxkc
         0CrIen+N2CNdl0gPQ0cEtZg3lgzOsZp/Dd0SrdojryXrbe0aheV32H7pSMOcDOxg+JUb
         r/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316070; x=1695920870;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tJ24ZdmC3+/lt3MKiQj6DVhfuE70M1LQ8RFFhKZZS5Q=;
        b=kRQ6NexjWc4vRoHCro7Qm+llCVZkz8y0m/skrCLqS5uHnJwUeN0SQFMo0id1PdsJyR
         fzdsi+GTQA63ec56nqTrCSg7oQPLjqXpY8j+B/nmpF4eDPZ3aG4z0k5Y3tskirBQTZ00
         U69NvMJKcy5TFOLGHdHfJzVuvZ32Fg+V4rJ3XPS/maDTQ9KIyBiilmteNwWJh1LiYBgZ
         zXYdhqReITHgr9XcoaE5XV3OJ+b4uPg50pMFSicSnMQ899sodmlcOAmFGpNOEQrTj9yR
         gGWlmUhSNLYZFZ+eV/39Ijg6cwwQd2Z/ahWoGy/5FBUa0rG8OLV9SHT+ZWlVWXXD6xw8
         x3hQ==
X-Gm-Message-State: AOJu0YwQSRH5tzAh0gVjPj/s086rwvSge+rIDzXkXRVgMjzskzIb0zs9
        8shQ7oZ2P/sD+kXABBUXOK1mwejVuIjOI3kG
X-Google-Smtp-Source: AGHT+IGs0qtNZWOH6DxXm1gSJbUU3dEbdkMCJibtY+QMhmhM5rkk01C+bRPoVqBat+5lBt7WZgRGKw==
X-Received: by 2002:a05:6512:110e:b0:503:7dd:7ebc with SMTP id l14-20020a056512110e00b0050307dd7ebcmr5159929lfg.18.1695279520238;
        Wed, 20 Sep 2023 23:58:40 -0700 (PDT)
Received: from ?IPV6:2600:1700:7c80:b060::49? ([2600:1700:7c80:b060::49])
        by smtp.gmail.com with ESMTPSA id 8-20020ac24848000000b00500a467914esm167556lfy.38.2023.09.20.23.58.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 23:58:39 -0700 (PDT)
Message-ID: <348823a2-af40-42d5-af30-dc00eaf1d90a@gmail.com>
Date:   Thu, 21 Sep 2023 02:58:37 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
From:   Abelardo Ricart <aricart@gmail.com>
Subject: [PATCHv2] ALSA: hda/realtek: Add quirk for ASUS ROG G533Q
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The same quirk applied to the ASUS G533Z is also applicable to the ASUS
G533Q (of which I am an owner and have thus tested). Resubmitted for
e-mail formatting issue.

Signed-off-by: Abelardo Ricart <aricart@gmail.com>
---
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index b7e78bfcffd8..7bb3c1e05bf2 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9781,6 +9781,7 @@ static const struct snd_pci_quirk 
alc269_fixup_tbl[] = {
SND_PCI_QUIRK(0x1043, 0x1493, "ASUS GV601V", 
ALC285_FIXUP_ASUS_HEADSET_MIC),
SND_PCI_QUIRK(0x1043, 0x1517, "Asus Zenbook 
UX31A",ALC269VB_FIXUP_ASUS_ZENBOOK_UX31A),
SND_PCI_QUIRK(0x1043, 0x1573, "ASUS GZ301V", 
ALC285_FIXUP_ASUS_HEADSET_MIC),
+ SND_PCI_QUIRK(0x1043, 0x1602, "ASUS ROG Strix G15 
(G533Q)",ALC285_FIXUP_ASUS_G533Z_PINS),
SND_PCI_QUIRK(0x1043, 0x1662, "ASUS GV301QH", ALC294_FIXUP_ASUS_DUAL_SPK),
SND_PCI_QUIRK(0x1043, 0x1683, "ASUS UM3402YAR", 
ALC287_FIXUP_CS35L41_I2C_2),
SND_PCI_QUIRK(0x1043, 0x16b2, "ASUS GU603", ALC289_FIXUP_ASUS_GA401),
