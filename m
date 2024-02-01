Return-Path: <linux-kernel+bounces-48313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49815845A2A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E439B2B076
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910655F468;
	Thu,  1 Feb 2024 14:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Fl9SC6wL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD5B5F49E;
	Thu,  1 Feb 2024 14:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706797391; cv=none; b=dMjF5SA1A/XNSC/XYGgI834y283/osNd/6pH0lXCjUR0v1brvDzhGl5zqhPvFSLeCBo9PyvvR4FuidjHjtKymeWi5bJslmzoYXGut4aQdQbeOblqYekP+DNZinR7a66hSUBKeQKI7UcOTD0mwd256RKTXW0PSi/m4dx7kM0yz7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706797391; c=relaxed/simple;
	bh=WsG+R9NmtL0YLV7hMM/jIjsW9m5o9P9FbMEh4vzvzZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+Vs/4NtZktbeDRdARFm+wRGu+X/iC3S4jTFxjjl9mQFvNqjg4CrUrAZyQmuUWVYj8Vj5H+RnlTTMg38rAoe+ZNHZeAQzpQKVKZiEs0sX/yOfkE2PkiSaI/wiRSsrhBHtor8IwzoWqtsmbY/nKk/ubZEZFVN0vvnxop7cplyxXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Fl9SC6wL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 351BAC43390;
	Thu,  1 Feb 2024 14:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706797391;
	bh=WsG+R9NmtL0YLV7hMM/jIjsW9m5o9P9FbMEh4vzvzZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fl9SC6wLJPus3RPok/+I9u9vDZFNALlOptOOHzFJWd+3tTrduGPDleoCWDnqqtrdz
	 utnGTtJYpWFmjQKCm8z8yDfxW5Bid3js70ArSW06NAMQYxqLqjs+ApRnY2gZN1UFEB
	 O+AOCR1Aa7UWw8VNSNBykrghdpQmqUuNqqgJwVCY=
Date: Thu, 1 Feb 2024 06:23:10 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Gui-Dong Han <2045gemini@gmail.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, baijiaju1990@outlook.com,
	stable@vger.kernel.org
Subject: Re: This is classified as spam [was: [PATCH] tty: fix atomicity
 violation in n_tty_read]
Message-ID: <2024020156-reforest-entrust-2388@gregkh>
References: <20240112125801.2650-1-2045gemini@gmail.com>
 <feabd944-47b6-4ea3-bde2-b6e90c58015f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <feabd944-47b6-4ea3-bde2-b6e90c58015f@kernel.org>

On Thu, Feb 01, 2024 at 10:02:46AM +0100, Jiri Slaby wrote:
> Hi,
> 
> all your mail is classified as Spam in both my private and company MTAs. Not
> sure what CCs' MTA say as I don't know why (as dkim, spf, dmarc all pass).
> You likely need to fix your mail setup somehow.

It was classified by spam for me too :(

