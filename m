Return-Path: <linux-kernel+bounces-138820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F2489FAC2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AAE11F311C0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCC5171E6B;
	Wed, 10 Apr 2024 14:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6DrME/l"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F77016D9D0;
	Wed, 10 Apr 2024 14:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712760912; cv=none; b=Fo4dCiHYSyMs5meEJyRtZBYgdbUUOkdParPG6Xyd1MHV7hoEgpg/wLB2yw/K6CXKBf1YnLyPdyaqXrgg00HDfSbXf+dUj31Rfx0b6I1ci/3ov7opOLXl+mT1FGQBo887yFeB10JHR0EC3dVZ6W3ssJARijV4ErzL+dVij8HR78I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712760912; c=relaxed/simple;
	bh=7fAQgpTMDVPYKudJ06RE2pyN1k0PYQWs65V2L6UE7Sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tI6yR5eHfFNMfX35SKNl3f+kEWUcl5alrWyEPdKh6DSNEjOvpo0h/wO9ZEhhX10iTTYSW2bThqnq5q6FGD9eUz7VIZfHYHPwR1KZjmUoRx6G72KMZr+F6zp+KhRjiGg5IE5DiRbgJ5WAsIdAK4kJRTk7JjRdpKzitz+PDKehfI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R6DrME/l; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e40042c13eso24443145ad.2;
        Wed, 10 Apr 2024 07:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712760910; x=1713365710; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rnPf8H9ChUNgME1R8Li6tCFhCJLrI7NwVEWBeOwG24w=;
        b=R6DrME/lmH/fU9bli/fg2+PfCDCPr52bjjJuSC4cLLZ+1KO112Eg6YtL/crVShZA4U
         xLdOiYChoCm7fLSeVk+CjGnYrzzxnOydk6FGnQ4eA+wlAqVK8d5Apu5Hpzy6rWG64DO7
         /uaP46iq4qdR/PNvGCGC02LYL7Sh3/wD7C9y4i3Gy6OZfI6T1ovAajsgEYcXFs3mBG1i
         YJC0H/CFQmQ+GGarSrSO5lrJjz6mLiIdOlGesMccSejUryG3XmiN5iFDh8oBzIuI+qb8
         eHQCwyaKVGcax4hW+9tyqoQ4Ujym2oC5VaNR7IkZvQ98tfcKNv4Zl8sc1F2l9+zb/q6i
         Wj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712760910; x=1713365710;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rnPf8H9ChUNgME1R8Li6tCFhCJLrI7NwVEWBeOwG24w=;
        b=pqCHRWHJu/12iekTMCSEu0p2agc/qM1eEDCvyWcizU6XNYL8WLktNUigLP0fGcRKm9
         zBrAaYd8piki4Xx+CMCF+/sDxAqrOBqvNTkfbZOxMNqbziEcn6KVEnDn6drW9tPhLbKc
         pnwPf3GJpwfw2If3a3mwXBtsoJRoB9LTz3o4eFzhz3+UjW/SeoUdHaRAk7BWrcErE8z2
         AAqz4ZDPj6pG/TS2QSnwdKkOkemlOyaSgAPvpG0gabw3997xI6wKLGj3A/pGptVlFKGC
         Ykof1PNJFKifH9mHwc2m9vHYrM5/qv6KWTTlIrPiYMU3dxtD23+tLxeFUb9RHtD2mbGq
         E5Pg==
X-Forwarded-Encrypted: i=1; AJvYcCU9MZ3x13A6EpIhJfGcvP9LUimRRmjhSPaUjHHDwjlKFvTIc+hLFEJcx2EScr0ooOE0ENwHHJI0rpmvLncx9SHX23LqL9VuV3XCRIAj0/n3twunbSdPN6bqwzvkQLoxGvNjaVGeF34o7z2rrtI=
X-Gm-Message-State: AOJu0YzkFzu2RkqHWTcJvKUHv8D15hIVb+aob30/pAVEGrPwNporp9EC
	whax8Z8rAXNG9Oy0IZxfykXYcCBQPsHG52AIAv2n5V/+d3hKjoBh7MvOiBR3
X-Google-Smtp-Source: AGHT+IFN/kZoObXcJJMFpnGS3H/KmNdrXTgYpzW2WtpE5Ti3/TE/96kfaAUMrC+QAZGPBEobCDBWng==
X-Received: by 2002:a17:902:ed15:b0:1e4:8c64:33c6 with SMTP id b21-20020a170902ed1500b001e48c6433c6mr2711740pld.59.1712760909711;
        Wed, 10 Apr 2024 07:55:09 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m12-20020a170902f20c00b001e2a4ac7bf9sm10863971plc.111.2024.04.10.07.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 07:55:09 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 10 Apr 2024 07:55:08 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-watchdog@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] watchdog: add HAS_IOPORT dependencies
Message-ID: <13ef0edf-e923-4139-8c6e-91bcb8193a9e@roeck-us.net>
References: <20240410084201.1481930-1-schnelle@linux.ibm.com>
 <20240410084201.1481930-2-schnelle@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410084201.1481930-2-schnelle@linux.ibm.com>

On Wed, Apr 10, 2024 at 10:42:01AM +0200, Niklas Schnelle wrote:
> In a future patch HAS_IOPORT=n will disable inb()/outb() and friends at
> compile time. We thus need to add HAS_IOPORT as dependency for those
> drivers using them.
> 
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
> Note: This patch does not depend any not-yet-mainline HAS_IOPORT changes
> and may be merged via subsystem specific trees at your earliest
> convenience.

Seems like the COMPILE_TEST / HAS_IOPORT problem is watchdog and
hwmon specific, so I'll just let it go.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Guenter

