Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2410768914
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 00:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjG3WTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 18:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjG3WTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 18:19:50 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74E010F4;
        Sun, 30 Jul 2023 15:19:48 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3178dd81ac4so2508560f8f.3;
        Sun, 30 Jul 2023 15:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690755587; x=1691360387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wc/+C+AJRRP3wZqyNPfzz3Cgo44jHnLGmmlbexMEhKA=;
        b=cl5onc+TkxuEATcjD6uyVY7nH/Vz7ZkRqu9JxWsgfv4SoPnzoPuj4UYgsSxMX4DmhN
         EbKH4KNoyGqNS1sDmy9WPnVudE7zyM5LAixHPtl9LhQN4/Y11NaWw5hciNNR9xqmFpDI
         jUxLHWGe2o7k91QBJv2Dj0G7vecaM5dVGMn3rpNojwwl/nBKXvfX62Zgd2Wk+PNHMd5F
         lciKG1RUQTDhjvSskhmAgEEOj5rAaI9Raeqr53hWDgXglo54RMDQ5w9HCfxSz+ehAeUe
         14kbku6uFYUNnBKXbK5+sabAjDsDY50Q+XhPkTCq6JzLn9+4yXYHCvueRbhilg/sLmRN
         sVRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690755587; x=1691360387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wc/+C+AJRRP3wZqyNPfzz3Cgo44jHnLGmmlbexMEhKA=;
        b=VIR4vOpdHsB7cSGOubhaBTOBtmakvbTRkqba88ukJvOsQJEXZKYOoa7yjX20VXi2+7
         hW7j5A+V2mBf+Y3jhKnc3t5Yxd83e7ZWxEIlcvr5hXGSY7ylpXegViF2vrY3zp56X/Pa
         /3Djds66tsUDRE4MiSJJ1B2VC7JrtFvRBuBC4ZNlTmjP1ZeOytzjxLH2f/f1YO5Hh/WT
         SyJOrOPjxa5S8EXXd2AUmLDR94HAdTrJr2ZeB4Ripll2RV6Y68PPWq9gN3saxA0uUOzY
         eh0lqbXec/TS5C2ML4sFbdQ04FSFkV32Ccv3CT71y8DOV8nMIJNnWmckgk+gsPhfTJ9K
         20pA==
X-Gm-Message-State: ABy/qLZOa2VgkEIjP4JjH2J12b3NGWcVTjuNeXKYJp1oMXLuwIn0ZQrH
        1pJnqa2rtUB32orfx03s3mwyAfe0pSPsWxHR
X-Google-Smtp-Source: APBJJlGn9QQ0KC3d+6nE6FU7hS1U6dLdyswmnOJX3ZD6J+r5QpKVi1LURDmwkv8hjOYhZJhMt1p4yQ==
X-Received: by 2002:adf:e50e:0:b0:317:57f0:fae with SMTP id j14-20020adfe50e000000b0031757f00faemr6721588wrm.63.1690755587148;
        Sun, 30 Jul 2023 15:19:47 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id e5-20020a5d5005000000b00311d8c2561bsm11020850wrt.60.2023.07.30.15.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 15:19:46 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-iio@vger.kernel.org, Maksim Kiselev <bigunclemax@gmail.com>
Cc:     Maksim Kiselev <bigunclemax@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Leonard =?ISO-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Maxime Ripard <mripard@kernel.org>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v8 4/4] riscv: dts: allwinner: d1: Add GPADC node
Date:   Mon, 31 Jul 2023 00:19:37 +0200
Message-ID: <2150270.irdbgypaU6@jernej-laptop>
In-Reply-To: <20230619154252.3951913-5-bigunclemax@gmail.com>
References: <20230619154252.3951913-1-bigunclemax@gmail.com>
 <20230619154252.3951913-5-bigunclemax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 19. junij 2023 ob 17:42:27 CEST je Maksim Kiselev napisal(a):
> This patch adds declaration of the general purpose ADC for D1
> and T113s SoCs.
> 
> Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>

Applied, thanks!

Best regards,
Jernej


