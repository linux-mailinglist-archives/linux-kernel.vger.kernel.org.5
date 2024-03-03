Return-Path: <linux-kernel+bounces-89937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 074B386F785
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 23:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1EEA1F20FB8
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 22:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4157AE6E;
	Sun,  3 Mar 2024 22:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cm5rvxAj"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07D179DBF;
	Sun,  3 Mar 2024 22:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709506742; cv=none; b=Jsx1VGP1+uaviJjiPaujnnWnqUlM/s9HESZ07HcamteXtd07MaPXk4FgMqpyCo0rWWOPdXGYu8cJ4kwFINXl0wwhojQtHTyw0uFuKf5dLyVBvYbuU+7org0SZEeQI4MlGqwtEmJmHXTLP4xmXuX/Gguh+1Is01QOmZoCq4LZybE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709506742; c=relaxed/simple;
	bh=a8us3ZdpSazkEvduVCYQEoDVuVXDpMKBMzlCg7XAn2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pnJomvJYxW07ZWP2btcPA0doak2N4pEm++CZC/MRA501/EKUagYQWEp2pNFc+cPkvAohm4JMo+Tfmlk+noq2Kp6qLjbM+j2OQ2k7UmgAHK9tNTlg4Oy7iaLOx8pmzzN4kP6SlZWN9aMIKzzaJOQ6uwGq7UUm+A7tMKt0PodUld0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cm5rvxAj; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-299354e5f01so3727592a91.1;
        Sun, 03 Mar 2024 14:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709506740; x=1710111540; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cTn+//QzyiW38u/myQllBoB9A0lqzlf6kvaDbTws9rA=;
        b=Cm5rvxAjkx7+9U0SAidKKovVKkNlKbi76bWxC4xn8DKNeZT/1uWkpO0iI4znjI2EAD
         kJ4RElzO4o2c64lCuk4A4g/7eh6F0pXzbCGafNSjKRrrwYJAF2nZoeBJYEn46z5fRKiJ
         fSVRQjcAPYxLLFWykvx+rop0QdqIM3Le79BC+z3vWak0J5hxDjy/0Mf4kTpgQSYQ1SCx
         5bCfbJF1XDacfs1zq8aDzMGMq+FtPJrtb7t/i/H8aynkizoc0d54V6AEYeVBSL/+nug6
         +AN4QOiKxN9h1ilx3FBorc6cYjMvkHMslXLDXqKVyZxIBcaB8tYjuZS+lRWRwc6w1BiZ
         G2WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709506740; x=1710111540;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTn+//QzyiW38u/myQllBoB9A0lqzlf6kvaDbTws9rA=;
        b=OLOmGPSWCyJVkIkogHs/Nlb9POEotX5dC/KTqIRQBi7TXZQTcQQNZf6MvtbEJBDJhT
         eQrHspbAngFnbOJGwcWbVXkXiSkDAhi+CAAl8bQpsOUJOfYL0MWp50qNUyv87Vf/SCSb
         3xt8v64JzWRry2ielmz3RPVJPWfjBQjMR5fsWKYwQlDujfv9pqca2S8YnTa19fffoknS
         an8+6HDuLEWxT/5kkCFPldyfqyVs22TvaJqsQ2gGfs+zm2bcMx+NCWAYQTtjcNVJpJOg
         NnveqBZKUXVD2I4TXdgJwSkjYduFJ/lwa+8xqvBqHbxgrU9Y7NeFXGuSMVGXBT4l2Akt
         R2HQ==
X-Forwarded-Encrypted: i=1; AJvYcCVD73fuClMWlvDO28LkamHtGNlcXySThDbankH/VonqiLkkwVWq71Ln2SAY8ttpO/n7jC4MH45sM/udTKoWFuWxya2OeSfMu+T0A9X9D0aPpGrafOHgLKj9fs8wH7Hnj+GeKjQb5ocNw/9kX6xj8PEM5VFsUX5s5k13AZPa0oPiDLHSpZzNgI6cNJM3Uzis4MAPtOofsxgQwGxQoi0JBnA3wdc=
X-Gm-Message-State: AOJu0YyQ03OxGbF8omgW+aL/AzuML2afW/0fjMds3M9g0LJe/gbmBB5E
	OlxqxIJETKPvfIGYwvh1ksWggKebz/fyTPqZbpDKVJeh6AIm3h7Z
X-Google-Smtp-Source: AGHT+IEGldfIl+eDJGL/DHASC/9Vsg+a9wXNA/kIUxPIBaxZYZj4m0QNBd8JUMK7LzXksn0JeilwFg==
X-Received: by 2002:a17:90a:101:b0:29a:ea3d:5776 with SMTP id b1-20020a17090a010100b0029aea3d5776mr10423008pjb.11.1709506739845;
        Sun, 03 Mar 2024 14:58:59 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:99d7:8333:f50c:d6a6])
        by smtp.gmail.com with ESMTPSA id gx15-20020a17090b124f00b00298ca46547fsm6494320pjb.36.2024.03.03.14.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 14:58:59 -0800 (PST)
Date: Sun, 3 Mar 2024 14:58:56 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Karel Balej <karelb@gimli.ms.mff.cuni.cz>
Cc: Markuss Broks <markuss.broks@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [RESEND PATCH v5 0/5] input/touchscreen: imagis: add support for
 IST3032C
Message-ID: <ZeUAsCKozr3y8DEA@google.com>
References: <20240301164659.13240-1-karelb@gimli.ms.mff.cuni.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301164659.13240-1-karelb@gimli.ms.mff.cuni.cz>

On Fri, Mar 01, 2024 at 05:40:59PM +0100, Karel Balej wrote:
> From: Karel Balej <balejk@matfyz.cz>
> 
> Hello,
> 
> this patch series generalizes the Imagis touchscreen driver to support
> other Imagis chips, namely IST3038B and IST3032C.
> 
> The motivation for IST3032C is the samsung,coreprimevelte smartphone
> with which this series has been tested. However, the support for this
> device is not yet in-tree, the effort is happening at [1]. Preliminary
> version of the regulator driver needed to use the touchscreen on this
> phone can be found here [2].
> 
> Note that this is a prerequisite for (at least a part of) this series
> [3] which among other things implements support for touch keys for
> Imagis touchscreens that have it.
> 
> [1] https://lore.kernel.org/all/20240110-pxa1908-lkml-v8-0-fea768a59474@skole.hr/
> [2] https://lore.kernel.org/all/20240211094609.2223-1-karelb@gimli.ms.mff.cuni.cz/
> [3] https://lore.kernel.org/all/20240120-b4-imagis-keys-v2-0-d7fc16f2e106@skole.hr/

Applied the lot, thank you.

-- 
Dmitry

