Return-Path: <linux-kernel+bounces-127866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C765D8951E4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 666381F21D40
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A3B657AD;
	Tue,  2 Apr 2024 11:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="SD+ylnYY"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7784CB4A
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 11:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712057572; cv=none; b=r/3Tvam4wDEjV37kyF/JUfUAdqVm7xZNSzRsmETDuJw4j9TEv8Y+4ShFi+FhHr+FlOYW7oar9QDUNcW8otb5r1uy85ycAi1PxxQvIUBx1K1lUQTIJVGCp4+6phB2iogzvYyLus3b1rLerDJOcxK7mdeZO1Zg4blu7XrNA8ijM+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712057572; c=relaxed/simple;
	bh=YRmGqypfvRqmg3mcQPuCwYHUt0Glp5uhzSXwBXtnwMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QMWQHWRBbobEvYGlx8ctCjGnMudTYfWLbdYI4fKROBQTzQh4ktNxvuav6emuP1lg8ORwX1fBZ7UNyQRTkBizNHw6XTt0fIMWJPnDsySiaBVXG9zX8B8N8Z9Sjwj1EdJtYNwfJ6Y/J2XcBjR4HBjp4A7DgtpIaaHX+tor0crr/2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=SD+ylnYY; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2a25094f8f9so646935a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 04:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1712057570; x=1712662370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mWJ1eWNsf3mDKXSgx9qyOAX+jE4gBs0xL5TwqXBogn4=;
        b=SD+ylnYYl5ksxZRaLXdfpJjlANPjSxBnLs7bxHMnNf++xrPJf2fHzCobbYHVOYIAv4
         NGRFpha5Iouu5GlAhX2tlY6sL37eo4cfTVoQb08mTm+7O7bc+IjNdwjDJHlxkLk5IYgz
         bVTYwbGmkZQ2xkoMpVM1yZM4iyKJOmz4/d5S0H4pT+srs7xQBrbnLbkCHpsVDjkf5BxU
         apenIiPq14MGrIPtMNIAhTFpo8H2jbjzfu7OV/mSJ6SktxiQKjZJTn4CzXRjC7yWUR6g
         5zcr21De3A+f43CcMIRYtwox6eI5fSMFOPEjjKSSXRPB5akdP5A9CRWLHrgmWRFKEWxD
         1AiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712057570; x=1712662370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mWJ1eWNsf3mDKXSgx9qyOAX+jE4gBs0xL5TwqXBogn4=;
        b=uYvX6zbEWPMlZJvw0sw6u47g44KqNVDZX7X6PIekPJk1as4+eQZB5T1S1ARjwCe+Vp
         i5aW7nXqsKBZJgvBBlbO2X954IudLu1fPH39GR/UkJD0D/geIYMfd/v3Wzl/wNUuhX3Z
         T18fxQCYhk4g66ywY31XVoIvoewCvyIhGZyQW8ykhaHBrgw5LTs3Qwfbt2hXArnG7ev+
         E/7GPyx5eOnI9NZWnfN3m4JDDJeeGrJoV4dTuNMV3aBJBFrTNUpAdk9TYG4vHOalr7Bc
         uC5dIe8dyN/KUguIxP/JTH8j/zaTol7dKfEk00x05syoLQJU5DAuiSHx33cF6cAZ4EIa
         g+qQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYiCvtsfqoqmhK7pMjkp+oQXrCRQpTAw+LOH3jUBpJm2sm8V6mPQIcQbJttyMBluXl6z8ku90Q67aNUsNGchaTsfnnwaeu1VIFAoxY
X-Gm-Message-State: AOJu0YwSgrL/4w0ouFghfCfPIvNbzIXXzPgFQfcCAEkxeb+G/++IqU/B
	NxN9bvwYYTIbR4ygeaPTONl7vWtp+aSNsLz1I2ijonu5yT8F7Eg8iypLbl9PsdWU3OPvEdCI1vR
	XN6erxpCgNCyL/29qyNof6HsdnRjQ0V1SkrmUJw==
X-Google-Smtp-Source: AGHT+IHx7EUuj7nvRf9Fi4J4iGIeWWtS0WlmsxgcMUaOaz7SMmHrxBW5v4aSmkZaEIencF5agCUbDZwn4zRGfIEOf2I=
X-Received: by 2002:a17:90a:a092:b0:2a2:2dad:66a3 with SMTP id
 r18-20020a17090aa09200b002a22dad66a3mr6122871pjp.13.1712057570207; Tue, 02
 Apr 2024 04:32:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401152547.867452742@linuxfoundation.org>
In-Reply-To: <20240401152547.867452742@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Tue, 2 Apr 2024 20:32:39 +0900
Message-ID: <CAKL4bV4EQ0SMMCE2fYqovSm3PHThObmKHNJpaNSNOWKGP59CDg@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/396] 6.6.24-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Tue, Apr 2, 2024 at 1:36=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.24 release.
> There are 396 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 03 Apr 2024 15:24:46 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.24-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.6.24-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.24-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 13.2.1 20230801, GNU ld (GNU
Binutils) 2.42.0) #1 SMP PREEMPT_DYNAMIC Tue Apr  2 19:48:41 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

