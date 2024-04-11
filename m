Return-Path: <linux-kernel+bounces-141233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B45AB8A1C0A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C6AAB335E2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396335467B;
	Thu, 11 Apr 2024 15:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cSL8EKlc"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F25951C40;
	Thu, 11 Apr 2024 15:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850666; cv=none; b=PD6ZeSpIQ4god9aA30iN9tcVJacR6FVISGBqkbrWtmjh/NL8KNz6tKY/HcpO0p4VE9ZAqFZmjDlWkvrU+pFCeDgL13U9VHcjZeRk2pUnQIzp+wWhy0grEX7RoYhnM1mrr8MF3GaXHekfaljSLybQDV9Q80Sga5Ggv2d7QnPiYWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850666; c=relaxed/simple;
	bh=pzvrNE8EFEXCzlDSTW+TEzpq7e63AiOfrix7rlIoy68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OiOZtnBtBScaYyXhYWL8wy3yd1iEPQF4K485JRSEvG5YcEkh+YgeicVsLTMmL0opQnn7SGhC7H5pPGdkACu7GE/450kJ20+ZCuAC0/kq8okg5JbW0FWSPK1Whe6W4jqSnTGvQN/MK0U+QVqG1lLyRzPwcL9UkojncGy3uRbJkDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cSL8EKlc; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-343c891bca5so5093889f8f.2;
        Thu, 11 Apr 2024 08:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712850663; x=1713455463; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qBD6bXpxU7Hkw+zKfp0+6VUMe+k70Bih07sQJuwKqO4=;
        b=cSL8EKlcVJlFxrKM1/Cz1KSoL7nMCWj9mwsaVa/4MQ842jqW0h0933skjVCgspabU0
         i6MLYFR6ljnRJnzcoP8nCUNnROa2virGZDAtIiEWXsESpPi+WbPS9CCnIP31tYFRvqy/
         wJ5UZTw0GuGYtTTw1kYpgtFuKPKWMOAeiNX0MHWxkb64hkTqD8UkEBg0C/y9Vb8emRjP
         tWyRxv1Fu73OZ71IphzBF/KHL1z16jpIXMx6ZWqkR3AqEeocjfkIHwaXUqBotnBEbGmY
         xobETZZ442wdxZh9L/FgS5oSiWaE1CvpVzau+UtLiN2RR/wbztrw/SMQRNySYiwmfgP6
         7DPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850663; x=1713455463;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qBD6bXpxU7Hkw+zKfp0+6VUMe+k70Bih07sQJuwKqO4=;
        b=K8go9l7H0g9Ewe/PYjZKYX+CsDQMODCHy42bQQsbigmWObVvT7mhmgL6TLdydBowU6
         BXHmBeBF4BeRFQoUwkXJt+wB9UfXDxK5zDouSz6+3MAIkVofzVjXcWRZmpIrHqyHP32R
         rbwdaIvfJfvOs5WlG2JAQvDX49neh807RBFSrG3T3HMnPbjRKt0h89sdIqo2mxBPnfrD
         FsKpCtq88J6tl+HCu5+XwqCG3p5vy0ip9j512HQVmXqDm7x2IjlrzNGJwAsBbBxQczSM
         e/DMnDFHheuo4xOG8xN67cwZsk9d9N+86iGGj42e5rLbqIjb6Fwknph0QF9EC2NBQKvW
         521w==
X-Forwarded-Encrypted: i=1; AJvYcCUIe3Q7VR3KhT/o8jo2wA39RzIeX4PZSFd+FTRMv3pkpORQuN9uqW3n6mqMONY1ckJeQPYhZDed15zqzDTH4FbciKAlYlC2m50gG7MMseY=
X-Gm-Message-State: AOJu0YwlK8dMpSTPELH1RROK6p0VVP2wc1tk48VsuLG9j4uuaWInIbIs
	ZNRm4AUvUmRrjzzz8zCTFOWqcEOxSvJ2/1gbhQJulu8CppcVWS0n
X-Google-Smtp-Source: AGHT+IHhJrxsiQjIDC0gM5a+V9NSj35vvKdB1iZjSZCjZsxnUYLqqKJffmY3UuQ2WLcDy4WDf0azHg==
X-Received: by 2002:a5d:60cb:0:b0:343:44b9:af97 with SMTP id x11-20020a5d60cb000000b0034344b9af97mr4906878wrt.64.1712850662873;
        Thu, 11 Apr 2024 08:51:02 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id s1-20020a5d4241000000b00343ac425497sm2059234wrr.46.2024.04.11.08.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:51:02 -0700 (PDT)
Date: Thu, 11 Apr 2024 16:51:01 +0100
From: Stafford Horne <shorne@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <keescook@chromium.org>, linux-openrisc@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] openrisc: Add support for more module relocations
Message-ID: <ZhgG5fxCEmo6gnVs@antec>
References: <20240410205201.1885032-1-shorne@gmail.com>
 <CAMuHMdV6W613FESO6EGTTJWoG=dfCbicyH49dywm-5O09SEi0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdV6W613FESO6EGTTJWoG=dfCbicyH49dywm-5O09SEi0Q@mail.gmail.com>

On Thu, Apr 11, 2024 at 02:12:59PM +0200, Geert Uytterhoeven wrote:
> Hi Stafford,
> 
> On Wed, Apr 10, 2024 at 10:52 PM Stafford Horne <shorne@gmail.com> wrote:
> > This patch adds the relocations. Note, we use the old naming R_OR32_*
> > instead or the new naming R_OR1K_* to avoid change as this header is
> > exported as a user api.
> 
> > --- a/arch/openrisc/include/uapi/asm/elf.h
> > +++ b/arch/openrisc/include/uapi/asm/elf.h
> > @@ -43,6 +43,8 @@
> >  #define R_OR32_JUMPTARG        6
> >  #define R_OR32_VTINHERIT 7
> >  #define R_OR32_VTENTRY 8
> > +#define R_OR32_AHI16   35
> > +#define R_OR32_SLO16   39
> 
> Would it make sense to switch to the new names, e.g.
> 
>   #define R_OR1K_NONE        0
> 
> and add definitions for backwards compatibility?
> 
>     #define R_OR32_NONE        R_OR1K_NONE
> 

Hi Geert,

Actually I had a patch doing this and added all 38 or so relocation definitions.
But I dropped it at the last moment in favor of simplicity.

Let me rework it and add it back.

-Stafford

