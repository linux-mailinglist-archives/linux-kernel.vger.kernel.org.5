Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCBDB7E7F78
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjKJRyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:54:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjKJRxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:53:10 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7C13119F;
        Fri, 10 Nov 2023 03:44:11 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-53e751aeb3cso3125875a12.2;
        Fri, 10 Nov 2023 03:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699616649; x=1700221449; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ls+i1gmtLBTSrDfIDCKkUwn7wVHegofzcMpwXT7w+4A=;
        b=Cce5gxPRibYbOcM20d+4cd2ZoeaRJuAq8WgCtnwg8EdN9Pgk3o8wW3rVVv/sJevWfO
         X+sjQZbsUckL/3EYaSIQtH0C2jBqbkhu/9fxU4LkVeKlabCGIeq+py02X140ptga8ghd
         qyWIrbdIU4/+QYOZ8kndIgdTONT0+QtHLe9CyOF8HaaqTuh3FsdZqeHmeeMxAF6nPgz/
         +v5JDYByB6mzMVTeN9ezeNvNkoJlqWCyREhfDvD1ONUt1+Qk6DXdxEhtMHjo+LGr/Kq+
         ADsEK7I+WqO3IDiArCHmbFcjx174LiJAaZY/jiMJU4scMfp+z5TqPAzLgJVRfmnhJQaz
         Kymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699616649; x=1700221449;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ls+i1gmtLBTSrDfIDCKkUwn7wVHegofzcMpwXT7w+4A=;
        b=LQpUykiHadaZTpOAR26RTAhWW19oDnwbhyTbDgMlMrsN88acMU6I4hl2+2tk02/SRq
         JioO3xjBysKCen07WDqlutF/EER1J+wcgA9ypeO0CBUpeSAfkd9KK54Oivr/WsF2cSiE
         14kPDEJ4SEKbpPz/q7oQb2ere7bacCz+iOEubeClepi4aaZXYdhZpIp0mjQ+7gNFvJjm
         0lpIHwZR+JP7ZLvyN9aIjVNI4jPcPTBJFq54KUKp7pp4qWxKu/CvFYAHs4AclStbZlyp
         DNi79rKaVCwO25l03HTE4SGjiWnJExzgXluktLssYByg8PPDom2aPt8tslaq1kDCvKRX
         6Hrg==
X-Gm-Message-State: AOJu0YwevJutcQHcDgmrF7uYy6hxilrKOhp/I9H+ABXFCG4zd94qtern
        ikPgpKuFfUwCACGPBlBSjNA=
X-Google-Smtp-Source: AGHT+IEDZNf7fK3SBH4Gvbr9dwhXqJGG5/7RAug27JiRlcTC2LXd/5Y7qKKS4jMCJMa8w2p8UhXYcg==
X-Received: by 2002:a50:d554:0:b0:543:5886:71c3 with SMTP id f20-20020a50d554000000b00543588671c3mr6540595edj.25.1699616649333;
        Fri, 10 Nov 2023 03:44:09 -0800 (PST)
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:cd7:bb15:91b6:862d])
        by smtp.gmail.com with ESMTPSA id cm7-20020a0564020c8700b005400dc94f43sm1018916edb.45.2023.11.10.03.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 03:44:08 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] vgacon: drop IA64 reference in VGA_CONSOLE dependency list
Date:   Fri, 10 Nov 2023 12:44:00 +0100
Message-Id: <20231110114400.30882-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit e9e3300b6e77 ("vgacon: rework Kconfig dependencies") turns the
dependencies into a positive list of supported architectures, which
includes the IA64 architecture, but in the meantime, this architecture is
removed in commit cf8e8658100d ("arch: Remove Itanium (IA-64)
architecture").

Drop the reference to IA64 architecture in the dependency list of the
VGA_CONSOLE config definition.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 drivers/video/console/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
index 83c2d7329ca5..bc31db6ef7d2 100644
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@ -7,7 +7,7 @@ menu "Console display driver support"
 
 config VGA_CONSOLE
 	bool "VGA text console" if EXPERT || !X86
-	depends on ALPHA || IA64 || X86 || \
+	depends on ALPHA || X86 || \
 		(ARM && ARCH_FOOTBRIDGE) || \
 		(MIPS && (MIPS_MALTA || SIBYTE_BCM112X || SIBYTE_SB1250 || SIBYTE_BCM1x80 || SNI_RM))
 	select APERTURE_HELPERS if (DRM || FB || VFIO_PCI_CORE)
-- 
2.17.1

