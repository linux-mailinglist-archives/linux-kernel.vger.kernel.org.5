Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401D6767076
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 17:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237013AbjG1PZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 11:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236886AbjG1PZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 11:25:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998FF3580;
        Fri, 28 Jul 2023 08:25:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37C9062180;
        Fri, 28 Jul 2023 15:25:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3476CC433C7;
        Fri, 28 Jul 2023 15:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690557902;
        bh=xF0X+qCCgDU+aCVXnCNOAuCkm3qHaATyuGP2PvOLG9U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m+2cgoUp+iR8NzknvyxQ5SoIRUemstGpTeSNqztN3Z8xZbGvw6DTHKdRrjl5kPUYD
         rRKjMhUz7bIm4bnxk7oTgc13T2hnvqI2cef3AaWJ9lh+hO0Sr19FRCo2JneIFq5QZ7
         aY+9YKQN3iPZlvGuiOOa4j1YaUDsBs206K9GTR9KmT58U2xwAMwnQBqlK2jyQ25Jk+
         GPal1r2/A+ue9m9LTeDQm/01wgtSIUp3LayAgIpdHaqxNuZQPDSJelxy8Bl2vNzI1P
         aAT62Wc4lZSFza4mLhaecD1KvLl+EmIRx2SVqwwS73bLs9hb4eUjwiMid3YPfnsNVJ
         wLzBv4Upyfncg==
Date:   Fri, 28 Jul 2023 16:24:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>, hverkuil@xs4all.nl,
        sakari.ailus@iki.fi, m.szyprowski@samsung.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v2 4/7] media: v4l2: Add audio capture and output
 support
Message-ID: <f28f7fa5-b557-4575-9cf0-e5cfb8187bc1@sirena.org.uk>
References: <1690265540-25999-1-git-send-email-shengjiu.wang@nxp.com>
 <1690265540-25999-5-git-send-email-shengjiu.wang@nxp.com>
 <20230728075933.pdepqspznenazs5f@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n2yYRXOnFZknHRi3"
Content-Disposition: inline
In-Reply-To: <20230728075933.pdepqspznenazs5f@chromium.org>
X-Cookie: Ontogeny recapitulates phylogeny.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n2yYRXOnFZknHRi3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 28, 2023 at 07:59:33AM +0000, Tomasz Figa wrote:
> On Tue, Jul 25, 2023 at 02:12:17PM +0800, Shengjiu Wang wrote:

> > +	case VFL_TYPE_AUDIO:
> > +		name_base = "audio";

> I think it was mentioned before that "audio" could be confusing. Wasn't
> there actually some other kind of /dev/audio device long ago?

OSS used /dev/audio.

--n2yYRXOnFZknHRi3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTD3cYACgkQJNaLcl1U
h9AyAAf/QDvn8GIQGSGSQC1iB0Evn5vRrpuFbeQwz9agsf2Q7hgTr3lRxGTIPRiN
l2YvkGHBzxVr+euWBjEZHcrlZczWEPpenxQByp7MvurwwQOFpUz+7DFM2CEPQYRe
HyTiJk7O1W6C/CVLUV74RqG0RmkWcIqJ3DySUZ1TbckRp/1mQb+v8UZeRfU7SkDz
rBJLMpNEzwcSXy4srbN/IB09tQltPa90V3YUMOUiqiP6K58ree66GvRp9la617UL
qdJQdzH5qY0W74CqxxQAKMVdkNIl7aXg9p55VQmsghM70IxpvJXHW9E9tU/FwbQh
iML5/Bu1FlifhcPBbQShVHsZn+Wp+Q==
=UVLV
-----END PGP SIGNATURE-----

--n2yYRXOnFZknHRi3--
