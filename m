Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605E07C53CB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 14:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346833AbjJKMYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 08:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346802AbjJKMYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 08:24:05 -0400
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF271BFC
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:21:04 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-53de8fc1ad8so714084a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:21:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697026862; x=1697631662;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v3eACpkWj+oHdW3ZMUyYDc/U0YwV3YoweDDdlVwDHUY=;
        b=O5ggpfd6LqsppERZEwWBWWn16H5vK21oN6f21DBr2WHjlzWnmTGGCEdZwdpiaA58HE
         u0P/pB0KQ2aauy8KpdxqSLXaI/zXsyGIEM+Ja1ky0eR2yvE2tOGdd9/yzAa2Do4LAyiR
         VdjbenM6qbpDpobpsfffGbkwjVvZwvBJISheBGjQpOSOAZjW8OnPVzLH7Ea+uJNnwxKv
         RjOWhoSJ1caoqJFiTil/XV6SP8okoTBctNCJT1ddxqGv8j3Ny81+WioWO4u5EmcbEgIo
         y6UFdfq9+xaabdV+mA9Soco9h88b6mcbTcsKXfMp3klakMhEKy17+Y+5FVK1/rkWkgJu
         LefA==
X-Gm-Message-State: AOJu0YyOt+HdxHQOofpL0mXqpkNLraMfXTp8rK3Rpv7j9pS1pjMmCzAY
        jfTh40eBhszT4p49KFN7mUU=
X-Google-Smtp-Source: AGHT+IE11BVUMB9L5MNFSJ1it2fgTjqjOZzW4xykdnJ+Sbd3p18wf0xfTkpUwlwsqkW4snQSExkh2A==
X-Received: by 2002:aa7:c493:0:b0:533:c77b:2f3e with SMTP id m19-20020aa7c493000000b00533c77b2f3emr17501199edq.21.1697026861973;
        Wed, 11 Oct 2023 05:21:01 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-020.fbsv.net. [2a03:2880:31ff:14::face:b00c])
        by smtp.gmail.com with ESMTPSA id n14-20020aa7c44e000000b005361fadef32sm8697009edr.23.2023.10.11.05.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 05:21:01 -0700 (PDT)
Date:   Wed, 11 Oct 2023 05:20:59 -0700
From:   Breno Leitao <leitao@debian.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     tglx@linutronix.de, bp@alien8.de, Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, leit@meta.com,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] x86/bugs: Add a separate config for each mitigation
Message-ID: <ZSaTK5HOuCabHoEb@gmail.com>
References: <20231010103028.4192223-1-leitao@debian.org>
 <20231011044252.42bplzjsam3qsasz@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011044252.42bplzjsam3qsasz@treble>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 09:42:52PM -0700, Josh Poimboeuf wrote:
> On Tue, Oct 10, 2023 at 03:30:27AM -0700, Breno Leitao wrote:
> > +config MITIGATE_MDS
> > +	bool "Mitigate Microarchitectural Data Sampling (MDS) hardware bug"
> > +	depends on CPU_SUP_INTEL
> > +	default y
> > +	help
> > +	  Enable mitigation for Microarchitectural Data Sampling (MDS). MDS is
> > +	  a hardware vulnerability which allows unprivileged speculative access
> > +	  to data which is available in various CPU internal buffer. Deeper
> > +	  technical information is available in the MDS specific x86 architecture
> > +	  section: Documentation/arch/x86/mds.rst.
> 
> MITIGATE_GDS seems to be missing?

GDS is named `GDS_FORCE_MITIGATION` instead of  MITIGATE_GDS. See
11cf22869ea ("x86/speculation: Add Kconfig option for GDS")
>
> For consistency I'm thinking it would be better to call them
> MITIGATION_* rather than MITIGATE_* since they're under the
> SPECULATION_MITIGATIONS menuentry, and the bugs code almost exclusively
> uses the noun "mitigation" rather than the verb "mitigate".

Sure. I can definitely rename them to MITIGATION_. Let's see if no one
else disagree and I will update the patch.


> While we're at it should we go ahead and rename the existing options?

Sure!

Thanks for the feedback!
