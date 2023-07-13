Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B257528FD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 18:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235306AbjGMQpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 12:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235286AbjGMQpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 12:45:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55884273F;
        Thu, 13 Jul 2023 09:45:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E455661ABC;
        Thu, 13 Jul 2023 16:45:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 586CEC433C8;
        Thu, 13 Jul 2023 16:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689266738;
        bh=J3RUI8qwmJA4yybDRpC1CZ1azrTZb/rtPO3fvob1qaQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UF5ph5fXPMOCKjXbD+kRjXsknOp3ebyBk25B7EUTUldcQ7/geh3aqzzro20niieF2
         EXaiokHw7yKT86DNyzF4zYJTLk/rfNHtxcMDn2mMhuthlcdm7eJO7FrmtvyYNDVSVF
         JKk9iSdPRLT2vj8LvbsOsWttXtgd0WiBiMRSM/X/0F3SmsVCp2c5Dr0ujlZZAbpyG1
         Wq7E9R0QRmOsrmlpxnfqOd/MCx2JYpMs4fEeG69+J/DNfVWm92EZOdoQY7W15MQY88
         KvAzx6Ukuvd5awg40LAA/LNmEztde46TgTduFA+KnYaOgjDz728s8w0C8/gRVJvIEN
         ZfgRPibcbqm7g==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2b8390003e2so1356711fa.0;
        Thu, 13 Jul 2023 09:45:38 -0700 (PDT)
X-Gm-Message-State: ABy/qLaY66IZzrEj3yQHlRHdizbxREP4MVuqZzKx/g+ZlmT3EzuRxuwZ
        rIqI8d37/swtDEUoqeUOCdRTl7wZOjJ0O2Id5w==
X-Google-Smtp-Source: APBJJlFDo7wwC4D28vWY2R4KsBMLdqWGL+yrptwz13QqhZxBfsTZ8gqTjVVzon8XNGcy5TX2GWE4qjSiHbBk9G3Vxak=
X-Received: by 2002:a2e:3c0c:0:b0:2b4:7f2e:a42d with SMTP id
 j12-20020a2e3c0c000000b002b47f2ea42dmr1951655lja.41.1689266736265; Thu, 13
 Jul 2023 09:45:36 -0700 (PDT)
MIME-Version: 1.0
References: <1894ed7a1a9.f5e49d5d141371.2744760538860302017@linux.beauty> <1894edd07ee.b7245352142935.3234373322799059936@linux.beauty>
In-Reply-To: <1894edd07ee.b7245352142935.3234373322799059936@linux.beauty>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 13 Jul 2023 10:45:24 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKSnhvgDfXA46v_CzFn1q1U_Lr7N=JA8bMYMrPAgENOWA@mail.gmail.com>
Message-ID: <CAL_JsqKSnhvgDfXA46v_CzFn1q1U_Lr7N=JA8bMYMrPAgENOWA@mail.gmail.com>
Subject: Re: [PATCH V2] of: property: fw_devlink: fixup return value check of
 strcmp_suffix in parse_gpios
To:     Li Chen <me@linux.beauty>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 4:47=E2=80=AFAM Li Chen <me@linux.beauty> wrote:
>
> This commit addresses an issue where enabling fw_devlink=3Don was causing
> a PCIe malfunction, resulting in endpoints missing.
> After thorough investigation, it was determined that the root cause was
> an incorrect usage of strcmp_suffix in parse_gpios.
>
> Fixes: d473d32c2fba ("of: property: fw_devlink: do not link ".*,nr-gpios"=
")
> Signed-off-by: Li Chen <lchen@ambarella.com>
> Cc: stable@vger.kernel.org
> ---
> changes:
> v1->v2: add Cc stable
>
>  drivers/of/property.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index ddc75cd50825..261eb8f3be08 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1272,7 +1272,7 @@ DEFINE_SUFFIX_PROP(gpio, "-gpio", "#gpio-cells")
>  static struct device_node *parse_gpios(struct device_node *np,
>                                        const char *prop_name, int index)
>  {
> -       if (!strcmp_suffix(prop_name, ",nr-gpios"))
> +       if (strcmp_suffix(prop_name, ",nr-gpios"))

strcmp returns 0 when there is a match. When we match ",nr-gpios", we
want to bail out. The existing code was correct. Your patch just
disables fw_devlink for all GPIO dependencies.

Rob
