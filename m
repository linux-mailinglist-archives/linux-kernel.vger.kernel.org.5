Return-Path: <linux-kernel+bounces-5808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A685818FBD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 19:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8E5428715D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C46A37D29;
	Tue, 19 Dec 2023 18:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="grLsKsOY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A9239AC4;
	Tue, 19 Dec 2023 18:24:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D66D1C433C7;
	Tue, 19 Dec 2023 18:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703010267;
	bh=yc5uKat7NtissNxZpaWjGwzUpSciT3vGWCPKFGRf70M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=grLsKsOYe2YYeK7firvhqaoeiFCCwhVpkVLyqdshoeHbL7uSX3l5rVO28pKDBEZ+8
	 uhkPcqKCn1HNFlQdA+iPqfRVqfXI0Bf7GTlYMhhxj3s1b5fn07PsG1xId7iM9FJl3I
	 LLkuhWcnZUtor8jjWo09Aj624PrKHd0rnPq6F0VQ=
Date: Tue, 19 Dec 2023 19:24:24 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Tanzir Hasan <tanzirh@google.com>
Cc: Kees Cook <keescook@chromium.org>, Nick DeSaulniers <nnn@google.com>,
	Andy Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>, llvm@lists.linux.dev
Subject: Re: [PATCH v4 2/2] lib/string: shrink lib/string.i via IWYU
Message-ID: <2023121926-mummy-gondola-0a56@gregkh>
References: <20231219-libstringheader-v4-0-aaeb26495d2f@google.com>
 <20231219-libstringheader-v4-2-aaeb26495d2f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219-libstringheader-v4-2-aaeb26495d2f@google.com>

On Tue, Dec 19, 2023 at 06:09:52PM +0000, Tanzir Hasan wrote:
> This diff uses an open source tool include-what-you-use (IWYU) to modify
> the include list changing indirect includes to direct includes.
> IWYU is implemented using the IWYUScripts github repository which is a tool that is
> currently undergoing development. These changes seek to improve build times.
> 
> This change to lib/string.c resulted in a preprocessed size of
> lib/string.i from 26371 lines to 5321 lines (-80%) for the x86
> defconfig.

Nit, use 72 columns like your editor is trying to force on you when you
write a git commit.  As is, these line-ends are all over the place.

It's the stuff around the actual change that is hard to get right...

thanks,

greg k-h

