Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25C977F5B0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 13:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350518AbjHQLup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 07:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350571AbjHQLug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 07:50:36 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884582102;
        Thu, 17 Aug 2023 04:50:26 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-76d7fcae695so25414285a.1;
        Thu, 17 Aug 2023 04:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692273025; x=1692877825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sbvZ0wXoAsUi3mH+OyBVc4tLRr53KILTrQvp8XOCI2I=;
        b=TI34epmG63xD/ogdDBQlcmORfJTVgqCB9lCa/odYhTA7mGcaaXBsVMVzIoLJkRSQSX
         cyj6CUlXhBBpxGczW9E//k7K5WcVE0awNVniGZOocUxt1fjELgDWbzmKjH/aB/Lw8haN
         ejRcRk+qaJr5GY/7t0AgvIN6MkEqFwU/TsheIqw6pwDr60lXmZZc4/+qGwtIMqPjCStI
         7LGDwqCEjWEvukhk68ufc+soaBCCdJqVyC3WfFdbEX15Vhznz7adSHAXxXIS41T3S+HW
         gUgF92Cz6ETPSlKpDhxGxaPa8wHIFUKq8zBcj/64dTv6/6P+aoRQODiwtCT7tJFNbbzP
         z9tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692273025; x=1692877825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sbvZ0wXoAsUi3mH+OyBVc4tLRr53KILTrQvp8XOCI2I=;
        b=g/p0QH9FZ7lHrfH1Yrl2coYjv+IWahmyxaym8A1ULADVYHW2fL69S2542jtXwx6qvV
         QUdKJTSpDcnwn1f+4GYqGwNM7pOXFkJZXUfDG3/NiLH01fV7fax2ndv/Ap/HMnBIhGfl
         yqMlUFYNrs/ksTFZQVoU8KXq8Pd8B0j+nzouE8VzzxXqCZDabM0BZJilSCcx8Yoe7ZmL
         4uikPq+ceo4VUwX5WhbbK+1LjB5cY5XM76LaOb5mBToutkVkMRyLdf3K63MrpmCwnQQi
         a1ngZFAAiki5FO/XgtQB4AKZOKCkLPZ9ZuEpgYeLk3+rxOemwv9MmmfQ+iPPI21Fd6Bx
         fRog==
X-Gm-Message-State: AOJu0Yx4jvqXfEjz/O230QrmZ1+IilLLsJ1INvP2hfZAZRw8rtIvT+wF
        NYZb75bF3P4MVqADTCBdDIrHeu49R5c=
X-Google-Smtp-Source: AGHT+IFwFJxPNX+IDoSCTYuBwePuAYwMImkYtdwD+QMIGbAdq3LaStJT3pJEeHO3wtYuDF5hW0txgA==
X-Received: by 2002:ac8:57c8:0:b0:405:5337:4166 with SMTP id w8-20020ac857c8000000b0040553374166mr5942082qta.68.1692273024954;
        Thu, 17 Aug 2023 04:50:24 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id h8-20020ac85148000000b0040ff387de83sm5142149qtn.45.2023.08.17.04.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 04:50:24 -0700 (PDT)
From:   Trevor Woerner <twoerner@gmail.com>
To:     linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 2/4] arch/loongarch/configs/*_defconfig cleanup
Date:   Thu, 17 Aug 2023 07:50:12 -0400
Message-ID: <20230817115017.35663-3-twoerner@gmail.com>
X-Mailer: git-send-email 2.41.0.327.gaa9166bcc0ba
In-Reply-To: <20230817115017.35663-1-twoerner@gmail.com>
References: <20230817115017.35663-1-twoerner@gmail.com>
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

Drop CONFIG_IP_NF_TARGET_CLUSTERIP as it was removed in commit 9db5d918e2c0
("netfilter: ip_tables: remove clusterip target").

Drop CONFIG_NFT_OBJREF as it was removed in commit d037abc2414b
("netfilter: nft_objref: make it builtin").

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 arch/loongarch/configs/loongson3_defconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/loongarch/configs/loongson3_defconfig b/arch/loongarch/configs/loongson3_defconfig
index d64849b4cba1..4700655b2bcb 100644
--- a/arch/loongarch/configs/loongson3_defconfig
+++ b/arch/loongarch/configs/loongson3_defconfig
@@ -137,7 +137,6 @@ CONFIG_NFT_MASQ=m
 CONFIG_NFT_REDIR=m
 CONFIG_NFT_NAT=m
 CONFIG_NFT_TUNNEL=m
-CONFIG_NFT_OBJREF=m
 CONFIG_NFT_QUEUE=m
 CONFIG_NFT_QUOTA=m
 CONFIG_NFT_REJECT=m
@@ -227,7 +226,6 @@ CONFIG_IP_NF_TARGET_MASQUERADE=m
 CONFIG_IP_NF_TARGET_NETMAP=m
 CONFIG_IP_NF_TARGET_REDIRECT=m
 CONFIG_IP_NF_MANGLE=m
-CONFIG_IP_NF_TARGET_CLUSTERIP=m
 CONFIG_IP_NF_TARGET_ECN=m
 CONFIG_IP_NF_TARGET_TTL=m
 CONFIG_IP_NF_RAW=m
-- 
2.41.0.327.gaa9166bcc0ba

