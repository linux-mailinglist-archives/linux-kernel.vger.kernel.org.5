Return-Path: <linux-kernel+bounces-23502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A22BF82ADAC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2498A287004
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB371549A;
	Thu, 11 Jan 2024 11:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJKlqkF2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3F215482
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 11:38:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E7FAC433C7;
	Thu, 11 Jan 2024 11:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704973083;
	bh=+k8TWVbkF/+QNIM0Rm/51/WpkmMdTzXk0cSBs2TISkM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hJKlqkF2BDQ+RRbWt5YYQSXVDcmgE2ItEeZ0Uszoj8PliO1jukjgupdbtS6GlY4sD
	 bywybUifPG/0UAlAh5jjmJiUacdW7eWnPU4H0HG/0wrR0f0Uy67UrzsT8I7/9nL7YW
	 tFujCV6R5+fpqSB2zmLuMFkzr7tSKdFQ7Q0TjrJj7yWI/7kL8c1U94KDNVvc2JK3L4
	 aBlEornG3f/Mda1xzcyHNxpw8EfkaJb0ZWuHxRB4G4+po3MyDgqDRwPkB9WRsqk7mG
	 ly4mW2hgGQqgML0zxXXa+lWNRtG5vZxPx9VRnWOU4UM8dgQM/M1iCU8zU0o41XK7pQ
	 7lcjYExpuA4cw==
Date: Thu, 11 Jan 2024 11:38:00 +0000
From: Lee Jones <lee@kernel.org>
To: chenxuebing <chenxb_99091@126.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: twl: Clean up errors in twl.h
Message-ID: <20240111113800.GI1678981@google.com>
References: <20240111014555.5117-1-chenxb_99091@126.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240111014555.5117-1-chenxb_99091@126.com>

The subject needs to be improved.

Succinctly explain what you're doing.

On Thu, 11 Jan 2024, chenxuebing wrote:

> Fix the following errors reported by checkpatch:
> 
> ERROR: space prohibited after that open parenthesis '('
> ERROR: open brace '{' following function definitions go on the next line
> 
> Signed-off-by: chenxuebing <chenxb_99091@126.com>

Is this your first or last name, or both?

> ---
>  include/linux/mfd/mcp.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/mfd/mcp.h b/include/linux/mfd/mcp.h
> index fd5cafc77e8a..ed56c67bbbc7 100644
> --- a/include/linux/mfd/mcp.h
> +++ b/include/linux/mfd/mcp.h
> @@ -53,7 +53,7 @@ int mcp_driver_register(struct mcp_driver *);
>  void mcp_driver_unregister(struct mcp_driver *);
>  
>  #define mcp_get_drvdata(mcp)	dev_get_drvdata(&(mcp)->attached_device)
> -#define mcp_set_drvdata(mcp,d)	dev_set_drvdata(&(mcp)->attached_device, d)
> +#define mcp_set_drvdata(mcp, d)	dev_set_drvdata(&(mcp)->attached_device, d)

The code is fine, obviously.

>  static inline void *mcp_priv(struct mcp *mcp)
>  {
> -- 
> 2.17.1
> 

-- 
Lee Jones [李琼斯]

