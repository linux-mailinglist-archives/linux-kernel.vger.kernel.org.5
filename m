Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE0B7DA727
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 15:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjJ1NSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 09:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjJ1NSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 09:18:04 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CBFE1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 06:18:01 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-507a98517f3so4150529e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 06:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698499080; x=1699103880; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=McBn8MGf5LwuA4yhCL/eoGiOuT3ohlhlsysy4bQmFxc=;
        b=bp/Av2akiFLyo2+Npb+FO0lFmU6RMbeb6E6EKsXTMwwIWh2Tp5u/5odtAF/bO4Qihp
         ykUNj9YGK90F3RuKJrzTGeaMOF2MaUb5Rwnh3dxGhzrdQjsdSSnycRYylBuBEUJeHhLN
         qAIVQd65xn9U1Amei/5Qb5if0IabegakmXXEW7p0FzGeK13ydL073E8wEE2k8YFXM6yZ
         0YX5gArs3XwEBhUPoIiuiXhqnQ7AgyOIhHkEnf0BbGFSzbwahvuLvgBPhutosIi/q57n
         u3hbqhoUbI0sajENpYxgyQESC/xm+Z4jhH93Np5xLgxIvvqyzTiU50IJVn3IBcDHAaMD
         VzVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698499080; x=1699103880;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=McBn8MGf5LwuA4yhCL/eoGiOuT3ohlhlsysy4bQmFxc=;
        b=W+do2KRXRFcOMvzTq9z1Vf80YBP8k7X43hhroHyvllq/zsG5ooxjfqq7VkQyLTrjNV
         elMRcZ7BM8EWxdw2b83Bq/genQ2YIsD2n5S+dF10HGm6iMO/9mcmQA+VmcbnwTRRjySn
         mG0ZdX7qAOz8bXGfbhqf8YQCvknNbBl6XuC0viWW37ZMW1ohT698TBk5sSeXoE5FHpqs
         NeBAkGuAOQi7MBAW+kYdUSr2iL02A0qUiaQjOrZDS/njfrv2W0r2ivpsUiCJ+gpZ/gel
         ROlSYo6ZM/8j2RmEmowXQa6nSsZhTz6ZYC7qV17gk9vlOVYuu1EkEdDJZIAm8rBMUDO0
         mEIg==
X-Gm-Message-State: AOJu0Yx9tEqOvHPnaKlb/hiBosdu7/8IlvUg9h+A4lWdaRkx4fQvHtvV
        mZetU1ePq+68hKpYnBHscx+vRAmpxgk=
X-Google-Smtp-Source: AGHT+IHxCzz+b6hDN7dL+2gERhGwc0FJASUXeI/jDJWcrouL3C/OwSYEh3YWKuQTgaQHdnaV2Zp9zQ==
X-Received: by 2002:a05:6512:401b:b0:509:e5e:232a with SMTP id br27-20020a056512401b00b005090e5e232amr1208831lfb.42.1698499079675;
        Sat, 28 Oct 2023 06:17:59 -0700 (PDT)
Received: from gmail.com (1F2EF1E7.nat.pool.telekom.hu. [31.46.241.231])
        by smtp.gmail.com with ESMTPSA id va13-20020a17090711cd00b009b2c5363ebasm2735251ejb.26.2023.10.28.06.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 06:17:58 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 28 Oct 2023 15:17:56 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>, Marc Zyngier <maz@kernel.org>
Subject: [GIT PULL] IRQ fix
Message-ID: <ZT0KBBagVt7tf6nN@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest irq/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2023-10-28

   # HEAD: f199bf5bf84c19a4f488a39d7d694ab10787de35 irqchip/gic-v3-its: Don't override quirk settings with default values

Restore unintentionally lost quirk settings in the GIC irqchip driver,
which broke certain devices.

 Thanks,

	Ingo

------------------>
Marc Zyngier (1):
      irqchip/gic-v3-its: Don't override quirk settings with default values


 drivers/irqchip/irq-gic-v3-its.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 75a2dd550625..a8c89df1a997 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -5112,8 +5112,6 @@ static int __init its_probe_one(struct its_node *its)
 	}
 	its->cmd_base = (void *)page_address(page);
 	its->cmd_write = its->cmd_base;
-	its->get_msi_base = its_irq_get_msi_base;
-	its->msi_domain_flags = IRQ_DOMAIN_FLAG_ISOLATED_MSI;
 
 	err = its_alloc_tables(its);
 	if (err)
@@ -5362,6 +5360,8 @@ static struct its_node __init *its_node_init(struct resource *res,
 	its->typer = gic_read_typer(its_base + GITS_TYPER);
 	its->base = its_base;
 	its->phys_base = res->start;
+	its->get_msi_base = its_irq_get_msi_base;
+	its->msi_domain_flags = IRQ_DOMAIN_FLAG_ISOLATED_MSI;
 
 	its->numa_node = numa_node;
 	its->fwnode_handle = handle;
