Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A51277EF50
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 05:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347780AbjHQDAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 23:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347782AbjHQDAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 23:00:08 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCFF2D69;
        Wed, 16 Aug 2023 20:00:01 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-64723bb9e25so2535186d6.0;
        Wed, 16 Aug 2023 20:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692241200; x=1692846000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n2GSnqeNoyAE/+SX3es1Oteof6ti0abAFPSQqsiZHHw=;
        b=nQWr89uC0Ngba1SRckU+echVMfhTwA2qk0vDCbhHdOtjAAGdM19nRWPqLBgCr0Duo7
         7rYD5dLldDIFpMazz5Tf135A0CAVP0imv6JyHkX52mUGYyUonKAhaM4xzJbZ4jbfWqpT
         jRkxUOVXjlnyM/G6pQOhk39ERd8wIastgkFTomKSXU8WGZfyXUXiBDbO60AmhQzjBzKP
         rEx+5tscbvHykIJgWX6AvvRShos4qB521nSQYyv2j8U1JPO3qJaP03/AX76O/sqeWF2V
         HT6ELMnIUQFFdssAO8g4/d7WQEhfQTgKwmxtr12KhKA4izqI3id8RZR/e7rVLQH7svHa
         uAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692241200; x=1692846000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n2GSnqeNoyAE/+SX3es1Oteof6ti0abAFPSQqsiZHHw=;
        b=Cslx0llJ9PFKEE27CbqNYa+3fKtj5JPdwOaARZYzqEma7aHvspVlubj7RpTWr3y8Wk
         yNG2fF8yfXH9bTwzOSlHWOmVfAUT6PKzAgJjySDBbwCXBrOwgTmFOuYYf4qXoqJpxSpd
         3+Koy8WyW0t7oIFIufUePKUVP77q3oodeb3xGVfGl2xCp9yXWb/wO2d7GppIH2FDLB9Q
         1+nMAe93+GnGQ9B519FAM1c4xaiWmH+5qvAnWTfqwI8n90hRvU6VJ6U8ZVNr3uDo0weX
         ZgwFSJPYLnJLqsDjMr0UjkGsVw8w1xfN9jomG75Lae/C44UQG+C3c6tQKrMirnpyZ4wo
         RcBQ==
X-Gm-Message-State: AOJu0Yz6bcTwXTQ67OfmNQXD6p5m/OroLJ0HQ2By5O3n/sJ3RveIlYpH
        UQNp7ftqOE6v4AMkI8MgqaNMhZBYuPI=
X-Google-Smtp-Source: AGHT+IFng0wFZtCSDDiVOY49UxdEFehiYLDUvGYu2W+npgCx1ZI6h5QEe6nSX/rWT8xkkK8CoCgLBA==
X-Received: by 2002:ad4:5d6d:0:b0:63f:9130:4e9c with SMTP id fn13-20020ad45d6d000000b0063f91304e9cmr1855432qvb.26.1692241200467;
        Wed, 16 Aug 2023 20:00:00 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id c16-20020a0cf2d0000000b0063d0159e1f6sm5260184qvm.109.2023.08.16.19.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 19:59:59 -0700 (PDT)
From:   Trevor Woerner <twoerner@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 4/4] arch/powerpc/configs/*_defconfig cleanup
Date:   Wed, 16 Aug 2023 22:59:39 -0400
Message-ID: <20230817025942.3209-5-twoerner@gmail.com>
X-Mailer: git-send-email 2.41.0.327.gaa9166bcc0ba
In-Reply-To: <20230817025942.3209-1-twoerner@gmail.com>
References: <20230817025942.3209-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop CONFIG_IP_NF_TARGET_CLUSTERIP as it was removed in commit 57f8e00d8a82
("usb: 71 musb: Drop old unused am35x glue layer").

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 arch/powerpc/configs/ppc6xx_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs/ppc6xx_defconfig
index 1034aeabdd6c..eaf3273372a9 100644
--- a/arch/powerpc/configs/ppc6xx_defconfig
+++ b/arch/powerpc/configs/ppc6xx_defconfig
@@ -183,7 +183,6 @@ CONFIG_IP_NF_MATCH_TTL=m
 CONFIG_IP_NF_FILTER=m
 CONFIG_IP_NF_TARGET_REJECT=m
 CONFIG_IP_NF_MANGLE=m
-CONFIG_IP_NF_TARGET_CLUSTERIP=m
 CONFIG_IP_NF_TARGET_ECN=m
 CONFIG_IP_NF_TARGET_TTL=m
 CONFIG_IP_NF_RAW=m
-- 
2.41.0.327.gaa9166bcc0ba

