Return-Path: <linux-kernel+bounces-67449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92939856BAC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32E311F21635
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E8E1384A4;
	Thu, 15 Feb 2024 17:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVkBuLMa"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08351339BB;
	Thu, 15 Feb 2024 17:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708019718; cv=none; b=WfXdDQgRa1gM4HuftEO+1IiX0/xb/LDaadyS00x16h2kjSvXaNm2TMvjc8GIdGrZ/PSvXdF8KSLd9IkRDpXx3TmI+NYGcQ1b9PTCehuFppqml3fcYDa3aQzJMjwTchjKOlJo3FTw7cwFM/VnT6pYpYkBz953gkB9HQwC7knGzs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708019718; c=relaxed/simple;
	bh=8Gjq54/KVDNpE5LXGa07GYFfTr25uhs+rBcl8YIUp60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nx28JTkcr/1+MTM/wnKzEDe5xb47IEeaVCKV132vAdZcHMmXCORenAfYLLvdF1o2WSurdtfpYQnrlJms2iC2LVETtRdLJOkqnd+Yydv8et9l4rI6f0PAq8QVK+9ABlM7k/snZLDYOwK9LGke6/q4og03WuMlON128FAeceXhOf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JVkBuLMa; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d746856d85so9714285ad.0;
        Thu, 15 Feb 2024 09:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708019716; x=1708624516; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aRTqb0Ggpo7RC4dP7ylLp6mZ/MLBFgTnFZagtyCC8BA=;
        b=JVkBuLMasgkaIgwPaZl+cQbogIr7n4gV8nMUvfMwOGXVkC3s7/13LudT2Nlo7H+bqI
         HxeMhY4JDLiwVqQSINrxWi9Z5RDnIB66vcyAaxV8T4N+n0kvX2/8gz2q64B/yknFRXXe
         BjPi0nWItmaGaFRy2KHzGEDQYWQNH5aNnoF2DVQjbC36zys8jCge8k7PqxO/EtEaG+vz
         c6akxsVmcEtz9crpo9UK8g+p1vgG0REvc28E/q2oFLxYA6UsrDItYOabOLj6p4kot68g
         ENmksQleqZyrHxf9dmfsoBGNe467CXqQGk8C0xTVkgjtirJR1kha3w+JunGX2BXAeH/i
         /3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708019716; x=1708624516;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aRTqb0Ggpo7RC4dP7ylLp6mZ/MLBFgTnFZagtyCC8BA=;
        b=YgPQNTifQN7MdjGjtuHWYtRvmaxEyXaoFdmrpD4N3xNAv1tJl7wSmkqEgEES/5bocD
         3Eg48O7oSlayKpbqKuB8gjCKzW/93MUQUqiyOJ3EBUa224EMyZnWlipkqlZXDfTO1h84
         8pW6BWO62Dr5gTTSGWZSMyrjpPMgCa+H1aD/tScZcYV86uskB7OCDt2FgLpYfu+hnFqm
         lJzfGDGFB90bqQEDKXEgiS8IOt0TyV91/4cCundxXNnt7jPoO2fyZck/yr6p9yO8wa64
         s1Z6LTBcxPEIxdiZmSKpXXvJVY6Zns85qAeYnBQUJfaqC7h0qjV7ReDifXA/FLfcu00q
         QM9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUvZt4XGx1iFYKGBgbAM2PjsyS3M7Pw0IAdffES9mpH1ZoaDMbxOu5kHTwO+9eq0ylij+EhPZIRdKaSdMK12wcN+qRsV9C9mwF49sTrINtvI+ab6iEk8Dq/g1aO5jaNnh4JzICxl+UFgfw=
X-Gm-Message-State: AOJu0YxOpIQOEOAMsWzaeydkenWGSE10Hgbk7kmqA9U6gJb3lb5RTfmd
	Q2qbJfVASiykADZR/tpwHA0iYxPQeUK6tu4Q9rFrGotEMNd5fH+b
X-Google-Smtp-Source: AGHT+IHkcu2NmxkP+LLoew1G9Zvv/nJA8uVfzjanwrBTkokv7aziZzIf49UZa7rfO+W/DNkU5Ivazw==
X-Received: by 2002:a17:90b:3784:b0:296:37f0:ef48 with SMTP id mz4-20020a17090b378400b0029637f0ef48mr2164571pjb.49.1708019715677;
        Thu, 15 Feb 2024 09:55:15 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:9b0:e6e9:5af8:ac53])
        by smtp.gmail.com with ESMTPSA id p7-20020a17090a348700b002992f49922csm46266pjb.25.2024.02.15.09.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 09:55:15 -0800 (PST)
Date: Thu, 15 Feb 2024 09:55:12 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Benjamin Bara <benjamin.bara@skidata.com>,
	Richard Leitner <richard.leitner@linux.dev>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] input: touchcreen: tsc2007: make interrupt
 optional
Message-ID: <Zc5QANGhS8EPvgEy@google.com>
References: <20240210175530.137361-1-clamor95@gmail.com>
 <20240210175530.137361-2-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240210175530.137361-2-clamor95@gmail.com>

Hi Svyatoslav,

On Sat, Feb 10, 2024 at 07:55:30PM +0200, Svyatoslav Ryhel wrote:
> In case tsc2007 is used as an ADC sensor there will be no interrupt
> provided at all, so set up an interrupt only if one is present and
> remove associated warning.

If we want to do this, we should better handle the input device portion
of the driver. We have 2 options:

- switch the input device into polling mode when interrupt is absent
- do not create input device

Those do not need to be mutually exclusive (i.e. we could use absence of
both device tree interrupt property as well as lack of poll-interval
property to suppress creation of the input device and only leave iio.

Thanks.

-- 
Dmitry

