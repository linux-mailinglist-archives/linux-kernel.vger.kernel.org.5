Return-Path: <linux-kernel+bounces-20981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85969828816
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91417B22410
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A30939AD3;
	Tue,  9 Jan 2024 14:29:34 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCCA39AC0;
	Tue,  9 Jan 2024 14:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a29a4f610b1so313004666b.3;
        Tue, 09 Jan 2024 06:29:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704810571; x=1705415371;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4PLkRHcOKx8awD/I3nMGKYisxvVR6qD6c46F0HsyxRw=;
        b=vtwa+Bxf7qekrkIQ35l02ilpD7BbuUyOkGpQbiO91M11Wjh/c9isD+Nfz1L275qKck
         DEdPrOlwHFo69ls4Tl6/0H6S1Z5OSbBKziD/BX+QyNifaWampqmUCkhzCrdbTZvtQm2x
         fKtKWy+VZCDQJmi+2tOfysK8xhFqFpH8K578rn58zDmyJDoYjaWB8ycM+NBP0QNrN/J0
         OR4kCAwsxBzZM7R9+muof0K0ELW8JZVkbbwpqbOiw3EZt69aQKUTWitHbppG4etVkBsh
         I7IW6I6aZ93Yiwj0Uu2nCwgZ9JOiJ8lM23Rb/Po89vXnty9Z8fQqKx9GtTqdGwQ6ImJ5
         C24w==
X-Gm-Message-State: AOJu0YwdqggbnMgHRXwclEzlQ4GR9qC7r3QUti4KRdOJL1UTvE2kvOXZ
	H49Ox19XptrKBh0wBVjKkBg=
X-Google-Smtp-Source: AGHT+IFoxfghl1pIrxobwdNW/Zvb8Bx6H2qL5iIng++P5tlvUO0keU6//vD7/PRG9YOxcLjf1HQjAA==
X-Received: by 2002:a17:907:318c:b0:a2a:c162:16cc with SMTP id xe12-20020a170907318c00b00a2ac16216ccmr748818ejb.62.1704810570559;
        Tue, 09 Jan 2024 06:29:30 -0800 (PST)
Received: from gmail.com (fwdproxy-cln-002.fbsv.net. [2a03:2880:31ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id c24-20020a170906529800b00a27aabff0dcsm1114447ejm.179.2024.01.09.06.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 06:29:30 -0800 (PST)
Date: Tue, 9 Jan 2024 06:29:28 -0800
From: Breno Leitao <leitao@debian.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	Greg Ungerer <gerg@linux-m68k.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 01/10] net: fill in MODULE_DESCRIPTION()s for
 8390
Message-ID: <ZZ1YSDBBUYR/Zn2j@gmail.com>
References: <20240108181610.2697017-1-leitao@debian.org>
 <20240108181610.2697017-2-leitao@debian.org>
 <CAMuHMdWqnTjHa6KW5g0F8xH50As4Ce+O3a2HaifJtnY1cGrFcQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdWqnTjHa6KW5g0F8xH50As4Ce+O3a2HaifJtnY1cGrFcQ@mail.gmail.com>

On Tue, Jan 09, 2024 at 12:25:14PM +0100, Geert Uytterhoeven wrote:
> Hi Breno,
> 
> On Mon, Jan 8, 2024 at 7:17 PM Breno Leitao <leitao@debian.org> wrote:
> > W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> > Add descriptions to all the good old 8390 modules and drivers.
> >
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> Thanks for your patch!
> 
> > --- a/drivers/net/ethernet/8390/apne.c
> > +++ b/drivers/net/ethernet/8390/apne.c
> > @@ -610,4 +610,5 @@ static int init_pcmcia(void)
> >         return 1;
> >  }
> >
> > +MODULE_DESCRIPTION("National Semiconductor 8390 PCMCIA ethernet driver");
>
> I would write:
> 
>     National Semiconductor 8390 Amiga PCMCIA ethernet driver
> 
> as this driver does not work on generic platforms with a PCMCIA slot.

Thanks. I will update and send a v2.

