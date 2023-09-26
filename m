Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F45D7AEF45
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 17:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235144AbjIZPEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 11:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235072AbjIZPEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 11:04:24 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35E619E
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 08:04:12 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d8164e661abso10224379276.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 08:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695740652; x=1696345452; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gACCqU464nbmifans7JAXRQVvVlNjsznE9UNt5TqO8E=;
        b=zz6fgqoFphdvGMLNH2enrbt75dF3gnnEZnc99UaQQszWz/SoVa20wcZrHv5Yi/RZUM
         3yqEKzPF0OdvS8g95UdBhU/uzT4C6Y+HbkPEHYXtVup5uXBicCwG7Ruc9dCDBcInc51g
         B+iakIzwDcG2etCBlfrdIZmOxrDW3PqBNDqMMVbZGuvFR+tMYK0vwkW9AfiMrlg39JTl
         q2rSS/6UxUiVsrh3T3pWhMmdku03y/L2lvGHKDzOb/lqkAj3OGGM/VnNipJDIcXaUkgC
         DkK0GzqLeiTIAjI3AeITmj7shwANteLC2yfdEE5Zrraq/gl0NMcykkqHnToSxR00bvYh
         1n+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695740652; x=1696345452;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gACCqU464nbmifans7JAXRQVvVlNjsznE9UNt5TqO8E=;
        b=cZbmeffe1VMZSlpkIi6A/+4GOFGZUPdGCXtHWck+8PoWeCMnayrWTww7z+zpUw+l0L
         bHMJCD4chcXRofde5oHOa5eqwSBGHtAqfA/eOfHE421DUqcKIqQTMReg7dfOH1C0Vv2d
         GI7+ol8zd9ADYuUQxpJKhPkNO0C5HNMDB+Zq172IpO1lbquIMfIWLbpHOra3ZS0GSWeD
         vnVA1SbSEp5+g1s0Oy4tYKNzilcoLHgGlf0kdfN0M8cOCvkKsG5f4t6NtUnmNwTdyTTz
         Zfl+fXcmesmawClPrUHhy0VdKQzzWPDt4JrDtnHtvPA1gG+Zy5Dh34iGNgS7Oi1a+2Tf
         WVXA==
X-Gm-Message-State: AOJu0YyAiCBot2obz2QOLuGsrvPyGPyy5v+b4Sc1JV3CPrd0HziICxCr
        krImtJKGXzxY9BeQS0YLk5mWx9evXIJlVhw9j02JhQ==
X-Google-Smtp-Source: AGHT+IHebOY62vQuQ8mi7GVykbe+TPx5MZJx0BhkK6giVggi+4w9oRLPJPUde9+BtK9dj0EgQ9y6d+OUJIa5A5+74kA=
X-Received: by 2002:a25:320e:0:b0:d7f:13da:f773 with SMTP id
 y14-20020a25320e000000b00d7f13daf773mr9543151yby.6.1695740651642; Tue, 26 Sep
 2023 08:04:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230922062834.39212-1-william.qiu@starfivetech.com>
In-Reply-To: <20230922062834.39212-1-william.qiu@starfivetech.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 26 Sep 2023 17:03:35 +0200
Message-ID: <CAPDyKFrrW+c9zm5pb6B7T_ULfij6=47E7OM-sgpCKTyWZ_BV0w@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Change tuning implementation
To:     William Qiu <william.qiu@starfivetech.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-mmc@vger.kernel.org,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sept 2023 at 08:28, William Qiu <william.qiu@starfivetech.com> wrote:
>
> Hi,
>
> This series of patches changes the tuning implementation, from the
> previous way of reading and writing system controller registers to
> reading and writing UHS_REG_EXT register, thus optimizing the tuning
> of obtaining delay-chain.
>
> Changes v2->v3:
> - Rebased to v6.6rc2.
> - Dropped redundant criteria.
> - Keeped "starfive,sysreg" in dts file.
>
> Changes v1->v2:
> - Rebased to v6.6rc1.
> - Keeped "starfive,sysreg" in dt-bindings but removed from required.
> - Changed the function interface name.
> - Maked the code implementation more concise.
>
> The patch series is based on v6.6rc2.
>
> William Qiu (3):
>   dt-bindings: mmc: Remove properties from required
>   mmc: starfive: Change tuning implementation
>   riscv: dts: starfive: add assigned-clock* to limit frquency
>
>  .../bindings/mmc/starfive,jh7110-mmc.yaml     |   2 -
>  .../jh7110-starfive-visionfive-2.dtsi         |   4 +
>  drivers/mmc/host/dw_mmc-starfive.c            | 137 +++++-------------
>  3 files changed, 44 insertions(+), 99 deletions(-)
>

Patch 1 -> 2 applied for next, thanks!

Kind regards
Uffe
