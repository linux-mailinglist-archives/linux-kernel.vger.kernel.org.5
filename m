Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60DB7FC284
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345506AbjK1Rmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 12:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344957AbjK1Rmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 12:42:54 -0500
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A9C10EC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 09:42:59 -0800 (PST)
Date:   Tue, 28 Nov 2023 12:42:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1701193378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rpzb16wTQD+aymEz7SbZXRnLQFtDSOEzXXEggagV1Bw=;
        b=uLxxv4vcSO9YksdxfTHkWbHgRKpXU4VwhsHNZdHVGBfVRZp3PO/4XWvff/Ra12jx4FxCoc
        KTT5/cfU9Lyyl5K3pDJ6mOpjHHc+IS2h0oDR+N9RbFJI6ph+OrP66AUFznCPPGllafPImn
        xBjGMFufaI0GKPWEATMqtNyJJr7BTf0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org
Subject: Re: [PATCH] kbuild: Allow gcov to be enabled on the command line
Message-ID: <20231128174255.xd3yji7rhwijkp75@moria.home.lan>
References: <20231122235527.180507-1-kent.overstreet@linux.dev>
 <CAK7LNASQ+btvNOZ8yU6JLXBHVzPaEwj-7z0_dFouw2EUKd=3uA@mail.gmail.com>
 <20231125195620.rjgkooixugucv2vp@moria.home.lan>
 <CAK7LNAT3_rk7xysSGnzq1carsght6gziyCnwEX=fjXy-KwhQEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNAT3_rk7xysSGnzq1carsght6gziyCnwEX=fjXy-KwhQEg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 08:44:11PM +0900, Masahiro Yamada wrote:
> On Sun, Nov 26, 2023 at 4:56 AM Kent Overstreet
> > It's consistent with how we can specify options in makefiles for a
> > particular file.
> 
> 
> It is consistent in a bad way.

That's a new meaning for consistent that I'm unfamiliar with.

> You used "GCOV_PROFILE_" prefix
> for the full directory path, while it is already
> used as a file name which is relative to the
> current directory.

And the current directory when you're building the entire kernel is the
top level directory.

> > I suppose CONFIG_GCOV_PROFILE_DIRS would be fine, but your patch isn't
> > complete so I can't test it.
> 
> 
> I do not understand what you mean by "isn't complete".
> 
> It is just a matter of adding the config entry somewhere.

Yes, not complete, meaning you haven't even tested it.
