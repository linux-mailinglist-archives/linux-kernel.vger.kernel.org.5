Return-Path: <linux-kernel+bounces-91178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F694870AB1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE629281DE6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216BD7995B;
	Mon,  4 Mar 2024 19:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zr6c96yD"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CBF61677;
	Mon,  4 Mar 2024 19:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709580575; cv=none; b=fHnyHZ6uMVaDEzoG0+BhxUjxCZLkeCGfiEYZA92ziGnoU8R2ysv7FL7kNtXiJQ45WD4eDPrh3+t5lUTCvWGz9XJeghuweNn2kdp4WIOu6Cma3DP7TX0GYhvXEROQipAxuYURY2nLV8JnGBOj22HhqCiaRsLKWJqyPjIhfnqiHWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709580575; c=relaxed/simple;
	bh=0Rxdcvf5MJj8GAwVkkY6TLI0UHLNrle0UYwUsx1B5sY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f4IS6Vfy5UXVnM69mD/jTHroM4X5qdWfs/ybtjidJUSPXeoLQTIdM/5GhSLf85r2cmXzxE8mFEWK+8tEmKh+z7wE/3PL5cDXBVeI85dT45UxKQtK1Drlf54TJIsiq9PSKWytc+hNP6OJIzFDo00oGEIWJ7FArOdoG06AwSH1VAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zr6c96yD; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dca160163dso47163575ad.3;
        Mon, 04 Mar 2024 11:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709580573; x=1710185373; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qjIrkRqRqyTyxYlPtOXrJ1tbSziABTmBAS1R3KCEOG4=;
        b=Zr6c96yDGP3cSZd0H3Jbqv7+lboeRUirk0iiJEEA/t3T7ETgCImPalQJgnXI8QY2aC
         Q5FPXX7QGEBsgCSZQ/kxTRg/CVL4q+YZMfWItXps8sTwLiFwLNUftA50HOO6anhWU3aZ
         77ArTV70sgVQggkJoBfcXaYolV+VECh61VA2/nY6jX8tMuNJzDQh13XgSeRJrNbzcHvg
         cRiqGjM0brs1L2yEkAaFXd/kh9QBCsToTN2ZmANf59w2cQfKNUPvzMjOlmsfTcHyu86y
         looclcVcjNTSp6uYr5BQ+ouT/xZZgOPOMgZdnbuvXW5IiFQUJa5jio1EJ7XAEriABYF1
         zYWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709580573; x=1710185373;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qjIrkRqRqyTyxYlPtOXrJ1tbSziABTmBAS1R3KCEOG4=;
        b=nhssq70BsV65EyDbecuJsofPTXi2ek9xpTNTQXtttCHu3J6GzyEJqg7ztQo2EtPbJ6
         npWMPSJjULTheAfTKE8oEJRZH6k8fT0WJe6iSpeadeYEgLcQey0hUZmlU7JyMSGerAzY
         nJPjYICa5i3UzlbA1XVOKKnhmgnu5mG5J6GwfExP+qeIgjHpALphB8FSCQ35ApvIBMmY
         ukXMS5GwE1hgcrlZDEhLXeFALx7NLYKw2zCDOx0UDtdwsmZbcvbxmq7s5sLutYCZwAWC
         XH3yJ367zu8WXEx1nMRwQbehC0Ysg6NbY/Vm5FRirSyJVTPCiGzTXe+UOJKimonaoF/c
         i42Q==
X-Forwarded-Encrypted: i=1; AJvYcCWWeS4t213m2yczSP3Iassk5tgjxq4MYBa+13NMgu/PneMx9bVi3T1fLLu6f0zeErxpMea/gvlP4cvTqCrmMNzXQsGpN/DDM6ivlZxEn7X6CQswiDErpi7qmi+sAS+RJzmN4Y8oX1oQOHI5dkFjk/N4UNHGIwGdfoMMdwdNGaGfcimv/Q==
X-Gm-Message-State: AOJu0Yzzxcw89Mtx2GhXMCIxrOy+ZbrOKGH74IBGj22kGN2scgBwyw2Q
	E1EOb56Y1t+YMCXIg3jtOYMFM2RHnsWkvcAUPlAeP+UYonuRjIHMOZhyPVuTLMPQfnnyKrus22b
	+3XU1D1FVFo8Fk3TGd933d4R/fMY=
X-Google-Smtp-Source: AGHT+IEaWb1+rYOENWHnXIKl8beg74pWUwp3Z+os8HZDvK6GGmiDny+sRArLo4pcVrDDjXwqA6im5Y7UJifhs7U+qUA=
X-Received: by 2002:a17:90b:68c:b0:29a:ce2b:7611 with SMTP id
 m12-20020a17090b068c00b0029ace2b7611mr7400561pjz.28.1709580572920; Mon, 04
 Mar 2024 11:29:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304192244.2924407-1-robimarko@gmail.com> <ZeYglnW6/k0nvmiL@shell.armlinux.org.uk>
In-Reply-To: <ZeYglnW6/k0nvmiL@shell.armlinux.org.uk>
From: Robert Marko <robimarko@gmail.com>
Date: Mon, 4 Mar 2024 20:29:21 +0100
Message-ID: <CAOX2RU77sBWD=N7hQ+7BKQ1DOh8d=JHJBLeN6NEp-4Jv_3M7zw@mail.gmail.com>
Subject: Re: [PATCH net] net: phy: qca807x: fix compilation when
 CONFIG_GPIOLIB is not set
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, andrew@lunn.ch, 
	hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, ansuelsmth@gmail.com, 
	linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Mar 2024 at 20:27, Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Mon, Mar 04, 2024 at 08:21:36PM +0100, Robert Marko wrote:
> > -     if (IS_ENABLED(CONFIG_GPIOLIB)) {
> > +#if IS_ENABLED(CONFIG_GPIOLIB)
> >               /* Make sure we don't have mixed leds node and gpio-controller
> >                * to prevent registering leds and having gpio-controller usage
> >                * conflicting with them.
> > @@ -749,7 +749,7 @@ static int qca807x_probe(struct phy_device *phydev)
> >                       if (ret)
> >                               return ret;
> >               }
> > -     }
> > +#endif
>
> I know it makes for a bigger patch, but #if is not equivalent to if()
> in terms of indentation, so the indentation also needs to be changed.

Oh, sorry for that, it completely slipped my mind.
I will fix it in v2, and will send it tomorrow afternoon to give
others time to comment.

Regards,
Robert
>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

