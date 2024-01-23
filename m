Return-Path: <linux-kernel+bounces-34832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0BD4838812
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 806D3282C0E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 07:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AEFB52F73;
	Tue, 23 Jan 2024 07:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IJbvyLwb"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4572B9C0
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 07:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705995529; cv=none; b=pRiNF0JuzAbl5MTIu9NGMkKXjzKlp9tj9SJ6r8IuRIq+gsxbAdFpJX+R8RIFKKIUfFlm8ZuoT4I0TqQnLWflX2x7U6DfVjUx61bGE8ha+dxFAgB8ykkN6oHZf0Skr+UoiU8klQ+Cb/egrd9uMXV2BIMTUoTt/R/kCbAAoFkBnxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705995529; c=relaxed/simple;
	bh=owfshLc2LGPZAA9/8wFtBBZyNyp2uwDVREAV32FmYEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HE4EfZFQKvx2EnzIIRnPZBYKk+qbE9u4IZjwH8Yrm40ry6ulPx88J5kjS4F3m9F0bZDN1NZqWXfV1aRcoNid2lpc/I/CJrSk09rajKo5eDlBuRsf7Qmf6EO5glkJxeNc30ev5WyH4xsYyFX6stIb03WPMGkOP3PZR24hkk/df08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IJbvyLwb; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-338aca547d9so3139379f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 23:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705995525; x=1706600325; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yETxiGG3CveSvMqCA4PglMWiCajZsQqRtEiheWi+x/Q=;
        b=IJbvyLwbmVn98GyTvo1X+xX79AE7S0Pia0h/VXfKRMA2r/i9K3fTr53k7rCvjkQPf2
         m8gE7fYAd9azIBWxuJRRePRFRtatR27gBQ5lL72kBBBm3a3dwYpI0D47eoRlPFAXoVGk
         5jcsJYBZ3Gj44rfnGNrYrx/cid2Nb+vhcL531mUhmvsBqckDBKp/3ppSZZosWels8CXw
         IpnkZpYTl00qGnLYlh0ko2wSod9WPNgsQ1YihhmF/WNrxVD4c62CCjNgI1gO5HMPcG9U
         mjKL4ayETDGdzj53c/aXTFoGRJf4unC6PG/T9DQy37wNJhIFGqtTvopCF3ULsmhMwS8M
         R1jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705995525; x=1706600325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yETxiGG3CveSvMqCA4PglMWiCajZsQqRtEiheWi+x/Q=;
        b=sxMBP9Dsxeu4YwxMEeW4pwQvKYnBAuAdKf9xuw9hyfZ/Teac0PLifxFLd4CsTqH+6I
         7d+2r4vAEzIH5RXNSY4uvz+bCq5y8OOsEgjYEDIzcoyYwZ1mDEWcF5FFiFRuxUrfgA8N
         bkjZoEGZNaEb+6quPqXDhXfftbwKoJNG5bp4EaSAlkC8MuWRWJG7Dty0Ghliq6BQoy/K
         KRKHKOrZpLTAw3jUmwHqaB8Hxx0N01amanOt/j/13kkL7WX0RPu2jHcImGloUmEbCy/d
         LMiNzoARb/jU8uXJjkRGk+yPoY28b54K7Bs2KG+U0rfVuDRqp2KDHGzp8mOk1pa0P9eH
         HhbA==
X-Gm-Message-State: AOJu0Yzma+eFyGs01mxOX5VJtce2LiSTULCsTr+l9LyazJ7X4gFWXYuZ
	G0UtxUQA3DdE8NOaifw8qx1PevfZMB3JzPG9u8x8k7vEFPCDlRSDAzXbTKxQYrScPldTxIxR7pZ
	ujuY=
X-Google-Smtp-Source: AGHT+IEYd35MOW7sUO6WnjHIiHJYGzUljxDUCiR4Ck+ZRIreA3QvtDPNOG4m6ojWM4vS49RBrPxWhA==
X-Received: by 2002:a5d:6882:0:b0:336:768d:1b90 with SMTP id h2-20020a5d6882000000b00336768d1b90mr1758406wru.168.1705995525330;
        Mon, 22 Jan 2024 23:38:45 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id t8-20020adff048000000b003366c058509sm7565004wro.23.2024.01.22.23.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 23:38:44 -0800 (PST)
