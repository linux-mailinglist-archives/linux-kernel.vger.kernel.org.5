Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4088F78A100
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 20:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjH0SaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 14:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjH0S36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 14:29:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0580125;
        Sun, 27 Aug 2023 11:29:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15F4B61142;
        Sun, 27 Aug 2023 18:29:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD444C433C7;
        Sun, 27 Aug 2023 18:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693160995;
        bh=tb1OXQkHPNQCQkfYRrTcJBEgq95JZ1a2PwPjsGJdgOE=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=VFS40JNPmy1VfqGZcC8W0ntBZaEiT6m0I7Tjgh+IGrqrYi/HovNmK9BNPtO4AvR9C
         6hpyWojceSlD8hiiU8lwzgV6JGWqmoBTLuwYWMkAisNoY5iVaNEMJBRUp920jgPibn
         qnsmrZxTVRdshQSYA7zGDb27MLSx2LYJhzQbdRhVAN7cMokORuODNEMTwz6rux2w3I
         b+o6SYSBPgTnwJHcUHlZrGuyvbhJTvkdag1/gT1dmMfiHrFM4k93CnLOKPAqJGLQtg
         NLWvlNHADgruiLhY+cmnsDueLBBci9pHAWkY8m2vFSwukwcqvi+HFeYngU9JO4VWPP
         UU66qNC/XxuwA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 27 Aug 2023 21:29:50 +0300
Message-Id: <CV3JH95Z8SUR.M3YJTDW2D7GW@suppilovahvero>
Subject: Re: checkpatch complains about Reported-by block (was: [PATCH v3]
 tpm: Enable hwrng only for Pluton on AMD CPUs)
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Joe Perches" <joe@perches.com>,
        "Paul Menzel" <pmenzel@molgen.mpg.de>,
        "Andy Whitcroft" <apw@canonical.com>
Cc:     <linux-integrity@vger.kernel.org>,
        "Jerry Snitselaar" <jsnitsel@redhat.com>, <stable@vger.kernel.org>,
        "Todd Brandt" <todd.e.brandt@intel.com>,
        "Peter Huewe" <peterhuewe@gmx.de>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        "Mario Limonciello" <mario.limonciello@amd.com>,
        <linux-kernel@vger.kernel.org>, "Patrick Steinhardt" <ps@pks.im>,
        "Ronan Pigott" <ronan@rjp.ie>,
        "Raymond Jay Golo" <rjgolo@gmail.com>
X-Mailer: aerc 0.14.0
References: <20230822231510.2263255-1-jarkko@kernel.org>
 <705b9769-4132-450b-bd47-2423c419db2a@molgen.mpg.de>
 <CV03X3OEI7RE.3NI1QJ6MBJSHA@suppilovahvero>
 <3a9bf7a1-1664-401d-8cff-3a5d553bdd77@molgen.mpg.de>
 <0155a718388cf598d2171795c129a93f04a1ddfd.camel@perches.com>
In-Reply-To: <0155a718388cf598d2171795c129a93f04a1ddfd.camel@perches.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Aug 24, 2023 at 7:43 AM EEST, Joe Perches wrote:
> On Wed, 2023-08-23 at 21:24 +0200, Paul Menzel wrote:
> > [Cc: +Andy, +Joe]
> >=20
> >=20
> > Dear Jarkko, dear Andy, dear Joe,
> >=20
> >=20
> > Am 23.08.23 um 19:40 schrieb Jarkko Sakkinen:
> > > On Wed Aug 23, 2023 at 11:23 AM EEST, Paul Menzel wrote:
> >=20
> > > > Am 23.08.23 um 01:15 schrieb Jarkko Sakkinen:
> > > > > The vendor check introduced by commit 554b841d4703 ("tpm: Disable=
 RNG for
> > > > > all AMD fTPMs") doesn't work properly on a number of Intel fTPMs.=
  On the
> > > > > reported systems the TPM doesn't reply at bootup and returns back=
 the
> > > > > command code. This makes the TPM fail probe.
> > > > >=20
> > > > > Since only Microsoft Pluton is the only known combination of AMD =
CPU and
> > > > > fTPM from other vendor, disable hwrng otherwise. In order to make=
 sysadmin
> > > > > aware of this, print also info message to the klog.
> > > > >=20
> > > > > Cc: stable@vger.kernel.org
> > > > > Fixes: 554b841d4703 ("tpm: Disable RNG for all AMD fTPMs")
> > > > > Reported-by: Todd Brandt <todd.e.brandt@intel.com>
> > > > > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217804
> > > > > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > >=20
> > > > Mario=E2=80=99s patch also had the three reporters below listed:
> > > >=20
> > > > Reported-by: Patrick Steinhardt <ps@pks.im>
> > > > Reported-by: Ronan Pigott <ronan@rjp.ie>
> > > > Reported-by: Raymond Jay Golo <rjgolo@gmail.com>
> > >=20
> > > The problem here is that checkpatch throws three warnings:
> > >=20
> > > WARNING: Reported-by: should be immediately followed by Closes: with =
a URL to the report
> > > #19:
> > > Reported-by: Patrick Steinhardt <ps@pks.im>
> > > Reported-by: Ronan Pigott <ronan@rjp.ie>
> > >=20
> > > WARNING: Reported-by: should be immediately followed by Closes: with =
a URL to the report
> > > #20:
> > > Reported-by: Ronan Pigott <ronan@rjp.ie>
> > > Reported-by: Raymond Jay Golo <rjgolo@gmail.com>
> > >=20
> > > WARNING: Reported-by: should be immediately followed by Closes: with =
a URL to the report
> > > #21:
> > > Reported-by: Raymond Jay Golo <rjgolo@gmail.com>
> > > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > >=20
> > > Since bugzilla is not part of the documented process afaik, I used th=
is
> > > field as the guideline:
> > >=20
> > > Reported:	2023-08-17 20:59 UTC by Todd Brandt
> > >=20
> > > How otherwise I should interpret kernel bugzilla?
> >=20
> > How is the proper process to add more than one reporter (so they are=20
> > noted and also added to CC), so that checkpatch.pl does not complain?
> >=20
> >=20
> > Kind regards,
> >=20
> > Paul
> >=20
> >=20
> > > In any case new version is still needed as the commit message must
> > > contain a mention of "Lenovo Legion Y540" as the stimulus for doing
> > > this code change in the first place.
> > >=20
> > > BR, Jarkko
>
> Well, if it's really desired to allow multiple consecutive reported-by:
> lines, maybe:
> ---
>  scripts/checkpatch.pl | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 528f619520eb9..5b5c11ad04087 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3179,6 +3179,8 @@ sub process {
>  				if (!defined $lines[$linenr]) {
>  					WARN("BAD_REPORTED_BY_LINK",
>  					     "Reported-by: should be immediately followed by Closes: with a=
 URL to the report\n" . $herecurr . "\n");
> +				} elsif ($rawlines[$linenr] =3D~ /^\s*reported(?:|-and-tested)-by:/i=
) {
> +					;
>  				} elsif ($rawlines[$linenr] !~ /^closes:\s*/i) {
>  					WARN("BAD_REPORTED_BY_LINK",
>  					     "Reported-by: should be immediately followed by Closes: with a=
 URL to the report\n" . $herecurr . $rawlines[$linenr] . "\n");

Kind of opposing this because:

1. Bugzilla has a reporter field.
2. The request is now, if I understood this correctly, to add
   reported-by field to all people who have left a comment.
3. There is a field for the reporter, which points out to a single
   person. Why all the possible commenters and not the creator
   of the report?

BR, Jarkko
