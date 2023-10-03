Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6007B6CB1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 17:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjJCPLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 11:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjJCPLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 11:11:37 -0400
X-Greylist: delayed 420 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 03 Oct 2023 08:11:31 PDT
Received: from mail.meier-coaching.de (mail.epic-bytes.net [IPv6:2a03:4000:46:fa::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AACB9AB
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 08:11:31 -0700 (PDT)
From:   Markus Meier <kerneldev@epic-bytes.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epic-bytes.net;
        s=2020; t=1696345466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qVteM+WyhCWgGKmgpjhnWHSPzBzizjYf1Mb5ewbwwLc=;
        b=JFq/ZLqSlpnnLU/2G+6t7Dy+lzyi4pGx2eX+ogWFbWuAhW/uq0i4OmT6EK4Y0CIQ9G9myM
        rws652AqnFxfjAxYIDyrAZA7WQkSoavZyRPzRvzqWGxjnsrk2V6GjQhyzq+x68+/a+TkvO
        qa95ohwhQ3xdv2GeS5unOhTAGIYh5Fej8XoTlA6zy5VadG+3PvxqXYVt6LK8aToYnaSagL
        CL8w6plrNuFPm9FaSPk7MvNX0qM8/JLKPbKDuCnb6ywGQWMObOOu4sSP58hPb9SxplVJoQ
        GUFmWgsPnd2DSa3OEhG7eDCndatFHxo6pdzjtZLfEJID0dpjNiwT/JlR1pXN9Q==
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=markus smtp.mailfrom=kerneldev@epic-bytes.net
To:     Markus Meier <kerneldev@epic-bytes.net>,
        alsa-devel@alsa-project.org,
        Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Linux kernel regressions list <regressions@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Mark Brown <broonie@kernel.org>,
        Sven Frotscher <sven.frotscher@gmail.com>,
        August Wikerfors <git@augustwikerfors.se>
Subject: Re: [PATCH] ASoC: amd: yc: Fix non-functional mic on Lenovo Yoga Slim 7 Pro
 14ARH7 82UU
Date:   Tue, 03 Oct 2023 17:04:25 +0200
Message-ID: <4836369.GXAFRqVoOG@mobile>
In-Reply-To: <aa54a70c-e7fc-4ca2-9a4d-425675ed0be3@leemhuis.info>
References: <10347605.nUPlyArG6x@kali>
 <aa54a70c-e7fc-4ca2-9a4d-425675ed0be3@leemhuis.info>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1865545.tdWV9SEqCh";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1865545.tdWV9SEqCh
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Markus Meier <kerneldev@epic-bytes.net>
Date: Tue, 03 Oct 2023 17:04:25 +0200
Message-ID: <4836369.GXAFRqVoOG@mobile>
In-Reply-To: <aa54a70c-e7fc-4ca2-9a4d-425675ed0be3@leemhuis.info>
MIME-Version: 1.0

Am Dienstag, 3. Oktober 2023, 12:24:56 CEST schrieben Sie:
> On 02.10.23 23:04, Markus Meier wrote:
> > I own a  Lenovo Yoga Slim 7 Pro 14ARH7 where the microphone is not showing
> > up. I added the system to the quirk table and the mic is working
> > correctly (but with very low volume) now.
> > 
> > Here's an except from dmidecode:
> > System Information
> > 
> >         Manufacturer: LENOVO
> >         Product Name: 82UU
> >         Version: Yoga Slim 7 Pro 14ARH7
> >         SKU Number: LENOVO_MT_82UU_BU_idea_FM_Yoga Slim 7 Pro 14ARH7
> >         Family: Yoga Slim 7 Pro 14ARH7
> > 
> > Please add this patch to the kernel and add it to the stable kernels too.
> > I
> > guess the microphone should have worked before. Seems to be a regression
> > introduced by c008323fe361bd62a43d9fb29737dacd5c067fb7
> > 
> > [-- Attachment #2: yoga-slim-7-pro-82UU-microphone.patch --]
> > [-- Type: text/x-patch, Size: 451 bytes --]
> > 
> > --- a/sound/soc/amd/yc/acp6x-mach.c	2023-09-29 19:31:03.753786095 
+0200
> > +++ b/sound/soc/amd/yc/acp6x-mach.c	2023-09-29 19:32:06.414276453 
+0200
> > @@ -217,6 +217,13 @@
> > 
> >  		.driver_data = &acp6x_card,
> >  		.matches = {
> >  		
> >  			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> > 
> > +			DMI_MATCH(DMI_PRODUCT_NAME, "82UU"),
> > +		}
> > +	},
> > +	{
> > +		.driver_data = &acp6x_card,
> > +		.matches = {
> > +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> > 
> >  			DMI_MATCH(DMI_PRODUCT_NAME, "82V2"),
> >  		
> >  		}
> >  	
> >  	},
> 
> I CCed a bunch of lists and people to make sure everyone is aware of
> that patch, as it otherwise might fall through the cracks.
> 
> Markus, quick question: do you have (a) an interest in contributing a
> change to Linux or (b) did you just post this because Mario asked you to
> do so in https://bugzilla.kernel.org/show_bug.cgi?id=217063#c25 ?

Nope I don't plan to become some kind of kernel developer. I just want to use 
my notebook without any issues and want to help others who want to use this 
device with Linux too. I just followed Mario's suggestions. I thought it would 
be easier for everyone when I create a patch, try if it works and then submit 
it to a bugtracker to get the bug fixed.

> If it's (a) then you might want to take a closer look at
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html
> , as your patch lacks a few important things before it can be applied
> (most notably a Signed-off-by tag)
> 
> If it's (b) I wonder if it would be easier for everyone involved if some
> kernel developer could create a patch own their own, as that likely is
> way easier to review and thus likely gets the problem resolved a lot faster.

Please feel free to create a patch based on mine, when it's easier and faster 
that way. I don't really care as long as the microphone is working in one of 
the next kernel releases. 

Thanks for your help Thorsten. I really enjoyed your Heise Kernel-Log series 
and I really miss those series. Was always a pleasure to read that.

Kind regards
Markus


--nextPart1865545.tdWV9SEqCh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEERBSE7v1a64GvZ1KmZ8XdFW0AfzsFAmUcLXkACgkQZ8XdFW0A
fzseVAf9GbHjcHa2amWp0h43dfHGYjL9JR3njUJnLGfz4JWEyNBfaDtYatzr0YjY
7TNxkbqH/lbGWoTsIBzHO540T2VmTLluHpQDWdB2xL857gIgPH5Ddtg1CUjODK2H
xTyqnHvURs2QadjITFN5ox3z32RjkXxBjIAA6C0xF/CXg+WXsxG9fPqZhifAhqxJ
LcE1D5K0VWT7qrbIJ2SHQy0GCHz98bOx7rNkduLNspyHwtVgG+ujgMRo2jDa1yBH
OGat/Tf/It66GQs18PAnuW3rM5EZKNt7PE5XDX9jT5wgnG5DkkdygGPdZo1lhrnj
r2W9M96d5MphyPQm9YcopDbMPOnseQ==
=F8i4
-----END PGP SIGNATURE-----

--nextPart1865545.tdWV9SEqCh--



