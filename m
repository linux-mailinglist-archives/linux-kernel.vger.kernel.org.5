Return-Path: <linux-kernel+bounces-69703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7871858D78
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 07:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C1FD283469
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 06:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E3F1CAB5;
	Sat, 17 Feb 2024 06:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JiTvRVn4"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469E71B7E5;
	Sat, 17 Feb 2024 06:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708150714; cv=none; b=WkEklN9qChWzIlIbThPtF/TycrG7f2vX0bmFicx1w6rM68deHMLxCNq9MDCVHR+z+Rjk++TCFp6z9XMPhJSk74yROQW9ubgMoAkns3Jb4BBKoWafkPXzTPxRsbT1kOQDtC9DqPLY6GPnjwCGzQe02pPD/dXHwoeHKDGx0SIAOQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708150714; c=relaxed/simple;
	bh=HDGjIiHl6JexBertXG8SmqhqLZJIWv57C2E5U+Ef8c8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fXGfhYeY7V2w6x7dm/ygOjr2mYJLJQkpozQe11mEhiQIdVzKNtcBQ+fWPbP1UHFGZttqr8rsHL9/nNQbjMWi1FP3JuVjPvE6glwcpzQNXOgytml9VANEClWgp7uR8tfUtMyPZVCcy38sr5UDoAe63UUcqthQ7eQLLPZaX7yVIa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JiTvRVn4; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dcd7c526cc0so3054615276.1;
        Fri, 16 Feb 2024 22:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708150712; x=1708755512; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HDGjIiHl6JexBertXG8SmqhqLZJIWv57C2E5U+Ef8c8=;
        b=JiTvRVn4R/mreZBNbyEpyjzBY3+IlXOsqwqGsvyQE1Vu4Ubs2cLUuCSjEnqikaOqiC
         KY0qFBjxXgVAFLKP7fp2PG6r8p6y/Y8gswVzv9DB54+Fz9wp65dL981ekfhMo3ciVwuP
         4K14lQZ39YHc8RTWr27YvHA5zEdRuiYQishQOpUfshNbDCamLcTZBeNd3IK7YPCtdPuH
         TLFFTE/hFgDAq2kKX4INcUf3D2UaKAsst5PHyGsjlKd9nRLUYstVOhIL8jXOaigCy9pn
         R4NKTpv1S8uUVZ44JbTQDx8vn6Yj4FWxBkc0WwPMCYfE9bRXQxpmQGjv3L0Ekz1DKjuI
         4kig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708150712; x=1708755512;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HDGjIiHl6JexBertXG8SmqhqLZJIWv57C2E5U+Ef8c8=;
        b=nMwzl6kpkrwZq/q8+mBeB1SEn32uHsF/Ufpc/nxxEP5cHrf1osyCTMWmWoEEquWJ19
         0eTyDqyOb815pV5SXh09gIJDOARA7AVLaQ0+U3BYLTD10I90h/wn3fjqqKoEOVx4JdSF
         4lk2OxOTWL9i6+MSi2sx/yLvjBWvBaF4/nd//0brYgXA7kf9Ic4V7wSCD3KBEdyjJa0E
         BZyaQPvQfI4qB1kjd0fHAh+S1HKcz1IrPrEIyf4KMKeL89FnYLkM4+NYFRFsK0yZ/hYc
         fI/emQ60ezF5cnYJHWOK8TvllqsP6aukjYwbDLJ0cJ28/4O3YJCMAfH4PN3mn9Goitt1
         SR+w==
X-Forwarded-Encrypted: i=1; AJvYcCW7ukEHWNmVNseyPJq2vQACFAtaL9n5qXfLsxgGGWKo5k083JE3u03E/UK37iztnAwHsu47ZXrN6F4c0yAWtfUhJ4dR5Q9h7hVBPPHEu6ZQDjOeGU3ck/cmT1HjToBmGsbKI4+EFaGhDJpA8z2Aajlpg9HtZfOG0wopFsfqfNW/
X-Gm-Message-State: AOJu0YxXLpDbbnyid1jqVu/hpH8/0U+uEZTTY+1U3+kUDTfPfdRmGLIS
	tgbAgFNNKCelMKayflxdc/bWEoOvO0jbrBJxT8o9GWu6CSQnmotXAPgeI4MauQwyMPuWnnQefwI
	RoFPjRWjs2ZcS8hZYmGDIr2ef/iU=
X-Google-Smtp-Source: AGHT+IHCh7huCKCOiKjghM4S6CgmsfthTmyxRgJc2uBOcAsh9Yi+EnV9V7BrFKj6FNlpMEtJpumjLDc02x1w5ZVLeXU=
X-Received: by 2002:a05:6902:2487:b0:dc6:e5ef:3013 with SMTP id
 ds7-20020a056902248700b00dc6e5ef3013mr8370316ybb.0.1708150712074; Fri, 16 Feb
 2024 22:18:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212020403.1639030-1-hayatake396@gmail.com>
 <CADFiAcL+2vVUHWcWS_o3Oxk67tuZeNk8+8ygjGGKK3smop595A@mail.gmail.com>
 <8eb6384a82fc4c4b9c99463a6ff956f04c9d5e33.camel@redhat.com>
 <bad0da2c-546b-2e05-feea-d395439a0bb0@intel.com> <CADFiAc+RP91PfEBAnwbABjrHJkdLc0=nm3_TE=+ZaN1AiVQEEQ@mail.gmail.com>
 <b227037c-16e0-37b5-a5ac-cf8eb0d3556f@intel.com>
In-Reply-To: <b227037c-16e0-37b5-a5ac-cf8eb0d3556f@intel.com>
From: Takeru Hayasaka <hayatake396@gmail.com>
Date: Sat, 17 Feb 2024 15:18:21 +0900
Message-ID: <CADFiAcLo+3L1DVHaKpkPg8MXq=rDt6ykO==Q5hrW_-yV_mKbsQ@mail.gmail.com>
Subject: Re: [PATCH net-next v8 1/2] ethtool: Add GTP RSS hash options to ethtool.h
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mailhol.vincent@wanadoo.fr, 
	vladimir.oltean@nxp.com, laforge@gnumonks.org, 
	Marcin Szycik <marcin.szycik@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Hi Tony-san

Thanks for your reply!
> Everything is good for now. If we have issues or questions we will reach
> out to you.

Okay. Let me know if there's anything I can help with:)

Thanks
Takeru

