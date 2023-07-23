Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2282775E3E1
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 18:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjGWQiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 12:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGWQiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 12:38:21 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CCCEA;
        Sun, 23 Jul 2023 09:38:20 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-55badd6d6feso309145a12.1;
        Sun, 23 Jul 2023 09:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690130300; x=1690735100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1fILWGknGYtceXaaDdSa7GUTAbeDyflfRfQ1Pomhxo=;
        b=eK6YqVkH7uIh0895sUArC7vginN7wUG6J03ge/MEP9zStHdCFSXdYqxX9EG0iYNPbG
         MR9xzpX9PPwJD99kZDFK+a1ZHOyJKtAOxrrzGFx9ml2bXNe+o7tAFdw36kTLzsznui6+
         VpbHywJGaWKPG4BVSeVjB5EbDajOI5iF9yU3Onnol24566GMUB0SHdkpz0VO0+R7CuaJ
         4p1R+2lAIagL6fucTfDheM3kmrdR+1KqzcEKD150U/58d4IMDuSrdJD67+r019H0lAui
         HfYLnfSKf2R+D+ctraMZeK6+MDDbtttcduC245brC4GtpvEtznp/J9UcQXAm2SgDqKDC
         44zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690130300; x=1690735100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y1fILWGknGYtceXaaDdSa7GUTAbeDyflfRfQ1Pomhxo=;
        b=Bw9Wgf7xd9hA0LKwZMMJP7tH+yzfxJp/o/DGGdquOUhwFc6DHZK4JLHFB38WUUnTR1
         rtmwmUYZfl8w09zJJP5jGXs5WiXEIMOgYEJ+OaGG4rNrjfcO0AIYrVx+HHs6nCn8SU/j
         n0IcFydNu/3ROrl3noh9n7dsTJgOaGXurPLIXHuJ+NNPtUv2m5jMcjLLQh6m1GSFMMQl
         hU/Z4d1FHl8lXv48vOb45fhPCn5nAyYQYnWoJczEBp838U+Md+qFbzE9U1/xXFPKceMZ
         mbpo5UOFXf7zNvLmAqEa2kXPhjxH5nyDafmYt+g3hvJQNiqelEFQDNS+7KeD+aNUSTHm
         3VzA==
X-Gm-Message-State: ABy/qLYaRu7cfK6ZJDJKxNm5kPwx4XHOjOHIf0zJRVvPKtpWj3cp3RVu
        Dl4ESC3Ofof6CpLf3ZA/fd5NwzW1NCwwEilS+cA=
X-Google-Smtp-Source: APBJJlHPbbccROQonvgfLGOZ5PG+aiSfMqZcjHQqHSDxj8DgUip6Mal7QVbr3EK5jzAI5n84hQ1y88ohAUFTnNVxNH0=
X-Received: by 2002:a17:90a:f86:b0:268:40b:2e03 with SMTP id
 6-20020a17090a0f8600b00268040b2e03mr2757956pjz.4.1690130300180; Sun, 23 Jul
 2023 09:38:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230723022050.524050-1-xiaolei.wang@windriver.com>
In-Reply-To: <20230723022050.524050-1-xiaolei.wang@windriver.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sun, 23 Jul 2023 13:38:08 -0300
Message-ID: <CAOMZO5BZXYH7CUduBfysgOgrcreEaYN-gzNZk3JGpSs_d37xzg@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: imx: Set default tuning step for imx7d usdhc
To:     Xiaolei Wang <xiaolei.wang@windriver.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        linux-imx@nxp.com, richardcochran@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xiaolei,

On Sat, Jul 22, 2023 at 11:21=E2=80=AFPM Xiaolei Wang
<xiaolei.wang@windriver.com> wrote:
>
> If the tuning step is not set, the tuning step is set to 1.
> For some sd cards, the following Tuning timeout will occur,

You missed putting the timeout message here.

> so set the default tuning step. This refers to the NXP vendor's
> commit below:
>
> https://github.com/nxp-imx/linux-imx/blob/lf-6.1.y/
> arch/arm/boot/dts/imx7s.dtsi#L1216-L1217
>
> Fixes: 1e336aa0c025 ("mmc: sdhci-esdhc-imx: correct the tuning start tap =
and step setting")
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
>
> v2:
>   * Refer to https://github.com/nxp-imx/linux-imx/blob/lf-6.1.y/arch/arm/=
boot/dts/imx7s.dtsi#L1216-L1217
>     and add the following attributes for all usdhc of imx7:
>       fsl,tuning-step =3D <2>;
>       fsl,tuning-start-tap =3D <20>;

This v2 changelog should be placed below the --- line.

> ---

Put it here.

Reviewed-by: Fabio Estevam <festevam@gmail.com>
