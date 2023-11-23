Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8810B7F5DE0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 12:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345068AbjKWLcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 06:32:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345034AbjKWLcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 06:32:48 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C992719D;
        Thu, 23 Nov 2023 03:32:53 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-543c3756521so1042399a12.2;
        Thu, 23 Nov 2023 03:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700739172; x=1701343972; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJR3101Hl0ju0T8k7A5FLhqgAt7jmzAhmxoZQCDqWNQ=;
        b=GUOz08A+XjAbDfEUHx2VlJ2WTqaPRGbE+0wZELY6tVi4aJGILWORN0ay2fATSAuUhG
         IVKsiGWpJZES7aDo5K2F1SR5bgAqufii0FkvkwRvx6SFIWN+VSBb30WxiVZEZsLNdaEv
         rZ+kyf3gyZ8u4sY6erkgg7nnTOwmu/P2U3Nk8u9ZBTbLK6ZM3eqLUMOPrzpTyo28uZ/n
         0tc/JDbCGt7YFHJUoBlYDKQp4QhQCcm2W2hGBHEU1Kkb4w3xcvwGFvTlFYEwj19pzaDN
         DdPwXyv1o0e+zROHslFbBP4eQOSTgDue9yccuaAjfebSYe97YpCLQ9krpTmwsZaUYxnY
         uCRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700739172; x=1701343972;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FJR3101Hl0ju0T8k7A5FLhqgAt7jmzAhmxoZQCDqWNQ=;
        b=m1plgXXm41i+psrLsb4ffj+I1uVzIM+p6CORh3OCZws7xJKpBi9jChiWxmva6qNkmq
         P/o3aM7vQjRtN7vC3BHkygyAP4mYYYhPxhEXYMh2JvTaynAYgk04kApbxG7woSkcukip
         LbXifPC0E9+LcY8g96cnP7sjLHuBVkUHcuiI+38/mxd+59rtljsi7trqAR55G/8L5bF3
         KsZLMjbzVTYOfj4M3l8XfiSrSmtxQP9jwsVLikqxjklsHa4QhXK8xy6GgI3A3a0EyCC/
         sD9Wcd4rseaFurc/IKa3/60pZ4U70vNUM/0zFkwcBtzp5rW3OyxlOiVB6SB0VBgwhUKy
         wkjg==
X-Gm-Message-State: AOJu0YxbXRYTTLDX32qdHyIfca885kd+UNBTJtg0ya/9EkrJDFmcWog5
        Zi0D36kP5o14mWxkBHSj8Nw=
X-Google-Smtp-Source: AGHT+IF9yCBLo40X1hbdFBWCUzdwY/UWNgg06E7pt731qK1mToTbvsH/X0QsP6Uzk24cb537Bx/Ntw==
X-Received: by 2002:a05:6402:26c7:b0:54a:9155:48e3 with SMTP id x7-20020a05640226c700b0054a915548e3mr2592158edd.1.1700739172081;
        Thu, 23 Nov 2023 03:32:52 -0800 (PST)
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:d183:a5d9:39a9:cd13])
        by smtp.gmail.com with ESMTPSA id f19-20020a056402151300b005489dbe8ed3sm557251edw.4.2023.11.23.03.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 03:32:51 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Lee Jones <lee@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: adjust file patterns in TQ SYSTEMS BOARD & DRIVER SUPPORT
Date:   Thu, 23 Nov 2023 12:32:45 +0100
Message-Id: <20231123113245.23542-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

Fixes: 77da3f22b3d5 ("MAINTAINERS: Add entry for TQ-Systems device trees and drivers")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index df7a57ac864e..1e439b08d5d4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22084,9 +22084,9 @@ TQ SYSTEMS BOARD & DRIVER SUPPORT
 L:	linux@ew.tq-group.com
 S:	Supported
 W:	https://www.tq-group.com/en/products/tq-embedded/
-F:	arch/arm/boot/dts/imx*mba*.dts*
-F:	arch/arm/boot/dts/imx*tqma*.dts*
-F:	arch/arm/boot/dts/mba*.dtsi
+F:	arch/arm/boot/dts/nxp/imx/imx*mba*.dts*
+F:	arch/arm/boot/dts/nxp/imx/imx*tqma*.dts*
+F:	arch/arm/boot/dts/nxp/imx/mba*.dtsi
 F:	arch/arm64/boot/dts/freescale/fsl-*tqml*.dts*
 F:	arch/arm64/boot/dts/freescale/imx*mba*.dts*
 F:	arch/arm64/boot/dts/freescale/imx*tqma*.dts*
-- 
2.17.1

