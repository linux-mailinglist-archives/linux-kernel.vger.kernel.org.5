Return-Path: <linux-kernel+bounces-62141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6A0851C22
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE92D1F22DDC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EB746B80;
	Mon, 12 Feb 2024 17:51:59 +0000 (UTC)
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D00946551;
	Mon, 12 Feb 2024 17:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707760319; cv=none; b=vEH/lo7kYG6ETMBbyymbD43NX5dKiipqT7+dWL7c6yBX1Jl/bnqaf0mVSRsKu810zvySh/68SlKq8d1NHO7ARmC4ApNk4D9h49e5k7tAtFDkC41IjkOF0jpRUQyUJzuEco1jWNfSEsp+2i8l9P/g08f1Ty1vGYR5STUE4EGONlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707760319; c=relaxed/simple;
	bh=MSV9z83/rPdyR+wFYfqvWW44qfCrTEBxvdnwMXkgwpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rmqESiPPm8q3TeMMJZ0H4n+Ybwe3S8kb6hGl0P/k2DMzx1V0M/Kk9XtraShrjeSyB9lbgm7WVyxmhUP/EaMzo5UMNyG4xnY9WrqhhxstTIyzBMJdvb+JoiFw1Wnm5ixwDHJ27VhyDPGD7tneJE1p5G39xeZTvzxmM424/WjlCa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-59a24bf7cadso1164584eaf.0;
        Mon, 12 Feb 2024 09:51:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707760316; x=1708365116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tV5WxbgiDjtX0x1opWnkC9kI2tXW3KAWA0QX8hrZmag=;
        b=PhFt9ohh9nxcrsEwRCf7COytUq+U0NjIHFDOaiImfRHEFxvWP+HzljzckTPvNRzVCg
         uUp6bjC+kufNAZWRx+gMjIQ/H1Qh8y84LBO2958gktk2ZzxDktUVhpVnJBp1Z/3Yp0sN
         oskLU65MtP5ObRtXCWnriVzF9IC9CdU/v7RLJETPXAc32XKlADv/13GUuP0x7KvnWCLf
         miauTEYPTEG5eoANDiiolY+/TMiJzc2IFg0RE6/NvOSjDn8v0E6wNnoH2lQYtbIHcRNx
         Ak8lvd+N8conwGkief8PzaB7G9KOG+DEMzwnT12S6mlw/2Qsyn1vw/trBbCMUD2Jo5fm
         nbWw==
X-Forwarded-Encrypted: i=1; AJvYcCXbzTt/nsGGYNiBDxz6jhW8h5VVsAg2mqYLghez6cNYv+C3gdPL90it9o+PV1SYNbqEPLNdPjqn05FIZSnY9s0BkXWbHVkVIDWkblya72WfRZPcL3sGJ/1m041nwQlUDXNHh1GmK3X3Hg4bmKU6zzrXbcYEB23TUlnlOAgwTzLmPfU=
X-Gm-Message-State: AOJu0YwGx4YmDYFxtldRI4SkBeqD/o7zzWZmklpTNJtF4sJsHgHRciYY
	9BhzW0aye2SJ3A6zawA5LbKtEPlHpemNYsjm8xiR76Et6g+2Nv0C+JzgjPZpYee7eXeTPDyK3OV
	vKHzllaxSsZNq9jLyIjUf5J6HiDQ=
X-Google-Smtp-Source: AGHT+IGTtJKI1BtcYOhVTDcIlt7hZ7fg57x3IPWUNB2Hg4KNLtSgBkQokvKCbcf0cXy4NSPB8zdSrOL3u0ZqfyGhhzQ=
X-Received: by 2002:a05:6820:2b12:b0:59a:bf5:a0da with SMTP id
 dt18-20020a0568202b1200b0059a0bf5a0damr5424442oob.0.1707760316733; Mon, 12
 Feb 2024 09:51:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202152120.13317-1-s921975628@gmail.com>
In-Reply-To: <20240202152120.13317-1-s921975628@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 12 Feb 2024 18:51:45 +0100
Message-ID: <CAJZ5v0horZ06Qm9+pNR39MQkokBfqRADYEJd=Kc55_cO79Y9Vw@mail.gmail.com>
Subject: Re: [PATCH] Documentation: PM: Fix system hibernation section
To: Yiwei Lin <s921975628@gmail.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org, corbet@lwn.net, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 4:21=E2=80=AFPM Yiwei Lin <s921975628@gmail.com> wro=
te:
>
> From: RinHizakura <s921975628@gmail.com>
>
> According to the context, 'pci_pm_suspend_noirq' is the right
> word for the changed sentence.
>
> Signed-off-by: Yiwei Lin <s921975628@gmail.com>
> ---
>  Documentation/power/pci.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/power/pci.rst b/Documentation/power/pci.rst
> index a125544b4..120703203 100644
> --- a/Documentation/power/pci.rst
> +++ b/Documentation/power/pci.rst
> @@ -625,7 +625,7 @@ The PCI subsystem-level callbacks they correspond to:=
:
>         pci_pm_poweroff()
>         pci_pm_poweroff_noirq()
>
> -work in analogy with pci_pm_suspend() and pci_pm_poweroff_noirq(), respe=
ctively,
> +work in analogy with pci_pm_suspend() and pci_pm_suspend_noirq(), respec=
tively,
>  although they don't attempt to save the device's standard configuration
>  registers.
>
> --

Applied as 6.9 material, thanks!

