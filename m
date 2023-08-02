Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 210ED76D976
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 23:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbjHBV1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 17:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbjHBV07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 17:26:59 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDBDE6F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 14:26:54 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3a36b30aa7bso160456b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 14:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691011614; x=1691616414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jUEKuWb/qRWGPcwpGm7URWDdQ7oovJb2rcmtaobVWAE=;
        b=RtvSGxJ+mav+wPCHXdVYU99ayoscEV2EM98/HQ0bElZBkBhCnY52dJk3jZmCfir+bQ
         L8eAzwIAR2sBr3vw3uj7w5jHFASc0kRvhRLops40/wOaRkGdBtQZL0B2JXDVUq/DTidq
         UwYpDpC3VbqG8FBd2+huJtyaBTMmNB05ZP73hP+qD1Exlyqr9dr1fWYofRcuCA2WmTzd
         XRXdvyboVi8POQ/f4NS95xvWVD4BwvCCGv2lTwbCaaz6EbycEglhuXXD6usNr6E/nU6f
         gM0GDl24nkATrFuswOptpea2z3rdCPAdNGFYtmJQnrRsSO3UrYwln4f4QN4w4WrqQg+Q
         GYNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691011614; x=1691616414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jUEKuWb/qRWGPcwpGm7URWDdQ7oovJb2rcmtaobVWAE=;
        b=mE74ByK590kynAA0p0BgYbd2Zg8wY6Db/b1u/040J4JTmBGzGBG5NPpv8in9Mm2S8C
         BBDxYTjkJulIC6r/INNX31+Eexn9NxDehQIWff+xhaOsysD0qV170xzS+sPhwM1MesEA
         bwXs/DP7n3sUHOROf9XY2CFPi8yui1OXk0xnuuRKhVd0OMXGi6hegpNVkwZL8aHAfzb9
         EGjcPuQamPEZkMZf/5WLmLkhcL6QomFfMSDvb6qP2SLxSJTZoJYiJKkvgHSoW1+HGun5
         hKX2tcdw9zksUa77qbZMyqJPExGuBsz4dLevUp/0dE62LtPrcK+zTItZDj1IvcM+igh7
         DGcA==
X-Gm-Message-State: ABy/qLYWcoUe2DO/gFX4w0m0tRo/LmERu90QK62qWUhzeEmo9Jbp4HnS
        BL/N++qLHbJ1qyC54o3QchgtiipAhTQKe3HIOncEJQ==
X-Google-Smtp-Source: APBJJlEfMzUewc9dWiMhV1sSjAHIMUeF38rrKJ7dqV5L8zFEEuQ4WO4ftfNL1eREbhXHWSw8qo+hdp/PdFdD1O7e0SY=
X-Received: by 2002:a05:6358:6f8d:b0:133:eff:39c with SMTP id
 s13-20020a0563586f8d00b001330eff039cmr6979151rwn.20.1691011614061; Wed, 02
 Aug 2023 14:26:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230802092647.3000666-1-sergio.paracuellos@gmail.com>
In-Reply-To: <20230802092647.3000666-1-sergio.paracuellos@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 2 Aug 2023 14:26:43 -0700
Message-ID: <CAKwvOd=SvHUPd8+sWtqgxghPEciD5sqPiggZx+OOEqxtJrML6Q@mail.gmail.com>
Subject: Re: [PATCH] clk: ralink: mtmips: quiet unused variable warning
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
Cc:     linux-clk@vger.kernel.org, tsbogend@alpha.franken.de,
        sboyd@kernel.org, mturquette@baylibre.com,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 2, 2023 at 2:26=E2=80=AFAM Sergio Paracuellos
<sergio.paracuellos@gmail.com> wrote:
>
> When CONFIG_OF is disabled then the matching table is not referenced and
> the following warning appears:
>
> drivers/clk/ralink/clk-mtmips.c:821:34: warning: unused variable 'mtmips_=
of_match' [-Wunused-const-variable]
> 821 |   static const struct of_device_id mtmips_of_match[] =3D {
>     |                          ^
>
> Silence it declaring 'mtmips_of_match' with '__maybe_unused'.
>
> Fixes: 6f3b15586eef ("clk: ralink: add clock and reset driver for MTMIPS =
SoCs")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202307242310.CdOnd2py-lkp@i=
ntel.com/
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

I think this is fine; Arnd or Nathan do you have a preference? or thoughts =
here?

If not, thanks for the patch.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

(I have a slight preference for wrapping the use in `#ifdef CONFIG_OF`
since with the approach used by this patch, if all users are removed
we will never get a warning for this var. But it's a weak preference;
it's more important to me that we don't have -Werror promote this
warning to a build breakage)

> ---
>  drivers/clk/ralink/clk-mtmips.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/ralink/clk-mtmips.c b/drivers/clk/ralink/clk-mtm=
ips.c
> index 1e7991439527..6716394b28a3 100644
> --- a/drivers/clk/ralink/clk-mtmips.c
> +++ b/drivers/clk/ralink/clk-mtmips.c
> @@ -820,7 +820,7 @@ static const struct mtmips_clk_data mt76x8_clk_data =
=3D {
>         .num_clk_periph =3D ARRAY_SIZE(mt76x8_pherip_clks),
>  };
>
> -static const struct of_device_id mtmips_of_match[] =3D {
> +static const __maybe_unused struct of_device_id mtmips_of_match[] =3D {
>         {
>                 .compatible =3D "ralink,rt2880-sysc",
>                 .data =3D &rt2880_clk_data,
> --
> 2.25.1
>


--=20
Thanks,
~Nick Desaulniers
