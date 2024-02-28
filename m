Return-Path: <linux-kernel+bounces-85302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFB386B3B8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FDE41C255CB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545ED15CD60;
	Wed, 28 Feb 2024 15:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="KhE2jlyE"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6011F15CD65
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 15:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709135451; cv=none; b=sMTkyXpoXyO1Mo6Ar3wAAD+4+yX9klH3+/Zu5FCBlVLv3QPoklgA98m4Fkwgc83ISNF8UNubiwDryCmw9Y7rTfLi5kMcJgW7hyzxJeOQLaIHC+BsWyCbpS1XTWYADgp1zqMWmKt+FT6X/lAG9B7wkk6XI7rXlvljcwb4Sq4JTUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709135451; c=relaxed/simple;
	bh=qw/lsb8EBSivANarcDEFfqbKUxGjNYj5K/tvppvuWZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PMxgSWG+5ZGvaEfgdA6JW51wDqqFz+z8cTzBPHDBaAUm3quSncTB7mDseOZE+FJExlU0ubYVHKDJE8olyyLbrLm8iYxt4EzKSbeRFdgl42HwGTsN4HFgUmDs5Ikx9V4xJCzDWDHE1mqOvZSgHTZyVmESnwP2hsO9QG3AOk4jdPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=KhE2jlyE; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-412b7bb0bd3so2060565e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 07:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709135446; x=1709740246; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=stUSePaurhatS3Ury/aUkVTpamNEr91HAAR49t8RyYY=;
        b=KhE2jlyEQ8bnsMCHGrLhkDjUYoFfFKvxOdTUIpfYihckDn5QyjwOoW6LBoM8z7E0Zp
         /coRuhNLniDOcXa8M/a8RXZkZDx2FuTzKYS1kA+4Wp3phY45mAF9NVbH52ZXgEyANu7D
         rCt3ZMPOUBKnUPaWCmZ0eG14JC6AMP5yOpHvpVAZWLMUYBoISZtQxa34F7FUJf8bCiHN
         qW30VTfIj7oP9RqKCe7FvpQXtCQwLQG/WM0j6U8sNpaZT0q1R153WxI6h1UkyJYtM6t5
         Wv0fIfXdP3fTW83RvZva91s3+V6QbAyr+RAxun1SAmulOFI+T6/r647AcAw6aBk953rW
         Gq/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709135446; x=1709740246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=stUSePaurhatS3Ury/aUkVTpamNEr91HAAR49t8RyYY=;
        b=hzbQuA/dl0nk9Y0hTtxlKmhYEqRxCdkgquG2xTfZ1z9u0NkXAwFLpjGd1GpVuuwHg9
         LVzzO9XSvQixaAWZXNACWRGhmFAgup4YdyZM4W8VrslMGYR0pjCGnXXxkwZF7Ajbu/oq
         B101WLzbklPAYpghF350vJt8YUp8h7kmAJsYtxoehc3oJTD4Hp19ZZo7L6KPP9d5QBq7
         6ukST3OgpJAROnlzLhHWO8YYrh9GPMeaffVs1Wmus/JZY/V1zIA5Yu0B02U1lYcx4gGJ
         2SuRaICDALKxPB2oMPV6uwejZr/U0A/B0tizexPzPbvsSLhQlnyJeGhtqrIW6ru+VlAM
         yaeA==
X-Forwarded-Encrypted: i=1; AJvYcCXtfFbpSH3jcJLVGFNEN3QCuMN5zukg1jaHZZI/WjZPrjutls3qOgyYtzWodU/baRbKI6zTyEB1Y36RLtlK3POb6/wsQuLWZ5Ifcm5b
X-Gm-Message-State: AOJu0Ywfcg1ljCRR/C6EFM1pur+JbtOhRLH7KW61kAmy1T/YZklxR3st
	hFsddNzubqo30HqGdiqmOQ43N5q0tfqZW0cm7x/kNJDtfrg76f6Bqa9XFTf/rjs=
X-Google-Smtp-Source: AGHT+IG0lOzeZ+/WxvUdFaRJkHfwlU5mdhNXZKdUzkPe8Pc39VME6SVEd3+lj1GdI3bR8LEZsQoyvQ==
X-Received: by 2002:a05:600c:4f4e:b0:410:78fb:bed2 with SMTP id m14-20020a05600c4f4e00b0041078fbbed2mr2843006wmq.19.1709135446576;
        Wed, 28 Feb 2024 07:50:46 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 9-20020a05600c230900b004129018510esm2401794wmo.22.2024.02.28.07.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 07:50:46 -0800 (PST)
Date: Wed, 28 Feb 2024 16:50:43 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Lena Wang =?utf-8?B?KOeOi+WonCk=?= <Lena.Wang@mediatek.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"dsahern@kernel.org" <dsahern@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Shiming Cheng =?utf-8?B?KOaIkOivl+aYjik=?= <Shiming.Cheng@mediatek.com>
Subject: Re: [PATCH net v3] ipv6:flush ipv6 route cache when rule is changed
Message-ID: <Zd9WU1bpoOlR9de7@nanopsycho>
References: <c9fe5b133393efd179c54f3d7bed78d16b14e4ab.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9fe5b133393efd179c54f3d7bed78d16b14e4ab.camel@mediatek.com>

Wed, Feb 28, 2024 at 04:38:56PM CET, Lena.Wang@mediatek.com wrote:
>From: Shiming Cheng <shiming.cheng@mediatek.com>
>
>When rule policy is changed, ipv6 socket cache is not refreshed.
>The sock's skb still uses a outdated route cache and was sent to
>a wrong interface.
>
>To avoid this error we should update fib node's version when
>rule is changed. Then skb's route will be reroute checked as
>route cache version is already different with fib node version.
>The route cache is refreshed to match the latest rule.
>
>Signed-off-by: Shiming Cheng <shiming.cheng@mediatek.com>
>Signed-off-by: Lena Wang <lena.wang@mediatek.com>

1) You are still missing Fixes tags, I don't know what to say.
2) Re patch subject:
   "ipv6:flush ipv6 route cache when rule is changed"
   Could it be:
   "ipv6: fib6_rules: flush route cache when rule is changed"
   ? please.
3) Could you please honor the 24h hours resubmission rule:
https://www.kernel.org/doc/html/v6.6/process/maintainer-netdev.html#tl-dr

pw-bot: cr

