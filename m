Return-Path: <linux-kernel+bounces-23145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4268B82A840
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5180A1C23483
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 07:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A37D2F3;
	Thu, 11 Jan 2024 07:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMOXAgc3"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDD1D27A;
	Thu, 11 Jan 2024 07:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3bbbc6e51d0so3481149b6e.3;
        Wed, 10 Jan 2024 23:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704957696; x=1705562496; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yy2lzqaTFfa02W+7q6UCYddcpHLmZArhRiq65UjnToc=;
        b=dMOXAgc3yiR0rThuCvyuP5/NLE+vuWibffhVpBiszUHFe5wZSMWoXz1kHGb58nZtaF
         sbQdcCLPn55TJnELM+EtsZFS+UtFbaBlWYrvL+1EhL+y5KxPoe31mCrzTlk3WISfVbDN
         cVIvbzSRXJhLmV/DohN5LvVq8pe7XSI6nqYqWlivmieGiaP5JTaeCD9u0blkLASUwyC1
         9CsI+zi+iyLUuslgC8zUeydzEAOZ+fKXVDX9xWPlBzapfRu/03PY7bSQX5AEs3EIcvtE
         F93UIJUkVolifPa60tTFHnGA75H4e4mSAd0Glue5sFh4yEQBzXbof88Zk++o9aLdieah
         tsKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704957696; x=1705562496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yy2lzqaTFfa02W+7q6UCYddcpHLmZArhRiq65UjnToc=;
        b=qZ9oh8i/l1+xlKKTxzhkDWs3pz0KPpZPYtLCMLAEfCSItlZTun8Mgo6I2auK5Iexdh
         UckBFooHBDY4r0YfIVKC4tuAdmLfEXEmE1vvD8F+fi3WwJ/YhNd4lrjnI0gVVHkvJVP2
         wnHBHIkoNwRES0K/jK+tHmho1VkDm4CTiFT+Xe3g4XK+qfDtzV4erkq1te7UVEv+BvFc
         60KeD5QtyROVE2k/ksyi7KVW2mdXvx8MY4X9JvzIV9pnpcpypBApdS2QU9IuafeTalUf
         h4qp9yhRjCRNLnoDuaPwV5Xw+GtE/ZkkTdmsNdTI1fLzb5W6Gm/czyWbhf5Cw5CH/vPI
         H//g==
X-Gm-Message-State: AOJu0Yygt1rwajjL3l+bJkdZrNnqEutpGPNXhZ0zn+UHu/Fr/0iqMmEA
	H7q1KdaC1RVDfeO7rPUGcwI=
X-Google-Smtp-Source: AGHT+IEd95KMby+FaKu8/bxssdUJwSuxQqijxRBzUkA6Qa5Imunn62jJCrDzhGREmY0J6EUzJfPCKg==
X-Received: by 2002:a05:6808:1411:b0:3bb:c599:e3ed with SMTP id w17-20020a056808141100b003bbc599e3edmr867056oiv.17.1704957696423;
        Wed, 10 Jan 2024 23:21:36 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:70e2:a0a5:5166:fbbf])
        by smtp.gmail.com with ESMTPSA id u2-20020a056a00098200b006d99056c4edsm464983pfg.187.2024.01.10.23.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 23:21:36 -0800 (PST)
Date: Wed, 10 Jan 2024 23:21:33 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Helge Deller <deller@gmx.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-input@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vt: remove superfluous CONFIG_HW_CONSOLE
Message-ID: <ZZ-W_WAmGuOU-Bbg@google.com>
References: <20240108134102.601-1-lukas.bulwahn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108134102.601-1-lukas.bulwahn@gmail.com>

On Mon, Jan 08, 2024 at 02:41:02PM +0100, Lukas Bulwahn wrote:
> The config HW_CONSOLE is always identical to the config VT and is not
> visible in the kernel's build menuconfig. So, CONFIG_HW_CONSOLE is
> redundant.
> 
> Replace all references to CONFIG_HW_CONSOLE with CONFIG_VT and remove
> CONFIG_HW_CONSOLE.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> I think this patch is best picked up by Greg rather than splitting it
> in smaller pieces for m68k, amiga keyboard, fbdev etc.
> 
> Greg, if that is fine, could you pick this for the next merge window?
> 
> I was also considering to rename config VT_HW_CONSOLE_BINDING to
> VT_CONSOLE_BINDING, as the dependency is on VT, not HW_CONSOLE, but
> at the moment, that seemed more churn than value of clarification.
> 
>  arch/m68k/amiga/config.c        | 2 +-
>  drivers/input/keyboard/amikbd.c | 6 +++---

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry

