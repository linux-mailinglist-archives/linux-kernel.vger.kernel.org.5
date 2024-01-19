Return-Path: <linux-kernel+bounces-31138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FADE832996
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 13:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B0571C22E73
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 12:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195B251C34;
	Fri, 19 Jan 2024 12:37:23 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563C31D687;
	Fri, 19 Jan 2024 12:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705667842; cv=none; b=aoHFXYqM3fi5nIjypYsMQxRjdV439BkIGWfBKEOsZNrQM03SXXo6QuqOQnLswbV9chk5ZRG+1n8bV/AxMW8RI0qdkDS08DM2B+uxCb1QkrPOYvNqRtN0J04VOMBUMQ0XwdPyCpfxmafarYkjD6vy5Q7yLeRFN3QrXk8gst9309U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705667842; c=relaxed/simple;
	bh=ZwpSq93rbnovsdIDb5kZ0WFR8+aUX/dq0TsAxC9N25s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ag2Zw1iZ3sps2L+VHjf2mSVX3M51zD+Tb7zepiHI+nBTmKapFOS9+yjx5xMlSsrf/h53Vu7FD1wbu2qmfh377+9M4AXmlfw42tMybll9JOS2oTbRcor+BmhCJs3RQG8vJns1G6sfWVbpr3LqB8e04kCcYJaWtjpC7DUoW58DWRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1rQo7N-0007zr-9w; Fri, 19 Jan 2024 13:37:05 +0100
Date: Fri, 19 Jan 2024 13:37:05 +0100
From: Florian Westphal <fw@strlen.de>
To: wangkeqi <wangkeqi_chris@163.com>
Cc: Florian Westphal <fw@strlen.de>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	wangkeqi <wangkeqiwang@didiglobal.com>,
	kernel test robot <oliver.sang@intel.com>, fengwei.yin@intel.com
Subject: Re: Re: [PATCH net v2] connector: Change the judgment conditions for
 clearing proc_event_num_listeners
Message-ID: <20240119123705.GB9015@breakpoint.cc>
References: <20240116015753.209781-1-wangkeqi_chris@163.com>
 <20240117114713.GA11468@breakpoint.cc>
 <1adb8c68.a950.18d1d237182.Coremail.wangkeqi_chris@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1adb8c68.a950.18d1d237182.Coremail.wangkeqi_chris@163.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

wangkeqi <wangkeqi_chris@163.com> wrote:
> 
> If cn_netlink_has_listeners() is used instead of proc_event_num_listeners, I think proc_event_num_listeners will be completely meaningless. 
> I read the code and found that there is nothing wrong with cn_netlink_has_listeners as a judgment of whether to send msg. 
> sock_close will update the listeners. The previous proc_event_num_listeners count was wrong, making it meaningless. 
> But if I change it to cn_netlink_has_listeners, will it affect some low-probability scenarios?

Please avoid top-posting on netdev mailing list.

Yes, thats what I meant, replace proc_event_num_listeners.

I do not know what a 'low-probability scenarios' is.

