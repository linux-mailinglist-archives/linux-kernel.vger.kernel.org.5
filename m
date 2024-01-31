Return-Path: <linux-kernel+bounces-47156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE61A8449F1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BC041F218AB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481F43985A;
	Wed, 31 Jan 2024 21:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EsXeVT8y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D7D381D5;
	Wed, 31 Jan 2024 21:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706736362; cv=none; b=j4DqZzBBjpUxoNz4JH5YAGpFAMG6N+7TQ/9L7wst06hTpoxTV5Z+vVwuJ2UwGrGU4JVrevlvclXPKqkDSgS0baaPMwIQal9g5fHjl8mCVQOSXgxyP6rLek2Kx96c/dJ8OSK57SqAMZ2hlE758Th8PkE1xmrrFhUGFTehOF0DlyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706736362; c=relaxed/simple;
	bh=H0i78GfMShXCMIs6RwszSny3QbPZTTswjn+XCYbagPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HtcURrTCvLun9okl9mqirbKY9iWXAK2bKcfPZFYXWEQWVFwUc95tS5oG53wKG4lJqBD+/JDn6VhtJzIktgAgvL9YYcOlaLgPDb4Q9ODh/tHXuF0merTVj6Vvx0qbFsWNabRs5g+avp20zz39dgG2JtEzTTnOF7I99nfn1Okzssk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EsXeVT8y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB68FC433F1;
	Wed, 31 Jan 2024 21:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706736361;
	bh=H0i78GfMShXCMIs6RwszSny3QbPZTTswjn+XCYbagPI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EsXeVT8yeTocepwrSWHtTJRES3SzWxLo4i3xNAEpeweo6+TkMQGCdIn1oub2sup8X
	 Pu6B6KleuOhxQLuRESJFRnuW+7apXEkQkNyRZnLl0WEPguu7Br9imMmSJD0na1EHEZ
	 lkjOq8W+Gof5i+woecNw+tLhtdmpn7bJdvzCMJEI=
Date: Wed, 31 Jan 2024 13:26:01 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: John Garry <john.g.garry@oracle.com>
Cc: mcgrof@kernel.org, russ.weight@linux.dev, rafael@kernel.org,
	rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	keescook@chromium.org, masahiroy@kernel.org, nathan@kernel.org,
	nicolas@fjasle.eu, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-kbuild@vger.kernel.org
Subject: Re: [PATCH RFC 0/4] Introduce uts_release
Message-ID: <2024013125-managing-most-2335@gregkh>
References: <20240131104851.2311358-1-john.g.garry@oracle.com>
 <2024013158-dipper-mural-424b@gregkh>
 <e21c6dbb-7083-4425-bace-6194bfbf35b7@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e21c6dbb-7083-4425-bace-6194bfbf35b7@oracle.com>

On Wed, Jan 31, 2024 at 05:16:09PM +0000, John Garry wrote:
> On 31/01/2024 16:22, Greg KH wrote:
> > > before:
> > > real    0m53.591s
> > > user    1m1.842s
> > > sys     0m9.161s
> > > 
> > > after:
> > > real    0m37.481s
> > > user    0m46.461s
> > > sys     0m7.199s
> > > 
> > > Sending as an RFC as I need to test more of the conversions and I would
> > > like to also convert more UTS_RELEASE users to prove this is proper
> > > approach.
> > I like it, I also think that v4l2 includes this as well as all of those
> > drivers seem to rebuild when this changes, does that not happen for you
> > too?
> 
> I didn't see that. Were you were building for arm64? I can see some v4l2
> configs enabled there for the vanilla defconfig (but none for x86-64).

Building for x86, maybe it's one of the other LINUX_VERSION type defines
we have, sorry, can't remember, it's been a long time since I looked
into it.

thanks,

greg k-h

