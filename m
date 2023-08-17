Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E174477EF4E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 05:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347765AbjHQDAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 23:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347748AbjHQC76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 22:59:58 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29EE10E;
        Wed, 16 Aug 2023 19:59:57 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-649c6ea6e72so2586106d6.2;
        Wed, 16 Aug 2023 19:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692241196; x=1692845996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ztwugRyCoG/jPczTnAvnIkr0nq9TF+fC2+bEu6D3jFw=;
        b=Zw4yS8EE/ONnyxUVX0vsKLQUPf5oNFxSVPTWmOyt4c9a9lq6ns/tC4610cgge8UXgh
         fBhR1AdhwR9+pdnw5tRB+nIS+XUKsWg9lY7C9zM6eYgGoCfOBUP21kM5OM/pDhOahNSx
         wXluh7v2jIkhQdJJifSB8i0RenT6XLhxG8V9iThazbxiTkEUJM+tJ2tWaMQtUqfPZ8f2
         Hv99NSes3vLfyMDH56pVsPQXJYlOS0T0ENdSrkqFa1nnmUiJzDPXVhd96mWYJ6Am9Tc8
         OwzCXEx2MpfRi0rwevYHxRB9wjuSrt2KNaXNTfPAyOnLTlIFwDrZ2INl9TTdeLMxyW+H
         TjUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692241196; x=1692845996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ztwugRyCoG/jPczTnAvnIkr0nq9TF+fC2+bEu6D3jFw=;
        b=OS57n0CHmOcgodYYf2U0mP+88pOtAG3h+9bonIW+mSO/1+NjTv8qqZaHwzjDRwAhL5
         g9DeG6ODfFbjBVe0tYzOKWs8z1k0915qj9N07o9o2MxXSaoDYhEtUQAksyMyyFXOzwKl
         Lxg7mcm1L4n8sgxlbh9jTEOArmHQLwxpiqzcT0cj3GCfDIbm+InAZ/orU9wtdQptXMdg
         aI+B8iRjowNtvrXxyu8kWFgcWaowcjqeGD+2X6O5kG0R5uohzoXuUmVuoQUZ9CRBTxMN
         +77QQSWFPHqNzat60PSWBH54X3UR+exFf1QaqMaSSyMNMh0aJG1Ch8xXKxOzn2hUim6e
         4poQ==
X-Gm-Message-State: AOJu0YyVUIHs4oZa36NtZwaT3DHRDBuDhpqwT1fKb3kl0i9ER3B81n96
        L5ITKZej01Sat+5Pi6ARM8/2AqxJgWA=
X-Google-Smtp-Source: AGHT+IG+FilTVdaRFGvd3ZuP9D/ev2/97REv1ERlKBJZKe5MJQokXeEBYBnEUFUrg7AAkPP/DryCmQ==
X-Received: by 2002:a0c:b356:0:b0:649:7b67:14d3 with SMTP id a22-20020a0cb356000000b006497b6714d3mr1869864qvf.32.1692241196259;
        Wed, 16 Aug 2023 19:59:56 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id c16-20020a0cf2d0000000b0063d0159e1f6sm5260184qvm.109.2023.08.16.19.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 19:59:55 -0700 (PDT)
From:   Trevor Woerner <twoerner@gmail.com>
To:     linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 2/4] arch/loongarch/configs/*_defconfig cleanup
Date:   Wed, 16 Aug 2023 22:59:37 -0400
Message-ID: <20230817025942.3209-3-twoerner@gmail.com>
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

