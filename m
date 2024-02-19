Return-Path: <linux-kernel+bounces-70962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 077CB859EB9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89586B21204
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96ADC219FC;
	Mon, 19 Feb 2024 08:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sI1sDyc0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7652135C
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 08:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708332492; cv=none; b=o4C0XE3jj5i8+HPFsarDpnvvpsCsMQNFrMLNWDMHPQXE4+QBwor++HHvXb9Kjhi91emEOD2+RfSI3O76KaQQn5cTdvrTeA+kJkS0UyVPCq+dm/7HYOoWirxQZ1/IVQMjlbH5q4veudh0Xwd1GeiFwXa0T9lJq6rloFQ4Dec/vag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708332492; c=relaxed/simple;
	bh=YoIDpWDIX9pforE2WxzkzBak0O5Z/5WZ0/U6XJm1nqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NVV08Icf+n/3QopJUJtDjhWBKoLfCSYJg4X7JY0Y2ZA/yj7hBXck/aSe18g2zqwf1QInNr7GhJBA2BR3vIlEiIiAJrvzxAcW/IqfKbN1+0vZvrVJxe3jwf9XuBn6Fu984k0smMYjY14WcUiTwGqKsqnNCat2nVEXOfam1sE0qck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sI1sDyc0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3506C43390;
	Mon, 19 Feb 2024 08:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708332492;
	bh=YoIDpWDIX9pforE2WxzkzBak0O5Z/5WZ0/U6XJm1nqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sI1sDyc0R39U29kfVeKCNL7WIjtcwSuzndUchHPg/ecwiYFxmSrU4L5VJjSp4Q0Gy
	 mx94krrvHwhpPHIe6ZXDQLEMrKtr6J9gPWXsSFCsfh2Cyi+NFC7fLehI9h/tswMSt7
	 xnRACDjB6qNJB+37nBABU3I12Dlb0HDds4RZNtHM=
Date: Mon, 19 Feb 2024 09:48:09 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] const_structs.checkpatch: add device_type
Message-ID: <2024021959-flavorful-lapped-b714@gregkh>
References: <20240218-device_cleanup-checkpatch-v1-1-8b0b89c4f6b1@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240218-device_cleanup-checkpatch-v1-1-8b0b89c4f6b1@marliere.net>

On Sun, Feb 18, 2024 at 04:25:51PM -0300, Ricardo B. Marliere wrote:
> Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
> core can properly handle constant struct device_type. Make sure that new
> usages of the struct already enter the tree as const.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> ---
>  scripts/const_structs.checkpatch | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/scripts/const_structs.checkpatch b/scripts/const_structs.checkpatch
> index 188412aa2757..5227f34a1b4f 100644
> --- a/scripts/const_structs.checkpatch
> +++ b/scripts/const_structs.checkpatch
> @@ -7,6 +7,7 @@ comedi_lrange
>  component_ops
>  dentry_operations
>  dev_pm_ops
> +device_type
>  dma_map_ops
>  driver_info
>  drm_connector_funcs
> 
> ---


Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

