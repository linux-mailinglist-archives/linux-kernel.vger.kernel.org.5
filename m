Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA147B1CCE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 14:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbjI1Mpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 08:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbjI1Mpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 08:45:39 -0400
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D8E139
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 05:45:36 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-99c1c66876aso1675869966b.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 05:45:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695905135; x=1696509935;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LqyFyejgRJ3HVV9uFW0VQLQllqmaovz7EFt7peLUQxg=;
        b=F2eqsSSE0IrfEpD63jHxFNhhL1+z3ZvFivzXB5xsSfcyrjuuH2T2zoVFcQjClt9ZPA
         aeHo7Zjyhh1XdzswATfEyHmisAshQIuKAKXfnSWPvMd3grpqn3/l1LCgB/l3CrrgCKdm
         7m6Bk5yshMCt0J+M2onFlYcwM3ZA7FAfYYScPoskU5v/VYX5ffbc4TC5+TwOR8xzxzyb
         45sbN7luB6xPwfHz8Ut081Wbj5kHJTXURYIN6GudU8zGenYrzU7FEpWugM3nn98wxU9M
         ajzheo6EBSyIu4j+TU2NqbIWG5hylS8WoV+pVZfJYibiCH/MuWhsqsfRe4GkTer8lUrT
         dfAA==
X-Gm-Message-State: AOJu0Yy9m+/rfhyX7Oqb/lbLt6RLg9tZB9qTe98RlnJ0EJ21ATqDFYjT
        LcgrEVIfM/2oEhJNh+O4OSc=
X-Google-Smtp-Source: AGHT+IFahYdwNSWZ1JvEfMoP8D3MCuubWHljnogWtiGQHizQCLCy8rKsNclkyyGvGL393mXD8fpBuA==
X-Received: by 2002:a17:907:1dcb:b0:9ae:5367:fe90 with SMTP id og11-20020a1709071dcb00b009ae5367fe90mr1203899ejc.32.1695905134918;
        Thu, 28 Sep 2023 05:45:34 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-022.fbsv.net. [2a03:2880:31ff:16::face:b00c])
        by smtp.gmail.com with ESMTPSA id l25-20020a1709066b9900b0099cc36c4681sm10778878ejr.157.2023.09.28.05.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 05:45:34 -0700 (PDT)
Date:   Thu, 28 Sep 2023 05:45:32 -0700
From:   Breno Leitao <leitao@debian.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc:     leit@meta.com,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] x86/bugs: Add a separate config for each mitigation
Message-ID: <ZRV1bIuSXjZ+uPKB@gmail.com>
References: <20230628142129.2468174-1-leitao@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628142129.2468174-1-leitao@debian.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 07:21:28AM -0700, leitao@debian.org wrote:
> From: Breno Leitao <leitao@debian.org>
> 
> Create an entry for each CPU mitigation under
> CONFIG_SPECULATION_MITIGATIONS. This allow users to enable or disable
> them at compilation time.
> 
> If a mitigation is disabled at compilation time, it could be enabled at
> runtime using kernel command line arguments.

I had a chat about this topic with Boris and Thomas at Kernel Recipes,
and I would like to summarize the current state, and get it moving
forward.

1) The hardware mitigations are half-way added to KCONFIG. I.e., half of
the hardware mitigations are specified under SPECULATION_MITIGATIONS,
but not all of them.
	* You can enabled/disabled just half of them at build time.

2) It is impossible to build a kernel with speculative mitigations
disabled.
	* The only way to disable the mitigations is at boot time,
	  using the "mitigations=off" boot parameter.


So, disabling SPECULATION_MITIGATIONS, will only disable the mitigations
that are under SPECULATION_MITIGATIONS. Other mitigations will continue
to be enabled by default. This is is misleading for the user.

Here are a few options moving forward:

1) Create one Kconfig entry per mitigation, so, the user can pick and
choose what to enable and disable. (Version 3 of this patch. May need a
re-spin due to the new mitigations being added.)

2) Keep the Kconfig entries as-is. Create a new Kconfig entry
(CPU_MITIGATIONS_DEFAULT_OFF?) to disable the mitigations by default,
similarly to the `mitigations=off` boot parameter (v1 of this patch)

3) Same as 2, but, reusing SPECULATION_MITIGATIONS instead of
creating a new Kconfig entry.

4) Remove the current entries in SPECULATION_MITIGATIONS and the fine
control on what to enable/disable?!

What is the preferred way?
