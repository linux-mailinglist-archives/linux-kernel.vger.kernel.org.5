Return-Path: <linux-kernel+bounces-112046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3CA887490
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 22:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B8A4B21206
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 21:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDDB80628;
	Fri, 22 Mar 2024 21:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8HRMBA1"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E9F60B91
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 21:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711144008; cv=none; b=B2JYS5t/kw/z8kIGy5MANhEex+wodx6Scr21YidIQYP91CfhOpCntbgPfizw4SZ/8BML24SYVJKPZJKzjqPWCzXh7JifVy3hxBtfUR/xpooiTWZ4MlRP/4tK669+M2z3/T+FsvaxFwY9WqQj9VHJUL5l6TBQ1u1R80TgFxBB6IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711144008; c=relaxed/simple;
	bh=+PoEwJEi5agh8zv9r1KQgcGsCgp/XrDb7ksCx4Z7LUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tjk1sYCqEvVxtxKSlYY8bzbj2D/LhW9a0aPCO71PK7RsoOe/iWimll25aHM0cy5RIO0zAPtpRLxwIE62XNGzLPZ4dwaLyvHJsLxOnG9qkJ3NOaSU6w6Ms7wWU2c7slYAc1x+x+DfB6jPSWBoNVbK7VVlfO0VH2BI0Br5E6PP67s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b8HRMBA1; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-366c6170706so12293865ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 14:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711144006; x=1711748806; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5TZNWXr8KL2/PUmKKK6Ex7t5zb51CLse1GgHxbWue5A=;
        b=b8HRMBA1mhJ5czVkpmDrehWjQz/jDFGNeTyVH/r4Se+Hcjscnpuf01C6gMKilguYRO
         eObNYJbqYa1vf0VSydayZL93YcCdOCvVFDEDDqP9xhS7LLVCK26/W2v3ojsZHP+rXsdT
         u8MKIJF/X7V8G79etDpnUFM9qvfoJsg8XPLclnz0A+GECXsNP3qoWtwuu4CrmPJM5Jv5
         9GatJdswF+yIMNy5tnNyOsxNFrvFWPGSVk0FzrV8ibtr6e3f72ZJceCzWdzJIAclt23q
         DBk2Uk+A6/SCP8W2pGbRg6qv2REWjBFXGTahv3GZaFOJggaFuxyKLLxjUnuKN1HPBnFS
         55ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711144006; x=1711748806;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5TZNWXr8KL2/PUmKKK6Ex7t5zb51CLse1GgHxbWue5A=;
        b=VOZF0Qhug0NdZVIj3IAvEfpabvA9MZGBAkz2YHsuGSk8UG7ouy3Gdp7waNID9dGkK1
         M6x6t8eDGjCxBSjucP9xlSkm+VP4K7+QQLhmhUTaSOWeCAF5rClbY2iOjTz5jZ41mXbM
         q5+0ZEd2Cwdz6scDi3RsCOVuAccG1SYFyUeC+Ji6jTCK3nyTV9VOP5oobWF4DQKYRwxw
         X47ThjnNcYkp+70NnBavKXKj6/PlbLouDYC5ceqpsy7K6AKyIwGHIuTIcxHPzlV8l6Dp
         Bujk5zmEcP6uc1ByWSizL4kq6LFptUa6+FJ3kr/zXObQ1MTaACNDLYnEVv45ekM8x70y
         YuTg==
X-Gm-Message-State: AOJu0YyglwzbB56qlpeknccm+Y9xmPN7WWYVjinOGL0FWJRJY452e3yx
	BQDwMlwbXCPgT7mtKWftI5gCBYZZ2w8JVFYKmJ1Y/jIATxVcl0ItSpW9KtOT
X-Google-Smtp-Source: AGHT+IFFz8aP/icuKnXx6cQTzNzqmQqy6pp27gL79w3qTTgUjJMWPRdWrxGwItsndMmY3+avE/2sjA==
X-Received: by 2002:a05:6a20:8417:b0:1a3:7285:a63 with SMTP id c23-20020a056a20841700b001a372850a63mr1087093pzd.55.1711143664710;
        Fri, 22 Mar 2024 14:41:04 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t22-20020a17090ae51600b002a000f06db4sm5988036pjy.5.2024.03.22.14.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 14:41:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 22 Mar 2024 14:41:02 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [patch 1/4] x86/cpu: Ensure that CPU info updates are propagated
 on UP
Message-ID: <7f08850c-6ddb-42f1-b2c9-0057e175b6e1@roeck-us.net>
References: <20240322184944.141421692@linutronix.de>
 <20240322185305.127642785@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322185305.127642785@linutronix.de>

On Fri, Mar 22, 2024 at 07:56:35PM +0100, Thomas Gleixner wrote:
> The boot sequence evaluates CPUID information twice:
> 
>   1) During early boot
> 
>   2) When finalizing the early setup right before
>      mitigations are selected and alternatives are patched.
> 
> In both cases the evaluation is stored in boot_cpu_data, but on UP the
> copying of boot_cpu_data to the per CPU info of the boot CPU happens
> between #1 and #2. So any update which happens in #2 is never propagated to
> the per CPU info instance.
> 
> Consolidate the whole logic and copy boot_cpu_data right before applying
> alternatives as that's the point where boot_cpu_data is in it's final state
> and not supposed to change anymore.
> 
> This also removes the voodoo mb() from smp_prepare_cpus_common() which had
> absolutely no purpose.
> 
> Fixes: 71eb4893cfaf ("x86/percpu: Cure per CPU madness on UP")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

