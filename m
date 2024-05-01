Return-Path: <linux-kernel+bounces-165353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC28F8B8B9F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AD9D1C2199E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF60612EBF3;
	Wed,  1 May 2024 14:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3mHW2JX"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FF41527B0;
	Wed,  1 May 2024 14:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714572128; cv=none; b=hM/0ucC2jtKbOuAMLMnnmPoQMQ8RvbkrQ0OgEfQmTV6+7MmG+gm3mEsDzs/qVNbcmZ+5bMM9MsJ664fh13j9HGtQUpkj/VTOHiSlevUTEJcnoOUey8vWq83ccTiRyJLidaEo4AYlXrg5keQ9d/2EiwtmDb2kMoVOxMUX8kMEdgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714572128; c=relaxed/simple;
	bh=iEPVtQCPaROhqp+EwVfARizPvBkYYoRA/AP+4jZZpOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U0ST3GHgLr0GB3p5G9s1I0zC8ooYL/SPf64invw0NGrO41LR3zf6Oug2JlWdi9q+ocypdoV2Sjnb1qOnOKBdyTSY+DRmeqfPZaOrVInZ+by3Kig9cyCgUoiGPEmK3Q0BIUWx9gkGbff12eHVHdQWv3HJBw52rBMh1AHTaxAPwRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e3mHW2JX; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1eab16dcfd8so58808195ad.0;
        Wed, 01 May 2024 07:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714572126; x=1715176926; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V0BdnG/l27ArELjTgywItVcooJIOFPA+WeMfuqzMrXU=;
        b=e3mHW2JX8vFIdO+1t2c3OElCli6gWnr5vziSsy7Sj4lAFOKbL39igIkfGBX0mQcEg+
         lF0GMWUWWYb+HHaHI9LAQFddkmHPHOTBYn8DI7JeP1GnGDRTS4hGxdRdR5P+sGDo1LKQ
         RbItRJjpOqMv/o98LFU5XIUNou967Iq1PjyuC99gQKwJjZP0l827kkI2oyX6UOPbAHDS
         KqwtZfed2dBthG9uzHLEt4bQMJ0pQilpWq2EwEUsyEj+x/BM2gXCpxH3LAwsDLj/Q6t6
         1N+z0M9A30faBiqZQRKKAd4zX2j6zfRWonoZ5QZPv0oWqyRI2Ou8J9DlpCfOHNyu9ip7
         2iBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714572126; x=1715176926;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V0BdnG/l27ArELjTgywItVcooJIOFPA+WeMfuqzMrXU=;
        b=cUfkQNEz0O6lxhCtLF6IxC4i2yAUtSV1fPo6ReeoNUwzLYb2ixsz5xu3uGteWrZRmK
         e6kW5Fzw3poxzORXWiVelmi/XbAWwc98q66kUn/QIWast9Mes8oHw9AngAWAMWWX6PwH
         giyc4LHUN+rcjUrXf+waRb+XjEcsJHCkrREDQXnl8Debo7xht/MBaxHIKFPlnP+C0HQq
         DDi3lat79sb63pHrIN3jF5qR0f9i2xAMc6I7f9zfdZPD8CmLEpV5dTs+2by+80MKliBE
         /Rs26UZ6GfCQKLkYPRgrGPm28vur2TyBxcXl40NzzgfphZTxbAXlLwd6qnHp5+gFztEz
         JWiw==
X-Forwarded-Encrypted: i=1; AJvYcCVewpR2LvsWAgQNwrYC0uNr9H2lNJmPSCqMRieqCou3im/7YCvst+Y2VhWx9IEhpHP6lou9+Adz1uFI1w9qOc7fwGT4go4KbiGF5pTxgdvkB0Njt6GaRQt62WSi3aF0n+AWqyQAloRebcpC
X-Gm-Message-State: AOJu0YyConkflCc2Lh+mqCLMsOVOkKDKNvD0UYHdTr5DRCx2R4dtOe3Q
	v70Rq+P5Wr4B3M0yu+kpkOZJXbxTCgB6PYGMET6taPXou9If8ShP
X-Google-Smtp-Source: AGHT+IGb8MuiX71DsiTtDJZTkooQY6i2mOWK67mo/shUPtOeVU1RY2JqC3XmWVAfBU0lZvlXbwgaYg==
X-Received: by 2002:a17:903:1c8:b0:1df:f681:3cd8 with SMTP id e8-20020a17090301c800b001dff6813cd8mr2936869plh.12.1714572126198;
        Wed, 01 May 2024 07:02:06 -0700 (PDT)
Received: from hercules ([68.69.165.4])
        by smtp.gmail.com with ESMTPSA id u8-20020a170902e5c800b001e425d86ad9sm24148760plf.151.2024.05.01.07.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 07:02:05 -0700 (PDT)
Date: Wed, 1 May 2024 08:02:03 -0600
From: Aaron Toponce <aaron.toponce@gmail.com>
To: Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Eric Biggers <ebiggers@kernel.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH] random: add chacha8_block and swtich the rng to it
Message-ID: <ZjJLWy4Y5Y__JCUF@hercules>
References: <20240429134942.2873253-1-aaron.toponce@gmail.com>
 <20240430031105.GA10165@sol.localdomain>
 <ZjB2ZjkebZyC7FZp@hercules>
 <20240430162632.GA1924352@mit.edu>
 <ZjEf2VV4igcCtkRE@hercules>
 <20240501022201.GD1743554@mit.edu>
 <CAGiyFddFb1yZ3kC5MP+UgqsCATcAcFvZLTXm_bCv3MsSnwAWcQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGiyFddFb1yZ3kC5MP+UgqsCATcAcFvZLTXm_bCv3MsSnwAWcQ@mail.gmail.com>

On Wed, May 01, 2024 at 02:38:52PM +0200, Jean-Philippe Aumasson wrote:
> Switching from ChaCha20 to ChaCha12 might still raise eyebrows but I
> dont think any respectable crypto/security expert will suspect a
> JiaTan situation.

I also mentioned this earlier in the thread; that is, to switch to ChaCha12 if
ChaCha8 makes us uncomfortable. It's not without precedent also:

- eSTREAM recommends Salsa20/12 in their final portfolio
- Adiantum uses XChaCha12 
- Rust uses ChaCha12 rand::rngs::StdRng

There may be other precedent of ChaCha12 with from non-trivial projects I'm
unfamiliar with.

-- 
 o .   o . o   . . o   o . .   . o .
 . o   . o o   o . o   . o o   . . o
o o o   . o .   . o o   o o .   o o o

