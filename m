Return-Path: <linux-kernel+bounces-94094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4DF8739DA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD7A61F2534A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4C4134759;
	Wed,  6 Mar 2024 14:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxWLQYeo"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D7A134413;
	Wed,  6 Mar 2024 14:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709736905; cv=none; b=Rb4eTql9kMToQMU1mGlDe+3oyTF+IgeuRt4mxtMNl7J7i4xVi/J5XPFGyj9OlCZro/SIsjeJcjwSmGr3wLBE37TvkIPtZtMPX1So4DR7/ssEadsmOTvF8LZjeBwOEDiP4Qp6chGQ4EPLXEeISOC8c7RUivsuDBGE+TpVg2q30v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709736905; c=relaxed/simple;
	bh=nNpO6ESIQuWNHV3anMdBB0uTpqzi1/v1tY6k8m6q5S0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K6rroyOxnsIGBkVJ05Q33522glBVBfBa4+om36zIj4nJOORObgb7xbL+pSiyAZ2F4hvvsq8ly6PRQPq+jnnSqLZrgJCOdRAkebav9sRopOwptl6TzvaRDv3pA1uehGV8mZiISOrOEOAs2b4TSNxlg+0oHdlEyC1EE0FnbEXqC8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IxWLQYeo; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5e4b775e1d6so668456a12.1;
        Wed, 06 Mar 2024 06:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709736903; x=1710341703; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kNsQrzui79q+RpiAKCUg2sUg0iqLQRE/fhXeQe2h8Ek=;
        b=IxWLQYeoq/yT0bM64audHCaylP7e65SX9cIJZQqHZ+J+wcJiqExDk5KBVcorYMAN0u
         OA6PHKhkUaKTSyGiSt4FzTH8yuqDULicm6FN0PFgVnxdPKon97zZiKpS2ocNWa1Bs9EU
         Pt93jF2AU+Yit4oeD+nCif8IZYD/GPTT7dT9CKandbxfh2DXH30ghAz9sS7Ut64hK5H4
         uiE86MGiCDvVsy6RB800ZwJeFYjIWyia/UYEGbVLcrLIx7ujN2CoGiclbWlKJ25uZQFJ
         5BdyaP5rZYPQlN7k+V6PgYyes34XrzWmvqPBoMjmQNk4Y6mtKRW4Mh4BqglzqGzo0t1A
         UdyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709736903; x=1710341703;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kNsQrzui79q+RpiAKCUg2sUg0iqLQRE/fhXeQe2h8Ek=;
        b=PN0GvMBmXNGzvDgHWAUgCWThYFxc32ZQAHdqVohbYg3NzX2tEMyUXprzoBmjfEo6ac
         b5fsfKfAG2BRw/ljK294Z4T43On5WBI5lzhRvBVQfO1o11Wd2DgJ9yMmDIXt4xlHOGir
         6HFLqSgtL2a+GQHJha12Gpkw5Vfi/1xqPrksXrSaKzpqXT1UbghWphiQgODihJbPRQb/
         xjkJVf1NVh2gjjg+wbeEX2IrkjNb97IdQOZNV6eqvOD2E7LSMz0ukcFOsxL3kggLBHkx
         C9iByyGn96PwkFV3FhoDHWnQrzXp65nyfMDun5TK+by2b5/62fHGbHF+4+2BI9rru84u
         woKg==
X-Forwarded-Encrypted: i=1; AJvYcCWxtySveBIQvcKw0NONpoT3NfomLjJgY7ZRhBRWc7UFhotB5q2bVWVPmkJrD0KuAATDL0bdHE+3KQWZ5gcOChAcfQS+i7OiTajzypYE1VsNUxu4I1EXo8HNL60Za9Qtx1cdhrLB
X-Gm-Message-State: AOJu0YxuouYx3umGogwXsl88Lalkowl938/ouy6I2Tq8EwK8gvFyLplT
	kC5NcpkXvqr7fKE9tL8VR2iuwnrxD/bbnwXl1jrQ4uK1wennTjP1C5kHC27Tb6ox02xhMUrrU+/
	/HLRhbtmZ7YyIDbeTpjkXtWTzdbk=
X-Google-Smtp-Source: AGHT+IH+SzGwawUqge120mvgXtvy59eTBMFCd0+4qfzbDoCxlgbUsEiqbq5q/j9OyqS4I31oiXEXizOmvUgy+fJ0Hqw=
X-Received: by 2002:a17:90a:9f87:b0:29b:7f85:db2c with SMTP id
 o7-20020a17090a9f8700b0029b7f85db2cmr719232pjp.12.1709736902964; Wed, 06 Mar
 2024 06:55:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304211551.833500257@linuxfoundation.org> <20240304224813.73380-1-sj@kernel.org>
 <CADo9pHi0az-CL_hktmpCVcuoiDaUJn2U208=TwAvBM6YQhfFqw@mail.gmail.com> <2024030653-reforest-gauze-149e@gregkh>
In-Reply-To: <2024030653-reforest-gauze-149e@gregkh>
From: Luna Jernberg <droidbittin@gmail.com>
Date: Wed, 6 Mar 2024 15:54:50 +0100
Message-ID: <CADo9pHi0OqBgMsVCf-QaUea+x1viiXHJp+rGn3Jie5noEHv49A@mail.gmail.com>
Subject: Re: [PATCH 6.7 000/162] 6.7.9-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: SeongJae Park <sj@kernel.org>, stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Tested-by: Luna Jernberg <droidbittin@gmail.com>

Den ons 6 mars 2024 kl 15:52 skrev Greg Kroah-Hartman
<gregkh@linuxfoundation.org>:
>
> On Tue, Mar 05, 2024 at 12:05:33AM +0100, Luna Jernberg wrote:
> > Works fine on my Arch Linux desktop with model name    : AMD Ryzen 5
> > 5600 6-Core Processor
> > after the Arch Linux manual intervention for new mkinitcpio settings
> > and version in Arch
> >
> > Tested by: Luna Jernberg <droidbittin@gmail.com>
>
> Nit, this should be "Tested-by:" without the ' ', otherwise our tools
> will not pick this up.
>
> thanks,
>
> greg k-h

