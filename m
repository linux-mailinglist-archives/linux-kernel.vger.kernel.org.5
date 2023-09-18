Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20CB27A4FFD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 18:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjIRQ5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 12:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjIRQ5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:57:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A388E;
        Mon, 18 Sep 2023 09:57:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30439C433D9;
        Mon, 18 Sep 2023 13:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695043100;
        bh=hXDd8ZCR0qFWfMru86jsT7snWkFtdp7y7o+jqhKajTc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XUuoVqbsWrH9NHQOfmm9OTzkx99X39N3feJNW9gHBFNWYSIId0hq9EyItJDMK4n8Q
         lOVjjYbLJcqpwcn16Sca83cFIVlmv+edAg9zsxlOdKAIOPByr3LO8JM4uqUoapJQ3s
         e7RMxpwW6wjIrDu/6ZmoNSxy8FfcOsfFliSgI48wxpCg2IU6XSci4Vk6LlxhrLJ4kj
         +4oZjWSa52KFiHXi1ng3F17sEBH8hDXdZCXn+GyUcF6YvbNklNIvcSSeI4WGo6Bpun
         brZ7kIrD2AbcppczMYkDUetjhAT4X4FNKjw1XGv3CHjfKJsYEtqq3z8IhuVwrcRYlu
         BbUMixdBUb27Q==
Date:   Mon, 18 Sep 2023 15:18:17 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Jonas Gorski <jonas.gorski@gmail.com>,
        linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        linux-mips@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] vlynq: remove bus support
Message-ID: <ZQhOGY+tr25CDuI3@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jonas Gorski <jonas.gorski@gmail.com>, linux-kernel@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, linux-mips@vger.kernel.org
References: <20230916091125.3221-1-wsa@kernel.org>
 <CAOiHx=kLQzTTzuGM0tyuv=e9J3Oi7EbWWYFRK5mEfqNrVj05NQ@mail.gmail.com>
 <3395161f-2543-46f0-83d9-b918800305e1@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/qD4GUSmuXgfBJs4"
Content-Disposition: inline
In-Reply-To: <3395161f-2543-46f0-83d9-b918800305e1@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/qD4GUSmuXgfBJs4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

> Agreed, TI AR7 is nearly 25 years old now, we should be able to remove that.
> Wolfram, do you feel like doing that or would you rather have me do it, say
> next week?

So, I pushed out an RC here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/cleanup/remove_ar7

Just waiting for the buildbot report before I send out patches. buildbot
was already happy with my protoype, though. But I needed to reorder the
patches. (I do wonder, though, if they build AR7. I would have expected
a build failure with my prototype).

Happy hacking,

   Wolfram


--/qD4GUSmuXgfBJs4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmUIThUACgkQFA3kzBSg
KbYItA/9FoAXTY6n1hIFgTMAnBKyBWqJ4GXd7L8RSp/NghlIGQAy+GELs4VQLKad
fOPPY2RlGf0WSvj+ao0/7+Pjsx3DnIhZ5mpSCvx5XERdUdiCe9Gt4dvP7RLG1yq8
rYAWaRqBsa9v6IUKldjvIx54DGRclpMvOkOdolhpZFqxOFzzlgwEsD3M1fayDzIU
X3xkSFAMqpBKeP5vqATgP+5ess6/BtFAr/BcnhuvmlxcJIDsb4BiECdRJPXdwouH
FADRrEg+F0hDCzRwttkXEeMMYfe3NmyQdQJc6wzA2K7oRvJhDRCOoHiaeaVkezJ0
iSa4pmqAJiuohESbnIX1rosnUTkX9a704ksSlh/F8xKsr0xsCpAY/KO+/i3NK4oJ
2lHKWQLjl+ul7CPfTVzbPWThnwebkxL8xDSzKgPSj//4WXFbe8HI1NJAn828SpNr
IpjwPj6hLJivGt+YiBY5Qy8FIeHMtiuXXstEmIPjsFhYWVsES7EAKARYJZ5X/wSj
151RBps/xFB8UF6Qf7kZs1BSt4T9A3UiVH0EUkUpyxG2iKl+TJvB9OZjTx6sj4w/
SQk/ne1cT6aqXucDSTByd8z5SKhwOBEp+YOHmqUyRrQFGjiylAlpfXoAep8M+kcj
8S+bx1W9qhcgL7bbgJQU3HrS69LD7/Apadq9nP29UuJoyfBGdx0=
=bTSj
-----END PGP SIGNATURE-----

--/qD4GUSmuXgfBJs4--
