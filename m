Return-Path: <linux-kernel+bounces-31721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D80C8332F8
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 07:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A64EF1F229C6
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 06:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05AD81FD8;
	Sat, 20 Jan 2024 06:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EcD+dZah"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C059110C
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 06:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705733098; cv=none; b=oH+JSwVqvahqmxUBRt8wGxruRHJSCnS2XYI+1ap5y4/LnJz8MLz0e/OeLLcUzjTH1vz2rgffQHH6aVQHv/FGrLzLlBpXKBwFp52aRPQhuKF2TMSXdA7y3XLAy2T38c7JFuaaCrnr53IG2F06Yc6BkA/vfE2akqdGTVqbdcOAVVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705733098; c=relaxed/simple;
	bh=mXISCnVnZDJqJnGivhVUgmM3kBJei0cwIy/Vv3NV2ec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YgHJLZhPhazOfBv6cm8YtIVm0pBXwNK2Ec6b1evDfdwa2kOvS604277batosAERR5v2yJJV66OPJYmOidEtoM+xB/hgunuLJKxO1QNq9GKRPm9x0gwsIrhwm38yWv6W47ZeOw1DPcvYDJYXMU0NAs23ATz4rw0xqVQhA5sjUbrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EcD+dZah; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=KyVk/SOUXJl8dnnCYM6D4LOj7QVA0hhOE3Pxx0E0hBA=; b=EcD+dZah5jKikYIqbwm00byvbZ
	GKnVP5FJSKNnitaA+aLoInrWxgfIJEJcJXIPTq7KOeLXt8iA+pVVIwIl9ChEQCNVTtX2ZOf4TepsB
	ddnp2hRWH1oXabOymclFtX8aGOwMq/ML360oIdmaxdi9eIcGW5Tof2Q4XSFSNYJgM3gtnLWseuS+S
	cs9jxsJILV0yHBaChKz1IkKOIIpEevux3RZLKjkTgM11qvg2LXaRdZpIrlZ5rrDLK8RHEprPtqxZl
	2jbhzApDZgxbJ1U9M4d5WLICYB3QKRYi1Ke20ST9OIEpNp/fcoMPWOhO5P7NRz4AAhBHnwqwUtPY4
	6HrUjK5g==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rR564-007Lqr-1y;
	Sat, 20 Jan 2024 06:44:53 +0000
Message-ID: <a7c8ec21-adf5-4dcc-af7d-33662f864596@infradead.org>
Date: Fri, 19 Jan 2024 22:44:45 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/display: fix typo
To: Oleksandr Natalenko <oleksandr@natalenko.name>,
 linux-kernel@vger.kernel.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org
References: <20240119102215.201474-1-oleksandr@natalenko.name>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240119102215.201474-1-oleksandr@natalenko.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/19/24 02:22, Oleksandr Natalenko wrote:
> While studying the code I've bumped into a small typo within the
> kernel-doc for two functions, apparently, due to copy-paste.
> 
> This commit fixes "sizo" word to be "size".
> 
> Signed-off-by: Oleksandr Natalenko <oleksandr@natalenko.name>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/gpu/drm/display/drm_dp_dual_mode_helper.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/display/drm_dp_dual_mode_helper.c b/drivers/gpu/drm/display/drm_dp_dual_mode_helper.c
> index bd61e20770a5b..14a2a8473682b 100644
> --- a/drivers/gpu/drm/display/drm_dp_dual_mode_helper.c
> +++ b/drivers/gpu/drm/display/drm_dp_dual_mode_helper.c
> @@ -52,7 +52,7 @@
>   * @adapter: I2C adapter for the DDC bus
>   * @offset: register offset
>   * @buffer: buffer for return data
> - * @size: sizo of the buffer
> + * @size: size of the buffer
>   *
>   * Reads @size bytes from the DP dual mode adaptor registers
>   * starting at @offset.
> @@ -116,7 +116,7 @@ EXPORT_SYMBOL(drm_dp_dual_mode_read);
>   * @adapter: I2C adapter for the DDC bus
>   * @offset: register offset
>   * @buffer: buffer for write data
> - * @size: sizo of the buffer
> + * @size: size of the buffer
>   *
>   * Writes @size bytes to the DP dual mode adaptor registers
>   * starting at @offset.

-- 
#Randy

