Return-Path: <linux-kernel+bounces-162077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E89BC8B5590
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EF222827C0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20503F8EA;
	Mon, 29 Apr 2024 10:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ferroamp-se.20230601.gappssmtp.com header.i=@ferroamp-se.20230601.gappssmtp.com header.b="ZeiwofjH"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832C33E47F
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 10:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714387091; cv=none; b=hIMmhM6XRZx8trod4rBFpAr8/aj9TcWPxXL+zZ+qAhrg8eXEfDA8kyP7Z8LqA6xhugwUFaub9ewoe7VjwIvxpe4hn3Y8BaNSU5yRpvtwy+/XVyHrHXIIrMq0ERWF2i6aE4I8Ne8+4o2S9LbF1RLYozDl/kv7mVkUR75cSUqGH+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714387091; c=relaxed/simple;
	bh=NT4axfLV5so4MHdczPOcLAZj95UXq5Tm+h9HSL4IoAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwMTyfiOD6I7Xw+erWbUs2IjEpUpL/T7Jp+OE7VTjtqSjrXslEu+3mQUtxSjh3+dGVnHNZtCX4nWBXLvhE5cNjkvaCrqX8e/90s+g5TB6TocuSPvJQNs7TJRt/CDL7JITFEm1uiZMUCfCK6NVGwHQBEtn7Cu08iHK6AzNmsNhg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ferroamp.se; spf=pass smtp.mailfrom=ferroamp.se; dkim=pass (2048-bit key) header.d=ferroamp-se.20230601.gappssmtp.com header.i=@ferroamp-se.20230601.gappssmtp.com header.b=ZeiwofjH; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ferroamp.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ferroamp.se
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51ac5923ef6so3833364e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 03:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ferroamp-se.20230601.gappssmtp.com; s=20230601; t=1714387088; x=1714991888; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fjzB5kOYHpIXeG3DalUTk+1WzbsP4BD9hLC648e5APk=;
        b=ZeiwofjHmGINVoP2jvQjS5sy5rfYbk07y7BQ88mpKuAtxax14y/8arg6IAAB2zBUe4
         yJirhaT3rxp9hAJvB0hHMNRSQ4BEbe1cphRmp5F03jGvs68VrZH31RGkxgj+dFZRyrvU
         v/otfgY+VwJApivRrPrj4ATngN/+gKBEooSHCZWwwdALV1tMSeEHagZJhM4ddlbwsAGI
         5anntWk0ohMrknTThUVijwI6f6Kg5dkEkj3Rw/P9ZZy84qolPGJHgFo7NJJbfths+zw6
         zvHexqld2hJDvauBBhv51VC+RSOGt+ISTSjWxVVjGFyplkRuIi7M7i19LxpbgCHSSWsv
         t0oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714387088; x=1714991888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fjzB5kOYHpIXeG3DalUTk+1WzbsP4BD9hLC648e5APk=;
        b=kl5jPGUalMjUj01EwFfdn9q9giEEuGyBmw6QhRm/73MVnUNc+rYa3EaG3u5a/eYXbJ
         XZTU7O9p8fLwJUktzCxuF3f/mXWAJqbYvEzo+201/3DsZm9WSTBzHbmHNzjccmyE6KZB
         qUdBNl5y59bYIVi4sYZBbLIGf92CoE2yP4A+BqoMu46wsnUnDwS3mb6Yev82pPOYPGyv
         jLUiK9f3h6CWaQClskb/S9o912Xj+bnpb4hh0it93XmApiGMF2yd28D8sKh/hx4mjzU4
         7ha0uZAUa3cS77GIkn8r0NE+wi7e4/sBJFdqiQdr2v9Z3K5eiwTRheLygIWmD9SHgpkY
         LE+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXTWkm+UhZ0Lu4XujaIn1ZcSKRdoxq8buPSZYUNNvIOaCUz8fYJv/beBhYnPqsLhXr/qj3UaQzOXK8mSNWPlDDxIx3nGsobME90OJ1c
