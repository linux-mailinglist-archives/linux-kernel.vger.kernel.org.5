Return-Path: <linux-kernel+bounces-61773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC8A851666
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F0541C23316
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E89482D3;
	Mon, 12 Feb 2024 13:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NRkSAQk/"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9089F3F9F1
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707746118; cv=none; b=ALt5AXgEOf+A5bTDY3y+XdV8436BcB79dZSvvEDCfYJTs+8Cv+iyPLpqcRB2iyeJAW2A2CYc2N7wlt9ToGYTCmaNfQotZosHtKQ0PeQpIBx8PlIGwcrQlsf8y+GCHw1oFZzTBCwKSj/mkPaZXVO5BRYECL8U7pmGzrY4QhW9hEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707746118; c=relaxed/simple;
	bh=A7CF62CM0SmP/RQtAarmAlFDk0JBcuGbt4p09vT/r9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G9v7Xur0OOWWrYul5Cw9rnQXi1G7o2I2OlIN9qHE7EXVhck1Jmd8hMXjvET2zvDNLiYNa4rlrIgRmeixeG7PllfmHpAqx54EuvTzSTpm0I3M8H81wi7tJiEp/N+wNp0hhQ7eosaM5pvxKUV0pk7IRYEPWUyMdBWggVe3rJwCkwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NRkSAQk/; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5602500d1a6so4388621a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 05:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707746114; x=1708350914; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m0H408okGAfg/chpgekYfx9JZudQHf9tmXBxZ5aIo1g=;
        b=NRkSAQk/MbfJ6oIoSuXIjbWB5WvMg5oHBOqSisMx3zsIjAEMRDPFi3MoBvlmw1e6mX
         N68ZnkHdVygxhRUu/Ef1c3yCdA4C7osws/jxSJWaOZhb7tjELMfAUqu1HAO6kY9xfXse
         v8iYEacQYR1+UNCE3X9r3KQRMwIpib09vBt8xs+AVmrZNCoJGEMmXSaRtUNXjZuplRP9
         a/Bo6WIEnQsH09xJgBX1RTeiPueeDj3D2bgOFyV2RQVQlz5wBK18snrsF3/msPauSg1y
         CUHquTuuiqqFEWiTA6mosbnO78Mg5t66nH+uOWT1LNVqyWB7D8EgK14EF21YW4cvseMd
         c7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707746114; x=1708350914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m0H408okGAfg/chpgekYfx9JZudQHf9tmXBxZ5aIo1g=;
        b=vAYsT220U5d0SEfMeR8BU4zNjvuKqprpKg/Jcy59e/ZguKvAujFHbRHC7x+QUj+mYi
         8a6x4qmh9nzkT9idU91dtsYdQu3IseM/21R43DzsXUckdn+AmXMk9pV1KXhv4KmvcwHg
         kZBWZsTO+L5JOzT2rndqI55GA2cQkVQJGgAHfEky0+5vGLHE/tAIEBOFVRefPtcksN9e
         tIe+XVK9uQ5eGTQUFEMV44LNRfPegBTff39V+ZQGl2LKAyCwZCTaN4T3eC943ECnTWYy
         MzePbGkWXkCH/v0LVaPbyrG4oWyVU/pTHAL2kIcYCtGr5H6Bcqs5eM47rKgRIMSq2bYf
         qE2Q==
X-Gm-Message-State: AOJu0YynuVJ9uZAGMskmSWXdIYchON96W6i32v6Pm6gjjCowFh9anvLA
	hKswWv7Eqf6ed2YSaJvMrJtilDZIjB2hMVOdVW3N4kZ16UE/bQE7Cme927Gp9L0=
X-Google-Smtp-Source: AGHT+IETnL3gImozTuiUtynzbC6bLh97EMSE60Utc5/HsrktVZ2hPhuoH1IZ7mdo6fEzeRkE2O4DhA==
X-Received: by 2002:a50:f689:0:b0:561:85ba:dd96 with SMTP id d9-20020a50f689000000b0056185badd96mr3562213edn.35.1707746113884;
        Mon, 12 Feb 2024 05:55:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWeMEykx8W0S83/Sk7edDhPMHvOlfn30LstaMUHO01B1X9l+Ruz7bfR2TM/At/hbeHGMfQgPIp5J5ddnbVTF0khxmV/AJoaa14FL0f3m6jfIk5zG/sCbkQ/tpQvBh2UB4ijI6DRqN4FdaChzkOnDdNmsVt7gLcYHbtKYaKs15w0AvBBhZSr8WLL+SOEKDAcrxWiIVodkGBrZSvRN18BIIsBV5zTOwW7VMqfccvLiigi7j4hHe8oDYaqxyJdbAI=
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id n16-20020a05640205d000b005616db210c1sm2504560edx.67.2024.02.12.05.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 05:55:13 -0800 (PST)
Date: Mon, 12 Feb 2024 16:55:09 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Moritz C. Weber" <mo.c.weber@gmail.com>
Cc: marvin24@gmx.de, ac100@lists.launchpad.net, linux-tegra@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: nvec: nvec: fixed two usleep_range is preferred
 over udelay warnings
Message-ID: <e57cb313-77da-47c3-be5a-93725a52707f@moroto.mountain>
References: <20240212133645.1836-1-mo.c.weber@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212133645.1836-1-mo.c.weber@gmail.com>

On Mon, Feb 12, 2024 at 02:36:45PM +0100, Moritz C. Weber wrote:
> Fixed a code style issue raised by checkpatch.

Needs Signed-off-by.  Please run your patches through checkpatch.

> ---
>  drivers/staging/nvec/nvec.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/nvec/nvec.c b/drivers/staging/nvec/nvec.c
> index 2823cacde..18c5471d5 100644
> --- a/drivers/staging/nvec/nvec.c
> +++ b/drivers/staging/nvec/nvec.c
> @@ -627,7 +627,7 @@ static irqreturn_t nvec_interrupt(int irq, void *dev)
>  		break;
>  	case 2:		/* first byte after command */
>  		if (status == (I2C_SL_IRQ | RNW | RCVD)) {
> -			udelay(33);
> +			usleep_range(32, 33);

We only accept these udelay() -> usleep_range() patches if they have
been tested on real hardware.  Sorry.

regards,
dan carpenter


