Return-Path: <linux-kernel+bounces-157709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53EDE8B14F0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFBEA1F23158
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB7C156971;
	Wed, 24 Apr 2024 20:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJzj98ju"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5921713A401;
	Wed, 24 Apr 2024 20:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713992119; cv=none; b=pH1D+kPotanEUz4tcNpL3q6pwm6moFmLlweALeJvSO0Q1xWitZP3jMoBEfwW6DrRkm+U0+CUR1ohkNennBB8MNyi0RM11qMkWrcg034bIiE+qMhqRqpUjCB7by7M9L9xbtc4+ObJC/NCLIfnU7VkMCgf1uU83dSTXnYlOuIaX/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713992119; c=relaxed/simple;
	bh=ZD4tZlZg8iDpJqnTG0WbgD/HGxDLb2UNmsDflXW348I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s9V4s/I21QdSUZlgAkHxJpy+CQvLoLnTsLDXV3taaxpN245UW7JSoA119zc5xYiD8JkZDjvTWTLEx21IZnvpcLUYCake35q6aYse2lrxs9g+Awp2dfGCAfVtv5EVl0K++0SvoJuLIU7cQ/pNU8JoyUx5+fEMKZ7o2jcvmpXGkZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJzj98ju; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D4C7C113CD;
	Wed, 24 Apr 2024 20:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713992119;
	bh=ZD4tZlZg8iDpJqnTG0WbgD/HGxDLb2UNmsDflXW348I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jJzj98jupviMeWLvN/eHUpGzvpm4H8cPywyKS0W2BbVvUcKPd+Y2U0Sh4mpRENI9h
	 4JYQ4CztFu+Q1SuELJF36jG0y4+0DCI4gL7A8/KljNRPRlPz8MJ6E+xLiHva9hxqLv
	 U4sqROdbBe01rpD7PCVEWHOJUkgZXHbl9vasbFbYe8GbHXXBN0v/WbpJxuJCVKy6HO
	 YS5zB5eW1o7ZU+eDK4VbFAy4fgodT4bjuFI15Q6BfWWGE3thIdaCPXNipr07oAHlcD
	 /or6cmsJXGmv4px2eRLEX5pc+8L8uejB9aCyAndLLuVwU4eaxkHuPUs7WVXWLR2jCY
	 NpmtOHtqbbw4w==
Date: Wed, 24 Apr 2024 13:55:16 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH v4 27/71] x86/bugs: Switch to new Intel CPU model defines
Message-ID: <20240424205516.3l6gpsozvtt2fm3u@treble>
References: <20240424181245.41141-1-tony.luck@intel.com>
 <20240424181506.41673-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240424181506.41673-1-tony.luck@intel.com>

On Wed, Apr 24, 2024 at 11:15:06AM -0700, Tony Luck wrote:
> New CPU #defines encode vendor and family as well as model.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>

Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>

-- 
Josh

