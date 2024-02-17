Return-Path: <linux-kernel+bounces-69981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EB1859139
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 17:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C8BD1F22308
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 16:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3A77E0EC;
	Sat, 17 Feb 2024 16:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MjRBOOk1"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3FD7D40F;
	Sat, 17 Feb 2024 16:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708188922; cv=none; b=XSM+PgpP4TNlzEInKXvy8vuZhuc5EzRd6Z4paB4xZGutUqxAmHR4+hqKbrSWapPXzyRR5TwucabzICqOFs8gIacnIahymai3eq4ZGPqWHZoNDctQUh9EcLlaFvesn007MiSxgAPftDq9MXhGBUo3YECW2JnwSBWP6QCH7WRvdPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708188922; c=relaxed/simple;
	bh=8ebv9RjHbb+ATx+/pj6wfe0MacLYUX4hb804VnXVpeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dEPeF3n6edPCQz5lALDq11MlgcoTaFa23ri6AeQ6PzTgKBl57mL/cVkM487uO2ovM/2XKgZ2YkvJXWEW+UK24va6kPZjkWND8D6A5o8ly91ZE7J+WQoYgBuwnCEpFNRnxy0as0cmzh7r0xKIUhGPijcOiJGFMB8HeSDBUxdI1U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MjRBOOk1; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6e2f6c7e623so330162a34.1;
        Sat, 17 Feb 2024 08:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708188920; x=1708793720; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6N7H1dJxAdgtz17OJV7h2M/b32+Y0VMenOKk4p0Y73M=;
        b=MjRBOOk1SyjRJHuLMgabToRrfnSCyTLy1MpfS0nW5E12NVu+tbEYSF8mQ8MnPptGgq
         kJagE7BHVpvfK2ZHVgDs23B9OzGIhhpyWTxadzF+lA3hYdKVw1BpQ1KD39+LDP6GU+nI
         q48UAlu6wHXCXGZgcUZjYtv8o6tO2K2qRea8W7PaIddQPvTLC6JqVRqJmJ7d4KUEmqtb
         SnvzjtHY0kwW+j60VXre+sssf1IIJwvCgkszdKMm8+6N4MFp6QubYeAP2aUKaaHc0R08
         1BCSjayJUccSq1KDYuo//tlTTqxC/qOicyd0P07lg10qiOizPengQReDS99nipzafs7g
         kHbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708188920; x=1708793720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6N7H1dJxAdgtz17OJV7h2M/b32+Y0VMenOKk4p0Y73M=;
        b=iNBdTjHe64v+sBh9iCTXvdRllX0PoR6d/u+Lu8XmC9f4zadeA4dNdy0BcvDvwlup6q
         ynoOorRCW/+TYpKYqPgcG0LoPf9HeEBy/mJu0AEiZ0MHCt+OpdybRy47caluSmqqO3mi
         EfG5F0GYRUZsQTMz08ULu9YHacTV42GMcI+W15lRMWJEn+wZXtVrsV/NgVdGFuU6EEpb
         peMub4Eeu7mDQwy4SOqKFNBtdQxsdh3bedyW5J2T2oMWsUv6VhpwxcEKuGXbHJvtgeGT
         c4AAXGOqTxJLZED7CHUcp8PaKzjtNDmxojCF+U5C99mLqA2y/1/AQX20+fIgMNb1cl6n
         ii9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXNWWHm0UhA1ZbCBkLGvjj9wjCmu9jZcRVSR2sL2d+hxfC/O1eQ2/0qoEKzAbnk7fzsCqAf0ClNRyff44Ihf55SRK35FhUtnTGnhtMU2vBHSJ1ZDEDg9gxsCt/S6qFjQDA1TuUm
X-Gm-Message-State: AOJu0YziBmLUpyNC3w89xCls7N/ZeovenI1BKRmUIALmdQUHi755K0tL
	OTN7m/leOHqoasf5+8fCDzu4j9Rb4ZPX7yoXn6Oi2sIMeIijF+P/
X-Google-Smtp-Source: AGHT+IGbFFkZ2PWjmMxaXxYBlH/e83lIN7wTMd/FjXj5Co/BgIFwbdfXGResrmYNGntMpaORY52b2w==
X-Received: by 2002:a05:6359:4595:b0:178:686b:900e with SMTP id no21-20020a056359459500b00178686b900emr5562703rwb.3.1708188919682;
        Sat, 17 Feb 2024 08:55:19 -0800 (PST)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id i13-20020a25f20d000000b00dcc620f4139sm771059ybe.14.2024.02.17.08.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 08:55:19 -0800 (PST)
Date: Sat, 17 Feb 2024 08:55:16 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, sasha.neftin@intel.com,
	kurt@linutronix.de, anthony.l.nguyen@intel.com,
	jesse.brandeburg@intel.com, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [iwl-net v1 2/2] igb: Fix missing time sync events
Message-ID: <ZdDk9AHE8svlNbbl@hoboy.vegasvil.org>
References: <20240217010455.58258-1-vinicius.gomes@intel.com>
 <20240217010455.58258-3-vinicius.gomes@intel.com>
 <ZdDLI4o1Bll1xvH6@hoboy.vegasvil.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdDLI4o1Bll1xvH6@hoboy.vegasvil.org>

On Sat, Feb 17, 2024 at 07:05:07AM -0800, Richard Cochran wrote:

> Does setting ICR.Time_Sync[TXTS] also clear ICR.Time_Sync[RXTS] ?
> 
> That is what you seem to be saying.

Okay, so you really mean that if the _same_ bit becomes set between
the read and the acknowledgment, then that event will be missed,
right?

In that case, thank you for fixing this more than nine year old bug!

Acked-by: Richard Cochran <richardcochran@gmail.com>

 

