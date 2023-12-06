Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE44D8077B8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 19:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbjLFSm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 13:42:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjLFSm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 13:42:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147A0D40
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 10:42:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02CFFC433CA;
        Wed,  6 Dec 2023 18:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701888152;
        bh=Z1/55yzMuInGGMiFrVpL72QittGX16HCTLFf+Os5o/w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YZlmINq0IhveoV1iEJDBzMqrwVakbojITZqfK7Ub17p4CaHW4axLE1K8gmtbPzdXY
         7sZgtS8nJcEHdyx8PrY26UkJjo3Ti4WlDXOn5VBnZLNSYol2VE+xEIRfjHsogWpwEf
         em8DLtq0DGYwf1gGD2xcVI3FCflaNEOtkEuXwoZv7gMeZsVU7HryDKpUvnXzta/pdT
         BSrkOORx/nxKZI91EItlnB7hcoxIUL25ZHM46t+eDqisxnnmynuqKdkd36MVd+OrmE
         odcXURBHZCAVFMmdn6JICXKvM0km2elMMzpv2daDtblEuonbBGmowoFW7UPqQw3k6y
         9W0LBUzmtQiBg==
Date:   Wed, 6 Dec 2023 18:42:23 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "vschneid@redhat.com" <vschneid@redhat.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "will@kernel.org" <will@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jannh@google.com" <jannh@google.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "bsegall@google.com" <bsegall@google.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>
Subject: Re: [PATCH RFT v4 5/5] kselftest/clone3: Test shadow stack support
Message-ID: <2a7fe5bd-3133-4bdf-9150-cf929925d421@sirena.org.uk>
References: <20231128-clone3-shadow-stack-v4-0-8b28ffe4f676@kernel.org>
 <20231128-clone3-shadow-stack-v4-5-8b28ffe4f676@kernel.org>
 <4898975452179af46f38daa6979b32ba94001419.camel@intel.com>
 <345cf31a-3663-4974-9b2a-54d2433e64a7@sirena.org.uk>
 <a6bf192a1568620826dd79124511ea61472873c8.camel@intel.com>
 <098f5d43-e093-4316-9b86-80833c2b94ec@sirena.org.uk>
 <127bba3063b19dd87ae3014f6d3bba342f7a16fb.camel@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zxBosQRC8SZzpWjX"
Content-Disposition: inline
In-Reply-To: <127bba3063b19dd87ae3014f6d3bba342f7a16fb.camel@intel.com>
X-Cookie: From concentrate.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zxBosQRC8SZzpWjX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 05, 2023 at 10:31:09PM +0000, Edgecombe, Rick P wrote:
> On Tue, 2023-12-05 at 16:43 +0000, Mark Brown wrote:

> > If the x86 toolchain/libc support is widely enough deployed (or you
> > just
> > don't mind any missing coverage) we could use the toolchain support
> > there and only have the manual enable for arm64, it'd be inconsistent
> > but not wildly so.

> I'm hoping there is not too much of a gap before the glibc support
> starts filtering out. Long term, elf bit enabling is probably the right
> thing for the generic tests. Short term, manual enabling is ok with me
> if no one else minds. Maybe we could add my "don't do" list as a
> comment if we do manual enabling?

Probably good to write it up somewhere, yes - it'd also be useful for
anyone off doing their own non-libc things.  It did cross my mind to
try to make a document for the generic bit of the ABI for shadow stacks.

> I'll have to check your new series, but I also wonder if we could cram
> the manual enabling and status checking pieces into some headers and
> not have to have "if x86" "if arm" logic in the test themselves.

I did think about that but was worried that a header might encourage
more users doing the hacky thing.  OTOH it would mean the arch specific
tests could share the header though so perhaps you're right, I'll take a
look.

--zxBosQRC8SZzpWjX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVwwI8ACgkQJNaLcl1U
h9CVHQf/cmjZxceMOIDMMSGhM2fS6i96ldlWTSPwQfb5HMKyTcQ9YOSXaNHb1m2n
dbvgXqvkgPThdFw0hYwcTryPVlHqdnqTAuZwcn5s0I+z0YEt9KiBtfNM1AZtxSkd
wIEAlKcXlSJV6x8d35Hg5hsVHoeEefnw4Wi5qVddYjN2yoBVVKH11gniMSs5dll+
nlvb20GPpPPTFyx3qqVyuraICoNnxRAI7x/+GyDlDJW4fn9EBcYnOr32L4kRxIY7
aQY9S2naHGi/jQoayRcGng+kj+FMGqeRF6nJh3oN57fekEqjJvcE43JtefHT25Cf
AuTtlmmNB4jQcvkAK6CoMdX6HG153w==
=RXcG
-----END PGP SIGNATURE-----

--zxBosQRC8SZzpWjX--
