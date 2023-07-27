Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59BE176603C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 01:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbjG0X1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 19:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbjG0X1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 19:27:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DA630C5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 16:27:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BB4661F89
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 23:27:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20150C433CB;
        Thu, 27 Jul 2023 23:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690500451;
        bh=eYdamAR9IwNb7ZMcaqS76Bws/3YygfXLjnMwqsbDt88=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kgbNFW1jLhTadTo3OTjnsqbgl3HuNukpcDRdVejd5Q0AzhKYtmSSB8gEcOv9RWhlX
         gdt70k+LRoxcUmqN/XEwp4duSqHqIhTyyWsT1fLCjTh8jn+/y9LIq9Kcg2c3YRakXn
         m3RamsQof3ye6ZhkQDdNu9GeUVZPIPN6kPol5k/Idh997KJqyyMbELCM1/mU9yW8of
         hk3/TaMe7upwvEmND6rtQOSrYfEnpGX6Hl1tCdBn0aw7rMUQb1FdBI3mo1CMAIeQVx
         Qoibh4W3GBpWN1od4KpUwqUGnlf4W1FWMDj30jRMsjZuJ7lAjOk21HArg0YxAHYq3P
         XiHijmKsie/5A==
Date:   Fri, 28 Jul 2023 00:27:24 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: Intel: Skylake: replace deprecated strncpy with
 strscpy
Message-ID: <f0f0ebe4-55fb-4861-a94c-77c82ec600c5@sirena.org.uk>
References: <20230726-asoc-intel-skylake-remove-deprecated-strncpy-v1-1-020e04184c7d@google.com>
 <20230727-asoc-intel-skylake-remove-deprecated-strncpy-v2-1-152830093921@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fxdzMHT9nHAlz0DB"
Content-Disposition: inline
In-Reply-To: <20230727-asoc-intel-skylake-remove-deprecated-strncpy-v2-1-152830093921@google.com>
X-Cookie: Go 'way!  You're bothering me!
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fxdzMHT9nHAlz0DB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 27, 2023 at 08:30:18PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
>=20
> A suitable replacement is `strscpy` [2] due to the fact that it
> guarantees NUL-termination on its destination buffer argument which is
> _not_ the case for `strncpy`!

Please don't send new patches in reply to old patches or serieses, this
makes it harder for both people and tools to understand what is going
on - it can bury things in mailboxes and make it difficult to keep track
of what current patches are, both for the new patches and the old ones.

--fxdzMHT9nHAlz0DB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTC/VwACgkQJNaLcl1U
h9BKtQf+PU+B7WMVvB7nKGZnwnltRf1hOqO+ppLtmCXfk99XwgbXWOnUINT6wWH8
rqz+nkDW5ENnOOk1EVwQ1ZhlFbJjQhKa6GtrywDD3j69RP8MljzUJB9U1aqemxlM
g2ZbR9w+dkv1BR/tbYavi/OceU/0f4BOYEAMCv94GOEh55dCbXcJPVC+QU4zjORa
LY+hg4QCm9+h6KL8bwUpim02/gfJ94NugdogkyB31Ct/d87gH53GGnrJRU7x7nB2
UcDs6mPmCH9QSxupNP0S5Zy9VA5yl06ahKnW9YvFiEmRLQJ00An+Pam5Cjrwsfa/
3gihyIbKLSxc4IGD9kJDuCTDJuz2Gg==
=wnJm
-----END PGP SIGNATURE-----

--fxdzMHT9nHAlz0DB--
