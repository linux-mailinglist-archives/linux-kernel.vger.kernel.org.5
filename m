Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7999802273
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 11:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233348AbjLCKO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 05:14:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233265AbjLCKOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 05:14:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BACF3
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 02:14:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE71C433C8;
        Sun,  3 Dec 2023 10:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701598468;
        bh=y6guoQ7JWLb6nFfFVlYe/P/b7whl0hnphrJFPbci+gk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ANc3f6u9EJ1ssuxlufhHFIfCJXuS+5oWXzSwIs67To6kWkn4rM1AnGhiZ8OET+DzD
         BJ0ThA4/ZrHd8ZdZuOP7SgL+PaY62RFymEtlgn6DvuxLngtM/RcjMGvia/dCb5GAY2
         xRIWJGXwJpWSBf9S1v38Ux5kfOPwOvoNc5tBznfjUbCEnViqTDZSXeVp0UBfvNiC6o
         G2JoRJPw9ZkD8Cka9somYHgg4zMQmsyHtvMuIKNySqyOxNtB4HuegMnJnqD2pR1O40
         DBUYwHtlTBHiDQ0ECMWhWsSHnZ26BNrN8+Vcj7yl3mqVlC5iN5fD91fWFJqnYorXBW
         OID75cthdk4VA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: [PATCH 3/3] sparc: vdso: use $(addprefix ) instead of $(foreach )
Date:   Sun,  3 Dec 2023 19:14:18 +0900
Message-Id: <20231203101418.1910661-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231203101418.1910661-1-masahiroy@kernel.org>
References: <20231203101418.1910661-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

$(addprefix ) is slightly shorter and more intuitive.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/sparc/vdso/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/vdso/Makefile b/arch/sparc/vdso/Makefile
index 03a32b6156ee..7f5eedf1f5e0 100644
--- a/arch/sparc/vdso/Makefile
+++ b/arch/sparc/vdso/Makefile
@@ -13,7 +13,7 @@ obj-y				+= vma.o
 obj-$(CONFIG_SPARC64)		+= vdso-image-64.o
 obj-$(CONFIG_COMPAT)		+= vdso-image-32.o
 
-vobjs := $(foreach F,$(vobjs-y),$(obj)/$F)
+vobjs := $(addprefix $(obj)/, $(vobjs-y))
 
 $(obj)/vdso.o: $(obj)/vdso.so
 
-- 
2.40.1

