Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6725F772D45
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbjHGRtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjHGRtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:49:33 -0400
Received: from mail-ot1-x34a.google.com (mail-ot1-x34a.google.com [IPv6:2607:f8b0:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3230C10F0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 10:49:32 -0700 (PDT)
Received: by mail-ot1-x34a.google.com with SMTP id 46e09a7af769-6bc7afd0498so9390447a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 10:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691430571; x=1692035371;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lvTqsAuYDg6pJiZTtB6ZMlYo7Jtn6FS/cj5mVT1Lh+0=;
        b=VYtva0u1UQj3x9ZSO1yuqxuAHrjmu3o+hHzAmbTG2LG3SW2I2x4Ahm/h0/boF43ElS
         R0NKeHmz2vFckrQPp1dqMkPRx6riDwxHuE7ZyWa3TrfpFB6ZTRYgeIqvZn/epGrEnuIk
         AqaGb2CAHARkz1eTMLvLPSvlZJiXdeKgtc6QDIbwbUdN+tcDmkD2QmCYORDCqaZ8TM0p
         nHoNrvHy00LeCE/OIBaB8xqpf3NbTvh+USGgky0bv85rwQTXy1mBcPYn9j7AMZrFQauP
         ce3GruZFlczh3rr90Z/gYYsqoV4dzqt0jUBTja+enXD/QUJSETU8FXP+RCGEffwzv+nq
         xzEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691430571; x=1692035371;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lvTqsAuYDg6pJiZTtB6ZMlYo7Jtn6FS/cj5mVT1Lh+0=;
        b=NMXwGTPpPJ7A39un8CfDjQjrZkOKYsjBAHsf4hjWMGVL5BBOiwE6z84rSMiMCAc53L
         6d8iQt7DG8G0h3DdvhttZSnAM7tLxTiLFqOg488nbmdwzl3vMG92liPGGT352wED2j8p
         tqdPVj0LYdu6ZjgjC1ohTaYona2cDACgzddP7OcKKME7w8CeJyAPvsZ/sYTeg3MLSk/9
         /clRm5YFccTp/IAxDZyVjh5qOYpMEysrw4O5PNCJ3Ol5R/nanqcay3jx22fcBacMKOwo
         HWMjlp4OlnYmUlDX5J7HFjKcRufwU7MdAUDwapN1auJDHXh8Eslw76V0a9BMJpK3+LLE
         QKyg==
X-Gm-Message-State: AOJu0Yyg2Du/Glwuv1DnMA27FFXlvOcmsfA4WmUyPSbokxXoGgQpa60e
        5GaCGdpCI/SpFQfZXhACFwbeV0ZgGKsLwoQXJw==
X-Google-Smtp-Source: AGHT+IHn3JrxBCkxtBRwtWs4Y+KDOf5zBeJmbUjMvvC7zoFNpobgh85JmBn1m+oRFaKQ1C0WAv0im5nnt94mQPvwOg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a9d:7c95:0:b0:6bc:b75c:f32f with SMTP
 id q21-20020a9d7c95000000b006bcb75cf32fmr11241444otn.2.1691430571266; Mon, 07
 Aug 2023 10:49:31 -0700 (PDT)
Date:   Mon, 07 Aug 2023 17:49:28 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAKcu0WQC/x3MTQqAIBBA4avIrBvwhyi6SrQwnXI2KkoRhHdPW
 n6L916oVJgqLOKFQjdXTrFDDQJcsPEkZN8NWmojZ2mwpit6zI4xeIvO2EnpfdLWjNCbXOjg5/+ tW2sfnbTOTl8AAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691430570; l=1948;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=xdOHWoLsICV7kUxr/6xDknStuYMXv78lIRyu9paMiP8=; b=tFxAj2FlZPOq0oZKEB/bIYDagN+DiU16Koww8F9rnQI1LEkVkzSsnFMSpUQ4J53g/GPHsTbiL
 jC4KhL4eV8mA93uTvIXU3O3oEwXceeyJagwD2lIK4s1jLye7qa03Wcg
X-Mailer: b4 0.12.3
Message-ID: <20230807-sound-pci-hda-v1-1-6d9cdcd085ca@google.com>
Subject: [PATCH] ALSA: hda/tegra: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     alsa-devel@alsa-project.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

A suitable replacement is `strscpy` [2] due to the fact that it
guarantees NUL-termination on its destination buffer argument which is
_not_ the case for `strncpy`!

It should be noted that the current implementation is unlikely to have a
bug because `drv_name` is a string literal with a size of 9 while
`card->driver` has a size of 16. However, it is probably worthwhile to
switch to a more robust and less ambiguous interface.

[1]: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings
[2]: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html

Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 sound/pci/hda/hda_tegra.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_tegra.c b/sound/pci/hda/hda_tegra.c
index 9d0ab043880b..f16740500d46 100644
--- a/sound/pci/hda/hda_tegra.c
+++ b/sound/pci/hda/hda_tegra.c
@@ -378,14 +378,14 @@ static int hda_tegra_first_init(struct azx *chip, struct platform_device *pdev)
 	}
 
 	/* driver name */
-	strncpy(card->driver, drv_name, sizeof(card->driver));
+	strscpy(card->driver, drv_name, sizeof(card->driver));
 	/* shortname for card */
 	sname = of_get_property(np, "nvidia,model", NULL);
 	if (!sname)
 		sname = drv_name;
 	if (strlen(sname) > sizeof(card->shortname))
 		dev_info(card->dev, "truncating shortname for card\n");
-	strncpy(card->shortname, sname, sizeof(card->shortname));
+	strscpy(card->shortname, sname, sizeof(card->shortname));
 
 	/* longname for card */
 	snprintf(card->longname, sizeof(card->longname),

---
base-commit: c1a515d3c0270628df8ae5f5118ba859b85464a2
change-id: 20230803-sound-pci-hda-c3a712b72a35

Best regards,
--
Justin Stitt <justinstitt@google.com>

