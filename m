Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED8E77F5AF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 13:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350510AbjHQLun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 07:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350559AbjHQLub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 07:50:31 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B160D2701;
        Thu, 17 Aug 2023 04:50:22 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-40fd2de0ddcso54998441cf.2;
        Thu, 17 Aug 2023 04:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692273021; x=1692877821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qcri40AASRR4BFsuSO+X3cA76lV9mjhear1ggGLTZLg=;
        b=TPnESRUpP/KtEYZty2/I71s0M7NdefMLoExvx9rNuW8Reu40ADoBeZFuDMVF9NfGxp
         6jm1VSkNUATDJUAO2waHJf6ZuRjtYXCMibErNn1PcQPInVBNTPt1LynPSb351l+dpPgU
         8uR+Cg6eEt9lu2ZTtxyeF3nm5m96aBb27q3bZOscAOlDDbinhtVDTsvVnyY2e/O41AaR
         3ILuvFu1GOacRyKkb50Aijdm2HXNe87tUgm4ZbMnzvOVpDdRb1OFXssgZF1lCg6+QbR/
         1Votk8z5iyG1pZ5l87yCSStgvjzBnV0m0kH7WLqgSSrGPUh+WiEv7lMxnq7doraeSruP
         83DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692273021; x=1692877821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qcri40AASRR4BFsuSO+X3cA76lV9mjhear1ggGLTZLg=;
        b=aedw6HmENRXCTg514z+SufIOCY7Lz+zDH661EDmXP7sYcp8B6sQZC+ks643o9I9uWI
         JoPphanmHiJ5clHLXx5Aj5HqDbawnQhTGUugM6VhJghfPNKuA9zLEvULwvzoIz75/pu8
         9IYKKlifpbt8zg4BC4/TSAMIci8G+xIzN390f1xKGEQLXS+/6nswid8ElF+/2nGXyFPL
         vrftzWD7WvU93mMrvl2NjjKqLV4bth5qFtGo7BnQ0hMRbl3auKalhN/5leY1eFyGzOO+
         6h4Yh53WBVsdVYruh57CnDHPbc9XvEEr/fikeXxKJqMmVtrCaNQkplhRNcRaaLAjmCYG
         foOQ==
X-Gm-Message-State: AOJu0YyHTGuKPUX6YUxp4K4/t6AwdC6iay73duXyhNPw6hvirpCLnLzg
        nbiBjcV/pKcUVO68ujkx4bbfR6ItPHs=
X-Google-Smtp-Source: AGHT+IGxsq2uwogQdBPmvMNMrm5x/VpIF14pHjZPiMJMm6t7UtQ0zLWCLBZFUfKOaK/uYR3GUwHjIA==
X-Received: by 2002:ac8:7e8b:0:b0:403:b252:96ea with SMTP id w11-20020ac87e8b000000b00403b25296eamr6018736qtj.21.1692273021085;
        Thu, 17 Aug 2023 04:50:21 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id h8-20020ac85148000000b0040ff387de83sm5142149qtn.45.2023.08.17.04.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 04:50:20 -0700 (PDT)
From:   Trevor Woerner <twoerner@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 0/4] general defconfig cleanups
Date:   Thu, 17 Aug 2023 07:50:10 -0400
Message-ID: <20230817115017.35663-1-twoerner@gmail.com>
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

v3:
While reorganizing the patches, I put the wrong commit message with the
CONFIG_IP_NF_TARGET_CLUSTERIP option.

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

