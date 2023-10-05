Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD82C7B9E5C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjJEOEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbjJEODn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:03:43 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DC1111
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 19:56:28 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c3d6d88231so3664165ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 19:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696474588; x=1697079388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hp2x9Ltp2Ai2cgY/IY4VFvuHeSSiTk0rfcUCP8Bu0Y8=;
        b=ZMX3iS/Cfoxpu9NpYWySr4M2cCHFEyi+/NhhNMTOj1RXslsEV0lvm05U1FWnkhs0Om
         UoExBi1dVfkk/z/hiydBKLiAgR+j2FOVQS0dP2/74CAw1/sUz1tyKgA1uIvWnvTMTjfL
         PK7axzRSb3GcHy17qH35enlVDfcHmq33n1p94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696474588; x=1697079388;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hp2x9Ltp2Ai2cgY/IY4VFvuHeSSiTk0rfcUCP8Bu0Y8=;
        b=h3QQV6GTzKoZLAkKiie1tnORvpysP6nm+utNKAd05VrJGXFOvTvRZCkp13UJk+f/Ka
         aZdd9IGEZ51JahACsEmLB5+wmo3KTdlHRBmYk6bxqc3ItjziM7FoR3/Rdeutgp8IDNLK
         4oa40BPgDxnlmwPDGwC2Hk5pec7D09RafdW3GoAnmERBM+5KjDF3OVRNnFiMbqKODAIi
         8iGphfAseuQZT6K9R2SqJdgiOxsSnOyMkimCC9wmfy3PSF5lCmuRhiEVXETOeblUUjrX
         OzJyxSkdq72iarUbnPjQ/rx80OAiOUmRpMeqrIUPE5k5kwOkRmzcIOM8O6Qj0bTOaAwW
         q7qw==
X-Gm-Message-State: AOJu0YzwkdrGpIHTy5eLKcLc4oTcCNRKNfGrqYpAcC1dVHKlgqkdDwNA
        FLbPCvL0Oyn/jriGGYhC+MWhJw==
X-Google-Smtp-Source: AGHT+IGzKXtlYTyFAyJxsn0YtydWrFVTkiE3rJN/i5QNmjp5IWWgIQNLh8gGPCrwuP4RXGdCsYJ0pg==
X-Received: by 2002:a17:903:22cb:b0:1c4:5e9e:7865 with SMTP id y11-20020a17090322cb00b001c45e9e7865mr4806918plg.0.1696474587984;
        Wed, 04 Oct 2023 19:56:27 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c16-20020a170903235000b001c724732058sm309809plh.235.2023.10.04.19.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 19:56:27 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Include sof headers under ASoC
Date:   Wed,  4 Oct 2023 19:56:21 -0700
Message-Id: <20231005025618.work.355-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=707; i=keescook@chromium.org;
 h=from:subject:message-id; bh=1XKbY9x91B/FZLpCrXeADLgIXY2PtIiBsgGvJMAcMfc=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlHiXVlntw2mnLlbUmA5XbA4LI/lm54Dci8rr+f
 miK/UuUKTqJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZR4l1QAKCRCJcvTf3G3A
 JoqJD/9cFG7TlWh91sULXaqZacvlKmqNwlACQ23Wy+Dh3MD7OKq17VAIMYGV7O89aQa4XhYxMxV
 bCn8CFyQ31P3Bpg59Ogl8BMif+Q0UOm3Apfq6vLTjWEXgQPVaCgizBQ1X+siJfOTkmUEUtTJa7O
 axnf5U5gdmji+VA9Acl+gMTCshPKg5jToXiiU/h2FuY0hHEGzN4ZvnA0H5gPcTXuLzntVivYV3P
 ixCRzL5CWDNSrb4yQPTRFc6rs3S51d91z53paVM16j8pSZb3GqucGUYbLNVL7rPhl/Q2OwalIiR
 XoGHiE19O/Nhpin9OxdfwJsh946IeXEjI/NDvSkqi493Dy09qyeeEtXvVbCxwppbbvSWaMJ40Bo
 Yh/4umb0r42AoTFBK+Q4vVKzSRdvBhpH3WdmYZM4SST7PnF0GZ9DTZY3OUZ30D+8f0yZT2DaK3u
 yTXxXQArLdNsaJAdNy83xH23qGNd3hJYw5DnZUEgqyJ/2ci8GNtLiedY3xsuKWZvRqz7YLU3O+5
 RZ+xMHKAwdrvjL548hOB/TkI7kLT9oZN8mMCIc/YnGWARYHr6SbFPOJEEPiwvDzl26DtKDm/Njs
 hFHiM8ClbPaOaVyLfaQbWue/lLQiFd89+2HPzMsVMIgaVjbKgalO9JcJ3bSU0XoTESDSGXSZSJM
 H17cOqnF yV5FKZQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing sof header files for ASoC.

Suggested-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/lkml/f258a7e6-0728-4f55-a71a-6e99113ce7e5@sirena.org.uk
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 585a13b9b52a..811e59d50291 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20116,7 +20116,9 @@ F:	Documentation/devicetree/bindings/sound/
 F:	Documentation/sound/soc/
 F:	include/dt-bindings/sound/
 F:	include/sound/soc*
+F:	include/sound/sof.h
 F:	include/sound/sof/
+F:	include/trace/events/sof*.h
 F:	include/uapi/sound/asoc.h
 F:	sound/soc/
 
-- 
2.34.1

