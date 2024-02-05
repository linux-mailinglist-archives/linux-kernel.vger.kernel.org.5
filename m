Return-Path: <linux-kernel+bounces-52558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 832188499AC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 367B91F2718E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1A61C298;
	Mon,  5 Feb 2024 12:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="k2aoDXdR"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5816200BA
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 12:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707134733; cv=none; b=oAW1Rzuj6e/u0Hm1ELJjaRU/5pBZ9NBTmY9T5Ux+w4liQmGL3AB+w0AysZZNPAnZQsLa0cjvtD8e4b8jrPFvzacz9dUjoEnQmD+w/aFv2lKU7HW6VBuN2wwctjw6hcURoseI9BWCWdj7fMpsPe/UOq9MvTZ7Snn29ufIildDa0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707134733; c=relaxed/simple;
	bh=X1duw1mS6JjQGddQSOLFB42PLLgbnopdVgbbue+brlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A3MOYsATrrs3ksg0/wwsZvburhXLP2q7Uw7dgyAOgcKBesVktlp853tVhjSuKI817ZgwfLuSQPSHmlecfoTncDM7694LApdxG4Efxgzq+VFtnTU/reWGe0MIwPXhROA9yvasJ+DHVYz/uf+iv3Lk9g/3f7EqKP2xDQ3y6tpIZZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=k2aoDXdR reason="key not found in DNS"; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d7858a469aso30881805ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 04:05:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707134731; x=1707739531;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from
         :dkim-signature:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A3KIw4nh0ZlsNY+qMf2ryaKB83r+kLjyKzsK4TQemXc=;
        b=UOY/WH01M843O5dDU76c9ooLOngThZSEZjF9LWv0cfbEfYirkmhtfe0veF+VfmCQik
         8le/Hhc2ti7sScReQLYLMvk278pzyr3zQjkA4pZ2BLyA1vST2C2qy/85PIiphCY+kwhI
         b62KX6j4W5MeyNVGAgWmyKr3mOARdrawWlpnhGdqbNwoXG5HiKLTRuLalfHeDsbbxwCu
         hL1j/2V/nsv3gAhmCgcgo/rKP/2vdSD9+YFuiHIfoQcfXBXy7h/BENWFuNNCtLtBfoT+
         xnQiLvMJU3yQW/cmhlinOC5N6+qAsmUaeZb67ykWusEHDYYQEoRE83yQ3V5H4Jgb8eSI
         zdjA==
X-Gm-Message-State: AOJu0YwFCHunGj73+StnX4h/mffKU9OoQB9hMyJUxm1kry0wLmwdQnrt
	8vdDcHanU7Db5/SAdWTosK1ZzXR4okeeiJe1loag1cvwYUM2lg+C
X-Google-Smtp-Source: AGHT+IH/MR+Xb+PE+qG3lboszaOkHFGeODIFJyO2o1NobN/54wtfQ4lB7cgA6WQ7uxWEu+uehR5OHQ==
X-Received: by 2002:a17:902:ce8c:b0:1d9:ad4e:55fb with SMTP id f12-20020a170902ce8c00b001d9ad4e55fbmr3836834plg.13.1707134730899;
        Mon, 05 Feb 2024 04:05:30 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXf8XAuLXTZ/JoFsR7pcdtFH9TpFX+eiJfo7200KDoHTASzOWzG3Y9AxYQxAzjrgXyAz7KTKkQtisNSQP+s4eGw2UCq51TxOfdmBWAMR1U5a06iqNaHyOm+F0zlXF5tZ8iL/70BQzDV1Qrifw1fgB6pjdJ1YVbXZ5QQJKCkcIg1
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id lh4-20020a170903290400b001d8ecf5ff6csm6206117plb.147.2024.02.05.04.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 04:05:30 -0800 (PST)
Date: Mon, 5 Feb 2024 09:05:57 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1707134728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A3KIw4nh0ZlsNY+qMf2ryaKB83r+kLjyKzsK4TQemXc=;
	b=k2aoDXdRd6xbec9NNJoScy9F6yMhw1iKs+Ab8pnYQJ99SrNax9mSGhtWAE0UKkXHHHWt+w
	7HHvjfDKNXMzbV+Qu3Vh0SJJdaSUTo2682HlQDziAr7xbtoIDPGk6zOHAOkatqsZrPsQNY
	ydydnNXfOi1zDjf3VuGxCMB7AQHpC6BUZ1xqzQVKtngf+CZl6BHGVi1vDORP+6UmHKyWTd
	x3SFpap9FlM2VBjmrZojBcsgvupCAKu86mTTVq3b74UmnWpo+xbv0D63xxwmWRP6c65E5F
	1zSCnfhIIsbKgU8sJYtgXosD3/b+jE0aMucQYzeDQJx40J/QBAMZCdbf983Mvg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
From: "Ricardo B. Marliere" <ricardo@marliere.net>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thorsten Scherer <t.scherer@eckelmann.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] siox: make siox_bus_type const
Message-ID: <ysesefska42ctpibulegsfpuaxfr5innla35yrvi7de2llkcwl@dq5hppwwpsxl>
References: <20240204-bus_cleanup-siox-v2-1-3813a6a55dcc@marliere.net>
 <5zjixnsaylidn7t65thchwg5aa2igpwr34bmlfdtevvn4bgx2e@txzz36fi7rqz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5zjixnsaylidn7t65thchwg5aa2igpwr34bmlfdtevvn4bgx2e@txzz36fi7rqz>

On  5 Feb 10:03, Uwe Kleine-König wrote:
> Hello Ricardo,
> 
> On Sun, Feb 04, 2024 at 07:26:42PM -0300, Ricardo B. Marliere wrote:
> > Since commit d492cc2573a0 ("driver core: device.h: make struct bus_type
> > a const *"), the driver core can properly handle constant struct
> > bus_type. Move the siox_bus_type variable to be a constant structure as
> > well, placing it into read-only memory which can not be modified at
> > runtime.
> > 
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> 
> I currently have no setup to test this, but compilation is fine, and I
> don't expect any surprises.
> 
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> Thanks for your patch,
> Uwe
> 
> PS: b4 gave me:
> 
>   ✗ [PATCH v2] siox: make siox_bus_type const
>   ✗ No key: openpgp/ricardo@marliere.net
>   ✗ BADSIG: DKIM/marliere.net
> 
> when applying your patch. I didn't check the details of the DKIM issue. I
> quickly tried to find your pgp key, but failed (wks, kernel-pgpkeys
> repo, keyserver).

Thanks for the heads up, I'll go check what's wrong. I think I only
published the @gmail.com one.!

Best regards,
-	Ricardo.


> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-König            |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ |



