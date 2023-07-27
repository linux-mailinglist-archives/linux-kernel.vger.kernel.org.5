Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0FD765E7F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 23:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbjG0Vyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 17:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232656AbjG0VyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 17:54:11 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F45F423B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 14:53:35 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d13e11bb9ecso1253963276.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 14:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690494814; x=1691099614;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+IrV9GMRSdZPt30c7KcILm3qep9zKx/623+6CGNnSZI=;
        b=YRH0RandNbmWOsNbix1juf2j32ITK9Uvj67kgr3R72979X637zKHH8KZguOPLopzPy
         fjkQbcWwTfMo1Hqb4p+zc/kFemN21RJ6rTyJtcMQ/oEKwjHKIFtmzqeJZgnBmRq/79FF
         Q1T9puk7xzNEdjIV/igXmV4UFIlev2+Onajgaupn8iFIWwD+LDMaU7Rqh6Y/qZ8WNZcQ
         EbYgsmXlOOtwiPgFmIy/5TsvUTsSImKFRVPRiBPAtXKPd4wWKkCURJYYWadAtcEjnXsQ
         ZCgI9IcqtCntKz8lcvSlVTtTRikw2cRxyKs3v6SBQpDYBNM+kCas8jJKyEbxblWbQEXw
         lu9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690494814; x=1691099614;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+IrV9GMRSdZPt30c7KcILm3qep9zKx/623+6CGNnSZI=;
        b=cdMWgx+QPQpHizCjUdM/feE5LXH40ST0zJu0MmvzKMO67DvkYYQuDtWTTyW10K3h7Y
         VHj6IehJoD5m3GFUCIaOxP9JypzeksrSLU/L+cKM8S8ijvp7VJH7sUuPYlhS6RMPvYlY
         VEiEah0l9pQDNEXUyCnV0AWRCOxVLEG+Z8aO0H2OKKnp1BSzztvzx59FDxeLZiuU/6AV
         L/OLGsDmvVAk/iaRyCY2Gh5nD0H/GvlgHwxqWwGon2jEPtehpdjQGc/RLakghFvrUW2S
         LbwyN5j6rxKheMvrOxoDyK1X7y4ngVNQkUZUsmIiZQqpIIZHR7z6ymmZatmLwsKEtoTz
         ZAcg==
X-Gm-Message-State: ABy/qLbyjaZqGvDCTEbdgp6NZzJRQAosd0Y9dEdkUCUWhkoLWFZE/wR+
        ArYRdVKpSmbXZQwX7TF/Bgo2Hfn/cmvcFxZF/w==
X-Google-Smtp-Source: APBJJlHXF3DAQ7oQ2+0tdvzkYP1VoY7GsOUMjOE+/Vdzmdw/tfkvYZ+dZ1a3XDRmAV0OnKJAbEafFAFp/DwKM5StMA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:ab13:0:b0:cfe:74cf:e61a with SMTP
 id u19-20020a25ab13000000b00cfe74cfe61amr4397ybi.6.1690494813865; Thu, 27 Jul
 2023 14:53:33 -0700 (PDT)
Date:   Thu, 27 Jul 2023 21:53:24 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAFPnwmQC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDcyNz3eL80rwU3YrUPF1jS4tkS0sj8yTjFAsloPqCotS0zAqwWdGxtbU AfC3LdVsAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690494812; l=3106;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=2DV18A5LAIbHOz8+4mF5Dz/H6ijYF+f0DqJHiw+O6Z8=; b=vopO06Wm0zYSnDpTC9r5I+EsMsCZYRVtZWxLb5Dfivdpz4dFnQc4/MROOoOi/9uBOTysUrbZO
 B8mJVXUSQDcCy59jXa+eGsPlPBt2oonSrkqDfkKPfBHRnmLmfyW1zgm
X-Mailer: b4 0.12.3
Message-ID: <20230727-sound-xen-v1-1-89dd161351f1@google.com>
Subject: [PATCH] ALSA: xen-front: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     xen-devel@lists.xenproject.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

A suitable replacement is `strscpy` [2] due to the fact that it
guarantees NUL-termination on its destination buffer argument which is
_not_ always the case for `strncpy`!

It should be noted that, in this case, the destination buffer has a
length strictly greater than the source string. Moreover, the source
string is NUL-terminated (and so is the destination) which means there
was no real bug happening here. Nonetheless, this patch would get us one
step closer to eliminating the `strncpy` API in the kernel, as its use
is too ambiguous. We need to favor less ambiguous replacements such as:
strscpy, strscpy_pad, strtomem and strtomem_pad (amongst others).

Technically, my patch yields subtly different behavior. The original
implementation with `strncpy` would fill the entire destination buffer
with null bytes [3] while `strscpy` will leave the junk, uninitialized
bytes trailing after the _mandatory_ NUL-termination. So, if somehow
`pcm->name` or `card->driver/shortname/longname` require this
NUL-padding behavior then `strscpy_pad` should be used. My
interpretation, though, is that the aforementioned fields are just fine
as NUL-terminated strings. Please correct my assumptions if needed and
I'll send in a v2.

[1]: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings
[2]: manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html
[3]: https://linux.die.net/man/3/strncpy

Link: https://github.com/KSPP/linux/issues/90
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 sound/xen/xen_snd_front_alsa.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/xen/xen_snd_front_alsa.c b/sound/xen/xen_snd_front_alsa.c
index db917453a473..7a3dfce97c15 100644
--- a/sound/xen/xen_snd_front_alsa.c
+++ b/sound/xen/xen_snd_front_alsa.c
@@ -783,7 +783,7 @@ static int new_pcm_instance(struct xen_snd_front_card_info *card_info,
 	pcm->info_flags = 0;
 	/* we want to handle all PCM operations in non-atomic context */
 	pcm->nonatomic = true;
-	strncpy(pcm->name, "Virtual card PCM", sizeof(pcm->name));
+	strscpy(pcm->name, "Virtual card PCM", sizeof(pcm->name));
 
 	if (instance_cfg->num_streams_pb)
 		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK,
@@ -835,9 +835,9 @@ int xen_snd_front_alsa_init(struct xen_snd_front_info *front_info)
 			goto fail;
 	}
 
-	strncpy(card->driver, XENSND_DRIVER_NAME, sizeof(card->driver));
-	strncpy(card->shortname, cfg->name_short, sizeof(card->shortname));
-	strncpy(card->longname, cfg->name_long, sizeof(card->longname));
+	strscpy(card->driver, XENSND_DRIVER_NAME, sizeof(card->driver));
+	strscpy(card->shortname, cfg->name_short, sizeof(card->shortname));
+	strscpy(card->longname, cfg->name_long, sizeof(card->longname));
 
 	ret = snd_card_register(card);
 	if (ret < 0)

---
base-commit: 57012c57536f8814dec92e74197ee96c3498d24e
change-id: 20230727-sound-xen-398c9927b3d8

Best regards,
--
Justin Stitt <justinstitt@google.com>

