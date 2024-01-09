Return-Path: <linux-kernel+bounces-20798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C214F82855A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 12:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A5AB28403E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 11:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE153381CA;
	Tue,  9 Jan 2024 11:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="bHZPHjZ+"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC94381B4
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 11:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5ceb02e2a56so1044082a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 03:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1704800685; x=1705405485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MmMVd1TV42cNBbNsQpvbQcAK09XwSn0dXhlKzPYJ5go=;
        b=bHZPHjZ+KDKeSCgsA8QR1i44+8ZzBnE3AxaK9rdkFiOP7qMXprWAntV4KnAvr0hMRK
         w/4uZs8HmQ6ilcsTgcVDSZZcoyy8c/eixHW3vrLT3Seah6JtbeH+fuithjfhvY9Z8vTr
         Op0kA3hk8HJN0MoNofUqZmQdptlAK6TVS+6KrEPQUbsibOBwiWBkEYJdPCL03qBsYa5q
         ks9DPNIDORsMs2PzlJMLxIVH7DjTEqUzTCxCcU4CKz0bHfOk2xP+GLLd0G6/1HbocmWc
         BT1doZzXpxhxqOql3rw0R+nkGGHmzWA5+Hl48WW6o5laI+A33WFC6gsOCVOknTeD9A3T
         K7VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704800685; x=1705405485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MmMVd1TV42cNBbNsQpvbQcAK09XwSn0dXhlKzPYJ5go=;
        b=egDn8ffuZTYZF1cAv8NJX4YNOzETk665dAWKOHYd9SHl0eIBnP1AZphdSlxfVut4KF
         sFoSFdTrrJMQp8zOZs9OTDQ0NtPKG5wOIV6exD7UfXeWPxO4QHNqdBbQeixDmbKdbXKX
         RBI6xdBWEK3CmwPtzEZxwn0Qrf4A7f13SnCZ6yK55mWwxURCSsBUyEiP2P5GywmAO6du
         HlYnwgpDIUN0FbhY7K35ppMb765HDhLdq7lkcvtXEBdjc7Db6cN0zA9WAEdUq39hE7nH
         IKpSC1FU0pVU+g3Q5LA0gtPdxXGdJJ+ZhqIc5BMi4R8g+mB2CSvofhtMBDLg99K1dgaU
         fW+A==
X-Gm-Message-State: AOJu0YzqCUETOK6qeK1oKktvKV8BnQASpXftL0Bbrb3fBPOsaYjwqEW4
	LI52a7EaoCN1UwI61kYAxHXpyG6Cb1Shks0W3JBSSgGAPdaRhg==
X-Google-Smtp-Source: AGHT+IEffszrpF2En1bJ6gOLICjjdZv5fF0QiPLTJXtNn64pKENunyOV3TEqn3cbA7su8Hb83EZyT4bnQY0XDAkpuNA=
X-Received: by 2002:a05:6a21:18c:b0:199:b7a0:ffa9 with SMTP id
 le12-20020a056a21018c00b00199b7a0ffa9mr1974546pzb.24.1704800685554; Tue, 09
 Jan 2024 03:44:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108150602.976232871@linuxfoundation.org>
In-Reply-To: <20240108150602.976232871@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Tue, 9 Jan 2024 20:44:34 +0900
Message-ID: <CAKL4bV4Ks5210x8WvbiE=o1FzJSMGJ8eNPA_StkMAMm4dy4XeA@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/124] 6.6.11-rc1 review
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

On Tue, Jan 9, 2024 at 12:10=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.11 release.
> There are 124 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 10 Jan 2024 15:05:35 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.11-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.6.11-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.11-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 13.2.1 20230801, GNU ld (GNU
Binutils) 2.41.0) #1 SMP PREEMPT_DYNAMIC Tue Jan  9 18:32:00 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

