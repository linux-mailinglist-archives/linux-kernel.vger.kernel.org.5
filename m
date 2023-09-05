Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8F2792501
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234315AbjIEQAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354517AbjIEMLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 08:11:10 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3341D12A
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 05:11:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5A75ACE113D
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 12:11:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 958A3C433CA;
        Tue,  5 Sep 2023 12:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693915862;
        bh=t9xypQL9zL3DNGu9AYpXUQw6SSdWKkSm+5Iht8Xwh2U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WU/YD13TZ++YOfqMBQXeDFj75Ryx80Kz8RXpeolotxpnFAv3i03dqB5bn7NT+jCxu
         jkBx6ypmTq9XOjc9M7HQ6vkQmXXMWxE3rms1nBD3vRy4baD5sIXtwjqx3UmivyLMDY
         fAhfDc3aFJIKbVUmx0luQFdBatfn+UEOSahR6BcjtuLmxIzhRP9i4goMgWoaoO0/7+
         KIlm3vEswuXoms0PtT88F7YK53clzi6CxTGV0VfvGRCZMrTjrN18Ri35KrX67wZ0eF
         E5AXh67jnTGupCb8OPbc/4BVPH2wsg2Ngco4/t0lwBLaXqQ19DnoMWMN7X1yQuF7iD
         g88ExNwatibcA==
Date:   Tue, 5 Sep 2023 13:10:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     wangweidong.a@awinic.com, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org, perex@perex.cz,
        tiwai@suse.com, yijiangtao@awinic.com
Subject: Re: [PATCH 3/3] ASoC: aw88395: drop undocumented and unused
 sound-channel property
Message-ID: <df03160a-38e7-4af9-ae72-605c120ce4a0@sirena.org.uk>
References: <3ff94d4b-7585-d7ed-9736-ba4c02b3fcff@linaro.org>
 <20230905071356.18301-1-wangweidong.a@awinic.com>
 <537821c6-df3f-6946-b7dc-07ba9db9d416@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZMs55giJ2FMIAcuZ"
Content-Disposition: inline
In-Reply-To: <537821c6-df3f-6946-b7dc-07ba9db9d416@linaro.org>
X-Cookie: I can't drive 55.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZMs55giJ2FMIAcuZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 05, 2023 at 09:28:08AM +0200, Krzysztof Kozlowski wrote:
> On 05/09/2023 09:13, wangweidong.a@awinic.com wrote:

> > Could you please tell me what known kernel interfaces=20
> > can be used to parse files?=20

> With exception of Audio topology and FDT, I do not think we parse
> user-provided files in Linux kernel.

It's fairly standard to parse firmware files, usually there's multiple
blocks that need to be downloaded to different locations perhaps with
some dynamic linking involved.  We do also parse the userspace binaries
we run, though that's a rather different situation.

--ZMs55giJ2FMIAcuZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmT3GtAACgkQJNaLcl1U
h9DIsAf7BU+K39jcV6Rv3hG/mLK/M+W/HNSnQ7tqN35N8IaXkPbukfRyPu/8FdwZ
iTMNIRn17gs588wV+4zhZ0k4Lbb46SSt6aHoMf0jzka2apWmFswNSy+zvlJP1p/t
q/MVcbHOswsIYn+MY4M4JSC0mELeBne3wjCU4uciWEnYMwo2tFMJUmUYf9kT1JsA
F+H7AyzrpKrzEAga6kg7Ce5cJDNddvm3ayutfMLx8jk3VMLacx2bd18DqSrlElAQ
NHfKQLg05GDjUm4XZbommDIa4LmbcxW0r2T1Ge69+WYKPMRjdSCceSHXmOWTBSrB
EmiG/5FVHjVN0roLKHKpCG8h0fMJcQ==
=zWBM
-----END PGP SIGNATURE-----

--ZMs55giJ2FMIAcuZ--
