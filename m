Return-Path: <linux-kernel+bounces-105145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CF187D9AC
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 10:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 528572821E2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 09:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7600917997;
	Sat, 16 Mar 2024 09:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="XO0kuuAW"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447E91429B
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 09:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710582418; cv=none; b=NO2rQecOQqkXV6RceoFHtyy94b7kLDuO8gAznxrPF0GYCKSBDuc+awbpAMB6Mnz1FgRtiTHJfAMSgvBEn2xQzTo7iGdXaO1OYqxCF2c6XF/S/d9CVQ+CBrj7leeAeH1l0wxwV/l9VmE3Y7LJ2gq//VXY+ET3ZTPcj8ioNwzYzLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710582418; c=relaxed/simple;
	bh=DMtx0/3geiYhVdzSo4B/B12kXf6OyeqliMzNBLNMbFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OhpeiXlR4irmmQgkiAmpc3YrWUC6LewF1MZtSSYqvKgV0A4ti31GNd5MsydwTCO/il+srKlujUwnzeJ6BkQy1x7uTzRZ8a6uqjri+SGiaIKH6HFlchoeiLwIpJTFvoy0lTYHpVX6nz3aHGgwrFxGXQuEOlRbOVuqomFJYlyPc2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=XO0kuuAW; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-513d599dbabso2740863e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 02:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech.se; s=google; t=1710582414; x=1711187214; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fUW/FIbXtZhpkOcYQxCVkz21OR+E2wEaVF3lBWv8kQM=;
        b=XO0kuuAWVGXCHp3fBjnEyHI4y5M/FWfeRaQfsebasvPkOSqgc+ysKHwFuqvoLiKNv7
         +vZAGYRFQoxVNccE517ZYtEyNrDOKyo4tfTzr/TT48xXKspdub2fFo2OPrboxx1jpBbs
         xC3KuHO0/5FAmElYt3foCnetcTFgV18IOdMxj93145Jj1Wd48R5YvR03EXWuiMWQL49I
         G56mAKnD6dvHxLw6i5L40G4WYrzwiBtEIxPkX2fRIoOiHhxtBCzfKFKLogqPwIYrNtej
         w4iNIAk57yxvtZGju5y5oEpkK4klCozTuoQkcLo2CowFeAOGC8p8vMbjvdJhKxj50eRa
         /0pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710582414; x=1711187214;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fUW/FIbXtZhpkOcYQxCVkz21OR+E2wEaVF3lBWv8kQM=;
        b=RB/RJOTMHwKGEOfvq8GDoyZnoa8tGS+JWFPreiWNiqlMu3K2kFLCUi+trUu84Hyc2h
         iCiv82AnPNKfnycVi8t8cpm9TCTPLEGFDabUhjgRW2jSQgSvft5TqMfWnf1MNZ4kSzA+
         wfM+IYXS3ZhnnuANjhxnXU39QKcNxi6P/Ocp2nH6CKlk3O10h0rPeiGw/4oIbOTbaWgm
         uER/a1bTFLTT56KLpOGQTR8dF1jNii2dO3x0vRJDP6ebikqCPrvY+jaFhPoGrq+1S391
         XVxzm4DrY61FWPRIG6Cg+H6CkqbT1t29V295trjQSv6hZ3ipqVuoW1oB1phbAx072sdz
         eu2g==
X-Forwarded-Encrypted: i=1; AJvYcCVpbU4yULUlFWSIpb3/3Lr95PVuIdLqmeluVQ2uwDRpdS1QGG8vXazCuFDMVbquNnCRVGw8Z6HewNRSpFgIREM+a0e3AJ01jIqvg1nx
X-Gm-Message-State: AOJu0YxSlIUozjbVIHkxmdeisVJeukojT4gb2VbPq1vnKTvJOI9rWZE3
	EpjnAA4mf8hjzrYtKTGM5gm0IfGIHtDKNTY3KIEJpD/vPnYjmvoEd+yOHZRIv1M=
X-Google-Smtp-Source: AGHT+IEDsDdll7w3geO/Tp+xb2ClYrnmkqXOFWJIa3xlfSDYbiyEsikoRMXqjej+3H6Huqwl5UJ7qA==
X-Received: by 2002:a19:ca51:0:b0:513:b061:1815 with SMTP id h17-20020a19ca51000000b00513b0611815mr4296285lfj.18.1710582414145;
        Sat, 16 Mar 2024 02:46:54 -0700 (PDT)
Received: from localhost (h-46-59-36-113.A463.priv.bahnhof.se. [46.59.36.113])
        by smtp.gmail.com with ESMTPSA id u19-20020ac25193000000b00513a76b310esm921223lfi.60.2024.03.16.02.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Mar 2024 02:46:53 -0700 (PDT)
Date: Sat, 16 Mar 2024 10:46:52 +0100
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Markus Elfring <Markus.Elfring@web.de>,
	linux-renesas-soc@vger.kernel.org, linux-media@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] media: rcar-csi2: Use common error handling code in
 rcsi2_parse_dt()
Message-ID: <20240316094652.GC2092253@ragnatech.se>
References: <8b4203dc-bc0a-4c00-8862-e2d0ed6e346b@web.de>
 <CAMuHMdWwegdks3eEviEsBJE3AvUVKbZqHduYdhuwz=8xTMDs5g@mail.gmail.com>
 <260d82b6-e7fc-40c3-b414-50a883709fd7@moroto.mountain>
 <ZeWnD9YrXLWJYmhT@kekkonen.localdomain>
 <cc121bef-8bca-44e6-81aa-bf8e682bdaf5@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cc121bef-8bca-44e6-81aa-bf8e682bdaf5@moroto.mountain>

Hi Dan,

On 2024-03-04 14:16:56 +0300, Dan Carpenter wrote:
> On Mon, Mar 04, 2024 at 10:48:47AM +0000, Sakari Ailus wrote:
> > Hi Dan,
> > 
> > On Fri, Mar 01, 2024 at 04:42:01PM +0300, Dan Carpenter wrote:
> > > Sakari Ailus pointed out in another thread that we could use __free()
> > > instead.  Something like this:
> > > 
> > 
> > Looks good to me.
> 
> Thanks for checking!  I've never used these before.
> 
> > 
> > We could merge this with your SoB (pending Niklas's review). :-) The driver
> > has been since moved under drivers/media/platform/renesas/rcar-vin/ .
> 
> Alright.  I can resend this as a proper patch.

Please do.

I do find the idea of scoped operations and the syntax

    struct fwnode_handle *fwnode __free(fwnode_handle) = NULL;

a bit foreign in a C context. But I think the intention is clear and it 
allows us to avoid having the remember to free the fwnode in error paths 
which is a nice thing.

> 
> regards,
> dan carpenter
> 

-- 
Kind Regards,
Niklas Söderlund

