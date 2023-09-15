Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E46D7A1B72
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233968AbjIOJ5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233892AbjIOJ5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:57:08 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6F735B8;
        Fri, 15 Sep 2023 02:55:49 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2bfc14e6d03so23533191fa.1;
        Fri, 15 Sep 2023 02:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694771744; x=1695376544; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R7zkJukNUYSEGarsHRiRBGtJZPGffpcT+jlk9LRKGkg=;
        b=QdDGbNqwhEhBBx55vCpuZUUqgRtMPj0DEuYY06Q1cc2zPr1YJA8e4Hdw9vHiLzjRI5
         6ViwJGJ74DKMuM2tFeqwF48JJA9fsDikXiOxF3XE33md+61WcupXWq25Ysx2BCvLwpvR
         H7R4W03PaD+uGD7io/NIGKFUw4rY7wpbtMZ+kOOvmEUbGr26ofcNwlm9BfdT2Riueb1v
         FNUmGe8F5HO7IBFQwkyuablKbdqexwmwk1+S3/iixuIC2s5UNP3MuUnbUD3G/lbb+DZ7
         AYXyiNFu0DrUL3k4lhr/5T8XhuIJtBLUYyspBVoNsLWDc1722jOwJH1QPEy82x5zmRJg
         WQ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694771744; x=1695376544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R7zkJukNUYSEGarsHRiRBGtJZPGffpcT+jlk9LRKGkg=;
        b=jcc3msjCUTFScJoSXvAGYBE09pZKtDtZoz0ucEKzC6TC50TH4HkOfK4HSZVrFMNglw
         51+X4cn1ANFnn4x2BmSMRwVMUJ3fzuNmQaABdnF3H6cVjgb1kuL5B93d9aj40fd1y0D8
         GYsjpCymzfc4lVALzji5oJXs+XxEAfUb/K2evL7ouwIzmJ6bKGwZJddej0Xx2gc1IkUp
         WW0+N3LQCNa18dy9whCMQddFcpvCACI5GaBH/9kmeNjJPFfTHRA740rD+ikf2sh1lfn/
         /ys+vuAlyQWsLOjlM9lPyzAIboBX7RGa+M0UNpZQg+c5OWLB+KYlc/l7UYVJqQRWxhHC
         qynQ==
X-Gm-Message-State: AOJu0Yzt4QdoJlyuJDer9JinfYIZ03Gd2e2zzWAk6eDjj3gxoLWVjdrc
        fX2L/QCFEX+fltMlrsk0ZDeUxj/nMFd9tQ==
X-Google-Smtp-Source: AGHT+IHZLNXpdRzn2IhV8455COBFdw8gXQ4ZUbGrFWe4r4mMAp2BwvIbfoiDIKVm4dVnely/apypdg==
X-Received: by 2002:a2e:3019:0:b0:2bd:a67:e8c with SMTP id w25-20020a2e3019000000b002bd0a670e8cmr494625ljw.3.1694771743907;
        Fri, 15 Sep 2023 02:55:43 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id a20-20020a2eb174000000b002b9a1e9ba68sm654548ljm.136.2023.09.15.02.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 02:55:43 -0700 (PDT)
Date:   Fri, 15 Sep 2023 12:55:41 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH v5 0/3] Move Loongson1 MAC arch-code to the driver dir
Message-ID: <ueevvju7i42wik6fevdmvbtypm4su77guyo4zizhrfreexken7@nrcovxfnyuvq>
References: <20230914114435.481900-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914114435.481900-1-keguang.zhang@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keguang

On Thu, Sep 14, 2023 at 07:44:32PM +0800, Keguang Zhang wrote:
> In order to convert Loongson1 MAC platform devices to the devicetree
> nodes, Loongson1 MAC arch-code should be moved to the driver dir.
> Add dt-binding document and update MAINTAINERS file accordingly. 
>     
> In other words, this patchset is a preparation for converting
> Loongson1 platform devices to devicetree.

No more comments from my side. Thank you for the patches and
especially for the patience in the review process.

For the entire series:
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

* I'll also send individual Rb tags to each patch so b4 would be able
* to take it into account.

-Serge(y)

> 
> Changelog
> V4 -> V5: Replace stmmac_probe_config_dt() with devm_stmmac_probe_config_dt()
>           Replace stmmac_pltfr_probe() with devm_stmmac_pltfr_probe()
>           Squash patch 4 into patch 2 and 3
> V3 -> V4: Add Acked-by tag from Krzysztof Kozlowski
>           Add "|" to description part
>           Amend "phy-mode" property
>           Drop ls1x_dwmac_syscon definition and its instances
>           Drop three redundant fields from the ls1x_dwmac structure
>           Drop the ls1x_dwmac_init() method.
>           Update the dt-binding document entry of Loongson1 Ethernet
>           Some minor improvements
> V2 -> V3: Split the DT-schema file into loongson,ls1b-gmac.yaml
>           and loongson,ls1c-emac.yaml (suggested by Serge Semin)
>           Change the compatibles to loongson,ls1b-gmac and loongson,ls1c-emac
>           Rename loongson,dwmac-syscon to loongson,ls1-syscon
>           Amend the title
>           Add description
>           Add Reviewed-by tag from Krzysztof Kozlowski
>           Change compatibles back to loongson,ls1b-syscon
>           and loongson,ls1c-syscon
>           Determine the device ID by physical
>           base address(suggested by Serge Semin)
>           Use regmap instead of regmap fields
>           Use syscon_regmap_lookup_by_phandle()
>           Some minor fixes
>           Update the entries of MAINTAINERS
> V1 -> V2: Leave the Ethernet platform data for now
>           Make the syscon compatibles more specific
>           Fix "clock-names" and "interrupt-names" property
>           Rename the syscon property to "loongson,dwmac-syscon"
>           Drop "phy-handle" and "phy-mode" requirement
>           Revert adding loongson,ls1b-dwmac/loongson,ls1c-dwmac
>           to snps,dwmac.yaml
>           Fix the build errors due to CONFIG_OF being unset
>           Change struct reg_field definitions to const
>           Rename the syscon property to "loongson,dwmac-syscon"
>           Add MII PHY mode for LS1C
>           Improve the commit message
> 
> Keguang Zhang (3):
>   dt-bindings: mfd: syscon: Add compatibles for Loongson-1 syscon
>   dt-bindings: net: Add Loongson-1 Ethernet Controller
>   net: stmmac: Add glue layer for Loongson-1 SoC
> 
>  .../devicetree/bindings/mfd/syscon.yaml       |   2 +
>  .../bindings/net/loongson,ls1b-gmac.yaml      | 114 ++++++++++
>  .../bindings/net/loongson,ls1c-emac.yaml      | 113 ++++++++++
>  MAINTAINERS                                   |   2 +
>  drivers/net/ethernet/stmicro/stmmac/Kconfig   |  11 +
>  drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
>  .../ethernet/stmicro/stmmac/dwmac-loongson1.c | 209 ++++++++++++++++++
>  7 files changed, 452 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/loongson,ls1b-gmac.yaml
>  create mode 100644 Documentation/devicetree/bindings/net/loongson,ls1c-emac.yaml
>  create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c
> 
> 
> base-commit: 98897dc735cf6635f0966f76eb0108354168fb15
> -- 
> 2.39.2
> 
> 
