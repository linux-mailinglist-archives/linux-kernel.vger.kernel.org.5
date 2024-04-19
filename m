Return-Path: <linux-kernel+bounces-151156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F488AAA00
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8D7D1C21491
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 08:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D728552F82;
	Fri, 19 Apr 2024 08:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TOKQSDQE"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A638E52F62
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 08:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713514953; cv=none; b=C04/BWXR2BMmzPCblUteeqeALfE1TQMnfkcvLrdcT+A1Uisae3ZVpDG8+RoJNteiuAkaOxKsB50LiT8SXOC8RWnIegnUiiRvarT98GGprlankd0J0kThk2Ej9OcnjoUMKIKbQQe3z359/Oq31q3I+/Z/JjDbxtIeq2AnP43t79A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713514953; c=relaxed/simple;
	bh=R+lW8U2rIcGFEawJxZSXhfE6ZoNKFCIGHTbAbeVXNxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ecUcU28mCEFRZKOPKuWT9p6UDW2ozYweYbkO+NFVbhWeNcs5JsflyCWE5Dkz7B0k3NJVPuT18ywdCQvFWjDvN+GxGOYXcLDXtUBSspGCXlVqeJq8WpklxJIM7FtkF1R8ZMxZV4gMGGTH+y1jYAsf4fENygD4hXic0huQM0UITu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TOKQSDQE; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-de45e5c3c84so1804093276.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 01:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713514950; x=1714119750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+lW8U2rIcGFEawJxZSXhfE6ZoNKFCIGHTbAbeVXNxg=;
        b=TOKQSDQEGXt4a6LLm2ifH2Uah85NVDCIeSwv6/DZCOU2955ZEhMS7aLsM03IBa6Kzv
         5drMC/9qS8RzZi5pvuAVmwNpgtlKiCKN2V9N7PJdv/rW/GIUcTZzuvhxqgm3cuBwQMEW
         28k+iYQNp7hNu5/tbCve6Vmxr8geHMiDYkoJXww09xXwDMEF+WFGdawKdc1MeaoHNQ3w
         m2Zfya4wJGvA3Mss2RMtQFPRR8F2Hto7mPNrZb1mhAqZQbSfI8te5ZwcMBPuYHE/JNSz
         4gYqxgYjDmxU2h19pfa6rTaFnRxZcj1JwMbYVs/61X76WB5EADy734kBNXKlB//Ek0wi
         VHAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514950; x=1714119750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R+lW8U2rIcGFEawJxZSXhfE6ZoNKFCIGHTbAbeVXNxg=;
        b=rwOlBGPlNJlkr9wxDm+oVUuuWqqUqrW8IECHxKVoedsKNEQOuviQGKfdWnkSWFe+Qo
         vc31S3qBWdkwnY6x0C3BXPeTj3qTbKUP9qRRcub1TzXi6OVm9s0Fmsq+tLqyQYnj/GXK
         6GjyG1vnfEd+SSxAzBGeOblGiJ+caUWaaVQ9Fjt9Ie2iSrzw4FIGrBMVvnMErcNC2VM2
         zoF2VHGym2jsDFzZ83udgPbuOdDo5cLikrzT8KQnfrD8te3SZC1IpYAuz4oPDPHWhQPb
         QTb1VPMZL1CXAWCzKJfnopL733b+qQjErUrsoVNcb/Nop7pCEYUd3GBLSjXxI2hMQzaH
         iXUw==
X-Forwarded-Encrypted: i=1; AJvYcCXXhXdmsz0eNdxRyKX1RTJMvd9KwJrfhme4Uel80ZHkByQQR8hK8wOuZKiBegr6YF6xrGEBQvl0dO1AFTBPa2Q4SF2yKP5cmyu16ofN
X-Gm-Message-State: AOJu0YzzaCePiasNpJ+6rgWkWmcRD3CUybPjIzddWUId0m3THoobrPbI
	qaNhJsvQI/e8UCdDZQF6rCuVhDWnfGvaUf/KixE+z06aozOPs79xDP942ovPxfftaq62XUsFNex
	WZ2w25ngg1wALQNGPZ+zW7f6sx+ublHGEwEy9EREeO260oOet
X-Google-Smtp-Source: AGHT+IFPyhBOcKsumPvUAGu+ybltqO/6sX6k0ocwJKMsoJgn5Y5t185Co/wULm06e1qdXJ1gmr8tw6bnd8/ohyJChO0=
X-Received: by 2002:a5b:bcf:0:b0:de0:d32b:52bf with SMTP id
 c15-20020a5b0bcf000000b00de0d32b52bfmr1058038ybr.39.1713514950675; Fri, 19
 Apr 2024 01:22:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417-component-dummy-v1-1-b0854665c760@herrie.org>
 <CACRpkdbijfwYFhg2XigzVKoPDjU00K+arqaL_kP3FNxsS82gHg@mail.gmail.com> <4xywfprr7qkxpncmnhqjc3lrrcjbv46tsmlzz5yxvcr4xr2dnq@w57ni7u2hpvu>
In-Reply-To: <4xywfprr7qkxpncmnhqjc3lrrcjbv46tsmlzz5yxvcr4xr2dnq@w57ni7u2hpvu>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 19 Apr 2024 10:22:19 +0200
Message-ID: <CACRpkdYT9my4KETHybHPQ3ksXhiEgYQLSdP8TsBmwzNd+r-qxA@mail.gmail.com>
Subject: Re: [PATCH] component: Support masters with no subcomponents
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Herman van Hazendonk <github.com@herrie.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 1:36=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:

> I have LVDS working on apq8064, but it requires fixes in the MMCC
> driver, in the MDP4 driver and in DTS. I need to clean up them first
> before even attempting to send them out. Also a PWM/LPG driver would
> help as otherwise the power supply is quick to be overloaded by the
> backlight.

Thanks then I bet the prototype 8060 MMCC driver needs similar fixes
before it will work as well, so we should work to merge this, then look at
8060 support after that.

Yours,
Linus Walleij

