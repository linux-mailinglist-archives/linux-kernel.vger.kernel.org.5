Return-Path: <linux-kernel+bounces-123591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA3A890B70
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 049F9296DF7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319A013A405;
	Thu, 28 Mar 2024 20:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igUckRLN"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFF146BF;
	Thu, 28 Mar 2024 20:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711658243; cv=none; b=GX5yWC9YYLpztbKxf5+5P8SNvdpsx24FPeFhKBhSm9Yz5FMOc0ikBue3pNPKKgR09DcEDBHTgkWa6pUaQJIoWrHVVDsbTczMmO8kjMoMGVnP9T20+NMsnhw2YYUBgXJd6BZfZxS+oudzAKiF30tLrBUt5DPaKNSAcUIPUCYzTX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711658243; c=relaxed/simple;
	bh=vnHYx314qwSCkOWwj1tKTXE0ChWHnu2vxdHGmjAP+YM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXqOfzplRUcS7bjlAj5x5Rybk60hOKrT4kNAo3/PBk/n82HLPFOw73nq8YszNQRm8dATTNq4G7fNLVGhWrtqeQXqFNf2UDxocDxQTX7wFT1c7rbv64QojTUtL9umftT/XOPFNmZy82xkbwadoqIA5lCEVqxrix0G+R/DA26/rdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=igUckRLN; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e46dcd8feaso894188b3a.2;
        Thu, 28 Mar 2024 13:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711658241; x=1712263041; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3mekUCLeBEm209UcyPPjf4dbkIOApvmlN6pXh76P0Gc=;
        b=igUckRLNm2C5Z6YmvRvxiZ6+Czme64sF/LHC45XEVf5/EvZs5kDmmFKkldpAsS5u9T
         UkME44AtCRoBbr/7PMudAxOYMHF+pTHmFSkWOqoHQqA/SZTAMvKcN/cwuZgnyQhyJUm8
         8P1KR7ZXhzco1YT7hnFM3foJwGrOTozvDy7ATV0fjoId4kfjzk7e+E9OzRbJmdFYL/Q9
         WYcj4xa9FUZcBLfdrgZtdXrdZj98ZMnUAb11vWmrZiUDaqPbyhT7rEIckvz5x849wFh1
         C4LZ2TQxc465fvwy6IwCtjZQLiU4GwFxG10ELhRQ+eVlEbTsGek06yYUyiMArV0j7hLF
         IAlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711658241; x=1712263041;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3mekUCLeBEm209UcyPPjf4dbkIOApvmlN6pXh76P0Gc=;
        b=i8N0BC/dWUdQF9AoGjgJ4bDUSRolvoxGYimL27v5YoYTuVncI4p8BaQ0M1aWhO9dik
         TZCriUonmpUPu4ArA2fayULQyQnaZF/0mm1cN1E1U8TReKRX8Qibn4reyMD2xqXG02cR
         PJNOVYoiuXLJpqZ8LbQDR2VcE5Ii9+DmnQPzpX1zVaprFgSqC5luVM2sWf21bowyYquL
         Qdvmcqs8TZBV3nRpfCvwRBUYM6nqN2CgZ2PgijrHyWRL0kpxhkPvchcxo6w6LIuMKe0i
         2QTbV7rvfFVXogf516vukGmmhu1WSyzZChqyWQKP2c9AZs30F03WK2PhaCgajRd0zzyJ
         Y4kA==
X-Forwarded-Encrypted: i=1; AJvYcCVJpWGzw1Q9fpRNg86oklrHqgAIVPpd8Ch9ztZ0Y4fH84NA5MyNC+x65wKKl8jCDDqnrlDCb9fjHquK9wm1a86BxWtft1vEqReCpAJi0Q3N8oMPgUrg6y47XeIEMA2SJ6R3fnjv4RhTgbk=
X-Gm-Message-State: AOJu0YyZ0CCA0XfPBQgqyPsmoV+2dStpAuujkoHtePfeZyMRSeFZLR0t
	aoPUFmltMnIlZNsk1FpNrLp9gxIXyoAJtOMvkRXh3qxpSjhALIM77uf/V9ejOfw=
X-Google-Smtp-Source: AGHT+IElNpwrorBm8kulfC0t9Ae1oILrqeaxMakhHrW9s5jS4jQAyEOdezW1rFDRTcVk7uHfQV9yWg==
X-Received: by 2002:a05:6a20:914e:b0:1a3:9566:2784 with SMTP id x14-20020a056a20914e00b001a395662784mr303483pzc.16.1711658241486;
        Thu, 28 Mar 2024 13:37:21 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:493e:82a3:49f9:d88])
        by smtp.gmail.com with ESMTPSA id o20-20020a63e354000000b005dc36279d6dsm1736090pgj.73.2024.03.28.13.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 13:37:20 -0700 (PDT)
Date: Thu, 28 Mar 2024 13:37:18 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Anshul Dalal <anshulusr@gmail.com>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: adafruit-seesaw - only report buttons that
 changed state
Message-ID: <ZgXU_tYvR22zgSdQ@google.com>
References: <ZZ-U_bmZpIdoYA6c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZ-U_bmZpIdoYA6c@google.com>

On Wed, Jan 10, 2024 at 11:13:01PM -0800, Dmitry Torokhov wrote:
> If a button has not changed its state when we poll the device the
> driver does not need to report it. While duplicate events will be
> filtered out by the input core anyway we can do it very cheaply
> directly in the driver.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

I guess there's no objections so I am applying it.

Thanks.

-- 
Dmitry