Date: Tue, 23 Jan 2024 10:38:41 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Danilo Krummrich <dakr@redhat.com>
Cc: Colin Ian King <colin.i.king@gmail.com>, nouveau@lists.freedesktop.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH][next] drm/nouveau/fifo/gk104: remove redundant variable
 ret
Message-ID: <55f0983a-300e-40bb-9142-6f4683914402@moroto.mountain>
References: <20240116111609.2258675-1-colin.i.king@gmail.com>
 <aafe669f-b322-4f22-a48e-564e3eb3447f@moroto.mountain>
 <bdc7e401-a676-4040-9138-8dc5cf35bd05@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdc7e401-a676-4040-9138-8dc5cf35bd05@redhat.com>

On Tue, Jan 23, 2024 at 12:04:23AM +0100, Danilo Krummrich wrote:
> On 1/16/24 13:31, Dan Carpenter wrote:
> > On Tue, Jan 16, 2024 at 11:16:09AM +0000, Colin Ian King wrote:
> > > The variable ret is being assigned a value but it isn't being
> > > read afterwards. The assignment is redundant and so ret can be
> > > removed.
> > > 
> > > Cleans up clang scan build warning:
> > > warning: Although the value stored to 'ret' is used in the enclosing
> > > expression, the value is never actually read from 'ret'
> > > [deadcode.DeadStores]
> > > 
> > > Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> > > ---
> > >   drivers/gpu/drm/nouveau/nvif/fifo.c | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/nouveau/nvif/fifo.c b/drivers/gpu/drm/nouveau/nvif/fifo.c
> > > index a463289962b2..e96de14ce87e 100644
> > > --- a/drivers/gpu/drm/nouveau/nvif/fifo.c
> > > +++ b/drivers/gpu/drm/nouveau/nvif/fifo.c
> > > @@ -73,9 +73,9 @@ u64
> > >   nvif_fifo_runlist(struct nvif_device *device, u64 engine)
> > >   {
> > >   	u64 runm = 0;
> > > -	int ret, i;
> > > +	int i;
> > > -	if ((ret = nvif_fifo_runlists(device)))
> > > +	if (nvif_fifo_runlists(device))
> > >   		return runm;
> > 
> > Could we return a literal zero here?  Otherwise, I'm surprised this
> > doesn't trigger a static checker warning.
> 
> Why do you think so? Conditionally, runm is used later on as well. I don't
> think the checker should complain about keeping the value single source.
> 
> If you agree, want to offer your RB?

If you look at v6.7 then probably 300 patches were from static
analysis.  The syzbot gets credit for 63 bugs and those bugs are more
important because those are real life bugs.  But static analysis is a
huge in terms of just quantity.

One of the most common bugs that static checkers complain about is
missing error codes.  It's a super common bug.  Returning success
instead of failure almost always results in NULL dereference or a use
after free or some kind of crash.  Fortunately, error paths seldom
affect real life users.

My published Smatch checks only complain about:

	if (ret)
		return ret;

	if (failure)
		return ret;

I have a different check that I haven't published but I wish that I
could which looks like:

	if (!ret)
		return ret;

Here is a bug that check found recently.
https://lore.kernel.org/all/9c81251b-bc87-4ca3-bb86-843dc85e5145@moroto.mountain/

I have a different unpublished check for every time ret is zero and we
do:
	return ret;

But I only review those warnings for specific code.  Perhaps, I could
make a warning for:

	if (failure)
		return ret;

I'm sure I tried this in the past and it had more false positives than
when we have an "if (ret) return ret;" like in the first example, but I
can't remember.  I could experiment with that a bit...

To me, if "return ret;" and "return 0;" are the same, then "return 0;"
is obviously more clear and looks more intentional.  When I was looking
at the code here, I had to consider the context.  Especially when the
patch was dealing with the "ret" variable it seemed suspicous.  But
"return 0;" is unamibuous.

I don't have a problem with this patch, it's correct.  But I really do
think that "return 0;" is clearer than "return ret;"

regards,
dan carpenter


