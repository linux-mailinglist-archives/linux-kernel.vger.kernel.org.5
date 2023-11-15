Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817807EC4F6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 15:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344179AbjKOOSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 09:18:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234172AbjKOOSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 09:18:50 -0500
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40CFDAC;
        Wed, 15 Nov 2023 06:18:47 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id a1e0cc1a2514c-7bae8dd095cso2537090241.3;
        Wed, 15 Nov 2023 06:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700057926; x=1700662726; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RKXWWYLOboqOH2gLGDOT9HKU3exX5nUOcx/sNGbdXC4=;
        b=ZmfQT2KOC8iW8RSIdG6dHUccuEkrCCQPacIfIf1EbRUm8X2Q1OSeKgfBzK773SkR+J
         Glgq8TBW6xlp1EgwXDe+pLzeMCL3sCcRXQPOYrRYZg40uR2hWBklGhlreGKNGTbZTbLz
         mcgL5oR5Rlf6aPT+5+yr9ofi18CKpPrcdTf44sj/GJOxnNcsR+FAJMDPo4fIRArV/O2n
         wb1Ru9ODZTdHIuMMEBZJrEGBZPTnFcIKDyeIY+XxwqKpA4T8VWLoB0eejPW13vhtWyBB
         NoNKq32rcT707/FXueoJRRqEnAlLvHsSDOSEr5xpTISk0ry7MfVmcxLiDfcAvKaG1Jcc
         98zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700057926; x=1700662726;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RKXWWYLOboqOH2gLGDOT9HKU3exX5nUOcx/sNGbdXC4=;
        b=T2Btv5BfWfcm+8vPNhFubfXZYy3wMOwBVVaSE6V8okthfjBHVlB0ALnhLU/zOBZk4M
         FxT7bHWg+Q/e+wGc10Hh01oJ5yome1Jl6wrA8jJN2bJXEz7BZ/xrcjDQwSsa541YAKZT
         ObrFsmONXtQgaJOPU7B9KYCMdbKS26zuFKIa0uEXPAPrk5YBq4iAL2c8VrD8J7gB9rEk
         2u+MuI7f9csIr0C/7JB163jgenzctqaK3L5VINUeBoejr1dAttvg5L4K9zoDoThiYF2F
         Jhj70XnTC2QEeGPmqb6rbBtLSsBKiMtHQfnplZKjE9LgoEtdOTeSgkaGmjqAo++W8OFx
         Dt9g==
X-Gm-Message-State: AOJu0Yy1F7z/3tyPluEpflVP1JRm5UdbQOw0TPTkDqWah7t91cyZGdq4
        G2QBvFO0FNCPxJV5Gaxo2wfrgFRYtSqxB53Lz8uGIv0SA0vQy6doe9s=
X-Google-Smtp-Source: AGHT+IE5bw2YZTFycs9t3VUp8Wvnd9VcdvPw6CxJKVxfflhq22HIjFzDvfGzKNeDUgERqwOuuJHcqbP4QpTC/nkzm6M=
X-Received: by 2002:a05:6122:2007:b0:4ac:22c7:89d5 with SMTP id
 l7-20020a056122200700b004ac22c789d5mr13880061vkd.2.1700057926242; Wed, 15 Nov
 2023 06:18:46 -0800 (PST)
MIME-Version: 1.0
References: <CACDmYyf4hxbuw+cpKqEDnqmHpS9yPXuE5MPD5_XZ3hjmYuViUQ@mail.gmail.com>
 <a3e35d3b-906a-4540-924c-0103cf32efa4@linaro.org> <CACDmYydnLQd0n9ACnTQ6P4wYf38eMzokyHrF7r6LisG4oTFtyg@mail.gmail.com>
 <5cd19f5e-baa6-47da-8730-fe0ddedff364@linaro.org>
In-Reply-To: <5cd19f5e-baa6-47da-8730-fe0ddedff364@linaro.org>
From:   Legale Legale <legale.legale@gmail.com>
Date:   Wed, 15 Nov 2023 17:18:33 +0300
Message-ID: <CACDmYyeBbGVPxLh+dmWus=BEiM6rp-1Qn17_RhSyDywrWf8uLw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: ipq6018: add QUP5 I2C node
To:     "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

update again:

---
 arch/arm64/boot/dts/qcom/ipq6018.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index e59b9df96..822ac51a0 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -506,6 +506,21 @@ blsp1_i2c3: i2c@78b7000 {
                        dma-names = "tx", "rx";
                        status = "disabled";
                };
+
+               blsp1_i2c6: i2c@78ba000 {
+                       compatible = "qcom,i2c-qup-v2.2.1";
+                       #address-cells = <1>;
+                       #size-cells = <0>;
+                       reg = <0x078ba000 0x600>;
+                       interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>;
+                       clocks = <&gcc GCC_BLSP1_QUP6_I2C_APPS_CLK>,
+                                <&gcc GCC_BLSP1_AHB_CLK>;
+                       clock-names = "core", "iface";
+                       clock-frequency = <400000>;
+                       dmas = <&blsp_dma 22>, <&blsp_dma 23>;
+                       dma-names = "tx", "rx";
+                       status = "disabled";
+               };

                qpic_bam: dma-controller@7984000 {
                        compatible = "qcom,bam-v1.7.0";
--
2.42.0

On Wed, 15 Nov 2023 at 17:16, Bryan O'Donoghue
<bryan.odonoghue@linaro.org> wrote:
>
> On 15/11/2023 13:58, Legale Legale wrote:
> > + reg = <0x078ba000 0x600>;
>
> This still doesn't look right.
>
> ---
> bod
