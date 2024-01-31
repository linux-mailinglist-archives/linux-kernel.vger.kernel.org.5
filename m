Return-Path: <linux-kernel+bounces-46490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 686DA84407A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2478B29182E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3547D40F;
	Wed, 31 Jan 2024 13:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMXTCep+"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D467BB19;
	Wed, 31 Jan 2024 13:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706707473; cv=none; b=kD7IgaEtdQReVsSIx4Lw93DzLlSTY5ToJ0wVklrT7ZKFNoOZx4kTeV5udYa1Zf+gcqH2QTnKdJh81DaK9xKE1FP/eg/z4Kqns69C2jgs6B80nBRQMdzR3XYYxeUdSXVQWEAU+nTxlNgOiSHsvofEilwNKTMEW2lX3Cm6LH7bhHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706707473; c=relaxed/simple;
	bh=FmKNXLkA/kr+CM40gASiK/j9SM+MckCirdBHbOT2wJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eKaQzRgPcsFr+kdaWX1p71hbNzD7gB/oI8G7uUQw/tWNa1TcpdJ1hQIQigIGYtWpz7T8YI830lvKquhaUYKqiAKkG4xtfHfQvxCPz+0QTY7JUonWQCKaOnTBTOASojsMjSgu/QHeRweHisKJwdkjBq4YWlY6DPYFT4NSmeQviug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMXTCep+; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6dfc321c677so593848b3a.3;
        Wed, 31 Jan 2024 05:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706707471; x=1707312271; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mIdR54PoTx04BsX44lZ3Vej1iDtysZ6kTYG9UVMC/bo=;
        b=HMXTCep+I5/MyReAopcRT003eQ940PO71GL7qpnfqeUQ1nBKjIyUOga7z0Fwg+7Ilq
         Po99nNEGhAP7DNyjUYHz8TM2AO/9Mcm+FA7iofPyOOHFoY2vYmMySgAwci1eZ7FeGSc0
         nezxG+0IXF2Hs/pvMzy+0beUjfxVGheSSCR5Q2CHkqIHIXFSijOpvs6idFj+Jcn/f1yy
         Vu/1EoHcI0C62UD44heADIl8bNEG1ZQWw38hBtG7XmcEtjqV0PkmK1Oh/tUXU261wn6j
         TDqZsLMhlNoBpAVquniHYsU45lOMGuKL9+2f/bsixaSQnds+gtZrrMxjVg8waYhdvysn
         ++1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706707471; x=1707312271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mIdR54PoTx04BsX44lZ3Vej1iDtysZ6kTYG9UVMC/bo=;
        b=GK4UW7OKpGCO4WUyBMUdPlJr++vksefc5jEs1W5E73w9PEZScxNsuqINhNPElhhrEX
         Ewama48jurBFUNjud5Qzid2PJGNrPqHiKonTMYe00eQGXkgriJx3OaPrf5hhTf7vk8Cr
         Wal9jU4WTYEycQIw1i/nDcX/N8rhocAvMavePnDxsqKnZ5QRScbm9HkLwEqNgSipjey/
         VsFgU1GFdRIpnRInS5oRwSp1bIuSCZlkCGlY1He9boWvng96jry+Hdm9hggEe46Ccumg
         Ygpj3dxjDfiMHgwoFBtJPj+KS+cJ1TNszN18rdRBhEQ1KYcgnmHI5F0YJyHIH+x2A7KZ
         bs6w==
X-Gm-Message-State: AOJu0YyeoDnGdvN5ipMdsdWhbhtwgjUSmdCV0NZryxrpmsVbaMEOd5+l
	RE3N9fPrtWPuhmOj8f5giyWtvo5aW/Wzteboowry1NG2YGpuInU/
X-Google-Smtp-Source: AGHT+IEORJNOP8Y2doGdBQmQSDg8neCI7FRvJuiw+TokpKCUC1ZXUM0pJlOg1K4ZcPAxCx1Yh4TKXg==
X-Received: by 2002:a05:6a00:2e8d:b0:6dd:e398:2a84 with SMTP id fd13-20020a056a002e8d00b006dde3982a84mr2216183pfb.7.1706707471354;
        Wed, 31 Jan 2024 05:24:31 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y11-20020a056a00190b00b006dde0969ce3sm9717371pfi.66.2024.01.31.05.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 05:24:30 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 31 Jan 2024 05:24:30 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Ivor Wanders <ivor@iwanders.net>
Cc: Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Mark Gross <markgross@kernel.org>, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v5 2/2] platform/surface: aggregator_registry: add entry
 for fan speed
Message-ID: <7e392c1e-2cb2-43e4-804e-227551ed2dd7@roeck-us.net>
References: <20240131005856.10180-1-ivor@iwanders.net>
 <20240131005856.10180-3-ivor@iwanders.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131005856.10180-3-ivor@iwanders.net>

On Tue, Jan 30, 2024 at 07:58:56PM -0500, Ivor Wanders wrote:
> Add an entry for the fan speed function.
> Add this new entry to the Surface Pro 9 group.
> 
> Signed-off-by: Ivor Wanders <ivor@iwanders.net>
> Link: https://github.com/linux-surface/kernel/pull/144
> Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>

I wasn't sure if the Reviewed-by: tag means that I should apply the patch
through the hwmon subsystem. If so, please let me know. For now I'll
assume that it will be applied through a platform tree.

Thanks,
Guenter

