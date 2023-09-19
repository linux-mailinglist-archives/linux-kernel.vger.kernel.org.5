Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3AED7A6C8C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 22:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbjISUyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 16:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233133AbjISUyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 16:54:02 -0400
Received: from out-220.mta1.migadu.com (out-220.mta1.migadu.com [IPv6:2001:41d0:203:375::dc])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A386AC0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 13:53:51 -0700 (PDT)
Date:   Tue, 19 Sep 2023 16:53:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695156829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KQ9SnVQR0ev2rRpFFyXcwg3OT+7mPuajRg1/AFqHDzE=;
        b=rW8Qh/dj/Kdb0RdB34BMKvHEQUKyWwxEEGeAOrIG16Tyi6NBCYeGDrJYnhhjuQejbCMCd2
        FOCbOwc/UoeJ1CogiUEw73ECBpEecqhEEGFr5TbN3K9T82WTKsdLUrLcyqX3aapC55qWag
        NqNdM3+mCPAfvLWQosoqhwmwgTAXevk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Brian Foster <bfoster@redhat.com>, linux-bcachefs@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH] bcachefs: Fix -Wself-assign
Message-ID: <20230919205347.qfof2omdw6tyedfe@moria.home.lan>
References: <20230919-bcachefs_self_assign-v1-1-830936792fc9@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919-bcachefs_self_assign-v1-1-830936792fc9@google.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 01:38:31PM -0700, Nick Desaulniers wrote:
> Fixes the following observed error reported by Nathan on IRC.
> 
>   fs/bcachefs/io_misc.c:467:6: error: explicitly assigning value of
>   variable of type 'int' to itself [-Werror,-Wself-assign]
>     467 |         ret = ret;
>         |         ~~~ ^ ~~~
> 
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Applied, thanks!
