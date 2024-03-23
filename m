Return-Path: <linux-kernel+bounces-112406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 567EF887960
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 17:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B9DA1F21A7F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 16:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A195847A52;
	Sat, 23 Mar 2024 16:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ttP9Ck0E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5137FBE9;
	Sat, 23 Mar 2024 16:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711211262; cv=none; b=UqB8UBWfuq92dhLqxt43ZaxNevLqr9qZYVBqHLKNlEBEOmroPURAeyxaoGkGs1AdDOGmlHlZfLaC2ucAg58Cy3ja3rXMctU93nifGBHLo2nDcVE+Oy9gemb6u/eafo+j/wv5CxnUKsB7CtU91tSQYOvpGBk2wmBnUeJigL5Wxto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711211262; c=relaxed/simple;
	bh=Vma/pcEXNxYRvNdR137I9OIWj+Sze300TSp7nlJt978=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gYrzmkcXFPKQnNWuc+T4K3uvgA7YwK1gJLyFEsmLrvRA5/rss7vet2C+ELEhVSqc7PjBCQa1lXhBnCPPRpPo4oZm4elxbrx9fAeBlvV/IA1nKRiXT1JBfEzpRw84VVSEgs/ua+8xHodjcIbwv+EOlWGibO4O56/nSjvAR1yp/wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ttP9Ck0E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7943AC433F1;
	Sat, 23 Mar 2024 16:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711211261;
	bh=Vma/pcEXNxYRvNdR137I9OIWj+Sze300TSp7nlJt978=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ttP9Ck0EP1jEQ5O+3QOt28aWBjd3+OPqTMJfFnQ3DqSZMgtrDgmMH8O/LXYqRc6mM
	 ZCs10GX0Ff6ATkdeVNiSi/faEuQnrE4pu4gIh65UU3WMvWgOwiS+K5koNeEBHHVYK+
	 Qy7n7QGEC1/T1JcCmOU6GkZy/aldhoJWkBySiLfnYEC4ygaUl9l96WjISHpbzIy+6R
	 zwEvdSkkrj+ix0Qlv3FdHHmqO/HBIfRPVEZWhDZiGf2cSFe66YS5WWVKV2VzNmH0qa
	 +gQrdHkNidxfJm7zG9jaOrrRE3ImYCh/Umjj2pUpqyTg/qU4L7+sik17Sf53CWj9QU
	 exIkytD4TuVnQ==
Date: Sat, 23 Mar 2024 16:27:37 +0000
From: Simon Horman <horms@kernel.org>
To: Andrey Shumilin <shum.sdl@nppct.ru>
Cc: 3chas3@gmail.com, linux-atm-general@lists.sourceforge.net,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org, khoroshilov@ispras.ru,
	ykarpov@ispras.ru, vmerzlyakov@ispras.ru, vefanov@ispras.ru
Subject: Re: [PATCH] iphase: Adding a null pointer check
Message-ID: <20240323162737.GA403975@kernel.org>
References: <20240323063852.665639-1-shum.sdl@nppct.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240323063852.665639-1-shum.sdl@nppct.ru>

On Sat, Mar 23, 2024 at 09:38:52AM +0300, Andrey Shumilin wrote:
> The pointer <dev->desc_tbl[i].iavcc> is dereferenced on line 195.
> Further in the code, it is checked for null on line 204.
> It is proposed to add a check before dereferencing the pointer.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Andrey Shumilin <shum.sdl@nppct.ru>
> ---
>  drivers/atm/iphase.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/atm/iphase.c b/drivers/atm/iphase.c
> index 324148686953..596422fbfacc 100644
> --- a/drivers/atm/iphase.c
> +++ b/drivers/atm/iphase.c

1.

The line immediately above the provided patch is:

	if (!dev->desc_tbl[i].timestamp) {

> @@ -192,6 +192,11 @@ static u16 get_desc (IADEV *dev, struct ia_vcc *iavcc) {
>             i++;
>             continue;
>          }

So the dereference will not be hit if .timestamp is zero.
And, lightly examining the code, it seems likely to me
that if .iavcc is NULL then .timestamp is always 0.

As Eric and Jakub have stated in relation to other patches [1][2],
it really would be best to provide a clear explanation of how
the problem can manifest.

[1] https://lore.kernel.org/all/CANn89iK1SO32Zggz5fh4J=NmrVW5RjkdbxJ+-ULP8ysmKXLGvg@mail.gmail.com/
[2] https://lore.kernel.org/all/20240322154337.4f78858c@kernel.org/

> +       if (!(iavcc_r = dev->desc_tbl[i].iavcc)) {
> +	   printk("Fatal err, desc table vcc or skb is NULL\n");
> +	   i++;
> +	   continue;
> +	}
>          ltimeout = dev->desc_tbl[i].iavcc->ltimeout; 
>          delta = jiffies - dev->desc_tbl[i].timestamp;
>          if (delta >= ltimeout) {

2.

A little further down is a check for NULL as described in the patch
description:

           if (!dev->desc_tbl[i].txskb || !(iavcc_r = dev->desc_tbl[i].iavcc))
              printk("Fatal err, desc table vcc or skb is NULL\n");

Assuming the proposed check should be added (which I do not believe
is the case) then I believe that the "skb" portion of the message
that has been copied from the existing check relates to checking
txskb. So either .txskb should also be checked or the "skb" portion of the
message should be dropped.

3.

After a quick scan it seems to me that all changes to this file since the
beginning of git history relate to tree-wide changes, clean-ups, addressing
problems flagged by static analysis, and so on.

I do not see a single commit to this file relating to real work on this driver,
f.e. addressing a problem observed by someone using the driver.
If so (please check!) perhaps we should discuss removing it?

-- 
pw-bot: changes-requested

