Return-Path: <linux-kernel+bounces-1299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33376814D13
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 667171C23A48
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1113C497;
	Fri, 15 Dec 2023 16:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="QYQMTncq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8427D3DBB1;
	Fri, 15 Dec 2023 16:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 9AF472ED;
	Fri, 15 Dec 2023 16:31:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9AF472ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1702657890; bh=MOGN08AAxPtXYlfatBeq3Ua29jRUGnUBoCfFPOWMpcY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=QYQMTncqCC3ycU6OLwKc3wuqaApQ8kGpraPH5WeaEOF1SetEFXQ/6nZC/98pG3fw7
	 VE1081/ZC9OpaF3/30rSbzEzfiFWEOHAzRJWTzuwUPTtphLRuWES9oEmdfJcD6/pXJ
	 C4iupHPPb7l7Ras9/MpWwgzWjxe5SS4SX7Ls0/9s5jwzj6QZppvwNSKTcnV/xxDzZo
	 UWM9Kq2+D2p+bC7UQ3jtRFDbmvrZ86n4UowPERSAYg9us7+PkIifx3TNH4olaixOI4
	 Gw0WcGizXegAntOEP8s1H2+zIMCXbrzAgQeQoG30CmoWkMpSjnMJXZHwrdkjvgs8bm
	 vSq29HvLP9kzA==
From: Jonathan Corbet <corbet@lwn.net>
To: Kees Cook <keescook@chromium.org>
Cc: Kees Cook <keescook@chromium.org>, kernel test robot <lkp@intel.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-doc@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: conf.py: Ignore __counted_by attribute
In-Reply-To: <20231215001347.work.151-kees@kernel.org>
References: <20231215001347.work.151-kees@kernel.org>
Date: Fri, 15 Dec 2023 09:31:29 -0700
Message-ID: <87wmtfpgv2.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kees Cook <keescook@chromium.org> writes:

> It seems that Sphinx is confused by the __counted_by attribute on struct
> members. Add it to the list of known attributes.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202312150614.kOx8xUkr-lkp@intel.com/
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: linux-doc@vger.kernel.org
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  Documentation/conf.py | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/conf.py b/Documentation/conf.py
> index d4fdf6a3875a..5898c74b96fb 100644
> --- a/Documentation/conf.py
> +++ b/Documentation/conf.py
> @@ -106,6 +106,7 @@ if major >= 3:
>              "__weak",
>              "noinline",
>              "__fix_address",
> +            "__counted_by",

Applied, thanks.

jon

