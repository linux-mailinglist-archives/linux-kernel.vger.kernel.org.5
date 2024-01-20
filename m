Return-Path: <linux-kernel+bounces-31781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C31B8333E8
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 12:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1460B21E92
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 11:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF97DDDD;
	Sat, 20 Jan 2024 11:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fqUpZAJm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87890D2F0;
	Sat, 20 Jan 2024 11:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705750886; cv=none; b=bwQoi7KplKphyMqYl+ohe8aOvg2vNCnlID7YkDeOK8HF1B1RGqIR3Majzi1NqTYdbpZhm0kmQM9SzgM8EvucpZpVL30GSq1BBxq0DMTyJnUou/2GBs/vs4GlMNbOO8ALmb0W0n2QWtSDdi3mEJ20/aRNLjQk1iavdm4A3hnnsxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705750886; c=relaxed/simple;
	bh=fEOJ/SLhFHP1Cs6MwAcKFJ3V5Nhrt3Muo0epX6IfEPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m5oeTkwNJrhSaZ+NUo2YWMTXhB2yxMP6JlKYcNOrn4cybuLU0aP1l3EwcRKK+YPZW1hF7u8Hj4M+fu5EVdGwOFLRZq1zeKDZ8nyhh84F6JPaNN/hGi9RQxJuxCIQyB5m9sAu4ngtlB4GlFYtKWFPeSH2mZSxRmao9sbo/L9l5eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fqUpZAJm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD104C433C7;
	Sat, 20 Jan 2024 11:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705750885;
	bh=fEOJ/SLhFHP1Cs6MwAcKFJ3V5Nhrt3Muo0epX6IfEPo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fqUpZAJmj1Jg9FsTGsOly7juaAkWKZhbeS8vmvYE+YQ+GxYo1l6xe1ZoEzlm+YYXL
	 H8LiXF1DzMbcIo+VD+DTgYLIDmd8yoy84pIgwGzuee5CEAmKmeuXv8IaPqgRiPRssF
	 Tzf8Lb7Vlu5PA/S9BYGrHkJaUU8tv2MDnGJDvWHUTI2m4iteoS5mxnUB5UtKpvFn1S
	 fFzFWNq7UFXyafCmcTDEk5CBxijsmEMvFQRgXZgdkOFriC7Gci4ud2N/M8Z3Yl4KTF
	 um76L2mZpzmyoJALeGWrMVyErtvyskYAn6qcXm4oCBgtVmr5MzC/Y+O2ID9uaZN/4Y
	 ZBFlrHqkaQ7jQ==
Date: Sat, 20 Jan 2024 11:41:20 +0000
From: Simon Horman <horms@kernel.org>
To: Lin Ma <linma@zju.edu.cn>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, dsahern@kernel.org, razor@blackwall.org,
	leon@kernel.org, haleyb.dev@gmail.com, ja@ssi.bg,
	judyhsiao@chromium.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v1] neighbour: complement nl_ntbl_parm_policy
Message-ID: <20240120114120.GB110624@kernel.org>
References: <20240119070847.5402-1-linma@zju.edu.cn>
 <20240119195058.GA105385@kernel.org>
 <3ddbc728.7c83.18d245c1152.Coremail.linma@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ddbc728.7c83.18d245c1152.Coremail.linma@zju.edu.cn>

On Sat, Jan 20, 2024 at 08:53:50AM +0800, Lin Ma wrote:
> Hello Simon,

..

> My bad, I prepare this patch on the linux-stable tree and never thought this would happen.
> Will also compile on the right tree next time.
> 
> So should I send this to net which has this attribute or something?

Hi Lin Ma,

If it is a fix for net, then it should be based on net and targeted at net.

	Subject: [PATCH net] ...

Else, it should be based on and targeted at net-next.

Either way, I think reposting is a good idea.
Although in the net-next case, please note that it is closed,
so please wait for it to reopen before posting patches for it.
It is likely to reopen next week.

Does that help?

