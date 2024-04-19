Return-Path: <linux-kernel+bounces-151070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 208AB8AA89D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 08:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C96081F20F6C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 06:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865C23D55B;
	Fri, 19 Apr 2024 06:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YKl8PeqU"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8585237165;
	Fri, 19 Apr 2024 06:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713509213; cv=none; b=kbY4gJJGvvU6ul1sK6Li5sP6aSYKukHTTUm9pjj10XVHBgH9jLy1hzEGxmxl43Ia3ZsxojCyW+fqLZkbPN6yQBRYUFLWt8RnAQdbSWLXiA8ymNh38r9o11hopvhG4rhu/ed9bhDDUIxdMZ2TOm1cusyDVvueZAocCeWMf0u/nZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713509213; c=relaxed/simple;
	bh=6Lk2R6y1Ms4neAaNsZ7lhhpYZy6AgWbaZOXp8KTkQac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QSFzIGSv6R7TDAZmb9MyMSczD1CQWilv/htrX2CQ42Pho0uHSuvsOvujGfaZ+0GLp/1Kq54so05tu729np8ykns212L7XGOi9rZ/5OteIDoZQoFbL6Tu1QkjWcEkV56jEL0R9DLpz/7CwP3hbx73dgLCTNJM+7OEc3Py51pgCY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YKl8PeqU; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-de4654c3423so177691276.0;
        Thu, 18 Apr 2024 23:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713509211; x=1714114011; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XbSzBtnw4hgq7px4JzzkDwNDE3yBxvZABkHTmlQ2vAA=;
        b=YKl8PeqUEBuNCxmpa+lR3tExhG5LmRS8jHb2fAMVCUhU7s5lGFalVM2hcx5Za++tvl
         nKHwwmEEcgpxm0QbrVgzXoEfNRScRWugBrqlRFzNv40csy2j/P0zCS96ljTbDFNfpoyH
         rlZ2xAdKPGW6sdZl9E21xtpwwhLklPnMEHzDrY5976lvYZQxepGkaJ9RMuglKCyT0/6U
         I76BMr8MpCOkVlbeh9S3cNzm03+3RtMgu5w9w1IxqSpz579+MZ1l592nMCXizvyVR+jh
         ylpVTQk3i3aCzcCqLE39LNEGTEIL8/6GuhMB7FMvYPuDB+PJAy2SEQWnvPSn5rEpsA3Q
         inXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713509211; x=1714114011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XbSzBtnw4hgq7px4JzzkDwNDE3yBxvZABkHTmlQ2vAA=;
        b=riGWHki7eg9WL7MfMN25Uwz9p59+OEpKoCsNlmWi/2fx8GM2K+j1mUjjEveJEmmGpC
         qoK4I1LBx0ThQYQUkwh3vaqvgaJRZ8n1DHpUAjdFCWs9oviUhNiehSXAxQwOnIWw5iKV
         CSqK9uWopJyb8LdA61vdroqU2XJGy4BA8QZXJxJxZ/70vI2N2b8LfvLPzuNQKx7hxmMm
         XI3dvCj1pmXicRZPvoBxy0IlR14ENaai4EFKdN4fEvnUepaXPYVuswPBhoF+9Nio0DrB
         mzWEtaClsnqfzNovrs18Ir5V8wAHnhWRe1mhB2cSNGQkQKUEhNwTvPzEEhRrAi0bOEOk
         mkFA==
X-Forwarded-Encrypted: i=1; AJvYcCVE30Z1oDllOqGlLqdQ5h1P0BK7tXilBnH0u2dJZlvpz72/G9pAOgW8Gjolzx4B74P4QrXgn46fXew+XSg+PWQLMZTmbxMSHkMay63Z6a5SOUEuc0vcv40KrW4Jc5GHja0K90bE
X-Gm-Message-State: AOJu0YyGQNM6FiVQQrI6DsP/TaCGd5urG7ccwRYguel0ukLdXiKFts5P
	tlBgKEK/iKdIKbPJ3kI6QhGOPPtmG3+sPdvFNTfiKkQ54cHH6TBF
X-Google-Smtp-Source: AGHT+IGLlCfPF0PKkwCVFiCiRzCfoD021zL84oexxmQJIgFwc875Wlv9wzHYbxGcRz0ExGpQvo1mlg==
X-Received: by 2002:a0d:fb06:0:b0:61a:fac1:b045 with SMTP id l6-20020a0dfb06000000b0061afac1b045mr792092ywf.3.1713509211428;
        Thu, 18 Apr 2024 23:46:51 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id p66-20020a0dcd45000000b0061b04dd1806sm666269ywd.50.2024.04.18.23.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 23:46:51 -0700 (PDT)
Date: Thu, 18 Apr 2024 23:46:48 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Russell King <linux@armlinux.org.uk>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH net-next v1 2/4] net: phy: micrel: lan8841: set default
 PTP latency values
Message-ID: <ZiITWEZgTx9aPqIy@hoboy.vegasvil.org>
References: <20240417164316.1755299-1-o.rempel@pengutronix.de>
 <20240417164316.1755299-3-o.rempel@pengutronix.de>
 <c8e3f5d0-832b-4ab1-a65f-52f983ff110a@lunn.ch>
 <ZiAtREiqPuvXkB4S@pengutronix.de>
 <b44a4aee-f76f-4472-9b5c-343a09ed0d33@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b44a4aee-f76f-4472-9b5c-343a09ed0d33@lunn.ch>

On Wed, Apr 17, 2024 at 10:23:07PM +0200, Andrew Lunn wrote:
> I suggest you go read older messages from Richard. It was a discussion
> with Microchip about one of their PHYs.

My 2 cents:

User space has all of the hooks needed to configure corrections for a
given setup.

Hard coding corrections in device drivers is bound to fail, based on
prior experience with Vendors not knowing or caring how their products
actually work.  Vendors will publish value X one year, then delete the
info (to avoid embarrassment), then publish the new value Y, once
customers have forgotten about X.

So, prudent users will always calibrate their beloved systems, not
trusting the Vendors to provide anything close to reasonable.

Ergo, adding new magical correction in a kernel release causes
regressions for prudent users.

But, in the end, that doesn't matter, because prudent users are used
to being abused by well-meaning yet misguided device driver authors.

Prudent users are wise, and they will re-calibrate their systems
before rolling out an updated kernel.

After all, device driver authors leave them no other choice.

Thanks,
Richard

