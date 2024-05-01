Return-Path: <linux-kernel+bounces-165238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D68788B89F6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03FF81C210DC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F91D85636;
	Wed,  1 May 2024 12:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="aS+66/h8"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E0B84A30
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 12:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714566349; cv=none; b=UqUXT7kqH26v9oPrIb+MM5z0WCbNzUKJRqOQGy0NEpR+VLPtt7WfNrbUa72QTDg42W7t4xYjT94fqTcGGhOn1IWNXS+YeKoR9+10NIEepJQUnow9tqlLed/RQePpcWPz51y3NugAGLCV9wJ+d5DfVJs93aKBt2ntcWn0mcqiLJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714566349; c=relaxed/simple;
	bh=NSwHWAOCmxw85tG4MpaDkx4K6KlMQMGRZ9GWBGkHOuQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZyQfEta8V5JOybHF3Eo/vJ9fV+s4X7BvUnshkNQLz4CnVxCR3N9z0gAjVGVJ2PwbP6fRxCcUs7jDTRuhDQXvYYSWTRPXd1IYiQZmEn90TA2Tp2wZeMPLKY8BtMALDaLGNbzqE5NZMx9l7WM5ZJ0UzD2hAx102Y3Wv2cOrtJzkL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=aS+66/h8; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ecec796323so6420847b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 05:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1714566347; x=1715171147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JiVKU3GODS4dwlptSTMaoTCW/CBkEG4u9gcmVKIN794=;
        b=aS+66/h8a+lR/RBQ46xAnMPWozJ8dggz3K8j3nNKgwIoE1xr04vxfDdL39XBvNqErY
         rlu16aR5hMQzTehH2Z97dkkwVlHnx5ndvYGHoS20BDHgsOrMlY/rRUz+DpRg08RbjpGV
         aKmu4VNukrPCKJm3VQ+6/L6HJT9k5crncyndMBe5nrlUAGTwOysSrh3RU1vOzKQ1W4KN
         /W8xAZjKyE7l3QpwyACQMOVinGiRf2oTHWfr3T2PNNMwp+b4+LwzU4Ik8VpcjVQyAv9+
         s5zhfJ2SDlC/vzGpICh8Bfw9miqWtyaHfYg8t0egnE286WLOyVdCRcBQxfuNe5kABK9e
         Hc4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714566347; x=1715171147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JiVKU3GODS4dwlptSTMaoTCW/CBkEG4u9gcmVKIN794=;
        b=Uw/sWQaw5PIhMbufAYcgOUB3n5Tq2DtGOj7yJFbFI8SR+kZzOev+aF+J2HXoXgjLjp
         BM0ZHi+J1c5t45QOw8nmXKUqzCFOd76BbCS0cyJLHIKXiq2jZdZsOkcJ3lN3/9W3fKOI
         UNREdb2WQq0H98ohHk4uM6Ee2zy+IzQejitq0MXQdrZN+6vJCo4KvMkCobLQYIbzEHU4
         6g8hVi3NzfpKtVB8ZxbACaPWPJkyrmj9Bj/TRPSmkDMrT3376JLIqK33wjwYly77g8d1
         fm2HzUVyZ2AGtfpHAkTDfeYh7vJ9s24TW14VjC4rPfdsaM/iGnvH0DIoe3yK3FKp1OXv
         0hKw==
X-Forwarded-Encrypted: i=1; AJvYcCXYdYDQSXwxijZkZI0LaZNoT+5BseVIRW+sniwNPEzX2UGKRLDkt0J9uCB0hGiP2UGmk/tjnnpJMT1k8QOqfZ0B4UxHWz0C5v8nJt7i
X-Gm-Message-State: AOJu0Yz40l82Wn+tn9qI7Agq/tgSUUYfSwFVeZ99sFoj+IAPfDu9VyPG
	ZyuAi9O0u9Os7Ty1MCSI8GDmIW/05nExi/gZob3XQs3DjLoWykJOZ1GPJLplXYhdX+IVCp6r5mU
	bbeXjcncEiRlAYfBpCtR1JPRHQND+DemU2I4JG/P97OR4f2xIvAk=
X-Google-Smtp-Source: AGHT+IFu7bWRAod+fNBklmqwmdOx9dOl716oP5Qi4fuEP26czGC5fQL/lUqerfzxAy382qDKgagM6DDf6j+5N6sB8SA=
X-Received: by 2002:a17:902:cec1:b0:1eb:1698:ea0b with SMTP id
 d1-20020a170902cec100b001eb1698ea0bmr2947039plg.6.1714566347519; Wed, 01 May
 2024 05:25:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430103058.010791820@linuxfoundation.org>
In-Reply-To: <20240430103058.010791820@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Wed, 1 May 2024 21:25:36 +0900
Message-ID: <CAKL4bV4UNZTAwz1Lge9qXfSA4dRwZp1NVgv3kXxiwzEhPxfDyw@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/186] 6.6.30-rc1 review
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

On Tue, Apr 30, 2024 at 8:08=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.30 release.
> There are 186 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 02 May 2024 10:30:27 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.30-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.6.30-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.30-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 13.2.1 20240417, GNU ld (GNU
Binutils) 2.42.0) #1 SMP PREEMPT_DYNAMIC Wed May  1 20:29:45 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

