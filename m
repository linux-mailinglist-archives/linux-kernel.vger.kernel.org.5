Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145BD7F4CD9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 17:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343817AbjKVQkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 11:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343819AbjKVQjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 11:39:51 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15636A2;
        Wed, 22 Nov 2023 08:38:38 -0800 (PST)
Received: from arisu.localnet (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: detlev)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9FA6B6602F31;
        Wed, 22 Nov 2023 16:38:35 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700671116;
        bh=si3WK0FrjG81C4HO0aJN41hihbd3NqNMO1F3f6cyEv8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gCwN4KyKM/tEM426vB1Xc0yr8+YkjWgLrNLmljXWUYcKjbLbhtBysUOdtv6UubyCC
         B6gmlU/X960b+bpIyb4ffX6UwZjWlHH5LCdvayTlvZ0gMxEeW1Y0h2F2wMrStA6q4I
         ypURIPj0F/vETt4dDKKiAFgJ5kdOnpJvZzUA3dbw0M+vZtEEaKDgukFQutLcpU95hd
         Daea+zPOG6JJL5khDBFlFjIkadD0L2c9Ag8z4URw2H5OSeP9UYSIvmPBys0kmJEuXn
         xTW0DmDlslmviNG4UT5Jbyf13zUXaEw5Fjdov71ra7QRNWXHJYqaQaoeq53QTxFdJY
         HwrmBnMJlGjqw==
From:   Detlev Casanova <detlev.casanova@collabora.com>
To:     linux-kernel@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v2 1/5] media: visl: Fix params permissions/defaults mismatch
Date:   Wed, 22 Nov 2023 11:38:46 -0500
Message-ID: <4879622.31r3eYUQgx@arisu>
In-Reply-To: <e647782f-6ed5-4d1f-b318-2d83d713b9b1@xs4all.nl>
References: <20231024191027.305622-1-detlev.casanova@collabora.com>
 <20231024191027.305622-2-detlev.casanova@collabora.com>
 <e647782f-6ed5-4d1f-b318-2d83d713b9b1@xs4all.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4529700.LvFx2qVVIh";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4529700.LvFx2qVVIh
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>
Date: Wed, 22 Nov 2023 11:38:46 -0500
Message-ID: <4879622.31r3eYUQgx@arisu>
In-Reply-To: <e647782f-6ed5-4d1f-b318-2d83d713b9b1@xs4all.nl>
MIME-Version: 1.0

On Wednesday, November 22, 2023 10:56:20 A.M. EST Hans Verkuil wrote:
> On 24/10/2023 21:09, Detlev Casanova wrote:
> > `false` was used as the keep_bitstream_buffers parameter permissions.
> > This looks more like a default value for the parameter, so change it to
> > 0 to avoid confusion.
> > 
> > Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> > Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> > ---
> > 
> >  drivers/media/test-drivers/visl/visl-core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/media/test-drivers/visl/visl-core.c
> > b/drivers/media/test-drivers/visl/visl-core.c index
> > 9970dc739ca5..df6515530fbf 100644
> > --- a/drivers/media/test-drivers/visl/visl-core.c
> > +++ b/drivers/media/test-drivers/visl/visl-core.c
> > @@ -74,7 +74,7 @@ MODULE_PARM_DESC(visl_dprintk_nframes,
> > 
> >  		 " the number of frames to trace with dprintk");
> >  
> >  bool keep_bitstream_buffers;
> > 
> > -module_param(keep_bitstream_buffers, bool, false);
> > +module_param(keep_bitstream_buffers, bool, 0);
> 
> ???
> 
> This last parameter is the permission, it makes no sense that this
> is either 0 or false: then nobody can see it in /sys/modules/.

It makes sense if we want it set when the module is loaded only. This way, we 
don't have to manage the parameters values changing while work is being done 
and keep it simple.
It could be made readable if that looks better, but there is no real need for 
it to be read either.

> Typically this is 0444 if it is readable only, or 0644 if it can be
> written by root.
> 
> Regards,
> 
> 	Hans
> 
> >  MODULE_PARM_DESC(keep_bitstream_buffers,
> >  
> >  		 " keep bitstream buffers in debugfs after streaming is 
stopped");


--nextPart4529700.LvFx2qVVIh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEonF9IvGrXNkDg+CX5EFKUk4x7bYFAmVeLpYACgkQ5EFKUk4x
7bZE+wf+MCK8uJhfh4YaMqQHC74WNCozrTSQtFgK/+EywNzwEhcHIKUSmLHntpzq
ECO/A1CYJ03YtO5VJ0CR/3S+kGppVspGA2XBPUvaqao3SiiGzRuvca5ix71Q8W30
cUxFzknce1gJB4W/ZENeYnrBlPyFWvKi34fB33iOvT8/LonOqgJJergpsccNUvp4
NY+zmGYJ/S1Liqh5QG0Qa3hDuKQdLPIYdUkjiESmCGgw9D51vNJYhcSi3MwyHxbK
9eniFJmTWrt1vdiUgeUaNpYfo1JzW0PtDT0Wp+3MoKn0fniLyfDC4UT7uAr2B1Y1
e6/AmZNuyz/uS+/JKjogIMBTF+KzjA==
=09tU
-----END PGP SIGNATURE-----

--nextPart4529700.LvFx2qVVIh--



