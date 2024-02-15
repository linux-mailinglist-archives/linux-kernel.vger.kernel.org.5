Return-Path: <linux-kernel+bounces-66830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC2A85620C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E7801F2645D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC7D12B144;
	Thu, 15 Feb 2024 11:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="R3cxt7VX"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6E757872
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 11:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707997667; cv=none; b=G7QC2gOqOPzoW0ZDMeoMmk8aIDUTWk3qvARgyvuyfoHZBlDi9hD16Y/dDcfu83PfNMpp436LgAD96KIJNpI08qQbd0zr4viOv62Yt8gTxt2zlnjZC1odMmfuTYM3ak8c/2ZK3yfHJba5k+Tth04dYHN7AmtpSuWFvLEpKubHfCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707997667; c=relaxed/simple;
	bh=LN1fd7tD77fB42zqbauIV0Aa4K8khZa+u2KvtOVoSpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W22T6xwmoXLpkkSGyqsgwpV5HR2S6TnM06ETP2oY11mhB6VMUocvTZpglyB7MKHh64MRaMTj1eenuv5PEQnkfgHrv1R9tqTfsbbStDGV71WS0wtQYYQz139I0NCFu5BslEif2hozaC2KMfHgFEIIe57pP1ke/iiezDCnohOXtLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=R3cxt7VX; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-411ef179d2eso5847555e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 03:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1707997664; x=1708602464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jDZkTUXyfxckUhrTkjTJWxTxMlTrhxiy3HMA9uLoreY=;
        b=R3cxt7VXCBQuF4hl4JzL4rf35exxSu35UqPADRG3pSLGH/5NgUP81TpdFw+ABphBUj
         dXU4i3155dzdiCjLzA9wbcTVBB5VUc9FH95diRNnQD8eqKN9JPfb1dZAhxBqQrOKqWvR
         sJosQF+E+5OFzhgd+x0DA4cQUApqHphtfCVuu/gNnzwbPEghDbuo0p8und9Sk8zctlq5
         YhUZkzSbvAAlrcDCNssVbk0zD+ATffYIp9J9s5DRPV5lJ/Ijzw/O71toOD5D78AElUKn
         clHbwP1pq3CsOvWfapTLoid6N9++6d/3ZJG59q9RwO4x84+neSZcQr2Yp3uZuJfs8Y0p
         F/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707997664; x=1708602464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jDZkTUXyfxckUhrTkjTJWxTxMlTrhxiy3HMA9uLoreY=;
        b=sLKedPXhofAwbJoU/OgE7dJwWQh0VOxkDiHG6TLohq6VYG8AFezSPKRG20y2YLvBR0
         emEDq6jd0+OKf6WcsSS1OlQQhsWVIGO74PzOwv/BDK1GmT0bnqdl712cG4cNmVrmG6Do
         qptbYOVo+sN2b8GW+xGA/ReddkDlHxIE1QzNKzzteJJ511XJkFuBelB94SLKlPdiUVdQ
         kX1+8CIG3svVWkm0CFXa6tYrsfScItyPT78Dv5QiVnkKRKG3i9BivM/fH4GDDHv3ycxZ
         7cwFrH+2/uyW+h7rJAARzeugGrGr7CLEGgAUHTMKh2xgxgSOx1Rd8YrHhykx1f7a1cnv
         b/ew==
X-Forwarded-Encrypted: i=1; AJvYcCWQsqBHpUyM0q7A+xGCEtpqrhCtYgKy4XWDWP4Bdg7+f0AOmFxVc3OKFgG5tnKAGHHa5uenKIpYu7Xk7xIdp9KPS+KjZEbhTlLIJKc8
X-Gm-Message-State: AOJu0YwmhijTAjrYEg8z/mVYuDnJKlzBoZhpXKLj97cibbsmKMJN8ABm
	6sGMAAMsZjUmKylk7zO0alkAWogd4ukeje+h2JqmRMjhnvC1jiVhlwVXVe+yhsJRT32mceS4odT
	BeeNW1AIfKrzZSQdLe8vduL/R9Lz+ZYOHhKXr0A==
X-Google-Smtp-Source: AGHT+IEPa0xe746/mLrXSvxwPwOUcEJ2izyVagCxfrOZJvxe8P6kn5FD8DsuToN4BWhfhL8fRGnF9fn34vnFWVpVl0k=
X-Received: by 2002:a5d:66c2:0:b0:336:76de:c171 with SMTP id
 k2-20020a5d66c2000000b0033676dec171mr1213235wrw.62.1707997663921; Thu, 15 Feb
 2024 03:47:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214142247.920076071@linuxfoundation.org>
In-Reply-To: <20240214142247.920076071@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Thu, 15 Feb 2024 20:47:32 +0900
Message-ID: <CAKL4bV6VJexFZwG4fHjZQ7eqSzUee3+VZH2baxvJqJqSneNj7w@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/124] 6.6.17-rc2 review
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

On Wed, Feb 14, 2024 at 11:30=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.17 release.
> There are 124 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 16 Feb 2024 14:22:24 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.17-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.6.17-rc2 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.17-rc2rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 13.2.1 20230801, GNU ld (GNU
Binutils) 2.42.0) #1 SMP PREEMPT_DYNAMIC Thu Feb 15 19:52:35 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

