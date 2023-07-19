Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED417591BF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 11:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjGSJgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 05:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjGSJge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 05:36:34 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8467E42
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 02:36:32 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R5W0r4XGjzBR5D1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 17:36:28 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689759388; x=1692351389; bh=eCH2V3ntIvzfeHaDHWorbP5NXrR
        Bd6933jWIixZYE1w=; b=XMNVOtWDkMUJiO+PMZpcwHfvBybAtpvmWEth0tDScM9
        ZU9qMv/xMTT31Cl5Ym2Yrnb8eVjFZrzhQnr28nCaA/CikkX+SsL2l3miweypPxSR
        wu0UjIU8zYwIRKu9No+WC63f4JYQivT3thr1EDWTZvH+LA05BTGsKQ90pIwOSme4
        N3rt8+eiKr6gjF5J2bVYn0T7QFM37LJINbfSMK4WmoAib1+kTWKXya5cqWr/thN5
        jhgPHMHduplwZrcwU1vR1mTxEN3Cn6WHPcEEjk5d1BBVaWfZzNV0BOVXLYH2fhVy
        zilHit6sPfUZQ6SKiIpKL+qukvI4AnN331gv5WfWk+A==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3DgKu2Binp99 for <linux-kernel@vger.kernel.org>;
        Wed, 19 Jul 2023 17:36:28 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R5W0r2cxvzBR1PC;
        Wed, 19 Jul 2023 17:36:28 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 19 Jul 2023 17:36:28 +0800
From:   hanyu001@208suo.com
To:     guoren@kernel.org
Cc:     linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] abiv2: inc: abi: add require space around ':'
In-Reply-To: <tencent_80CE010520AAD72B85C65189CC69B56AC709@qq.com>
References: <tencent_80CE010520AAD72B85C65189CC69B56AC709@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <07397261f87f410076689e4a0cd0913f@208suo.com>
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

/csky/abiv2/inc/abi/ckmmu.h:131: ERROR: spaces required around that ':' 
(ctx:ExV)
/csky/abiv2/inc/abi/ckmmu.h:132: ERROR: spaces required around that ':' 
(ctx:ExV)

Signed-off-by: Yu Han <hanyu001@208suo.com>
---
  arch/csky/abiv2/inc/abi/ckmmu.h | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/csky/abiv2/inc/abi/ckmmu.h 
b/arch/csky/abiv2/inc/abi/ckmmu.h
index 64215f2380f1..b5cac07c4411 100644
--- a/arch/csky/abiv2/inc/abi/ckmmu.h
+++ b/arch/csky/abiv2/inc/abi/ckmmu.h
@@ -128,8 +128,8 @@ static inline void setup_pgd(pgd_t *pgd, int asid)
          NOP32
          ".endr            \n"
          :
-        :"r"(asid), "r"(__pa(pgd) | BIT(0))
-        :"memory");
+        : "r"(asid), "r"(__pa(pgd) | BIT(0))
+        : "memory");
  }

  static inline pgd_t *get_pgd(void)
