Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 548AE791D7F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 21:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239666AbjIDTKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 15:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233255AbjIDTKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 15:10:13 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5658F18C
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 12:10:10 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-31f2f43d5a0so1544161f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 12:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693854609; x=1694459409; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yyyFOHB3gzzI5iGWS70prFSR7TfLwPyZra1eFxtvst8=;
        b=dZnCwb0ejH4Q8OYcaDAilX4g1D7WM/Fw+x+AoCqr/GKmUqxsiUAY03xkf8mv74ySZZ
         HXlIZVPxdb0BUo+V6pasOJk4HmQk6iOFohPhrhBd87kpcH4z1W5EtPrRwSRF8wXYZsab
         ZbrcSTUWS3mTnZ19P2HSdsXrE9rhhYHMiqCBkttrak131lCSrbo3kj37xdZoS8Ca9/Y9
         BTi+gRjRezJdCUobCyVN/YqRdEtkRCCEnqTl1X53Qj3DzYkKMbcfMuraFSeIBNBuQJhf
         M0iIrfoeBXEBkXHNU5Xh2AE9wczkWwznlN9dlKFc20J3Sl2ta82It4o4WrxnX64N4UKr
         u/Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693854609; x=1694459409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yyyFOHB3gzzI5iGWS70prFSR7TfLwPyZra1eFxtvst8=;
        b=V743qe0Qbna9nIq0oh6hdjt7JlL8OSo3fhHiITUhGGADwWv5yw2vO/AEe6DzwO0HB5
         0jtZKIfiriq0SZU+/ciqBzGJPD648vJdfD+n7ejPZnCCQdAffho3QX4OC43ZnKPS7dRf
         4xlj/U5v/4+MOiHHzrnWyQWCNXjTM2rxjcA8NZ/CPGkTuY7yRpcJzjpXTnVtVG5JuRrU
         fUFvElXGrFRCGg6M00HKH+ZQDZg4UmptxouU0zKDzVWgrokJbbzZQvUJ7SG4eWhVYKCa
         CIGRWtRtXq7MhJJIi+F/htzyk/YowqPBmOPJ8PBwGD+2x56IbXyh9i2vQuWW86+dQO+1
         x9cw==
X-Gm-Message-State: AOJu0Ywks8CeKKRolvPuX92kLvWJgT9orjXyieMu7PuRDlXdY/7B81B1
        gtgDkW8cUz2RUgD8grH2eFo=
X-Google-Smtp-Source: AGHT+IFWecIpohLfvib2V0BAGdVW0Wa1vNzp2vQ7s9VGWZda5HFAINa0LxdNbsf2UPR51idK8wOaqg==
X-Received: by 2002:a5d:58f1:0:b0:319:6e43:7f6a with SMTP id f17-20020a5d58f1000000b003196e437f6amr8138427wrd.30.1693854608537;
        Mon, 04 Sep 2023 12:10:08 -0700 (PDT)
Received: from gmail.com (1F2EF6A2.nat.pool.telekom.hu. [31.46.246.162])
        by smtp.gmail.com with ESMTPSA id f3-20020a5d6643000000b00318147fd2d3sm15254412wrw.41.2023.09.04.12.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 12:10:07 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 4 Sep 2023 21:10:05 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        Yunying Sun <yunying.sun@intel.com>
Subject: Re: [PATCH] perf/x86/uncore: Correct the number of CHAs on EMR
Message-ID: <ZPYrjW9+hIOJODHY@gmail.com>
References: <20230901142028.298051-1-kan.liang@linux.intel.com>
 <ZPRGmoXKvOCFrK26@gmail.com>
 <37afe50a-44f1-7fb1-c4c0-1e45c38c9a6d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37afe50a-44f1-7fb1-c4c0-1e45c38c9a6d@linux.intel.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Liang, Kan <kan.liang@linux.intel.com> wrote:

> 
> 
> On 2023-09-03 4:40 a.m., Ingo Molnar wrote:
> > 
> > * kan.liang@linux.intel.com <kan.liang@linux.intel.com> wrote:
> > 
> >> From: Kan Liang <kan.liang@linux.intel.com>
> >>
> >> The MSR UNC_CBO_CONFIG, which was used to detect the number of CHAs on
> >> SPR, is broken on EMR XCC. It always returns 0.
> >>
> >> Roll back to the discovery method, which can give the correct number for
> >> this case.
> >>
> >> Fixes: 38776cc45eb7 ("perf/x86/uncore: Correct the number of CHAs on SPR")
> >> Reported-by: Stephane Eranian <eranian@google.com>
> >> Reported-by: Yunying Sun <yunying.sun@intel.com>
> >> Tested-by: Yunying Sun <yunying.sun@intel.com>
> >> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> >> ---
> >>  arch/x86/events/intel/uncore_snbep.c | 4 +++-
> >>  1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
> >> index d49e90dc04a4..c41d7d46481c 100644
> >> --- a/arch/x86/events/intel/uncore_snbep.c
> >> +++ b/arch/x86/events/intel/uncore_snbep.c
> >> @@ -6475,7 +6475,9 @@ void spr_uncore_cpu_init(void)
> >>  	type = uncore_find_type_by_id(uncore_msr_uncores, UNCORE_SPR_CHA);
> >>  	if (type) {
> >>  		rdmsrl(SPR_MSR_UNC_CBO_CONFIG, num_cbo);
> >> -		type->num_boxes = num_cbo;
> >> +		/* The MSR doesn't work on the EMR XCC. Roll back to the discovery method. */
> >> +		if (num_cbo)
> >> +			type->num_boxes = num_cbo;
> > 
> > So in the zero case we don't write type->num_boxes and leave it as-is.
> > 
> > How does this fall back to the discovery method, is the existing (default?) 
> > value of type->num_boxes some special value?
> > 
> 
> Starts from SPR, the basic uncore PMON information are retrieved from
> the discovery table (resides in an MMIO space populated by BIOS.). It is
> called the discovery method. The existing value of the type->num_boxes
> is from the discovery table.
> 
> On some SPR variants, there is a firmware bug. So the value from the
> discovery table is incorrect. We use the value from
> SPR_MSR_UNC_CBO_CONFIG to replace the one from the discovery table.
> 38776cc45eb7 ("perf/x86/uncore: Correct the number of CHAs on SPR")
> 
> Unfortunately, the SPR_MSR_UNC_CBO_CONFIG isn't available for the EMR
> XCC (It works well for other EMR variants). But the above firmware bug
> doesn't impact the EMR XCC. So this patch NOT lets the value from the
> SPR_MSR_UNC_CBO_CONFIG replace the existing value from the discovery table.

Thanks - the comment & changelog should probably reflect this background.

	Ingo
