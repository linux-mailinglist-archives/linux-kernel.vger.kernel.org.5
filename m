Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F816765D61
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 22:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjG0UbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 16:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbjG0UbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 16:31:05 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D68271C
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 13:30:55 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d087ffcc43cso1308475276.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 13:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690489854; x=1691094654;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lEKw26+6RZdhI/anFRn58wCKq7xAbjFEyn0dAkNnpG0=;
        b=JQC4MlN38CgOxQdZXvHWUw5mbVGP5ZPWx3/5G8h/aF0HPkdXFJcNXoEoXMLjnMoF+x
         4Hu7uggmX2FpspBq6lxF6wv2JjPXaPL+uGbaW+Nd7y8gpo8X88P8w29kKuvtOUw19yXA
         zphnSGDV8E05vxXMRCAAt9K2cv2wVtwHz4LUJ5smBonEAlaEnG7uioYbPbvxaUBOgFyn
         f9D0nZZnJcuVdYQjNi024aRj9xHd9AEX9poOXq/xImJab3PtyMVu7Znmvks/rO0yWHkY
         cFEs01yQ6Z2Gh4IzSHsnInDvM54A6RIJuGDOnwXLr9ngP2bmUs2Orsu+Gx7Slb7I84Di
         fGSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690489854; x=1691094654;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lEKw26+6RZdhI/anFRn58wCKq7xAbjFEyn0dAkNnpG0=;
        b=RyT5AgVcCbbk6ikitpUFLdJgkeokjrBIFBna2UeK2F/BfRtOwjGp2rqJQryv4l5RWt
         eX5PRZleQ2zKGyEq8ZFc0e5noeyDcQlWf95jgH98Cx6HfFK+T0vGjuDV5dKxfpZ/4uq8
         4EluRD3szN+xLqZCdfD0hbv2uXUVrDuGCISNQ2y8uLy2ruOqQLPjuP8rk4WIyM3fzD7I
         AP2dOZ6/OS+5idhMbZyGseJWtEx1HgT2uYPZDqNj+4HRRieqZTOR5Fsitdxd7YOBYctH
         t7zLvZ41Neg8FlPx0b3TpDlbvADDnkifNtemku55u/sjBGIX8FhQYwgXqumkuSsTr5nQ
         Tw6A==
X-Gm-Message-State: ABy/qLbsYxW5kcUL+smRUWQG8R42U9R+T1nemWJaZSJwgS0Ym20H32fN
        zmkYy2s9U2zcTF4KyvbFX9iiGuRNUdQ6elniog==
X-Google-Smtp-Source: APBJJlGl9kr0YKjXXClaNvO5YXYK+bsI4pnNFzpD0RmmC23yYTH1+wRPxm/hihZJnIhi6nmd3x0pGnlwMsmYe8YXBg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:c0cd:0:b0:d0f:dec4:87a0 with SMTP
 id c196-20020a25c0cd000000b00d0fdec487a0mr2722ybf.2.1690489854578; Thu, 27
 Jul 2023 13:30:54 -0700 (PDT)
Date:   Thu, 27 Jul 2023 20:30:18 +0000
In-Reply-To: <20230726-asoc-intel-skylake-remove-deprecated-strncpy-v1-1-020e04184c7d@google.com>
Mime-Version: 1.0
References: <20230726-asoc-intel-skylake-remove-deprecated-strncpy-v1-1-020e04184c7d@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690489451; l=2099;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=ekRYz8xbmy5B35whJHZOKa2NN55Pqt6uzdTr4Owj6tU=; b=ZHerNq4/0/izYJjYC4OPRwRQsf1JjGaWzyKG1n6tatiOox8osMHj5IC5H3w7pomkovsRZW+Mr
 ZalieCCjJkOBFVxsodA8i2CfMpi8W7SOSDjFdBjxoR32Os1IBvPaV8a
X-Mailer: b4 0.12.3
Message-ID: <20230727-asoc-intel-skylake-remove-deprecated-strncpy-v2-1-152830093921@google.com>
Subject: [PATCH v2] ASoC: Intel: Skylake: replace deprecated strncpy with strscpy
From:   Justin Stitt <justinstitt@google.com>
To:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Justin Stitt <justinstitt@google.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

A suitable replacement is `strscpy` [2] due to the fact that it
guarantees NUL-termination on its destination buffer argument which is
_not_ the case for `strncpy`!

It was pretty difficult, in this case, to try and figure out whether or
not the destination buffer was zero-initialized. If it is and this
behavior is relied on then perhaps `strscpy_pad` is the preferred
option here.

Kees was able to help me out and identify the following code snippet
which seems to show that the destination buffer is zero-initialized.

|       skl = devm_kzalloc(&pci->dev, sizeof(*skl), GFP_KERNEL);

With this information, I opted for `strscpy` since padding is seemingly
not required.

[1]: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings
[2]: manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html

Link: https://github.com/KSPP/linux/issues/90
Suggested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- Remove extraneous logic change (thanks Kees)
- Link to v1: https://lore.kernel.org/r/20230726-asoc-intel-skylake-remove-deprecated-strncpy-v1-1-020e04184c7d@google.com
---
 sound/soc/intel/skylake/skl-topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 96cfebded072..0ead3ea605cd 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -3159,7 +3159,7 @@ static int skl_tplg_fill_str_mfest_tkn(struct device *dev,
 			return -EINVAL;
 		}
 
-		strncpy(skl->lib_info[ref_count].name,
+		strscpy(skl->lib_info[ref_count].name,
 			str_elem->string,
 			ARRAY_SIZE(skl->lib_info[ref_count].name));
 		ref_count++;

---
base-commit: 0b4a9fdc9317440a71d4d4c264a5650bf4a90f3c
change-id: 20230726-asoc-intel-skylake-remove-deprecated-strncpy-9dbcfc26040c

Best regards,
--
Justin Stitt <justinstitt@google.com>

