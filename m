Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE5A7B3C82
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 00:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233739AbjI2WFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 18:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbjI2WFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 18:05:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FC49C;
        Fri, 29 Sep 2023 15:05:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14B6CC433C8;
        Fri, 29 Sep 2023 22:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696025133;
        bh=xTt1l9PiByHy9KtGYSiqfxwf26BRVWc4x8YQoj9u6ic=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TGHm3/hcapD2qY5VqtzZJgwRp2oVb/A6fn4Nnqr5nEZh58pF9DzgylPd8kYt1lgTT
         +zEuKXuhQGZ5Xa21SgMiQ3zR3vj1K1H6Fls1esixfFKq0D02b0pN220yNHE3q7rSN+
         BopiEsKK2al8cpF0RmHo3z2hYgg0Y8OnZqDmGfqeg4G02GhUTtk37Ljb3E5pteYOXt
         EgTMWG1ne/9y5vJznSEwIlfQqDR4cpV7wjWz20aQZJvMtUrcfA3+6T4HeAYnpRJHMS
         8RO7UyaNCM73ogClUAfIkBD74jfQj6I387sVGZh+NrUZVVwJMXeJSH2CQXQi1WnRuS
         sq/v3BjPVYT4w==
Date:   Sat, 30 Sep 2023 00:05:30 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-tip-commits@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] tick/nohz: Update comments some more
Message-ID: <ZRdKKiQAgU1btl7V@localhost.localdomain>
References: <20230912104406.312185-3-frederic@kernel.org>
 <169582689118.27769.11953848930688373230.tip-bot2@tip-bot2>
 <ZRVCNeMcSQcXS36N@gmail.com>
 <ZRatsTz1mQRFJ0sW@lothringen>
 <ZRc9BN+Mv3HnN9GL@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZRc9BN+Mv3HnN9GL@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Fri, Sep 29, 2023 at 11:09:24PM +0200, Ingo Molnar a écrit :
> 
> * Frederic Weisbecker <frederic@kernel.org> wrote:
> 
> > On Thu, Sep 28, 2023 at 11:07:01AM +0200, Ingo Molnar wrote:
> > > > + * infrastructure actually relies on the tick itself as a backend in
> > > > + * low-resolution mode (see hrtimer_run_queues()).
> > > > + *
> > > > + * This low-resolution handler still makes use of some hrtimer APIs meanwhile
> > > > + * for commodity with expiration calculation and forwarding.
> > > 
> > > commodity?
> > 
> > I meant 'convenience', my usual frenglish issues...
> 
> 'Convenience' it is. :-)
> 
> > Looks good, thanks!
> 
> Thanks, I've applied the patch to tip:timers/core, with your Acked-by added.

Sounds good, thanks!
