Return-Path: <linux-kernel+bounces-94461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D2A874021
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05B5A1F2622B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AC713F430;
	Wed,  6 Mar 2024 19:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AC7ZSDtz"
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0AF13E7FE;
	Wed,  6 Mar 2024 19:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709752144; cv=none; b=kDtI1CKJbP7jaaj2m4gHI5Qdx4/DCGy+/ANPGlUD9iqq/c355rw7JZUTMKukUVw5r6uDI/kPGcJ4aEUH5zXAXmCHW1LjlSZ6awLiKaxjB6rKlM7+GMcfvjxyztUQY69apze4rxsjg8o9SyB0km/viAgPCvYwrZnPve0uRL7+Bg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709752144; c=relaxed/simple;
	bh=Jx5YcUSMGpbao0LQhgAqxzAS5Kk25Nmxc+dmsrTnlWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eogKa7Cj0SPNV19CUbJWu9FPbihmhfN1WZGzYHijGoqUFvxbASWbTMZGY3vBIy5NthgqV+AUm/wHy8ZlMOJQrQX6vpsLY923WOTTxNQ5C/wV0E/2zEYI+dFiLUch2m/UP7oj8R4vs0qzEHY4RCCLR46DEdzYZ+PSwpkNLcGNFZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AC7ZSDtz; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4d37e76a3dfso626751e0c.1;
        Wed, 06 Mar 2024 11:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709752142; x=1710356942; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1MBwhmXT0GNigfPvd8pOX8ehNc0dJQsD/F/tCLyw9ak=;
        b=AC7ZSDtz7KWWKfexfVAGsC5/smdaHUDnzeA/mlQ7VxqI1zVe/hbauuWKJCMksBLrFc
         V9Mu6IOLcULHpDzPNPx0dGzKrJYcOuMt/UqsgEbYMGceI/CGv9LT34a0iOn7sPgd4O+S
         tIYmbcwJiAgBTu4dpkiexpHRI9Wncxhq2hVdgsT4ssIzjcG2ePCv0U/URboAFpguYq3M
         qS4mkVJSSh6j58CNIjiR1FwKumTTOt/xIIiDki5ZKLrj0RfLOGOxOogMsTkm5hH1ddp/
         MucVwYqPaKdCpjyFFB1frIDtunI9spGHz40wfjzXc8m/ji6X7FTwSmz0f57g7cGH0/6Q
         Cosg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709752142; x=1710356942;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1MBwhmXT0GNigfPvd8pOX8ehNc0dJQsD/F/tCLyw9ak=;
        b=MaeeHnhGeej8J45HPzLyNDL/2g4E/shdq2RWxdP0etu2N69SkTXCIYUfnp8v4TpArB
         nYUVKHhuI98EiLGoop2/xgbK2tXF0+i4iKvdfeZX9GJLZKdw2I75v8tNWhLLqCrOTuRZ
         r3gXSc//YOh4ZjJWjhaZBCSBsEHoaQYbZ8/pq04G6Ri06xjS/mzalYvA0LR7gyjvEr3Y
         QY/ULtBJdALkyMkSUm39GYYTUCc/Stvo4+8ezSVQwK5hcn2Bz9yfmE6kwB9PljCt7oIY
         BnPuniogbrYUF23RLEEGH7z5dYgZh5kYxStxETBwjOPdik76/u9LSrifnJUuJvHFvh0C
         +TCg==
X-Forwarded-Encrypted: i=1; AJvYcCXNQbr7BKWFjwJKru5OdK1pNFCD1+3axDALw/2LSS3STG53t6OIkXXWlTLJOxXgrA2Er1NTESS9FXyeI3UKwT9PvkTJmvlB8VPyiv9Z
X-Gm-Message-State: AOJu0Yx2sWHq+edg1LTlKfA7dwuaRtvCoGAYk7oCsk7PcHxaRW7usLpt
	QHYgUO9VyIZWg7AgXDLr+eUJSR2jJBKIWC/CNeIGSbwwTDepnAjED9q+iksBo2riXVS14ySevap
	RUxJ8wjA5xrKLl5IRigIDim3j9iU=
X-Google-Smtp-Source: AGHT+IHSD205Bw7kFQ5g85sYG4JAaOTjsZkfbzYFFVfjsRAerokh0J5v5leMfz71NT6uScbQetKY4yvDLPcftceTHrs=
X-Received: by 2002:a1f:ee44:0:b0:4ce:96b7:c2f6 with SMTP id
 m65-20020a1fee44000000b004ce96b7c2f6mr4447688vkh.5.1709752141889; Wed, 06 Mar
 2024 11:09:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304211549.876981797@linuxfoundation.org>
In-Reply-To: <20240304211549.876981797@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Wed, 6 Mar 2024 11:08:50 -0800
Message-ID: <CAOMdWS+9O6OV99UHDHALvxconF066qh2KVrAdvnK0AvhHgLUeg@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/143] 6.6.21-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.6.21 release.
> There are 143 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 06 Mar 2024 21:15:26 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.21-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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

