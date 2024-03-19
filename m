Return-Path: <linux-kernel+bounces-107105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E486F87F78C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84B45B23257
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792DC50A78;
	Tue, 19 Mar 2024 06:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K+fSXIPo"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015F380BF4
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 06:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710829996; cv=none; b=qudY/9WJULIpY9UpGCHj5DnofYSzOOUjw+8s6+oEfIjdnj/KGWt7cnz27m/EAi6TkhJHVTBbEbNfKooGUmTfPPnOsEg0zC2UQDeqA+FcB5nylSeGN0vUfnBRE+/7HXpp6CcFz/heIpdrEFnvE9a7GDsE1pnQEbkdwzjPyJEFbyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710829996; c=relaxed/simple;
	bh=emvB+UPk4wGVsjn2XtVyzPHEDiFnOm03YX66S20HkhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MYy99dqUyL2uvGdpWvNijN/BsiDXJ654hHZcdn9ESIPPoXjBFKzu17baSNj81tZkMBpF8CbmwDo8dmSb1SE4FC5H9p/7wgAmDeA6Lyjqq8n1LxOPwnHGJLWhR0lFID+gKIc4V1zMUpryU5F420Ttd6RSGCxLFttuSvpoKB0KFYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K+fSXIPo; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-513d212f818so6146534e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 23:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710829993; x=1711434793; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DQLjuETvXpykXhqUOpejSGf3kPj5baBzqZF6hMzvPVE=;
        b=K+fSXIPofMXhE+D1VC9CVIZ+GTPeAeO47c0IABKWvNBdGDYiUD0JB4Y2my1c2o2L2g
         ghWpPMVEYY0+nsp8FkfPjSH8cWp6AG2NdIix+kGBqVpjq5hxE5aSGEXuqRQuSmr8c5pE
         P1EYobquS9OITyncHRYAlBJ6ckDQgJYtbIi1YuSNNIT9VHRpJyLWt17hhhowBjktKPyT
         iqURSmPx0Tj+BsVie0qrwvBR0jgMyeQAMcWYmtr+rf3m9+E/VHp8pvjZyP2lEwoqax56
         6PUEgtOX34lqAeN7cXmI+XTh2/43leNRHG4wsppXZFYD/zOBEbD5uBSVWW+sqMtyHbFL
         lWbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710829993; x=1711434793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQLjuETvXpykXhqUOpejSGf3kPj5baBzqZF6hMzvPVE=;
        b=e7ZFGPeERzIxTSqUw698g6wdOKmNsLru08CL2Vplh/PbqsRB4QlexPJ9n0nUWN7eHP
         BewY3IJ2OgOOfMaH0D5HsjQRMUBUJ+k83eUrXDbPLg8gPehQZQF717+VN5HkMlbvAwrv
         GN9QBnEdJQ0VpsxZ7R/R4rFUSRi8kxs58+aAu+myBDVIXxNzHvkWMZLBZtt+IQiSI2Zl
         /0kdRnnrUEYINvFzuF2cuc1StF3nNLkR9qaxCqV+ZLglxZe/maJkXii01p4Q/l5bamlq
         WihI/OGLPyZo4vUTnXjF1XMCa8WyRjMnNMwBkYwiVo67QhKoBZrhRawkw0Oye7GuHjZi
         tzNg==
X-Forwarded-Encrypted: i=1; AJvYcCVllOe49qbe4RyiAXsmG37fFPSrJPctl6a1ED5X0PIDA6Q9guMjclzdg3z0FLlZ4KpkOQIV7kLZIo6URA1uARsg6eLC7PdehIR3oB4X
X-Gm-Message-State: AOJu0YwGlPD+5apxBhyWpXAwr+Yxo8p1Ip1TOFZ/ku6/P8d+w9670g9L
	fjTc1EKlQJUanMXjH2zeZntBiob8prK9J/gjVqPgL4JwCiKktyxl1NLozRF4K7g=
X-Google-Smtp-Source: AGHT+IEkLz+CrD7kd9e1OQIXrqk34kVS2kjJ6pk4f2Nu6yVG5PdTdGqBmLTHCPeZZsJythZHkYBwPA==
X-Received: by 2002:ac2:4da6:0:b0:511:674d:88c5 with SMTP id h6-20020ac24da6000000b00511674d88c5mr9820073lfe.13.1710829993013;
        Mon, 18 Mar 2024 23:33:13 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id o23-20020a05600c511700b00413fea18735sm14220565wms.13.2024.03.18.23.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 23:33:12 -0700 (PDT)
Date: Tue, 19 Mar 2024 09:33:08 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ayush Tiwari <ayushtiw0110@gmail.com>
Cc: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev, outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: rtl8712: Rename blnPending to bln_pending
Message-ID: <865b37f4-8139-4072-a320-855bfc3121f4@moroto.mountain>
References: <Zfiz7YFKAqAOGsu5@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zfiz7YFKAqAOGsu5@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>

On Tue, Mar 19, 2024 at 03:06:45AM +0530, Ayush Tiwari wrote:
> Rename blnPending to bln_pending in r8712_cmd_thread() to address
> checkpatch warning "Avoid Camelcase" and conform to the kernel coding
> style.
> 
> Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>
> ---

What does bln_ mean?  I suspect that b means byte and we don't allow
that sort of naming scheme.  But I don't know what ln means.  Also the
type should be bool and we change 1/0 to true/false.

regards,
dan carpenter


