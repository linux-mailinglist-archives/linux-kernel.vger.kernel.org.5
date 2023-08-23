Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A984D785EBD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 19:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237548AbjHWRhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 13:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236177AbjHWRg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 13:36:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA9EFB;
        Wed, 23 Aug 2023 10:36:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1B97A2216E;
        Wed, 23 Aug 2023 17:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1692812216; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0mGoyVdhe07nIruGTIsfRG7pAPcIOn+S23DzxQvPcN0=;
        b=iFkpG/UqOQuBN3F/2OisVy7AxfadSIXjbGO5ToPKFYcruO2BtpJQ1QweflqdVAA04Mocm1
        zZFQMah5bP9Rj1LGJl84ubUT+OE6pL8ZVo2GKOJZyjhjrNSyjlRA+gQ8up+uIdJ8zUq6ZQ
        T747QgTmhFFMsbsQ9DundtkkxVajpm4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F37D613458;
        Wed, 23 Aug 2023 17:36:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fxCROrdD5mREYgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 23 Aug 2023 17:36:55 +0000
Date:   Wed, 23 Aug 2023 19:36:54 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Cc:     linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        linux-kbuild@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH] depmod: Remove version parsing hack
Message-ID: <lroeqntgmtuuijs7m7vcey3tmhfy3pku3cupydupult62hdvlf@obv46zblj2w7>
References: <20230823170632.14377-1-mkoutny@suse.com>
 <20230823173120.GP8826@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="savtmz3n5xpx2hup"
Content-Disposition: inline
In-Reply-To: <20230823173120.GP8826@kitsune.suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--savtmz3n5xpx2hup
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 07:31:20PM +0200, Michal Such=E1nek <msuchanek@suse=
=2Ede> wrote:
> As far as I can tell this is already merged as
> 4d15c9fa058e6dee09324cfc93f48858d4296019 in
> https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git

I assume this is heading to v6.6-rc1.
Perfect, thanks! (It even handles dead cleanup part better than mine.)

Michal

--savtmz3n5xpx2hup
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZOZDtAAKCRAGvrMr/1gc
jpFGAQCnx049CvE5NfEeN6WAi+ygIWnmuUpKYs1iQDNRLfh4QQD+PRdr2w8TLpBl
/q9wzp2Wsp/eriQ3MeAsR/IWSL2owAk=
=aY4I
-----END PGP SIGNATURE-----

--savtmz3n5xpx2hup--
