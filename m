Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC357EB89B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 22:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234090AbjKNV1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 16:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbjKNV1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 16:27:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F6F9D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 13:27:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A6F1C433C7;
        Tue, 14 Nov 2023 21:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699997267;
        bh=9ZG+AI0fj8e2HRbIkqu4+FdTFxFjv/se3KzEuXLYjE4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HbOwQLkUw5smV9aA4vlMU3nBnCLux1jYUWonswLnx/gA1I1q720MF1kd6lE0Qi8Ik
         5Rz7sRRCZgM9XaIHOTtcibx1VkiTsUjmbwIZxRPab0tcQBm8Wr9LaxU/Bp1k0giRRA
         E2OiD5RtqesBxSLMAhsZefkWnkSGmnVlFAuZHjJIiFv0T+nD/mltv2xS4u8n2UZL5f
         YAeXfZB3cgkLAwFd6Krh+hGDEWL4CSXvDVLRZOnYofv4mRLNwQO0igm/3gxEJzKHJm
         am9WSpEgVOYbpJuFOEzBQG9EjZvBa0saSwKXMgpYKVzAx1O4LbHgxe8EsAr1CLzq4E
         35U4ARqDTtT5Q==
Date:   Tue, 14 Nov 2023 21:27:44 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Drew Fustini <dfustini@baylibre.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Fu Wei <wefu@redhat.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v6 5/7] riscv: dts: thead: Add TH1520 mmc controllers and
 sdhci clock
Message-ID: <20231114-starring-swarm-0e1b641f888c@squawk>
References: <20231114-th1520-mmc-v6-0-3273c661a571@baylibre.com>
 <20231114-th1520-mmc-v6-5-3273c661a571@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="luEG+7A6lTHoA2TH"
Content-Disposition: inline
In-Reply-To: <20231114-th1520-mmc-v6-5-3273c661a571@baylibre.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--luEG+7A6lTHoA2TH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 14, 2023 at 04:07:59PM -0500, Drew Fustini wrote:

> +	sdhci_clk: sdhci-clock {
> +		compatible = "fixed-clock";
> +		clock-frequency = <198000000>;
> +		clock-output-names = "sdhci_clk";
> +		#clock-cells = <0>;
> +	};

If only you had a clock driver to provide these...

Is someone working on a resubmission of the clock driver?

--luEG+7A6lTHoA2TH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVPmTQAKCRB4tDGHoIJi
0lBuAP9U7s7Dc8QCdpB5PoIv2t5+2ZksodPnAE+UTFB0b2B4iwEA/05GHKJqoHi1
lD5+SQ6yUh9/FlIek1FwIChWYiF72As=
=O9oG
-----END PGP SIGNATURE-----

--luEG+7A6lTHoA2TH--
