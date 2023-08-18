Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A28F7815E7
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 01:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243014AbjHRXpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 19:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242803AbjHRXpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 19:45:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D562135;
        Fri, 18 Aug 2023 16:45:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B787A61AC3;
        Fri, 18 Aug 2023 23:45:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DFD6C433C8;
        Fri, 18 Aug 2023 23:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692402301;
        bh=EFspup6cR9VPHpUpqSpRCk0dSa6MjO+d0wAi8Hq18po=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LZ5ElMq+XVvkH9j+Vo8v3BVpCeb1amQjUJemQnEx8Q/SED18QB/TaJmX36iMuRk3M
         9k9Sj0eWgq4TEsg2jHcN/xeRZqIhcCJffniZgTxid//0Z7sUc9KA6zA+MPCmgcK3FH
         mgGA/2+AsXcZvh4MuwtzMr1YVJbOpsuxzaNTefg6VR8IWSVbh51EVwb4Koxdjxl2Rb
         rOYKEKKMI/jsHmKfTpRAuBcqHl7PlTv4bhdg7ACw1nTZl+T1uPeaNpaH4WsbBT8hs1
         2ilPFi6W3YDU55tRtjL2/fXlauG7DdGO+BYOa5goCeCHYC4LqO4RonZWFZVKUaSGOD
         Wcu/TwN3Sqv4Q==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 18 Aug 2023 23:44:57 +0000
Message-Id: <CUW2JM314GAR.36XV41132X3OX@seitikki>
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Thorsten Leemhuis" <regressions@leemhuis.info>,
        <charles.d.prestopine@intel.com>, <rafael.j.wysocki@intel.com>,
        <len.brown@intel.com>, <stable@vger.kernel.org>,
        "Todd Brandt" <todd.e.brandt@intel.com>
Subject: Re: [PATCH] tpm: Don't make vendor check required for probe
X-Mailer: aerc 0.14.0
References: <20230818181516.19167-1-mario.limonciello@amd.com>
 <CUW0GZCVHKPB.1W7ESSPE7INHQ@seitikki>
 <25a21516-7201-4ee4-be2b-f67edaf97e2a@amd.com>
In-Reply-To: <25a21516-7201-4ee4-be2b-f67edaf97e2a@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Aug 18, 2023 at 10:38 PM UTC, Limonciello, Mario wrote:
>
>
> On 8/18/2023 5:07 PM, Jarkko Sakkinen wrote:
> > On Fri Aug 18, 2023 at 6:15 PM UTC, Mario Limonciello wrote:
> >> The vendor check introduced by commit 554b841d4703 ("tpm: Disable RNG =
for
> >> all AMD fTPMs") doesn't work properly on Intel fTPM.  The TPM doesn't =
reply
> >> at bootup and returns back the command code.
> >=20
> > Is this reproducible with any production hardware? You are stating it
> > as it was reproducible categorically with any Intel fTPM.
> >=20
>
> Yes, it's affecting production hardware too.
> Someone came to the kernel bugzilla and reported a regression on 6.4.11=
=20
> on a Lenovo Intel laptop as well.

Now the description says that cateogrically all Intel fTPM's fail.

I asked for the laptop model in the bugzilla bug, which should be put to
the commit description later on (hopefully with a snippet of klog
transcript). This commit cannot be applied as it is at the moment, even
if it turned out to be a legit fix.

> >> As this isn't crucial for anything but AMD fTPM and AMD fTPM works, th=
row
> >> away the error code to let Intel fTPM continue to work.
> >>
> >> Cc: stable@vger.kernel.org
> >> Fixes: 554b841d4703 ("tpm: Disable RNG for all AMD fTPMs")
> >=20
> > It does make sense not to exercise this outside of AMD CPus but since
> > there is no production hardware failing, it cannot be categorized as a
> > bug fix.
>
> See above (and also kernel bugzilla).
>
> >=20
> >> Reported-by: Todd Brandt <todd.e.brandt@intel.com>
> >> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217804
> >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >> ---
> >>   drivers/char/tpm/tpm_crb.c | 3 +--
> >>   1 file changed, 1 insertion(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> >> index 9eb1a18590123..b0e9931fe436c 100644
> >> --- a/drivers/char/tpm/tpm_crb.c
> >> +++ b/drivers/char/tpm/tpm_crb.c
> >> @@ -472,8 +472,7 @@ static int crb_check_flags(struct tpm_chip *chip)
> >>   	if (ret)
> >>   		return ret;
> >>  =20
> >> -	ret =3D tpm2_get_tpm_pt(chip, TPM2_PT_MANUFACTURER, &val, NULL);
> >> -	if (ret)
> >> +	if (tpm2_get_tpm_pt(chip, TPM2_PT_MANUFACTURER, &val, NULL))
> >>   		goto release;
> >=20
> > It would be better not to exercise a potentially failing code path at
> > all. This initiates full transaction with the TPM.
>
> So why does a full transaction not work in this case?

It makes absolutely zero sense to send a message to a TPM just to know
that you are on AMD CPU, right?

E.g. you could check if boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_AMD righ=
t
in the beginning of this function.

BR, Jarkko
