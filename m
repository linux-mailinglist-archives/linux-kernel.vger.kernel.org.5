Return-Path: <linux-kernel+bounces-148413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A03438A823B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B3E4285B99
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BDE13CABA;
	Wed, 17 Apr 2024 11:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SlN29j/T"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF8213CA8B
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 11:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713353971; cv=none; b=ER/GQMGb5rJnIUlA3n1HQrbjVtdc2+30GmRZnYeBaLeUu9wgQ+xZcamo20wuzwCVNhxrFhoXx6/WhoMGaf2JCfHWlerjrQM2rd5hbqJ1Y1sRq0PQjkZId+HF+mP2HKMcZknj3Y5ZeX+WXOd9CWyJx2bb968QZQhN9GurVprI9X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713353971; c=relaxed/simple;
	bh=Ioj9DnkX+ObVSDL6/fpvkdjT0u8OzlkNnV61k9vgk3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L2MLFN4qKMW3Yt4vRkpbECOGmzq9alDOdOJLJ5VCAaVfVONDVB79kiz9RRy6VAM8HryGSFjuOPjEI+K2+E23p0uKhz+OoNqfg5//sfAo0f3HDqilZjsV1VRVQftW8CP6KFf21Xig8AktaPHLHtEJsjCwmA8vPA3Gs57dCM4y3dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SlN29j/T; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dcc73148611so6104722276.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 04:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713353968; x=1713958768; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ioj9DnkX+ObVSDL6/fpvkdjT0u8OzlkNnV61k9vgk3c=;
        b=SlN29j/T7mf/fmifgHuw0Izecr5l2bt6MaqPKYasH1BqGb+Co/lz1l3dIXZ7qnY3vz
         rNDNdgvyE+ewYIoGIJbpYbXPmEOBR2zdr+dnZOvgXr6OBREKRST86virgi5luEEre2S6
         O1Az2/LMudCKZamLaVsB8ewDPW5NCWW46Y5OoFPlVGkynXUWnRZwv4VGmU6tygoJCtNw
         j60dAzk2NO2sIfs4HlXMwe0/uByDYfdIRCSAH06djW7tbFd57c/FDWMojxqEqTDuZEbf
         CW7YuksPfBug2+tDjwk5cRSUiBUNmV4d7EYT+Tc14M6JMKOefFhFvJeOIw32olPCfLcA
         LgrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713353968; x=1713958768;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ioj9DnkX+ObVSDL6/fpvkdjT0u8OzlkNnV61k9vgk3c=;
        b=h6e5oO2MJ548rgDgJZrbzso10gQSGokpyH4xO69u8pSR+7WGI2ZSxiHYkRNy/0O6CE
         o+rIsObuQxvFdn4Mvh4ffiJAiKMRZnr23RLwUEGHivpB/dr9lanOloAk6nMazZUNYdrm
         HbZN7p6rvImewLj2Xr6uBozJpE7t7ehfc/a46Vco8d1hDa0MvA4wcvG0Ul71BpwDgTMO
         WEj1XvUf6g9dtHTD4EubNPBnBy9GI1Gveyw1TdpI/7OK7XZmZpJmoOVxT2vn1tZbUi9Z
         64zZam+eZE82U21VdqZRWH4UAg2VX1mGR93y61LyaeWoWkuTb6kpGRtd2fe5/SBGla3A
         JBAg==
X-Forwarded-Encrypted: i=1; AJvYcCV78sxLY/znmWAVHgEKKqp4cVcFbfe1/puxQpBBIKphMHeNzxsvJrlBDRsW+1LF7C8ItQ6TwSMrExKGrNpY6Kg0jyKbdBzaS5CZhVOa
X-Gm-Message-State: AOJu0Yzh/e8dN+RtpdIjyd26u3a8H852e2Tt9HsgBpqzebniFkpN19Pq
	6jddxmRdaShqjxWiq7CVSKTug/yNmn/bPEMv+vH0FsXpRCk+fWkJ1nKgrIbBYu7O03lCS196yyF
	PN02nUVKALlQlIwrk95baVjNTvlCacGeRNu7lMA==
X-Google-Smtp-Source: AGHT+IGto7S93HRGORyq0GvXIhVAp6wm5zMdY16fzYtx/hb1OWYbqCpxV9/Z5ojkl/ieoD41Fqkg4zQQmmhDYZoEYzI=
X-Received: by 2002:a25:ef51:0:b0:dcf:f9bd:fe05 with SMTP id
 w17-20020a25ef51000000b00dcff9bdfe05mr16431807ybm.48.1713353968629; Wed, 17
 Apr 2024 04:39:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417-component-dummy-v1-1-b0854665c760@herrie.org>
In-Reply-To: <20240417-component-dummy-v1-1-b0854665c760@herrie.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 17 Apr 2024 13:39:16 +0200
Message-ID: <CACRpkdbijfwYFhg2XigzVKoPDjU00K+arqaL_kP3FNxsS82gHg@mail.gmail.com>
Subject: Re: [PATCH] component: Support masters with no subcomponents
To: Herman van Hazendonk <github.com@herrie.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Herman,

thanks for your patch!

Do you actually have this working on real hardware? I never
submitted this patch because I could not get the hardware
working.

I was hoping for smarter people (Dmitry Baryshkov...) to step
in and help out to actually make it work before submitting
patches.

Yours,
Linus Walleij

