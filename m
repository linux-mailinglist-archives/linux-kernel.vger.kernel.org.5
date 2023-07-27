Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2940A765FDE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 00:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbjG0WqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 18:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjG0WqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 18:46:16 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58881BC3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 15:46:15 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-57320c10635so14862037b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 15:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690497975; x=1691102775;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+xSxR3hp/I+0TJm3Gw1q3yDgLZR8du1mEjkS4CS9C3Y=;
        b=3p4mB6hS4bB4DjFvuA8AjBwm5q5y+9Rzo3bKtgHjsDBsRvfkB/zxRokoM6g5pNE/r/
         ZnvKnqADVXicY1zIdf1mIprFzlLZImIXH/CI0gtSf2ESS1Z/gZYWL+ArRYrb1YIZUMSD
         mqlsU25BuAOrvimQaJpZ08nOy4tHf6aQQSFHSU/YU6HpRljTxIg5nDzc51mMJc3On4pJ
         64Vx2T9bnQutSKVxTtf0+xyW6SO/QUumDNILCURJWyNR1tewKdbLlTqGU9Cju7temypD
         L90tLrBo5GwqkwwwM0PC2+/H8f8qPtaM/j9HpULrmpfBJfIF9O2PBwZxWbEpTb/MOFCA
         2aXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690497975; x=1691102775;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+xSxR3hp/I+0TJm3Gw1q3yDgLZR8du1mEjkS4CS9C3Y=;
        b=ioLq1RxQOf2HuZ7NRE9ynIoPx5P+iU9jNO0x9EjTsFcqgqM7ogzEMM5pPyEWVo9bVr
         BLPZGa9AANP3ZC2jZ7FgWAOjNfS0HOXvcDTpjaqQvbBFRWQB/Y1yXy2z7GcA1pe3I0Kx
         IUkqFsxulhQWb/VEhJ/qfC9tzXWz+7TCgWQ28jAjwD5bVAOsuFxmZ4O/Zgr01R7yWEgA
         BuQ9rR1c8gOw5UGKUbhmrZCCKVM0L465u1fdQKQl02Y1AuOuD0rUhpOBZvdPDqpLVBxg
         n0lnMOSwX4erQ5ifL0CpUlu3HPGJ50MSfybNSnrKywID8pYJriAD2E8xSuIKOGgPPTVI
         otDg==
X-Gm-Message-State: ABy/qLYh6c5mUFmAxfXi1S5A/xLmaBIt6geUv1KEzlDnRrQtPXtqNhdt
        LHlwdv9Qj4cf6jZfhonvxVfbwbfolblUcPByZA==
X-Google-Smtp-Source: APBJJlFtIfNRWhxKI9ReVlZVrIdSJVbc68FHmf1QrwaTAqeS7qwdelvTuwenzmSR6B4vHHVO4ceb+3rUp6w8zZjxvA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:c58a:0:b0:d07:9d79:881c with SMTP
 id v132-20020a25c58a000000b00d079d79881cmr4ybe.11.1690497974749; Thu, 27 Jul
 2023 15:46:14 -0700 (PDT)
Date:   Thu, 27 Jul 2023 22:46:13 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIALTzwmQC/x2MywqAIBAAfyX2nGD2kPqV6GDrVnvRcCkC6d+TL
 gNzmMkglJgEpipDopuFYyjS1BXg4cJOin1xMNq02hqrJF7BF6LC6AlFjZ3dcB37dnAWSnYm2vj 5l/Pyvh9K+aHLYgAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690497974; l=2418;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=bZgCYDFF558H9+uGABOoX1/6Falrihq1b+s55TkP1Rc=; b=RXhH5b4I6Sx8dSLpV7dWRHWahWzUnLIfmT5bv+HNz20DE0PdQ7UaHD8k8TSZLqjCeBJjEBK26
 QNpKX4HQNG5ANdl4Q781Tn39kh8DTU+nTEgSo6JdYZ3svnd/iWTQW6q
X-Mailer: b4 0.12.3
Message-ID: <20230727-sound-soc-codecs-v1-1-562fa2836bf4@google.com>
Subject: [PATCH] ASoC: 88pm860x: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
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

In this case, though, there was care taken to ensure that the
destination buffer would be NUL-terminated. The destination buffer is
zero-initialized and each `pm860x->name[i]` has a size of
`MAX_NAME_LENGTH + 1`. This means that there is unlikely to be a bug
here.

However, in an attempt to eliminate the usage of the `strncpy` API as
well as disambiguate implementations, replacements such as: `strscpy`,
`strscpy_pad`, `strtomem` and `strtomem_pad` should be preferred.

We are able to eliminate the need for `len + 1` since `strscpy`
guarantees NUL-termination for its destination buffer as per its
implementation [3]:

|       /* Hit buffer length without finding a NUL; force NUL-termination. */
|       if (res)
| 	        dest[res-1] = '\0';

[1]: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings
[2]: manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html
[3]: https://elixir.bootlin.com/linux/v6.3/source/lib/string.c#L183

Link: https://github.com/KSPP/linux/issues/90
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 sound/soc/codecs/88pm860x-codec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/88pm860x-codec.c b/sound/soc/codecs/88pm860x-codec.c
index 3574c68e0dda..d99b674d574b 100644
--- a/sound/soc/codecs/88pm860x-codec.c
+++ b/sound/soc/codecs/88pm860x-codec.c
@@ -143,7 +143,7 @@ struct pm860x_priv {
 	struct pm860x_det	det;
 
 	int			irq[4];
-	unsigned char		name[4][MAX_NAME_LEN+1];
+	unsigned char		name[4][MAX_NAME_LEN];
 };
 
 /* -9450dB to 0dB in 150dB steps ( mute instead of -9450dB) */
@@ -1373,7 +1373,7 @@ static int pm860x_codec_probe(struct platform_device *pdev)
 			return -EINVAL;
 		}
 		pm860x->irq[i] = res->start + chip->irq_base;
-		strncpy(pm860x->name[i], res->name, MAX_NAME_LEN);
+		strscpy(pm860x->name[i], res->name, MAX_NAME_LEN);
 	}
 
 	ret = devm_snd_soc_register_component(&pdev->dev,

---
base-commit: 57012c57536f8814dec92e74197ee96c3498d24e
change-id: 20230727-sound-soc-codecs-947fcb9536a7

Best regards,
--
Justin Stitt <justinstitt@google.com>