X-Gm-Message-State: AOJu0Yz4diQXrhZ7ItuDNeLrYXjVZGhJlblpufZ6mEgZKI66r5Kou20X
	g/e/P9aPUbpbS44p39XxjmlqSm3JL/FTuQDp/voocARVXK8+/1lc4Y44IV6RtrA=
X-Google-Smtp-Source: AGHT+IEHVNXQsyKshnf6f8TXqzAPKtcUZxZwg655xlhrBAyzGERSWZml0/lCbYiuKWsIzvFvtuyaLw==
X-Received: by 2002:ac2:48ba:0:b0:51a:c904:f1 with SMTP id u26-20020ac248ba000000b0051ac90400f1mr3281586lfg.3.1714387087641;
        Mon, 29 Apr 2024 03:38:07 -0700 (PDT)
Received: from builder (c188-149-135-220.bredband.tele2.se. [188.149.135.220])
        by smtp.gmail.com with ESMTPSA id c36-20020a05651223a400b0051cc38f801csm1080372lfv.118.2024.04.29.03.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 03:38:07 -0700 (PDT)
Date: Mon, 29 Apr 2024 12:38:05 +0200
From: =?iso-8859-1?Q?Ram=F3n?= Nordin Rodriguez <ramon.nordin.rodriguez@ferroamp.se>
To: Parthiban.Veerasooran@microchip.com
Cc: andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	saeedm@nvidia.com, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	corbet@lwn.net, linux-doc@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, Horatiu.Vultur@microchip.com,
	ruanjinjie@huawei.com, Steen.Hegelund@microchip.com,
	vladimir.oltean@nxp.com, UNGLinuxDriver@microchip.com,
	Thorsten.Kummermehr@microchip.com, Pier.Beruto@onsemi.com,
	Selvamani.Rajagopal@onsemi.com, Nicolas.Ferre@microchip.com,
	benjamin.bigler@bernformulastudent.ch
Subject: Re: [PATCH net-next v4 13/12] net: lan865x: optional hardware reset
Message-ID: <Zi94jdVg8a5MaB3E@builder>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <Zi68sDje4wfgftyZ@builder>
 <dd9da345-e056-4f34-8e39-6901bf9c1636@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd9da345-e056-4f34-8e39-6901bf9c1636@microchip.com>

> > This commit optionally enables a hardware reset of the lan8650/1
> > mac-phy. These chips have a software reset that is discourage from use
> > in the manual since it only resets the internal phy.
> The software reset done by the current driver is not only resetting the 
> internal PHY, it resets the entire MAC-PHY including the integrated PHY.
> The reset bit of the Clause 22 basic control register only will reset 
> the internal PHY alone. But oa_tc6_sw_reset_macphy() function is writing 
> software reset bit in the Reset Control and Status register which resets 
> the entire MAC-PHY including the internal PHY.

All right, I did not dig deep enough obviously.

> The above note is given in the lan8650 datasheet to let the user to know 
> that clause 22 software reset will reset only internal PHY but I don't 
> think they mean it for the MAC-PHY software reset done from Reset 
> Control and Status register.

Could still be relevant to implement the .soft_reset with -EOPNOTSUPP as
Andrew has suggested in the phy driver.

> 
> So in my opinion, I don't see the need of external pin reset as the 
> existing oa_tc6_sw_reset_macphy() function does the software reset of 
> the entire MAC-PHY.

I agree with your assesment that this invalidates the problem I was
aiming at solving.

Additionally I figured out why my setup did not work without the HW
reset, I had missed a pull resistor in the schematic that held the IC in
reset.

To me it seems more feature complete to have a driver option for the
physical capabilities of the chip, but if it doesn't actually solve a
problem it might just be bloat.

> 
> Still if you see a need to have this external pin reset as an optional 
> function then it may be needed for all the vendor specific MAC drivers. 
> In that case, reset-gpios parameter value alone can be taken from the 
> chip specific device tree and the remaining code for operating the reset 
> gpio can be moved to oa_tc6.c and the function name can be 
> oa_tc6_hw_reset_macphy().
> 

If the consensus is to keep a HW reset I do like this suggestion.

I won't push for this to be included, if it is, I'm happy to address the
feedback of patch 13.

R

