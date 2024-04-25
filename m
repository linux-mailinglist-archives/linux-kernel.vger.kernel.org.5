Return-Path: <linux-kernel+bounces-158125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E8C8B1BE4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 047DB1F25092
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6634D6CDC8;
	Thu, 25 Apr 2024 07:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vdzYQW8q"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104D5134A8
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 07:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714030121; cv=none; b=C/CfT9cf3aFTWa0ORrocCl4nZo5Ek5jAev5yrr2hUfy7v8aJwXQf1b7Wf1vpOr0rOVWtGwEPgFmsP4Wk0eOHyzCCea3rdy7ASvAaIH9KqrDjKnTY/OVcB8vdFfKu/FG1++tOurUtMvxJGXsrvdIQLNqsyiZG3sn8qq2g+/UBn9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714030121; c=relaxed/simple;
	bh=jwz5Ly5LvWWfYiBeM3AqmJqqw8OmB7BdviDG+rXxIMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=t97s8RT0kO896gnATB9TAKtuE8n+L8fMxD/DAeE5KiYGFP4e/h4JQ2jEZ2+U6Z9pQWXVYYSlKaWcUmYbFvWHAUjGPELbHISKT6EugHW++UiKiWfv0yrufecCrs07dZC5d7Bc7JTVlI632VBI4wtQ1DCIWZuQ+EgS8U7A2ruJ4aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vdzYQW8q; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a55b2f49206so308045666b.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 00:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714030118; x=1714634918; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tpPWV8/b/XqJko0DAoRlntqCOk7cVDc9gpPuKjkpYCM=;
        b=vdzYQW8qWul/1ebbhQdUMlPN6/+Fb77Oow0kgB1b5GItzyqJiEdRX0K75Bj9ILhAIy
         qSqaiGeuOaoHwmg9WpiNONcouV/9fi3gIBQ2uYRQiF1/DVcf8C1+MaXViurX/dMwpYhL
         AnOogPwcBtcDpGkCbG2Ff89JqM495MvsQIbzwJQ/rOIu4F6uxpL/sJgvllf53tSai1+m
         NDyBsZ96MfScp+6QqbRq1yFF8Kv40TlidilRaznHQxC3JSMvXIXHq39T/uNEZ2N9iVRG
         T48nsXq9EHTjOOc8cTxfSzGl65BT167K2sia7wUPgfH4EmehCPfAJyWMyDJFQaSFNFPw
         43sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714030118; x=1714634918;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tpPWV8/b/XqJko0DAoRlntqCOk7cVDc9gpPuKjkpYCM=;
        b=H96+s+HFJSGTCRdL4CQgXGkDoM7cRIhKW+9gNkDiNpIChfyKdN92qY5lTB9X5rZo8s
         VcrIFd5W1TFPaV/qjUKMpm8RGL09Yh9twTjmVYbdcuteoTCLpLZNzpVQUqdQ448oedC7
         BRrKfhPzqSa46WfIq5AvXFigA/wPAQgZId0Iu3+yhKc1QfTNQ8B37io6HTx2pQ3imAek
         HqFuRyiEl8EquUTiBT9u4QVFRkT2RY0A48C4mv+XwJwjOMRXCUhUb9QfdpXXXXCNqnGu
         XnR7LjXi5Fyq+pHnqRsc6DgE+REA2PVKJuVRdKgNKt8tnNSDcLfWbhnx2QqBL/bgV1G+
         wqxA==
X-Gm-Message-State: AOJu0Yy46zjEYM6+AQ7bgNTQOK5k3/d/yln1kpDcz4D9QqKQKiymZ7UQ
	ua/tUbxGtLy8sqHTYhiOKiaVllkuIzsuvtIDtlI0rYIyO0h0KlPhW04MTJz4d4iZ+jREJVrcaED
	4
X-Google-Smtp-Source: AGHT+IH/B4NfXYRFXAK+21wuV74gKyOJSZMgMpeCfpp6SmwlzduowNdL32OCakM1TBQGncLa8MqbCQ==
X-Received: by 2002:a17:906:15cf:b0:a55:b10c:8f6d with SMTP id l15-20020a17090615cf00b00a55b10c8f6dmr2088208ejd.29.1714030118220;
        Thu, 25 Apr 2024 00:28:38 -0700 (PDT)
Received: from rayden (h-217-31-164-171.A175.priv.bahnhof.se. [217.31.164.171])
        by smtp.gmail.com with ESMTPSA id h3-20020a170906260300b00a559965b896sm6592772ejc.202.2024.04.25.00.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 00:28:37 -0700 (PDT)
Date: Thu, 25 Apr 2024 09:28:35 +0200
From: Jens Wiklander <jens.wiklander@linaro.org>
To: arm@kernel.org, soc@kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] OP-TEE convert platform callback for v6.10
Message-ID: <20240425072835.GA3258167@rayden>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello arm-soc maitainers,

Please pull this small patch converting the platform remove callback to
return void for the OP-TEE driver.

Thanks,
Jens

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git/ tags/optee-convert-platform-remove-callback-for-v6.10

for you to fetch changes up to 5c794301eb4e5373822e8898661bacdc7f46ba14:

  tee: optee: smc: Convert to platform remove callback returning void (2024-03-25 11:51:06 +0100)

----------------------------------------------------------------
OP-TEE Convert to platform remove callback returning void

----------------------------------------------------------------
Uwe Kleine-König (1):
      tee: optee: smc: Convert to platform remove callback returning void

 drivers/tee/optee/smc_abi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

