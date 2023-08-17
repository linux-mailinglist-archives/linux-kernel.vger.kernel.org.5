Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641C177FF07
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 22:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354878AbjHQU3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 16:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237299AbjHQU3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 16:29:18 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB082E52
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 13:29:17 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-68866e64bceso129546b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 13:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692304157; x=1692908957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UBC0kyACp6cZakr+/LVmBs8MHr/PelOvdSb/J30Xonc=;
        b=D3BLvgRIzTueG23XC0/di+/pbRKmgOg9JH+UkYD5kCvW0hFBHl7MTDaUBOFP1+Hmim
         Em2szVmnvj7xaNBUHKCmEdkGhdqhcaKTRDwaZlPA9FycY+p9OoI87eKnsS5usZ1T5r8c
         rw6/n9HNCHlpT+2i2UO2k9c/G/pwFCqGcjN9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692304157; x=1692908957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UBC0kyACp6cZakr+/LVmBs8MHr/PelOvdSb/J30Xonc=;
        b=bWBwP/pio0235OXqDRqBAQz/6zgF3ZDOXom/w+2fbUjAdViZRnDPdDkmCYtR3F7JQn
         7xYRuFUMHEiFEO6tAwQCSHRZH5BHzxYwc7DhdbOY7s+my3Cyzaw7WnLzJj+Rqz6cgdYL
         4+TElBxR/To9fNVa06lIFf9KEEB+wcVQGfT6JRHhRLNx/tA/GrXAxrjiMlnlPjcTWx5K
         Foy7iCQ0gCisGdB+Rc9Inup5g4E0YZmLsq2UDV/KGU0XoxR4jJh8RNsy6gIfPR5BnbfH
         6lk6BsKCsGq/PTwyPBQETHJv6y44LMM8ce0DW/bLAP4EAgoOjirT6g24scm+sKLxni56
         WXSQ==
X-Gm-Message-State: AOJu0YyQOlR7sgKBFj+1A0oby7B+MNpErGxlx7DYT2zEIivkVd64k6VV
        oYfuoK9XFyOHWf/U3T4ZhY9+cg==
X-Google-Smtp-Source: AGHT+IE7lenirKPXRZ81vsUg+uiz21E6QGGGQWt45oeRx5Z2P4xIkRjz8TrSA5QwtdIXR+cRojXk/Q==
X-Received: by 2002:a05:6a00:24c6:b0:687:7b0a:fae4 with SMTP id d6-20020a056a0024c600b006877b0afae4mr860075pfv.0.1692304157183;
        Thu, 17 Aug 2023 13:29:17 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f8-20020a633808000000b0055c02b8688asm104792pga.20.2023.08.17.13.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 13:29:16 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-pm@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] interconnect: icc-clk: Annotate struct icc_clk_provider with __counted_by
Date:   Thu, 17 Aug 2023 13:29:15 -0700
Message-Id: <20230817202914.never.661-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1168; i=keescook@chromium.org;
 h=from:subject:message-id; bh=V/JCGKhhIUvYMZwINl/W0cWShIAE6EyAXc3VChYyI48=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBk3oMbZWS6f4Gn2UrbPx823jib67w4/eDfzQkNc
 8O/6ildBgOJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZN6DGwAKCRCJcvTf3G3A
 Jmt3EACiQyI5QLyRqha/vGjQqFJOXqtFjcN9mt/F/ayeNCxUvPbrt8FYFRLgRht8uX0saNCudAk
 ke+mW9O8NefD1xoVSvt1W08jN/v+63aZ0yIQUnp/CLb3BV6SO33EWj22w77Hx7i7GgxyDIiVLnH
 f9KLTAfoQnloXyk5vfFecdmKewwa2wAXVirnkGqVvw5GexvknXAdVAdgw+znrGu+Sc481EbV+hF
 2OoqpBQ33YctAqJUVTeg4HfoJLyEWBHH918kk1Q12U2oYUcf5aFd0wmJZsLjUefjBV5SvAZFZiZ
 Cw2/ymHRWHOmJ0YMxp91JuL2x16H+ozABgmMlG88q72KfSg9UH0VSYn1mSPNQ2YhShAnA25/Sxc
 M61r3jF+BiE9QChOPFriiV050W8RsVNMpX3RBqR19jThspygD4bd3xUqXfxJ8mOHl4AP5ykeURf
 Fxa/RuWNGUXfy/6hD/v41uXp9+1IKom3zooPuGdoDeEhJ54CvvHrnyWH1pke6NndkibWPDK97MY
 zo/0iDbdKXMFSdebJDWjWiCwe2Eabu8dkEb0ASCTA+bZaQzGB7jCt9de4wq8tCHEU1xRyxf4Ga/
 /L9fMyRP9Karpe1y0LXyjLHU728TNd7iLQYn7g2EeFNwNz9Y5pzQW8taQ1Re1R0Vj33476iGUwh
 2d9k7+i FKtaJuTQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct icc_clk_provider.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Georgi Djakov <djakov@kernel.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/interconnect/icc-clk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/interconnect/icc-clk.c b/drivers/interconnect/icc-clk.c
index 4d43ebff4257..d787f2ea36d9 100644
--- a/drivers/interconnect/icc-clk.c
+++ b/drivers/interconnect/icc-clk.c
@@ -16,7 +16,7 @@ struct icc_clk_node {
 struct icc_clk_provider {
 	struct icc_provider provider;
 	int num_clocks;
-	struct icc_clk_node clocks[];
+	struct icc_clk_node clocks[] __counted_by(num_clocks);
 };
 
 #define to_icc_clk_provider(_provider) \
-- 
2.34.1

