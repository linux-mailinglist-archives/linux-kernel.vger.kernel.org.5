Return-Path: <linux-kernel+bounces-19704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0770E827137
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 472FDB21F23
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AB246559;
	Mon,  8 Jan 2024 14:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgWTV0Q/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB5146433;
	Mon,  8 Jan 2024 14:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40e45504006so7078485e9.1;
        Mon, 08 Jan 2024 06:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704723914; x=1705328714; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T3YcN5sbPM8QQgL7TIIf/pYnEaVq2EW3Yd+zPw8iM0M=;
        b=kgWTV0Q/UIfY3Zh4OV7jtY5LAKKV7cw0bTdURfdlfb2NLrgjpM1ky+yPZ9oDwb+7mc
         EeJZGCleihtPoDtfCCrT5pOTHe4lujEuLaHIj3QhQLZA+bt1oDnJgMwYCde+d1kLwStz
         su6TJFGE2Qg0M+nPvj2ttwxX0tbD97zSck8bvcYIqPL52MFrasvqXn7iQvVoHCERwLUs
         CB7xtZbrhLDgztkQe0OfymVSEmiDZTJKgFSLWvO7/Z3mLf83iSuona01Q2eVL/rERr/T
         iJE3cbz8YFXJvdb+gMRnGBvRH+VIRvRb3MYEOKIawbXs/gyL2Pa3ASRfgihZMqQV9v+b
         y8pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704723914; x=1705328714;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T3YcN5sbPM8QQgL7TIIf/pYnEaVq2EW3Yd+zPw8iM0M=;
        b=DeF9TwuO0DE67W7PXpnwepRXjSMsyRu37gw8XALPpeppjYYSX6RvalfixjypBFUedT
         KR//C4r+SYe5B7qDvFtHN50jYF9wXJ/MC+MjX8dnVG2EbrlY7u+xke/7ytupKXoEynT9
         +EcBjRcJwRJucQ0uL/+IaooY7I9+WcHfiH5O/Zxk5g1irXYndb7nWEj3mddM61D98Kbq
         lPU0+uO3bDmvqRfp9DvOSv6KYKlssl7uj/Yo6ZQtlki6jAPb5kcFiFNpRp79iwRh/VCD
         QDEUG53Vfhpa7WlEI/wuIr2MKoCIG/TFSVysT0GbxVJrryDlaBhQyO9Nx0LQ2BlLWm/s
         RDcg==
X-Gm-Message-State: AOJu0YwcA21uZzYevCy8qfxNF2lFvfCUn+UokAW9FF4kjxPOKmQK2tfR
	IkoEAUZvKuv/AtqwJKZ8J0k=
X-Google-Smtp-Source: AGHT+IEglyFJdGhakyHH/+5PUo/SAN0kklXc9OmARRxulYSuS+w5F4Ax8NK+bHw4qkVhBJ6VGtPHWw==
X-Received: by 2002:a05:600c:2317:b0:40e:482e:7ec1 with SMTP id 23-20020a05600c231700b0040e482e7ec1mr571443wmo.31.1704723914180;
        Mon, 08 Jan 2024 06:25:14 -0800 (PST)
Received: from debian ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id hg24-20020a05600c539800b0040e38859c47sm2673wmb.16.2024.01.08.06.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 06:25:13 -0800 (PST)
Date: Mon, 8 Jan 2024 15:25:11 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 net-next 1/5] net: phy: Add BaseT1 auto-negotiation
 constants
Message-ID: <20240108142511.GA36576@debian>
References: <20240108093702.13476-1-dima.fedrau@gmail.com>
 <20240108093702.13476-2-dima.fedrau@gmail.com>
 <c9ede0c2-ec37-48b1-9ce7-8a1543c828ba@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9ede0c2-ec37-48b1-9ce7-8a1543c828ba@lunn.ch>

Am Mon, Jan 08, 2024 at 02:49:02PM +0100 schrieb Andrew Lunn:
> On Mon, Jan 08, 2024 at 10:36:56AM +0100, Dimitri Fedrau wrote:
> > Added constants for advertising 100BT1 and 1000BT1 in register BASE-T1
> > auto-negotiation advertisement register [31:16] (Register 7.515)
> > 
> > Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> > 
> > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 
> Sorry, more nit-picking :-(
>
> Signed-off-by, Reviewed-by:, Fixes: etc should all be together. No
> blanks lines between them. And Signed-off-by: comes last.
>
I'm fine with it. :-) Will fix this in V5.

> Given the missing statics, it looks like you will need to repost in
> two weeks times.
> 

That's okay. I will repost in two weeks when net-next is open. Do you
mind if I add further patches to the series ?

>        Andrew

Best regards,
Dimitri

