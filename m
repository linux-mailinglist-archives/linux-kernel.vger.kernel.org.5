Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66177640FA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 23:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjGZVMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 17:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjGZVMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 17:12:20 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE691BE8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 14:12:19 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c6dd0e46a52so184301276.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 14:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690405939; x=1691010739;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rZM5DChdNI8S3fRaG82Uf+jm5x9WWsFq+xNzYHKGX4I=;
        b=TFvfXD2jpjpWq8sY4RDHzUNEf2ymN+fSetV8uTMDOQ+efdSDZm9AVu17Ww7vnobhgB
         ipCdmG9oLkCSmc/Ewxmh9qpvD8J5WxmQPeRTIimCFCbthp+v2w4LMNk9MqelA3mbqiTx
         b6yNHsrXMJYrky0IG18TgFNI2T0u0kk++fomF7W7zJ1tSMZaclcN9/xsXE1jSPnWxbIt
         SD8OnfWzUGmqz8Li/3PhJb77U/8kU8ZqMf4watsGPkU4z89D+rJiwf62psgJ7kJGdK8l
         Jy2wFbXod1DCUCD/DJQnR8q+eZ1PFAyayDYnC0l5FzvVGZBLA3+9PgSKC+VLpfHFrThr
         Smow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690405939; x=1691010739;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rZM5DChdNI8S3fRaG82Uf+jm5x9WWsFq+xNzYHKGX4I=;
        b=E99CINyJK3mRro6rzmDf29iavcCNZ15AJZ1xOvXwfxDberf5DpqZc2DwFjzpMPOhVV
         upja0/505usyH0dg+zIBYOVHbFy5L/yG7lbrkYVKmax0JbAADeEoftjEmLG5PVeC0Z0N
         BXp5y0QJ5eDQSivzvxbwQrzTfn3KmMIaRRWuA5mxSna/fqrZU+jtBTqVQcZp4F/sHv0C
         E/7neLMyPQPiO+hkebSaoC5beg09V3e6JdaiiFTMZ0jFSD92sv2DInG8fcCrq0+a3z6a
         4zf5Q0gLCNyaXeBuwO91hKL5Q65lz4VwYw5WGv+UYNWkcokqsJDEKdeAUzBD0+YZJJKu
         jujg==
X-Gm-Message-State: ABy/qLYYJUHLNCOAzG1PyI05EyL+B/BaS8tFN5nNAfuEeOxum8MVS0AH
        qdGpfEWFSoLD19HaMuu9gOwm8Mu7IKQNnBCHAA==
X-Google-Smtp-Source: APBJJlHztluktJg0B0qaDZ70CcY32gizNyhPP2LwGCkpCXg6eyN49WkgyiCmLZ6pxTh3gxGo8YcM18w/ekYxGaaJqw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:fe05:0:b0:d10:c94a:be7e with SMTP
 id k5-20020a25fe05000000b00d10c94abe7emr19783ybe.8.1690405938894; Wed, 26 Jul
 2023 14:12:18 -0700 (PDT)
Date:   Wed, 26 Jul 2023 21:12:18 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIADGMwWQC/52NQQ6DIBBFr2JYdxqgamNXvUfjgg6DEhUMEFJjv
 HupR+jy/fy8t7NIwVJkj2pngbKN1rsC4lIxHJUbCKwuzCSXN36XLajoEaxLNEOctllNBIEWnwk
 0rYFQJdIQU3C4btDpNxqULa85sqIsB2M/Z+7VFx5tTD5sZz2L3/pnKAsQoNuaeI1dYxrzHLwfZ rqiX1h/HMcXwpnJEOkAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690405938; l=2258;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=lQAXd/QKEocVTpWzsLq/yuRWIfGT/6JXnq+xx86jdyo=; b=qfHnDTc0z2fwrsubm0mfrEuvyffKkOeKhwokW9XrOjcVXFcWc7iFlQrcWEH+KOMyhxzifxMK8
 aycPeRwhO0xD3vZ3vBW2pcHncCaCAkivn+JIrWDtsLx0CBm1ilapKZ+
X-Mailer: b4 0.12.3
Message-ID: <20230726-asoc-intel-skylake-remove-deprecated-strncpy-v1-1-020e04184c7d@google.com>
Subject: [PATCH] ASoC: Intel: Skylake: replace deprecated strncpy with strscpy
From:   justinstitt@google.com
To:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
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

Also within this patch is a change to an instance of  `x > y - 1` to `x >= y`
which tends to be more robust and readable. Consider, for instance, if `y` was
somehow `INT_MIN`.

[1]: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings
[2]: manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html

Link: https://github.com/KSPP/linux/issues/90
Suggested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 sound/soc/intel/skylake/skl-topology.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 96cfebded072..67f08ec3a2ea 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -3154,12 +3154,12 @@ static int skl_tplg_fill_str_mfest_tkn(struct device *dev,
 
 	switch (str_elem->token) {
 	case SKL_TKN_STR_LIB_NAME:
-		if (ref_count > skl->lib_count - 1) {
+		if (ref_count >= skl->lib_count) {
 			ref_count = 0;
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

