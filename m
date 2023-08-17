Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A73C78024C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 02:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356405AbjHQX7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 19:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356357AbjHQX7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 19:59:10 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814393A8D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 16:59:05 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-564b8e60ce9so298017a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 16:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692316745; x=1692921545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vdyN/fj86XQDqOrrbJ+rbs9RYAU+LL5JiAfmLxUgxMI=;
        b=oBAxpd/FRve5XlrsrxBsKrpB9KrQpqxMLqtzRew+3AXlkD3fhn6Z/EWeioXVIsD6kj
         3UN9nAIQlgnxjePwywSbPfWa9tfyA8y/aDDAQVK3PTHWjac9q1kudJxi0AAh+o2xrvjm
         PvMz6QfhB+OTlJil0oC0LSXa2xCQpDnGbbsRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692316745; x=1692921545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vdyN/fj86XQDqOrrbJ+rbs9RYAU+LL5JiAfmLxUgxMI=;
        b=K4Wp+Y/5UlUBC/25z7xB8K7nyMYXmI7LY3z96o/yte8RfDPeOZ/hiIcv4LPWImY0OM
         y8JcgCvPlLP4qzDeaoFcTvCa8J9DCeK194XPtcKVqoVM5USf94Ew9NELlnFFhQuqr6lo
         7Cyk6JJhk6xC7/EAeujjCkP+s6cTdr2I3UqwYfQKEuo7BcY/y3LAMIukkvThctGIePwl
         migD2J/ieVybzbCRV7sf5+0k1cdleVxLr4e6DT+3U+9JT6L5DOJS3nEJTe1F9EtMsbfA
         1Kzd/x2J4EcqCw9hh90mChsOE8m3L++aGPcsiXBZ/30F+utvHuBy3u0UanOHtqZnmCXg
         em2g==
X-Gm-Message-State: AOJu0YzHR+uC7uyDnFNGvFD9aCrt32GbZGWfthRKrWpTQazo/6nk/hbW
        cWXz/ezBc30NzXPGOpFFI6C/Uw==
X-Google-Smtp-Source: AGHT+IFLA/CIxbmsvmuWSrpKDShZC6V6vXLs3lxX1Dmv57MIgyNPYM0mdX/sp44i54mRWraeoWHmIg==
X-Received: by 2002:a17:90b:3ecb:b0:268:1f64:cefc with SMTP id rm11-20020a17090b3ecb00b002681f64cefcmr735024pjb.49.1692316744997;
        Thu, 17 Aug 2023 16:59:04 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 30-20020a17090a001e00b00263b9e75aecsm374450pja.41.2023.08.17.16.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 16:59:03 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, dmaengine@vger.kernel.org,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Jie Hai <haijie1@huawei.com>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Green Wan <green.wan@sifive.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Yu Kuai <yukuai3@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jordy Zomer <jordy@pwning.systems>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-tegra@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: [PATCH 06/21] dmaengine: moxart-dma: Annotate struct moxart_desc with __counted_by
Date:   Thu, 17 Aug 2023 16:58:43 -0700
Message-Id: <20230817235859.49846-6-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230817235428.never.111-kees@kernel.org>
References: <20230817235428.never.111-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1707; i=keescook@chromium.org;
 h=from:subject; bh=w8ccArCK59lLgZlEqE1v4MzImMqgGYgm/+wOZMSMxlo=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBk3rRAGAtj6QDi3SIiqD7IGrGC/+0Gb9g0S4VM8
 u1mMmM3RH+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZN60QAAKCRCJcvTf3G3A
 JqYDD/9/+1NFbYoLFAkSnMt+6wz7PrKIBUx8STNwFYd5uLkUDOxm+oYRPkP4DFdI1hDEam8anpu
 y9+IVtxhhyEqt/4mNDt8+9FNBIhzcvuNJuJpJ0nFALFYv8nhl13P/zs7SQ1xyHCLGToHg3qIUQY
 unQgnT0GPGBhgoqd0PlT9GoIPLWgvAopUg58S0v0OIzsgJWZO1gDpLLVfTiaEkysoR4QaIyY0Tf
 4HuqwDb3Wg0PUlSxnMi8WoIvZ23/AsEOEHerD8XkZKM+2AH2MTl54S6lJTH1xnz7xXNUa1jB3c9
 PvD1AuoczbYJ4PTTeVOqvkENjm2GG3ToHGqlGDsRGOFX8cqhCjbvPFR+6rgPWn7akaROfbszdzT
 AlNECT/TCNDtS+oXRgchrXfLns90wz9SiNpXVuxnWVVWNNMcc5GctK+cRF9c7+kOJTphcbDS5QI
 bpisH48oEtOPOZQO5iS/ucJ4tuFlKmA9+1EY4QYSUcr9N0Og/+Sz6AV5qbQyY8Cd4z/KF3g1jK8
 RF4QrfyW7zK+r0nIhITM2Ldoh2wTEn6/g6WbgST49AoGB/zXJJgLnveuswjG5rP4s8k7Aeo5XC9
 VNR067SFeZAGtJCkpUEAXZ1KYjafWfD7xO5/9mQhxYrn2vBkjwlhsNRz6alIogRUVGo2AbOldIj PpoxZOFiyCFqmxQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

As found with Coccinelle[1], add __counted_by for struct moxart_desc.
Additionally, since the element count member must be set before accessing
the annotated flexible array member, move its initialization earlier.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/dma/moxart-dma.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/moxart-dma.c b/drivers/dma/moxart-dma.c
index 7565ad98ba66..c1dd5716a46d 100644
--- a/drivers/dma/moxart-dma.c
+++ b/drivers/dma/moxart-dma.c
@@ -124,7 +124,7 @@ struct moxart_desc {
 	unsigned int			dma_cycles;
 	struct virt_dma_desc		vd;
 	uint8_t				es;
-	struct moxart_sg		sg[];
+	struct moxart_sg		sg[] __counted_by(sglen);
 };
 
 struct moxart_chan {
@@ -309,6 +309,7 @@ static struct dma_async_tx_descriptor *moxart_prep_slave_sg(
 	d = kzalloc(struct_size(d, sg, sg_len), GFP_ATOMIC);
 	if (!d)
 		return NULL;
+	d->sglen = sg_len;
 
 	d->dma_dir = dir;
 	d->dev_addr = dev_addr;
@@ -319,8 +320,6 @@ static struct dma_async_tx_descriptor *moxart_prep_slave_sg(
 		d->sg[i].len = sg_dma_len(sgent);
 	}
 
-	d->sglen = sg_len;
-
 	ch->error = 0;
 
 	return vchan_tx_prep(&ch->vc, &d->vd, tx_flags);
-- 
2.34.1

