Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F47778224
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 22:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbjHJUZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 16:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235758AbjHJUZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 16:25:21 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34A12735;
        Thu, 10 Aug 2023 13:25:20 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37AKP4hU027029;
        Thu, 10 Aug 2023 15:25:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691699104;
        bh=LlM4ebmHJM3OSNZTcjpf5OxbeJgDHb88khhaM1SpUmk=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=W7rrHvPZ6yLGXjVOAjztdXjjgJIPcYxSE7MuWdtGiJ7LM+Aqty4PiPEpDUupWSPUv
         hoX3fkShO6po+Kics77kcBhOEKqtovu5KmlNnY9/FRAiWWi/QhoR1AE2xtW1hLkrub
         4Jh9LeLoKF9Tq4WmJkwop8k5BRl/hEv/lACkcjoI=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37AKP4I4012077
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Aug 2023 15:25:04 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 10
 Aug 2023 15:25:04 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 10 Aug 2023 15:25:04 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37AKP4HT021038;
        Thu, 10 Aug 2023 15:25:04 -0500
Date:   Thu, 10 Aug 2023 15:25:04 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Kamlesh Gurudasani <kamlesh@ti.com>
CC:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH v2 6/6] arm64: defconfig: enable TI MCRC64 module
Message-ID: <20230810202504.ujmjaqos5tfqlmna@plentiful>
References: <20230719-mcrc-upstream-v2-0-4152b987e4c2@ti.com>
 <20230719-mcrc-upstream-v2-6-4152b987e4c2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230719-mcrc-upstream-v2-6-4152b987e4c2@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 00:58-20230811, Kamlesh Gurudasani wrote:
> K3 devices include MCRC64 engine for crc64 calculation.
> Enable module to be built for K3 devices.
> 
> Also enable algif_hash module, which is needed to access MCRC64 module
> from userspace.
> 
> Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
> ---

There are few things to improve in this series, but we can discuss this
as part of defconfig merge

See thread: https://lore.kernel.org/linux-arm-kernel/ae2ad056-96de-41b7-8df4-1d9c0f5c469b@app.fastmail.com/
for additional info.

K3 devices is too broad, you want to specify specific boards that will
benefit out of this.

I suggest to keep this as "DONOTMERGE" to indicate this should'nt go via
subsystem maintainer tree (most maintainers are  aware of it, but
explicitly calling it out helps keep things sane)


>  arch/arm64/configs/defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index bf13d5c46578..4d555a125315 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1535,6 +1535,7 @@ CONFIG_CRYPTO_TEST=m
>  CONFIG_CRYPTO_ECHAINIV=y
>  CONFIG_CRYPTO_MICHAEL_MIC=m
>  CONFIG_CRYPTO_ANSI_CPRNG=y
> +CONFIG_CRYPTO_USER_API_HASH=m
>  CONFIG_CRYPTO_USER_API_RNG=m
>  CONFIG_CRYPTO_CHACHA20_NEON=m
>  CONFIG_CRYPTO_GHASH_ARM64_CE=y
> @@ -1558,6 +1559,7 @@ CONFIG_CRYPTO_DEV_HISI_ZIP=m
>  CONFIG_CRYPTO_DEV_HISI_HPRE=m
>  CONFIG_CRYPTO_DEV_HISI_TRNG=m
>  CONFIG_CRYPTO_DEV_SA2UL=m
> +CONFIG_CRYPTO_DEV_TI_MCRC64=m
>  CONFIG_DMA_RESTRICTED_POOL=y
>  CONFIG_CMA_SIZE_MBYTES=32
>  CONFIG_PRINTK_TIME=y
> 
> -- 
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
