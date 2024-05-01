Return-Path: <linux-kernel+bounces-165352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 090048B8B9D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D0F91F21BF5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D3E12EBE9;
	Wed,  1 May 2024 14:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ovMJmXlz"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9027F12DDBD
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 14:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714572110; cv=none; b=M5o3Ws9nqKN4BC4kBBVSIgX4tJX9fr6cPHNzh4fsEvcpCPC/o8zqg17t8YQbCWhJJLtIRvTBKlyuNIDf8PYbVJL+ZWSQHRs/MdAgM4rf6Oqfa3NPC3Kg+o0u88AJR8i/PRvEPDna66lBqsTGUdHrHMxuiXQHyBAZvNmF9Mz//Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714572110; c=relaxed/simple;
	bh=MRQauao233bl7PaCKp2AAgdkPImfXRP53eHl06LQeag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e47Wg1169z+ZCde43S3X5SCIykiYU/uQQJ2QGnwCT9TweWgEvhI+p0U8CIaeGlLfRnrjPCC39nE4oYnvUC8kti5GN74qjAnr/Uv6M+/La6asNKVAJ+NN0gb5I4XHxzm3pNmaQfIgWltMRjW+Kgc0ttR0lcVY675fFOLCwuIJqDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ovMJmXlz; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41b79450f8cso43339135e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 07:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714572107; x=1715176907; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MRQauao233bl7PaCKp2AAgdkPImfXRP53eHl06LQeag=;
        b=ovMJmXlzrne8niuccMib5zu0vOZhemNly9cMl1Gcl1cLaiAAo7cTJoByh1MPYJdlGt
         aFoEWNAonoUS0qHDx/p/fgUQMFZf3KSPAQlYNQc0pZV5c91a+2D04agZs+mtScWKT0R8
         wnW9mfDzr/+Ejnz91KQs8zOnxo3vB17WhjiC3WuY8Kj/7mQZ9BKCFT7IFDeDfNuYbM3o
         /KeaY5TMJUivwVQ7L5vZW7x09S8ZX+E652aoJUF/F07YAP9wxw3Fr50a+zteaAq9K/k9
         HRyVTuoE8uSAqfIjYKTM4YZ9ftpEwftqGTWEqui2kTIBjYg6iuR75IiI3J2DLXGaudn1
         dfmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714572107; x=1715176907;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MRQauao233bl7PaCKp2AAgdkPImfXRP53eHl06LQeag=;
        b=o8BnSgM4lBfee62XoFYgD4dYjbezc2CswRBjfcYbsp5bNz1s9vCqO/ytlB5Kbkoh2W
         ytTcQQBvtwLWk0VcyE30GZSkuAOshGlwfzC9RQry0K7Vwmwns2PYXaiqxdhYvgXGZIfH
         oBUAN3CEKBgCBC6lG6S6UslEdr/hnuBfE7Lnrrs1Kx/9/UdGFSFHohO9s23w2MDKWXwU
         ycjCKcbwluNg9rpEWrgt23zsLW0z2K9SoPp1qJu0DMWANccMEvTx4K27BSBgpOUBjWk0
         vn1bVmmrVmIge9vvqX1E50EpX12os2/1ShpEWLyfFFlSC5cUBKyiT2fV9VV9S+Qnr/dE
         XKnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXH3oOT8YLQ1w7zhaVVShJ+aerLkTDuPlxKLwFEONsICjxpeBUB41XX53kWUtiV/ZNrLPB2otYI27PuTK4YECSSPuPOOca/AmpfAF8h
X-Gm-Message-State: AOJu0YwK7mHj/9G7EpxE4Nere4TZDzjpMAqMgR4cMLJT+W1cVH9Ou+8r
	vbV5RlUvqwPdYP2bEHFuPp5aE3kUR7rKKjSm9SkEobsFx/Erw/KdK4c1/CYdARI=
X-Google-Smtp-Source: AGHT+IF6AVQRyF6Dk1uSruwo7/L5zDwxkFGB+A6XFcz0Xm5YcaxaSXEkcGktSgGbTNPnxqHZOX+zUw==
X-Received: by 2002:a5d:4a05:0:b0:34c:a488:e6d0 with SMTP id m5-20020a5d4a05000000b0034ca488e6d0mr1782698wrq.36.1714572106928;
        Wed, 01 May 2024 07:01:46 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id n12-20020a5d4c4c000000b0034de40673easm1117019wrt.74.2024.05.01.07.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 07:01:46 -0700 (PDT)
Date: Wed, 1 May 2024 15:01:44 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: R Sundar <prosunofficial@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org, javier.carrasco.cruz@gmail.com,
	Julia Lawall <julia.lawall@inria.fr>,
	Shresth Prasad <shresthprasad7@gmail.com>
Subject: Re: [PATCH] backlight: sky81452-backlight: replace of_node_put with
 __free
Message-ID: <20240501140144.GA10180@aspen.lan>
References: <20240501125146.33648-1-prosunofficial@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501125146.33648-1-prosunofficial@gmail.com>

On Wed, May 01, 2024 at 06:21:46PM +0530, R Sundar wrote:
> Use the new cleanup magic to replace of_node_put() with
> __free(device_node) marking to auto release when they get out of scope.
>
> Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> Signed-off-by: R Sundar <prosunofficial@gmail.com>

Thanks for the patch but I think this one is a more appropriate
solution to this issue:
https://lore.kernel.org/all/20240421104916.312588-2-shresthprasad7@gmail.com/


Daniel.

