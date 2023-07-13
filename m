Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35EAE752148
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 14:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234750AbjGMMaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 08:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234287AbjGMMaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 08:30:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140B519B4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 05:30:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D169610A6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 12:30:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED282C433C8;
        Thu, 13 Jul 2023 12:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689251412;
        bh=sQcZxsFkCNWRLdgruhrDdD5aFaAy2pxE5uSPrI77aTo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ktW+Ju2UrctbF+/WRUqnjneRfiEc5NxcNmlMz80Xitk23Pt+GfTfyrDhcuPNVI8Y7
         bj/DPiPF9VV3qWFYLru+84wSreNLdMpdsH79exF2q+6ieP0jtySMMRFu860x7ns48k
         HRvrMLiKPzuUm1fUt/oa0Qv70w8ibMybUiZX9eyS6/7droAu15gWbxg0lX2b6lOwY4
         1piXUTS82Hvs9fMqjN2Ho3CFs4QgnCRrNgn5YiXpGQJyzT0HLmXDOiFHMifsr0lYml
         AkeP+h0OG0vYSnMpu3uODplu/yoMp3/qNjAjNN82TFIybUdW+GTODSQfimK+wr6MDx
         RqTsSdifg9w5w==
Date:   Thu, 13 Jul 2023 13:30:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Support Opensource <support.opensource@diasemi.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Marek Vasut <marex@denx.de>, kernel@dh-electronics.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5] regulator: da9062: Make the use of IRQ optional
Message-ID: <d8f60e51-2d62-4370-9032-51eda744239d@sirena.org.uk>
References: <20230713090328.3879-1-cniedermaier@dh-electronics.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZhH88YA9AlDlO1Kf"
Content-Disposition: inline
In-Reply-To: <20230713090328.3879-1-cniedermaier@dh-electronics.com>
X-Cookie: MOUNT TAPE U1439 ON B3, NO RING
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZhH88YA9AlDlO1Kf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 13, 2023 at 11:03:28AM +0200, Christoph Niedermaier wrote:

> This patch makes the use of IRQ optional to make the DA9061/62 usable
> for designs that don't have the IRQ pin connected, because the regulator
> is usable without IRQ.

Are there any dependencies for this patch?  The fact that I acked it
makes me think there were MFD parts

> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202303082246.GuLdPL0t-lkp@intel.com/

I really doubt that the LKP bot ran into an issue due to a system with
this device without an IRQ wired up...

--ZhH88YA9AlDlO1Kf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSv7kwACgkQJNaLcl1U
h9Dk3ggAg42Bxb1YqW/uFXFf0VSUCOZdV+qHuNXMF7MYWR1SDSIbF327ZXEVDkPy
uRj/SNhpGYK/cNCEjyvnPlvNJdHVPuXgwIWG1N427HDUuFErvdqxCA9OBSYHyVRO
v0TwUTgwdCRKS/pvO1qcQff7uQ2ZFOU20rKSSRAWtd0roR//eQzeAZzHeSB6ZACU
bLz8xhFG1j6dATPltyHN33pj7p2xkprS8sULZKYNyyudPeqGkuUT0OAz6vRMFfxt
Wv2/JlIUUE4OrGEc88h8mXyHFmPTLyFvcDIzzo39LxXXdvfxLvZjLpa+Igrh/2Q2
+gcv/M/rLPd8lBUtoFuw7KvwY75F6A==
=1tcM
-----END PGP SIGNATURE-----

--ZhH88YA9AlDlO1Kf--
