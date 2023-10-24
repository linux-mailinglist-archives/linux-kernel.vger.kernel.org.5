Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D8A7D4BED
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 11:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234017AbjJXJYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 05:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233854AbjJXJYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 05:24:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD37FC2;
        Tue, 24 Oct 2023 02:24:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A853C433C7;
        Tue, 24 Oct 2023 09:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698139470;
        bh=TMH9i+Fhp55yLemMgn7mG/Mqj1J3e3OF2xTh9OPo5ro=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PY8Db2njxbM2uqy2Uem2hNOwtJto/7DwimuPj85aaFN9KT59ubjrxke/mt2vJZe3b
         wJDUuAsAFsdaOwfiqRjmMNENp6KFVFPI3VUC8ravlGyyRlr/Bqp73OAw11s0FXuJr1
         MDij5HK+StV/xD+rpMrAN72JaHLJdI4MEezxHs1k=
Date:   Tue, 24 Oct 2023 11:24:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Willy Tarreau <w@1wt.eu>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>,
        security@kernel.org, workflows@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Solar Designer <solar@openwall.com>,
        Vegard Nossum <vegard.nossum@oracle.com>
Subject: Re: [PATCH] Documentation: security-bugs.rst: linux-distros relaxed
 their rules
Message-ID: <2023102402-unheated-basis-55e5@gregkh>
References: <20231015130959.26242-1-w@1wt.eu>
 <87zg0ajcha.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zg0ajcha.fsf@meer.lwn.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 22, 2023 at 08:31:45PM -0600, Jonathan Corbet wrote:
> Willy Tarreau <w@1wt.eu> writes:
> 
> > The linux-distros list relaxed their rules to try to adapt better to
> > how the Linux kernel works. Let's update the Coordination part to
> > explain why and when to contact them or not to and how to avoid trouble
> > in the future.
> >
> > Link: https://www.openwall.com/lists/oss-security/2023/09/08/4
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Solar Designer <solar@openwall.com>
> > Cc: Vegard Nossum <vegard.nossum@oracle.com>
> > Acked-by: Jiri Kosina <jkosina@suse.cz>
> > Signed-off-by: Willy Tarreau <w@1wt.eu>
> > ---
> >
> > This is the final version for merging. Changes since RFC:
> >   - s/BEFORE/UNTIL from Vegard
> >   - improved wording from Alexander
> >   - acked-by from Jiri
> 
> Greg, you've taken changes to this file in the past; do you want to grab
> this one or should I pick it up?

I was hoping there would be other reviewers of it, but I guess not.
I'll take it through my tree now, thanks!

greg k-h
