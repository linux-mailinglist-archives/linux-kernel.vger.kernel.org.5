Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADAE97558E3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 02:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjGQAht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 20:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjGQAhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 20:37:47 -0400
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E0256118;
        Sun, 16 Jul 2023 17:37:45 -0700 (PDT)
Received: from wind.enjellic.com (localhost [127.0.0.1])
        by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 36H0atQM003092;
        Sun, 16 Jul 2023 19:36:55 -0500
Received: (from greg@localhost)
        by wind.enjellic.com (8.15.2/8.15.2/Submit) id 36H0asnJ003091;
        Sun, 16 Jul 2023 19:36:54 -0500
Date:   Sun, 16 Jul 2023 19:36:54 -0500
From:   "Dr. Greg" <greg@enjellic.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/13] Add TSEM specific documentation.
Message-ID: <20230717003654.GA3044@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20230710102319.19716-1-greg@enjellic.com> <20230710102319.19716-3-greg@enjellic.com> <ab6ab3d2-d168-8c10-b7f5-94a669e212fc@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab6ab3d2-d168-8c10-b7f5-94a669e212fc@infradead.org>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Sun, 16 Jul 2023 19:36:55 -0500 (CDT)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 09:37:10PM -0700, Randy Dunlap wrote:

> Hi--

Good morning, I hope the week is starting well for everyone.

> On 7/10/23 03:23, Dr. Greg wrote:
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 9e5bab29685f..0e6640a78936 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -6468,6 +6468,24 @@
> >  			with CPUID.16h support and partial CPUID.15h support.
> >  			Format: <unsigned int>
> >  

> These 3 entries should be in alphabetical order: tsem_cache,
> tsem_digest, tsem_mode.

Now alphabetized.

> > +	tsem_mode=	[TSEM] Set the mode that the Trusted Security Event
> > +			Modeling LSM is to run in.
> > +			Format: 1
> > +			1 -- Disable root domain modeling.
> > +
> > +	tsem_cache=	[TSEM] Define the size of the caches used to hold
> > +			pointers to structures that will be used to model
> > +			security events occurring in the root modeling
> > +			namespace that are called in atomic context.
> > +			Format: <integer>
> > +			Default: 96

> What unit?  KB, MB, bytes, pages?

Our apologies, we obviously erred in the notion that referring to the
size of a cache of pointers would be understood to mean the number of
pointers.

We updated the documentation as follows:

tsem_cache=	[TSEM] Define the size of the caches used to hold
		pointers to structures that will be used to model
		security events occurring in the root modeling
		namespace that are called in atomic context.  The
		value is the size of the arrays of pointers to the
		pre-allocated structures that will be maintained.
		For example, a value of 16 means each array would
		have 16 entries in it.
		Format: <integer>
		Default: 96

> > +
> > +	tsem_digest=	[TSEM] Define the cryptographic hash function that
> > +			will be used to create security event coefficients
> > +			for in the root modeling namespace.

> 			for in
> ?

That must have been an untoward effect of the single-malt.

The documentation has been updated to read as follows:

tsem_digest=	[TSEM] Define the cryptographic hash function that
		will be used to generate the security event
		coefficients in the root modeling namespace.
		Format: {name of the cryptographic hash function}
		Default: sha256

> > +			Format: {name of the cryptographic hash function}
> > +			Default: sha256
> 
> -- 
> ~Randy

Thank you for the review comments.

Have a good week.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
