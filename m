Return-Path: <linux-kernel+bounces-83124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA952868EC9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63DFA28A860
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E0C13959A;
	Tue, 27 Feb 2024 11:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rWr2n8qe"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3274556465
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 11:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709033322; cv=none; b=Lb3Y7egWC/uF6A41bVpzxUKWupFfahwwVhhMXqQgx5DAOhcpUOImwuQe0GxOapm53hx3kEveYgZOUft/G+m2W7sYKyaaTcPxh8gLWZ9+W3rN8JWtxvMVw1fXxpFds/Pibil7aVgb8ecVSK59eJZt/cod41E2tBXyP7ty9WR7yos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709033322; c=relaxed/simple;
	bh=9Jxn3F7BPbJ33BsE+OXoXYNcfkUB6WuSIR8VDNdlYzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qXoLugdq6RR0QkwffUVOPDpmxGKIsyLNvolu5GKo5fG2fG5DtUVZq/DnjUPpRMzM+0aXeqq3XiyyffGjmo0GYuwgjjV6SBI1JuDQXe1ltsp1i3UQOz/l93hX9YgiX1M2vY+YFROTZU7RBZTyHxfTOAHpBTS1cbNCMHSYz+WMsHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rWr2n8qe; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 27 Feb 2024 06:28:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709033317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3/B1z/tRHsooLBDmS7Eslm++6VzRqsJ367gEjAwED7k=;
	b=rWr2n8qeEuoWDefLVn3ckv0ahrgUOkAUXMAfezhSjEVXayA6L1mNdveX/d6e+zHQ6+JJi1
	B6Y35c2xrg7ioXJN53n1e+2cpx0YMNIus1xclfUBZRQ4IQzm8mTIUSMoY7VsTALkbVDukP
	26cUyLhefJgSTjo0qH8kA8yRoCeWeTA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: lilijuan@iscas.ac.cn
Cc: bfoster@redhat.com, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pengpeng@iscas.ac.cn
Subject: Re: [PATCH] bcachefs: mark some of the functions in the bcachefs
 directory static
Message-ID: <ewrqjlfbnmuj442y24v2kp4n4b2l3egog6cpn4ryg2dgctzx46@dboxgm6blsv5>
References: <20240227102035.537903-1-lilijuan@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227102035.537903-1-lilijuan@iscas.ac.cn>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 27, 2024 at 06:20:35PM +0800, lilijuan@iscas.ac.cn wrote:
> From: Lijuan Li <lilijuan@iscas.ac.cn>
> 
> The modified functions are only used in the .c files
> in which they are defined, so mark them static.
> 
> Signed-off-by: Lijuan Li <lilijuan@iscas.ac.cn>

this doesn't build

