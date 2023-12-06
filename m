Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5CB80761A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 18:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442719AbjLFRJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 12:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442647AbjLFRJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 12:09:25 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF811D3
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 09:09:31 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3b9d029b9bbso18055b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 09:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1701882571; x=1702487371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ebrCX+s/Y/vVmHv1yCH1HySRy2V69fpkAgLFjl3R0nI=;
        b=V9dwCaKhkDr1wSqN3nhJZ++0WlJajp/v9kwKN06sZsYOUnFzgqF0u52sqeoV/s1MAf
         D9r7RTBlJPEWHH+oe8AsUaWE1N63gCrCy2ACz7QvMEABeZVLg2KqUpDILUwGn8sgg4F4
         j67DU3D7gfg4t6uc4/9nN3ML4OgL1h8Gj+M8ogjYMlKl2vWU+Cg+DIjsIqzw4rthHp9Y
         figZOKzYsb0kFTNuq3YE8i+oiiceMh0yKeCqHdxLq4k0vNwianYnofEmiLtCNJPVNYAF
         X11MfpHXuX9HI6d0mK8LQxonM15u7kYcvZPEw2Sx3qBYajb74vlf+TLAt9+ZMwnKjdZf
         ZGZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701882571; x=1702487371;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ebrCX+s/Y/vVmHv1yCH1HySRy2V69fpkAgLFjl3R0nI=;
        b=sI+3rNJ4jBqVdkepm0Wks/RZabVyYW4n5i1oaUJ8GE8b7T6yCAwsrp2ySeyRhouYk+
         CtmLWZ9MJcfODjEeo07VFWBJrkAldJXL8vWp7Aab2qzkpYMRdwL3HDlfhnv/G+1R/3tC
         l1QVaQ/Jss9uuoy5QBFG3wUQVM3NhnY4hoFXwD7yEf5Fvc7FqTX3EsuBIKynEgDLi6ZQ
         tdgD94LbHRWOXOOwmOP84ePE+UQdtZn8F0++lOD/Y5/WyYvdlZKVEKQlZyjSzR6vqMng
         DHgFEHGpd5fZBADHy/EmZ/OKP3F3DLCk0XAO4kQVBkVAF0Gf0l/VP5JcNushtNoJaksi
         8vnw==
X-Gm-Message-State: AOJu0Yy2r0ChsV+XKLOGVzrUyKcIMkTBzyuEjUJdF6vot8R3r3LEYhn5
        lmC98mkhB5GV7HOUQqTrghevEZEfaNOouvTsIF4=
X-Google-Smtp-Source: AGHT+IGuQkE0n1LAuOq5AF8j/hKBwUXZppnsnN5YyGTCGJ1oFqClQUkOyOw7Od+cPjK0nrrDM+eS+g==
X-Received: by 2002:a05:6808:318:b0:3b8:9d83:ec5e with SMTP id i24-20020a056808031800b003b89d83ec5emr473367oie.20.1701882571169;
        Wed, 06 Dec 2023 09:09:31 -0800 (PST)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id j8-20020a544808000000b003b845ba61c8sm60240oij.12.2023.12.06.09.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 09:09:30 -0800 (PST)
Date:   Wed, 06 Dec 2023 09:09:30 -0800 (PST)
X-Google-Original-Date: Wed, 06 Dec 2023 09:09:28 PST (-0800)
Subject:     Re: [PATCH v2 1/8] riscv: errata: Add StarFive JH7100 errata
In-Reply-To: <20231130151932.729708-2-emil.renner.berthing@canonical.com>
CC:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>, kernel@esmil.dk,
        Conor Dooley <conor@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        cristian.ciocaltea@collabora.com, geert@linux-m68k.org,
        Conor Dooley <conor.dooley@microchip.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     emil.renner.berthing@canonical.com
Message-ID: <mhng-5a8c5e00-7f74-489e-b191-e5fc6c0ecd58@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2023 07:19:25 PST (-0800), emil.renner.berthing@canonical.com wrote:
> This not really an errata, but since the JH7100 was made before
> the standard Zicbom extension it needs the DMA_GLOBAL_POOL and
> RISCV_NONSTANDARD_CACHE_OPS enabled to work correctly.
>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> ---
>  arch/riscv/Kconfig.errata | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/arch/riscv/Kconfig.errata b/arch/riscv/Kconfig.errata
> index e2c731cfed8c..692de149141f 100644
> --- a/arch/riscv/Kconfig.errata
> +++ b/arch/riscv/Kconfig.errata
> @@ -53,6 +53,23 @@ config ERRATA_SIFIVE_CIP_1200
>
>  	  If you don't know what to do here, say "Y".
>
> +config ERRATA_STARFIVE_JH7100
> +	bool "StarFive JH7100 support"
> +	depends on ARCH_STARFIVE && NONPORTABLE
> +	select DMA_GLOBAL_POOL
> +	select RISCV_DMA_NONCOHERENT
> +	select RISCV_NONSTANDARD_CACHE_OPS
> +	select SIFIVE_CCACHE
> +	default n
> +	help
> +	  The StarFive JH7100 was a test chip for the JH7110 and has
> +	  caches that are non-coherent with respect to peripheral DMAs.
> +	  It was designed before the Zicbom extension so needs non-standard
> +	  cache operations through the SiFive cache controller.
> +
> +	  Say "Y" if you want to support the BeagleV Starlight and/or
> +	  StarFive VisionFive V1 boards.
> +
>  config ERRATA_THEAD
>  	bool "T-HEAD errata"
>  	depends on RISCV_ALTERNATIVE

Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

Thanks for dealing with this.  This is mostly DT stuff so I'm fine with 
it going via Conor's tree, but LMK if you guys want me to take it.
