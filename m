Return-Path: <linux-kernel+bounces-151354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE408AAD73
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BF341C21207
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 11:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3ADD811E8;
	Fri, 19 Apr 2024 11:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mq0dbvlP"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701758005E
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 11:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713525035; cv=none; b=rm2mPsbgdqUlwNMHnu2E8yhBtcbGeftnrZnXayZdeP9ABYdbbRVVIYi2vz/lBxbu6wcvpXMDSMRJjgcq1Q14UWadOxF6KW2INs30re0Nhpz3gHROX/QvmeKQEbVFJA/aQ63QmifgzAiMg1ckgZBKJpGcT21xJ9/Ig80TXygdpTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713525035; c=relaxed/simple;
	bh=ngZhSXUKauT0ajH5Km67x+k8pGFN9squK7rnsssj2Xs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JTuAGYzzAG5s4CaSpVxrATlmLGpHKF6fQBYfG4e6IQoMe5DMTFfkpfCIA9HXhrDf60eEFyflNqTVRCVbtME49vgxiE6aTBmia+lR2/CkLorQoZ4ZLtNNden6Rp2EXdS06MeflhMxM39+5SGghhhqh3FP33UutqmmDngLoXgDUp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mq0dbvlP; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51967f75763so2148523e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 04:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713525032; x=1714129832; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f0GwB5qJ+cyOywFV3R2azRhim7NBqTDtJm3XeiS5x10=;
        b=mq0dbvlPmfzuMrFw+EV2moLriskQEvLaYtcKt3BIF3+veJHtAcOs8JZN67+yrJhlkv
         aXw6LAJQm6yNoB8UFSLb1If4AHLj0nbBfaVi6JLYpEMOnpFe2kWw9mPfhR8eW/4w8sC0
         VPOVJYZcDduTqMybjSVqMapRaaLU1hG5qoO5BpsXuSXd2QNPVVZ6wzQqR8YNEgsye/Nl
         TEy6F8L2u/Z8OmnVdShV3xAYsIiHwgcKR4aALBsJvxSVszvNyB+ls9ITN+E2U85ckTo7
         tO4WWWUAdwq6xOXUS9PL7UIb951tIthjETG8ST0lVOsMI3j+vgqBWsj8i29sxisdCg/z
         za3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713525032; x=1714129832;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f0GwB5qJ+cyOywFV3R2azRhim7NBqTDtJm3XeiS5x10=;
        b=Zt8URj0J3Iuzk4j/Rrv0rPT9ht5nIJdlNt7lvMJf/F2vQzKxJl4BIT/L1z7OJwmCpn
         jWz7DpVBhfkcyU1EYWvH06fKu6IskXhUFBTMZXSomkwu/QVUaxf6eNBjv1nkZqs4zGMK
         Yh/06KM91u71c0IHNA75kjvT4FAY+J08AnJzUo+kvVb4/hsOnuTUtFhMigc9r23NkHia
         D4uFLVeXZEZlz4BA4q8vTO3liK69smGrA69Jil9SM2r6vSBR0x4BrmRoLDm7mjH8E0H7
         YZHZFmD8DGpNPgyineHAHvja9r6PMMucT779TkQ4KLLbzTob4Bhpo4CO7XJRkSfwgR8D
         YSng==
X-Forwarded-Encrypted: i=1; AJvYcCXoH71AkFR98OU27TggtvREGOnLfiCvowBXeSVAoLuvYPoGOrvzgOd6fCCyEN9pEfBBr9w7us9YC1Nz9dMvAK7lNX634tGYeJlc3D4c
X-Gm-Message-State: AOJu0YzT+BrpWIC43up4E2VLnUHg9kfS1Yaqb6IFYpVvhe/1RdbaUXIy
	pLRsKhXKYjaZD+kedd+VTzASKRvegGaK5Mg9S66b9oiAQmjeIhPyr7o3Df0DxVk=
X-Google-Smtp-Source: AGHT+IFQo1G5Y1xQHtbUg2nwyWjiKgAT9a/1iOBxkBGTK/stbBS9hYfv5OT/OGO4XL4ZN4IxJzHdRg==
X-Received: by 2002:ac2:5629:0:b0:513:13eb:c99b with SMTP id b9-20020ac25629000000b0051313ebc99bmr1166467lff.62.1713525031233;
        Fri, 19 Apr 2024 04:10:31 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id i36-20020a0565123e2400b00516ced23066sm656047lfv.61.2024.04.19.04.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 04:10:30 -0700 (PDT)
Date: Fri, 19 Apr 2024 14:10:28 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Herman van Hazendonk <github.com@herrie.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] component: Support masters with no subcomponents
Message-ID: <fmqfaq55l7l4ipreflgzrhvybtvar4kfclbtstctw2qkcxakbh@tge4viy6u7u7>
References: <20240417-component-dummy-v1-1-b0854665c760@herrie.org>
 <CACRpkdbijfwYFhg2XigzVKoPDjU00K+arqaL_kP3FNxsS82gHg@mail.gmail.com>
 <4xywfprr7qkxpncmnhqjc3lrrcjbv46tsmlzz5yxvcr4xr2dnq@w57ni7u2hpvu>
 <CACRpkdYT9my4KETHybHPQ3ksXhiEgYQLSdP8TsBmwzNd+r-qxA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdYT9my4KETHybHPQ3ksXhiEgYQLSdP8TsBmwzNd+r-qxA@mail.gmail.com>

On Fri, Apr 19, 2024 at 10:22:19AM +0200, Linus Walleij wrote:
> On Thu, Apr 18, 2024 at 1:36 AM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> 
> > I have LVDS working on apq8064, but it requires fixes in the MMCC
> > driver, in the MDP4 driver and in DTS. I need to clean up them first
> > before even attempting to send them out. Also a PWM/LPG driver would
> > help as otherwise the power supply is quick to be overloaded by the
> > backlight.
> 
> Thanks then I bet the prototype 8060 MMCC driver needs similar fixes
> before it will work as well, so we should work to merge this, then look at
> 8060 support after that.

Once I have time to cleanup them, I'll post 8064-related fixes.

-- 
With best wishes
Dmitry

