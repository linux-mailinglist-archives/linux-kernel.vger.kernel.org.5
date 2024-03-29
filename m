Return-Path: <linux-kernel+bounces-125270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B60892322
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEABB1F22891
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 18:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB86137900;
	Fri, 29 Mar 2024 18:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V94ku2tA"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5361752F79;
	Fri, 29 Mar 2024 18:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711735574; cv=none; b=UbJf/NIkyy89E9yREApR0EidGtKVe68bA2sQRhp6MP/LJV3hMerexjZS0VrcDQoyuWibie/211KOgt0/Zgeonz7+pSLK2TkT0HeCDCylgpLvs0qHnXY6tqLGWv8RolWHp31NsX5kWG4Szhuxhv/leWO1Bat7Ut7rP0WBm1/am0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711735574; c=relaxed/simple;
	bh=R3BSlNZGjpe56WqazE4wFdBARmf3FVEmHM7BHsgVa9M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ShPxQk5oTx8zt4N/k4ujEZCIEi0NZBZDdxJFW8KMW8j+yoOgl1AWHZXnFFXqnf5KbpBaQ2rySmqTi1KqY2Dp7qwqofMsxvDtAwRu5XyTJbYcQ44ZchjBoRMKIy24z8FekQsh1MiPhEGjp0RaX9a0TnpSLn/8bhZMa1ejr6WcaUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V94ku2tA; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5a47680a806so512065eaf.0;
        Fri, 29 Mar 2024 11:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711735572; x=1712340372; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R3BSlNZGjpe56WqazE4wFdBARmf3FVEmHM7BHsgVa9M=;
        b=V94ku2tAY7EKQBBJuDasqWg1jH8odq0g9dqRR22Wn+DC580jstkq7zocqO0uYGV4ua
         u2Xy84yUlA4VA2AcYF9co0YvcaU2/Qk7zWV4LBDcvsjWhJojCMbJ576MR0v6JrpsUkju
         azAP2x4DRla/SS2LQU07fygIm6j0vvCsmR1QWqvi74XFfcNKudSGRYRfAJCtjYSDlrtd
         5fu1q7zrS6KrRzvPo4VOzlIhuzqLPilgJlrAkZu5Mea2ciX0JpERckv2JVYmd20uydSK
         nG7gbd7SzqTjcW+7Cu/uU2L2qrfD2lr+Y/NX2CDwHtLeIFCPcti6lnbEbVhZFCjQIGVX
         Xr5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711735572; x=1712340372;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R3BSlNZGjpe56WqazE4wFdBARmf3FVEmHM7BHsgVa9M=;
        b=Zn5v+PHbOA1qVUVlPnhYIyF7pgy/C7RN9Lkrbr+n9Qk4Ud3DNUo/OhZlHXHaRkW0mV
         YOXxv3OY1DQku8QhkhiineiH6TREE8vp0VZwjoMHchz/JoSWnEdFmRycuOt23HEd9Eqz
         Xm6QEikY0zrVWf2QqdSavgjl+Ji/hzAleiF8+S59feg4QZoeThWwPOoPmANT+xybe/yo
         1CYinkdV9YJoJ2EVE+GzQrwsl9KQSvcEnTbdKgqNhhuMt/itDlWQzb2OfgM7u5hh7rOz
         hvexFlYpDAGDiSxLi1GN3cpYg7sK4CeAXXOH58vUt+ayVN50Wo7TSPXYNRM6CTdGyfgx
         n0/w==
X-Forwarded-Encrypted: i=1; AJvYcCUoyXBhL74gyq5F6wGi6MxmncloLd5fYDmAxLwq/TX3aJMWgYA0sZtyd+Oe+XDWoVkRkE1rCF1bgCfBCw/EP+HL4gppGpDVFVISOuao66U7DkiEk45V4VHORts9D0v34OmGs2xFLhVIycOFGoab8/Hv7NL1lkR7vtz7PLOjQ3kx2F1mYotjiJ6RE1yP
X-Gm-Message-State: AOJu0Yyl7kV/rO4oGWctMX2TywsA47SGe99cGVPgqsXqc9buePRTp2zT
	4xMleOr8Bgy2H8D9191BLxjdqSl93bXedWXxuUuBCGpUnCr3mF1u9IWO21c2HI0=
X-Google-Smtp-Source: AGHT+IGOg/geWD4v+qwNlFlaTa+hTI8kOf/RVIEj1oqLw5OnBFGg4z0B/qqLXoBgpz1gwipqIOngrw==
X-Received: by 2002:a05:6830:1d61:b0:6e6:c6ef:cb3 with SMTP id l1-20020a0568301d6100b006e6c6ef0cb3mr3019879oti.0.1711735572023;
        Fri, 29 Mar 2024 11:06:12 -0700 (PDT)
Received: from office-nix (hlfxns018gw-134-41-63-216.dhcp-dynamic.fibreop.ns.bellaliant.net. [134.41.63.216])
        by smtp.gmail.com with ESMTPSA id jt12-20020a05621427ec00b00696766401adsm1860527qvb.38.2024.03.29.11.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 11:06:11 -0700 (PDT)
From: David McFarland <corngood@gmail.com>
To: "Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>
Cc: Chris Feng <chris.feng@mediatek.com>,  Linux regressions mailing list
 <regressions@lists.linux.dev>,  "Rafael J . Wysocki"
 <rafael.j.wysocki@intel.com>,  Alex Hung <alexhung@gmail.com>,  Hans de
 Goede <hdegoede@redhat.com>,  Ilpo =?utf-8?Q?J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>,  "platform-driver-x86@vger.kernel.org"
 <platform-driver-x86@vger.kernel.org>,  LKML
 <linux-kernel@vger.kernel.org>,  linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/1] platform/x86/intel/hid: Don't wake on 5-button
 releases
In-Reply-To: <1198933e-bf89-4237-a6e8-f7daeeebf885@leemhuis.info> (Linux
	regression tracking's message of "Fri, 29 Mar 2024 14:51:47 +0100")
References: <20240318191153.6978-1-corngood@gmail.com>
	<20240318191153.6978-2-corngood@gmail.com>
	<1198933e-bf89-4237-a6e8-f7daeeebf885@leemhuis.info>
Date: Fri, 29 Mar 2024 15:06:10 -0300
Message-ID: <87bk6wlxpp.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Linux regression tracking (Thorsten Leemhuis)"
<regressions@leemhuis.info> writes:

> David, from here is looks like this is stalled for ten days now. Or was
> there some progress and I just missed it?

No, I've not seen any emails since your last.

> From the cover letter[1] is sounds a lot like a "Fixes: 0c4cae1bc00d31
> ("PM: hibernate: Avoid missing wakeup events during hibernation")" would
> be appropriate here.

The specific behaviour I encountered (failure to hibernate) started with
that commit, but I think it just exposed the underlying behaviour (wake
on button release), which probably dates to when the driver was
introduced.

I believe it would have been possible to reproduce the other behaviour I
mentioned (long hold of button to suspend causes the machine to wake on
release), even before 0c4cae1bc00d31.

That's why I left it off, but I'm happy to revise.

