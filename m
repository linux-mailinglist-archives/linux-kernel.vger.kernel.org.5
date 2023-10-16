Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7887CB66E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 00:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbjJPWQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 18:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjJPWQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 18:16:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C1FF1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 15:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697494537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WWU5V1er/iUZOcl8s3BoY8FcUa0kV+G70KVQ2Non5Og=;
        b=D8MR/0csXcC5wX7I5svjQeZAHWwNjuY8wMpFTKu2BNJ2tG2AaJ0MpxQCNZnC/N/unx0ysK
        Z9BfRG6iVgqn6eTNsUaCBfxppkZ3qeh5wL4nceU8PPwutzF53x5aBwYjViNnis+t+LXaRT
        gOfFEcKhbFX4bak1lQR4apwSEuPDKBk=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-3dnieL1UNyqF_J738PMqpQ-1; Mon, 16 Oct 2023 18:15:30 -0400
X-MC-Unique: 3dnieL1UNyqF_J738PMqpQ-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5895d0eaf19so2731986a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 15:15:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697494529; x=1698099329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WWU5V1er/iUZOcl8s3BoY8FcUa0kV+G70KVQ2Non5Og=;
        b=A1go3Nexpn6+FXvThoz4hWBha5EwVL1M5NFWda6Ffa/+qSZRImqNW7KqBbK7X2iZ2+
         7YIcMzHf3fLKtM24qHSB8vBg49aolBYs3h5Wh+85KP/tn5NMOUS5rsTLn1SjQIdxxvhb
         A3JK4J1WXL+wV4HnI8kIXu6z9F85FvmE+FJFflPkYYmPz0MXem0ZUQqWYoHPcNxZRQAC
         1QXbvOCFMLwivbntL9WB5V4QOXAcudBO7IFRItDZvt7j+vsnsjDz7DCX3wUJa7Deod9q
         md+ANhuXJuqYLv9T98hAz9ntLg1HIHOedTVLPxBXK023k6XLKLNrXQo/+M4JTHsq+ON/
         soqg==
X-Gm-Message-State: AOJu0YzcqOFaGxbu/h+VsPGxp306bOCerrzFL1blLwAOe2CdfcnVemX1
        DBlcu3y4iuI287xyCpq/oVj5vWuiJmyGf0HHoRd+TRa/rHLRMImo2mRmGNn3LGumzIsorH1YYXM
        jwWvKjdYbeIEZJ1I9YWYoqMgoDPkfRtp3
X-Received: by 2002:a05:6a20:12d4:b0:164:e94b:d3ae with SMTP id v20-20020a056a2012d400b00164e94bd3aemr341796pzg.54.1697494529412;
        Mon, 16 Oct 2023 15:15:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfNwrV5AaptC/8gum4eGfqgoZvSaofAwHHvkgI0niAZQus5WRonAHY4AfJdFullHUwOZsLAQ==
X-Received: by 2002:a05:6a20:12d4:b0:164:e94b:d3ae with SMTP id v20-20020a056a2012d400b00164e94bd3aemr341778pzg.54.1697494529049;
        Mon, 16 Oct 2023 15:15:29 -0700 (PDT)
Received: from redhat.com ([2804:431:c7ec:c7d4:d97f:2969:ee8a:865a])
        by smtp.gmail.com with ESMTPSA id b14-20020a17090ae38e00b00276cb03a0e9sm71736pjz.46.2023.10.16.15.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 15:15:28 -0700 (PDT)
Date:   Mon, 16 Oct 2023 19:15:23 -0300
From:   Leonardo Bras <leobras@redhat.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Imran Khan <imran.f.khan@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH smp,csd] Throw an error if a CSD lock is stuck for too
 long
