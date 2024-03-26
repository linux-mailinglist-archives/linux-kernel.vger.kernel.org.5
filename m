Return-Path: <linux-kernel+bounces-119581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 394B388CAAD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C19F1C653FD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118241CD2E;
	Tue, 26 Mar 2024 17:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fs8hLRmu"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6BC1C6A0;
	Tue, 26 Mar 2024 17:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711473880; cv=none; b=fplFy0Jejr2JldnUeuNF0vaP/pfsI4Du+UDrlzdINyzsBhfI+piiKPmXvCY7obArL8IvaMx9KKydLiL7tQuFkXySBeVSIF46XXW3ZqcMrVMhS4C+bvQESBdJROBRA2cHBrgkejQU5AYevJljx4qvQJgsb6K2KCI0a3WbRCmmLuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711473880; c=relaxed/simple;
	bh=8MxJLVegabRBz98Kr4jfe2uumdXdL9WWQG6U0d84h20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=juQCDd00xGOlBF5wB1plP4ycQ+gHXgpzqmxA1TDbqNhgi8JU+QkFhCMCyAMVGUM5AbcxuEH5s+Ad6mONqIp+5AtCO9qirLuA9EVARa24P2Yz7O06TQlAe6iMhWo7UhtNrmLKwy3eQ3rbuRAQHESFkc/3zSaZlUmXv8GjFot+PTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fs8hLRmu; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a44ad785a44so664366666b.3;
        Tue, 26 Mar 2024 10:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711473877; x=1712078677; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HWssbRS4LXejM/4y1x22PFUSQF3V8Eb/sTfSEE3bEaM=;
        b=Fs8hLRmuIUnaqsXFKFv/WSa1dhc4bKA+1GdDnF9AZaffwUlQk/Rkc12AEL86+PXuH0
         MSkjh6Mi4xqB3nQSjujEuggVgWzgShBnuLFTvgvN4JhXnWJMSp+b3og2Q0slZVfp0Qib
         FDwLxeXGyIp2PlLOHv1xcivAtPcvKY5+axIv65wwNzo7G9b3kRMFYt3rYaxl08oYxads
         m7PeYhhAFmvYUKP/4Nlt938GBYG5XnsJeADS0kF7c22Rw84vrru8950H8/WC+t43DzPh
         3I0wafBhuoUEcdaucQeBsL+k+VrckBqPtsKKlt5kFY5qyEINwUWGCmtKUbex4drEPiH/
         C5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711473877; x=1712078677;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HWssbRS4LXejM/4y1x22PFUSQF3V8Eb/sTfSEE3bEaM=;
        b=PpwfilFLiy2db1JLmDj8Pswu1UGMHTOrgyHrFZtoT78YqHJ0NLZHZw0/BYbuK7jbWW
         /TBX+m8Sgno8hLTnJEWsLkx/Jxs4mzRRMAQQvec707Zzr8v2XADJYu5yzjsZajZ/CbMm
         2BBY9104zNhbDS6lXVB1B0xG9RiePnOM+T/6xov9r+RPQMpLZa3CDbS3nWZZbDuS2HY9
         qPIlWaa3yD38c0FFOk9ckOq31mGQR8vZPWbdY0ufwuao8e6B4JC1r84ZSb505T9UN27s
         dpCI2o8FAO7ZrVeyiz/a5wiPD3bLz1u/scsW1gmFzJqUcHiu1LzzQc6dEX+Z5P/U0mo8
         PELQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMgxCfu8hyAJlEhYaqIyRl7sO3y2mK3zHj4JseyENz7qUJOU0gYTOWrsQShsTvVpMBY2sGW/AbZgdDhlLK5EQxfuN5SY+dzdMyLM0mob1BRdgMa81tNk92euxqVT+FQ3lPgk+dncKEsQ==
X-Gm-Message-State: AOJu0YxkhvgUEaCZ+Y7ZEVwZ+Fk1ypMWwk9Vj3XyKF8AmHZZZV0ky4ZG
	SH0bNLae1DcOUu/76W7p114sryMpfGDg0ncdiiOjRym3kAz9/gAb
X-Google-Smtp-Source: AGHT+IHmJMH1ofGnAheKhTqTGvl14MXcrHx5BC6Ai/Drqkfgs1jFGFFCrX3fSqGrAeWzK2LgWEyJdA==
X-Received: by 2002:a17:906:2414:b0:a4d:fe65:631b with SMTP id z20-20020a170906241400b00a4dfe65631bmr196855eja.18.1711473876829;
        Tue, 26 Mar 2024 10:24:36 -0700 (PDT)
Received: from chinchilla (92-109-110-130.cable.dynamic.v4.ziggo.nl. [92.109.110.130])
        by smtp.gmail.com with ESMTPSA id m12-20020a1709061ecc00b00a46d04b6117sm4438352ejj.64.2024.03.26.10.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 10:24:36 -0700 (PDT)
Date: Tue, 26 Mar 2024 18:24:34 +0100
From: Matthijs van Duin <matthijsvanduin@gmail.com>
To: Robert Nelson <robertcnelson@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Kridner <jkridner@beagleboard.org>,
	Drew Fustini <drew@beagleboard.org>, Andrew Davis <afd@ti.com>,
	Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uio: pruss: Deprecate use of this driver
Message-ID: <ZgME0qSL3KXCD07I@chinchilla>
Mail-Followup-To: Robert Nelson <robertcnelson@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Kridner <jkridner@beagleboard.org>,
	Drew Fustini <drew@beagleboard.org>, Andrew Davis <afd@ti.com>,
	Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20240325210045.153827-1-afd@ti.com>
 <2024032631-excursion-opposing-be36@gregkh>
 <CAOCHtYjauA+BAxZJBMTaxxaMGcvipP9=ZPeWe4FiNFs_jpq6dg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOCHtYjauA+BAxZJBMTaxxaMGcvipP9=ZPeWe4FiNFs_jpq6dg@mail.gmail.com>

I'll write a more in-depth reply when I have a moment, but right now I'd
like to point out that the uio-pruss driver in mainline linux is for the
pru subsystem on the freon/primus family of ARM9-based SoCs (OMAP-L1xx /
AM17xx / AM18xx / TMS320C674x / DA8xx), which is not currently supported
by remoteproc-pru.

-- 
Matthijs van Duin

