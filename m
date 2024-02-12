Return-Path: <linux-kernel+bounces-61438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D43A5851255
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12E111C2144D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9589C3984A;
	Mon, 12 Feb 2024 11:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="FFR+E5OW"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823D517BBF;
	Mon, 12 Feb 2024 11:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707737679; cv=none; b=YAZYOXM6yM2WA6lLvjLdmFKJGcMXU5/iSJdEqAQuWZqri/+W8A1a+9Ei/jIK92YslYScW13tXAJ5L8lHVZIa3Mc7sXYEGoMdTXfDYdQzQQIlsxg9/wlUW05aQpx6eA1NFoLJ3G6MZVO7HOObrk9bLJCV5FfLEpaKMXsrn1hq24w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707737679; c=relaxed/simple;
	bh=+XJ4iIEBqUjS9rfMfrR/tT09YLEg7EFIO91ieWhj9s8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a7ZTwFe5BAuZJfibktgWDqEw1wI+mJD2QdHpuLcExvvJbTmXqSGGUNlcsdeEXHyKnDhQ7O1T/Y6+ON55oz9PEhgldakzAxdC6YFhg723GZ+MdDqNFNwwOdifx4bYmJ37FOc9Gzrlnd1dItpB5y/dPAL5G1uWiAHn1B8GeM5639o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=FFR+E5OW; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-296c2b74448so1639963a91.0;
        Mon, 12 Feb 2024 03:34:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707737678; x=1708342478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:dkim-signature:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BHr+sPH30ZpkHimGFKF7fIzLaf2Wa3xLSn4lodorOgw=;
        b=tTTtMhhNq27+NuYgqUgb3YGRVF1gi+Kb7yWGCeKFCC0c1mIbHNG4R98qnplde9+qyU
         q/YUZUK9xaWxUwhL5DokW+TdgFPHUqHRCUlciK1a+n4cuSZEowWUsOzRjpXGekwLom9D
         NQBa2Mo45aJO8l62mFfMqMNUaf4MwBx7G6WcHIvMQvr/YaN0QnxSeRjo8wk/tbwzHitM
         Dpz9v3qm4SUKVw0XY+khqU9xFipN9TP5s7sbNR9DSPcnxIqFJNuI0/xMQ4vEmfP7fP8C
         eOD4i7F8JlKFStMHve0j8wtHXrBC5CoOIMHeNwZc4whUIR5g3UnPeKqlK1CKjctBDLYk
         S92A==
X-Gm-Message-State: AOJu0YxZCWAhH3owuv0j+EbbsicjwjRvzhd7jauPy72TVfA3YRaPRGBp
	dsF+w4BE50izb3KXwgJ4+j9OjR3DRexvOWEuW0tNihgVzUK3SeYT
X-Google-Smtp-Source: AGHT+IFcjned3aWW/71vRpIDv7m9xHgfCWh/1Ov0arnczjWZg6K6wB+0NhXNLJuOurjb+ZV3qlHvbA==
X-Received: by 2002:a17:90b:46d0:b0:296:4844:78c6 with SMTP id jx16-20020a17090b46d000b00296484478c6mr3430412pjb.7.1707737677692;
        Mon, 12 Feb 2024 03:34:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU8QIS3ziUbJTb8bKdmsCVLE205UIedoiM1HGzjM9xTY/i+1ddrqPG/Piud8QKM6tpHPF5/4DvOMsOsN93lOHagtRxhTUm2dxFQl1LVn5bx3ALpN5qSd/KC8+KpC1Uszeyn2H2olwi6b0RUUHSRSZMXdZ5uuEOBUZRwdSJx+rfmDT9rEhqYf3oxxAFYS9pXuMwQT5hLWvG0PTtTo3d6zsbw39b7xqofdiLArrrEMxpXuzlygIGZCg7DHxMvAZV/uWM4SCWOmPp1lA==
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id si13-20020a17090b528d00b002966dbf4d82sm280483pjb.26.2024.02.12.03.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 03:34:37 -0800 (PST)
Date: Mon, 12 Feb 2024 08:35:14 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1707737675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BHr+sPH30ZpkHimGFKF7fIzLaf2Wa3xLSn4lodorOgw=;
	b=FFR+E5OW3S7ddXw51MjoaPzs6rMzW4/KHlLaYM39+n1mnT0qQmubbjjDPiZ4kuhwa4ebeu
	XKJPLxxq5XNoQwFiSkZnWI289npTov7fC9W32cZehWQkHPaImG0TpGf3tI7P5y3HXx24zT
	uputgzAv5TfqgRWNNzZ1dFykWXjv6aUVgG39uvJSp+QmrRVofW8PhkT+YkzXF7Qnw3tkDv
	+X2lQYR4tUUYnGYuOBEmHvoV/9SSrklCFNmCZlwFvqAjzG0UylDeZm3ggqT4oY6UayCDGA
	I0qCBSw4W1baEZeSYJtq44aZ8+rUh14jcMWIqNRA/RraaeFds5lHb90uHcN0PA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
From: "Ricardo B. Marliere" <ricardo@marliere.net>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, 
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] ARM: s3c64xx: make s3c6410_subsys const
Message-ID: <2ezdr4px2tfzpn7ut63wdtmcb2roid4d6kpl654wwmfvkemhpq@k5hpjz74q4ho>
References: <20240211-bus_cleanup-arm-v2-1-3de9e8af7cbd@marliere.net>
 <b7726526-0b0a-4d3d-bf05-b1065d361cc2@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7726526-0b0a-4d3d-bf05-b1065d361cc2@linaro.org>

Hi Krzysztof,

On 12 Feb 08:31, Krzysztof Kozlowski wrote:
> On 11/02/2024 16:57, Ricardo B. Marliere wrote:
> > Since commit d492cc2573a0 ("driver core: device.h: make struct bus_type
> > a const *"), the driver core can properly handle constant struct
> > bus_type, move the s3c6410_subsys variable to be a constant structure as
> > well, placing it into read-only memory which can not be modified at
> > runtime.
> > 
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> > ---
> 
> I just noticed you sent quite the same change for the same subarch.
> Please perform changes all at once. Squashed.

Yes, sorry about that. The reason for this is that I initially started
splitting up this commit into proper submissions:

https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/commit/?h=bus_cleanup&id=26105f537f0c60eacfeb430abd2e05d7ddcdd8aa

And only after that I started grepping the tree for the other users.

> 
> Best regards,
> Krzysztof
> 

