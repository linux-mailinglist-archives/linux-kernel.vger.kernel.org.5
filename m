Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9BB783B39
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 09:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbjHVHzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 03:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbjHVHzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 03:55:35 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F9D12C;
        Tue, 22 Aug 2023 00:55:34 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3179ed1dfbbso3902627f8f.1;
        Tue, 22 Aug 2023 00:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692690933; x=1693295733;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Pyw7HPK+xHieuJcUWxvPWFNip6TqzROQ+caJEui+Sw=;
        b=hNxYkbqaXZY6G1gX3OHllwQY96THYAEYI6lmNEJ06Rp4qaMJiMQuL4dSXUvmRR5yHH
         IehXqKAwxryb6T8TLbqE6DhCN9NTE0SScbhKIb2wbRVNBuRNclghNolhaX+kWUiOAiq7
         aTwHaaVsfG3qwuh+GNS+U9s48LZJg+1ZaeMH3UhAv/e0UEibKGgwRiAIYuEXwM7rAy5k
         7hsqiM4dFr9e2AjEsNy5mLaX6ga0XMUdFvAtbmHdqr7EsrFjpMZ27MGXQJh5HWX8e1QD
         Xc349GvZHCfLoReXzZ4gKmC2y6Qrge4pYfwnfcPKBYgKQUvR9ouz95OsY50+KpsQbden
         TGTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692690933; x=1693295733;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Pyw7HPK+xHieuJcUWxvPWFNip6TqzROQ+caJEui+Sw=;
        b=FpBjzK1n7vjOosOK9vBnGnNjycocu66G3tiDav3t2RAR06m5oslsYHGTuiBYAt2969
         XaYsH7N2gs2y4RWEb4f5bAL8AD9FeKMsXcs1Fp265X3fqsw00WKbxTN5D+NH/BSwdtR1
         YZQYggFyfYO159KvSyJTpjcEseoRHiTeri71CNfLpvraHIjPEYAwZLNAZm6OzYTny/Lb
         wZi4k9eTQV8xknXzzctF7Cxn7McOEXqBZYyEgBd4jY7vlr4dii9JJA8W/V+DtPTXZS8u
         93ePqAUs6lgQvN+gcWAIdRgNw2u+42HEoKjrkgjjF2KrruxbSifIz2k2RMTNYJR+4/D/
         ebsw==
X-Gm-Message-State: AOJu0YxCR7wauT36xEQPsDdTBtc1m9shc3Z1yuOCPuMZj2iOhyVcF1Ov
        xePvWcLpJovGZsq9RP2gR9xTAN+YY4w=
X-Google-Smtp-Source: AGHT+IFmBEpq5gk7+dXAFv8bYJ2V6eP47ALqdwODVT0Pl7xU05uLvOja2iHwLjTzNYErcCVzdrG7mw==
X-Received: by 2002:a05:6000:10b:b0:317:6849:2d39 with SMTP id o11-20020a056000010b00b0031768492d39mr6291650wrx.10.1692690932594;
        Tue, 22 Aug 2023 00:55:32 -0700 (PDT)
Received: from orome (p200300e41f1bd600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1b:d600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id s7-20020a5d69c7000000b0031c5ee51638sm2049572wrw.109.2023.08.22.00.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 00:55:32 -0700 (PDT)
Date:   Tue, 22 Aug 2023 09:55:30 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Kartik <kkartik@nvidia.com>
Cc:     jonathanh@nvidia.com, sumitg@nvidia.com, arnd@arndb.de,
        pshete@nvidia.co, andriy.shevchenko@linux.intel.com,
        digetx@gmail.com, petlozup@nvidia.com, windhl@126.com,
        frank.li@vivo.com, robh@kernel.org, stefank@nvidia.com,
        pdeschrijver@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] soc/tegra: fuse: Add function to print SKU info
Message-ID: <ZORp8n6c3TrpiFiA@orome>
References: <20230818093028.7807-1-kkartik@nvidia.com>
 <20230818093028.7807-5-kkartik@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RKs60H4+8uOWGCre"
Content-Disposition: inline
In-Reply-To: <20230818093028.7807-5-kkartik@nvidia.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RKs60H4+8uOWGCre
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 18, 2023 at 03:00:26PM +0530, Kartik wrote:
> Add helper function tegra_fuse_pr_sku_info() to print Tegra SKU

Nit: I'd prefer tegra_fuse_print_sku_info(). This is already quite long,
so the extra 3 characters aren't going to make things a lot worse, but
they improve readability quite a bit.

Thierry

--RKs60H4+8uOWGCre
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmTkafIACgkQ3SOs138+
s6EFDRAAnYqGBgan06elWAHrHHRw2s75niOr04MaZs4dxVPwY5JZBtnq58e4xEzA
NX2Q58ZNWe5llkvQbJJltM9V2WYlstDd/5dhrdAH/HYAZwDhDj8DimggwblkBNdS
iYQ5ABx26KDZNGPNFGKA2gsLoPTpTgiWwT9JW4q7KZalku0fJmeQ8z5tldZ1qShk
ffVboREpI8xpIjQSwZ3IrluKJ/aTNBqmWoyyIDwI2eS2Urx8kgStgyotobEhSHfO
D2Ef1JAS9YoggHsKwUdz0M72IMp3GTL+Gg1XrNCjaf2SBWh8EPI+sh3nahK0/X6R
wKtCXEeuQL+qc2HfUYPqqhCm4tyLw4+Ler50el2n7Dtvz6JfkhP72ZVpxF7IzFtx
35BV/YmVoPBFRCQYtSXqfE4fxk5ZxBGzPhKsxlpv2fEo78L/QFxIYIQonJMv15az
gYVLy40A4/rTHgYRnHTNfAHuB6/57TMIVmaCyGj0Zk2EnX2EytAM/HMcwTvQ3IBb
qChok/+XMT90cu1M9eAuHJf1jCrFv075XkI95KxoUJLsjjDs8D/+C5bbF3Ac1bk9
8w0AhKcZjvn4Lb43u7U1dSjqGTZ6tX92OSSTXvhEov5cVKORcXEVfcTPn54Q3HNY
fFI63I3odn8r8YjQ1Qtdnk4rxcEH0IQCx5tQXpEsc5j/LN1Gx7M=
=L1cY
-----END PGP SIGNATURE-----

--RKs60H4+8uOWGCre--
