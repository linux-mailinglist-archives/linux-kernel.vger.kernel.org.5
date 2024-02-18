Return-Path: <linux-kernel+bounces-70169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEA5859448
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 04:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A265282F86
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 03:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C44184D;
	Sun, 18 Feb 2024 03:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTDQKvOd"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC9515C0;
	Sun, 18 Feb 2024 03:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708225768; cv=none; b=K6aavmN4mcmvUU1tVNzzrwq+ImUQlvw8VGKP7Mi8pNpISwRPOAyDCowa3qDdLp8oIrg5Nyp089Y2HebOQCHvlHSPVjoRysBtVLDFoj0LOehk7D+pg3u5dN31G787YQMVrabfksP3iKofDyoy7tPVoEDpfN1UpcAgo+j+U5TqeIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708225768; c=relaxed/simple;
	bh=zR1HMsmGMaZ26j+bVBfRm28Ttxn0fhdBC7DIwY1gBS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VgnEhDyTs7FRf3Vg/GmXr/3rERwpZlgKmwQhc+cuoVTP8/c30foyZBIzpYv8bVg47/R1SUyqirw7TK48u/xvGHjBtgJ8RIkdi4fglAsF3rXSlWr9RJBs+FUb9QoUnH7GvCEAtSHhr2HYi5yFkLEi+NlFH5Ccs9t4rBpnIH5/4No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nTDQKvOd; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e457fab0e2so36900b3a.0;
        Sat, 17 Feb 2024 19:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708225766; x=1708830566; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0fBKftuuEdPNjupg4JnWY07VpPh6NclVscigNTiWYfM=;
        b=nTDQKvOdqgXkFlrthdZqhtQCbcSUxaeZdxOl8dF8zbxes0rUxO0LBGJFMWDGZe+/hC
         USEX+NINP66G6dY4KQ2yXhifPgvdxufsNXcLLLJyQIuV165i9vX8HxIOBBUKCvrMdxcz
         UYzH/fk53r3FwcttZlgv5mUo9fgXPB70/LPcIjiTKKa0zN6ZiRrPE8xGuELWa1IwMeuM
         HHC+ZKOQy2zShVQuEMBJIwbm89gvc2ylMDa1oyPUb7aeMw6zS6W86XbnkhEEBcFS4wfS
         6Ev1YSwfeCqhbZdIBYe4JyI3e3uP4zG9OZS/o0xgnqlqr+QVZrVPbP3xrQjbvCbW52oc
         KFNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708225766; x=1708830566;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0fBKftuuEdPNjupg4JnWY07VpPh6NclVscigNTiWYfM=;
        b=H9+eMwaysMIql/CZ6n2LDqDbddNqYxB2c0gJd2iNMGOfNGqWvxkB5JhhjRLUxskyQM
         rsSmDDu7CsV9Oz3F1AJCbjJgNcyARRA3kpYYoCYz0LIryY9ZrYuDRLyBFvSO8aqegKs9
         k+/QxSvLfERNE6SFGbikGTpIsMfW7q8u3IWuEAUMcZgbua+RJS+Pasqnh2IqvQogWpHC
         71IN2WLgHAR/O82Lg2tzS5os6AnRj5c7rR455yQOToNMtt6PHVq0zvtGTuHk/K5vzZBi
         5RtT696Kv2Zf6OWCLe9kdlQmvgjUW7hhKrVWIks9UCM+KYUDsRYrxsxwwitCXSppOxZ/
         Qazw==
X-Forwarded-Encrypted: i=1; AJvYcCV1cw5kbHzKYamw7p68O4pTujYdyv9klinTQ5eLxNTslqBsflcx642A1QseNwJWvx7CAK7oWAc9w5/JKneomLrTcXPx3DY7LbYgBq4yAKmsAhzFpXXCg3SCo0cZGxvrx5DWyTtE
X-Gm-Message-State: AOJu0YyZKXxw9yRo/09fJYkwHc3yRSce5MRsnmHwsmV00BjSN6EzVL8S
	Ilb9z35GX/UXiqIZZGI9Jo1dttBHx9RqTlZA6dS0NZqDV3pq1oNl