Message-ID: <ZS21-5tvii1zzU1q@redhat.com>
References: <bc7cc8b0-f587-4451-8bcd-0daae627bcc7@paulmck-laptop>
 <c87d7939-a88c-ad2d-82f2-866e04692882@oracle.com>
 <a77da319-3161-4e42-894e-521d29fa8348@paulmck-laptop>
 <ZSlhnu0n9eOfkN-U@redhat.com>
 <fb3f6a95-5c54-460c-8581-276bc359a1de@paulmck-laptop>
 <ZS2iqck0tWDWEVMZ@redhat.com>
 <ZS2j73BWypYk-S1u@redhat.com>
 <1f956071-2155-4632-b8ff-84f8056acf50@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f956071-2155-4632-b8ff-84f8056acf50@paulmck-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 02:37:10PM -0700, Paul E. McKenney wrote:
> On Mon, Oct 16, 2023 at 05:58:23PM -0300, Leonardo Bras wrote:
> > On Mon, Oct 16, 2023 at 05:52:57PM -0300, Leonardo Bras wrote:
> > > On Mon, Oct 16, 2023 at 11:27:51AM -0700, Paul E. McKenney wrote:
> > > > On Fri, Oct 13, 2023 at 12:26:22PM -0300, Leonardo Bras wrote:
> > > > > On Mon, Oct 09, 2023 at 09:39:38AM -0700, Paul E. McKenney wrote:
> > > > > > On Fri, Oct 06, 2023 at 10:32:07AM +1100, Imran Khan wrote:
> > > > > > > Hello Paul,
> > > > > > > 
> > > > > > > On 6/10/2023 3:48 am, Paul E. McKenney wrote:
> > > > > > > > The CSD lock seems to get stuck in 2 "modes". When it gets stuck
> > > > > > > > temporarily, it usually gets released in a few seconds, and sometimes
> > > > > > > > up to one or two minutes.
> > > > > > > > 
> > > > > > > > If the CSD lock stays stuck for more than several minutes, it never
> > > > > > > > seems to get unstuck, and gradually more and more things in the system
> > > > > > > > end up also getting stuck.
> > > > > > > > 
> > > > > > > > In the latter case, we should just give up, so the system can dump out
> > > > > > > > a little more information about what went wrong, and, with panic_on_oops
> > > > > > > > and a kdump kernel loaded, dump a whole bunch more information about
> > > > > > > > what might have gone wrong.
> > > > > > > > 
> > > > > > > > Question: should this have its own panic_on_ipistall switch in
> > > > > > > > /proc/sys/kernel, or maybe piggyback on panic_on_oops in a different
> > > > > > > > way than via BUG_ON?
> > > > > > > > 
> > > > > > > panic_on_ipistall (set to 1 by default) looks better option to me. For systems
> > > > > > > where such delay is acceptable and system can eventually get back to sane state,
> > > > > > > this option (set to 0 after boot) would prevent crashing the system for
> > > > > > > apparently benign CSD hangs of long duration.
> > > > > > 
> > > > > > Good point!  How about like the following?
> > > > > > 
> > > > > > 							Thanx, Paul
> > > > > > 
> > > > > > ------------------------------------------------------------------------
> > > > > > 
> > > > > > commit 6bcf3786291b86f13b3e13d51e998737a8009ec3
> > > > > > Author: Rik van Riel <riel@surriel.com>
> > > > > > Date:   Mon Aug 21 16:04:09 2023 -0400
> > > > > > 
> > > > > >     smp,csd: Throw an error if a CSD lock is stuck for too long
> > > > > >     
> > > > > >     The CSD lock seems to get stuck in 2 "modes". When it gets stuck
> > > > > >     temporarily, it usually gets released in a few seconds, and sometimes
> > > > > >     up to one or two minutes.
> > > > > >     
> > > > > >     If the CSD lock stays stuck for more than several minutes, it never
> > > > > >     seems to get unstuck, and gradually more and more things in the system
> > > > > >     end up also getting stuck.
> > > > > >     
> > > > > >     In the latter case, we should just give up, so the system can dump out
> > > > > >     a little more information about what went wrong, and, with panic_on_oops
> > > > > >     and a kdump kernel loaded, dump a whole bunch more information about what
> > > > > >     might have gone wrong.  In addition, there is an smp.panic_on_ipistall
> > > > > >     kernel boot parameter that by default retains the old behavior, but when
> > > > > >     set enables the panic after the CSD lock has been stuck for more than
> > > > > >     five minutes.
> > > > > >     
> > > > > >     [ paulmck: Apply Imran Khan feedback. ]
> > > > > >     
> > > > > >     Link: https://lore.kernel.org/lkml/bc7cc8b0-f587-4451-8bcd-0daae627bcc7@paulmck-laptop/
> > > > > >     Signed-off-by: Rik van Riel <riel@surriel.com>
> > > > > >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > > >     Cc: Peter Zijlstra <peterz@infradead.org>
> > > > > >     Cc: Valentin Schneider <vschneid@redhat.com>
> > > > > >     Cc: Juergen Gross <jgross@suse.com>
> > > > > >     Cc: Jonathan Corbet <corbet@lwn.net>
> > > > > >     Cc: Randy Dunlap <rdunlap@infradead.org>
> > > > > > 
> > > > > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > > > > > index 0a1731a0f0ef..592935267ce2 100644
> > > > > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > > > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > > > > @@ -5858,6 +5858,11 @@
> > > > > >  			This feature may be more efficiently disabled
> > > > > >  			using the csdlock_debug- kernel parameter.
> > > > > >  
> > > > > > +	smp.panic_on_ipistall= [KNL]
> > > > > > +			If a csd_lock_timeout extends for more than
> > > > > > +			five minutes, panic the system.  By default, let
> > > > > > +			CSD-lock acquisition take as long as they take.
> > > > > > +
> > > > > 
> > > > > It could be interesting to have it as an s64 parameter (in {mili,}seconds) 
> > > > > instead of bool, this way the user could pick the time to wait before the 
> > > > > panic happens. 0 or -1 could mean disabled.
> > > > > 
> > > > > What do you think?
> > > > > 
> > > > > Other than that,
> > > > > Reviewed-by: Leonardo Bras <leobras@redhat.com>
> > > > 
> > > > Thank you for looking this over!
> > > > 
> > > > How about with the diff shown below, to be folded into the original?
> > > > I went with int instead of s64 because I am having some difficulty
> > > > imagining anyone specifying more than a 24-day timeout.  ;-)
> > > 
> > > I suggested s64 just because it was the type being used in
> > > BUG_ON(panic_on_ipistall && (s64)ts_delta > 300000000000LL);
> > > 
> > > But anyway, int should be fine.
> > > 
> > > 
> > > > 
> > > > 							Thanx, Paul
> > > > 
> > > > ------------------------------------------------------------------------
> > > > 
> > > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > > > index ccb7621eff79..ea5ae9deb753 100644
> > > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > > @@ -5931,8 +5931,10 @@
> > > >  
> > > >  	smp.panic_on_ipistall= [KNL]
> > > >  			If a csd_lock_timeout extends for more than
> > > > -			five minutes, panic the system.  By default, let
> > > > -			CSD-lock acquisition take as long as they take.
> > > > +			the specified number of milliseconds, panic the
> > > > +			system.  By default, let CSD-lock acquisition
> > > > +			take as long as they take.  Specifying 300,000
> > > > +			for this value provides a 10-minute timeout.
> > > 
> > > 300,000 ms is 300s, which is 5 minutes, right?
> 
> Right you are!  Fixed, please see replacement fixup patch below.
> 
> > > >  	smsc-ircc2.nopnp	[HW] Don't use PNP to discover SMC devices
> > > >  	smsc-ircc2.ircc_cfg=	[HW] Device configuration I/O port
> > > > diff --git a/kernel/smp.c b/kernel/smp.c
> > > > index b6a0773a7015..d3ca47f32f38 100644
> > > > --- a/kernel/smp.c
> > > > +++ b/kernel/smp.c
> > > > @@ -170,8 +170,8 @@ static DEFINE_PER_CPU(void *, cur_csd_info);
> > > >  
> > > >  static ulong csd_lock_timeout = 5000;  /* CSD lock timeout in milliseconds. */
> > > >  module_param(csd_lock_timeout, ulong, 0444);
> > > > -static bool panic_on_ipistall;
> > > > -module_param(panic_on_ipistall, bool, 0444);
> > > > +static int panic_on_ipistall;  /* CSD panic timeout in milliseconds, 300000 for ten minutes. */
> > > 
> > > s/ten/five
> 
> And right you are again!
> 
> > > > +module_param(panic_on_ipistall, int, 0444);
> > > >  
> > > >  static atomic_t csd_bug_count = ATOMIC_INIT(0);
> > > >  
> > > > @@ -256,7 +256,7 @@ static bool csd_lock_wait_toolong(struct __call_single_data *csd, u64 ts0, u64 *
> > > >  	 * to become unstuck. Use a signed comparison to avoid triggering
> > > >  	 * on underflows when the TSC is out of sync between sockets.
> > > >  	 */
> > > > -	BUG_ON(panic_on_ipistall && (s64)ts_delta > 300000000000LL);
> > > > +	BUG_ON(panic_on_ipistall > 0 && (s64)ts_delta > ((s64)panic_on_ipistall * NSEC_PER_MSEC));
> > > 
> > > s64 here would avoid casting (s64)panic_on_ipistall, but I think it does 
> > > not really impact readability.  
> > > 
> > > IIUC ts_delta is an u64 being casted as s64, which could be an issue but no 
> > > computer system will actually take over 2^31 ns (292 years) to run 1 
> > > iteration, so it's safe.
> 
> Back at you with s/2^31/2^63/.  ;-)

