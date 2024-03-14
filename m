Return-Path: <linux-kernel+bounces-102934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7DA87B89D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 08:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7AD9283EE2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE285C8EE;
	Thu, 14 Mar 2024 07:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JfYd2IHy"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FDB372
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 07:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710401858; cv=none; b=Msj0SX8Myitj2GUdE53Jhbp+be+5vWL2icZhc9SLCEQiMj9MJw7ZThalIJ7WccAxD/CXBUsccSv/yVJ9Pfl0B8G5PUoX+gkJZNiltt18S6Zbx0DaSnj7z8u/aB9chhPh8ifiYb/FqwisSNq3J5y/5d8ZXzEsph2nt7E+pymJZOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710401858; c=relaxed/simple;
	bh=h/noaULKqc6hSe5tg/b8NBkZtRpoPLoFI5/seEtHSUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IstheTfaSlqQVRxl0stiyqREL0fa7HEjaQ7xt+LpzD/SgYp0+1Sqrc91zEXP9lS4G9YGf025/uoAo/dYvcVUfrBG2G3kVkX8fxIWWQWNo2LMBRranJ8evoYoyu+ynz3fSaxDrZX0xJrAE20YcfTKCstRVYWPA6uCeQ9Xifjng64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JfYd2IHy; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-413f2fcd8e1so1110765e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 00:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710401855; x=1711006655; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g2xMEgErE0oZaNn60SyZkOBivkFZHVII//dNP0p/AvA=;
        b=JfYd2IHy3vIXKugaITlOyAxJ4G6/dG/V/AajhCfKukXeXp54fuRgyzctbvvGZGZSRZ
         QFyzzupvIbtezefxGXPvTKVx5ff8GYUVL3h1IsBJ06E7DJ10DKUrK1+AyUqF58mIGbL9
         eIl/MYg7DmwslL1kG6oUOyXUq5sIDE1SCg0KvCJOw5YxwQeBSrezP0rlWT4Hnvmg6KHD
         GR+qcbSNpJxa1USExt2gG2QwWv/SBGKWcuEqokPjX+x6g7IyLlqMOMxXcOfwpyaP5cCH
         0xfXrg0LDgLs2lrj93nI96Cs5dEFrHevJffaskBmsRaUNBnfDOQ8I+jj8TZ05g2uitji
         r35Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710401855; x=1711006655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2xMEgErE0oZaNn60SyZkOBivkFZHVII//dNP0p/AvA=;
        b=i90HcTwpROc7+DC7nx4E5ILv+uS89gdxBpk/djNuSWQnhoKHmDSXOQoohOGyxWnPCa
         MUdbKw1HMWqMt7d/XkhIQY/cywU2G94tPv0DD63YDEZQMDHL5EuYfnG79ZhZhRyDzc1w
         9Y4Dw+EYyW3IKeCLKgU4uXRYnPbV2KxkAlXq029stgRtjQHizhBaUffnG6EDksqijv9c
         6eZEzmq0xk0JnGfpKphgZF5dMej9WK/e5p4t2zxsPL+tUQ5BSOyU99YWk5haoqQ0fh93
         /eaZMqTQ5HXHu2ZEEYWrWAuuQjrnZKn2MzhP9gNaF9D1jxc/bUs/Q78xpVq/Z4jTG73H
         Qeew==
X-Forwarded-Encrypted: i=1; AJvYcCUQif+qBgJjjeAEzprjYO84drXyb3TUklZG8XZN2xRADAQalhS7xyo53SmRVYQrDIxHqQeCQcYLzU7legrcilaa/qohnFck0My0wK1v
X-Gm-Message-State: AOJu0Yxe+I2QOSm6k939zItlU/ltksKqfUWq4N2NIF4nJQ3kU5vWlrc5
	3FTVE4be818WJWNO7wagRum9eb0B6Yfy3b8Gw/kN/+KWSipeOEXSaYSrx08rN9MVaeNw5u0XS7T
	s
X-Google-Smtp-Source: AGHT+IGqoG0yaFgrjuSXEyheErkxym5o4y1BxFNQO/f8KnR/q5sTXHRvaQm1Gon5B4sF618nxOd7UQ==
X-Received: by 2002:a05:600c:1994:b0:413:f2a1:c47b with SMTP id t20-20020a05600c199400b00413f2a1c47bmr489038wmq.16.1710401854633;
        Thu, 14 Mar 2024 00:37:34 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id je2-20020a05600c1f8200b004133072017csm4779037wmb.42.2024.03.14.00.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 00:37:34 -0700 (PDT)
Date: Thu, 14 Mar 2024 10:37:29 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Ayush Tiwari <ayushtiw0110@gmail.com>, Larry.Finger@lwfinger.net,
	florian.c.schilhabel@googlemail.com, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
	outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: greybus: add comment for mutex
Message-ID: <41239f06-596e-4c17-95ed-4bf06ba9f9ec@moroto.mountain>
References: <ZfHuokO3pQXMOxcC@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
 <ZfJhtBrsL3elRve8@aschofie-mobl2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfJhtBrsL3elRve8@aschofie-mobl2>

On Wed, Mar 13, 2024 at 07:32:20PM -0700, Alison Schofield wrote:
> On Wed, Mar 13, 2024 at 11:51:22PM +0530, Ayush Tiwari wrote:
> > This patch adds descriptive comment to mutex within the struct
> > gbaudio_codec_info to clarify its intended use and to address
> > checkpatch checks.
> 
> Hi Ayush-
> 
> You may be right, but you need to convince your patch reviewers
> why your comment accurately describes this mutex.
> 
> That's always the ask with this kind of patch.

Heh.  Yeah.  The comment wasn't right in this case.  The lock has
nothing to do with registers or register access.

> 
> BTW - Don't start your commit log with 'This patch...'.
> 

Outreachy folk are a more particular about some of this stuff than I am.
Which is fine.  Could you do me a favor though?  Could you ack patches
once you're happy with them?

regards,
dan carpenter


