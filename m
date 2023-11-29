Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 190127FE42A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 00:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343688AbjK2XWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 18:22:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343661AbjK2XWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 18:22:16 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3769D67
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 15:22:22 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50bba1dd05fso563430e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 15:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701300141; x=1701904941; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2/HnZ3tBk4Rv10ctPha3htJ6jB9vSVJNy8j7jeHy+N0=;
        b=hbQhTkfqcwoN6Y8Ie9banA9lI2i7735KvbAFa24wXrPDCEIQpkFgHuildLcfvixCKW
         TBses0KlVbJABwSmYf2OFABUXBrlVGsq5/fAqbqneEO6GfJS85nv0FEfQbmdlOPk/8uD
         apQvYByFaFfaOUvhHU47BjynoIqX5F2XW+MVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701300141; x=1701904941;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2/HnZ3tBk4Rv10ctPha3htJ6jB9vSVJNy8j7jeHy+N0=;
        b=ES2yxcFrvYXeVLD41H/NWeYMkKqE+vyPVZhklOLPjoQbs1nRqIJmTQZKjMRueFq5bo
         zHTVgu0ImOkS22RmXoTNILP7PVHK08amnbn52UZLEvZICbAuYMMynzJspmILh432rfsl
         smx0nRM6GdxkUGlmRtHeeZe+A01oL4m5DH3G2IE8lChGxK7BoXDkyih86uZ+OvUo2Mxt
         XRp6P4ygGMoPAW9GEsd7amIGOjVLqywDfrgYAgXzjFt7gVuoo/tJ2008zvfbuJbKND5E
         ABuPns9EqLYBiBbgU7gC6vdROwdgAuJEhvGWqhqToScr0/M4swUPCsxYbAqunhOVbJCw
         wjFw==
X-Gm-Message-State: AOJu0Yyngl6UUteGzx8+0gXMnMdMIaI3huw08jAJLfTh2LonsfV2i5Dw
        g3pW6Uoy3ZyMtyZ+Xy/VYCls1CIDNnZglAYd6OSC6w==
X-Google-Smtp-Source: AGHT+IFYwY557f0M/HBVYE3v9Lp8eNTCTg5oXoWdtSW9n3YuCd9BE+gko2nwt0HyJjEkoxBEYx0zOQD+alQIHP6FIu4=
X-Received: by 2002:a05:6512:695:b0:509:8db5:949 with SMTP id
 t21-20020a056512069500b005098db50949mr17477580lfe.6.1701300140674; Wed, 29
 Nov 2023 15:22:20 -0800 (PST)
MIME-Version: 1.0
References: <20231116172859.393744-1-sjg@chromium.org>
In-Reply-To: <20231116172859.393744-1-sjg@chromium.org>
From:   Simon Glass <sjg@chromium.org>
Date:   Wed, 29 Nov 2023 16:22:03 -0700
Message-ID: <CAPnjgZ0z_oMy0kDScMjE9jYOvFJ12dxWn2CRoTpTsmw7TfARGw@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] dt-bindings: mtd: partitions: Add binman compatible
To:     devicetree@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org, Tom Rini <trini@konsulko.com>,
        Rob Herring <robh@kernel.org>,
        Michael Walle <mwalle@kernel.org>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pratyush Yadav <ptyadav@amazon.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 16 Nov 2023 at 10:29, Simon Glass <sjg@chromium.org> wrote:
>
> Add a compatible string for binman, so we can extend fixed-partitions
> in various ways.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v5)

Is there any movement on this series, please?

>
> Changes in v5:
> - Add #address/size-cells and parternProperties
> - Drop $ref to fixed-partitions.yaml
> - Drop 'select: false'
>
> Changes in v4:
> - Change subject line
>
> Changes in v3:
> - Drop fixed-partition additional compatible string
> - Drop fixed-partitions from the example
> - Mention use of compatible instead of label
>
> Changes in v2:
> - Drop mention of 'enhanced features' in fixed-partitions.yaml
> - Mention Binman input and output properties
> - Use plain partition@xxx for the node name
>

Regards,
Simon
