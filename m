Return-Path: <linux-kernel+bounces-147748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8738A7887
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 01:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B1FD1F2229D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD6A13A415;
	Tue, 16 Apr 2024 23:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6KzOwmj"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C722375B
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 23:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713309698; cv=none; b=kvqC8Xb+kulDfmzuf8tTOREUnqkmrliRR1n/zFRPTdP5bUGp5GXhNXZ+z3pg++LrPtIJ/xXbGXpI6uvUiUOdKXkpwyz8+K1uqc32/MRonbLiiKxHC1NHrOGm+J54Z/jjagu0cbY9ERwRdpN+Eoe2JeixpM/d1+u8j4qzhnkeHuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713309698; c=relaxed/simple;
	bh=Yq3XYE5PQn1xLC4Ak5UqnG6QBcosEZ2V2zfPFVJIjp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IOQbADC6TWAY/Y6fmXDeB3zXpBMb31E0Ufw7GlpgmbRWdm9WODOr9fpSuk1fpH+DyrhvhF1VUrk5nFCN9DgAiwk+NpGJ/+ds2yLHeve93nhMdAttriAKtfzJ1l2jlum1m7qFaUho0J/eJdS15FCWWhcQZOW4gT0v72uS1Fvpec0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R6KzOwmj; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6ed0e9ccca1so4551997b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 16:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713309696; x=1713914496; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+fgpHfTT4Bxv+6WWCRjV8ylNM9LjcYeL1sBjLxOjPOk=;
        b=R6KzOwmjuOMT9YlICG+69oNm2zQd3tKYYLlHlTgeVi5BtwEp5tD9pMfHEcrSvlMFRF
         haP7mkAxhHp66+wiRw6diuDgN0GB503M2og7hsUhCb4sOdyKrRhcMVV9pvozHSQFgdY9
         HcrJE3rQw20ZKI7INucZV2EvwwuDNj7F112Siemtmn4fM653Q9FjrIKPnAR/5XA0Ta1Y
         33NcNrs4eFwJqRNC93KkwEvWZyeHimzIlLETf0PAlUQerVEilW1bkhcLEeavw//mSwFE
         VokVFJx8OBQx0yQOZ7faogiqlJUL2Bh1RzLnTIZq77nMlCr1rMCYg88V2vlwUpfgVLQv
         941g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713309696; x=1713914496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+fgpHfTT4Bxv+6WWCRjV8ylNM9LjcYeL1sBjLxOjPOk=;
        b=iB2cFwoVfIf8hHnIv6rDqS0/Lc+45OXSTyIw5dE7aSCD5fU+TKm1KOsW6BrgoGI0/i
         KK9hiC2N3CCDpnkSVgo7gZFlGma+3R+kNZgbM+Mx2Y2SDNtkfa/0VIPqUVSIwJ2d5Owe
         Ku2lyxigdhdGfLubTribLU5r6+jSh1X/TQhwyhc8zETb5KUMhFgEwg0Nfe23s6NqDKoM
         wALIuIZV7pPy73rPqDARECyv2QvSBrQe/s1N33wD7qnN1yi8B9GAJfUAQ96dvuOPV9pB
         iqaeKM1JqhzgZ5U2utEfx0dou/amHx20qVnMq2Du4QQiv92At2C976WWQUauguq7jJud
         cpIw==
X-Gm-Message-State: AOJu0YwEmOmv2eG+HfmL1rXTotGEvYoGQn8XskRpzIx1BLsVZlfwJaeF
	8Y+VRgqjtV3BlmojiuYT/FSDrfmQbwmsiBicq2uVkKLVbXN9DN3I
X-Google-Smtp-Source: AGHT+IFRj3M/Wa9lIIhbJrMGRGXExG4U8ICEyuvtKUVCJx+R1O1y/hFqrxZp+bEM2ETZ7slNNsafMw==
X-Received: by 2002:a05:6a00:2295:b0:6ed:1012:9572 with SMTP id f21-20020a056a00229500b006ed10129572mr15448814pfe.29.1713309696504;
        Tue, 16 Apr 2024 16:21:36 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:6f51])
        by smtp.gmail.com with ESMTPSA id t6-20020a056a00138600b006ecef9e9615sm9483775pfg.200.2024.04.16.16.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 16:21:36 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 16 Apr 2024 13:21:34 -1000
From: Tejun Heo <tj@kernel.org>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Bjorn Andersson <andersson@kernel.org>
Subject: Re: Bug 218665 - nohz_full=0 prevents kernel from booting
Message-ID: <Zh8H_vG2dQLOjoIB@slm.duckdns.org>
References: <5be248c6-cdda-4d2e-8fae-30fc2cc124c0@leemhuis.info>
 <enqg6mcuhvff7gujjbapdiclicl3z6f2vnggcsg65pexipyr3o@4men5fhyt3vb>
 <28c84b3b-f68f-4f45-8da1-9c3f9a342509@leemhuis.info>
 <7kugx5ivbplwwrcq5zp37djtpakl55b3pfy36gpbsbcx43dpcs@uheu6iv7gm7h>
 <81149f18-0132-4ace-8c71-1b75790a88e4@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81149f18-0132-4ace-8c71-1b75790a88e4@leemhuis.info>

Hello,

On Tue, Apr 16, 2024 at 08:08:07AM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 12.04.24 04:57, Bjorn Andersson wrote:
> > On Wed, Apr 10, 2024 at 11:18:04AM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> >> On 08.04.24 00:52, Bjorn Andersson wrote:
> >>> On Tue, Apr 02, 2024 at 10:17:16AM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> >>>>
> >>>> Tejun, apparently it's cause by a change of yours.
> >>>> Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=218665 :
> >>>>
> >>>>> booting the current kernel (6.9.0-rc1, master/712e1425) on x86_64
> >>>>> with nohz_full=0 cause a page fault and prevents the kernel from
> >>>>> booting.
> >>> [...]
> 
> Tejun, I got a bit lost here. Can you help me out please?
> 
> I'm currently assuming that these two reports have the same cause:
> https://lore.kernel.org/all/20240402105847.GA24832@redhat.com/T/#u
> https://bugzilla.kernel.org/show_bug.cgi?id=218665
> 
> And that both will be fixed by this patch from Oleg Nesterov:
> https://lore.kernel.org/lkml/20240411143905.GA19288@redhat.com/
> 
> But well, to me it looks like below issue from Bjorn is different, even
> if it is caused by the same change -- nevertheless it looks like nobody
> has looked into this since it was reported about two weeks ago. Or was
> progress made and I just missed it?

Can you elaborate why Bjorn's case is different? I was assuming it was the
same problem and that Oleg's fixes would address the issue.

Thanks.

-- 
tejun

