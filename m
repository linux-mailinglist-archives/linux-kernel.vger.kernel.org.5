Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3367757711
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 10:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjGRIwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 04:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGRIwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 04:52:07 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11ACDB9;
        Tue, 18 Jul 2023 01:52:07 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5833695cc67so22055087b3.3;
        Tue, 18 Jul 2023 01:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689670326; x=1692262326;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cyG8fmdJQTl2SyeQjedBG6jEYOaMLAOoJTJLSOWVUuQ=;
        b=sZaYj3j7Q4gZ0/bzzEgPYToAKItoPUnA1AeCZo/SraM30n2csw5189082i0aAbJlQw
         VpNJo0ocs0lhS0UTSAf74mc0rk/ZCtXC/HCjW8AtwT2G1Sbm6h6ZEPG4dcSJS3EGZQ5T
         UF569XzmLNr6WTVrENBNeXTVVrJwm8FGj4fTjNZ949cRO1fGWfUoI0UejoM6DdNwyeb5
         E4VcXXSRxpwov03eNKGd2m+ESh6rHSTzJ8HeVahc1acgGPsYQXDdaC7A8cBv1iww4+ll
         BCxNK3nSxLQ0f4ive/zgp4pK8KOlVwyzN0U+O3bzEWlOdX8xxWeYYDnHPx3QAORP1Von
         QCfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689670326; x=1692262326;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cyG8fmdJQTl2SyeQjedBG6jEYOaMLAOoJTJLSOWVUuQ=;
        b=luPc3fF5HGs/cDbUGviIN8JhLGr0Q6YOC3j1mdGZ9KKvlmaSJmjx79cSHX6UJ8Irrs
         AhDyfknog8K7hIdIIhfGCWgooSFmgzi2zVoGPhJos9EzWrJkPScvPWJIAll7zy78Ggb4
         eFtWWIc2Ist0CkMbq1eu9ibgzeQI4yDXu1ddPNlstxbLMtG9hiT/n17+6F0K9QRaj+cw
         CzE8xwP4QJjvjyxdn8U4SH8uMtaQn1foGR1xiBqre+v69owcrhTDSUR3RftOfD2EaZ9+
         2BTRs3upOdDoWHx//9WwkAbnWcDxtYRePicWz8GeGMsBEqZYt51BdJi0ZDUqO7K6B5Mz
         hOqg==
X-Gm-Message-State: ABy/qLb6/oUyUnI8BeoMA3R30Rh5EMTx9TsNss7fBuJ4mTodOzalZJnU
        MY/uu0s2AANJh8zqnS3CJfbCRRJ4uSmORcZv94V+Gg+I
X-Google-Smtp-Source: APBJJlGsUU6uWGOFT1lECMnsMzz9OhaGf59FO7iZChU8CcjN8ksWgO7Kze3pyuQgBae+c92ju5vTqEcgt/nlTD/naw4=
X-Received: by 2002:a81:7741:0:b0:577:60d3:e5fd with SMTP id
 s62-20020a817741000000b0057760d3e5fdmr15381454ywc.28.1689670326193; Tue, 18
 Jul 2023 01:52:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230718080812.16801-1-xujianghui@cdjrlc.com> <98a14fa23e4fb81d4630264cba0cecc8@208suo.com>
In-Reply-To: <98a14fa23e4fb81d4630264cba0cecc8@208suo.com>
From:   Kjetil Oftedal <oftedal@gmail.com>
Date:   Tue, 18 Jul 2023 10:51:53 +0200
Message-ID: <CALMQjD-JB-53dpJ92V4tdmiD_mO0AiyDthRv8obnpw=1FtRJ1g@mail.gmail.com>
Subject: Re: [PATCH] floppy: add missing put_device()
To:     sunran001@208suo.com
Cc:     davem@davemloft.net, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jul 2023 at 10:15, <sunran001@208suo.com> wrote:
>
> The of_find_device_by_node() takes a reference to the underlying device
> structure, we should release that reference.
>
> Detected by coccinelle with the following ERROR:
> ./arch/sparc/include/asm/floppy_64.h:595:3-9: ERROR: missing put_device;
> call of_find_device_by_node on line 589, but without a corresponding
> object release within this function.
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>   arch/sparc/include/asm/floppy_64.h | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/sparc/include/asm/floppy_64.h
> b/arch/sparc/include/asm/floppy_64.h
> index 070c8c1f5c8f..e74a4d4e6519 100644
> --- a/arch/sparc/include/asm/floppy_64.h
> +++ b/arch/sparc/include/asm/floppy_64.h
> @@ -592,6 +592,7 @@ static unsigned long __init sun_floppy_init(void)
>
>           state_prop = of_get_property(op->dev.of_node, "status", NULL);
>           if (state_prop && !strncmp(state_prop, "disabled", 8))
> +            put_device(&op->dev);

From the same domain as "Liubin" earlier, introducing the same kind of error
(Not adding curly braces)


>               return 0;
>
>           FLOPPY_IRQ = op->archdata.irqs[0];
