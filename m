Return-Path: <linux-kernel+bounces-147645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 516468A76D0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB2D41F2149A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2107C6A008;
	Tue, 16 Apr 2024 21:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="athlweta"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147E06CDC0
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 21:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713303225; cv=none; b=IWpkCjX0+J+J/GiLJwg2N67klJsC6NTzKlMRedkxNjtafQQ1vgjCDmn3pzZ40pB9vlPJE62BSgpwGjWKewPAWj1/myjBecixI8L5i1cWV/xSi2aH1pBAop2n++wFEcP+Be0BiGSc2Z98gcBJwdRDl6hoIOcbfWhumFZniMkaUvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713303225; c=relaxed/simple;
	bh=u3DowmV9zYJ5szLDJu08b5Qs2/m2yOesB0guZPQwXQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nClS3wAx/jL5gO1LAYwQLiTxWORS2W9GPoeoPWtVsaABlFZZ1IWBqVossnU34Fc1JYjgPbTtEoCe/4RGtzMWoQUtfUvhB5ydjWL/jljJlO4PfrBJDLYWtCnr+cwGR6IOfJ86oOlk0Q4vvyHDzD7tjTA/avczWtmbcgxCWPQ0Vik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=athlweta; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6ece8991654so4422314b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 14:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713303223; x=1713908023; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Jd1FtdXQgkwapwAn9zLvYDMY6yjWASe0bHDCwK7dX4=;
        b=athlwetaCy0DOc9uyvFUlVkoyHVfzJD4ukzpPAq8UJERpMI6zcXsz8Bt19oQcUSOOf
         5FF0NuZrOV0GgxRQ0CfsaCSCCYSlTpH/+Lq33JMmLVpdFbyNtTKJZ4MhNhnLDuEEDPxN
         MqcPrFUYyBW92ZgJo9eAXUcqnbaFj+CSphusfslfRVBqGv+2nmQXfw1rQhDdw4bc4N+w
         OExQR2FA2MvKyYemmHenaCbhMZEz85MBZ1QQ2qzg9U6PCsU8oRwlppwCFig2miiXeZ/8
         slbqOfRVvOGzkMoZutivisdyoGc0Vb11jZs1D48ypZGg3n0/EcVeItcs3B4nKG1ckd8l
         Fmdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713303223; x=1713908023;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Jd1FtdXQgkwapwAn9zLvYDMY6yjWASe0bHDCwK7dX4=;
        b=r3QknsQXfZG0wnwusw2DL6yOvM7THuS6t4x4Y5N3TlrEPQ2baz3mfyzbvaM3qzK7x8
         IYkdoz3liOZwQRtoeYIV18vZgNalIjLDSIMCGiEthWQsg1p7Id6SUltxL9fT7fqz+KtH
         DqIDOmjNkzCwEpHhHjklQw5Ec1+3vUhoQDIXGb9+L81kSOFyyJOmHRliUlFX5pU56z1M
         9kpGi6pDLDEpjRJhgtzIu8QDf7i4Jx/2nPcoCeoOZ6SUzuhIWd2n1jZ41uLTKKKFrkvJ
         mMG780gsneOSUs4StZdVVEuDnJZzzDxeDlJcg9/YXDGkPLZVG3tIaqtKnjK6SkexkLst
         ainQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUGlSKY2AlNYgXtl7oPFgB0feqm5+kJDOh+d6N1I5/872CcxIFMwyyUWEmsB9lju4ocnNKWI+13cfSbKM75z5020YR5VK3OtJsamVy
X-Gm-Message-State: AOJu0YwB7fuvLYnFECNPbTwl51494dlJ0hcMQOdMcn1guz2g8dlNNW3w
	6HNTqaPG7t+LVYNG6VKif6w0Pc1N666H8Fc8i+zCjZHQhQUP0Mcm
X-Google-Smtp-Source: AGHT+IF86Bz9MOMVMehfbMOJLW7LVMuJ2ESkiFbW9e9lzOmIvd7XMUobB7TEpyOW7UbyfyXxBCzBGg==
X-Received: by 2002:a05:6a20:96d0:b0:1a7:8b88:96b3 with SMTP id hq16-20020a056a2096d000b001a78b8896b3mr17091757pzc.9.1713303223204;
        Tue, 16 Apr 2024 14:33:43 -0700 (PDT)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id gb10-20020a056a00628a00b006e6ae26625asm9436300pfb.68.2024.04.16.14.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 14:33:42 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 16 Apr 2024 11:33:41 -1000
From: Tejun Heo <tj@kernel.org>
To: Li zeming <zeming@nfschina.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernfs: mount: =?utf-8?Q?Remov?=
 =?utf-8?B?ZSB1bm5lY2Vzc2FyeSDigJhOVUxM4oCZ?= values from knparent
Message-ID: <Zh7utYkkkvJpzVWX@slm.duckdns.org>
References: <20240415102009.9926-1-zeming@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415102009.9926-1-zeming@nfschina.com>

On Mon, Apr 15, 2024 at 06:20:09PM +0800, Li zeming wrote:
> knparent is assigned first, so it does not need to initialize the
> assignment.
> 
> Signed-off-by: Li zeming <zeming@nfschina.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

