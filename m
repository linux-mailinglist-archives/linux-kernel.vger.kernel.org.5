Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B2B7625B6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 00:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbjGYWKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 18:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbjGYWKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 18:10:34 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DE52D49
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 15:09:45 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d0fff3cf2d7so3109494276.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 15:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690322919; x=1690927719;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1NWycEa65d4tlLHM/aUQNHUmkrnQ5gy649oFMAUFu0Y=;
        b=dkaLXO5P2GjZV3Ivpr8AVQ5wnqf+jGDLus6d6dyP8ArE5rnUAOpRGwjui3dRb3PCUX
         e3bWR+NAZSN5SrrVNyE5yE75yEn3IlvPUCvzHTwJN5GUsiOrZ7jChwaI01ZVTnI4cAt8
         jmjnAjkWEVrVph3PE4uht2TMudR5AdEnfhr7IwmTePO4NUD7iJac5IhceMZiFgnEDCTY
         6f+xzQ/U1rl1cUVr7mhlAFoe14B+n2Qqq4LMb+EVJwPg+gn1ji0bCxWWSg02ARBAvbnd
         36ACm3Z1kOHqz0G3ttgRlAkDBOtTVjCyWWWOHn/HBL6pnRKCtEH9iX8gYJZT2KhCItSH
         ndzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690322919; x=1690927719;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1NWycEa65d4tlLHM/aUQNHUmkrnQ5gy649oFMAUFu0Y=;
        b=FFX7jULldUuUOMlFocWmdWwivUntV8MVw9gt3MjcweQ8BrKL73BPdWcePGqNqYwrCe
         jGskN+kO3wuKNSegQpC8Y6oNX46ooY/YGFFNulcReLB4IzJci5JDeDJhgSdRs/Od9cw+
         HXGroo4yBG7qPPF1HOhlrWILzG/WWY+DglvVo1287A+5Pz27/D/bhfz5LkncOV0tWuwu
         X57ekl+NPsDnGzxQcp1eO7iH5m1+Tye6OaEoTfMg39E7/qenTWvAaeliQPb1YHF4Q5yf
         lcRzluhZYeS/F2pkVqXUG7ELkF7BL5u2Qz3QiC45646CAk8jf+5JCbDKyPBfvLlWBykL
         2w6A==
X-Gm-Message-State: ABy/qLZBcJb3VhFcwWBmUOdhwZSZpw7pFsvfit03DB1Nm1WN8dHFZU6W
        Nio3wf3awaoAxbfTuNH03oo/cDv0DBzKB4KsTA==
X-Google-Smtp-Source: APBJJlENtGndeMK75xsqbP+rObTFZUl8GefO08l5IcCtgMR26J0r2rSOjJAMnNmTOUoRnsSrpVgw4Y3QHRWFE05m4w==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:69c8:0:b0:d0c:e37:b749 with SMTP
 id e191-20020a2569c8000000b00d0c0e37b749mr1345ybc.10.1690322919734; Tue, 25
 Jul 2023 15:08:39 -0700 (PDT)
Date:   Tue, 25 Jul 2023 22:08:38 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAOVHwGQC/x2NwQrCMBBEf6Xs2YUmGhR/RTzEzVYXNCmbGCyl/
 97Fy8BjHjMrVFbhCtdhBeUuVUo2cIcB6BXzk1GSMfjRH8ezD1jLNydLQsmN3xh7ReVP6YyJZ2W Kja1vmmle0D/o5GKIYbo4sE0TJvn9/273bdsB0LrmxH8AAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690322918; l=1683;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=PhUj2cXtcqtjhYpon1W91iiAfF7M/UqU4Wb0CfeBYMk=; b=hwCrKKl4MBwnYeKbpJ7VXwZ58MxHlq/hUWRmyIcm4i/2grmqWc8hNmK+AMZ6GxlAJ+aUw6C6Z
 JLfTXt31O93DIg9K4aTcdVaMMNARadNBYo+WiR96LLszjj0XJbcnpNH
X-Mailer: b4 0.12.3
Message-ID: <20230725-sound-soc-intel-avs-remove-deprecated-strncpy-v1-1-6357a1f8e9cf@google.com>
Subject: [PATCH] ASoC: intel: avs: refactor strncpy usage in topology
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
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
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

`strncpy` is deprecated for use on NUL-terminated destination strings
[1].

A suitable replacement is `strscpy` [2].

There are some hopes that someday the `strncpy` api could be ripped out
due to the vast number of suitable replacements (strscpy, strscpy_pad,
strtomem, strtomem_pad, strlcpy) [1].

[1]: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings
[2]: manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html

---


Link: https://github.com/KSPP/linux/issues/90
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 sound/soc/intel/avs/topology.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/avs/topology.c b/sound/soc/intel/avs/topology.c
index cdb4ec500261..45d0eb2a8e71 100644
--- a/sound/soc/intel/avs/topology.c
+++ b/sound/soc/intel/avs/topology.c
@@ -1388,12 +1388,12 @@ static int avs_route_load(struct snd_soc_component *comp, int index,
 		port = __ffs(mach->mach_params.i2s_link_mask);
 
 		snprintf(buf, len, route->source, port);
-		strncpy((char *)route->source, buf, len);
+		strscpy((char *)route->source, buf, len);
 		snprintf(buf, len, route->sink, port);
-		strncpy((char *)route->sink, buf, len);
+		strscpy((char *)route->sink, buf, len);
 		if (route->control) {
 			snprintf(buf, len, route->control, port);
-			strncpy((char *)route->control, buf, len);
+			strscpy((char *)route->control, buf, len);
 		}
 	}
 

---
base-commit: 0b4a9fdc9317440a71d4d4c264a5650bf4a90f3c
change-id: 20230725-sound-soc-intel-avs-remove-deprecated-strncpy-2bc41a5a5f81

Best regards,
-- 
Justin Stitt <justinstitt@google.com>

