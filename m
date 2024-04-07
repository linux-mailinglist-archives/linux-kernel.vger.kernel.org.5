Return-Path: <linux-kernel+bounces-134343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C975289B080
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 12:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BAA6B2186B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 10:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F7B1DA58;
	Sun,  7 Apr 2024 10:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgEpgTBm"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CA317577;
	Sun,  7 Apr 2024 10:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712487305; cv=none; b=Gvd4/3ITRaC6JK/YDk2d2LvGbrNIM4MjANC87piLX4RHxhS5O9eogagGOjH0lu9ICB65pR1WKMv3yUdM6/YhCA+rJP4NMLglzLgFm8FjvE3FjWQ6qNbjr3XPQuDUnT04CEGU5oA8X0deieKyuXlVVuOivmo+0n1CLFdQy4CAdVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712487305; c=relaxed/simple;
	bh=0FNkFT5QS5lBRnQ/rWzuQ5eMPzd/+jLUn2aoKvSyB0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dVF2qB1yDcMo6ndsBMLBDdMbRTH8b5zX6IWJA3sYDhNNpV2Qd8Dfkzay9AoWPQVHoF6Wtutv06FWa7rzC+XO0kdqLeNdLUFqWJSmSdETZwHbyVVF2bTHNG8YzQhWMlTQd1aeuQL+q5wY9ifGR/yAf1R7FUNIebaolKvHmkh1jMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HgEpgTBm; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-22f32226947so59240fac.2;
        Sun, 07 Apr 2024 03:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712487302; x=1713092102; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hi6IMRhAW/p8+uIEIPIdvOce9xoFdjPwOwNp3TWqz14=;
        b=HgEpgTBmQtBfEgQqqT/1Q9NpYp+DgDFwBV1BuDikJP+qnLimfsqhPopA4r1ayyeWQp
         MuMpNl17fVY6+7w+W2Tm50toY0tW+0nq3t812QcpQUIYISLu+xzZeK/LlYVIMmRgqUqX
         VR6g2u8F4UfHTyeapREncwzHzPjl5nN5/WIGtBYDnLqrUVGjUPkIwB0/iNXkWOhDA16I
         sWmn2oXQfMQs05kq0XklN6v54A0gxDDiY7c0ZjJGHza1bkekGruPBcUhiXptXmUWwfAN
         fgpe8oeHQV9uMVBVZU7vtksw6rhWOLfQ+mPq9vc7GG10FucpSdMUYRoNALK0+NxJgq5F
         IjJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712487302; x=1713092102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hi6IMRhAW/p8+uIEIPIdvOce9xoFdjPwOwNp3TWqz14=;
        b=i0ziCA6FZPU2zCBgJ0Kg/Y+s0dN+jXe1QmlFUzGNNGmdhE4bKBJLk7vZEV5QAGIhX+
         Ce+cv5H37yh1h+1bNjb/WqyR2i5/xsbMmL3NzTdbP2LleRpobdBWU44oPyciEdHh9F5V
         i1GLE/Qjk0oqCpLeY3xKWbIEOJj13P8s4/5Q/7XfvPk/9df603/bHOvtgfiTArSkSD/l
         019hX9U1otCUfyYATRAODz6V/1T9+VBBfBW2OB1+W6S9YULRoHQne6DkYPmR0htG6vpO
         KezfNvAwDSLhM4BW747E+d7zbtk4/Kn/n9irTqFWSHKiwvjO+fYA2jvMJY1b1WHLsBrf
         HfDg==
X-Forwarded-Encrypted: i=1; AJvYcCVnAgysNIA/BUuCEIjKF/njPtt63NpbE1WnfWP3ALr6sAh5PBw7kzTMY8Eyr0RPKnhG4DmxuN0Y4sQKywHFTlJgbEy6VBcZkXwK7Gnhc2YyDBiCNg0m5lwgB0RlqK979GlQk8KHonHJ82o=
X-Gm-Message-State: AOJu0YzYZB6jzzgzN89F9ui440NWh/IU7opeiZ5v1Rvd3ZVMkS3fOSbt
	ZoNFB5IbgV4fg3sUVRCGEmsiARqYkL4n1JDIemDyksCUVk6m+/5F
X-Google-Smtp-Source: AGHT+IGgFKaNNHzF6DVMLndXuLCmjKQEvme5nIK3evzX5ufqHby78SZeGt98w7h6wxysANH3M+t1IA==
X-Received: by 2002:a05:6870:5694:b0:22a:1ce4:c0cf with SMTP id p20-20020a056870569400b0022a1ce4c0cfmr7378479oao.55.1712487302656;
        Sun, 07 Apr 2024 03:55:02 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id fn10-20020a056a002fca00b006ecfdcc2de9sm4607717pfb.10.2024.04.07.03.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 03:55:02 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 03F7A184690B1; Sun,  7 Apr 2024 17:54:58 +0700 (WIB)
Date: Sun, 7 Apr 2024 17:54:58 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux regressions mailing list <regressions@lists.linux.dev>,
	Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Emil Velikov <emil.velikov@collabora.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Arun Gopal Kondaveeti <arungopal.kondaveeti@amd.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Daniel <dmanlfc@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Sound System <linux-sound@vger.kernel.org>
Subject: Re: Fwd: Steam Deck OLED 6.8.2 nau8821-max fails
Message-ID: <ZhJ7gpvvkAiOXM5e@archie.me>
References: <ZhFJZoful6nEFskW@archie.me>
 <4d231dc4-0183-47e1-8bfa-3dd225bf8ea3@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4d231dc4-0183-47e1-8bfa-3dd225bf8ea3@leemhuis.info>

On Sun, Apr 07, 2024 at 09:47:00AM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 06.04.24 15:08, Bagas Sanjaya wrote:
> > 
> > On Bugzilla, Daniel <dmanlfc@gmail.com> reported topology regression
> > on Steam Deck OLED [1]. He wrote:
> 
> Bagas, why didn't you forward this to me in private first, as we agreed
> on as general procedure for cases like this?

At skim it was a rather (subtle) regression, so I forwarded it myself.

Thanks for the reminder!

-- 
An old man doll... just what I always wanted! - Clara

