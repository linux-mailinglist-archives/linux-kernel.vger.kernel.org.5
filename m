Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E043876F39C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 21:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjHCTnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 15:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjHCTnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 15:43:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44524127
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 12:43:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C11A761E82
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 19:43:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44790C433C8;
        Thu,  3 Aug 2023 19:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691091782;
        bh=S4NCLtZ/30zJp+pfzfZswDKY1EQRe7iHhrmUuGeO26c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mig/HwNqHsZ7HAUl5OPqdc6sSNaCHa/rLApdM+nUqaNs/YAoqqnCrQQmnc3d1jgPU
         D6imnhGURytRAWZkay0OFU+7QMRDu6ypR1mpLQaopOVDjc089Ck0ggiqu+364UiL79
         t5QStwnAj5/R8EertB13ruoTB3ybe7ejU4uyVi8OhEAEri4KWWUnkPoSWDRwASQMMH
         byzJRwiA0VhjwEYc3amNwOeHC+iw461MEPc15W+S8RlM17Cg+dNG/RDxqpfngOSul5
         qhS+/mBmVk9vHeWB6u0UKhKSFFCf9SHLuxIY3MvOBl86kwgMmJxWFZF6htlDZ/Pw0y
         nBOqaW303mIgg==
Date:   Thu, 3 Aug 2023 20:42:56 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marian Postevca <posteuca@mutex.one>
Cc:     Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        alsa-devel@alsa-project.org, Vijendar.Mukunda@amd.com,
        Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        linux-kernel@vger.kernel.org
Subject: Re: Regression apparently caused by commit
 088a40980efbc2c449b72f0f2c7ebd82f71d08e2 "ASoC: amd: acp: add pm ops support
 for acp pci driver"
Message-ID: <6a92d9f0-dc44-4bbe-ae23-a29cb8d569aa@sirena.org.uk>
References: <87a5v8szhc.fsf@mutex.one>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oYg9+n0oooCWknT0"
Content-Disposition: inline
In-Reply-To: <87a5v8szhc.fsf@mutex.one>
X-Cookie: One Bell System - it works.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oYg9+n0oooCWknT0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 03, 2023 at 10:22:07PM +0300, Marian Postevca wrote:

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

> I'm no expert in runtime power management (though I did read a bit on
> it), so I don't understand all the things that happen underneath, but
> one thing that is not clear to me is who's supposed to mark activity
> on this device and keep it from entering autosuspend if the user wants
> to play some sound? Shouldn't there be some counterpart that calls
> pm_runtime_mark_last_busy() ?  I looked through the code and can't
> find who's calling pm_runtime_mark_last_busy().

The core will hold devices out of suspend through a combination of DAPM
and PCMs being held open, it just does get and puts rather than making
an effort to use autosuspend delays.  See the calls to
pm_runtime_get_sync() in the core.

--oYg9+n0oooCWknT0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTMAz8ACgkQJNaLcl1U
h9AxPAf/Yj61S659XoNW1T+LDZiBfmEKTmHU1ADfDT3ln1jpRu7QJuNjiOGBl1Tx
spcSaDG/fRHmtSD/P8i/fUEaP9hGtDMEEUS9NzWITJnZgZePV+92FTn4PbLIr4gv
ERIV74ayfuO10baTw6mjgdxfCSDxT9w1NvYnWX1xAz8dOuFyXckKGNcD6uyJOTdZ
q6UNXh2DowiOqT9/E24BdhZp7sjNanB00+N3rBd7Bbfrn+Zv4giXCPgy4OoOcRZt
zo3t1H6RH4GsEXOMqrA/ol4HNJkpqRWeqLIgg2xOG2BEamGx9f02FhseJlC2JURk
HS75SLsdKxIHeaVEh1+Gtp1pROj0Qg==
=2OXo
-----END PGP SIGNATURE-----

--oYg9+n0oooCWknT0--
