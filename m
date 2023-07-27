Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD22765EF6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 00:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbjG0WJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 18:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjG0WJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 18:09:36 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BAD271E
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 15:09:35 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d1ebc896bd7so1345015276.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 15:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690495774; x=1691100574;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=k4cN8fzY539FysYzQlSA0Pbs/oY5p0DEsZqLCjbwVvw=;
        b=1invnO00XPFQo37nw+5PVQYz/KWJmJcQsHrAYLME6DNvlNc8mwD1kaP75zqLZyCgZF
         EEEkkLI1LSoHeQWteR7EOe2n5YElqxQ60OSuBTmyG+546N2uzZ4mfVr4LMfVLAu6vy0f
         Zvpyzfj6BM3ixLl6ryogT4cDvc0yH+covctlWW1es5tDA3xfUAonpRHprfuoYN96PRBh
         mrUUvWenRvbSOMenwKpah0ZQvYQYYy95lKiSvSAc8fkMcwRpdHvRuCspQ5KX/BWNZJ+k
         1Mt3QQyU09iMkwcMRSKXkUeeC1Bj/Ty0/HIY78A1fVqNWVOwA8yVs4HgNONieHi2yl6H
         SOLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690495774; x=1691100574;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k4cN8fzY539FysYzQlSA0Pbs/oY5p0DEsZqLCjbwVvw=;
        b=SPcbluBoLskFDxK1wjf9NjYi83wJsk+n1xWWq5B6dB8lnspe3n2Xh6rv0Ln82mQW+Y
         hh+6yF0A14i3J1aDRilQ0KbfG8GZ1aMl4OGo+VxmogWXLdGQGRK9gkbQeUeotyWzmox+
         CHhOtf8IhbfG8zxWe33GC3D8rlZxGg8WJTi35lHIuGx35ZneJmPCdmE3YjecfESsHGaa
         MW2nKdXSVBh7N88XHX1n6xLeetkUZBzKEyvfPbTyMcn5qkNv0jjOc1jNM19mja3Wsmwb
         99GrYy1fmWI+ElxQ9LIbil5jwtY+IyWq5ucP0KhDPug5MWIhOlJjlprmrXJ0teMEl2SN
         N8cw==
X-Gm-Message-State: ABy/qLZdZaxGtUZeQzQFgc8GSTlOSC73nQkHFZZ37CNjnlSTok11N7Mu
        OKecK4yucOGd3dJ61ZCyrVaA6RJqMPxMpifUvw==
X-Google-Smtp-Source: APBJJlGukc9SZ2I7uyCQYm11/HQDHfMQPVp2DWNDs8mAqGReE456fsavrd53NHvvDfPo0YNTJ/yH8S9Sb7Il8EZ2bg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:abf2:0:b0:d07:f1ed:521a with SMTP
 id v105-20020a25abf2000000b00d07f1ed521amr3818ybi.4.1690495774661; Thu, 27
 Jul 2023 15:09:34 -0700 (PDT)
Date:   Thu, 27 Jul 2023 22:09:29 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIABjrwmQC/x3MQQqEMAxG4atI1gZ+6zCiVxEXrY1jNlUaFEG8u
 2WW3+K9m0yyitFQ3ZTlVNMtFTR1RfPq009YYzE5uBad69i2I0U+LHCYowPAHyC0+ML3S0+l27M sev2f4/Q8L8MihdBjAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690495773; l=2722;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=oD0r9GQJcI4a0oPPFKD+f4eCazsB8WXRECfFQ/3Qn80=; b=RMEEkMB9gj5yDuIGuIqJVfiAW714ytVo21T7+/g2zrDgaM+Trm12x329hvrQ6qpkXQkBKdNp7
 h1YTuOzeph4DYE6Y7PJqPk4FGt00qNiQKla88lXSQoet8fLsPbVG5Uu
X-Mailer: b4 0.12.3
Message-ID: <20230727-sound-usb-bcd2000-v1-1-0dc73684b2f0@google.com>
Subject: [PATCH] ALSA: bcd2000: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
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
`card->driver` or `card->shortname` require this NUL-padding behavior
then `strscpy_pad` should be used. My interpretation, though, is that
the aforementioned fields are just fine as NUL-terminated strings.
Please correct my assumptions if needed and I'll send in a v2.

[1]: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings
[2]: manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html
[3]: https://linux.die.net/man/3/strncpy

Link: https://github.com/KSPP/linux/issues/90
Link: https://lore.kernel.org/r/20230727-sound-xen-v1-1-89dd161351f1@google.com (related ALSA patch)
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 sound/usb/bcd2000/bcd2000.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/usb/bcd2000/bcd2000.c b/sound/usb/bcd2000/bcd2000.c
index 7aec0a95c609..392b4d8e9e76 100644
--- a/sound/usb/bcd2000/bcd2000.c
+++ b/sound/usb/bcd2000/bcd2000.c
@@ -395,8 +395,8 @@ static int bcd2000_probe(struct usb_interface *interface,
 
 	snd_card_set_dev(card, &interface->dev);
 
-	strncpy(card->driver, "snd-bcd2000", sizeof(card->driver));
-	strncpy(card->shortname, "BCD2000", sizeof(card->shortname));
+	strscpy(card->driver, "snd-bcd2000", sizeof(card->driver));
+	strscpy(card->shortname, "BCD2000", sizeof(card->shortname));
 	usb_make_path(bcd2k->dev, usb_path, sizeof(usb_path));
 	snprintf(bcd2k->card->longname, sizeof(bcd2k->card->longname),
 		    "Behringer BCD2000 at %s",

---
base-commit: 57012c57536f8814dec92e74197ee96c3498d24e
change-id: 20230727-sound-usb-bcd2000-400b3060a9f9

Best regards,
--
Justin Stitt <justinstitt@google.com>

