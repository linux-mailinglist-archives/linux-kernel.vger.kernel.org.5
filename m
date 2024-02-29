Return-Path: <linux-kernel+bounces-87356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE3586D338
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 081B8B215A5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F0413C9D6;
	Thu, 29 Feb 2024 19:31:35 +0000 (UTC)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9B1134434;
	Thu, 29 Feb 2024 19:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709235094; cv=none; b=rDEFNbGswC3EBmVqy2wuvWuaHC8PlDZ6UWDGUwJE/H+1c9NiTdD+g5Kf8nCEV3qDd5KKFdp2vck9d02CfCZPmjXz3uOvry5hHuVLMN02/GOE3kr/OI4ki+fqvUjU1iob1WVFWQ/0cvpAFuUl+VSuq3OY4jf4gd7h+6FXVUj9Ar8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709235094; c=relaxed/simple;
	bh=njFwzLd3O52eEHT6q0dizalujYRQxu7MHu33B3xG37M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=la0MaT/u3liZ7z31t3QT9y8HFexAeyEaygWTx69Y/ekKQ9qWLbrhAK8CvrxuFTEu6ayfH63KRg16oMnLko0K4+7f9JHSMNslZHovcIKgUuadzKF6+Jc7ZkFMGthsqtDJ2SAUPMb7EaSzdnvyxguhFLgfBjz3pOrVYpN+F1RboKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6e447c39525so254035a34.0;
        Thu, 29 Feb 2024 11:31:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709235092; x=1709839892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ETKftWBVy6GzKkutN2GcCGR5cKv1VIm/ZISCNpvf9s=;
        b=hbex2avBQN5FU2dLnTmtpsxc8FstanMwpTMEGU9b/60T0rXeRMQi5NIPPORt424HZX
         eGpgWcd8tHv2Kny01G8NLxuZA+PqwZloYplHfqt30B/4YiMQXNM0KIKmhiiqw8ulxX2b
         BSTfY1cGQ9E5NYJpfX4OtruL4EQCnwhAScQsWDiX+dNElEl/PlpAxRq2pMEc9jy7/II6
         hdpSLej3xdwskqM0gRZ2xcgT8008oGEgZqdzCbJDUdqNCo3a/UfMbah94Ocz4B6Xb3vi
         keea8QB0oYhgLExvzZnrhNRhO8UlCs6DeVO/lSKZpPXs5dIdoeITCHM6Q1lkHWY7hzr+
         9JAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxfZYpMDBUEaX6yuRnqIGaeLOJ6mVQvc8ctmt6xymS2ptXOPtJSwT1GkR2tui/luLjFLNZbsQNSU27LLF2gwZ+Ld42/mkVZ3zPtSmjuT0EkVQ/XA5Gzv5z/WBbWqdoXxH3Hi4vgH0=
X-Gm-Message-State: AOJu0YzzxvLDzB42aNcbriWdjvEuSgQd+Z17pRgyUh/2Y8T0EUy0xOU5
	KuW5eW5NVlzrbQ2dg3hNRLWV3YAhYeOpNocdekLVUrY+FeQdodk3Nw2k3XAgtJ92Nw4Fa+gAKNe
	d4L5F6nG9tnDHpfceWFGcPcVzxoc=
X-Google-Smtp-Source: AGHT+IGmr8Ws2ZZbxr8S3XY9PtvJNcuSafyT8K4yK9nszYjX3GohlNi6UZMc36dkoILMAHC9DHOnJq0GkmPsY/Iw+do=
X-Received: by 2002:a05:6820:352:b0:5a0:6ef3:ed8e with SMTP id
 m18-20020a056820035200b005a06ef3ed8emr3073771ooe.1.1709235092242; Thu, 29 Feb
 2024 11:31:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228020040.25815-1-qingliang.li@mediatek.com>
 <1390e743-2216-4435-b2ef-7d92a55605b1@ti.com> <0c1e972cf506b22cb1de73c8509bf2b917c0806b.camel@mediatek.com>
In-Reply-To: <0c1e972cf506b22cb1de73c8509bf2b917c0806b.camel@mediatek.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 29 Feb 2024 20:31:20 +0100
Message-ID: <CAJZ5v0hPBbri9Y+VPqA8iisWg+fyZXouLnP=DQLN4j+W0pq6Pg@mail.gmail.com>
Subject: Re: [PATCH] PM: wakeirq: fix wake irq warning in system suspend stage
To: =?UTF-8?B?UWluZ2xpYW5nIExpICjpu47mmbTkuq4p?= <Qingliang.Li@mediatek.com>
Cc: "johan+linaro@kernel.org" <johan+linaro@kernel.org>, "d-gole@ti.com" <d-gole@ti.com>, 
	"pavel@ucw.cz" <pavel@ucw.cz>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, 
	"tony@atomide.com" <tony@atomide.com>, "len.brown@intel.com" <len.brown@intel.com>, 
	"rafael@kernel.org" <rafael@kernel.org>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, 
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>, 
	=?UTF-8?B?QXhlIFlhbmcgKOadqOejiik=?= <Axe.Yang@mediatek.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 9:33=E2=80=AFAM Qingliang Li (=E9=BB=8E=E6=99=B4=E4=
=BA=AE)
<Qingliang.Li@mediatek.com> wrote:
>
> On Wed, 2024-02-28 at 11:34 +0530, Dhruva Gole wrote:
> >
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >  Hi,
> >
> > On 28/02/24 07:30, Qingliang Li wrote:
> > > When driver registers the wake irq with reverse enable ordering,
> > > the wake irq will be re-enabled when entering system suspend,
> > triggering
> > > an 'Unbalanced enable for IRQ xxx' warning. The wake irq will be
> > > enabled in both dev_pm_enable_wake_irq_complete() and
> > dev_pm_arm_wake_irq()
> > >
> > > To fix this issue, complete the setting of
> > WAKE_IRQ_DEDICATED_ENABLED flag
> > > in dev_pm_enable_wake_irq_complete() to avoid redundant irq
> > enablement.
> >
> >
> > Just trying to understand, why not in dev_pm_arm_wake_irq ?
> > Is it cuz it's called much after dev_pm_enable_wake_irq_complete ?
> > Not sure what's the exact call order, but I am assuming
> > dev_pm_enable_wake_irq_complete is more of a runtime thing and
> > dev_pm_arm_wake_irq happens finally at system suspend?
>
> You are right, the involvement of 'dev_pm_enable_wake_irq_complete' is
> due to the driver selecting 'pm_runtime_force_suspend' as the callback
> function for system suspend. In this scenario, the call sequence during
> system suspend is as follows:
> dpm_suspend_start -> dpm_run_callback -> pm_runtime_force_suspend ->
> dev_pm_enable_wake_irq_check/complete
> suspend_enter -> dpm_suspend_noirq -> dev_pm_arm_wake_irq
>
> Based on the above, if the driver (i) chooses pm_runtime_force_suspend
> as the system suspend callback function and (ii) registers wake irq
> with reverse enable ordering, the wake irq will be enabled twice during
> system suspend.

It would be good to put the above information into the patch
changelog, as it actually explains the problem.

Thanks!

