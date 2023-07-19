Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30FD3759178
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 11:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjGSJ0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 05:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjGSJ0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 05:26:04 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BD61BE4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 02:25:39 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R5VmH3PYSzBR1Nx
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 17:25:35 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689758735; x=1692350736; bh=U/xYmzRLJcoCI0vopk7LHGsNMep
        cp9wZ08dVqcXm5dE=; b=H7+MctIyKVdE0vgjW5p0i+oNwjmu9/WQOUip3rLpuAY
        6BQsefu21+Vd3Xv1/EDnssYSqX//a6jzK8WOJm96KfHHAcPMbcvdzNsY8PdS0e1k
        fwli1bwYng9j+TOW+Ad/7qQiJWJkjfl7kLsO8WQmYClLOpWG6aa8D4nveWvYRpvF
        o+yXRzPXzamSGj4ajLa6hng4nrZN6SnQ2gpB4eIXuAU6/Ih2ZZRP5kt9t0QwIqdG
        tAEWfeKUizze/zLVoPDWod6pBYiV/HNZHcUZ1dkeS9cC7uhRXHEGUScjykSOELp8
        RZEe5uOqAq9VZGdr0dA/J5DdPHYGTaRUhke7bY8qIVA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6_yfpyDKlJX0 for <linux-kernel@vger.kernel.org>;
        Wed, 19 Jul 2023 17:25:35 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R5VmH0bZczBR1Nw;
        Wed, 19 Jul 2023 17:25:35 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 19 Jul 2023 17:25:34 +0800
From:   hanyu001@208suo.com
To:     richard.henderson@linaro.org, ink@jurassic.park.msu.ru,
        mattst88@gmail.com
Cc:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] alpha: asm:  add require space after that ',' and around ':'
In-Reply-To: <tencent_592244D6B47BB549E7840283D55D95B5E308@qq.com>
References: <tencent_592244D6B47BB549E7840283D55D95B5E308@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <875e01e4fae77a5ba0d8f733c9479466@208suo.com>
X-Sender: hanyu001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix below checkpatch errors:

./arch/alpha/include/asm/smp.h:19: ERROR: spaces required around that 
':' (ctx:ExV)
./arch/alpha/include/asm/smp.h:54: ERROR: space required after that ',' 
(ctx:VxV)
./arch/alpha/include/asm/smp.h:54: ERROR: space required after that ',' 
(ctx:VxV)
./arch/alpha/include/asm/smp.h:54: ERROR: space required after that ',' 
(ctx:VxV)

Signed-off-by: Yu Han <hanyu001@208suo.com>
---
  arch/alpha/include/asm/smp.h | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/include/asm/smp.h b/arch/alpha/include/asm/smp.h
index 2264ae72673b..c034bd8d9b16 100644
--- a/arch/alpha/include/asm/smp.h
+++ b/arch/alpha/include/asm/smp.h
@@ -16,7 +16,7 @@ __hard_smp_processor_id(void)
      __asm__ __volatile__(
          "call_pal %1 #whami"
          : "=r"(__r0)
-        :"i" (PAL_whami)
+        : "i" (PAL_whami)
          : "$1", "$22", "$23", "$24", "$25");
      return __r0;
  }
@@ -51,7 +51,7 @@ extern void arch_send_call_function_ipi_mask(const 
struct cpumask *mask);
  #else /* CONFIG_SMP */

  #define hard_smp_processor_id()        0
-#define smp_call_function_on_cpu(func,info,wait,cpu)    ({ 0; })
+#define smp_call_function_on_cpu(func, info, wait, cpu)    ({ 0; })

  #endif /* CONFIG_SMP */
