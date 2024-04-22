Return-Path: <linux-kernel+bounces-153146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEE98ACA32
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9F4A1F22D9E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C55612D3;
	Mon, 22 Apr 2024 10:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u0HotfNE"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E40113C3CA
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 10:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713780367; cv=none; b=ifImTlozp63iTfVdf89kIwhMWj/JftZ6bxxWyBBXBB7omESgQL06CAUcYkZ2ihKkyJ7FNFe+Pdofgryg2+LM8DcNE3nLxuwDhah8d9/N8ZKb5cTKHtYztJ61gAdhaxRM0rAMTaDn3eAzk+5f9ga5z38qbqhjjyIRdwMsNJxPPd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713780367; c=relaxed/simple;
	bh=bL2hSvdJUbEjiVu8mOzngLcfDSFc2sqN+pYwEXjIoRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dhsm6wtAfYXEV88MmreuNGv0Cy62ZMwq+0N2HtwZ1y1g9TJPQGCS1bAkiNGBDWCAWXBuUYR0w9+OFJr2vgn0RYYAReqk331eQdKcYXDz4eo0QPxr94cmZDWKvaHlvJhW/ULKEDf9m17LHMsOv0OlKtklvF6K1CzGu3UoowJgkvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u0HotfNE; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5aa3f0fcd46so2564716eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 03:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713780364; x=1714385164; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Pp9lUQ4HZ5PgJGPmf9IQ95ImHEOQFdQIgczUTfI1TFI=;
        b=u0HotfNEzSISiyO9rtcg9IMvD2AtAwPquxNa0gaCu+VEpQfh6LFtCsS6MuQ0iNqEIj
         8EMRrjwljGu0avUC76OW+0jdg8endhqeaoJXGLa4xo+RsIubY65+Z43iCHosG2KbHI9q
         r9+DMGRdnHsuv88L4olNVnfGnexO9yTRa8ZIlmPrAfMJouw6pSmwzCqnSczoeEa094Vh
         dX5tnK9qXID3lQlsAkMn1KRsVUYEN8R+hIEB7cmL7FkhhnOzGbsdUIA7XQZ3DTewqgHI
         n7D3bHLyxMuepgIot7ooTXLjAfBIs2p3MWJQVVZW9dseLj6DRspMApAfDY4DM87qbKeC
         pALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713780364; x=1714385164;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pp9lUQ4HZ5PgJGPmf9IQ95ImHEOQFdQIgczUTfI1TFI=;
        b=ON+RMxwhtlbIO0KlcusaPgcELpndLr4C1m6YeNJOrVWoo7KINIdRhLAQ/ZeLACFQSP
         +5Sl8ot3qHkYLSbl/1Fb3mzkhakpVCnkbgj/vvv7Qb4tOzsMUb78KoeapAavJ5VNzeSL
         AANwVFauWPVrlZNyj4iwxvIHZ4++q2ZlEOKFKDADuSaCUdo3L/3sLSN2efkA66yuS0JR
         XFiNeNBgxxAGTFHOl+tI48ETTu3TgJvHeo6YPNyC7bdEaVLyIZu4lMebdKGbsV2P9xoO
         LvrZvLb3tmeznbIz2l95L/6/SkjYJ5OK1iawNlhPy2K4mwMr0Nmw7Z7FDx9ZxXzjsdXU
         AkSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnKh5eF6SvCOfEkThEbBRLt+mpPCrWaUGtsgPeMXuZpjOI/j6rZhdkWMp0haV/NRs7Gi6CsEHwxus4wvdqwIhT3sTvQftzzn1q0HCs
X-Gm-Message-State: AOJu0YyfR5C+VaRZ7b+2dIWaRcsEctSlp58tzmyrxG7PBUHlXGkaZ+Y6
	kEYC19admUv4cJhsBhZkJ7LCNy9zumJNQH6+ljUAJ9Y+Qo2xM+V86qMkNEZrEOXaIqlJ5a+FuY2
	nWLpnEAUOX4n3JrxXWI7P/WBbtd5Yu/aqSKbl4g==
X-Google-Smtp-Source: AGHT+IH2cO2rZIY+HwOOnVAFVGLIKgIBh5VFjqWuGGTbO6sx2Y1eZMlp8KcjvsVT5MV0EfKhJfiXJpIcIBTuwaWiisY=
X-Received: by 2002:a05:6359:4287:b0:183:dda6:4470 with SMTP id
 kp7-20020a056359428700b00183dda64470mr6527469rwb.12.1713780364561; Mon, 22
 Apr 2024 03:06:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405060826.2521-1-jirislaby@kernel.org> <20240405060826.2521-13-jirislaby@kernel.org>
 <CGME20240415125847eucas1p2bc180c35f40f9c490c713679871af9ae@eucas1p2.samsung.com>
 <91ac609b-0fae-4856-a2a6-636908d7ad3c@samsung.com> <d70049d5-d0fe-465f-a558-45b6785f6014@kernel.org>
 <Zh-fgtujwjiSXz7D@monster> <c091da0b-a150-428a-bf96-75f9f3eab2e2@samsung.com>
 <CADYN=9LCJS0SW4PuF+e356HUxhzJYi093K6U+BdErPohq4RDWQ@mail.gmail.com> <6ef3422c-d931-4993-856d-c080b11d72d5@kernel.org>
In-Reply-To: <6ef3422c-d931-4993-856d-c080b11d72d5@kernel.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Mon, 22 Apr 2024 12:05:53 +0200
Message-ID: <CADYN=9LtODPtcFiuZ_Zv5O9M4S1+pAYJD8Fu8r5__67bPK98RA@mail.gmail.com>
Subject: Re: [PATCH 12/15] tty: serial: switch from circ_buf to kfifo
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, gregkh@linuxfoundation.org, 
	linux-amlogic@lists.infradead.org, 
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Apr 2024 at 08:45, Jiri Slaby <jirislaby@kernel.org> wrote:
>
> On 17. 04. 24, 13:19, Anders Roxell wrote:
> >> I'm trying to run on two dragonboard devices db410c and db845c and both
> >>> fails to boot see the boot failure from db845c [1], linux-next tag: next-20240415.
> >>> I tried to apply the patch [2] (that you proposed in this thread) ontop of next-20240415. However, that didn't
> >>> help bootlog on db845c [3].
> >>
> >> This is a different issue, which I've reported 2 days ago. See the
> >> following thread:
> >>
> >> https://lore.kernel.org/all/d3eb9f21-f3e1-43ec-bf41-984c6aa5cfc8@samsung.com/
> >
> > Oh ok, I did the bisection on db845v, and that led me to this
> > patch 1788cf6a91d9 ("tty: serial: switch from circ_buf to kfifo")
>
> Could you re-test with the today's -next?

Tested todays next and it boots fine.

Tested-by: Anders Roxell <anders.roxell@linaro.org>

Cheers,
Anders

>
> In particular, with this commit:
> commit f70f95b485d78838ad28dbec804b986d11ad7bb0
> Author: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Date:   Fri Apr 19 10:09:31 2024 +0200
>
>      serial: msm: check dma_map_sg() return value properly
>
>
> thanks,
> --
> js
> suse labs
>

