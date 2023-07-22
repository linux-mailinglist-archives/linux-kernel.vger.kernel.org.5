Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D29875D818
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 02:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjGVAQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 20:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjGVAQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 20:16:14 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1DF010CB;
        Fri, 21 Jul 2023 17:16:13 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6748a616e17so552141b3a.1;
        Fri, 21 Jul 2023 17:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689984973; x=1690589773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KGm3wATcLjmRhuJlYKHxaNDLAuB2jNiX/9sOF6u7nS8=;
        b=EJrKH1aiMokJXDi6o4r5EZUS/a5WuLSzuwmsA9y8wujRJEs1CdvBrJfgNTLSO9YxeK
         MN5xDDwBRifHdHgQfamdxcnFBCUfAvPpem25KM2IgzjhZYt3aSpFUVV3dZkq1eqGYUEZ
         cltkRNH3DMzaNH+CFzGC74GiMi+8j2uGvRkRb3k/jN4+BpLLuMnpmBg9gET4xslFp9eN
         e4w4Nk2ao+ASiSkT+w7gKCcMfn7rXSl0wiKyBcN0ChD+VJWzDo0UKebawDDPseBabj++
         Asm7edETIx2vwsje/UgOV/0X2Wm9g0JYrqM6BrUQTpe9rOfCUjdKqNAzzqWbY3E1W2By
         6hUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689984973; x=1690589773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KGm3wATcLjmRhuJlYKHxaNDLAuB2jNiX/9sOF6u7nS8=;
        b=ZRRXov0ia0upjOkxO3a1i1uc7UbHcjWFMJrcT+eYPQQ3SOYpBQGQ6xVGwHmi18XB3Q
         8sUNwPfo7+Ha0/Wt2JNXTpsXvRxuXNe1YPXNZQLHmdFVNoBOeSRskH8/rF4Uw31GTDva
         ZocpIVCKtEbC/pXrWqeySqDKm6rDkUafDVhI6EBpgl0THy3aG4Ytv9Rd6DpdIpJGg5YI
         Y7fI1QIatR4Rmh9pIvyREqnm2yt0ddwMk5WdBgDtJJyh8VMwI65jl1DgSdIIeIaX4T7l
         PCckDKaTTf9/4D89kTOlo1EaY4QIO01luABy9kkwEDH6QdS6IN7HKgqgobk1X43AlM6i
         ru+A==
X-Gm-Message-State: ABy/qLZqXbwivU6TdwjjDUkUshDKN6fTYjwp9hi8aFSZ3YhVdOnNiduc
        6RDn4zG0sCM2gZv59/spIhyA1okM6xj0FBBdaVQ=
X-Google-Smtp-Source: APBJJlGp/ADfscKgoTwPncN2boU9cMIjk1NSK+EuTKPwcQAwLSB9gFSerAIPVAPeU+z4FskpP8sVXJV+AhsMIbmX9R4=
X-Received: by 2002:a17:90a:128e:b0:264:942:ad27 with SMTP id
 g14-20020a17090a128e00b002640942ad27mr2912974pja.4.1689984973144; Fri, 21 Jul
 2023 17:16:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230721232123.2690960-1-xiaolei.wang@windriver.com>
In-Reply-To: <20230721232123.2690960-1-xiaolei.wang@windriver.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 21 Jul 2023 21:16:01 -0300
Message-ID: <CAOMZO5AMDvERRaSUYtuf_zq4foSqUuo0kErhj+hEZUuZRPXv1g@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx: Set default tuning step for imx7d usdhc0
To:     Xiaolei Wang <xiaolei.wang@windriver.com>,
        Bough Chen <haibo.chen@nxp.com>
Cc:     robh+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xiaolei,

On Fri, Jul 21, 2023 at 8:21=E2=80=AFPM Xiaolei Wang <xiaolei.wang@windrive=
r.com> wrote:
>
> If the tuning step is not set, the tuning step is set to 1.
> For some sd cards, the following Tuning timeout will occur,
> so set the default tuning step.
>
> Tuning failed, falling back to fixed sampling clock
> mmc0: Tuning failed, falling back to fixed sampling clock
>
> Fixes: 1e336aa0c025 ("mmc: sdhci-esdhc-imx: correct the tuning start tap =
and step setting")
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> ---
>  arch/arm/boot/dts/nxp/imx/imx7d-sdb.dts | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/nxp/imx/imx7d-sdb.dts b/arch/arm/boot/dts/=
nxp/imx/imx7d-sdb.dts
> index 75f1cd14bea1..d7396fbfcaf8 100644
> --- a/arch/arm/boot/dts/nxp/imx/imx7d-sdb.dts
> +++ b/arch/arm/boot/dts/nxp/imx/imx7d-sdb.dts
> @@ -493,6 +493,7 @@ &usdhc1 {
>         vmmc-supply =3D <&reg_sd1_vmmc>;
>         wakeup-source;
>         keep-power-in-suspend;
> +       fsl,tuning-step =3D <2>;

I wondering if this should be a imx7s.dtsi property instead.

NXP vendor kernel passes:

fsl,tuning-step =3D <2>;
fsl,tuning-start-tap =3D <20>;

https://github.com/nxp-imx/linux-imx/blob/lf-6.1.y/arch/arm/boot/dts/imx7s.=
dtsi#L1216-L1217

Bough? Any suggestions?

Thanks
