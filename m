Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8B07896C7
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 14:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbjHZMvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 08:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbjHZMvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 08:51:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E70611BC6;
        Sat, 26 Aug 2023 05:51:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 945471FB;
        Sat, 26 Aug 2023 05:51:50 -0700 (PDT)
Received: from pluto (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5692A3F64C;
        Sat, 26 Aug 2023 05:51:08 -0700 (PDT)
Date:   Sat, 26 Aug 2023 13:50:58 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        sudeep.holla@arm.com, james.quinlan@broadcom.com,
        f.fainelli@gmail.com, vincent.guittot@linaro.org,
        etienne.carriere@linaro.org, peng.fan@oss.nxp.com,
        chuck.cannon@nxp.com, souvik.chakravarty@arm.com,
        nicola.mazzucato@arm.com,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH 1/6] firmware: arm_scmi: Simplify enable/disable Clock
 operations
Message-ID: <ZOn1MhhlIj584bzY@pluto>
References: <20230811161446.636253-1-cristian.marussi@arm.com>
 <20230811161446.636253-2-cristian.marussi@arm.com>
 <17bd83d833b59fd4f64eec433589fa55.sboyd@kernel.org>
 <ZOXLNliOogkNyJYQ@e120937-lin>
 <a14cdd584283d32a3642658aaed6c98c.sboyd@kernel.org>
 <ZOdoP00tlAIRr9fN@pluto>
 <4870d94375cfdf6c0ba4d4b5cb3b6dc3.sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4870d94375cfdf6c0ba4d4b5cb3b6dc3.sboyd@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 11:43:35AM -0700, Stephen Boyd wrote:
> Quoting Cristian Marussi (2023-08-24 07:25:21)
> > On Wed, Aug 23, 2023 at 11:01:17AM -0700, Stephen Boyd wrote:
> > > 
> > > Perhaps we need a local variable to make it more readable.
> > > 
> > >       static int scmi_clk_enable(struct clk_hw *hw)
> > >       {
> > >              bool can_sleep = false;
> > >              struct scmi_clk *clk = to_scmi_clk(hw);
> > > 
> > >              return scmi_proto_clk_ops->enable(clk->ph, clk->id, can_sleep);
> > >       }
> > > 
> > > This let's the reader quickly understand what the parameter means. I'm
> > > OK with adding the function parameter, but a plain 'true' or 'false'
> > > doesn't help with clarity.
> > 
> > Thanks for the suggestion, it would help definitely making it more
> > readable, maybe a local define or enum could make it without even
> > putting anything on the stack.
> > 
> 
> Surely the compiler can optimize that so there isn't stack local
> storage for a local variable used as an argument to a function call?

Yes indeed the compiler will certainly drop anything at the end, but still
I'd have to fill with local vars definitions all the related functions just
to be able to make them more readable while I can improve the readability
also by just adding a pair descriptive defines to use all over.

I'll send a V2 and then you tell if it is fine for you.

Thanks
Cristian

