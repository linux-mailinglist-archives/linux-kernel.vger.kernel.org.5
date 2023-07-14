Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38896754027
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235555AbjGNRKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236016AbjGNRKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:10:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F613594;
        Fri, 14 Jul 2023 10:10:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D1CA61D74;
        Fri, 14 Jul 2023 17:10:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24EF7C433A9;
        Fri, 14 Jul 2023 17:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689354630;
        bh=Lv7iqVr1YQ8TDBfPOdW4/jxdtvTJbkQ8xM6KPN2go38=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NIZ3/YCJ1bNUpLO4ZsDmZjQAxcMcvsGl68b7I+/VoG5IzRFvSZM8DpB1cA1Wxj4cM
         3GnQbqOSQDB5mK6POqkGoCFL40VRg8sJfDnrP7RL1Sjr3KbgplElg0amaAKFBbxNdL
         8HLUqQmiHP4L8E74DQ3C+bjbS6BvvteEbRoo05lX5bYbAPiLUHpMsFunv4oEHyKtjE
         01jcQOoCRITMJFC1QAwYQhxK6YdjMHBeZFfPNlMymjmgJBToErE8BCPfkXEnHPGK80
         AmpTlVxdwwYML0DSsDLWLEjEjixHMjmPmFwkzJhzZydWaf2yfXx0xKzm8vb2PodPPy
         ZXf94vD2hTAhQ==
Date:   Fri, 14 Jul 2023 10:10:28 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     corbet@lwn.net, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH docs] docs: maintainer: document expectations of small
 time maintainers
Message-ID: <20230714101028.337fb39a@kernel.org>
In-Reply-To: <6f1014cd-f8c5-f935-dcc7-4f5a6b85e473@kernel.org>
References: <20230713223432.1501133-1-kuba@kernel.org>
        <6f1014cd-f8c5-f935-dcc7-4f5a6b85e473@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jul 2023 06:36:41 +0200 Krzysztof Kozlowski wrote:
> On 14/07/2023 00:34, Jakub Kicinski wrote:
> > +The amount of maintenance work is usually proportional to the size
> > +and popularity of the code base. Small features and drivers should
> > +require relatively small amount of care and feeding. Nonetheless
> > +when the work does arrive (in form of patches which need review,
> > +user bug reports etc.) it has to be acted upon very promptly.
> > +Even when single driver only sees one patch a month, or a quarter,
> > +a subsystem could well have a hundred such drivers. Subsystem
> > +maintainers cannot afford to wait a long time to hear from reviewers.
> > +
> > +The exact expectations on the review time will vary by subsystem
> > +from 1 day (e.g. networking) to a week in smaller subsystems.  
> 
> Two weeks is the upper limit.
> 
> > +Mailing list participation
> > +--------------------------
> > +
> > +Linux kernel uses mailing lists as the primary form of communication.
> > +Maintainers must be subscribed and follow the appropriate subsystem-wide
> > +mailing list. Either by subscribing to the whole list or using more
> > +modern, selective setup like
> > +`lei <https://people.kernel.org/monsieuricon/lore-lei-part-1-getting-started>`_.
> > +
> > +Maintainers must know how to communicate on the list (plain text, no invasive
> > +legal footers, no top posting, etc.)
> > +
> > +Reviews
> > +-------
> > +
> > +Maintainers must review *all* patches touching exclusively their drivers,  
> 
> I don't agree with this as a small driver maintainer. Several subsystem
> maintainers take the patches much faster than I am able to check the
> inbox. I can provide names if you need some proves. With such criteria I
> should be removed from maintainers, because I am not able to review
> within 24h.
> 
> Either give reasonable time, like two weeks, or don't require driver
> maintainers to be 24/7 for subystem maintainer disposal. This is very
> unfair rule.

I think your concern is more about the timeline than what's quoted here,
so I rephrased that:

-The exact expectations on the review time will vary by subsystem
-from 1 day (e.g. networking) to a week in smaller subsystems.

+The exact expectations on the response time will vary by subsystem.
+The patch review SLA the subsystem had set for itself can sometimes
+be found in the subsystem documentation. Failing that as a rule of thumb
+reviewers should try to respond quicker than what is the usual patch
+review delay of the subsystem maintainer. The resulting expectations
+may range from two working days for fast-paced subsystems to two weeks
+in slower moving parts of the kernel.


To the point of reviewing "all" patches, I want to keep this. When 
I ping vendors they often reply with "oh I didn't know I'm supposed
to respond, the change looks good". People confuse the review process
with a veto process, if they don't want to outright reject the change
they stay quiet :|

> > +no matter how trivial. If the patch is a tree wide change and modifies
> > +multiple drivers - whether to provide a review is left to the maintainer.
> > +
> > +There should be multiple maintainers for any piece of code, an ``Acked-by``
> > +or ``Reviewed-by`` tag (or review comments) from a single maintainer is
> > +enough to satisfy this requirement.
> > +
> > +If review process or validation for a particular change will take longer
> > +than the expected review timeline for the subsystem, maintainer should
> > +reply to the submission indicating that the work is being done, and when
> > +to expect full results.
> > +
> > +Refactoring and core changes
> > +----------------------------
> > +
> > +Occasionally core code needs to be changed to improve the maintainability
> > +of the kernel as a whole. Maintainers are expected to be present and
> > +help guide and test changes to their code to fit the new infrastructure.
> > +
> > +Bug reports
> > +-----------
> > +
> > +Maintainers must respond to and address bug reports. The bug reports  
> 
> This is even more unreasonable than previous 1 day review. I don't have
> capabilities to address bug reports for numerous drivers I am
> maintaining. I don't have hardware, I don't have time, no one pays me
> for it. I still need some life outside of working hours, so expecting
> both reviews in 1 day and addressing bugs is way too much.
> 
> > +range from users reporting real life crashes, thru errors discovered
> > +in fuzzing to reports of issues with the code found by static analysis
> > +tools and new compiler warnings.
> > +
> > +Volunteer maintainers are only required to address bugs and regressions.  
> 
> "Only required"? That's not "only" but a lot.

I was trying to soften the paragraph for volunteers let me try to
soften it.. harder?

> > +It is understood that due to lack of access to documentation and
> > +implementation details they may not be able to solve all problems.  
> 
> So how do I address? Say "Oh, that's bad"?

How about:

  Bug reports
  -----------

  Maintainers must respond to bug reports of reasonable quality. The bug reports
  range from users reporting real life crashes, thru errors discovered
  in fuzzing to reports of issues with the code found by static analysis
  tools and new compiler warnings.

  It is understood that the hands of volunteer maintainers can often be tied
  by the lack of access to documentation, implementation details, hardware
  platforms, etc.


I don't know how to phrase it better :( Obviously maintainers are
expected to look at bug reports. At the same time we all know the
feeling of being a maintainer of some crappy HW which sometimes 
doesn't work and all we can do is say "thoughts and prayers". 

IDK. 

The doc would be incomplete without mentioning that bug reports are
part of maintainers' life :(

> Jakub, with both of your criteria - reviewing and addressing - I should
> be dropped from all the driver maintainership. If this document passes,
> I will do it - drop myself - because:
> 1. No one pays me for it,
> 2. I barely have hardware,
> 3. I want to live a life and I am already working much more than 8h per day.

It's really hard to codify the rules. I hope we can start somewhere
and chisel at the rules if/as we start getting feedback/complaints.

I can give you examples of bad vendor behavior or people who stopped
participating 10 years ago yet they still figure in MAINTAINERS all day.
Next time I see a rando manager added as a maintainer I want to be able
to point them at a document. If the document is too "soft" they will
just wave it off :(
