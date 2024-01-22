Return-Path: <linux-kernel+bounces-33729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD6B836DD5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D8D81C26391
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841C754BDD;
	Mon, 22 Jan 2024 16:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZLLKROcA"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFAC46454
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705942521; cv=none; b=iZsHCR677UIUO9YV5j2Bh7ia1PBhnaKyfEQHD3HNFJPpHjeEHpA9aNfzUZlOmoMXu/TPiSB5X3zeFwMzdHczbix39fg2FwjtqlnI2il0ZRcXUTb8PPI/oadQdhwW/uNJ7Kqqc1eioD5uNphjQ+/9Xe/flviYJ7xc9inguWXmALk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705942521; c=relaxed/simple;
	bh=8CXEZAI9p+rNkSoJMtDxmMwVqX0l1AUSjTzoof5EcMQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=O1Cqf38DGdQNHMMO5G27vKyIu/pYZ9TcBUHVjnXxaOyBzCENw1sC473Duo/O9akOLsKvUbCWrxWLa3KD4dz38u/AJr2M6iiWb5fzzkzXUT/QBSQPpIV07+wEpdJyVWnB+KbwEmdkJ1GGEVB51v/XFsAdeD4lsnOdf0TR8iJtjKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZLLKROcA; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-559cef15db5so7846315a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 08:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705942518; x=1706547318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eviaarrHpSZeGPBJGMW5DVT05MBy6NrnL0kFpqfkPXM=;
        b=ZLLKROcAHWfya/CIf+X+IL0YYbZtKZHJgA6rq02bhRcRlq0X1yAo04R12VTpAKn9G9
         wIe+TEuKqj/0jou5vtgiZRvdbOZG+uns65+Gg/sCdtNznH3yuiF8z9dHezEQMqiG9EQW
         6kKSSijQM1fPTw25pXWnZxumHl3RlwcJ39TBwuq6jeX73G6l2MFvsDrGCRxbWdJQdASI
         XWMOvmlCOQJSzOFUAYUJBOe6KO6SoaMY4vewS4RTs7mLydOFfpvoiRTylDWN876sDP0v
         D6TMQhtFmQSqaKn6NIyibrK3SbRlVjD9TaHJg7bu1gqhYh8x4if4AQijhEbA3bsMLKlk
         z7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705942518; x=1706547318;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eviaarrHpSZeGPBJGMW5DVT05MBy6NrnL0kFpqfkPXM=;
        b=SRaW1myl5A0YpiiZRea7kZp7rUzFvUpUroaLAuArMm8GLg2tbK9iVqMfvl2cURYI6I
         Ha7AONLvJIINbHr0VzZ1dgJ0YjUS3+ffxLgvtg4OGxzyaBdoRNDB0ToArf+UNC0WfPhv
         DjAYCg9YiIGsb/fYxdXSK+deNV99b1Q2RnLdJ872MpNbS8gGVgUap5KLHSTI0qwmPFwV
         mbJT1dm51YR3idPlociowoK1WXvil7WVr/JpcvSvniEzYesmGJ5gQtVfjRd/c9OyqQKb
         vjVa1JYNuCHJ13vB+Xzv1EljLO3/329WcpRDqTajWGtH4tEEwmJ0Jd3TvT9lCY6J62Gn
         C/xw==
X-Gm-Message-State: AOJu0YxCvPe58ITxxbKWnBr++TimHMXRHComMdvpIHmcySBbmCXF53wX
	i2CDDeoUekQLBl/bAdM62WiAqm0kr8N+UXTfeDw1eP8I2euP+LhHUIUcgzkr6PIq0Efv8fEI07M
	4
X-Google-Smtp-Source: AGHT+IFOG8Du3dt/lDW1J4M+ULamdNrT6bybVDkUdNDMHDaJXtSRu6jRB4UlD4OtxBYTEA6yaVPF9A==
X-Received: by 2002:a17:906:3044:b0:a2f:ebb:f200 with SMTP id d4-20020a170906304400b00a2f0ebbf200mr6058747ejd.9.1705942518382;
        Mon, 22 Jan 2024 08:55:18 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id g11-20020a170906538b00b00a26aa8f3372sm13401726ejo.27.2024.01.22.08.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 08:55:17 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, regressions@lists.linux.dev, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 Chen-Yu Tsai <wenst@chromium.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, asahi@lists.linux.dev, 
 Sven Peter <sven@svenpeter.dev>, Michael Walle <michael@walle.cc>, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240122153442.7250-1-arnd@kernel.org>
References: <20240122153442.7250-1-arnd@kernel.org>
Subject: Re: [PATCH] nvmem: include bit index in cell sysfs file name
Message-Id: <170594251756.17335.7078970144473561827.b4-ty@linaro.org>
Date: Mon, 22 Jan 2024 16:55:17 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2


On Mon, 22 Jan 2024 16:34:10 +0100, Arnd Bergmann wrote:
> Creating sysfs files for all Cells caused a boot failure for linux-6.8-rc1 on
> Apple M1, which (in downstream dts files) has multiple nvmem cells that use the
> same byte address. This causes the device probe to fail with
> 
> [    0.605336] sysfs: cannot create duplicate filename '/devices/platform/soc@200000000/2922bc000.efuse/apple_efuses_nvmem0/cells/efuse@a10'
> [    0.605347] CPU: 7 PID: 1 Comm: swapper/0 Tainted: G S                 6.8.0-rc1-arnd-5+ #133
> [    0.605355] Hardware name: Apple Mac Studio (M1 Ultra, 2022) (DT)
> [    0.605362] Call trace:
> [    0.605365]  show_stack+0x18/0x2c
> [    0.605374]  dump_stack_lvl+0x60/0x80
> [    0.605383]  dump_stack+0x18/0x24
> [    0.605388]  sysfs_warn_dup+0x64/0x80
> [    0.605395]  sysfs_add_bin_file_mode_ns+0xb0/0xd4
> [    0.605402]  internal_create_group+0x268/0x404
> [    0.605409]  sysfs_create_groups+0x38/0x94
> [    0.605415]  devm_device_add_groups+0x50/0x94
> [    0.605572]  nvmem_populate_sysfs_cells+0x180/0x1b0
> [    0.605682]  nvmem_register+0x38c/0x470
> [    0.605789]  devm_nvmem_register+0x1c/0x6c
> [    0.605895]  apple_efuses_probe+0xe4/0x120
> [    0.606000]  platform_probe+0xa8/0xd0
> 
> [...]

Applied, thanks!

[1/1] nvmem: include bit index in cell sysfs file name
      commit: b40fed13870045731e374e6bb48800cde0feb4e2

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


