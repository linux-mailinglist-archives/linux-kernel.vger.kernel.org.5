Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0740879BB53
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378842AbjIKWhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241463AbjIKPJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 11:09:27 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1025CCC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:09:22 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-31adc5c899fso4809063f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694444961; x=1695049761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lYXngHOzN75PoywV4+ppenCMkO0BtlnfambIk5nvgf0=;
        b=FO9nVqZD3/uKX1Yw25BRFDcSnCyFQuL3X32ZseOV1f884UzFQe3Op75dL+aivvLy5S
         DszBs7XWkCzpn7KRw02rzP7dc/aXudbFVmkDy/GjMUypF/GiMiCGCE5JdkMLG8zEKWuq
         LJoASmMVv7trW8JqxKACk3fB3RffvpFqKR/F2R+JjIgStS1QaL08+clhVyBnC4WsubqZ
         NSenjyTQW3eHl7hdJ9t+BzAG0/EIlhTU/hgxjhZT+2QwgaXAUMNd6KcIkF2Uw7s5vQOu
         mDKxODcCAEgFe+pd/Vce6i/y8IBJPKPUL4v0Yv7xwchIVhFTieUffRw8F5NovvicC3/1
         bXxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694444961; x=1695049761;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lYXngHOzN75PoywV4+ppenCMkO0BtlnfambIk5nvgf0=;
        b=GdgutwajIMCc3zmVoXsRjIGOzNrBHVgQI6LKm60WjfW8BooULvq6ixKVAHf4FSdvNY
         jRpnULI6gFRp4mTxfu8b165yp9Yj7MwDzF2PRQz1LehtYniIfITUoQa+izfmCCWUDD5b
         OVs+XaGyVdqhohrI7MDuKyrl3R6AvHEYAks0kB5mpxR3GsLUcSH/tXeSR30pws1UFDZz
         5KxWcXB2VMrh4TmdxtApRhYtFoxOiAAHif9+HvUMpOYxH6pBMs4rVHumjHSdXgw5hp5M
         ivnROLjHXMepAycMJv7V0Eo8A9U8mufdsrDQ4T9+dSjo6m0qI6nPpMiwkrCHQQQ0grvc
         N4RA==
X-Gm-Message-State: AOJu0Yzj9AW15pzJlMAGw9FJZpEOv8dlNWURU83LtziyaYKgEwEuPkbu
        MprOQWo0VYombybUhl/ZF0TaJg==
X-Google-Smtp-Source: AGHT+IGEvvxL2vFpAriiGl4G3wGQZ/xpQvVGJmjqo5OcJg4NKx2heACN+56vMiFmzWqgfcWcpoS0XQ==
X-Received: by 2002:a05:6000:118f:b0:319:6001:978c with SMTP id g15-20020a056000118f00b003196001978cmr8510755wrx.53.1694444961129;
        Mon, 11 Sep 2023 08:09:21 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id y18-20020a5d6152000000b0031f3780ce60sm10388691wrt.7.2023.09.11.08.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 08:09:20 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>
In-Reply-To: <20230829020404.4058677-1-xianwei.zhao@amlogic.com>
References: <20230829020404.4058677-1-xianwei.zhao@amlogic.com>
Subject: Re: (subset) [PATCH V3 0/6] Power: T7: add power domain driver
Message-Id: <169444496026.3944766.18031639855172350392.b4-ty@linaro.org>
Date:   Mon, 11 Sep 2023 17:09:20 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 29 Aug 2023 10:03:58 +0800, Xianwei Zhao wrote:
> First patch is that remove C3 some power domain ALWAYS_ON property.
> Second patch is that add driver to support power parent node.
> Third patch is that turn on power if initial power domain with
> "AWAY_ON" property state is off.
> 
> Other patchs adds power controller driver support for Amlogic T7 SoC.
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.7/arm64-dt)

[6/6] arm64: dts: amlogic: t7: add power domain controller node
      https://git.kernel.org/amlogic/c/5355699dabac3c97492a30e6e01820fcaae11218

These changes has been applied on the intermediate git tree [1].

The v6.7/arm64-dt branch will then be sent via a formal Pull Request to the Linux SoC maintainers
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

