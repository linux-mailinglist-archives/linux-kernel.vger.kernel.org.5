Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D18C7C85E2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 14:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjJMMgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 08:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjJMMgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 08:36:49 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90D2A9;
        Fri, 13 Oct 2023 05:36:47 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9b9a494cc59so316950566b.3;
        Fri, 13 Oct 2023 05:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697200606; x=1697805406; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0C6tIoiijLTtT+75VUTeLzgpS9L0HrenMWqwMttVMu0=;
        b=RlzXuYL9q/F/FU7z9UraYjZlBI02C+YVWp6dFNvvprzjJENbA0yVIFFzVLzvvJY8MJ
         M2/X9XX5swQW24ZSnFXtSoyr5jBZs/DVt/4xGnA8cOmSO619lXMMJmKGvvTqM/blx+Ky
         TD+Lg7ka0QLMqNcOh2TAeRiUgGzKVL9qauEfhxCrj0vZIbGskpzHi4BQxvdiL/wBLDFl
         qESFyhcNIXpLQxnw7RfEgsoLThJiObKRVlrmfE0I9RXq0nw85vYCCNS4Tho8yq4HszgI
         xzCrIqkmR5xoTuxZwTbwj03f3N4sb2HKOcCiJKUmAWoq3o+X+V7bDqQjdi7KTaxZttI/
         /jUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697200606; x=1697805406;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0C6tIoiijLTtT+75VUTeLzgpS9L0HrenMWqwMttVMu0=;
        b=Z7/zQuTyickOMMd76DJsLSuVsOVw5YtFwo7KD1g+nuOJrXcuh8tIUt/Eu7dL2xLuUu
         tzpanfqFpm1BqTj0siPl7lzpmRhlagX/dXHQQKcn6wJAN2TXRAJFXKI+1An9+XbSjVoV
         TVN+jtEvJHx5tNMrZErs8F3CE3/4TMiQt1jvBlNL5NwR99X3ZffjGJCBdBHkRkr73+9w
         IsEq4dTXYlEcKEdEpo0rT6Zt9kjESjDVXz18gGTZrd2qe3jTF9HV+h6FfRtAG3ennyWK
         rh1X8r0SYWyxrgunsZylq2tYzDoIVMHYLPBll0Fw7nr+c2DAsMF70lWqWQ7arqDop4/7
         xkog==
X-Gm-Message-State: AOJu0YzQM92w9qmPqRizQlL+12kROjBfwthPwk4xe86HKAlQPnzu2ptX
        KYy1FbMP6l1W8lLUNzW4QZs=
X-Google-Smtp-Source: AGHT+IG7QP1VFb85+PxzKKSfG/X7ixlci4TjfPSx2zFvc56hmLPQAULdqzc5DjRo1Aotu6WbzyX+kQ==
X-Received: by 2002:a17:906:c145:b0:9bd:dfaa:3f3 with SMTP id dp5-20020a170906c14500b009bddfaa03f3mr456625ejc.7.1697200605846;
        Fri, 13 Oct 2023 05:36:45 -0700 (PDT)
Received: from orome.fritz.box (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id qq16-20020a17090720d000b0099bd046170fsm12242327ejb.104.2023.10.13.05.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 05:36:45 -0700 (PDT)
Date:   Fri, 13 Oct 2023 14:36:44 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     jonathanh@nvidia.com, krzysztof.kozlowski@linaro.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sumit Gupta <sumitg@nvidia.com>
Cc:     bbasu@nvidia.com
Subject: Re: (subset) [Patch v2 0/2] Fix hang due to CPU BW request as BPMP
 suspended
Message-ID: <ZSk53KRLZK-i3ETU@orome.fritz.box>
References: <20231009100557.18224-1-sumitg@nvidia.com>
 <169719989291.3880029.32092032379655248.b4-ty@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xPadoHu6msBICJZc"
Content-Disposition: inline
In-Reply-To: <169719989291.3880029.32092032379655248.b4-ty@nvidia.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xPadoHu6msBICJZc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 13, 2023 at 02:25:12PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>=20
>=20
> On Mon, 09 Oct 2023 15:35:55 +0530, Sumit Gupta wrote:
> > This patch set fixes hang during system resume which started coming
> > after adding Memory Interconnect and OPP support to the Tegra194 CPUFREQ
> > in below change:
> >  f41e1442ac5b ("cpufreq: tegra194: add OPP support and set bandwidth").
> >=20
> > Tegra194 CPUFREQ driver uses 'CPUFREQ_NEED_INITIAL_FREQ_CHECK' flag
> > which causes a CPU frequency set request from the 'cpuhp_cpufreq_online'
> > hotplug notifier during resume. The CPU frequency set call also triggers
> > a DRAM bandwidth set request but the BPMP driver hasn't resumed yet
> > which results in hang during resume.
> >=20
> > [...]
>=20
> Applied, thanks!
>=20
> [2/2] memory: tegra: set BPMP msg flags to reset IPC channels
>       (no commit info)

For the record, I've actually applied both patches, but applying them to
different branches (i.e. resulting in two subsets for the same series)
seems to have confused b4.

Thierry

--xPadoHu6msBICJZc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmUpOdsACgkQ3SOs138+
s6FNNw/6AttQEb6WuhN2Jh8tdrfhcHEQ+OKShZDnjm4IpDmS0vXpuAhbLN1rBOhP
VsXQr+78ZY7lpSJosm87zshJerTroNE+XlXurlHDHZxeYcq6Pb7HfU+GGPMmE/Qu
8locag/FtqZ8V3RAx9N0EtWjosNK84x9zr6n4oM4go7AhI3X6wJpvZGrFRTfBWO8
NWQBUUQ/l6eJyaf0RSyFQvACfas1jXT7WNF2golKMe2VK7tdMG8r3NpsHxCyNSxa
R27TmwlvYAF4ZYFHPZySeTSJI6IFAuFlBl/6/MODyTZOdey1nqRMJlDRj/4aWr4D
oNOEo1SMWrAWLJzIV/wXg7DJk+KjpoN6KTNYEUS0mnEvNp5RzhiaO00wglKA/OxL
CaZJfgyWEReVTrk9MiLZQA9sSzD0ZvikTMoZC3Ob2Tpp3xSnM96eCtNZU0u3MkIu
cqkmLj6xIaTh+G/nSXy+dK28v9uJ9JdXEd9lxBOr39jPRwjceeGQic0tKQ1QTWSq
d62E3W35AyUR27Kv60vzIgYYtZv5ctwI/RG77zlvUnAfy8RyS0Gw8qFloJ1VA3NA
1bj7xTActAO/DWjMvp0Vfm4CrVb6JguzibcW5IReYrFPPtuD2BXfgZhEeKmuexcm
JhrprtCVWlRXrBPJcchmNNpwjdYxDvB6f3n1t+c7QSQWwdl7glg=
=/40N
-----END PGP SIGNATURE-----

--xPadoHu6msBICJZc--
