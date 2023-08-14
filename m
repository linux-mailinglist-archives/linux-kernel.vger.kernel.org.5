Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27DD277C2E3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 23:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbjHNV7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 17:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233224AbjHNV7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 17:59:04 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E81E10F2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 14:59:03 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-589f986ab8aso24706667b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 14:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692050342; x=1692655142;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7+v0iX7TUi8hXK4ezowS7z03UPB+wBbokRKsGRyaepc=;
        b=3UTJ2GU3B3nLY5FYApPVdVBYQydT9CWZh3UUGR+QtQue9+8lYfdh8O+zvtzT0VMZ7s
         FiuIoV8xEOhjeccvVpTXLvrXMIkCPCaCBYLJKJT/synC01RnTAnSeWzunra6OITXmBz3
         7nBT01lv1SfoQSnv3Gz+R7FwHSHy8LD5+jY6/U4Fjt/kQrrhD0ICKaCLFKClq7zUMzT5
         xSo8fiwdL6NEK9wET8SC/homurpLe7H/WmzHXNOLOAhlsRHYtwZoZE02ce2LFDDQcOAT
         Q/H2+mvY11Ak8tJaALA5CMi2hC5y0xFpl47tMhFO7MT2heQkJJlGxZmsTPtWTGGmFDC8
         LeRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692050342; x=1692655142;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7+v0iX7TUi8hXK4ezowS7z03UPB+wBbokRKsGRyaepc=;
        b=c0GvzTp7dfcZIII9uBzR2baUe+hp2heuzcVoYc+gasmHJvXW7CzlPasE2LcHaZ6uCq
         4Z4AgCrXK2MvoRhP0e9SegRV7z3JzKpIKWIWRzPU3OBSeovc8c90aClMFEpbXczw/1t+
         b59AiGPf1KkPzlyrEICOBUh/h22XNSBBI4tCitdRMojzb/5XY08PlAcB8jD6SuW9A51R
         PTJQF+vpbu+bneWTlFvXg7YyAxgM4sl1+mYJHmcJ7auo1dIDVuO+alhnPUAKuWsoVbMW
         ObklPVKWBPSY/TgsIuGl8YTNfPJJE4rmwlkxqw8hpJUBc38AHsc+1Fq6kNT1DO7Q3CXL
         SLJQ==
X-Gm-Message-State: AOJu0Yybn2G1CWTzSmbw0F3ikTapWUI6f1XFpwQWXcN14Z1yHA3NAm04
        cKJbOYO4FcJxslyZjOqNPJmjyrl2TIC8F1BA+A==
X-Google-Smtp-Source: AGHT+IE1/X4F1Yk+tRoqMPP9Haa1n3PJ07MR3kpFeBGZzmnffVq2tD3CUhozUrVMYK5V87wxO6y48G0lb4qDGmHELg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:690c:3305:b0:589:6c60:f4a0 with
 SMTP id fj5-20020a05690c330500b005896c60f4a0mr5357ywb.0.1692050342656; Mon,
 14 Aug 2023 14:59:02 -0700 (PDT)
Date:   Mon, 14 Aug 2023 21:58:56 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJ+j2mQC/x3MQQqDMBBA0avIrDuQaGzEqxQXMhl1NknJtEGQ3
 L2pmw9v8y9QzsIKc3dB5iIqKTbYRwd0rHFnlNAMvekHM1mHJUlATd/4LyGlwKSYP+PTewwbGWf Jrn5w0BbvzJuc9/611PoDJW/zKm4AAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692050341; l=1438;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=/Kma0m/HdBNmCqOnMR7lPlA92je11aTwe8n3sswA/Rg=; b=xBHhDi4mcSlr1sHc0h4GlY4u8BBIj//mhzcKVjxHypIVM0sC61W4jIj4vp5C/DbjnfiDIyQ2c
 qFxpM+2gSL2BA2Du0iN4R9xa1TP1Ic5PCsa3aKdJslzaDOv6ZXIa91G
X-Mailer: b4 0.12.3
Message-ID: <20230814-void-sound-soc-codecs-rt5677-v1-1-5c468c60fa37@google.com>
Subject: [PATCH] ASoC: rt5677: fix -Wvoid-pointer-to-enum-cast warning
From:   Justin Stitt <justinstitt@google.com>
To:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`match_id->data` is a void* and as such is being truncated when cast to
`enum rt5677_type` which is only int-width.

There is likely no data loss occurring, though, as `enum rt5677_type`
consists of only two fields from 0 to 1 wherein obviously no data loss
happens from pointer-width -> int-width.

Link: https://github.com/ClangBuiltLinux/linux/issues/1910
Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: I'm not sure if `uintptr_t` is the correct solution here as I've
also seen a cast to `unsigned long` suffice. Any thoughts on the
semantically correct option?
---
 sound/soc/codecs/rt5677.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index ad14d18860fc..278cb0b265e5 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -5578,7 +5578,7 @@ static int rt5677_i2c_probe(struct i2c_client *i2c)
 
 		match_id = of_match_device(rt5677_of_match, &i2c->dev);
 		if (match_id)
-			rt5677->type = (enum rt5677_type)match_id->data;
+			rt5677->type = (uintptr_t)match_id->data;
 	} else if (ACPI_HANDLE(&i2c->dev)) {
 		const struct acpi_device_id *acpi_id;
 

---
base-commit: 2ccdd1b13c591d306f0401d98dedc4bdcd02b421
change-id: 20230814-void-sound-soc-codecs-rt5677-dfc041c1a734

Best regards,
--
Justin Stitt <justinstitt@google.com>

