Return-Path: <linux-kernel+bounces-75163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 731BF85E404
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2E2D1C228E0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9FE83A0A;
	Wed, 21 Feb 2024 17:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLtklMWn"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBA382D7B;
	Wed, 21 Feb 2024 17:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708535267; cv=none; b=IwdGTYQ5Y4F0Mn0CYvFXHDQyd0387qhZRVHljc/Z85f8ubtMXYM1b2/0v/gWGQmQnVtHmP7T9x1Xnhz0jn3o4UpMHjo4VuC9ouz4FO10psCi6T6BaphmcVOuMBseYR0YmIWw/GlfafK0r4slID2GLDYGcNNzQKnAlCM4DH2ItDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708535267; c=relaxed/simple;
	bh=zd3T8ygLSvLGtEjsLVelXVpLdVIjZK05NYGk2La0QAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oah9WvdiGdLBN5LW573kxZrCkcJZag0kqyvWFJnfonUQdYvEq/1s6jWLEdU2QT3HQGiIEfAMNBMNwz9XfcFweI9o0icqbdBy27BMsqdpj6EGLmc0Biyt9J/wEKNamadBzQquleIa9HKVNcC5XtUpblQEpIcw8Zs+Y/hasDbBRUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BLtklMWn; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6e432beab47so2670596a34.1;
        Wed, 21 Feb 2024 09:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708535265; x=1709140065; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dB/pV20cS6BwXBNQs60qJ05fA+DDKBXbgz6n38a3jQ4=;
        b=BLtklMWne7WMG0NZH5TO6dZvoGWnORw6R2Hbp5NOD/75S3KkiIuUruVL62B3cINPjQ
         6t8NrGCfLnZES3Go6aR2evHr60VBsO2QaEZEnlhY6l59FxJB4zl9Ob54yO5joqtsUrmm
         qgD7a3j5dR6tXsTKmhr1rECUJVEUtseoPmJJconqp87qgEsXdRKmKOvNDrple5f5mEML
         M8W2nWLFRw/36mSS43ezgJtx4ZFW+cK/P18OitH/re78oeC13cvq5bmZjCHc81ibALst
         3DHCfgbutC+iJjc5AmwATskhHuZjLo+7Mo1QgqrX+C2qOOZO6B2oiWqGdvgeUADNmmFe
         cvrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708535265; x=1709140065;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dB/pV20cS6BwXBNQs60qJ05fA+DDKBXbgz6n38a3jQ4=;
        b=DS15ssp3qyIUNFEgtCzvrFWdlwKBKcHC8id7XBkUM8R2b8aekOb8wLYuYe526BMNSX
         eIPGi7QVu4q7baRaz8nZASPOn7MOMsPvgJkXm+r9nwjRyYVi7dt96pSd1hSzaidKhbhL
         f42D/tagPYh4DrP/D67D8icThH4O6mslC8DGkcsEVChFW4owtKLvDtA/OGwbUmjq312C
         OiPGkaBBBfJ5k/oif4EhAD3bAToCpv1dRf93m13oMnjDcFWQhY6sdPp5MPvPl4OtU2CM
         7fETqZoIWWapT1rljBytNVfkg8NEYKpuHT+/HeXs3ZlAei28VQQQpzMwroL0b6tCEInq
         sRYg==
X-Forwarded-Encrypted: i=1; AJvYcCVGWMKELdrjDOtluMftD8gQEIMryBYQQSq5uXfjRyRT+8HedB/wCeesqTquB0vRPSJkvvw+302aV+QsUgbY/B6wvQFyQaCXZd9Q0gph
X-Gm-Message-State: AOJu0YwsVPLIs/cuufQckN+uajifQ6USuvQUDdebMnK72ijc/BW98sGG
	RXMWbCxiOpKaj5ZPjp536vfcoex/lOXC+2wurmcIfdZ7tnGSNWUqTqcVnoePuJSi8a61DJGur2I
	58O47HqWGT5Sefekd9oomhO9PC1U=
X-Google-Smtp-Source: AGHT+IFziaSIzRa6OEQTNjCaJ6MLpRnGpfMmEz3aVeBRK3owzTgtB5MeKyrr3qQ2cSif9s160uBUoplw/CvlOKpvpdU=
X-Received: by 2002:a05:6871:713:b0:21e:6670:b84a with SMTP id
 f19-20020a056871071300b0021e6670b84amr15666263oap.5.1708535265580; Wed, 21
 Feb 2024 09:07:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221130223.073542172@linuxfoundation.org>
In-Reply-To: <20240221130223.073542172@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Wed, 21 Feb 2024 09:07:28 -0800
Message-ID: <CAOMdWS++_6+L4bzcB8-ZWZ6ZwRV=Fc9cuU+U=h9Pv_Y1LQF-WQ@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/206] 6.1.79-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.1.79 release.
> There are 206 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 23 Feb 2024 13:01:46 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.79-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Compiled and booted on my x86_64 and ARM64 test systems. No errors or
regressions.

Tested-by: Allen Pais <apais@linux.microsoft.com>

Thanks.

