Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E3F787F76
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 08:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239438AbjHYF67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 01:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239385AbjHYF63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 01:58:29 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558B219B5;
        Thu, 24 Aug 2023 22:58:26 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99bcfe28909so59071466b.3;
        Thu, 24 Aug 2023 22:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692943105; x=1693547905;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IJG8goSXk3zwWZ19FJPr0WxT/uyTahaaLMr2MHUcYLA=;
        b=GNWYmUiuTytI+dVDFGnG7EG3wZqzZqbSLOqOqQ3+M7fas1jK/dQcmKOVwJVl+TA9vS
         C0GpP5+io7Di8GvFK2C1VsQF8MYgkI6VxmRasZBP4RRXkvLHQ236CF1xusNX9owrOOsG
         MoWMEHwrhlKotucXNIzltl3TJYvDwwG9vKshqMXCZ8FQI8x6koilEZqG6V4fcUgy8jWS
         +jmBk9DgG1RO2YJ4ZGD/Xvmmg+8HWFwRc6Xiqu08POhJe9b//KXUwrsqfupx028mUgpd
         2QbKNLI0FfpJRYD0bif239CmKXO4QlN1RSiQvojLc/H02cFMB9LWHnXv5h82tfp5Tb3T
         YthA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692943105; x=1693547905;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IJG8goSXk3zwWZ19FJPr0WxT/uyTahaaLMr2MHUcYLA=;
        b=GNHIhSIpvDxNLpbtn/s5tWHZVqGal7vfaSWom+VajUzkpX58jEoehJI21VGjbVFVUq
         0ifInUDbcA0KpYE4xhIr/4KMkQ+CbpPDo/sFZ749hQ6ZJ1ei/jkHkROSQwSEaDrRj721
         LWPxx1DRwn2Mr8D9wXNwL4Ia6JKpxQkRzKFCUJGGZPToHhenZ2wx5DJwHRtAcpOSm4tQ
         64agdcmi89fDe5dvUhps2Y4FFMcYBWJrz+NYtM9JZL110dAXmyOUgn9Em6no8gVGpb86
         Mx8/LMIUBxXw8tUoznk5rMWikPmKGS9yccraL6ylb+O6FniF+d1ZPxKG/f2g+Gn/b8SD
         vfXw==
X-Gm-Message-State: AOJu0YxkVTV2uGuXqoPwaUbErOsasH7Yo9yoZav635B9CDy0LBISSrML
        2ful/mGCsAheSCurVkOMwew=
X-Google-Smtp-Source: AGHT+IF9kWnJZdSru5yBZvRTrZ/LkXpY1drHf+dQXac0YH3cB4rwp3hFRPP5zVnGqhA1fMZuHoiU0Q==
X-Received: by 2002:a17:906:1ba9:b0:9a1:680e:8c54 with SMTP id r9-20020a1709061ba900b009a1680e8c54mr13090737ejg.71.1692943104488;
        Thu, 24 Aug 2023 22:58:24 -0700 (PDT)
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:98c5:e120:ff1e:7709])
        by smtp.gmail.com with ESMTPSA id re4-20020a170906d8c400b009930042510csm546959ejb.222.2023.08.24.22.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 22:58:23 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Lee Jones <lee@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: adjust file patterns in TQ SYSTEMS BOARD & DRIVER SUPPORT
Date:   Fri, 25 Aug 2023 07:58:21 +0200
Message-Id: <20230825055821.30508-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 77da3f22b3d5 ("MAINTAINERS: Add entry for TQ-Systems device trees
and drivers") adds some file patterns for files in arch/arm/boot/dts/, but
those patterns do not match any files in the repository. Hence,
./scripts/get_maintainer.pl --self-test=patterns complains about broken
references. The files of interest are actually in the directory
arch/arm/boot/dts/nxp/imx/.

Adjust the file patterns to match the intended files.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Lee, please pick this minor clean-up patch.

 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 52277ee9c1b8..f5d4058b7ff4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21817,9 +21817,9 @@ TQ SYSTEMS BOARD & DRIVER SUPPORT
 L:	linux@ew.tq-group.com
 S:	Supported
 W:	https://www.tq-group.com/en/products/tq-embedded/
-F:	arch/arm/boot/dts/imx*mba*.dts*
-F:	arch/arm/boot/dts/imx*tqma*.dts*
-F:	arch/arm/boot/dts/mba*.dtsi
+F:	arch/arm/boot/dts/nxp/imx/imx*mba*.dts*
+F:	arch/arm/boot/dts/nxp/imx/imx*tqma*.dts*
+F:	arch/arm/boot/dts/nxp/imx/mba*.dtsi
 F:	arch/arm64/boot/dts/freescale/imx*mba*.dts*
 F:	arch/arm64/boot/dts/freescale/imx*tqma*.dts*
 F:	arch/arm64/boot/dts/freescale/mba*.dtsi
-- 
2.17.1

