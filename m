Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60B67866D4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 06:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239079AbjHXEnw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 24 Aug 2023 00:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239003AbjHXEn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 00:43:26 -0400
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6788810E4;
        Wed, 23 Aug 2023 21:43:24 -0700 (PDT)
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay10.hostedemail.com (Postfix) with ESMTP id 4F25FC0199;
        Thu, 24 Aug 2023 04:43:22 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf11.hostedemail.com (Postfix) with ESMTPA id BF3892002C;
        Thu, 24 Aug 2023 04:43:18 +0000 (UTC)
Message-ID: <0155a718388cf598d2171795c129a93f04a1ddfd.camel@perches.com>
Subject: Re: checkpatch complains about Reported-by block (was: [PATCH v3]
 tpm: Enable hwrng only for Pluton on AMD CPUs)
From:   Joe Perches <joe@perches.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Andy Whitcroft <apw@canonical.com>
Cc:     linux-integrity@vger.kernel.org,
        Jerry Snitselaar <jsnitsel@redhat.com>, stable@vger.kernel.org,
        Todd Brandt <todd.e.brandt@intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mario Limonciello <mario.limonciello@amd.com>,
        linux-kernel@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
        Ronan Pigott <ronan@rjp.ie>,
        Raymond Jay Golo <rjgolo@gmail.com>
Date:   Wed, 23 Aug 2023 21:43:17 -0700
In-Reply-To: <3a9bf7a1-1664-401d-8cff-3a5d553bdd77@molgen.mpg.de>
References: <20230822231510.2263255-1-jarkko@kernel.org>
         <705b9769-4132-450b-bd47-2423c419db2a@molgen.mpg.de>
         <CV03X3OEI7RE.3NI1QJ6MBJSHA@suppilovahvero>
         <3a9bf7a1-1664-401d-8cff-3a5d553bdd77@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: BF3892002C
X-Stat-Signature: 1xjjsce6i7jma615t5qrayscjq57i77b
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Rspamd-Server: rspamout01
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19JYEiz5PLpsLuruTuFz2VoiXh0OmEylcQ=
X-HE-Tag: 1692852198-257671
X-HE-Meta: U2FsdGVkX18dUYFgPAQ9ALE34cDSU20UTVW4v+/WfftjxcVwLDAO/iYlu2p9HTFx2nbunLChkhEy99hDhbsGyAVSwMlubZAymz5tXIdTjWR1KOLAi+hcDAkoRxwl3Ui+y3rfUF3WhAQivGMqptjwN9+Q8HMfHLirF6cxXKFdz7pSJO1aqFRGXLRq8EbDxCDmDma3KYVzhscvWv3cHFdLVS5sOef75KM+fs0vu73ins+f0XmsSj8yp97NsS4VVU/dp2hIOLvsW8tiwj1N7j2hcoHlh9c7AzajKKzDTCoyWHTULdcJketAj9AdxAOVdsqw7QrSd8zg29bJDWxfXfKx3mPvDKp5fzp+EsDgmds6MsLhHPjHgP1mpOZdZWAGNJiV//p8dWLuQkNxyXKBNi+TxAbB/I6qrzc7+iXM+rEIi9o=
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-08-23 at 21:24 +0200, Paul Menzel wrote:
> [Cc: +Andy, +Joe]
> 
> 
> Dear Jarkko, dear Andy, dear Joe,
> 
> 
> Am 23.08.23 um 19:40 schrieb Jarkko Sakkinen:
> > On Wed Aug 23, 2023 at 11:23 AM EEST, Paul Menzel wrote:
> 
> > > Am 23.08.23 um 01:15 schrieb Jarkko Sakkinen:
> > > > The vendor check introduced by commit 554b841d4703 ("tpm: Disable RNG for
> > > > all AMD fTPMs") doesn't work properly on a number of Intel fTPMs.  On the
> > > > reported systems the TPM doesn't reply at bootup and returns back the
> > > > command code. This makes the TPM fail probe.
> > > > 
> > > > Since only Microsoft Pluton is the only known combination of AMD CPU and
> > > > fTPM from other vendor, disable hwrng otherwise. In order to make sysadmin
> > > > aware of this, print also info message to the klog.
> > > > 
> > > > Cc: stable@vger.kernel.org
> > > > Fixes: 554b841d4703 ("tpm: Disable RNG for all AMD fTPMs")
> > > > Reported-by: Todd Brandt <todd.e.brandt@intel.com>
> > > > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217804
> > > > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > 
> > > Mario’s patch also had the three reporters below listed:
> > > 
> > > Reported-by: Patrick Steinhardt <ps@pks.im>
> > > Reported-by: Ronan Pigott <ronan@rjp.ie>
> > > Reported-by: Raymond Jay Golo <rjgolo@gmail.com>
> > 
> > The problem here is that checkpatch throws three warnings:
> > 
> > WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
> > #19:
> > Reported-by: Patrick Steinhardt <ps@pks.im>
> > Reported-by: Ronan Pigott <ronan@rjp.ie>
> > 
> > WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
> > #20:
> > Reported-by: Ronan Pigott <ronan@rjp.ie>
> > Reported-by: Raymond Jay Golo <rjgolo@gmail.com>
> > 
> > WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
> > #21:
> > Reported-by: Raymond Jay Golo <rjgolo@gmail.com>
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > 
> > Since bugzilla is not part of the documented process afaik, I used this
> > field as the guideline:
> > 
> > Reported:	2023-08-17 20:59 UTC by Todd Brandt
> > 
> > How otherwise I should interpret kernel bugzilla?
> 
> How is the proper process to add more than one reporter (so they are 
> noted and also added to CC), so that checkpatch.pl does not complain?
> 
> 
> Kind regards,
> 
> Paul
> 
> 
> > In any case new version is still needed as the commit message must
> > contain a mention of "Lenovo Legion Y540" as the stimulus for doing
> > this code change in the first place.
> > 
> > BR, Jarkko

Well, if it's really desired to allow multiple consecutive reported-by:
lines, maybe:
---
 scripts/checkpatch.pl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 528f619520eb9..5b5c11ad04087 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3179,6 +3179,8 @@ sub process {
 				if (!defined $lines[$linenr]) {
 					WARN("BAD_REPORTED_BY_LINK",
 					     "Reported-by: should be immediately followed by Closes: with a URL to the report\n" . $herecurr . "\n");
+				} elsif ($rawlines[$linenr] =~ /^\s*reported(?:|-and-tested)-by:/i) {
+					;
 				} elsif ($rawlines[$linenr] !~ /^closes:\s*/i) {
 					WARN("BAD_REPORTED_BY_LINK",
 					     "Reported-by: should be immediately followed by Closes: with a URL to the report\n" . $herecurr . $rawlines[$linenr] . "\n");

