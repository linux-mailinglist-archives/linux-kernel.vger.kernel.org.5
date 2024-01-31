Return-Path: <linux-kernel+bounces-46983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4C7844770
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 19:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8C9628B3A6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEAB1EB37;
	Wed, 31 Jan 2024 18:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKBlKuxr"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689B61805F;
	Wed, 31 Jan 2024 18:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706726913; cv=none; b=T+jPed8ooykmDfBtEfqTwVYW0gBnwkK8dedATG/OIcL22L8mpQffq8UqI8yJuUxQGdh/EA7RSYEnLS5ZGJ223oQO10dMTkq/DiD0aFb8OBRXm5w7Z/nLyaAHefjkPql8yn/wl8aFIA5DylUCUo+NdgX2Hq863JqcYL0z7bs9Z44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706726913; c=relaxed/simple;
	bh=RFMdXct/WeF2HdVsAl1NpYcuQkoBVNHNuM4QUPQVh54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IBKxyu6QNZFj0oQM2FvS/eqQAb/9j7p21jg1a3qnxEP/3Owkp3m7AeJNo3iBfmNMxcdJmjhLpzacxbQQ1+PAelL9I1W32EHptzi/Z5K/ivIFDyQ1CtVT5fNtPALZh0UH5XDzFdwUeohsgFsYC2y7pnkW5p//wCJ7Gq1AUc/ftL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jKBlKuxr; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6ddfb0dac4dso34182b3a.1;
        Wed, 31 Jan 2024 10:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706726911; x=1707331711; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/7EvC4Sv0z/qUL75PLLhhMsn+h7NJhI8P8qFIiHbguc=;
        b=jKBlKuxr7bxwI+iAY1gVGCXg11/r26AUajESpw9fjXJ3UuBqhNWwW71ZHSuKFbN3iD
         2i8Nc3DU2/xwU5iaHqyvEzbn47iAjfodXgdLSVUu+LTm9bLzUz0AH96dEoq3bpMAn9/t
         UbcFK1ODS52eTV/3+fMGarF766HoVH6ii0wa6/wi32DFp2GB/OMdtZGkXKMVcKMYpjNd
         2OL2yYXqcFqGAFEM2btw2aoQdOLNM10JOWhda2X/cwoJFRV2czI0C26YzN9gilpx7biF
         xd+4cmUOnvXFY4FOYlktT3JHdAeL9IntUUabQ0Y7w1CtgzAiqTSht/AMhTvJd5S0crEB
         /qRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706726911; x=1707331711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/7EvC4Sv0z/qUL75PLLhhMsn+h7NJhI8P8qFIiHbguc=;
        b=VpWFQ7/nQK76VwoG87eJm6cB7MgqdVzQutaISSB5gULPpBuu5lyAjkP9FLS9yLYdZh
         fHOJOHErbGKjtXjKGgd9JLwfsNoVgY/U5F7w5Xnw1EocB44JNSC2dN4irGh4CNu1VIF7
         escwdWd8iyEor2Td3Wp/DlpcN2PT0QRXl/Z7TToRH1pFxrAhWLwG9hcbLy92cRlO60AV
         70U+rK+ET02uvwwGVWlQxg2IbbXWBo9DKfmm4YD8XzOXcK5bYxOq3gOGLnWWIiBlHwB2
         gMFHxDi9FI6iF354kjWkKI0LDkFfx7M+eMGLigv0fEIgSewHu1JNbiceoazd3BaVuE4W
         h1MQ==
X-Gm-Message-State: AOJu0YwYht0zwWvt8fWiX5h+z2s61NofMPOVRo20pzVIL9q1jCqFivDG
	zXDmCGKozGZSTXK9NClOLmdv+6OEty1lJ4dPqPWletJNietv+13H
X-Google-Smtp-Source: AGHT+IEwat+pYEQ8x/QzV9uAlx8DvMe1jJNSEg1K+ttTZrWzYk4523pBbpf0F2UjZqjfKd5hi8aGdg==
X-Received: by 2002:a62:ab12:0:b0:6dd:a11a:602b with SMTP id p18-20020a62ab12000000b006dda11a602bmr2358369pff.10.1706726911417;
        Wed, 31 Jan 2024 10:48:31 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:955e:133f:54ba:f642])
        by smtp.gmail.com with ESMTPSA id i1-20020a056a00004100b006d0a29ad0aasm10197409pfk.5.2024.01.31.10.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 10:48:31 -0800 (PST)
Date: Wed, 31 Jan 2024 10:48:28 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: linux-input@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Input: matrix_keypad - avoid repeatedly converting
 GPIO to IRQ
Message-ID: <ZbqV_EqBqppL5pNF@google.com>
References: <20240121053232.276968-1-dmitry.torokhov@gmail.com>
 <CACMJSetrYPaXOr5abHtP1mjsyH3nB3=6CwxWfviN1BP0rhgEhg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACMJSetrYPaXOr5abHtP1mjsyH3nB3=6CwxWfviN1BP0rhgEhg@mail.gmail.com>

On Mon, Jan 22, 2024 at 09:19:56AM +0100, Bartosz Golaszewski wrote:
> On Sun, 21 Jan 2024 at 06:32, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> >
> > gpio_to_irq() is getting more expensive and may require sleeping.
> 
> This is no longer true, the relevant commit was reverted and I have
> now a working series where I'm using SRCU for lockless list traversal
> so if anything it will actually become cheaper.
> 
> > Convert row GPIOs to interrupt numbers once in probe() and use
> > this information when the driver needs to enable or disable given
> > interrupt line.
> 
> That being said, I'm not against this change, though this may not be
> very useful after all.

OK, then I'll tone down the patch description and apply.

Thanks.

-- 
Dmitry

