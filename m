Return-Path: <linux-kernel+bounces-155422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6508AEA27
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DD6C1C21D67
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6F213C661;
	Tue, 23 Apr 2024 15:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWugi0Qj"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A2013BC27;
	Tue, 23 Apr 2024 15:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713884737; cv=none; b=S8cwXrrcAUQRuRwMF9m+cpaD0WuwBpA4McclTXahlkc2HTMGevhLEqn6r9WoOoaTs2CJRRijd2aVk6+IAkfohyjbQIQkOyykWNzyxO1XCs6i7dACMOm0PaQ3JA6WVRlD6/qoEbM+o8WMyYvDJRRsg2vV/6GE5PzOCm3wg57+f7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713884737; c=relaxed/simple;
	bh=1hxwFFG7sRViIQmtpQdXpYlxNm1EZkeQJ2bJvNxf/P4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aEXUZ3GJUnMkkpjfEeqxljM6Ers0Wj+f4nUEyW8bmr0e0ofzncRxq6kcnzl+EaLcoZkd9Cx5E+E0zBEY6VXCn8X6I2TRNSW95xLAmZJHMaSY4sWcYs2M8N5HWpi/H3IMd356UH+i7YoJhtd5JzPiLdPtdNtT0p0wRx0qtAg/SnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gWugi0Qj; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51b09c3a111so3951016e87.1;
        Tue, 23 Apr 2024 08:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713884734; x=1714489534; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1hxwFFG7sRViIQmtpQdXpYlxNm1EZkeQJ2bJvNxf/P4=;
        b=gWugi0Qj7+6RB2IlHo3P8hpJdMFoJ6/mJ3B3xGMy/LedV5Qk9pW9hlfqbpajZTnHWP
         A47tDh6byDRRpSODU4o4a4m8Q2T0t+Ohe3xBKhG75L+KG7IKp5eugkkVrH33VKss2/uA
         XFpqaQVOQuHLAYwyiLdygUGnA62dEp/eF2KVCaOfLpBL6gMwpjZp9nb1V1fLk3GESHuU
         2DM0j1H6b5+M9KwWmqVkPfNTQOqXw2Gc0BsrNLvbUzj4zmY5nWimUyK/Qo3pIOPU6E1q
         ztaFnPZderivx8clhUxJ3bl6X9V6oTpRMCWr8Mc+xoa1cMcjyTTJQMosLOCVaofsmlht
         SK9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713884734; x=1714489534;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1hxwFFG7sRViIQmtpQdXpYlxNm1EZkeQJ2bJvNxf/P4=;
        b=EY1YZukhH7LNiLzkaomBjQCTLuMrnzsp0cE6LDiZCaVj5IrWpkMXrjbLZL0ZqUsE8N
         o+O5r366CsO0rmCY5nxKJ/4IvNUHQcR9HH78sMafWeP9hAyx+WRCkoPhlfQt3Ad6R80A
         G2RpWQk9DW+Lepqhn3xv+VjYVdrz3Wpo8VGzqAFfCi3XjhENkeO+RI0fRND+Gv79FuIx
         XfLIpJE7tGBlY5veS0XbUlQkClZxYS2jVudWBo/QgPQOrVY+e2kAXjXWhKtIE9b5sXBZ
         yWcTTv+LMmmN4oitKwHArvkYdWWfD3tQ+GoHF4iHdOHDUhrYqPCf/Z74/pELycvMF+mk
         XdVw==
X-Forwarded-Encrypted: i=1; AJvYcCVawKkeIql+6La5p9m8kUCUUtR8ZzYUMM/N2Zdvf7mkI92Gx1sG0M2QrWvztRLmK9KgegZIVbAV93HqdePi7GGJC2vFhSATp9UbGJrq8WBW1HZ3ttk+WYzIPTIPMXQ4xIs/lDEsVX9Z
X-Gm-Message-State: AOJu0Yx0QSwA2cHmgU7LDMSXO2Vk43QSb68VzTZ29vqK//rOEPxSvtT5
	bfci2k9dtb+/B6F1+Kij3pZVUQN2xHzLoOsnr3IXIh/GapymYG/cAAQEDajYYLtgZkNSd0Jnmzu
	b4a3OMGY3sWbo3ZsnSDWplj5uSMwvQMYshWw=
X-Google-Smtp-Source: AGHT+IEU3imTQlpcLZ5MH0x6sN91i6XuYjmBODMD6US12RgziIx79DvQUAGEuU8BBK2rOuvXt9euHVtFIGm0exQtmgc=
X-Received: by 2002:ac2:4f8b:0:b0:518:c959:8be with SMTP id
 z11-20020ac24f8b000000b00518c95908bemr7735255lfs.58.1713884733587; Tue, 23
 Apr 2024 08:05:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJg=8jz0X=CKR1POvF41oEumrq1z=MVWPdF2ECbzV6-rhht8-g@mail.gmail.com>
 <ZiGYbJezGZg6tGgq@dread.disaster.area> <CAJg=8jycPX=fQskUb=48g=AS7-uUNAVKZyZ+tyAC5uGYwfpabg@mail.gmail.com>
 <ZiWl2MG5f0wAp7mM@dread.disaster.area>
In-Reply-To: <ZiWl2MG5f0wAp7mM@dread.disaster.area>
From: Marius Fleischer <fleischermarius@gmail.com>
Date: Tue, 23 Apr 2024 08:05:22 -0700
Message-ID: <CAJg=8jyZuxsUX+oNU6O_L4LNOVs21xVKTDi8ywPfDbj+cAxegA@mail.gmail.com>
Subject: Re: KASAN: null-ptr-deref Write in xlog_cil_commit
To: Dave Chinner <david@fromorbit.com>
Cc: Leah Rumancik <leah.rumancik@gmail.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	harrisonmichaelgreen@gmail.com, syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hi Dave,

Thank you so much for your detailed explanations!

> > Do you think it would make sense to backport that patch to 5.15.156 (the
> > LTS kernel)?
>
> That's up to the 5.15 LTS maintainers to decide. They also need to
> weigh up the fact that xlog_cil_kvmalloc() doesn't exist anymore in
> the upstream code base. i.e. we found other places that had the same
> kvmalloc() performance problems, and so lifted that code up further
> and used it in other places in XFS....
>

Understood. Please allow me one last follow-up question. Did I add the correct
maintainers/mailing lists to reach the 5.15 LTS maintainers? If not,
how do I find
the correct addresses? I used scripts/get_maintainer.pl as suggested here
(https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html)
to locate maintainers/mailing lists.

Wishing you a lovely week!

Best,
Marius

