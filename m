Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87EC47575CC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 09:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjGRH4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 03:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjGRH4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 03:56:00 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6E2FD
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 00:55:57 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R4rqG2khjzBQslH
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 15:55:54 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689666954; x=1692258955; bh=zWNni/qECU+wKhB4Mx0VGVeY3nW
        IHBQLKgy0+7TuklE=; b=IHtLeQZUhGryuLc1l44IuMr+WR86/I9bbmn8+dq9rzj
        uzRAvy1lXohHrI74wvKZIZw1ZyPPgHWaykBx2bN0ECWub3H3zlmdWzqFPGCbHiBc
        eKErWeIEccWeCVXyVNMVl/hmnO0X+Q3+dPljWpyq+6ct+NesntN5HnCZACi/CIce
        icDbEQMGkUQG61PlUbN4yjDZB+IL5xPCqqL6TumNlobHokk5Fl05qqqBZAYhwujQ
        cSJwEMHAyw8BsDTpajghGon9Ycr0O7OaWPKkSHl2jtV8DL83WbD2j67Rh4ShMj0L
        Bxn+ypOcTN9eF5GLOE7ZnS5TEI3dXfiL3IjL3tNa16w==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dv4_XWaIS2la for <linux-kernel@vger.kernel.org>;
        Tue, 18 Jul 2023 15:55:54 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R4rqG0jShzBHXh4;
        Tue, 18 Jul 2023 15:55:54 +0800 (CST)
MIME-Version: 1.0
Date:   Tue, 18 Jul 2023 15:55:54 +0800
From:   hanyu001@208suo.com
To:     mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: =?UTF-8?Q?=5BPATCH=5D_powerpc=3A_boot=3A=C2=A0insert_space_befor?=
 =?UTF-8?Q?e_the_open_parenthesis_=27=28=27?=
In-Reply-To: <tencent_66874A8B7152A23DDA815AEB731181CFEA07@qq.com>
References: <tencent_66874A8B7152A23DDA815AEB731181CFEA07@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <b1818ba6b3b305311f992885748494c9@208suo.com>
X-Sender: hanyu001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes checkpatch error:

./arch/powerpc/boot/main.c:273: ERROR: space required before the open 
parenthesis '('

Signed-off-by: Yu Han <hanyu001@208suo.com>
---
  arch/powerpc/boot/main.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/main.c b/arch/powerpc/boot/main.c
index 64a3d6586321..c8ebd552d1e8 100644
--- a/arch/powerpc/boot/main.c
+++ b/arch/powerpc/boot/main.c
@@ -270,7 +270,7 @@ void start(void)

      kentry = (kernel_entry_t) vmlinux.addr;
      if (ft_addr) {
-        if(platform_ops.kentry)
+        if (platform_ops.kentry)
              platform_ops.kentry(ft_addr, vmlinux.addr);
          else
              kentry(ft_addr, 0, NULL);
