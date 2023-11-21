Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0247F34DE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 18:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233792AbjKURXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 12:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjKURXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 12:23:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9452EBA
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 09:23:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D246C433C8;
        Tue, 21 Nov 2023 17:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700587394;
        bh=A1AiSQpqc9fSmXMRgtqpneZpzFCfm1C+I4tLcYy9+1I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rKpUi+HbhkedgyawXuAgVWI8M32Lb0+oSiTHmpElgAGaUGuQZLK/6LQOni/4vFo5L
         QRfE/wnyvfauMSciswNkc1mumPWA1jh/QqckcBAOFt8cqno538OYYYfULcnChDJgV0
         midvg34doNwwxtRTKdI+tnsyzChDeDSU6fNYq/myf7/06CuZED0S0yPu2xxdXtwa1X
         4Gr7Y/L32XSkUtEj8ZJnFWTpcI5OwAQ+94lCyc3DVrOMMjBTuB8Meagra15dBunzYy
         ie56rkJjkAWF5b0ubvmH65O2PUvC9owO9GobraqpnpqLmxQsED27zCVxj5lOIS/Hqm
         TvAYrLIwZDlpg==
Date:   Tue, 21 Nov 2023 17:23:09 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH] selftests/kvm: fix compilation on non-x86_64 platforms
Message-ID: <ZVznfV5SshVSNo5W@finisterre.sirena.org.uk>
References: <20231121165915.1170987-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p0jBt5KgZ6HnGNEY"
Content-Disposition: inline
In-Reply-To: <20231121165915.1170987-1-pbonzini@redhat.com>
X-Cookie: Slow day.  Practice crawling.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--p0jBt5KgZ6HnGNEY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 21, 2023 at 11:59:15AM -0500, Paolo Bonzini wrote:
> MEM_REGION_SLOT and MEM_REGION_GPA are not really needed in
> test_invalid_memory_region_flags; the VM never runs and there are no
> other slots, so it is okay to use slot 0 and place it at address
> zero.  This fixes compilation on architectures that do not
> define them.

Tested-by: Mark Brown <broonie@kernel.org>

Thanks, this'll make my CI and work's a lot happer!

--p0jBt5KgZ6HnGNEY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVc53wACgkQJNaLcl1U
h9BA3Af/dWbj2WKnUQYaHRAqg4nALwzxtfblwa2g67kTovBfJyYus9h2EBUgIqiI
yb/glPQ12njZ5sdKFYdQhAHtcIH+wYKbqSDg/Ux7bTCkIhhT8LsSfQ9MS5d2tDCz
OG9tSD3SFPIgCWAH1kOXuzjwcBStWHy1e23zACSNho8ruZgTJUN5HlYABOIndvKD
jTxQVFhPDwuZdgZlRuGl7nXXSWS+xH4kBa2NMLD2J7KSfs0QlYoNyHdDP5pBBr9u
ZD+f82/n8i/WimCsRQBYBjxRZw3sjrJoU8EhAdxTG3GzluRbVd1Gs20Z9Sqty0qq
FeXklR1hVd+fGDtBT6oHtPesmxvHug==
=UUpO
-----END PGP SIGNATURE-----

--p0jBt5KgZ6HnGNEY--
