Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FE977EF49
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 05:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347744AbjHQDA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 23:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347732AbjHQC7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 22:59:54 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BA1198C;
        Wed, 16 Aug 2023 19:59:53 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-4103fdba0fbso24473571cf.3;
        Wed, 16 Aug 2023 19:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692241192; x=1692845992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VqIUTEi6b5maOYfEISJN/XLCGUsT7sZm6MvKkdhtPPQ=;
        b=WHSqp/OjipS4malg5Jhuw8Q9iUeu1/JOmbXWqXYvnZgGD0kM17N6tQvxwUsCI5NLru
         Uc5eVbilZvj+vU/FDtUEKtVANL/igEVVU9fMzmN+KBhf+xt59WNKpal6tsNf+z9+Y7TV
         yD5Im18r3kHMjvZZUNXeLn1YO9dO18rMwOHA24MSxJx1EZE51SgTXLAarM8kC0zelVrK
         5SidfXYcfJz7Lp9YUVglFIezKC2ivHG+RE4hB+Sk1DDJsqYqmafTDGDirXACn06WXuBz
         DmK8i+/ZjA5wROpsni5u9JVtRraWCxRDSDmuyfbzUbITI31KPak3SF5rZt2bcrO0fYUd
         z78Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692241192; x=1692845992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VqIUTEi6b5maOYfEISJN/XLCGUsT7sZm6MvKkdhtPPQ=;
        b=jnt//KyImeMxegv8yxg02QybV/0wgmGApzrAnGbNAhF8347eUuwPoG3fqhwigbTTm3
         z/47o1FunnSpWXRuE4LUOTQf73m6eNcrGjxKaP5vdso23tGJCVTLgJj2CfFXYOk4n3jR
         qRCY/p4Z+h38iUKLCkFS2+Pp7EC3FUavaNRGx17FLsXDFHkELpQIqVTxon7Hn/XWIJwz
         uD4z4AdTK+Tm1735Po/HKFCmI2n/sSt/Dlql+JaM554GTtFXWfUFojVrvGOeth5p6rou
         KgExB5nNcZdZEpMTOmC26dazbVT7lwX2RJa3Op3BNexoQWgnbIdXhWCcU5x2w78jUhw9
         z5JA==
X-Gm-Message-State: AOJu0YwF6+xj7uYVM+7ShVwm99ixEbq85dXWGuST93zpMVfeH8jmHeoo
        acQkwQAPb67kJDtq7+AWV4ZXF/Nfht0=
X-Google-Smtp-Source: AGHT+IFBzAZ0MiGiVZDZXUmHBUCgDd7pIXBv+9jFVMKW5hvqzp/dG7vKept76xYLnf/geME77zPN6A==
X-Received: by 2002:a0c:e047:0:b0:636:afa1:345d with SMTP id y7-20020a0ce047000000b00636afa1345dmr3324091qvk.17.1692241191804;
        Wed, 16 Aug 2023 19:59:51 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id c16-20020a0cf2d0000000b0063d0159e1f6sm5260184qvm.109.2023.08.16.19.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 19:59:51 -0700 (PDT)
From:   Trevor Woerner <twoerner@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 0/4] general defconfig cleanups
Date:   Wed, 16 Aug 2023 22:59:35 -0400
Message-ID: <20230817025942.3209-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.41.0.327.gaa9166bcc0ba
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop config options from defconfigs whose code has been removed.

v2:
Generate arch-specific patches. In v1 I organized the patches by
CONFIG_ option which caused some of the patches to cross architectural
lines. This requires cross-arch consensus before they can be applied.
Therefore organize the changes by architecture so each one can apply them
independently (or not).

Trevor Woerner (4):
  arch/arm/configs/*_defconfig cleanup
  arch/loongarch/configs/*_defconfig cleanup
  arch/mips/configs/*_defconfig cleanup
  arch/powerpc/configs/*_defconfig cleanup

 arch/arm/configs/keystone_defconfig        | 1 -
 arch/arm/configs/multi_v7_defconfig        | 1 -
 arch/arm/configs/omap2plus_defconfig       | 8 --------
 arch/loongarch/configs/loongson3_defconfig | 2 --
 arch/mips/configs/ip22_defconfig           | 1 -
 arch/mips/configs/malta_defconfig          | 1 -
 arch/mips/configs/malta_kvm_defconfig      | 1 -
 arch/mips/configs/maltaup_xpa_defconfig    | 1 -
 arch/mips/configs/rm200_defconfig          | 1 -
 arch/powerpc/configs/ppc6xx_defconfig      | 1 -
 10 files changed, 18 deletions(-)

-- 
2.41.0.327.gaa9166bcc0ba

