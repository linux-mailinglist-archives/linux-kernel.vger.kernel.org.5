Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D658D769284
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjGaJ6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjGaJ5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:57:40 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D60A173E
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:57:13 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-314417861b9so3581818f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690797431; x=1691402231;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NzAUT/ZDau86t8TFCapt9e4TK2GEcNG0/asajNbvhAY=;
        b=erfQOYF/A3fjkJkXyUaO1epcPX2oVaro2+DPnPMOKL5pWklugRjasqvnVdZ+bCY/Xm
         l9AnlBv/HYFrYMznWluqDH2YO7+2gGiyDQ2Om1NhlHwUqWF0za2bMMxyoX9JhCAc/mcN
         AnqNrZcdA422DZR3rX66O8hAp/wbe7XIH2cDCyqSGElxWc4X+etS1dmJHjqbJF0Ylf4k
         c0IjGLqtIojuimzukEi+Cnhz/2p6u6SDgH0VoP8i3NaEuCBEGTceY8DdMoObzhjC8CPF
         grI6B0Kzo8bZQ1uLTx85urj8p72yAjXNIJwmYWM/0aUzct49w7Y5zdEMLwk43iPiRDLA
         eFpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690797431; x=1691402231;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NzAUT/ZDau86t8TFCapt9e4TK2GEcNG0/asajNbvhAY=;
        b=VSqNKHZ2BAQXr74eo2SY6kHRMwGn7LeNHR2rB0Nbiahx729F1/Ok+ZQINl+H1tU42/
         thcYLY/HjaJVs4nioCXZKoL2R9b99oEUc2K2qLIRO35gFbf6lwnGA2ywHkLBUvSDIqm9
         8KTXSuFbi8F2PLY+rFS35Pej/i4dSL3hytGE0Jzepdx2h2CmeZt2sigsuasO5W8EzvoO
         kMgqcpwQJAVWIjCxF8ASim05beHolQL6c2y3mQNnXV16xjEhZu/jVY+c3YL77ArcuC++
         GBNx6ZJ+/uTCySZh3zF1sKXiYWx2svYguF7lYbS9sFkIKr6Gq2Iw7g+Hhkdzq687N0Vh
         DfhQ==
X-Gm-Message-State: ABy/qLaU+PqvHffy5N+gwWmPFjvp0ujxBNSdtmBvivtPEi0bahlssUG9
        Ce/PBdce7BtUcKKlmDhJ7UHxrw==
X-Google-Smtp-Source: APBJJlGZSmVvYv3ec6G3JAUBNm4NksXaZ+h1NntarAk2oAYLTlrujbke1RIMcvjHGtocXLeP8Hwjnw==
X-Received: by 2002:a5d:5101:0:b0:317:5af3:caa4 with SMTP id s1-20020a5d5101000000b003175af3caa4mr6521173wrt.38.1690797431128;
        Mon, 31 Jul 2023 02:57:11 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id s7-20020adff807000000b00313e2abfb8dsm12506312wrp.92.2023.07.31.02.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 02:57:10 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230714175124.4066972-1-robh@kernel.org>
References: <20230714175124.4066972-1-robh@kernel.org>
Subject: Re: [PATCH] soc: amlogic: Explicitly include correct DT includes
Message-Id: <169079743023.199115.14539344901147605814.b4-ty@linaro.org>
Date:   Mon, 31 Jul 2023 11:57:10 +0200
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

On Fri, 14 Jul 2023 11:51:23 -0600, Rob Herring wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.6/drivers)

[1/1] soc: amlogic: Explicitly include correct DT includes
      https://git.kernel.org/amlogic/c/83147971318a3adeb48e75a61722b0f2a60a4b9a

These changes has been applied on the intermediate git tree [1].

The v6.6/drivers branch will then be sent via a formal Pull Request to the Linux SoC maintainers
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

