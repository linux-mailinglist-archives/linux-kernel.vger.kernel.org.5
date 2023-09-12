Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64EE79C83E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbjILHed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjILHec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:34:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B84B9;
        Tue, 12 Sep 2023 00:34:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6DE0C433C8;
        Tue, 12 Sep 2023 07:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694504068;
        bh=xC6q3HYiwW9CEGzJvj/sjpQyCTVoGfRxTt9DU15lsZM=;
        h=From:To:Cc:Subject:Date:From;
        b=B36S8DTT292C3Y/z3w0PZdqkISNsor2tvJRyDzHkyvoejCDbdPUO+eAs2CVWuy3Ni
         HkDmMaRwCxbfPegnuc7asX99szOYHD/gq/kH9BcwqE5POyG1S0U+QCp4bvbC61Dleg
         zzdvafPvBPod5m5Yqgdb6ZRgtEr8ySKIhNnbIQYjceYnfIZWQueqxgs0Gc4oqFIjgn
         IQkacC0hQf0mCsutjBAROzg2nv9GRxjqgCyNTo2AUK+CFzV7H2L13Yvbzq4oI8flJE
         I8VnE/BeSrM3RcnwLyOuUh0E9ecDT66E71MzgOqRFIwkBKxBxAiA/4tS5LD1mwXfXT
         yWSKvvGQhV6Lg==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Drew Fustini <dfustini@baylibre.com>
Subject: [PATCH v2] riscv: dts: thead: set dma-noncoherent to soc bus
Date:   Tue, 12 Sep 2023 15:22:32 +0800
Message-Id: <20230912072232.2455-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

riscv select ARCH_DMA_DEFAULT_COHERENT by default, and th1520 isn't
dma coherent, so set dma-noncoherent to reflect this fact.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Tested-by: Drew Fustini <dfustini@baylibre.com>
---

Since v1:
 - rebase on v6.6-rc1
 - collect Tested-by tag

 arch/riscv/boot/dts/thead/th1520.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index ce708183b6f6..ff364709a6df 100644
--- a/arch/riscv/boot/dts/thead/th1520.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520.dtsi
@@ -139,6 +139,7 @@ soc {
 		interrupt-parent = <&plic>;
 		#address-cells = <2>;
 		#size-cells = <2>;
+		dma-noncoherent;
 		ranges;
 
 		plic: interrupt-controller@ffd8000000 {
-- 
2.40.1

