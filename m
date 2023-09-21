Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD757A97AE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjIUR05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjIUR0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:26:44 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECB95AAAB
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:21:30 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50307759b65so2273237e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695316889; x=1695921689; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BRjD71BxaHKeKUao5JkBY66AYjHKMR6kgB3U+BDfPis=;
        b=Ho7SHi/ryKoRwLToXgd2BOfVJQIAGve3hien8pv9xkpxa457QYcZ0hwacwtOk3mKvp
         D0sETx3z2JHw2AeuqRZ0RrhGfK7KHK3E3T73RNkkG9uiEjIXQbcAK+P47KxDhs6PQavY
         PbMV00IINqjyX7V/M9NhnY0wBhP66kgxmCSk2Y45BtvSYlibWGY6q0DO3Xh6Sqp3izrl
         lj8I22RK2XEByZmiVzCSj0VF4hy6P3al3xFV8l66MQNKwpDyZcq1IvWDTha5fW38F1Y2
         zbCr9qe8e2wtnAISsLkJiGdzlnB0ySsKj3HmkCcV4dZS1Gkchx2xEFlt6dZY1nSSn7kY
         v4lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316889; x=1695921689;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BRjD71BxaHKeKUao5JkBY66AYjHKMR6kgB3U+BDfPis=;
        b=NDD5yOB9tCiBqbW2nUzPuw0OGZsFilqJusbtRvU7wiEIVlXkG5rS17MTUkN16qMgeS
         aYwGV1s5MYnsgLGI5AUSTCt/3AqmBuWdyavVqV7XTXISK8PJLlA79ejOyfHKyF7M7/pD
         l3em5dpDJYEVDwak6OCtJdq4u9BiBLlTgqvYaEomhEOiyjIdUH2K2JbnHqB//iPSLOq4
         4vrkquuqIzmB4z0Txyhf+MMSk6qkkWDXdvfmsOPYg8xo66NUU/ezHVy0yMBIjOP8wJ8U
         s4ed2qz9lVBhhiRU1O32FVzYu5qT/meQiWWFN7El9p2b+YmKXgFWARCcy0mj0KHvkVLA
         Wcgw==
X-Gm-Message-State: AOJu0YzBGw/cLB+kgEEOsyJR32eP7gcH+S2ji3xI7WpGidv5kl5LRzFV
        dP/b10lhgU4B3Htp2gzf+sgH6I/qQXXy9bdfDu2QoQ==
X-Google-Smtp-Source: AGHT+IG20+78STBi2PpMkzT53VyFCQlg3f49O0y4ik5lHqELKdgTjzje3z/jrKlwq+zFG+cbW++8sA==
X-Received: by 2002:a17:906:10a:b0:9ae:6355:afe9 with SMTP id 10-20020a170906010a00b009ae6355afe9mr2017506eje.52.1695306953057;
        Thu, 21 Sep 2023 07:35:53 -0700 (PDT)
Received: from [172.20.34.61] (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.gmail.com with ESMTPSA id cb8-20020a170906a44800b00988dbbd1f7esm1118264ejb.213.2023.09.21.07.35.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 07:35:52 -0700 (PDT)
Message-ID: <4425afd4-c38c-4f27-96a6-9833fe2401b4@linaro.org>
Date:   Thu, 21 Sep 2023 15:35:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mtd: micron-st: enable lock/unlock for mt25qu512a
Content-Language: en-US
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     SHUKLA Mamta Ramendra <mamta.shukla@leica-geosystems.com>,
        "pratyush@kernel.org" <pratyush@kernel.org>,
        "michael@walle.cc" <michael@walle.cc>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     GEO-CHHER-bsp-development 
        <bsp-development.geo@leica-geosystems.com>
References: <20230705154942.3936658-1-mamta.shukla@leica-geosystems.com>
 <19800e51-a871-be9f-9eb5-5829237e2613@linaro.org>
 <a8271289-0611-4e37-cf37-0be19a85656b@leica-geosystems.com>
 <084ed945-7674-280f-5866-9238473a294d@leica-geosystems.com>
 <17989610-d069-40e2-9b4d-7ca6bdf2497e@linaro.org>
In-Reply-To: <17989610-d069-40e2-9b4d-7ca6bdf2497e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/21/23 15:31, Tudor Ambarus wrote:
cut
> 
> So the first commit will look like:
> diff --git a/drivers/mtd/spi-nor/micron-st.c
> b/drivers/mtd/spi-nor/micron-st.c
> index 4afcfc57c896..a8da1f18e335 100644
> --- a/drivers/mtd/spi-nor/micron-st.c
> +++ b/drivers/mtd/spi-nor/micron-st.c
> @@ -405,9 +405,6 @@ static const struct flash_info st_nor_parts[] = {
>         }, {
>                 .id = SNOR_ID(0x20, 0xbb, 0x20, 0x10, 0x44, 0x00),
>                 .name = "mt25qu512a",
> -               .size = SZ_64M,
> -               .no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ |
> SPI_NOR_QUAD_READ,
> -               .fixup_flags = SPI_NOR_4B_OPCODES,

since we removed the 4b-opcodes flag here,
>                 .mfr_flags = USE_FSR,
>         }, {
>                 .id = SNOR_ID(0x20, 0xbb, 0x20),
> 
> and the second one will add just the BP support, something like:
> diff --git a/drivers/mtd/spi-nor/micron-st.c
> b/drivers/mtd/spi-nor/micron-st.c
> index a8da1f18e335..fdafbfa0f936 100644
> --- a/drivers/mtd/spi-nor/micron-st.c
> +++ b/drivers/mtd/spi-nor/micron-st.c
> @@ -405,6 +405,8 @@ static const struct flash_info st_nor_parts[] = {
>         }, {
>                 .id = SNOR_ID(0x20, 0xbb, 0x20, 0x10, 0x44, 0x00),
>                 .name = "mt25qu512a",
> +               .flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB |
> SPI_NOR_4BIT_BP |
> +                        SPI_NOR_BP3_SR_BIT6,
>                 .mfr_flags = USE_FSR,
>         }, {
>                 .id = SNOR_ID(0x20, 0xbb, 0x20),
> 
> Of course, I expect you to run again the mtd_debug tests and also verify
> the locking. Thanks!

would also be good if you can also verify that 4BAIT SFDP table is
present and you still use the 4B opcodes after the change.

> 
> Cheers,
> ta
> 
