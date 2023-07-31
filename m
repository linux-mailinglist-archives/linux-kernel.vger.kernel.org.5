Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB72C769239
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbjGaJsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbjGaJrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:47:49 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CE2198B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:47:04 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-31771a876b5so3559776f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690796823; x=1691401623;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B3jeQqtdJ+xfjOfxyUM9KLeeRJlgR/RPuZkZZLraWVo=;
        b=Lcy7iZWcAKSK7Co1/sU6mHmXnehE48FMUKNb6F4F2PKRo0seDDTM68ow+2oz/V2zWL
         8XarAdfAzRsuk1BTXZJaW7ltrFHmWZF0phNBMfXWVi2HSE36Z0elazDEyeKiAhxHZXG0
         kWsGFpMbtbjUhiUHAHz1xg1VLSAjLhCCG1c/qBlQkEIk5RF5muyVTChYaz5HP4cf3wj7
         C5ZnqKir/LA1mSrK4cF1KeywFwGiRt+cGP9vV+nOEiLWA2J+0+OCAczky3FRZWSkO58m
         7fjaP3Dy7J694lOb2DV7O39D+G9XFoOtTdnqzQpZaiNtMsBuwthfjadrhNHvXwjyENDV
         DkPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690796823; x=1691401623;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B3jeQqtdJ+xfjOfxyUM9KLeeRJlgR/RPuZkZZLraWVo=;
        b=XKMVYqxJSN5zAsokjEzsd4ZRX3WvLbv526UKH23WLXB7naRgg7wQaLMNSwhopFjg/Q
         FPnzVcVSl+UH2BL2CpJmvXosHYm5WkU2D6hDjVC7qc40Ohl9DxS51ZuPGIKqToecEobm
         o3tZnB97ASJADziWrdp3CxhTGB8wpORwhZNvnzvwawaiaLS6hoeUY4wlzv1ueB1/LNOo
         0E3dgWaTe4k2khlX9tr/nhClTxSrwJxBQ5QWZmLcelj6wwKyVJ15xzhqIfpjFcUDHD3u
         G2H68+q66YeKhu6p7KEhpJpeaUUmY6gwEX2djF5KrdPdiV1tsohgaHKOs6emrUXHTrLX
         b3FQ==
X-Gm-Message-State: ABy/qLZuhCtD0yOscEFDVqKYoPPMww6WBAGL1Sy/xoDbsiPzQrHi9Ifa
        /LBol45f/v2q4R2iyzyEcu294Q==
X-Google-Smtp-Source: APBJJlE9GV5VXePjkzprQQPzxJuy0/dp3j7sdBNJqwP9u2j2XDsIsGtHGZFenkjZpzlvYoHVQHLPiA==
X-Received: by 2002:a5d:5145:0:b0:317:5fef:1bf4 with SMTP id u5-20020a5d5145000000b003175fef1bf4mr6369009wrt.53.1690796823332;
        Mon, 31 Jul 2023 02:47:03 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id p9-20020a5d48c9000000b0031433443265sm12556878wrs.53.2023.07.31.02.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 02:47:02 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>
In-Reply-To: <20230707003710.2667989-1-xianwei.zhao@amlogic.com>
References: <20230707003710.2667989-1-xianwei.zhao@amlogic.com>
Subject: Re: (subset) [PATCH V2 0/4] Power: C3: add power domain driver
Message-Id: <169079682229.186625.2257818167689381488.b4-ty@linaro.org>
Date:   Mon, 31 Jul 2023 11:47:02 +0200
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

On Fri, 07 Jul 2023 08:37:06 +0800, Xianwei Zhao wrote:
> First patch is that Use 'name' instead of 'index' as criterion.
> The  variate 'index' could be equal to zero in some SoCs. Such as C3 SoC,
> PWRC_C3_NNA_ID be defined zero.
> 
> Other patchs adds power controller driver support for Amlogic C3 SoC.
> The power domains registers can be accessed in the secure world only.
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.6/arm64-dt)

[4/4] arm64: dts: add support for C3 power domain controller
      https://git.kernel.org/amlogic/c/22a9b2a488c3f0937fe0c57c96176cbea0953c20

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

