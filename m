Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6307CD47E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 08:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344419AbjJRGa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 02:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjJRGa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 02:30:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8B9C6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 23:30:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2418DC433C7;
        Wed, 18 Oct 2023 06:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697610625;
        bh=FPTTiiZq8GxaKyzpXJmy3oyhKpmAOd1lTbVWtb7o1s0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FAPf938xwnoVZc+dHRefOzJKEVyW6XfDQkghGROfppztei7tPdv2EuzgaTMa77GHm
         KXc93YGZzlkV6E+dN/Dqt+vcIoVVQzj2G0v5EXKDI2mUZtlBtuVrwR5YIv+WUxzpa4
         UE+wRIpNGs8JhEYi0AD+dVei+J5jOWqb2mAfBFzrysFArBlo3S2g66eevbiBKo7hUm
         1EE5jguXSdVpqmjBOVLHCJkVNoAjEokJj2+Fa3oFX3IOSr2z71eDyH1ry0G/KoyNXp
         cpoH11dJ765ccASJ3P4MtG04P/VQ7AKRmnsnDoeucKFtciPkZ1Leb4RyBygDEJWtdJ
         0oC/h7kenVl5Q==
Date:   Wed, 18 Oct 2023 15:30:20 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Francis Laniel <flaniel@linux.microsoft.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] tracing/kprobes: Return EADDRNOTAVAIL when func
 matches several symbols
Message-Id: <20231018153020.fac28cf4381b57e179104b02@kernel.org>
In-Reply-To: <2696412.mvXUDI8C0e@pwmachine>
References: <20230824160859.66113-1-flaniel@linux.microsoft.com>
        <20230825221321.faaa33e03afc48abc345c24f@kernel.org>
        <20230829195719.0eaf9035@rorschach.local.home>
        <2696412.mvXUDI8C0e@pwmachine>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Francis,

On Thu, 31 Aug 2023 09:14:55 +0200
Francis Laniel <flaniel@linux.microsoft.com> wrote:

> Hi.
> 
> Le mercredi 30 août 2023, 01:57:19 CEST Steven Rostedt a écrit :
> > On Fri, 25 Aug 2023 22:13:21 +0900
> > 
> > Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> > > > Excellent catch! Thank you, I will apply this patch and send v4 right
> > > > after. Regarding test, do you think I can add a test for the
> > > > EADDRNOTAVAIL case?> 
> > > Hmm, in that case, you need to change something in tracefs/README so that
> > > we can identify the kernel has different behavior. Or we have to change
> > > this is a "Fix" for backporting.
> > 
> > I prefer this to be a Fix and backported.
> 
> This makes sense, I will send v5 to stable mailing list too!

I missed this a while. did you send v5 ? I could not find in my mbox.

Thank you,

>  
> > Thanks,
> > 
> > -- Steve
> 
> Best regards.
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
