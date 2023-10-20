Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8527D1935
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 00:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjJTWev convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 20 Oct 2023 18:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjJTWeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 18:34:50 -0400
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B4891
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 15:34:45 -0700 (PDT)
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay09.hostedemail.com (Postfix) with ESMTP id A1C8480233;
        Fri, 20 Oct 2023 22:34:43 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf11.hostedemail.com (Postfix) with ESMTPA id 6F1CB2002F;
        Fri, 20 Oct 2023 22:34:41 +0000 (UTC)
Message-ID: <fbd86466d325055846e5d63f62ca1dc8613ba80d.camel@perches.com>
Subject: Re: [PATCH] checkpatch: allow tags between co-developed-by and
 their sign-off
From:   Joe Perches <joe@perches.com>
To:     Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Jacob Keller <jacob.e.keller@intel.com>
Date:   Fri, 20 Oct 2023 15:34:40 -0700
In-Reply-To: <20231020132156.37882-1-przemyslaw.kitszel@intel.com>
References: <20231020132156.37882-1-przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 6F1CB2002F
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout06
X-Stat-Signature: ejx1fdsi4p19nyntrhqe4nitqku94cta
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX192xNY8g1V4VJHRbK/KkJ93xdgnr/pv91c=
X-HE-Tag: 1697841281-109740
X-HE-Meta: U2FsdGVkX1/CJ6MPuslSjj72SWELfX+WrEQUXANFi+dkvn/6BM4rMZQ0XwrplW7GyMF27wNGSPLyqMU37ZGgH0Mw7UnGC4i7QkcMt/phT6OfrvK59oQJjLYluE7cSAnmVkyO9Zz7qfBIOWAf4SzQwuzfodpmHT35LoFqp8Vol4kp0RtadzunbhtJNoE0R0yGjVIhxQ/4uHGvCu0kG1oHcW+mzOa4m4twg/JIJqYCAqv+39PAw+tDu9TEDjUUqpM61lSu3RLYEy9Ns5E0pP3o9qn+PgymcFvYeiIqv29emCmnJOnkSVsninCTrf0aI8KQwHk2typc8uKYEheqFOzAdzFRQM+N/K1jSsuvgke8G/Qplc5ecFh9LSIUGOou3NA5
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-10-20 at 15:21 +0200, Przemek Kitszel wrote:
> Allow additional tags between Co-developed-by: and Signed-off-by:.
> Bump severity of missing SoB to ERROR.
> 
> Additional tags between Co-developed-by and corresponding Signed-off-by
> could include Reviewed-by tags collected by Submitter, which is also
> a Co-developer, but should sign-off at the very end of tags provided by
> themself.
> 
> Missing SoB is promoted to error while that piece of code is touched.
> 
> Two sets of perl %hashes introduced to keep both (int) line numbers and
> (string) messages handy for warning reporting, while keeping it correct
> across 100+ line long commit messages.
> 
> Mateusz Polchlopek <mateusz.polchlopek@intel.com> has reported this to me.
> 
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Unless this is accepted by various process folk,
and the documentation for it updated, I think this
should not be applied.

> ---
>  scripts/checkpatch.pl | 36 +++++++++++++++++++++++-------------
>  1 file changed, 23 insertions(+), 13 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 7d16f863edf1..0400bf092bfa 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2682,6 +2682,10 @@ sub process {
>  	my $suppress_statement = 0;
>  
>  	my %signatures = ();
> +	my %signoffs = ();
> +	my %signoffs_msg = ();
> +	my %codevs = ();
> +	my %codevs_msg = ();
>  
>  	# Pre-scan the patch sanitizing the lines.
>  	# Pre-scan the patch looking for any __setup documentation.
> @@ -2967,11 +2971,13 @@ sub process {
>  		if ($line =~ /^\s*signed-off-by:\s*(.*)/i) {
>  			$signoff++;
>  			$in_commit_log = 0;
> +			my $ctx = $1;
> +			$signoffs{$ctx} = $linenr;
> +			$signoffs_msg{$ctx} = $herecurr;
>  			if ($author ne ''  && $authorsignoff != 1) {
> -				if (same_email_addresses($1, $author)) {
> +				if (same_email_addresses($ctx, $author)) {
>  					$authorsignoff = 1;
>  				} else {
> -					my $ctx = $1;
>  					my ($email_name, $email_comment, $email_address, $comment1) = parse_email($ctx);
>  					my ($author_name, $author_comment, $author_address, $comment2) = parse_email($author);
>  
> @@ -3158,22 +3164,15 @@ sub process {
>  				$signatures{$sig_nospace} = 1;
>  			}
>  
> -# Check Co-developed-by: immediately followed by Signed-off-by: with same name and email
> +# Collect Co-developed-by: to check if each is backed up by Signed-off-by: with
> +# the same name and email. Checks are made after main loop.
>  			if ($sign_off =~ /^co-developed-by:$/i) {
>  				if ($email eq $author) {
>  					WARN("BAD_SIGN_OFF",
>  					      "Co-developed-by: should not be used to attribute nominal patch author '$author'\n" . $herecurr);
>  				}
> -				if (!defined $lines[$linenr]) {
> -					WARN("BAD_SIGN_OFF",
> -					     "Co-developed-by: must be immediately followed by Signed-off-by:\n" . $herecurr);
> -				} elsif ($rawlines[$linenr] !~ /^signed-off-by:\s*(.*)/i) {
> -					WARN("BAD_SIGN_OFF",
> -					     "Co-developed-by: must be immediately followed by Signed-off-by:\n" . $herecurr . $rawlines[$linenr] . "\n");
> -				} elsif ($1 ne $email) {
> -					WARN("BAD_SIGN_OFF",
> -					     "Co-developed-by and Signed-off-by: name/email do not match\n" . $herecurr . $rawlines[$linenr] . "\n");
> -				}
> +				$codevs{$email} = $linenr;
> +				$codevs_msg{$email} = $herecurr;
>  			}
>  
>  # check if Reported-by: is followed by a Closes: tag
> @@ -7712,6 +7711,17 @@ sub process {
>  				     "From:/Signed-off-by: email subaddress mismatch: $sob_msg\n");
>  			}
>  		}
> +		# check if each Co-developed-by tag is backed up by Sign-off,
> +		# warn if Co-developed-by tag was put after a Signed-off-by tag
> +		foreach my $codev (keys %codevs) {
> +			if (!$signoffs{$codev}) {
> +				ERROR("BAD_SIGN_OFF",
> +				      "Co-developed-by: must be followed by Signed-off-by:\n" . $codevs_msg{$codev});
> +			} elsif ($signoffs{$codev} <= $codevs{$codev}) {
> +				WARN("BAD_SIGN_OFF",
> +				     "Co-developed-by: must be followed by Signed-off-by:, but was placed after it\n" . $signoffs_msg{$codev} . $codevs_msg{$codev});
> +			}
> +		}
>  	}
>  
>  	print report_dump();

