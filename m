Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B407A0689
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 15:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239312AbjINNys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 09:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239107AbjINNyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 09:54:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95521BE;
        Thu, 14 Sep 2023 06:54:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37630C433C7;
        Thu, 14 Sep 2023 13:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694699682;
        bh=YQ5H8MjwWAk9ijZh6+radwmtv0HVmKTyZ9hRA6ErpIE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bx1T9g18Rl4QXA682jKmTd7TnbdrxdqmyOhmu54ZgOa+2cFubRl43SypxJnCKPFgr
         gMQEa+54AVRyQrpnGlFabc1PnryHmF1/LvNbL2jhTjJ8K3kTLqR7t0ZyVZ5/gc3vFp
         zQQvb3bv1P5kBRZLBvZtoI/G1ybiNs2URsOwS5M1ZGybnGKwLk/XhovJ+iDr5z/wq9
         NV+2NBHX3RVYmKSR5Su1ShQ7hVewVBWX4q6BrO79o44Qv4L5ZclRGYKw6b05qijgGe
         BaRZ2yUpYWp9agVHtj45P5aJApnGZDYUUQz4AztPp+R69yakeQbfoHfM0WVb+Dse+M
         C5csiaUsISX7A==
Date:   Thu, 14 Sep 2023 15:54:37 +0200
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        matz@suse.de
Subject: Re: linux-next: Tree for Sep 13 (objtool)
Message-ID: <20230914135437.tmb42rqcz6dv6wjc@treble>
References: <20230913150445.49bee094@canb.auug.org.au>
 <a53f9840-8581-44cc-beaf-6fb644c8cacc@infradead.org>
 <20230913214753.3xqemkqjhxcwqaz4@treble>
 <20230914072327.GB16631@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230914072327.GB16631@noisy.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 09:23:27AM +0200, Peter Zijlstra wrote:
> > We could just make smscore_load_firmware_from_file() noinline.
> > 
> > Or we could hard-code the fact that smscore_load_firmware_from_file() is
> > only called in the SMS_DEVICE_FAMILY2 case, like:
> 
> Yeah, this seems simplest. The code in question doesn't seem overly
> complicated and we can simply avoid confusing GCC.

I'm on my way out the door for vacation, if anybody wants to slap a
description on the patch and send it along, feel free :-)

-- 
Josh
