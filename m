Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754587F6588
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 18:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345436AbjKWRfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 12:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjKWRfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 12:35:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98B8B9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:35:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E27BCC433CC;
        Thu, 23 Nov 2023 17:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700760942;
        bh=/73LHzEUuMC+UbtJ5BdZY8QbIJypb3dNXKHEGBhyUfk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KY1lQexwEHntktudEDLo2U/ya2/15YkepNxQSkua05q8GbSv6SrrINT35F3cF/9SN
         nVVuTeTKuFby1C2Q2H9+GAtGpc3HmEwhDoSMRjdrnDZ7qd8YIV7PXYL7d3b0tOSPW0
         y7mw/lZsUVYDLUtrAv1a3ClM+o5NKYp0Gprp7NcVJrSepRcjEsTppbDPIu4rYAqPhq
         CPn+qYP6jrRFi7gx+yV6h+UfDlNYqR+RSiEZM4yd6J+0quh157aUnC+PPHDcVK7GKV
         v6z9a7G+dQuNhkhiiJDlH3d4BufRFhu6hioME38hjy6Ql6uspZzj41LliW1R+CMLeN
         S/BNLPWNqi4TQ==
Date:   Thu, 23 Nov 2023 17:35:38 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
        Deepak Gupta <debug@rivosinc.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>, jannh@google.com,
        linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH RFT v3 2/5] fork: Add shadow stack support to clone3()
Message-ID: <ZV+NamY31GyANEe/@finisterre.sirena.org.uk>
References: <20231120-clone3-shadow-stack-v3-0-a7b8ed3e2acc@kernel.org>
 <20231120-clone3-shadow-stack-v3-2-a7b8ed3e2acc@kernel.org>
 <20231123-derivate-freikarte-6de8984caf85@brauner>
 <ZV9Cz00vAKd7EwKD@finisterre.sirena.org.uk>
 <20231123-ausziehen-harpune-d020d47f964c@brauner>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CndIlGpPnv8RlVC+"
Content-Disposition: inline
In-Reply-To: <20231123-ausziehen-harpune-d020d47f964c@brauner>
X-Cookie: Slow day.  Practice crawling.
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CndIlGpPnv8RlVC+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 23, 2023 at 05:33:05PM +0100, Christian Brauner wrote:
> On Thu, Nov 23, 2023 at 12:17:19PM +0000, Mark Brown wrote:

> > > > +		if (clone_flags & CLONE_VFORK) {
> > > > +			shstk->base = 0;
> > > > +			shstk->size = 0;
> > > > +			return 0;
> > > > +		}

> > > Why is the CLONE_VFORK handling only necessary if shadow_stack_size is
> > > unset? In general, a comment or explanation on the interaction between
> > > CLONE_VFORK and shadow_stack_size would be helpful.

> > This is the existing implicit behaviour that clone() has, it's current
> > ABI for x86.  The intent is that if the user has explicitly configured a
> > shadow stack then we just do whatever they asked us to do, if they

> So what I'm asking is: if the calling process is suspended until the
> child exits or exec's does it make sense for the child to even get a
> shadow stack? I don't know the answer which is why I'm asking.

We were initially doing some suppression of stack creation based on the
flags but based on prior discussion we decided it wasn't worth it.
There was some question about corner cases (IIRC the main one was
posix_spawn()), but generally the thinking here was that since userspace
explicitly asked for the shadow stack in the worst case it'll just be
inefficient and userspace can fix things by just not doing that.  If we
just create the shadow stack whenever it's requested then it makes the
kernel side handling really simple to implement/verify and we don't have
to worry about having missed any use cases with combinations of flags
that we've not anticipated.

--CndIlGpPnv8RlVC+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVfjWoACgkQJNaLcl1U
h9AaCAf9ESVElI0jUJmzKPT+rOMQcmn2utfrXnIajA0L2w8qephayJtaRS/cumi6
x79EY3sWCc3/7DU8ZokCs+1hlLe2YXBcHChU9mPSM5r910muGEmRFmDNYvXT0MDx
zTAxwD1JezQm/xx+eao6qAXcndvSWtQ07KRkY+7kGh48MaBu6ea7ZHGLX36KLU3D
FGZ4pwQjZAEZniikVAMKqkMiZgPWLaklyuu86hpWa1m5m9t6j3O97Zc7zsT9EhvO
+L9dshnSTGK00sGneVJrznPPUm6w+9xYsAO8YNFfVMDSEeezBH3nKHxDGaGONOyP
jacIFPP64N2TZMtsNbsQpUCrFXE4DQ==
=+O4D
-----END PGP SIGNATURE-----

--CndIlGpPnv8RlVC+--
