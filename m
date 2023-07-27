Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1A6765F66
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 00:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbjG0W06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 18:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbjG0W0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 18:26:54 -0400
Received: from mail-oa1-x49.google.com (mail-oa1-x49.google.com [IPv6:2001:4860:4864:20::49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331A0F0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 15:26:53 -0700 (PDT)
Received: by mail-oa1-x49.google.com with SMTP id 586e51a60fabf-1bb91fb58f2so2681977fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 15:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690496812; x=1691101612;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y8k3rjyBf0fojb2EPgR8sOqghPhE9G594McR+LDMAVU=;
        b=D8uvkEu4/smEbpJTeMq90Bq5KeP1e5xIGLkQWzLEkXeN8AQU0NkbUy0zuQd+TUDBSx
         k3+CzER9oXoVsUCZvuh9ZIN4VObo+hEN4Z+y+rd2eVuE4GcNw/Ge5AGR5mdVOQA76bwG
         RNF1S8VERGMdefiESkMUi5anwpf8ky6b04huvSD7HuzDBWA7L1zc9uqa9vXivFgWWNuz
         Iho8dePREXhDWuWuG/4dhsZjV+1VOiSIAAkrXITi6ge7gaLlbxA3VbqTOo3LaknExZlo
         ubzzY+BjDM4VT64nFYkLUAMdC3XqpY8qwN3NTMwuL/P/ctD0iXxag6tLvhN2RzQTBur3
         Dk+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690496812; x=1691101612;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y8k3rjyBf0fojb2EPgR8sOqghPhE9G594McR+LDMAVU=;
        b=ewucLlnjTv1uwSdV9YZXHHbDIOo1OOEMvsHmuy2O3uMlX8M2JoteU7Qj/2lEE2TsE1
         dRUe8CSYKoNTfa+WvpNdOZN3E0Q0+WMJVXfh5+iTsMcnFgsc4aUf3P1xiG6n86lU2kmE
         1sBHCoBhQjdXyl6EQIz4oSV0i2x12xE3tj1nUTbluwjfp0qEmcwirETMt/yo8HZyrSVT
         ggijOnNheflkB0KOWaP7HHXZmx3o+sImAxkjtqpWYaPOsuyRAcXEL9VEDeh6gn6IfIg6
         sjKbUbMiQukXogAzZJLbnn/T7wvHFJW7Z7CHYxUkfVEtpaYM1oql5ZjZDWth+/IaOiHY
         XPCw==
X-Gm-Message-State: ABy/qLZl9hBoEw8DP/BvkNpqzYQNH97ktoTEIHgNH5lGPLO+YEK7F/cT
        ewKQOR0E+e2oGX1wTS9wMjvPBUYvAt1ewFLrPQ==
X-Google-Smtp-Source: APBJJlEBTUBehPEZg2R3Xd62gIsjVc6xsHEJaqFFsRtVLEpia0yBfJf6qBbvR8t5/rEX6B3ZnlKWSdJI2cgI6ejYLQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6870:5b0d:b0:1bb:785d:7436 with
 SMTP id ds13-20020a0568705b0d00b001bb785d7436mr961489oab.10.1690496812558;
 Thu, 27 Jul 2023 15:26:52 -0700 (PDT)
Date:   Thu, 27 Jul 2023 22:26:41 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIACDvwmQC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDcyNz3eL80rwUIJmsm1aco2uSlmxqamaZYm5umKoE1FNQlJqWWQE2Lzq 2thYAMKv4Nl8AAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690496811; l=2165;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=xEnu5xQr3cyZZvwQfMubiCiEuFBVC3Uk0Y9589JdUxw=; b=hmOqBlRYlYKaC3Yr5Zy8g3r9+9++L/pbK5ub/HORCIbyUCI0NGjnrADamWXFeaNB3CVKyg4I+
 L5n1tag1LikDFx+k0EHDanF323xxdNABjjW0T5SEFnG7vM0e2joX6sH
X-Mailer: b4 0.12.3
Message-ID: <20230727-sound-soc-fsl-v1-1-4fc0ed7e0366@google.com>
Subject: [PATCH] ASoC: fsl_micfil: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
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
_not_ always the case for `strncpy`!

In this case, though, there was great care taken to ensure that the
destination buffer would be NUL-terminated through the use of `len - 1`
ensuring that the previously zero-initialized buffer would not overwrite
the last NUL byte. This means that there's no bug here.

However, `strscpy` will add a mandatory NUL byte to the destination
buffer as promised by the following `strscpy` implementation [3]:
|       /* Hit buffer length without finding a NUL; force NUL-termination. */
|       if (res)
|               dest[res-1] = '\0';

This means we can lose the `- 1` which clears up whats happening here.
All the while, we get one step closer to eliminating the ambiguous
`strncpy` api in favor of its less ambiguous replacement like `strscpy`,
`strscpy_pad`, `strtomem` and `strtomem_pad` amongst others.

[1]: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings
[2]: manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html
[3]: https://elixir.bootlin.com/linux/v6.3/source/lib/string.c#L183

Link: https://github.com/KSPP/linux/issues/90
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 sound/soc/fsl/fsl_micfil.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
index 3f08082a55be..fe28b27e50d0 100644
--- a/sound/soc/fsl/fsl_micfil.c
+++ b/sound/soc/fsl/fsl_micfil.c
@@ -1044,7 +1044,7 @@ static int fsl_micfil_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	micfil->pdev = pdev;
-	strncpy(micfil->name, np->name, sizeof(micfil->name) - 1);
+	strscpy(micfil->name, np->name, sizeof(micfil->name));
 
 	micfil->soc = of_device_get_match_data(&pdev->dev);
 

---
base-commit: 57012c57536f8814dec92e74197ee96c3498d24e
change-id: 20230727-sound-soc-fsl-4fc5569d771e

Best regards,
--
Justin Stitt <justinstitt@google.com>

