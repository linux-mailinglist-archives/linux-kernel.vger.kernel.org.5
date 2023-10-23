Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40FE27D3773
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 15:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjJWNIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 09:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjJWNIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 09:08:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6356FC4;
        Mon, 23 Oct 2023 06:08:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79780C433C7;
        Mon, 23 Oct 2023 13:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698066527;
        bh=p6Inx0owgVSroWRP0ixv4LRXq0nbVd4Kt4ZJ+pT2iC4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=INbhZBoP9UOd48h2vZX331ejbRqiHJMSUMSLL3GaQjaqnkhpaRTfU6F5VrPlIecqs
         S8MF+eNDRBz4n4papemiRGY43yvHIFHbA6NZiv9RE5wYUdgL0nFst5xu2EYGQ1TU2k
         Ek59AZpcp8sd7bGHBivP3LGzPb0OAHX8+5kPS0j0=
Date:   Mon, 23 Oct 2023 15:08:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        stable-commits@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: Patch "rcu: Make call_rcu() lazy to save power" has been added
 to the 6.1-stable tree
Message-ID: <2023102303-pending-purity-c504@gregkh>
References: <20231021001842.1606862-1-sashal@kernel.org>
 <CAEXW_YR99h31ZXN+vsdcx2vx7LgZJYzWoyVHPZRYTA9qByvNSQ@mail.gmail.com>
 <ZTZt0FrBteUJpxf_@sashalap>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZTZt0FrBteUJpxf_@sashalap>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 08:57:52AM -0400, Sasha Levin wrote:
> On Sat, Oct 21, 2023 at 12:23:33PM -0400, Joel Fernandes wrote:
> > On Fri, Oct 20, 2023 at 8:18 PM Sasha Levin <sashal@kernel.org> wrote:
> > > 
> > > This is a note to let you know that I've just added the patch titled
> > > 
> > >     rcu: Make call_rcu() lazy to save power
> > > 
> > > to the 6.1-stable tree which can be found at:
> > >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > Sasha, could you drop this patch from 6.1 stable? It is a new feature
> > and as such I expect folks who need it to backport. For instance, in
> > our stable derivatives, it has been backported.
> 
> You're right that it's a new feature, but it was taken as a dependency
> for a later fix.

I resolved this, and removed it, it wasn't really needed for that fix,
your bot's dependency chain got a bit too long for a 2 line bugfix :)

thanks,

greg k-h
