Return-Path: <linux-kernel+bounces-166542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E46B8B9C16
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 409121C215CB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F77F13C69C;
	Thu,  2 May 2024 14:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6dhnwH+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614B012DDBF;
	Thu,  2 May 2024 14:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714659185; cv=none; b=muKnH/JlidNBE4tFJ3idmjX7K7SLrooLiv3cL+z7LhcGa2B/OHmbniHQ2+e/YX0u0kqhJsMAg50CjPgcwWt48i9J6S8rYWx6XaBKHAKikO53VtCLBK7baJTsrUaO8mE7N+ZpqZ949xpy2+ZcfRn64eK5WqttYfKZRGMQP0u3twI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714659185; c=relaxed/simple;
	bh=m/+rRNq0yK5IDVK52c0pcAeG0bkgcZEPiWZQqdchowE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N/3ic6EuzuIzk/vWnQEczNqxupst9Fb64Wh4604P04lSuPumf2ONR9i3TUZzrYDZLGaUQ024UMglZ/58JYuUJZdPuFAs1REz7a5VT1oDl6qSNd1fiXn6Kkyi3W/0yRmf1TQwTuxmy1P/Qf2QS8yoBsaoFvGBR+S8rxz4f5/LTY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6dhnwH+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D78C113CC;
	Thu,  2 May 2024 14:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714659185;
	bh=m/+rRNq0yK5IDVK52c0pcAeG0bkgcZEPiWZQqdchowE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V6dhnwH+Katn8gLImx8No+RInt7eA/8h67J/q6XmtDcYkdA5SeXqlZqIuR3KoLdfm
	 zcoRMUh8eoIkR4O/WgooiFAs0N88dLp1ET69g0Ta3fQ2udgxzZfRVoGzuUsWUucENe
	 DF7aNJCYAAf7d9s8MMEVmrfsZkB6B5CCLvvOygnnI7/TQxJ+BH+iUs1VmFsTSIZF4K
	 3ypD3rm+FfT6aN2AFqCqGKHg0X495fyOp+rCeMp4HPMdXcvVMQWnStt1nq595mMyb/
	 ThwZziME1Z8ciW1QZqWvaHGvirdkNtlxviMwTXVGaNPstMUFjPqXm5xrXTgCAB5ft2
	 kHKT0OqUCzNrQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1s2XBM-0000000061j-1leg;
	Thu, 02 May 2024 16:13:08 +0200
Date: Thu, 2 May 2024 16:13:08 +0200
From: Johan Hovold <johan@kernel.org>
To: quic_zijuhu <quic_zijuhu@quicinc.com>
Cc: Tim Jiang <quic_tjiang@quicinc.com>,
	Janaki Ramaiah Thota <quic_janathot@quicinc.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: QCA NVM file for the X13s (WCN6855)
Message-ID: <ZjOfdK41yLwkH25T@hovoldconsulting.com>
References: <ZjNxfFJmCgIyq8J6@hovoldconsulting.com>
 <5aea3149-ba44-400f-acc6-1a3eca8a7e72@quicinc.com>
 <ZjOUWqor4q1Efy0W@hovoldconsulting.com>
 <f1b45d7d-27e0-4ad7-976c-670a0e0d136b@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1b45d7d-27e0-4ad7-976c-670a0e0d136b@quicinc.com>

On Thu, May 02, 2024 at 09:46:38PM +0800, quic_zijuhu wrote:
> On 5/2/2024 9:25 PM, Johan Hovold wrote:
> > On Thu, May 02, 2024 at 08:56:12PM +0800, quic_zijuhu wrote:
> >> On 5/2/2024 6:57 PM, Johan Hovold wrote:

> > It's WCN6855 but the Linux driver currently uses the firmware you pushed
> > for QCA2066.
> > 
> >>> The current Linux driver is using the generic NVM file (hpnv21.bin) for
> >>> WCN6855, but connectivity is quite bad and I only get 2-3 meters of
> >>> range.
> > 
> >>>> Switching to the board-specific NVM configuration (hpnv21b.b8c) that
> >> it seems hpnv21b.b8c is a wrong NVM name.
> >> is it hpnv21g.b8c?
> > 
> hpnv21g.b8c is the right NVM for the machine.

Ok, thanks. I'll try to find some time to test with this one as well.

> > What is the difference between those two?

> i am afraid that i can't answer your question due to company CCI policy

I understand.

> > Exactly. It's a Lenovo machine that comes with Windows pre-installed and
> > we're working on enabling Linux on it with some help from Lenovo.
> > 
> >> need customer to make a request for their requirements if the answer is
> >> yes for above question.
> > 
> > Lenovo has made requests for X13s firmware from Qualcomm and pushed it
> > to linux-firmware [1], but they have not yet been able to get Qualcomm
> > to provide an NVM configuration file for Bluetooth (I think the problem
> > may be finding the right person to talk to inside Qualcomm).
> > 
> > So I was hoping maybe you could help us with this since the difference
> > between 'hpnv21.bin' that you pushed to linux-firmware and what came
> > with Windows appears to be really small (e.g. just a few bytes).
> > 
> let me try to find out the right person who will push this task at next
> monday.
> there are some other internal procedures before we can push BT firmware
> into linux-firmware.

Much appreciated, thank you.

Johan

