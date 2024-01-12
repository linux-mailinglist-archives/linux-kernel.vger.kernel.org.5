Return-Path: <linux-kernel+bounces-24976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1429782C581
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 19:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09CA61C2269A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 18:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559F8154B9;
	Fri, 12 Jan 2024 18:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VACd8jId"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D566814AA4
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 18:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50eabfac2b7so7778772e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 10:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705084515; x=1705689315; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DVuPEd45J8g9I3ZNEDA/EaMu/i6TqrreTASAObU9uDI=;
        b=VACd8jIdbUDiw/9EAJEouZaIgQ9qSFPq36Bg3JECc8DmOCU5PFSzSn/dihVEYHfkly
         NhIwgmWWcx9KolBCxvKBdJnNR2tIjW81fVr3uhUZEvezKHpGHt/3TKmqXNzY6E85xfzr
         eaPIg7LBXtIXq/leahx0D3RgowGDxA/BwiDgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705084515; x=1705689315;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DVuPEd45J8g9I3ZNEDA/EaMu/i6TqrreTASAObU9uDI=;
        b=UCY2g8hAbRMzGxH7FH1fH1W829C6eNXCzHPWu+DEucj75j1oZv533LuywmdmC3wkIP
         hPbnWOwO5r4sk/VRe6d8aSX2iFPOP+bHRnd//odk37+SjPEjIK1w6OG0k4F6XdE7W6Ak
         NLfBNpN4f9UNO7LHIMYu4C80TQ2RlMBpkeQRkWHz+uUe7RrxuI5xmxxlaR20lcTWfTJQ
         gSPBe6y70DOzomzciNXulxoeVtj/DgTE1Te2lkUIlKvLpDWsB+zjC2aIJuzk5c0u1iYp
         TifWx+8cDqYGNQ+Jg929fMBVfFJ35rP5R5bSh1ibpW770UxPEQTA50LCcnpA0kpP9r58
         iYmA==
X-Gm-Message-State: AOJu0YxKqKggtesA5T2ZeK34pr6FarGlh/Lbp1lYCPXo3Ql31hJVdas6
	lAJ1tyi4u93VDPKspxWSQLCEyfmXywgOL/p0MCR4oSVL4s4URfvM
X-Google-Smtp-Source: AGHT+IEWCbjWwjb9jCcTl/kNQit7bZAEgpymzBWZb9QpBcc6C+LUTFbahWAmfR66V2WhY+cD2CUURA==
X-Received: by 2002:a05:6512:2025:b0:50e:594d:3533 with SMTP id s5-20020a056512202500b0050e594d3533mr812336lfs.106.1705084515284;
        Fri, 12 Jan 2024 10:35:15 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id l16-20020a1709067d5000b00a26f6b8be1csm2050077ejp.75.2024.01.12.10.35.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 10:35:14 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a2c375d2430so296741566b.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 10:35:14 -0800 (PST)
X-Received: by 2002:a17:907:9247:b0:a2b:2bda:b501 with SMTP id
 kb7-20020a170907924700b00a2b2bdab501mr632927ejb.140.1705084514097; Fri, 12
 Jan 2024 10:35:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c5ac3166f35bac3a618b126dabadaddc11c8512d.camel@HansenPartnership.com>
 <CAHk-=whKVgb27o3+jhSRzuZdpjWJiAvxeO8faMjHpb-asONE1g@mail.gmail.com>
 <CAHk-=wiHCkxrMCOL+rSGuPxUoX0_GSMLjgs9v5NJg6okxc1NLw@mail.gmail.com>
 <255e3328bd48c23fbaae0be6d927820d36e14404.camel@HansenPartnership.com>
 <CAHk-=wi6PenRqDCuumMK_5+_gU+JdUqrBEDS-XwFiaNdVRZAHA@mail.gmail.com> <20240112-steadfast-eager-porcupine-2c9b3a@lemur>
In-Reply-To: <20240112-steadfast-eager-porcupine-2c9b3a@lemur>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 12 Jan 2024 10:34:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgvK8p7-Knxdy9WTN6RB4tczbcRvuzQ3jwE_RYBc+nGmA@mail.gmail.com>
Message-ID: <CAHk-=wgvK8p7-Knxdy9WTN6RB4tczbcRvuzQ3jwE_RYBc+nGmA@mail.gmail.com>
Subject: Re: [GIT PULL] first round of SCSI updates for the 6.7+ merge window
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-scsi <linux-scsi@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Jan 2024 at 06:27, Konstantin Ryabitsev
<konstantin@linuxfoundation.org> wrote:
>
> I'm piping up just because I know how to get the output you want

Oh, I know how to get the output - I can read a man-page.

I'm just saying that the default output is unbelievably bad, and
subkeys are really atrocious from a usability standpoint, with
expiration making things even worse.

And being bad from a usability standpoint here is in the context of
gpg. That's a very low bar to begin with.

               Linus

