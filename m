Return-Path: <linux-kernel+bounces-131132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7800898373
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1059D1C25FFC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED2073196;
	Thu,  4 Apr 2024 08:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUqZnihh"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540867175F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 08:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712220509; cv=none; b=kqN2AIayhXTO53eBekZTzR1puZrAxkpmrPpaFRtHmfVxf7TL1fSFGNK06+WOhiDJ26o/lhSFPAE2ZxSpjg3sF+V/279cGkonANyzABQGbD+EFDgz0FwsuRf/r7uAHyHorkbcVPSF3YZz7DaMxBpULN05mHPMBexdT0bUmW3j8C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712220509; c=relaxed/simple;
	bh=VAWm0UzP0DuDy5F1x5kFPa1dBtbP9phKW4djgHUapw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CA2jZT1MBrQVDo0Kw/OynvqqLwpRa/auzvxDnvoP/GP/VnIjVY5et/YhOe47qgmD0wIemhJ+vVI5o/hPzDJCFT3hfdruKd0IBNJ6dI6yMoSDlPLjhFwVyKM560fqSwVrlTnEVGqijTVGVJZ91Uk8zZurFUBRoLGi0UgwleD5Fj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUqZnihh; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d23114b19dso8147611fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 01:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712220505; x=1712825305; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=201J+X1AYkvpNmreLpHZ+lzNZ8LWCQdS27PNve8BW0Y=;
        b=FUqZnihheGopBLSod5/xdE32m/5mTjMhJONTXs8EBKRsH5w3bmR6ZaqOoboV1F3MXs
         ZeDk8ud3562LIUYlNbDy0dQ6fvr7/VT8idRqN01n27WUaSYMnDgvZKELbGVk1I5kPJa1
         S3xn3J6k1nv0AUXLqJneLEOVdHpUM0LltpVg9Fk5eIDGiZh2h+cL987Jm1RoWsO1aXV4
         p0NQ2HhK6SHSfv90bbihSBjjYJfiBtN6arhqEgI1EgCZwPFjG7F+Y4RDye8FblUEPogX
         w82yRTcfjpNk+TMWcJrRTS7FFo5WSBfLgWkfNKo7OpAQEo79ALSmb4TI7ui0YLAC4FPw
         gKhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712220505; x=1712825305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=201J+X1AYkvpNmreLpHZ+lzNZ8LWCQdS27PNve8BW0Y=;
        b=T1TtfHyFjdfHOIBoxGhcyi2OOxJ4V2oniUUwQX88pBAzgmjdvfMX0woDapDquSC/aI
         SFiWXDjT1+kj5vw9SQ7Joy/RrcjbuQHloTzYrsZm1hIHpnPGP8SP3Zu+LPpJQ5ER/jp3
         zkEhUsjXPzuCIgRnNOngzPiG6ZcUMTqKLKWyCHefhNXzwDUk3D2dA3Tm2w5rinK6GXwD
         jdyZkyH5uLP8uWYN/RJFGyMZhC0bVBNxLK1QcnkP5zqhRLZiFEUbCiWuBL7EyTgy5I+E
         up1Gvn+Z83Mj82Z4ZTW5npl93VhcbcTnfFy5KAjXLTdjHlSkSrLV88yxM/GHul13GsnN
         53DQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfSHfz36uWB3ak/95fIiaE2tfbO7S5Nbdm8w2Vwu+ATs5YF7ITltTeHbRgNL/pfJ6+87PpYAuFkGP5FHM3TL7WZ3sHOKJakh2I4LKf
X-Gm-Message-State: AOJu0YwPxEADD082YL/Dqhyp7BG4T2QRjXLeXSVmCeUdGZ20aY0u3QwZ
	4fVxsuufQsAglPZPew4CgcG/4NMITF8E/RCklXcIei4k8lwFIT/I
X-Google-Smtp-Source: AGHT+IENcpHrKciQr+7TH3OwDtFXrbFu+dS6LsqRUYA4DxkMAa8/mCNNc6uK0Wbsf1J+3ZRJmoXiIg==
X-Received: by 2002:a2e:9a9a:0:b0:2d4:3d86:54e2 with SMTP id p26-20020a2e9a9a000000b002d43d8654e2mr1465676lji.27.1712220505083;
        Thu, 04 Apr 2024 01:48:25 -0700 (PDT)
Received: from gmail.com (84-236-113-97.pool.digikabel.hu. [84.236.113.97])
        by smtp.gmail.com with ESMTPSA id hi23-20020a05600c535700b004146a1bf590sm1850034wmb.32.2024.04.04.01.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 01:48:24 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Thu, 4 Apr 2024 10:48:22 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/percpu: Fix and improve x86_this_cpu_test_bit() and
 friends
Message-ID: <Zg5pVphMVAJ6W9Cc@gmail.com>
References: <20240403144648.3885-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403144648.3885-1-ubizjak@gmail.com>


* Uros Bizjak <ubizjak@gmail.com> wrote:

> Fix x86_this_cpu_variable_test_bit(), which is implemented with
> wrong asm template, where argument 2 (count argument) is considered
> as percpu variable. However, x86_this_cpu_test_bit() is currently
> used exclusively with constant bit number argument, so the called
> x86_this_cpu_variable_test_bit() function is never instantiated.
> The fix introduces named assembler operands to prevent this kind
> of errors.
> 
> Also rewrite the whole family of x86_this_cpu_test_bit() functions
> as macros, so standard __my_cpu_var() and raw_cpu_read() macros
> can be used on percpu variables. This approach considerably
> simplifies implementation of functions and also introduces standard
> checks on accessed percpu variables.
> 
> No functional changes intended.

Could you please split this into at least two patches?

Hint: 'also' in a changelog paragraph is an indicator of a new patch 
being justified, in like 80% of the cases. :-)

Thanks,

	Ingo

