Return-Path: <linux-kernel+bounces-58614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A5384E8DE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 20:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10495B22422
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B8E3717B;
	Thu,  8 Feb 2024 19:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="EahjhotU"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3F437163;
	Thu,  8 Feb 2024 19:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707420193; cv=none; b=QLdvavEuEOUJnBK0A5ZK+dT0YPWJiLbTHmOf4W1KTWOF7oJ71y+/FHIMFB4+9nNpU0c2SjWlR0RoRxKpaYyZjx93DxOWtB2tYNhDb8urc2Re13j6F5Dqhj4x1WzoBVkOiTkDKk6s530dpPoCgLYUxvXBrD7Oe9OOeDwKCaqGoH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707420193; c=relaxed/simple;
	bh=KvYyFdcwjgP/Rkhv5767LwtVpy54zvCJo9+Ht3k+HL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b5Xen9zSzd79IZzIKJnsL/vE7PDWmmRTnoeeF9u0fWemuaHI3aPeaNGLS4EFTOz4zmSU0WMHoGPwLVmLERUiD69UhmOLiaOLPSjFWvGo9r5YTxMd95JTDqcMbm2ucOtv8MIYAI7Cx0jBbkU9qIxWktDHPJmZ+/Zzh7gvnY27RBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=EahjhotU; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d934c8f8f7so1231665ad.2;
        Thu, 08 Feb 2024 11:23:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707420192; x=1708024992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:dkim-signature:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aekVA8W5LNzx7JoIMAEi1mYxc0TyEjSAi3zyG/+SeE8=;
        b=nO28/nglpDkzB8Elu69d9THnxuKz1rtIOV9sGbxeb8iWZokivljCh4XdwtzM0HpgOZ
         uaWLVxFSvlU4wiiDNl1l8snPeFjRNqTfA92+wPut8bydEgOUyrJjYopgGvuEdlKrK8uo
         x8n//y0PHuSggxnpem8xwbfX7F6QnXbxw4ZhBB0K/Z8ofiGddZlVmw/2LiVhtpTJ1elh
         vEG32gn3dcITAzp1wGMJT3+MmxZblJluYBrvH9q+xZTJD75X2FwGJZGi87MZZp4QkJzl
         iQ84tKvC8Zc+dC5vECG8yeQ+pAidJRL8JoBFMvhC0zkUfNZ65kh3TSX6qCgkza2V34es
         rdIQ==
X-Gm-Message-State: AOJu0Yzp/BJHLhLCQcUhQ0BdBkSmmBl1KBT1W1MtKHOe1ufUggVxjBr7
	mXFDlYgjQF382suz7Hw01vllX/9VgdXSblp0uHkTDvQ2pDxt2IjVQH6gc6TC35joDQ==
X-Google-Smtp-Source: AGHT+IGuKRh6ayiRS8PM5sAPxRCD+/D6PUEHpbqFP6OQ7YEL21go1NPhvh6nKDUEjeiNarx9OnJj0g==
X-Received: by 2002:a17:902:ecc8:b0:1d7:3121:ffd1 with SMTP id a8-20020a170902ecc800b001d73121ffd1mr181019plh.13.1707420191641;
        Thu, 08 Feb 2024 11:23:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWB7UwkoUdjEinSIevWRJozFFm2+Nwy6tSKcacscNK0Crq47EFBXBvrqfvNFyBuCIVwTECm74/FlW/TkszCfRhY8SqK3aoC4vdtSKgEUGFL7yJMby884C4VFNt9nZfjTOcr49PbMn/WwlbKeiEfGhkh7+3PRKGSOAqbo2gAjNTnzk9lp/L0+Go=
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id f5-20020a170902ce8500b001d9396ac4ffsm98344plg.284.2024.02.08.11.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 11:23:10 -0800 (PST)
Date: Thu, 8 Feb 2024 16:23:42 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1707420188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aekVA8W5LNzx7JoIMAEi1mYxc0TyEjSAi3zyG/+SeE8=;
	b=EahjhotUOcXdZ2y114OYJfq5RtbDOAXZFd7KiPcXO9H5JhIAPqUtUy2PuDpWzDRdDfjtAi
	O+KAAmp1ZcFYwA5L5hF5cBXFlyHEs5JwTv2rm4HXzcBT9wth3P2mErwyvl6zrKivGG5Sk8
	XH0k04u+vmQ2x1FCtRYvyo3ciVBh8GVr/C6hZuInDY6Gs6DJvyQgJ7Jqq6J1ef6CE81LTK
	Y5Hgl71ynUXRTP0p1TZ1ErobRrNaxzGURh/BYqTpavn82Zbe5x1tekvetdXVPRBP/sYh3K
	VyXZDJFNYZFdtuZoM4N/lzNFQuoR16K+k1lJ/oNBFwmJbXg59vUYCsHLTw2opw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
From: "Ricardo B. Marliere" <ricardo@marliere.net>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] bus: mhi: ep: make mhi_ep_bus_type const
Message-ID: <5wutxqhfcxndolhu3mhgfx7jsqdnkpqirwpzmiwidrl47rcwd6@jexjzewkzjgk>
References: <20240208-bus_cleanup-mhi-v1-1-ee80f4e71845@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208-bus_cleanup-mhi-v1-1-ee80f4e71845@marliere.net>

Sorry, please disregard this one. I'll send a series that includes it
instead.

Thanks,
-	Ricardo.



