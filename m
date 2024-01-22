Return-Path: <linux-kernel+bounces-33136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D73F836510
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D05A01C235F7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F2B3D3BB;
	Mon, 22 Jan 2024 14:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CzEHrh1l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202DD3D388;
	Mon, 22 Jan 2024 14:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705932240; cv=none; b=nZtjgkxnRMqcsfLeBOsv+54B+RcZ5vaYO+PhxnuecdCD51PU/yh/sCwQ7/94YfTCW1GzEQwQqgIs55dbrXwsI9jGIP+MTIU9VNKgs6L4xvNRz7PtfZzj/vyPrLDMppF1Fa1SqwvhX2WMJSEOQBzMbqhBTqnvdpNESDuPzo7PBzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705932240; c=relaxed/simple;
	bh=uB+xAUnhOKylzIpbYFxEwD5Rje9Cwg6aWG5W9GJI7Cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=irxmVM/1IGY1lHemNmiesYhhfm/1XjBzQZfWO3gdr47LTq8MzrgB5w2IS0NsXmJoVxywI1VR/G2Md+R/vDNarhz6gdt6owkosCIoGCpZhA3nay1eQIDZz69NhoyFBkA9DZuS8Cu/izaO9scs0jCPzhuFcVsv4nN/P5izMXC0jmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CzEHrh1l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ADDCC433F1;
	Mon, 22 Jan 2024 14:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705932239;
	bh=uB+xAUnhOKylzIpbYFxEwD5Rje9Cwg6aWG5W9GJI7Cs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CzEHrh1lPdFqtVb9l+WgSxQUnjB7Aw6g1D1N9dKatukMp6j8UbcCiZDJsth8RLU/u
	 G73PtI+HjAQsBN7eW9AjxM+QyiGiD35Ny449HnyBltZc6FV4QIZcVS5KH6vWWl3W6x
	 gyAIh8znB+E3vF6UJlPPFq0gaaITQd7E8zmf40EjDv3RVrYoCpgnj5hewia4Huh/t7
	 9U34BJhmnQsdGnAfs3p6MAycc/3hGrbTpInJ6fMxHf8qGTAD15XtYqdBQmBi1Pu+9d
	 106XbGZ4nC7sxWHW8XeBmfVSIkVspsAlJzztUKOUJR71KjL5GWu21GeR0yF7xL78U1
	 MgwwAVdSWfBwg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rRuuJ-000000008K2-1TOS;
	Mon, 22 Jan 2024 15:04:11 +0100
Date: Mon, 22 Jan 2024 15:04:11 +0100
From: Johan Hovold <johan@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: ath11k: checking RCU usage
Message-ID: <Za5124pntbOOtURc@hovoldconsulting.com>
References: <20231019153115.26401-1-johan+linaro@kernel.org>
 <87o7goxget.fsf@kernel.org>
 <ZTfgJCBxsNv3bVjv@hovoldconsulting.com>
 <87zfx98r6a.fsf_-_@kernel.org>
 <Za5pOIkQ0SN2XzHr@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Za5pOIkQ0SN2XzHr@hovoldconsulting.com>

On Mon, Jan 22, 2024 at 02:10:17PM +0100, Johan Hovold wrote:
> On Sat, Jan 13, 2024 at 12:26:53PM +0200, Kalle Valo wrote:

> > I just found out that sparse has __must_hold():
> > 
> > https://lore.kernel.org/linux-wireless/87sf31hhfp.fsf@kernel.org/
> > 
> > That looks promising, should we start using that in ath11k and ath12k to
> > check our RCU usage?
> 
> I see that Johannes already commented on this in the thread above.
> 
> I'm pretty sure smatch can't be used for this.

I meant "sparse"...

Johan

