Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B53A07ECACB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 19:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjKOSwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 13:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjKOSwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 13:52:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80312BB
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 10:52:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD624C433C7;
        Wed, 15 Nov 2023 18:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700074352;
        bh=PVunFeVcVDida4tla11uaunipd8jgTS5w0unfbyZGBY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c0IoT8G3qlqXqap/1LCYqdIDnkIsmjxptk5gWyEizK3ZorHx4/Pha/ILoQvh4Urgv
         x50OymOZREo7FiEC0/mkkYuiDliZ2iNLPHlnrLBCsPU5PxUiqWfNfJ8fakyhc/RPRJ
         npG+AqZhomKkCnQzEuqFO8lkbHEqhpWRr58G019Xlnv8mFA0BS+jE2zy+VUbhenScn
         hmxkX630FrGdPT8Jp8qmoR/eVwum22ZlHVxu3SJRBtq95nwGYqjeharb7Txyuiud/H
         FiYlRizjsKwu/TY/wXSC+hRtGXXsOkZxDLCP8MZhsLhjFcm4PmG8kNxGp73tgf/ujS
         YATufXa3B+0Og==
Date:   Wed, 15 Nov 2023 13:52:28 -0500
From:   Wolfram Sang <wsa@kernel.org>
To:     Jan Bottorff <janb@os.amperecomputing.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jan Dabros <jsd@semihalf.com>,
        Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] i2c: designware: Fix corrupted memory seen in the ISR
Message-ID: <ZVUTbJfQXbXi9V2c@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Jan Bottorff <janb@os.amperecomputing.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jan Dabros <jsd@semihalf.com>, Andi Shyti <andi.shyti@kernel.org>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231109031927.1990570-1-janb@os.amperecomputing.com>
 <yuperxjytpcwz25fofjut2edzjc4i6jgymcraxp4q6mfe27taf@b33ym5iuubji>
 <ZVHxhN+dxJSUkEOg@shikoro>
 <tupjmogut45oh2t2cth7o5wpqc6u6qkwfwddqrfnozlpplavlz@vram3ul3t4zj>
 <16668165-adcd-4cd6-8c50-83b992f8e880@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hAYC832Rq+wQi06x"
Content-Disposition: inline
In-Reply-To: <16668165-adcd-4cd6-8c50-83b992f8e880@os.amperecomputing.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hAYC832Rq+wQi06x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Any chance we could get the "Cc: stable@vger.kernel.org" tag added to this
> patch? More than one large cloud company would like to see this in the

Well, no, it is already pushed out...

> stable kernel, as it significantly improves the reliability of IPMI
> transactions on platforms that use i2c for this communication.

... but with that commit desc it will surely be backported nonetheless.
If all fails, it can be manually requested to go to stable, but I am
sure this will not be needed.

> Sorry for not including this tag in the submission.

No worries.


--hAYC832Rq+wQi06x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmVVE2gACgkQFA3kzBSg
KbYhqBAAkspivkHfj10mw0NlonXTazQdxZcKrDS6p6//oEJ1urnZYedbVTdUGNhq
T+fTKtNP7V9IgtNIG/Sz0b7i23KoDMb31Ut9+XpgkHIJOZQlXZi9kbUBdRGd9dWk
a4ksoLLV3g4Yhv9gEJvic4brY3zhM7nKsJAcdpnz1bGWvT1N57ntuTKzcsW07I+r
tWN5fKiRl4gtOIoIjq96P4eaVITXlpmmzEyifD6v21ypejwNb7E5qnDRbKzGC1gj
sHr0cR6fpatLnzYndDCw3mTe0dPjHHYS5fLjQaVhIZNh8WQ/ryChh4JT6YX5PE0t
nFFVEwRaeJi/LljzWzvHeQuhlmeYs5kLWmesuFt+vBYOEAHZTK0zYRdJ9kZkT5cp
3y3ohyydl+0KhCyqRrcokpAJfMI5TbDRi5QTTq/w7vwd85lbLQL/xdf+i0yWoxzZ
6QgCjKIIGrqv0CYijPHtjJY+RFY0LlfGVcx229iKmcIHjtGi416dnjqSXO5k/KW4
gqI8lbGus2OFUBbQ0nL0Rw9Qm2+IkvVi2K5lerWLthiK7DRFo1COW04gGo63rv/P
6MUV3baHQtygGs5/OEVWX9/VYRiC+Fecg/zcFA1chSe5/pzArC+5Ry/zBkGs3QbR
TTNat9mOO3lSdMZNQ53eDrqtDEVf5WQb1yfGdAACpM8aK/nHDPs=
=5b9n
-----END PGP SIGNATURE-----

--hAYC832Rq+wQi06x--
