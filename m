Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D2378A0F6
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 20:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjH0S1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 14:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjH0S0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 14:26:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F6E124;
        Sun, 27 Aug 2023 11:26:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A57FD6126E;
        Sun, 27 Aug 2023 18:26:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85FFDC433C8;
        Sun, 27 Aug 2023 18:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693160801;
        bh=BNhZjXtFRAq8UQSVisMuoJblKFrLwF19vEF2lrOavWI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OFk/bDvUAxLUcrn3qfbleo0k/NItYzTtSOwvtU55upF71TsjibAVogZ6qcvkuQl02
         n1xPeUVW+rMGv7Ta3N9q+YxjIMhO6rMhr7bwGhr6+uYil7mQqSyiOdTwgRwwHK+8uR
         MStwI0iZDtXUmDV7QVusssPf+hbfpUH9IqoC31rOlI+ZSSlyDT3wkAw7/KrE3efpVb
         3du8yrRDIfukKJ4g29jGZFHpTMo1pzsXWA3pDEbpk1Q/G88mrq9HVeE90tAFFrFPHP
         z01GqFQ/wNINLy1+UzCWYheJcgEPwKkLBrV8HbCFnp2qkzD7ZJZLnyClMBliV0qvCc
         Sik6KUlc5SAZw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 27 Aug 2023 21:26:36 +0300
Message-Id: <CV3JERZA6ER0.3AV8WCESHCBOZ@suppilovahvero>
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Paul Menzel" <pmenzel@molgen.mpg.de>,
        "Andy Whitcroft" <apw@canonical.com>,
        "Joe Perches" <joe@perches.com>
Cc:     <linux-integrity@vger.kernel.org>,
        "Jerry Snitselaar" <jsnitsel@redhat.com>, <stable@vger.kernel.org>,
        "Todd Brandt" <todd.e.brandt@intel.com>,
        "Peter Huewe" <peterhuewe@gmx.de>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        "Mario Limonciello" <mario.limonciello@amd.com>,
        <linux-kernel@vger.kernel.org>, "Patrick Steinhardt" <ps@pks.im>,
        "Ronan Pigott" <ronan@rjp.ie>,
        "Raymond Jay Golo" <rjgolo@gmail.com>
Subject: Re: checkpatch complains about Reported-by block (was: [PATCH v3]
 tpm: Enable hwrng only for Pluton on AMD CPUs)
X-Mailer: aerc 0.14.0
References: <20230822231510.2263255-1-jarkko@kernel.org>
 <705b9769-4132-450b-bd47-2423c419db2a@molgen.mpg.de>
 <CV03X3OEI7RE.3NI1QJ6MBJSHA@suppilovahvero>
 <3a9bf7a1-1664-401d-8cff-3a5d553bdd77@molgen.mpg.de>
In-Reply-To: <3a9bf7a1-1664-401d-8cff-3a5d553bdd77@molgen.mpg.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Aug 23, 2023 at 10:24 PM EEST, Paul Menzel wrote:
> [Cc: +Andy, +Joe]
>
>
> Dear Jarkko, dear Andy, dear Joe,
>
>
> Am 23.08.23 um 19:40 schrieb Jarkko Sakkinen:
> > On Wed Aug 23, 2023 at 11:23 AM EEST, Paul Menzel wrote:
>
> >> Am 23.08.23 um 01:15 schrieb Jarkko Sakkinen:
> >>> The vendor check introduced by commit 554b841d4703 ("tpm: Disable RNG=
 for
> >>> all AMD fTPMs") doesn't work properly on a number of Intel fTPMs.  On=
 the
> >>> reported systems the TPM doesn't reply at bootup and returns back the
> >>> command code. This makes the TPM fail probe.
> >>>
> >>> Since only Microsoft Pluton is the only known combination of AMD CPU =
and
> >>> fTPM from other vendor, disable hwrng otherwise. In order to make sys=
admin
> >>> aware of this, print also info message to the klog.
> >>>
> >>> Cc: stable@vger.kernel.org
> >>> Fixes: 554b841d4703 ("tpm: Disable RNG for all AMD fTPMs")
> >>> Reported-by: Todd Brandt <todd.e.brandt@intel.com>
> >>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217804
> >>> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> >>
> >> Mario=E2=80=99s patch also had the three reporters below listed:
> >>
> >> Reported-by: Patrick Steinhardt <ps@pks.im>
> >> Reported-by: Ronan Pigott <ronan@rjp.ie>
> >> Reported-by: Raymond Jay Golo <rjgolo@gmail.com>
> >=20
> > The problem here is that checkpatch throws three warnings:
> >=20
> > WARNING: Reported-by: should be immediately followed by Closes: with a =
URL to the report
> > #19:
> > Reported-by: Patrick Steinhardt <ps@pks.im>
> > Reported-by: Ronan Pigott <ronan@rjp.ie>
> >=20
> > WARNING: Reported-by: should be immediately followed by Closes: with a =
URL to the report
> > #20:
> > Reported-by: Ronan Pigott <ronan@rjp.ie>
> > Reported-by: Raymond Jay Golo <rjgolo@gmail.com>
> >=20
> > WARNING: Reported-by: should be immediately followed by Closes: with a =
URL to the report
> > #21:
> > Reported-by: Raymond Jay Golo <rjgolo@gmail.com>
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> >=20
> > Since bugzilla is not part of the documented process afaik, I used this
> > field as the guideline:
> >=20
> > Reported:	2023-08-17 20:59 UTC by Todd Brandt
> >=20
> > How otherwise I should interpret kernel bugzilla?
>
> How is the proper process to add more than one reporter (so they are=20
> noted and also added to CC), so that checkpatch.pl does not complain?

I have no idea. I actually tried all sorts of combinations with no luck.

Since it exists and is out there, the process documentation should
really bring up some clarity to the kernel bugzilla.

BR, Jarkko
