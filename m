Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1757075777A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 11:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbjGRJMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 05:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjGRJMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:12:10 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A2610FC
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 02:11:52 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R4tVs2WLfzBR1P9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 17:11:49 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689671509; x=1692263510; bh=KucHDh6DWgAfyXp3Nu1+swDR6DT
        wgz80t/2PvvAIrgs=; b=xEo+BHBvDOf2ZOq3+I35APvibMBO0308GAxxNtIFZF7
        x3tbsuHTwh83ppRo7b5fSAVuib4HxXjOSphJnC2l96qcQ60S3HZJSHE/dWtFSg9g
        IDevvlo1IUkUYDvTESfc89ZwtEZ0nDWZukHjYJ5QNlsxpgRfOJ4//YPYRGF8d5r5
        hsAJUEIiZYkK1vUsoFbn8ce1Tz/HQzI0whP04PKtYwl+t0tRs2T5qdjaSWbVNtCv
        OKWRz3/r6s8C0i5E16LU8G+TpnDEr1Nq43mNTdFrgrbTbxAbWPk3gcADOOel0sC3
        xK2psjqaqMlx429Tc9WJpsQ9+/Wq7/G2zX2PoQ4EqPQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id KeXsK4bgCEYz for <linux-kernel@vger.kernel.org>;
        Tue, 18 Jul 2023 17:11:49 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R4tVr6hvbzBJBfd;
        Tue, 18 Jul 2023 17:11:48 +0800 (CST)
MIME-Version: 1.0
Date:   Tue, 18 Jul 2023 17:11:48 +0800
From:   hanyu001@208suo.com
To:     mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        nathanl@linux.ibm.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platforms: chrp: Add require space after that ','
In-Reply-To: <tencent_DC5A89DAEE730A81E76A904AA67119225807@qq.com>
References: <tencent_DC5A89DAEE730A81E76A904AA67119225807@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <482baf0b2b66efeb3605d44823b37fde@208suo.com>
X-Sender: hanyu001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,WEIRD_QUOTING autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes checkpatch errors:

./arch/powerpc/platforms/chrp/setup.c:91: ERROR: space required after 
that ',' (ctx:VxV)
./arch/powerpc/platforms/chrp/setup.c:91: ERROR: space required after 
that ',' (ctx:VxV)

Signed-off-by: Yu Han <hanyu001@208suo.com>
---
  arch/powerpc/platforms/chrp/setup.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/chrp/setup.c 
b/arch/powerpc/platforms/chrp/setup.c
index 36ee3a5056a1..f8f06413bf23 100644
--- a/arch/powerpc/platforms/chrp/setup.c
+++ b/arch/powerpc/platforms/chrp/setup.c
@@ -88,7 +88,7 @@ static const char *gg2_cachemodes[4] = {

  static const char *chrp_names[] = {
      "Unknown",
-    "","","",
+    "", "", "",
      "Motorola",
      "IBM or Longtrail",
      "Genesi Pegasos",
