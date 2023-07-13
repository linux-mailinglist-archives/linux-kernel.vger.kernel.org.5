Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F651751E40
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 12:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234370AbjGMKGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 06:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234614AbjGMKFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 06:05:54 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F722D61
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 03:05:47 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-992dcae74e0so81170766b.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 03:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689242746; x=1691834746;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3o51EUVcuodqc0XkTYcL4bWCMRmfM3v1NqqP+NGxBbY=;
        b=saErMT1eYfuFzYCkg/HCcOysEREdt8zBN/bD8sxNULjrgFtU8eaB77NW2JLv1SfCUB
         U37hOTZQNnqze1nRbqPt+MyCGjk9Y1Yq9ZND9kSVpGynMhFoJcq8SiF+CFNC4dnI5y06
         NeX7x88IR5peJoZLrgJaKA9+S7HjrOS0vxWDB5La0XS7wBCq25P7BO1r0QewgNDIlSEe
         VH2q5IotsM4YR9qsp8lzg9l/YXr2fWfKRR+EtD+X/YdplhioA51oWWCv+PBe/Njb1Kfs
         fupOShSexfcMbdaIjndMnzTYWcsPjE9+Pq8E6/yeILPC1jcsDlGRD/XHeDTZQZ2wwMd9
         +lqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689242746; x=1691834746;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3o51EUVcuodqc0XkTYcL4bWCMRmfM3v1NqqP+NGxBbY=;
        b=VB5zMqjTxlpgR/KG/VTcAxn9yN+Lz6Ob+AcT6IOMU9YBoQe6ZCTvTZFB/Ix1QKhwHq
         pSl4Lo5GCTsMp+pzKQ2/ZZ5FkcsRIgFB7OoCyQzGRufzeMEnJ2WkIwIDpHpLxZXwpYsD
         U6j1JzXDplbHWJouatz3juRcqv9rb217dLqFezMtbnzo6XJn9a5dTjI2uCccdjT8AgI7
         zgJ5ECUjE2fJH4F8hjrWl8UZadHBiIpyzn8KNs0YDTlkVQzruOgWcPskb45WR/ux/Rsz
         J/GM3FS1tEBxqNEr0hnFWGUYdJc9dRFxIDh7Tj18t+o/yjqZtDZEZUdWcWFUR9Pt5Y6q
         720g==
X-Gm-Message-State: ABy/qLbrcLHCMJEjsVpg91b0ZJiXLd34NlYbpnw14xjA8HKQN4SLU4fk
        uV4myuaFWwOD4jt298Tri/2SWw==
X-Google-Smtp-Source: APBJJlG8tz5eUlBbh0OW8ZQUxodptZIofJVNSgnH2r+KnFLsU0smyZr36vQMsYTW8oqlhJt4GtiZGg==
X-Received: by 2002:a17:906:739b:b0:993:d5bd:a75e with SMTP id f27-20020a170906739b00b00993d5bda75emr1008632ejl.6.1689242745788;
        Thu, 13 Jul 2023 03:05:45 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id qt25-20020a170906ecf900b00992ab0262c9sm3780517ejb.147.2023.07.13.03.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 03:05:45 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Yangtao Li <frank.li@vivo.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230706040504.34057-1-frank.li@vivo.com>
References: <20230706040504.34057-1-frank.li@vivo.com>
Subject: Re: [PATCH 1/8] nvmem: sunxi_sid: Convert to
 devm_platform_ioremap_resource()
Message-Id: <168924274486.15577.2601617976381408054.b4-ty@linaro.org>
Date:   Thu, 13 Jul 2023 11:05:44 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 06 Jul 2023 12:04:57 +0800, Yangtao Li wrote:
> Use devm_platform_ioremap_resource() to simplify code.
> 
> 

Applied, thanks!

[1/8] nvmem: sunxi_sid: Convert to devm_platform_ioremap_resource()
      commit: e4ccbdc5f82463e014b6b9072f206f80326e61e9
[2/8] nvmem: brcm_nvram: Use devm_platform_get_and_ioremap_resource()
      commit: 37bda099309f2c7c5a75113f43baf1ec3feeee14
[3/8] nvmem: lpc18xx_otp: Convert to devm_platform_ioremap_resource()
      commit: 8584695d9ad95246e79d3470f97f16578eb3c2f0
[4/8] nvmem: meson-mx-efuse: Convert to devm_platform_ioremap_resource()
      commit: b12a4928e60f0e683b1a8ccd317031de23a1679f
[5/8] nvmem: rockchip-efuse: Use devm_platform_get_and_ioremap_resource()
      commit: c169b0d3f79a2c26cbb1233948ea374b7b7c8ec6
[6/8] nvmem: stm32-romem: Use devm_platform_get_and_ioremap_resource()
      commit: 0d7713aa08dbd96d37f1fc33610b2cfcff87fed2
[7/8] nvmem: qfprom: do some cleanup
      commit: 4156cae2936605e982ad671d1078d41edf79875b
[8/8] nvmem: uniphier: Use devm_platform_get_and_ioremap_resource()
      commit: 17340c6c425fd0c29c75ee682742258955515a33

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

