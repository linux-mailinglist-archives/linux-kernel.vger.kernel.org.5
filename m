Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0CF8769235
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjGaJsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbjGaJrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:47:45 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74083E5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:47:01 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3090d3e9c92so4487196f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690796820; x=1691401620;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BRAAlSEqORL6Se6LTybe1yHsw0jhZLERYrRRtVClc94=;
        b=k6EPxM3uLXMkqpzDJespFM5M355FTMELH0xEI+R8ZOTZAmxD+pqNtbLPQvAf20pjLA
         8xn2e/hoPTesm4A+6OCgtpW98BVI3IEetcC3S6QV7wug7Z2HXS+cjAnHix2u4+wb0DdZ
         tVo9pUMdZLRdHNxhNuBBqmPwQObIEz/1NlTdWmc926Qr0BmxPIt1wm3N1wLNY37fp7Ti
         QB8Xai9Y3tGyHMSBPLHK/+N3eJ+sNMDc1YlJAP8rqlCheWgvBZZonG4C6DVaO6QXBlrI
         8K7jHPbQXE7Xtuf5Qvp1QVqFmBibJNNiQw9wH/O317Q2uNIEjh2+8mtCxU7U6wt7AMOz
         GspA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690796820; x=1691401620;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BRAAlSEqORL6Se6LTybe1yHsw0jhZLERYrRRtVClc94=;
        b=HWbd+m11merL0yaZ64TuDs+jntZB2Fc+CdWEVILZFccZkOu5YfJMWAFYBrTaeHcGGR
         OPzhwcBeR5pqHV8HDK9pXjU39uSBq3X9vAtqBU+sddXhI75l3QTfDZajopJ0gpJIk7AV
         YbJeRAvTgU7e602BEjY+8zD1wBDEjhENk5woQRvR47UU7QlT85h9p41/OxmbeWuehej1
         BGH2HKnliJLPgoSkng2aNEJHwaHGjiXvbfhp1mngrNv8ig2BYxvznB1gzRBrDKK4oSho
         QcYbQjMVJDq8RqQfagIcyfk+Z2VbyZpjhvF0cKmmnkD2i/QkCUjwF9x4299Er9+lFZQG
         //Vw==
X-Gm-Message-State: ABy/qLb30uDdwGDzA5Ad9gWaCuPZoBTSZxkfCOLGVkf33zTuY0zAPD4i
        jNq6MXwq3QvIeb61apH7VlGjVA==
X-Google-Smtp-Source: APBJJlGLaqSOORf3q94JYqUiTa1G4BtmOVF6jOvRxVk2rdvsCMTJOJ+JF6gOj4flgXIWkHeKe7gEAA==
X-Received: by 2002:a5d:4c43:0:b0:314:3740:7f69 with SMTP id n3-20020a5d4c43000000b0031437407f69mr8864082wrt.37.1690796819858;
        Mon, 31 Jul 2023 02:46:59 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id p9-20020a5d48c9000000b0031433443265sm12556878wrs.53.2023.07.31.02.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 02:46:59 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
In-Reply-To: <20230704031636.3215838-1-xianwei.zhao@amlogic.com>
References: <20230704031636.3215838-1-xianwei.zhao@amlogic.com>
Subject: Re: [PATCH 0/2] Devicetree for board AN400 based Amlogic T7 SoC
Message-Id: <169079681850.186625.7568524984807296520.b4-ty@linaro.org>
Date:   Mon, 31 Jul 2023 11:46:58 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 04 Jul 2023 11:16:34 +0800, Xianwei Zhao wrote:
> Add the board AN400 tree bindings based Amloigc T7 SoC.
> 
> Add devicetree support for Amlogic AN400  board based T7 SoC.
> 
> Xianwei Zhao (2):
>   dt-bindings: arm: amlogic: add board AN400
>   arm64: dts: add board AN400
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.6/arm64-dt)

[1/2] dt-bindings: arm: amlogic: add board AN400
      https://git.kernel.org/amlogic/c/015623ec05f96b1614ec2753d25f36743c17c530
[2/2] arm64: dts: add board AN400
      https://git.kernel.org/amlogic/c/6f048cc7a635b8736b4c7ae0e5230a92e3e648eb

These changes has been applied on the intermediate git tree [1].

The v6.6/arm64-dt branch will then be sent via a formal Pull Request to the Linux SoC maintainers
for inclusion in their intermediate git branches in order to be sent to Linus during
the next merge window, or sooner if it's a set of fixes.

In the cases of fixes, those will be merged in the current release candidate
kernel and as soon they appear on the Linux master branch they will be
backported to the previous Stable and Long-Stable kernels [2].

The intermediate git branches are merged daily in the linux-next tree [3],
people are encouraged testing these pre-release kernels and report issues on the
relevant mailing-lists.

If problems are discovered on those changes, please submit a signed-off-by revert
patch followed by a corrective changeset.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
[3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

-- 
Neil

