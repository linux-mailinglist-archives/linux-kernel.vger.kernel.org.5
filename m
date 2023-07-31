Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91DB776926F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjGaJzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbjGaJyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:54:37 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8621E1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:54:17 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b9f0b7af65so4873581fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690797256; x=1691402056;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cxvMJvHLwBTrnKLZye8TDFSPJgpR7pa1aGrAgRySAk4=;
        b=rtxydgC1gFkvb5mqPWXFSGiFQRPsbQ0ZaibVcnD1NSUYqfMl0IbHDE0rCfdx3TSuyc
         4M1Z5QR+NtQATWMNhrJNKlnjdWRI4M7goXuhgKl+R00xg9rpExLyylcY8A7BSj3eoPHZ
         POI7qCIIzpTRxbdyu4uJ/jxh/lwh9R7B47azI8gKpNUh5Kr5s3PRNCBNVVAxd/Q0Rpbs
         tGnuL55lb6MdiLk8YfpzRgboQXBgiXSGCnE1WTB2nYGjyC81FTX8eqwAowB7h5FfJzKQ
         Oer64uWIj27ehrTEWAOB0u8KMCF05uQXQGLfPAXY87TF38kdnSPB2iMH5A0+XBbklU8m
         rZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690797256; x=1691402056;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cxvMJvHLwBTrnKLZye8TDFSPJgpR7pa1aGrAgRySAk4=;
        b=Yb7YPaKdolb1fFcxCFdzPBdIAhta1iUkmW/+LJ6D3qWs1K9wIRaD8MwT/SJNK3UNYi
         2A+hjDE+sCTAw7UkUovEwv15lsdU+hWVE33X27A8PstOiVgXrRDlYX5x0sPog3F0pxqO
         KweOidHUoivKWcQnqZm/LKgMBNz2PuNCBE7IdTjTbfiyPnjREGm/N9fgLdBvztXkYwlt
         Em1R0mh3SQHsT6+iv3U1VMtsJhFrHZUiY07jC+7m5k+bw85dnWDsbPMom2Ppzle2h89+
         TDysaUxB12BVQ0+JrhMjpoaZPJIQxg30gsW7v7aD4C49dMtCTBZKPuCGPDvEYoalFVBx
         iqhg==
X-Gm-Message-State: ABy/qLZl++G2YpOgzX6g1Rrd1q94zJHTFZ6r/s6NLqF0qN+e6K4K7ZDc
        f87SCmbfzK8Qs0uXZ1btmKdp7g==
X-Google-Smtp-Source: APBJJlE7wQhXoweE/t+BJZjOJ+eAu06Zax8HzFnpro0zdCZ7/Ym8zCBK2Y/a+Ib5XLFFPG0rO8fENw==
X-Received: by 2002:a2e:9a82:0:b0:2b6:da88:a2d0 with SMTP id p2-20020a2e9a82000000b002b6da88a2d0mr6613063lji.47.1690797255881;
        Mon, 31 Jul 2023 02:54:15 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id h17-20020adffd51000000b0031455482d1fsm12543726wrs.47.2023.07.31.02.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 02:54:15 -0700 (PDT)
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
Message-Id: <169079725498.195351.12929338822608058749.b4-ty@linaro.org>
Date:   Mon, 31 Jul 2023 11:54:14 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.6/drivers-genpd)

[1/4] soc: amlogic: use name instead of index as criterion
      https://git.kernel.org/amlogic/c/fadf18180022743ff74b1f6ca4f3cff462ddaddb
[2/4] dt-bindings: power: add Amlogic C3 power domains
      https://git.kernel.org/amlogic/c/83b03d62939c46c118a8d722f07ae03a87967b00
[3/4] soc: c3: Add support for power domains controller
      https://git.kernel.org/amlogic/c/77e2f4e3cbd5cde442d05a7bdb6cd01565bead6d

These changes has been applied on the intermediate git tree [1].

The v6.6/drivers-genpd branch will then be sent via a formal Pull Request to the Linux SoC maintainers
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

