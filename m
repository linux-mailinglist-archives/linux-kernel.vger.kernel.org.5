Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39687B5998
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 20:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237784AbjJBRwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 13:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjJBRwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 13:52:32 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D5DBF
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 10:52:30 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-690fa0eea3cso46213b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 10:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696269149; x=1696873949; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KOuxCtNqv17X0t4RNxn56923Cq7dqqo58Qc2+gFgMbk=;
        b=X/0hNuAG628+FnERiOrgTLQz9Su29C2ki2rgc1VviwvVjwwG3wUgp1Ocg0/3BB8RPz
         TNJ9gl7ctqlKEtDDuI2IDzMYrmh4jw2COVoC64QyM4gCsHYvvJIaOghck9Ob7Um7/3o7
         swUW7FgU3lWeWcUhuWvhuNXEN0xgbdd5OnV3twuibvMQ4ki9RADpD7Ue0+qzExaWBn3K
         bLyJr0D6BhYNffUmewxvf46oa0oqeaX4sXIFBC/FPfiNYPWbRiP5T4yTSRYg8ieqfy9s
         gO7uLvz//T/ax/Z1U135VzFhR+Opzl/Z6JgOD+DRzhoRdwiJfWF7QSisfKlNHK+SbiY1
         +LpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696269149; x=1696873949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KOuxCtNqv17X0t4RNxn56923Cq7dqqo58Qc2+gFgMbk=;
        b=VEemYnE10QB4UqvvF9tky+/dQQlcgvLe/GWLqUjVTliTvpiAtzt17C41BRRT/dUecF
         x971agcUriJYPotlEuGvuyeU9yWHhhbRCWGpV2Z53hWfrwLrAcjK89N47mAsjzQOmOlI
         mx0FlcHnfJAOLwTaZP2hU7NGQ4KJnc4wp+wK+xR3MTIW9DTZcAS6WXEe9XXrrau9LAkN
         xXgN6sMV2chu9Ugfsh3ed4o80Ysx7qVaclH1kEVg1mgM+6RQfTaNckCg9o7LGBtZFUu8
         dPAzlgQtxWnIdpXR9Zi2UVk31ge+jf4YjH2EnhqrbVmrNvEXLKiVkA7aO80dQIsslyki
         JgWw==
X-Gm-Message-State: AOJu0Yws1SPE5SQ1JLiCbUKTmJmkBdptQEVvgcUseBZMRDC3TwLblO9x
        qNkYLmzaaKiEQOLIm+axZ+k=
X-Google-Smtp-Source: AGHT+IFZ2WuX1w764tF3YSTTCeclVqk5Cihmgu59D6wAtwQm0aXNimII3LaNoBQwqN5IR6m+6aOaVQ==
X-Received: by 2002:a05:6a21:7746:b0:14e:b4d5:782e with SMTP id bc6-20020a056a21774600b0014eb4d5782emr10942829pzc.29.1696269149552;
        Mon, 02 Oct 2023 10:52:29 -0700 (PDT)
Received: from swarup-virtual-machine ([171.76.87.78])
        by smtp.gmail.com with ESMTPSA id ij25-20020a170902ab5900b001b8b07bc600sm8923305plb.186.2023.10.02.10.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 10:52:29 -0700 (PDT)
Date:   Mon, 2 Oct 2023 23:22:24 +0530
From:   swarup <swarupkotikalapudi@gmail.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, shuah@kernel.org, hughd@google.com
Subject: Re: + selftests-proc-add-proc-pid-statm-output-validation.patch
 added to mm-nonmm-unstable branch
Message-ID: <ZRsDWFxy3rcILfxg@swarup-virtual-machine>
References: <20231001193740.B716AC433C7@smtp.kernel.org>
 <c1c55bdb-78cd-4b74-b9e5-2667dfdf9b2a@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1c55bdb-78cd-4b74-b9e5-2667dfdf9b2a@p183>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 03:38:25PM +0300, Alexey Dobriyan wrote:
> On Sun, Oct 01, 2023 at 12:37:40PM -0700, Andrew Morton wrote:
> >      selftests-proc-add-proc-pid-statm-output-validation.patch
> 
> > Add /proc/${pid}/statm validation
> > 
> > /proc/$(pid)/statm output is expected to be:
> >  "0 0 0 * 0 0 0\n"
> > Here * can be any value
> > 
> > Read output of /proc/$(pid)/statm
> > and compare length of output is
> > equal or greater than expected output
> 
> > --- a/tools/testing/selftests/proc/proc-empty-vm.c~selftests-proc-add-proc-pid-statm-output-validation
> > +++ a/tools/testing/selftests/proc/proc-empty-vm.c
> > @@ -303,6 +303,37 @@ static int test_proc_pid_smaps_rollup(pi
> >  	}
> >  }
> >  
> > +static const char g_statm[] = "0 0 0 * 0 0 0\n";
> 
> This is both unreliable and incorrect.
> 
> 4th value is "end_code - start_code" when exec is done which could be
> anything not 1-digit number (although unlikely).
> 
> Testing for strlen is simply too weak of a test.
> 
> > +static int test_proc_pid_statm(pid_t pid)
> > +{
> > +	char buf[4096];
> > +
> > +	snprintf(buf, sizeof(buf), "/proc/%u/statm", pid);
> > +
> > +	int fd = open(buf, O_RDONLY);
> > +
> > +	if (fd == -1) {
> > +		if (errno == ENOENT) {
> > +			/*
> > +			 * /proc/${pid}/statm is under CONFIG_PROC_PAGE_MONITOR,
> > +			 * it doesn't necessarily exist.
> > +			 */
> > +			return EXIT_SUCCESS;
> > +		}
> > +		perror("open /proc/${pid}/statm");
> > +		return EXIT_FAILURE;
> > +	} else {
> > +		ssize_t rv = read(fd, buf, sizeof(buf));
> > +
> > +		close(fd);
> > +		size_t len = strlen(g_statm);
> > +
> > +		assert(rv >= len);
> > +		return EXIT_SUCCESS;
> > +	}
> > +}
> > +
> >  int main(void)
> >  {
> >  	int rv = EXIT_SUCCESS;
> > @@ -389,11 +420,8 @@ int main(void)
> >  		if (rv == EXIT_SUCCESS) {
> >  			rv = test_proc_pid_smaps_rollup(pid);
> >  		}
> > -		/*
> > -		 * TODO test /proc/${pid}/statm, task_statm()
> > -		 * ->start_code, ->end_code aren't updated by munmap().
> > -		 * Output can be "0 0 0 2 0 0 0\n" where "2" can be anything.
> > -		 */
> > +		if (rv == EXIT_SUCCESS)
> > +			rv = test_proc_pid_statm(pid);
> >  
> >  		/* Cut the rope. */

Hi Alexey,
Thanks for reviewing the changes.

I assume below output of /proc/${procid}/statm
can be assumed as mentioned below:

static const char g_statm[] = "0 0 0 * 0 0 0\n"

If 0 is correct at their places, only issue is *,
whose value will be single digit or could change?

If this assumption is correct, i can change the
validation to handle 4th postion, and remaining
place will validate if it has zero or not,
and will send another patch?

Thanks,
Swarup

