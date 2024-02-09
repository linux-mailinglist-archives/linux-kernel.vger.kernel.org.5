Return-Path: <linux-kernel+bounces-59557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D62C084F8E1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CCF61F24EC2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C6C7603A;
	Fri,  9 Feb 2024 15:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gd6H8K62"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D21A74E10
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 15:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707493834; cv=none; b=o4pUo0MP76QNmVe3dVVD5wRnDKUKNX5AXdH2W/lPtWbvhwaMlbwgA6hUQ0yeqwk7eQFPDlvMxIQCb2ivxxEUPQgO09BkMygVOIYFu6O5tBxWh8hT4Ytv753OoNxS1e4CEANwRr3zq2MiPB3AEPHgCK5pLUmszOJwUzQlZ9GdJV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707493834; c=relaxed/simple;
	bh=zRj7Ic4l/E73fjvhjprZydN7d0176ik2vMMmlB1Ot98=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZCHAFgp4+MkuMUN+cHBhSMGmOG7L0YsWU+JIExu913sgLKtY/R7kWGGFDyIXZvbBtLIRAOjX7oeFvRmAEPqLSV3p47i1Rk6bipXuYmf3bqxJJxrRgdMxL+KOtyiFTGmdQz0nSpQn8jZufpdbH1VKcivvFtQkFBadvEfgo6frLKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gd6H8K62; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE1EAC433C7;
	Fri,  9 Feb 2024 15:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707493834;
	bh=zRj7Ic4l/E73fjvhjprZydN7d0176ik2vMMmlB1Ot98=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Gd6H8K62KuZARwutWS7UtdyHlLVoUpcXYspGEJb1w5wdxpSUcNbv5Fev/+6jzh9Mk
	 /ddrLAWcBB58pafUJxOMJ7VsfTSqUmvITzEQr8c85Qq1ceSgxs0h2guX7vL8bygqkK
	 mGQLE+zKYV7n2J0kO6gyvIfB5itVCebY/wynHR+68dI2RrUI63Nr7LljnipHBAiG/U
	 1ZKX+5Epto301nUA4GPhcDuiktyk9gIt7uEWBC0vbK8YN58XNdwthsieTBTLlxdyiO
	 7oZ+9Ul2C5ezTlp6fB1OIhIkEO2YcBUYX+9zoxcdf+XJevXp/qUpXQDsU9hAUgG68H
	 0dUILikGB9r3A==
Date: Fri, 9 Feb 2024 07:50:32 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Imran Khan <imran.f.khan@oracle.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] connector/cn_proc: make comm length as TASK_COMM_LEN.
Message-ID: <20240209075032.1deb447a@kernel.org>
In-Reply-To: <20240209121046.1192739-1-imran.f.khan@oracle.com>
References: <20240209121046.1192739-1-imran.f.khan@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  9 Feb 2024 23:10:46 +1100 Imran Khan wrote:
> Since comm_proc_event::comm contains a task_struct::comm,
> make its size same as TASK_COMM_LEN and avoid magic number
> in buffer size.

missed CCing netdev?

