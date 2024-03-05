Return-Path: <linux-kernel+bounces-92005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDEA87199C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCABA1F2240D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F0052F6A;
	Tue,  5 Mar 2024 09:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="zWtWdYoX"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F20752F68
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 09:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709630983; cv=none; b=kFQoUEA3GH3y0tuukELc5s8Wf3Vf/8MbHRhJLCtU95TQAnJqk2j4bYP9A97m4c8qeExPwVJhVv/bfT444GfiAApYeaXQhgylTtSZuZ9HaC53v0UcgTBzUpRKv3lFjSOFZk0UP+hFniQP8NN//s2ryHhKe7dk6rCKe5d+K4U899k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709630983; c=relaxed/simple;
	bh=fwwZcoGwaB5irpy1rxHWbnfBT46aa54lt77MG6kaomM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cB7JTtJcKkODFExOkXXwe1lzITOLeyqC3pwE1ZyDVTOviOmz6DZF4XMqC2I2KUDI+DiYE/I6sX1c+dlQPTvegS/62M+jndurmtSQf01p+IsMwTbs1kaOw3EH+FJQJXdP2cfcX3vhV1xZmffZkszpXPii4K/CTDSF8M0nZyD0Rgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=zWtWdYoX; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33d568fbf62so2883716f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 01:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1709630980; x=1710235780; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kax6J8q+YyZ2/tOmW0rK7vE9BJFxUzpNAhhYIq1f1zs=;
        b=zWtWdYoXfRpwj0ke9hzl6/a2lvm2sVjYc8k9ugAizoc+iSOB4qKqm5TGL+S2Afk9HC
         LkA+mpoe8QkqvvFYVVP9Ti+KQ6NmFgl6eqhI0cX2f0gkfBsq3BDZKUMzclszqQZw5ftu
         yIvZ2DT2dx7LfRL4eJGNBvLmhBHhgavMEkMq+p0GOmOfXW5rLHf8FLp4jN8tVaJE7bh0
         A4H9057CVuHn6fl/vzGynX3NB9yslHbIANxz+0bphPc8EgN6zn7ko5a+Fti0lHssGeZl
         4CWt9RVLC0yBgHIV8BvhprUgoA60tVJH2+ub2b4it2MDdvFEYoVm19ivX6BHdI6MOz7B
         9Qqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709630980; x=1710235780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kax6J8q+YyZ2/tOmW0rK7vE9BJFxUzpNAhhYIq1f1zs=;
        b=WAt6ZP8KC1xx8qp8BmWwp5IH6JrapAbNRNhv0Ue0rqJCQYIUB+MRFhg55mlr9lnezc
         3fgaz2QoXjVjQnOhVs8LPb4G7+kojX2CPqIpjIIssaSxHyEvq4DKhZDMfYJmAaUpCfXr
         DlTbSQY7UkrbtfMPEMwGtNLVWX3/X325N0io5UCZ5vfdoNBAMDkfplsO1Rb1cMUCFSye
         gdkQvrj2v9alW0jIbaNsqOohAuCxxT4+NRGHMnJciHfH9LHkKNyrwVjG+432gYDp2sSy
         M8ZNOzHfKJPESeIGrPEJ9rMlvNFC09wkfeyZdymQ7m9jQp4XHhSi7SgaW/I3j6K6OzX/
         uiuw==
X-Forwarded-Encrypted: i=1; AJvYcCWV3wt3yUts1x2+ZbNsAPTqNVpoHvveSgx+tAZMvsPWHIe3rPmbMbrcVwKZn18eOor4OaZuc9rsrNit8hgm2XtgdghNFnf7VIHmhtur
X-Gm-Message-State: AOJu0YxeZ1zZ5nmYRKegvullAZtB1LEbahbSLS+F/7+yzm74tJjk7mFJ
	mIicLtg9wBeF0SKbYDen/VgBVqBYlciVbD04i4COP4m26//mRLUMbIFZDcQrxKQnPZyyaWKlI5N
	tM78WqzQqv0lpDU+W1XgqUAERchimZ0dXz5Zcmg==
X-Google-Smtp-Source: AGHT+IECVfZbaj8vE32BJFSRyojq5sxoYbaE05unjWleIgRKFNOLgHqoAT9uxruPOMGn+ALi7kAOewyVZuDWxdEwu+Q=
X-Received: by 2002:adf:a154:0:b0:33e:47e5:e70b with SMTP id
 r20-20020adfa154000000b0033e47e5e70bmr1011317wrr.3.1709630979563; Tue, 05 Mar
 2024 01:29:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304211549.876981797@linuxfoundation.org>
In-Reply-To: <20240304211549.876981797@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Tue, 5 Mar 2024 18:29:28 +0900
Message-ID: <CAKL4bV5WJ_xZ76KBnOvf6WFAfVtj++4zE=hXRgGyOGD55xgwqg@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/143] 6.6.21-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Tue, Mar 5, 2024 at 6:37=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.21 release.
> There are 143 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 06 Mar 2024 21:15:26 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.21-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.6.21-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.21-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 13.2.1 20230801, GNU ld (GNU
Binutils) 2.42.0) #1 SMP PREEMPT_DYNAMIC Tue Mar  5 17:15:13 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

