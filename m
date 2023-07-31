Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1554769236
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjGaJsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbjGaJrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:47:47 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794FA10F4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:47:02 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-31771bb4869so4540065f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690796821; x=1691401621;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zClCjZjOdixGCLkxsyJvj3NbPUjrYERXcvMYfwjLNfE=;
        b=TilFRbTFqa4TuaX6WgCSre6+GR3T3GgCkO/0zcJ0BwEZiLsOO1AtT4uArKHRBiQadM
         TQybXelE1vzPKw3YOUBUYc6QQm2O75tInpgLqiCOnJ9WZFa7jD1keWuBYGEMB2RJkaz5
         fyJp+8t8V/MfyqbA2vAKKpHLoHg2ilPCGpv7I90w6h0AEzQAWEX1oIAhL7bM01dIWCxF
         NlBCPGN9FYkGOxMVf92bWa1U2U5xuQ8XGUhU+vEpIkV8GVXzHlcNIVY72SsLrIoXh1d1
         Z1vxty/Ycinf3Tef/hO/iwdwxekiw5pBge/LmCrfIyqcsgz0fYwhpyN1klMtZnXiKtzQ
         TWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690796821; x=1691401621;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zClCjZjOdixGCLkxsyJvj3NbPUjrYERXcvMYfwjLNfE=;
        b=S/PcmvhdN2lsEa9v2EEHTRRdUV/WnCD8gmj8W659Z5TRUF9izZR+KHTEc95r3RxwBm
         7Tgmfxc9yXXp8BqEIubFtHvEjy0Ad+kC1/YPw09Aq7uebxH6BifIelwfgua1kQNuCXnZ
         lyROjfm06FUhFsxHChzTsH402ns6QtRvnmthqlfEOdcAimfICLyHR7Kmr7HgY63LLE4z
         2+9fgxbi/Wr+FlOhVeMwPnRvBXhbIAO+Z1X9NTF2Vv6ufMAhTJP28zjSfm2bWImTKcB/
         G4xp5ZhmUrVeqDOnWCA/lB0NBuiN4HMPGAxxZVm6UTpvy0sspCapBx4dJdwEitDXZYL/
         rODw==
X-Gm-Message-State: ABy/qLZycL1whov7Ab+7+darY0Anlgrtymjom75wIafvZGYHJ0+c7cbL
        dIGyW+zfjGV3mO0+WbBdrm1fsw==
X-Google-Smtp-Source: APBJJlE+g5uUfGniF+8kFuxO1Nky2BcsSvbHb1jzL9PNTzoCO3wc1waETL2Y9ABFdvHQELPLFaSrNQ==
X-Received: by 2002:adf:cd11:0:b0:317:759a:8ca6 with SMTP id w17-20020adfcd11000000b00317759a8ca6mr8047426wrm.62.1690796821004;
        Mon, 31 Jul 2023 02:47:01 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id p9-20020a5d48c9000000b0031433443265sm12556878wrs.53.2023.07.31.02.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 02:47:00 -0700 (PDT)
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
In-Reply-To: <20230706091954.3301224-1-xianwei.zhao@amlogic.com>
References: <20230706091954.3301224-1-xianwei.zhao@amlogic.com>
Subject: Re: [PATCH V2 0/2] Devicetree for board AN400 based Amlogic T7 SoC
Message-Id: <169079681994.186625.5295354786398700202.b4-ty@linaro.org>
Date:   Mon, 31 Jul 2023 11:46:59 +0200
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

On Thu, 06 Jul 2023 17:19:51 +0800, Xianwei Zhao wrote:
> Add the board AN400 tree bindings based Amloigc T7 SoC.
> 
> Add devicetree support for Amlogic AN400  board based T7 SoC.
> 
> Changes Since v1:
>  -in memory node use properties "reg" instead of "linux,usable-memory"
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.6/arm64-dt)

[1/1] dt-bindings: arm: amlogic: add board AN400
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

