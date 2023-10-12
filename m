Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66C57C6BBF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 13:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377996AbjJLLBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 07:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343843AbjJLLBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 07:01:25 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870B490;
        Thu, 12 Oct 2023 04:01:24 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-523100882f2so1427056a12.2;
        Thu, 12 Oct 2023 04:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697108483; x=1697713283; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MvxkMe9RfyanvHhkjVecXnsiPB+ZPMYaNZs5zsO5BTk=;
        b=IEL5FVunqmWxumI+USq4LzZAtbm0+TUAANWm3Hf4wDgf6N+acB5xK3lhPHrup5sgqs
         Bgz6JeiGW3RQ0V5gtxwQAVSMywUmMOA7rnMhvA1rQXF91XoqE79REbJ8PMEzNLDFJFy0
         2CwjDhb9XH2bOdx0/28N2f6pevPoZe5Q7DkvFT0fZTUt3RjeQNR2eocZpegOKuA+MQT+
         g0hnOj4FrS8T7pWtbqTfvETMYtyu22veKwOLeV4xML3/G99creeVAfPHPvU28nCAttRn
         nbzVDasRixvhpt065GRz3NxZ6dAOGndO2FSlJsiyWEj2WucQ7ag5Rjb4xq6kvMKOrad6
         Ry5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697108483; x=1697713283;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MvxkMe9RfyanvHhkjVecXnsiPB+ZPMYaNZs5zsO5BTk=;
        b=LNDF0LCHRd5/ZiXMKb7nvYWQ4DUWC10VxOspwhqBW62AUmqU2JrSk1e8ik8DR9sMmz
         Q4vmdod14HQZurOd2uEL3M4ijSp4FZRgExDlhxmcbNyNoDQy1Y1N3lM5CyJjs45bEgem
         RdDeIMgUKHE+zQd+gHo5SLy6ecqvqkhOL79Xr3u7Y3ELXmB2rs5r+dZd8z5bwc/2S/aW
         N0W9t9iS/7ubkcQWNbA1TkfOEgYhYExPSP0Yeftu2ZeBNM5O4HNA2cweDSee7gSqH83E
         DmhTeB4IhAHmzGpDu+fNhu5b1U7xwxGO1ZFa3ir7dQYEPAfHGWvxfSd/yCfjmTVzN7ud
         tfUw==
X-Gm-Message-State: AOJu0YyGBH8O92c72Dunq+CDvpm07/zKAQwzeSrBTTJL5z3/VjEyrCm2
        b+YoOc9J0MwGYxGR/T95A5A=
X-Google-Smtp-Source: AGHT+IFwb1O5ro5ipJuz+EbMGwI3AbBUSgRzfZ2l/zYUaiJXtPzHDtCU1Ovu/0MGA2ra6VOCw5pbgg==
X-Received: by 2002:a17:906:8a51:b0:9a6:5696:3887 with SMTP id gx17-20020a1709068a5100b009a656963887mr20471909ejc.59.1697108482494;
        Thu, 12 Oct 2023 04:01:22 -0700 (PDT)
Received: from orome.fritz.box (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id u2-20020a17090617c200b009ad8084e08asm10774126eje.0.2023.10.12.04.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 04:01:21 -0700 (PDT)
Date:   Thu, 12 Oct 2023 13:01:20 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     treding@nvidia.com, jonathanh@nvidia.com,
        krzysztof.kozlowski@linaro.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, bbasu@nvidia.com
Subject: Re: [Patch v2 1/2] firmware: tegra: add suspend hook and reset BPMP
 IPC early on resume
Message-ID: <ZSfSACoBr1rDF4Gk@orome.fritz.box>
References: <20231009100557.18224-1-sumitg@nvidia.com>
 <20231009100557.18224-2-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FpRCwFCpfPlEo1jF"
Content-Disposition: inline
In-Reply-To: <20231009100557.18224-2-sumitg@nvidia.com>
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


--FpRCwFCpfPlEo1jF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 09, 2023 at 03:35:56PM +0530, Sumit Gupta wrote:
> Add suspend hook and a 'suspended' field in the 'struct tegra_bpmp'
> to mark if BPMP is suspended. Also, add a 'flags' field in the
> 'struct tegra_bpmp_message' whose 'TEGRA_BPMP_MESSAGE_RESET' bit
> can be set from the Tegra MC driver to signal that the reset of BPMP
> IPC channels is required before sending MRQ to the BPMP FW.
> Together both the fields allow us to handle any requests that might
> be sent too soon as they can cause hang during system resume.
> One case where we see BPMP requests being sent before the BPMP driver
> has resumed is the memory bandwidth requests which are triggered by
> onlining the CPUs during system resume. The CPUs are onlined before
> the BPMP has resumed and we need to reset the BPMP IPC channels to
> handle these requests.
> The additional check for 'flags' is done to avoid any un-intended BPMP
> IPC reset if the tegra_bpmp_transfer*() API gets called during suspend
> sequence after the BPMP driver is suspended.
>=20
> Fixes: f41e1442ac5b ("cpufreq: tegra194: add OPP support and set bandwidt=
h")
> Co-developed-by: Thierry Reding <treding@nvidia.com>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/firmware/tegra/bpmp.c | 30 ++++++++++++++++++++++++++++++
>  include/soc/tegra/bpmp.h      |  6 ++++++
>  2 files changed, 36 insertions(+)

Krzysztof,

if you want to pick these up instead of me taking them through the Tegra
tree:

Acked-by: Thierry Reding <treding@nvidia.com>

--FpRCwFCpfPlEo1jF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmUn0gAACgkQ3SOs138+
s6ElRA/8C3rhydYi5I9CFwLC0jWTL9qvnq5w4IRFApPQkFOziQZ7Qt/7tngMYDLA
IwsU2evqHj7la/NJFQlf5BxN+fUzlMtzuj3ibtyZToJYU1eZM4vV9SJP/s6j0AML
2+1bMco+JWhsjPyIXsp995YsLBJ442JMqXLXnXbprg+mP7qpU4lVJm4Elkp8U1Rn
qxqCBTKR9zdLVTV3d85K8ATEp5jll1MkQhayPRPUgN5EmEXvjjiknWjpO/M1+emC
1y0Ng0UDYe206mgyYlElyQy9+3yp/jDU36yM3FHl0KLmEUXsjfv3HyiKwaCyxrXA
BlXuPSDE48Lo4W/n42sxHvuyEQguHfKvTvuBgfX9RnDsI0eGNW7whhdIhs58cDaK
mpF8LDfqkA9ukma2Esy/SHmo1btSXaiB2skC5aHXDCRtWJGZ+19YRR+tK+auX2y5
BTvr67fZ5xJKjuPAXtNWP32myBR0PoWvEa8oayGtZeG86sCQ+Jxs1UyprOizZ6cr
8DxK2Ko+Sh0G/N679lsjK7wOupd7qV/2O+ICnz4RmaaOyUw1yRzXtlwInWEG7VVd
KR0AXdG6wIrvAEtP/qeyIVUs0TIw5ERt2cZkE4Awb9xw1KXdJKM89jTIjDQBRSrY
Wk17pFz57Nz3jbC1ghJLsnY5i1ujcubGG8IxHj4DXE5DT4OFOEI=
=3TXZ
-----END PGP SIGNATURE-----

--FpRCwFCpfPlEo1jF--
