Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C657D6AE9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 14:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234782AbjJYMMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 08:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234128AbjJYMMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 08:12:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF6C183;
        Wed, 25 Oct 2023 05:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4jXfSAs/OUT6Ayj3tW7CYh3Hb2UaHX2D+jHjYtfb32k=; b=lYi0G2ACqlktbPLMIQ3Mqzp/sf
        cy6joSVmmS/2yikTEosSVY/MI/R++s0XcXjSX7w4zZ4SCFDB6sPbjP5lhobDLhdw3gVfeCRS06MKS
        KWOaC2WU3qT/5lNPmxsZ+gsxoH9XO87+flkxO+keRCTdFm1mLFuG+OVk+vISH//hN3Ve4NGnVIN+B
        saztQZWZK7M50YEHcPhAH9A8XFUQfYqlJvCxQNdKanntFGg4+kHQA9KNjjEcYG++CL2n3cm/yhW4F
        z8Pr8syoW/k6+JdqAYY2e1oz7wAWhqw3xmcZp5AtZFoEbZD0ipetCVyeYNn0+79DalbFnTN9tgN3J
        lGZnckJw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qvcjg-008fgr-AQ; Wed, 25 Oct 2023 12:11:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id C4EDC30047C; Wed, 25 Oct 2023 14:11:43 +0200 (CEST)
Date:   Wed, 25 Oct 2023 14:11:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, viresh.kumar@linaro.org,
        lenb@kernel.org, robert.moore@intel.com, lukasz.luba@arm.com,
        ionela.voinescu@arm.com, pierre.gondois@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-acpi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org,
        conor.dooley@microchip.com, suagrfillet@gmail.com,
        ajones@ventanamicro.com, lftan@kernel.org
Subject: Re: [PATCH v3 4/6] energy_model: use a fixed reference frequency
Message-ID: <20231025121143.GA28289@noisy.programming.kicks-ass.net>
References: <20231018162540.667646-1-vincent.guittot@linaro.org>
 <20231018162540.667646-5-vincent.guittot@linaro.org>
 <20231025115456.GD31201@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025115456.GD31201@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 01:54:56PM +0200, Peter Zijlstra wrote:

Also, can we pretty please not cross-post to moderated lists, that's
rude.

Rafael, can you please mark this acpica-devel crap as moderated in
MAINTAINERS so that it can be auto-magically excluded from receiving
mail?
