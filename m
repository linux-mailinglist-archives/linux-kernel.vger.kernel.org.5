Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9F675286F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 18:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbjGMQfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 12:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbjGMQfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 12:35:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD9C30CA
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 09:34:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC84F61A5E
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 16:34:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 822AAC433C7;
        Thu, 13 Jul 2023 16:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689266069;
        bh=1LL3CazwAbR5q+97Oy9lUld6Xg/rBqR+FId9AmfTTyg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JMpQ/esdy6yr7ovSPpIj0eLzkhNmdFV7Wzg1UpbupCJWuQaT+pHpg0UOicJlUOITL
         H5e2KpFl+j84ioj/GK2eXk3IPDWbUecJyKYrOhw4XpWfMW1ldP7K/n6lBFFgCdGJrp
         BP8WvyPGdrY37TlnaaD8y8nRqHLBNs3+uOR0vrcuEYyOn27YwBKSly+a8eXCgjrq/d
         ZChllxy5A9OqLXhgM4fHi9YaTIsUMdYd04Kn9VUk1q5/dZ7NZPNObOkTG2+/mIUHmQ
         nfv2+qiq03Bsjgj07xU26kJsUF15AixKMaJXPoruyagriIvpK+OxOKrvGtQWm834hm
         bL2iG0tQBc0Ag==
Date:   Thu, 13 Jul 2023 17:34:24 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Marek Vasut <marex@denx.de>,
        kernel <kernel@dh-electronics.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V5] regulator: da9062: Make the use of IRQ optional
Message-ID: <8558f2aa-09fd-4cd3-ae1e-c80893e00aa1@sirena.org.uk>
References: <20230713090328.3879-1-cniedermaier@dh-electronics.com>
 <d8f60e51-2d62-4370-9032-51eda744239d@sirena.org.uk>
 <9629970cc2c3452e83a43660823319e5@dh-electronics.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="altLkxuEsntrmcoR"
Content-Disposition: inline
In-Reply-To: <9629970cc2c3452e83a43660823319e5@dh-electronics.com>
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


--altLkxuEsntrmcoR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 13, 2023 at 03:36:38PM +0000, Christoph Niedermaier wrote:
> From: Mark Brown [mailto:broonie@kernel.org]

> > Are there any dependencies for this patch?  The fact that I acked it
> > makes me think there were MFD parts

> It's a patch series. This patch is the last one in this series, that is
> missing to have the ability to run the DA9061/62 without a connected IRQ
> pin. The other patches are already upstreamed and yes there are MFD parts,
> see below:

Oh, dear.  Why weren't they applied, it's not even the confusion there
was over what Reviewed-by means...

> >> Reported-by: kernel test robot <lkp@intel.com>
> >> Link: https://lore.kernel.org/oe-kbuild-all/202303082246.GuLdPL0t-lkp@intel.com/

> > I really doubt that the LKP bot ran into an issue due to a system with
> > this device without an IRQ wired up...

> In V3 of this patch the kernel test robot found an issue. I had really
> overlooked that. Thanks to LKP. I forgot to replace the irq variable in
> the function devm_request_threaded_irq(). So it affected the path with
> IRQ. In V4 I fixed that. In V5 I only rebased it on the current next
> 20230713 and add Marek's Reviewed-by tag.

That doesn't mean you should include tags like this, it makes it look
like they reported the commit...

--altLkxuEsntrmcoR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSwJ48ACgkQJNaLcl1U
h9Dq2Af+JAGbntNGDLrRx3J0Mp22kYyvYDnvqfOTote2xsxDWunWrXEkSXTDp1LB
nKTTchli1wMXiQfQjtjGYlgkSu5rfetldWH+W3+pbrBkGg35l9J2Gmn77SPZqDvW
SZLVrsN2CVwuOods3ZK1kkKw4ZbFE3TC/Y3sQ0B/iK66cv2OEuzTk5Wx3wlvUNhj
pX/4cq3Y/9vgpp11fr2l5wxhllWZ0jgE413QgTBnUinO89zht6AlgLVnGIrUfuwu
YA+l4V6jmzTXj1Z+FCQJxKFfnAyOGmUYCHeq2QIgWQ7UxO2FoSXJpt6HiA4H7D64
rJQtHR6rtylZEgHFHVn7u34JjhWz8w==
=JMDM
-----END PGP SIGNATURE-----

--altLkxuEsntrmcoR--
