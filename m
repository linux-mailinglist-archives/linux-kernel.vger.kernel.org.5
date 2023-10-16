Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C507CA4F0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 12:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbjJPKMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 06:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232591AbjJPKMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 06:12:32 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7368D9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 03:12:29 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d9a7a3e17d1so5001413276.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 03:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697451149; x=1698055949; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sOqwohzYX+crYtYe7hq9X/d+XgTn23JPYuyixtE0r2I=;
        b=n0WQD/5sZb0nEt66pX2EX92//dgko3/wDQw8+0YbUpp7uPad75X37Tj7r649+/0jKW
         E8UeQslEq5vl/HqwGgYoF4YGN2W2J0GZ4tE1Vx7vTy+zrOia+QeOHM+SSI2cvjQUKLOI
         adVpTXOx4PG6lgiNufmnGUVRKOYU3anoRXWPtuQLwvcKeNShs8cnxyVbDaaakIbIzMWi
         2nZ9EmRcmSSQaC5c+NQC5DxpeSBKP081OElq1HW0nHTBL8eu/od1+2F7GorH51DqZlc3
         mEJJd0n5v2v0nc2xQHCqT7LkrRYVeSDV+pOV27fZYY69amiXE3FgepTbHX8fn7HkXNO9
         RLUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697451149; x=1698055949;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sOqwohzYX+crYtYe7hq9X/d+XgTn23JPYuyixtE0r2I=;
        b=wMUgyIzxCwDIoA3ILGpjE/ZjjT6u1jEqJiwEpsFXG66gO9vqJnzk68uwm2T1vNzGUO
         n734kO5Bc5NTEmokFfjcBsFQ7Am+j3wPb1m0mI0/bbNDDvsU6dzxKlmeZsmNdgsq/D34
         6i5DsX9dimxShgmCn8DAUpu01O8o9iqGa4hjeyUx/lXR73UTopp2Np36GozYyBAg5b1W
         04k0TLJhaTkGXj6dZArGxZLtP5Pgg2S8YAa9weHlatpbBRd2xeRrc00SM9TPlE0kNzIA
         aMVHvE9l0LbNhMzhv/eh67ZZIU6FkvcbJAwvfg4d6v+BUSm9E/yjAoZPRKcoGvYUcsDc
         ArNg==
X-Gm-Message-State: AOJu0YxdpPKhvnBmTzu0RZ6DKaYmnixcrpGUthLV7IZF+C7D17cHZkOs
        OseKo3M7O3T8EnJLXFDgbhSIP7ucXZ26XNQTDjYFHA==
X-Google-Smtp-Source: AGHT+IHv6ZpEf8y1gqS/s/DwsEUsJ45Zh4a4dm5PAsnnxhTKvZyh/2ejz9HT4AtoCuBLpn9pc1a2ZtHVCQy9KTBCiVM=
X-Received: by 2002:a25:33c4:0:b0:d86:57ff:210c with SMTP id
 z187-20020a2533c4000000b00d8657ff210cmr32152187ybz.17.1697451149170; Mon, 16
 Oct 2023 03:12:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697186772.git.viresh.kumar@linaro.org> <4cd8fe2135128168c1cd80482359dc7a46550085.1697186772.git.viresh.kumar@linaro.org>
In-Reply-To: <4cd8fe2135128168c1cd80482359dc7a46550085.1697186772.git.viresh.kumar@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 16 Oct 2023 12:11:53 +0200
Message-ID: <CAPDyKFosOx_nVuMRc+YS58Tc3rMbVnv8Yz6WXhGUVtbYnu+2DQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] OPP: No need to defer probe from _opp_attach_genpd()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Oct 2023 at 10:49, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> When the new interface for attaching genpd's via the OPP core was added,
> it was possible for required_opp_count to be zero, but not anymore.
>
> Remove the unused check.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>  drivers/opp/core.c | 8 --------
>  1 file changed, 8 deletions(-)
>
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index befe46036ad5..c069aabefa00 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -2430,14 +2430,6 @@ static int _opp_attach_genpd(struct opp_table *opp_table, struct device *dev,
>         if (opp_table->genpd_virt_devs)
>                 return 0;
>
> -       /*
> -        * If the genpd's OPP table isn't already initialized, parsing of the
> -        * required-opps fail for dev. We should retry this after genpd's OPP
> -        * table is added.
> -        */
> -       if (!opp_table->required_opp_count)
> -               return -EPROBE_DEFER;
> -
>         opp_table->genpd_virt_devs = kcalloc(opp_table->required_opp_count,
>                                              sizeof(*opp_table->genpd_virt_devs),
>                                              GFP_KERNEL);
> --
> 2.31.1.272.g89b43f80a514
>