Right you are! :)

> 
> > > I think it's a nice feaure :)
> > 
> > s/feaure/feature
> > 
> > Also, FWIW:
> > Reviewed-by: Leonardo Bras <leobras@redhat.com>
> 
> I have that down as well, and thank you again!
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index ccb7621eff79..e1fe26dae586 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5931,8 +5931,10 @@
>  
>  	smp.panic_on_ipistall= [KNL]
>  			If a csd_lock_timeout extends for more than
> -			five minutes, panic the system.  By default, let
> -			CSD-lock acquisition take as long as they take.
> +			the specified number of milliseconds, panic the
> +			system.  By default, let CSD-lock acquisition
> +			take as long as they take.  Specifying 300,000
> +			for this value provides a 5-minute timeout.
>  
>  	smsc-ircc2.nopnp	[HW] Don't use PNP to discover SMC devices
>  	smsc-ircc2.ircc_cfg=	[HW] Device configuration I/O port
> diff --git a/kernel/smp.c b/kernel/smp.c
> index b6a0773a7015..695eb13a276d 100644
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -170,8 +170,8 @@ static DEFINE_PER_CPU(void *, cur_csd_info);
>  
>  static ulong csd_lock_timeout = 5000;  /* CSD lock timeout in milliseconds. */
>  module_param(csd_lock_timeout, ulong, 0444);
> -static bool panic_on_ipistall;
> -module_param(panic_on_ipistall, bool, 0444);
> +static int panic_on_ipistall;  /* CSD panic timeout in milliseconds, 300000 for five minutes. */
> +module_param(panic_on_ipistall, int, 0444);
>  
>  static atomic_t csd_bug_count = ATOMIC_INIT(0);
>  
> @@ -256,7 +256,7 @@ static bool csd_lock_wait_toolong(struct __call_single_data *csd, u64 ts0, u64 *
>  	 * to become unstuck. Use a signed comparison to avoid triggering
>  	 * on underflows when the TSC is out of sync between sockets.
>  	 */
> -	BUG_ON(panic_on_ipistall && (s64)ts_delta > 300000000000LL);
> +	BUG_ON(panic_on_ipistall > 0 && (s64)ts_delta > ((s64)panic_on_ipistall * NSEC_PER_MSEC));
>  	if (cpu_cur_csd && csd != cpu_cur_csd) {
>  		pr_alert("\tcsd: CSD lock (#%d) handling prior %pS(%ps) request.\n",
>  			 *bug_id, READ_ONCE(per_cpu(cur_csd_func, cpux)),
> 

It's great!

Thanks!

