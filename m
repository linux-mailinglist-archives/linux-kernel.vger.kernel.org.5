Return-Path: <linux-kernel+bounces-14925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1A882248C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 23:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D5DDB237EB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 22:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC3B18053;
	Tue,  2 Jan 2024 22:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6Xa/2hF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A0D182A7;
	Tue,  2 Jan 2024 22:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d420aaa2abso36526195ad.3;
        Tue, 02 Jan 2024 14:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704233289; x=1704838089; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bQr+uhhDTZOsAl6z5oXQifSDEqeLIZrPqfs2TXfgIgM=;
        b=c6Xa/2hFMxmx8jz1Ly88rmog991jtZw+A8Blb4WinQTEPUMKPdZ/7joOWNwPt76ixP
         faJmsOs/s9dqEojgd0tfZLOhLBahL39TtCDgsin6l1TJcIEXU3Q7XIjXEwqdoqJm+rEz
         q4K0CQIas6SsUxZbidPk3GvntBQt3icgrf7DI7ir58VexmwZL6EgC3a/qGcFIVR9fwqz
         byu2d/XHrsuuZo2VxZP3s6Jpgs72b5GWuzEvXtcnNYBN27QvHdB3737X18TAX5Q2/FCW
         qxPYIGteFmjBhA4a0aSrIQ5E6Cp+2btcIfkyEbwSmYVSXfgj974qfHQ4M3uvNBzCb0Gx
         Oz3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704233289; x=1704838089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bQr+uhhDTZOsAl6z5oXQifSDEqeLIZrPqfs2TXfgIgM=;
        b=V63dUenhKYau3nHYXrtFaMKjJo8hhS7DPLL/ORxmZclIkA/T2h3JTGxaZow7B22qgv
         Ev2dtvWXLQyOX40TSXTJT8U0437DpWPVK02aG6UQGCR+uZ7T8FoAMi5QVE4+V6Y5vfFk
         EjR5346TAWgvBhTptglDVBJBRLOAlC86ikaQfbtW0JqjmpfAEYPhGp6UNMBCDpSRbIS7
         sV+AlMS3WLgUzVbZeQduyu3WI9pbNmZof4XjZbPxQDRZ7Gy47RVvEFMblxWxntTCCU0+
         IGMyqLAMV5sNhqliDTXOuRg3kD2S5TtvJkDey95V26Xfi8AXSVDyrYeWMyBPG9v4ej1x
         fFAw==
X-Gm-Message-State: AOJu0Yygyzh/gMwWJ5VhjkSM+d7NjmO7VGx8aM5as4mYCKCtXt8pqnTL
	zgIaYKC7lNfj3gON90hDCdM=
X-Google-Smtp-Source: AGHT+IG5pWWqxAfPozSD4Nm4JLECeWYYKJpLIp4ShaMB05PnfuGC5keWjhBC5CAGlIezu3Ru5TsPVg==
X-Received: by 2002:a05:6a20:8e06:b0:196:b1d1:a6bc with SMTP id y6-20020a056a208e0600b00196b1d1a6bcmr1939325pzj.19.1704233289295;
        Tue, 02 Jan 2024 14:08:09 -0800 (PST)
Received: from geday ([189.115.92.220])
        by smtp.gmail.com with ESMTPSA id ck4-20020a17090afe0400b0028ce12f8cdasm96521pjb.10.2024.01.02.14.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 14:08:08 -0800 (PST)
Date: Tue, 2 Jan 2024 19:08:45 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Andy Chi <andy.chi@canonical.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Stefan Binding <sbinding@opensource.cirrus.com>,
	Kailang Yang <kailang@realtek.com>,
	"Luke D. Jones" <luke@ljones.dev>,
	Shenghao Ding <shenghao-ding@ti.com>,
	Matthew Anderson <ruinairas1992@gmail.com>,
	Luka Guzenko <l.guzenko@web.de>, Yuchi Yang <yangyuchi66@gmail.com>,
	Vitaly Rodionov <vitalyr@opensource.cirrus.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: fix mute/micmute LEDs for a HP ZBook
Message-ID: <ZZSJbWB2O7mKVbeW@geday>
References: <20240102024916.19093-1-andy.chi@canonical.com>
 <ZZOQamQsHUR7eEPd@geday>
 <CAEzXkg3YiH_XQGz4vbFc7dptmMSWrVDrALdNJAmmQgWa17PP1A@mail.gmail.com>
 <CAEzXkg1DmR2PJ2SKF8hRdbRaPVVU8eWHjzjXHcJE-KqCU-8wqA@mail.gmail.com>
 <ZZOwVZN7Xn2rIKtB@geday>
 <CAEzXkg0NLYxgKHr4iyoJPU7aZcrtcQFBo3o_K=qHuBpXeyNvbQ@mail.gmail.com>
 <ZZO/Az2puwFY5L3R@geday>
 <87y1d77pg4.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y1d77pg4.wl-tiwai@suse.de>

On Tue, Jan 02, 2024 at 03:57:47PM +0100, Takashi Iwai wrote:
> I merged as is now with some comments about the new model.
> It's fine with the current patch if the entry will be updated later
> with a proper model name; having the code fix before the name
> definition would be more important.

Thanks Takashi, actually it's a commit from the ideal world. I wish more
integrators would work together with Linux companies to launch new
products that work smoothly, like we see here.

I appreciate you adding the note about it being a new model without a
proper name. It's a middle path that doesn't overwork you and Andy, and
my concern is still addressed that way.

Regards,
Geraldo Nascimento

> 
> 
> thanks,
> 
> Takashi

