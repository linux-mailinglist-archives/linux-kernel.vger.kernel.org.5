Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4567D4C85
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 11:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234097AbjJXJdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 05:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234061AbjJXJdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 05:33:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7C03259;
        Tue, 24 Oct 2023 02:32:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B569C433C7;
        Tue, 24 Oct 2023 09:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698139964;
        bh=UPQBF1hjWZNZJzepFfkVdTlAkejOqi2qCPHFJIJlpoo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1yRUBc8YUTQyJ3mKxupBcm8GBt5PJZ82/ESPqSF3ssB3JJfGEg1YaqKI/fYTogBPM
         WVxqdjED8e1T7WhoxBzzvaZzA7qVJ7CO7CRW9AoAnOM85CmkLqckbMumWTm0jjs/BZ
         SA8McnxFrETIDIRO1STRzZm/qBwhUsU7ueYbeC4k=
Date:   Tue, 24 Oct 2023 11:32:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dan Raymond <raymod2@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-serial <linux-serial@vger.kernel.org>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, peterz@infradead.org,
        andriy.shevchenko@linux.intel.com, quic_saipraka@quicinc.com,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v5] arch/x86: port I/O tracing on x86
Message-ID: <2023102406-prodigal-evidence-471d@gregkh>
References: <b8eae358-a3b3-fd68-82f1-b2c53534b922@gmail.com>
 <2023100344-dart-jailbreak-c371@gregkh>
 <94e2b77c-9cc4-534f-e650-06d7e0697f9f@gmail.com>
 <20231004195001.76a57417@gandalf.local.home>
 <80b84be0-a0ad-d1a9-607a-a87c6cf509e0@gmail.com>
 <cc7fba3b-9da2-b9eb-95c8-7336e1cd4449@gmail.com>
 <2023102122-diabetes-trend-57d0@gregkh>
 <62349c78-14b8-4d5c-87ea-00dbd662fe26@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62349c78-14b8-4d5c-87ea-00dbd662fe26@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 02:28:04PM -0600, Dan Raymond wrote:
> > Anyway, it's up to the x86 maintainers now, good luck!
> > 
> > But personally, I don't see the real need for this at all.  It's a
> > debugging thing for what exactly?  Who needs this?  Who will use it?
> > When will they use it?  And why?
> 
> This comment confuses me.  As you know I originally submitted a patch
> that added I/O tracing just to the 8250 serial driver.  The patch was
> titled "create debugfs interface for UART register tracing".  You said
> this at the time:
> 
>    "Anyway, again, cool feature, I like it, but if you can tie it into
>    the existing trace framework better (either by using that entirely
>    which might be best), or at the least, putting your hook into the
>    data path with it, that would be best."

Remember some of us, like myself, get on average 1000+ emails a day that
they need to file/delete/review, so what I wrote yesterday I usually
can't remember, let alone weeks ago :)

> My original patch went through a few revisions before Andy Shevchenko
> suggested I should add portio tracing instead in a manner similar to
> how CONFIG_TRACE_MMIO_ACCESS works.  You agreed.  Hence I created this
> patch.

That's great, but it turns out that the x86 maintainers don't like this,
so perhaps that's not going to work out well.

I still think the original idea of using tracepoints for serial data
would be best, but hey, I don't need this feature :)

thanks,

greg k-h
