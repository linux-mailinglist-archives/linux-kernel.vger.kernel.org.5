Return-Path: <linux-kernel+bounces-97489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39381876AFB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 19:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E758328385A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB36657332;
	Fri,  8 Mar 2024 18:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="uxwr5CgG"
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1666958201
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 18:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.203.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709924240; cv=none; b=TrcunaCJpwMShiTvwuF0eVrh+1eHsHRwh1al5t6EibXwgxlzCfBrAaqPkKBw+W2S6Ch3fZ+f4ET/Mf8c+vuZXJRq9yP3cOSFts+1w77nuDn4wrfNoxmVeTcVX/nZeYfKaLfEwhvLnsLDWfvR8UDMpnCmv4FC6zCD3GxCUP9cVog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709924240; c=relaxed/simple;
	bh=W/S6YVE2N22GZ0K/E+PhUSGeVjzkFSrrJpVdzcpFjkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jtPDC/+8hmXIQkC+gCNPWy5p2iB5xcgUmnctxNyFOTc8oWXEP/5T6N6J6zeYr5/s4NWLJJZEM63gUB8fEl+3m6EzNcy6u4aT3inMywJr9epD5g9TlCz7jzHVGxK+uhWN4Qou35hbVwUIbvKU645OcSR8ZjcxB0S7Fn+U0/M7P5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=uxwr5CgG; arc=none smtp.client-ip=188.40.203.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hWPBVLYXJDFa8zEKefUX+1hwxLuSBGMK1/OmWBWIvjc=; b=uxwr5CgGQ+ikqWD6thdwsE/5Ul
	2J6n9FokaQC5PitC9OA+f63YNPYzvQvOtrh2ch12qJrjdzhi13VQyH9cB1St8R7WiuOeTgCF3H3aM
	5pL6Lk+yXE4ll4m6IGFHSw8/xkFTqEoFP9o8uh4Ymn9dfDfCictZRyTmL877nJBvv0AI1gH0iFbA2
	2p5Grnh8MucjF0+OiaarP4Ip4EwgIdHAFl53rQ6Pi6vkVbunAiJUB64//uX5E0smzkGETR1N3irQK
	AbsVWwTtctv4aUVHpmlsL+94UCVYwPKLyKZ+lYkVKLC7i4jzyOEm1MjIdfd1YXQ7wmNbJ70yH5rUP
	uEX4FTeg==;
Received: from [167.98.27.226] (helo=[10.35.6.244])
	by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1rifP9-00CPOt-Dq; Fri, 08 Mar 2024 18:57:15 +0000
Message-ID: <b6e60c22-8054-4efa-85dc-eb587296fe63@codethink.co.uk>
Date: Fri, 8 Mar 2024 18:57:15 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] comedi: don't build module device_ids if built in
Content-Language: en-GB
To: linux-kernel@vger.kernel.org
Cc: hsweeten@visionengravers.com, abbotti@mev.co.uk
References: <20240308185419.1929060-1-ben.dooks@codethink.co.uk>
From: Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <20240308185419.1929060-1-ben.dooks@codethink.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: ben.dooks@codethink.co.uk

On 08/03/2024 18:54, Ben Dooks wrote:
> If not building as a module, then the device_ids[] array is not used
> by the  MODULE_DEVICE_TABLE(pnp, device_ids) so remove the warning
> about it not being used by enclosing it in #ifdef MODULE
> 
> Fixes:
> 
> drivers/comedi/drivers/ni_atmio.c:209:35: warning: ‘device_ids’ defined but not used [-Wunused-const-variable=]
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>   drivers/comedi/drivers/ni_atmio.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/comedi/drivers/ni_atmio.c b/drivers/comedi/drivers/ni_atmio.c
> index 8876a1d24c56..f0dbe4c2341a 100644
> --- a/drivers/comedi/drivers/ni_atmio.c
> +++ b/drivers/comedi/drivers/ni_atmio.c
> @@ -206,6 +206,7 @@ static const int ni_irqpin[] = {
>   
>   #include "ni_mio_common.c"
>   
> +#ifndef MODULE

Whoops, this was meant to be fixed to #ifdef.
Will send fixed patch Monday

>   static const struct pnp_device_id device_ids[] = {
>   	{.id = "NIC1900", .driver_data = 0},
>   	{.id = "NIC2400", .driver_data = 0},
> @@ -216,6 +217,7 @@ static const struct pnp_device_id device_ids[] = {
>   };
>   
>   MODULE_DEVICE_TABLE(pnp, device_ids);
> +#endif
>   
>   static int ni_isapnp_find_board(struct pnp_dev **dev)
>   {

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html


