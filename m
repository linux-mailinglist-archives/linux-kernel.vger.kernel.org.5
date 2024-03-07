Return-Path: <linux-kernel+bounces-96243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B975875926
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 22:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2179F28646D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7099B13BAC3;
	Thu,  7 Mar 2024 21:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzfx1bGr"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F1F20B38;
	Thu,  7 Mar 2024 21:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709846405; cv=none; b=qVidbC0ycN7l8Fr3vB1s+dGRFn2Fqg5Jxuu4imlyypYtZz7QzOINbHTq58p9ItBSn/247Q1ogZNJgEMqfqEsIWzf2zxvOsC8K3kW4mJl+HHEjjBPGzNQdMztAJ0ANA+xWiyXDNgdBD1KzSHb5yVMmC8m0UkKX8cMuhbZ1kzIFQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709846405; c=relaxed/simple;
	bh=xdHld3fsdtPljdPCL66D7ZTvMhGAvf9JeorKbStlTFc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fSnBsd5EPVmanC3THMK9A9Mu+kRguFFXyRky6O/srSLhFr4RF1riRXTYjioyfsTn0nvGO4PX67ewLf8oLUGz89Rk4YvmcGypNXZhknIARqXDCCirymf3yrOCtSeN5De/LVakiEQgVA/8n/0OTmVDDacxi9mCemCqn3QFBmsUV34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mzfx1bGr; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d2ab9c5e83so12647021fa.2;
        Thu, 07 Mar 2024 13:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709846402; x=1710451202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FxAW6z2fWfFSrmQ+Ro+a/GGTy69KREURq9bDQwEnpUQ=;
        b=mzfx1bGrhYz2GwofGg1ERFd0Fp9t9E+3F1285u5KQR8S5DyYRblfOcJddEVu9C5KuQ
         SUclPS89Snducnc6TxjDqpz7H76GzF8WvLvBUWdjxLViqkxRiAIK4l9zCqTDF8S3W+oa
         rpkR24oXir0u24ajeXWqbQLQjzj3YVhIIlvQ+P7PCPFlHS1eofveYkQDTvBe7sZMmm8B
         qam+CtKcDUOk6NXY6IacmAMXV0H28NfttQwjkxfoAX7x1iP7Hup9pT3JMX1tYhv2eT0Y
         hQ1XAYakkNpi2HRUfBT3xTQeJGWnCcSeCLME1YhOKrENQ5BaUMbYg9UVRYOO3DtDyK3D
         6Ggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709846402; x=1710451202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FxAW6z2fWfFSrmQ+Ro+a/GGTy69KREURq9bDQwEnpUQ=;
        b=HocPm4WzauENdLfuzGr2ku04nNmM+EjlNpEgshDftsCq7r6H0GzEDkDPFiH9hnfvrt
         SW2yEu9NI+4cPM/sDyh3OSNX/aCxPDcCj08hJUjBcuRJuR/Yfwo2QE1yhigES+SK+JDl
         071/3xzJbTV2RJKjTbeTyQpKXLgvWl1cVoA5zdFgNJYJQwcoodQdYuiR+nMGKOePh7ng
         maxpepb07wnDNwsmjJcMrBxn1ycNWJtDk7t0kJ8J3/YwnKxYW+PjE7jDRgYuitb8W6Rv
         3gxsKNC8MqzhAPuHMtpMXGM5H/hcgEwV4p0flODuHbbuoc6MO0iEzBh+GBiEatIO8cYr
         DZZg==
X-Forwarded-Encrypted: i=1; AJvYcCXRr89fcBYuO7Y1Fq4cUdojPR3NAOJ3Bvl8SLAInLilsKOyAhhwewMFa3jDFDdPE6bPlUyUUrDq7oq6ofpV18vscVZPLRclAS9C9+0ZAH31MRJH4ZHVScYz+iI0R2RUm4nQ027p4rpiflGQkCg=
X-Gm-Message-State: AOJu0Yy67OzBSavPitxKFo0cpXs+Igh+b+AXbBOE5DaAclpVCo6iZATW
	sGcrnuaJ39J1FNtDwKn9iyTMImwgdZQI6hFO+p5tEIYHhwNJKHAwhjUNhEReY/TA7Q==
X-Google-Smtp-Source: AGHT+IH4bFWXliiFPy8OHDFILE3C+glH0nxYOHkaYl1BFf/+aSDidJoTSbKkVKKKkIOqYDJAmqHxqg==
X-Received: by 2002:a05:651c:204d:b0:2d3:28b3:d9e0 with SMTP id t13-20020a05651c204d00b002d328b3d9e0mr2110144ljo.40.1709846401462;
        Thu, 07 Mar 2024 13:20:01 -0800 (PST)
Received: from rand-ubuntu-development.dl.local (mail.confident.ru. [85.114.29.218])
        by smtp.gmail.com with ESMTPSA id k20-20020a2e8894000000b002d2d7f4ac11sm3232995lji.0.2024.03.07.13.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 13:20:01 -0800 (PST)
From: Rand Deeb <rand.sec96@gmail.com>
To: m@bues.ch
Cc: deeb.rand@confident.ru,
	jonas.gorski@gmail.com,
	khoroshilov@ispras.ru,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	lvc-project@linuxtesting.org,
	rand.sec96@gmail.com,
	voskresenski.stanislav@confident.ru
Subject: Re: [PATCH v3] ssb: Fix potential NULL pointer dereference in ssb_device_uevent
Date: Fri,  8 Mar 2024 00:19:28 +0300
Message-Id: <20240307211928.170877-1-rand.sec96@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240307192405.34aa9841@barney>
References: <20240307192405.34aa9841@barney>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Thu, Mar 7, 2024 at 9:24 PM Michael Büsch <m@bues.ch> wrote:

> There is only one reason to eliminate NULL checks:
> In extremely performance critical code, if it improves performance
> significantly and it is clearly documented that the pointer can never be NULL.
>
> This is not that case here. This is not critical code.

Hi Michael, thank you for your collaboration and feedback.
Yes, I agree, this is not critical code, but what's the point of leaving 
redundant conditions even if they won't make a significant performance 
difference, regardless of the policy (In other words, as a friendly 
discussion) ?
Please take a look at https://git.kernel.org/netdev/net-next/c/92fc97ae9cfd
same situation but it has been applied ! why ?


> Having NULL checks is defensive programming.
> Removing NULL checks is a hazard.
> Not having these checks is a big part of why security sucks in today's software.

I understand and respect your point of view as software engineer but it's a
matter of design problems which is not our case here.
Defensive programming is typically applied when there's a potential risk, 
but in our scenario, it's impossible for 'dev' to be NULL. If we adopt this
approach as a form of defensive programming, we'd find ourselves adding 
similar conditions to numerous functions and parameters. Moreover, this 
would unnecessarily complicate the codebase, especially during reviews. For
instance, encountering such a condition might lead one to assume that 'dev'
could indeed be NULL before reaching this function. That's my viewpoint.

> V3 shall be applied, because it fixes a clear bug. Whether this bug can actually
> be triggered or not in today's kernel doesn't matter.

so would you recommend fix the commit message as Jeff Johnson recommended ?
or just keep it as it is ?

--
Best Regards
Rand Deeb

