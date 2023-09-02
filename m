Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425EC790780
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 12:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352031AbjIBK5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 06:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238180AbjIBK5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 06:57:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E2B12D;
        Sat,  2 Sep 2023 03:57:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B201602E0;
        Sat,  2 Sep 2023 10:57:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 679D7C433C8;
        Sat,  2 Sep 2023 10:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693652262;
        bh=bT880HRAHTg093m0k1X5BqXi6ae7927qarFE1Li5t5A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H1zpkGPZJlfWzBR4wRPRsxyVY9nodEIBmcgwz3iARi5Gu7fHg8PZhO5wrqSvRAdVt
         1a0BzQgWyArN64ZyWPwFl2enpzrWkVwUTuk9VMRkfMTIfwp4wVo4qJWPEPD1yCmPaJ
         qAr6qTKhEPlE1WmNm3yoRpRld96MWxWXHnrzwKL5DupCd8S5UDlbFL/dktEPhI2Ou5
         kXFwFM/db6YEmoD22jP5t+6YVhz60B57OGItix1du61I7pu0PnXTrjyWw2rHDIXUoD
         BhsAeqM0gX7nprsS1Z8RdpZZfwpsoY8YMAW70bI5CPT/mfWZDjYeF6yJ8GxRbDuDvM
         xnp1BD4/4JmFQ==
Date:   Sat, 2 Sep 2023 11:57:35 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-pm@vger.kernel.org, conor.dooley@microchip.com,
        suagrfillet@gmail.com, ajones@ventanamicro.com, lftan@kernel.org
Subject: Re: [PATCH 3/4] cpufreq/schedutil: use a fixed reference frequency
Message-ID: <20230902-clip-shortly-c9af45460915@spud>
References: <20230901130312.247719-1-vincent.guittot@linaro.org>
 <20230901130312.247719-4-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hbuDC/hObmFDzy3k"
Content-Disposition: inline
In-Reply-To: <20230901130312.247719-4-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hbuDC/hObmFDzy3k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 01, 2023 at 03:03:11PM +0200, Vincent Guittot wrote:

> +#ifdef arch_scale_freq_ref
> +/**
> + * arch_scale_freq_ref_policy - get the reference frequency of a given CPU that
> + * has been used to correlate frequency and compute capacity.
> + * @cpu: the CPU in question.

Copy-pasting fail? That's not what your parameter is called.

> + *
> + * Return: the reference CPU frequency.
> + */
> +static __always_inline
> +unsigned long  arch_scale_freq_ref_policy(struct cpufreq_policy *policy)

--hbuDC/hObmFDzy3k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZPMVHgAKCRB4tDGHoIJi
0s6XAP4jMpeTFFLjakOgVS/UBIHhbCJsiwI5gp2cw9MfBFMfYAD/ZhOUlbrUT4gF
FxgcXOif8c9nBARo6fmstL6oTNc/3gk=
=C74W
-----END PGP SIGNATURE-----

--hbuDC/hObmFDzy3k--
