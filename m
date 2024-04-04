Return-Path: <linux-kernel+bounces-131839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A58898C60
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 538D21C2570C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24DA1C6A7;
	Thu,  4 Apr 2024 16:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIIzXA8N"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7293B125B9
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 16:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712248859; cv=none; b=kpUv1r7t0dfn68rV+iInfWg625g110DHYNXnAX6VBePkNL7Zes6fJk58ZC76vimVdahmZUO/HZlz2hv+tR2dWfHaTf7Bhj9HAIZol5QyKlU12CT2OW5foDiImABsK5ySzBlvEykOwvi04U8QeY85Y169FN3BprWHe30xYD2rSpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712248859; c=relaxed/simple;
	bh=b2d0qQYbju9lgtc5nmj7jxcijpQBXP6WITuwhntJg4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d1N9gEsodYWn8X4UfrYhPuFCcD8NBRMmAWMgKUeywznZxRTFw/ZhDIh6Lkuygfk68XbGHDkZoCgBW0PVYG2O51tvqTBr/jK7gxZ7/m5epQhKhPtDS5ZVYM2ortWwz0QrLa6eLAsfbMnz+cvNLkpiy4TB4vn3UofGSulBEs8ZVpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XIIzXA8N; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3bd4e6a7cb0so530614b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 09:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712248856; x=1712853656; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=koBbAALBJX5u2i+CgjXOjC27/k7ODf/jfcl7opMOdoY=;
        b=XIIzXA8NloCA+HctKO/dRtDe4BSxpy27wCLstsV1+E342PjD+tRh1KzpIFrNZDTlbC
         +qRm5Tq0rqAFHg0uqQ8jbRlrtX+Uify+nUX+qa02sZlJCjt/ZnSdj07BfRqzKoEFG7xo
         yDEbhoiXY59tG8MNS2/ylujBvIWwi/2LBsMOqPGPSR+JpfLoiEvxJk29bksH/FKxBK4j
         l3pwWFWCzikuZpg8+1HytXmDw9wIz/DJCy5tt1H7UKD6oECpYsxOM4f768qsiacrF8eb
         9Ix/5kU8502ZeZeKFydXUTa09PJyoFWzE/EiQPztWBURJbQ5Jd+HKhX2agTudifmvSxd
         oLXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712248856; x=1712853656;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=koBbAALBJX5u2i+CgjXOjC27/k7ODf/jfcl7opMOdoY=;
        b=lvb4KR0HtH/7tZzW4DO/V9tpbt9IMy07bsfL0rwxYwx+C1VXzbUg2tWAwAXtN6iTFe
         EODzWGeawHgy/DwfmsOPmH3v6693VEAtUm/BeEFT9oNJ6tJG/5fP8wTeW/jz1Q/UNytz
         FaWrFD5M3hqOOtewve3QlqfRMi8vxatbT1DrFw+VWV8SWr4EgrdZoWQCNsKUceS95/xD
         hB8BKcDii4lD2uJJQI26qodbi1AfKZxwbqDjmz7hG6mSacEazqoAi0Q5Nx1LEpBlRQ6l
         QBM+k8LtmuVyWl67TdwWNzQBuj0AxgxhCpJBdiqoEqFOQlOnEgZTpt3u8jluB/RUrpgG
         a/Ew==
X-Forwarded-Encrypted: i=1; AJvYcCXqSEZiURvk62vPa+UlFbOA/NmGib1THboBrC0XBWTApbwWuBH20HiZ29U3duKrWQonWLy5pPzq2NXek5qyteg6apEYBPJYhYrTgzap
X-Gm-Message-State: AOJu0Yxeu2C+gYmAPNvdW1F/g5A3Tm4t2nxMj/O5wGFuEG/CYUB1t8VM
	fbI5QLtR17te05b9C6qZbws/dVZBSe/hklb+CfTiwWA2ggh9AIpLolupAsk=
X-Google-Smtp-Source: AGHT+IHNbm7PY/uTRxRqaZrPED6Iw7sCNpc5qZuy5kKASXKiP1rrjZAAeYSkvdsiodNsGs/1gQLQ9g==
X-Received: by 2002:a05:6808:1314:b0:3c3:8337:8032 with SMTP id y20-20020a056808131400b003c383378032mr3336441oiv.38.1712248856394;
        Thu, 04 Apr 2024 09:40:56 -0700 (PDT)
Received: from serve.minyard.net ([47.184.176.113])
        by smtp.gmail.com with ESMTPSA id eu8-20020a056808288800b003c4f4873bf7sm979629oib.29.2024.04.04.09.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 09:40:55 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from mail.minyard.net (unknown [IPv6:2001:470:b8f6:1b:c4d9:1498:3232:e39e])
	by serve.minyard.net (Postfix) with ESMTPSA id 3DB1918004E;
	Thu,  4 Apr 2024 16:40:55 +0000 (UTC)
Date: Thu, 4 Apr 2024 11:40:54 -0500
From: Corey Minyard <minyard@acm.org>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: openipmi-developer@lists.sourceforge.net,
	Arnd Bergmann <arnd@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] char: ipmi: Handle HAS_IOPORT dependencies
Message-ID: <Zg7YFs/foTMen5UO@mail.minyard.net>
Reply-To: minyard@acm.org
References: <20240404104506.3352637-1-schnelle@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404104506.3352637-1-schnelle@linux.ibm.com>

On Thu, Apr 04, 2024 at 12:45:05PM +0200, Niklas Schnelle wrote:
> Hi Corey,
> 
> This is a follow up in my ongoing effort of making inb()/outb() and
> similar I/O port accessors compile-time optional. Previously I sent this
> as a treewide series titled "treewide: Remove I/O port accessors for
> HAS_IOPORT=n" with the latest being its 5th version[0]. With a significant
> subset of patches merged I've changed over to per-subsystem series. These
> series are stand alone and should be merged via the relevant tree such
> that with all subsystems complete we can follow this up with the final
> patch that will make the I/O port accessors compile-time optional.
> 
> The current state of the full series with changes to the remaining
> subsystems and the aforementioned final patch can be found for your
> convenience on my git.kernel.org tree in the has_ioport_v6 branch[1] with
> signed tags. As for compile-time vs runtime see Linus' reply to my first
> attempt[2].

Sorry, my bad, I've been out a lot recently and dealing with a bunch of
issues and I missed this.

It's in my tree now and it looks good.

-corey

> 
> Thanks,
> Niklas
> 
> [0] https://lore.kernel.org/all/20230522105049.1467313-1-schnelle@linux.ibm.com/
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/niks/linux.git/log/?h=has_ioport_v6
> [2] https://lore.kernel.org/lkml/CAHk-=wg80je=K7madF4e7WrRNp37e3qh6y10Svhdc7O8SZ_-8g@mail.gmail.com/
> 
> Niklas Schnelle (1):
>   char: ipmi: handle HAS_IOPORT dependencies
> 
>  drivers/char/ipmi/Makefile       | 11 ++++-------
>  drivers/char/ipmi/ipmi_si_intf.c |  3 ++-
>  drivers/char/ipmi/ipmi_si_pci.c  |  3 +++
>  3 files changed, 9 insertions(+), 8 deletions(-)
> 
> -- 
> 2.40.1
> 

