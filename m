Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4B577F20F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 10:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348880AbjHQI05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 04:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348930AbjHQI0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:26:52 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92022D57;
        Thu, 17 Aug 2023 01:26:51 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51bece5d935so9600650a12.1;
        Thu, 17 Aug 2023 01:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692260810; x=1692865610;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rlMF7ovViqq0ugED3FJJqRatkLdBYCCpmtAAJM1UKiU=;
        b=WbPo41i8cd8rXCJCH7lp5U8AZvrgq8oK6KGNF9B9RA3rxb4kM4wuYqU+7Y8chQBvE3
         HhTX0hcbfOSdgnbhITIebmMXMwbKq83qdIlYxf5U+cDVJm8HyWXP4Hm6jxfDXd6r4U0K
         Rnf+v+pEaOSGR4AtBcCgbDTo1frIB6bTL8Sg+0o4puPXlCGDqCRb+9ADLIQCxWHn+2qw
         DTpv0Iwb7qjjuHG881e10e48pKZTnEvkldQMqZ0aMMxAG4A26kMzOuBr02drvFaDn/ip
         JTfuMy77HEH2undGaGzUOW8kIFd87HE/7D24yThDXgGZPrvRgDBGktJzRv0e9dEUvPJ2
         0J0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692260810; x=1692865610;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rlMF7ovViqq0ugED3FJJqRatkLdBYCCpmtAAJM1UKiU=;
        b=PLFI0fwpr5BnLwmdWMdiFM0xyXIC0JgmRZ3RM+t7fsfnu+kXXsr8wj1LJnhOq9R3SY
         elfz57otInxa2DOh5Yae4GGfdeXSFJOgJCKGCptWVgUThesXPNwYbTIWGDszCFjv8DL5
         M6jLbbZllTv7v0zjc0MyB1PMu7r5ZuE6UJw7CWQDMtZqty3hK7IueStAcZGFPsfoRffF
         rG4BsrgJxGo5LcYGvmkRwH7oU7agbd1Bw9qqRudmTZw73mB7+BRkPPsCDY2XHarQ+/At
         kze+5oSZhc6a2Vu6HfidiTgaw6yx8Naw7ZV6X44k964acho9nij/eJ3nePE53zPppesB
         YWrA==
X-Gm-Message-State: AOJu0Yyv183arMFmAHDaULhzPCqYkz+pmLVqQV/IWyywrW9FtysjkWdJ
        WvXN3Dn/bmZhdNguEuDME7w3zz6NL2Ebfe3HBmU=
X-Google-Smtp-Source: AGHT+IEwUb269mLv8B048N5rOpTXPkPv81uaXg2r0melQjmsUDZLA2j3D1qFboxx371HLTQyJKsI5SWjYOFvVdx14Fk=
X-Received: by 2002:aa7:cd13:0:b0:523:19f0:b113 with SMTP id
 b19-20020aa7cd13000000b0052319f0b113mr3840035edw.31.1692260809792; Thu, 17
 Aug 2023 01:26:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230711162346.5978-1-cixi.geng@linux.dev>
In-Reply-To: <20230711162346.5978-1-cixi.geng@linux.dev>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Thu, 17 Aug 2023 16:26:12 +0800
Message-ID: <CAAfSe-sorWk5zhzevAoxwbiyk2YoDU9d47FLXcT43q1ZwHdvdg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: sprd: fix the cpu node for UMS512
To:     Cixi Geng <cixi.geng@linux.dev>, SoC Team <soc@kernel.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        cixi.geng1@unisoc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2023 at 00:24, Cixi Geng <cixi.geng@linux.dev> wrote:
>
> From: Cixi Geng <cixi.geng1@unisoc.com>
>
> The UMS512 Socs have 8 cores contains 6 a55 and 2 a75.
> modify the cpu nodes to correct information.
>
> Fixes: 2b4881839a39 ("arm64: dts: sprd: Add support for Unisoc's UMS512")
> Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>

Acked-by: Chunyan Zhang <zhang.lyra@gmail.com>

Thanks,
Chunyan




> ---
>  arch/arm64/boot/dts/sprd/ums512.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/sprd/ums512.dtsi b/arch/arm64/boot/dts/sprd/ums512.dtsi
> index 024be594c47d..97ac550af2f1 100644
> --- a/arch/arm64/boot/dts/sprd/ums512.dtsi
> +++ b/arch/arm64/boot/dts/sprd/ums512.dtsi
> @@ -96,7 +96,7 @@ CPU5: cpu@500 {
>
>                 CPU6: cpu@600 {
>                         device_type = "cpu";
> -                       compatible = "arm,cortex-a55";
> +                       compatible = "arm,cortex-a75";
>                         reg = <0x0 0x600>;
>                         enable-method = "psci";
>                         cpu-idle-states = <&CORE_PD>;
> @@ -104,7 +104,7 @@ CPU6: cpu@600 {
>
>                 CPU7: cpu@700 {
>                         device_type = "cpu";
> -                       compatible = "arm,cortex-a55";
> +                       compatible = "arm,cortex-a75";
>                         reg = <0x0 0x700>;
>                         enable-method = "psci";
>                         cpu-idle-states = <&CORE_PD>;
> --
> 2.34.1
>
