Return-Path: <linux-kernel+bounces-30669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E48E8322D6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 02:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14F51284640
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 01:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9034A1109;
	Fri, 19 Jan 2024 01:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGisGj/D"
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4C1A23;
	Fri, 19 Jan 2024 01:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705626313; cv=none; b=mW/5OFSzH4ZkcEWFPfREsthAMlHXp6v9JUAJ89lw6xEM4j6nSLGBxkJL9dZ7Zed8onxBxZeUkjBIzejEFDJdK7ITUIB6qd8QeaXppN6lxV70XeL7ihh8i/FXhPBGRgDd4vjqJrDvApuIBVvvh6bM9wdOBJ2T+qD0xoxsJHSww3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705626313; c=relaxed/simple;
	bh=osn/EaMYbogc4RGhbu8zSAYeMBzzRshQrCk4otxkJLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KNfb93YZ4HxzPaRph7qRce+LN0e/uLGBfbZSMDz02ou72wtU17w9ORtXbklaOWr9al3C7a5fJN7z2z0AzVdCexPwOdC/vZiwJ0f6QMuz4i3e3nUbodrKGDr5BPc6Y4tVJTdGZwfT4Lzr1Mm5+W5FpOLQr9an7oN5kaat0M72KbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VGisGj/D; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4b8e5d64a4bso91533e0c.3;
        Thu, 18 Jan 2024 17:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705626311; x=1706231111; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RsJhYuEUNNPlToTs/UNxc5vaiohzBu5MAjVEZ2pF1+A=;
        b=VGisGj/DS4h5pZxqPFS0fCOxl/0L2L8GTiiBUBLYTGu2oCmRu5+SE1nwLJ8DNGltz5
         oBrIO1FaTrheTnR8ud9bBXRb8JXFjbAZaua29Ez7/AQXtMxqwJXfyBKBjZ/yBnth2D/R
         KxMB1NiJfV/GnuKSsNcsCZ5Pg1cPtTGsQBXv0+/AAy19yY+Nm1SiugAhJYFy7MGpS9Rc
         BUUmGL5d+g3mDCZCakqLU1WxT+1r+OBBpZVZjssNgw+vxCSEo9rcsskryq/rOngHLR0S
         khJVyVIa999rKF64OiQW4P89ISib2XGK3oDrBBWDKy2EHGzy5ihmLNoBKJ5vgqQk4Hiv
         BchQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705626311; x=1706231111;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RsJhYuEUNNPlToTs/UNxc5vaiohzBu5MAjVEZ2pF1+A=;
        b=Z3Uje9+5AKHLFSt2hC4XBqy0qzzJnPZtQ3gIon9RoRYLtglLIQFE6/AVrM4pz+zCdM
         k3c/s8xhZcR0OxppOQLALbjLGL0qzlJmU4GBJhkh9VcDYyedTPToPlpgZ2DjD1RznGeS
         Wf71tGrxQKwzNPEJWONbV1fYzhH7NUlpuPZUEWG8xaNQHvf7qYMcf4rpikcdRGRFzios
         zVxr+LLFREbwMf7y+0jejQco4GVRPslIEQEConrRyC59YmBqz/gd6TCJSgcH+Ob2dTkH
         O2ZzbCc90rbgl6DId3hpHvTJ6SGope6ryI19vunXe/xkHsv/bNmKuhcU9MyaXWQ4duRo
         VWNQ==
X-Gm-Message-State: AOJu0Yw2kzWEBSSh0lUJckOlBAUENvqqAVVitcNu5/YEK/u0OoJ0z58v
	7NZyBq+bP+fqb7Q9qopz14Enl4uUNTCx4ZqqqF+bxjwiMTSVBJRcdmsCLc0bySJUqW+KxuJ0YrC
	JjGxTLZxZzeynQKJ7B/Vcad1rSgA=
X-Google-Smtp-Source: AGHT+IFXF7x3w7Ds+w2Ht9DWqHc+79QouazVGPSlh6x5W2FOMR6SBlf01kt6rcBtM0q+5OwUdit5Ww9EyrFmTAiwpJs=
X-Received: by 2002:a1f:ea84:0:b0:4b6:dfda:5256 with SMTP id
 i126-20020a1fea84000000b004b6dfda5256mr1375902vkh.30.1705626311414; Thu, 18
 Jan 2024 17:05:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118104310.892180084@linuxfoundation.org>
In-Reply-To: <20240118104310.892180084@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Thu, 18 Jan 2024 17:05:00 -0800
Message-ID: <CAOMdWSKJzNYt0AZNXFU9vViAWmi_fv_BnFFGbKv43w2H1EbBwg@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/100] 6.1.74-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.1.74 release.
> There are 100 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 20 Jan 2024 10:42:49 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.74-rc1.gz
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