X-Google-Smtp-Source: AGHT+IGDFbWIs6WEwZplgbWM6ycPwdoYi6LUzqNSJYP6obqc33HnI6Doo+s+fJ0oGuV3HfnIRSHFcQ==
X-Received: by 2002:a05:6a00:d5c:b0:6e0:df2d:e7fe with SMTP id n28-20020a056a000d5c00b006e0df2de7femr10554154pfv.11.1708225766271;
        Sat, 17 Feb 2024 19:09:26 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id q18-20020a62ae12000000b006e3e362b180sm713018pff.114.2024.02.17.19.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 19:09:25 -0800 (PST)
Date: Sun, 18 Feb 2024 11:09:20 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Praveen Kannoju <praveen.kannoju@oracle.com>
Cc: "j.vosburgh@gmail.com" <j.vosburgh@gmail.com>,
	"andy@greyhouse.net" <andy@greyhouse.net>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Rajesh Sivaramasubramaniom <rajesh.sivaramasubramaniom@oracle.com>,
	Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
	Manjunath Patil <manjunath.b.patil@oracle.com>
Subject: Re: [PATCH RFC] bonding: rate-limit bonding driver inspect messages
Message-ID: <ZdF04GYACphhBCwl@Laptop-X1>
References: <20240215172554.4211-1-praveen.kannoju@oracle.com>
 <Zc8k2wYZRvtfrtmW@Laptop-X1>
 <SA1PR10MB6445D15BA6BF3CD57CC690328C532@SA1PR10MB6445.namprd10.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR10MB6445D15BA6BF3CD57CC690328C532@SA1PR10MB6445.namprd10.prod.outlook.com>

On Sat, Feb 17, 2024 at 12:39:44PM +0000, Praveen Kannoju wrote:
> > -----Original Message-----
> > From: Hangbin Liu <liuhangbin@gmail.com>
> > Sent: 16 February 2024 02:33 PM
> > To: Praveen Kannoju <praveen.kannoju@oracle.com>
> > Cc: j.vosburgh@gmail.com; andy@greyhouse.net; davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> > pabeni@redhat.com; netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Rajesh Sivaramasubramaniom
> > <rajesh.sivaramasubramaniom@oracle.com>; Rama Nichanamatlu <rama.nichanamatlu@oracle.com>; Manjunath Patil
> > <manjunath.b.patil@oracle.com>
> > Subject: Re: [PATCH RFC] bonding: rate-limit bonding driver inspect messages
> > 
> > On Thu, Feb 15, 2024 at 10:55:54PM +0530, Praveen Kumar Kannoju wrote:
> > > Rate limit bond driver log messages, to prevent a log flood in a
> > > run-away situation, e.g couldn't get rtnl lock. Message flood leads to
> > > instability of system and loss of other crucial messages.
> > 
> > Hi Praveen,
> > 
> > The patch looks good to me. But would you please help explain why these
> > slave_info() are chosen under net_ratelimit?
> > 
> > Thanks
> > Hangbin
> 
> Thank you, Hangbin.
> 
> The routine bond_mii_monitor() periodically inspects the slave carrier state in order to detect for state changes, on a state change internally records it and does the state change action.
> 
> Parked-to-Parked state changes goes through transient state. As an example for Up to Down, BOND_LINK_UP to BOND_LINK_DOWN, is thru BOND_LINK_FAIL.  In order to attain next parked state or transient state bond needs rtnl mutex. If in a situation it cannot get it, a state change wouldn't happen.  In order to achieve a state change as quickly as possible  bond_mii_monitor() reschedules itself to come around after 1 msec. 

I think a large miimon downdelay/updelay setting could reduce this.

> And every single come around reinspects the link and sees a state change compared to its internally recorded, which in reality internal state could be not changed earlier as failed to get rtnl lock, and throws again log indicating it sees a state change. If attaining rtnl mutex take long say hypothetical 5 secs, then bond logs 5000 state change message. 1 message at every 1 msec. 

Anyway, setting the rate limit do reduce the message flood. Would you please
summarise the paragraph and add it in commit description when post the formal
patch?

thanks
Hangbin


