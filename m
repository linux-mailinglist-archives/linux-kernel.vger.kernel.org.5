Return-Path: <linux-kernel+bounces-69228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7868585F6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D72772812B1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00D3130AC0;
	Fri, 16 Feb 2024 19:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="EsUq5vSB"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F25F135A49
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 19:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708110381; cv=none; b=pELGI8ndPiA7rcuNUtMsMPvdslqrq5dWeEVb2l0IdkaSHvaEYVDsS9ILyXNIawzh7G2agCE3Uh/qL75pGl+dAnAWlbAztSMP+74eh8t0ElTCfhVf9LmYe+yMzcClc+oi/gNhJJEeJ46sHajzjobV4aKYc+GUUE6C4mmDbzFq8uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708110381; c=relaxed/simple;
	bh=tyXKpT94FpSnBWMVzJImdgL6izGWv0FtXsMQPeQnSGA=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=bJX/ZFMw7bwHmrqnNQ+rkC+GqMCAqFNMTZjWPigx1Bk74QgPZFZI3MrUCiLy5eSKSMAyaDXVaiVFwgf+vry40JSkEY5LrO8iITrJYYl27Lecd0ThQWre9McUlUDG0da3/zKBcsb2thlSdYBM/+ltvwky+4n9GN9gpDfZNqnHyBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=EsUq5vSB; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d7858a469aso20969065ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 11:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1708110379; x=1708715179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G57ATopsWGdgfukCf+oinJCn957kvcdWv+8EF1OVrlg=;
        b=EsUq5vSB9682MEt9Ck0RPUdwAjiPnXC2vB10k9m87Qhos0KmkMghLmA7zHZ4IHhe62
         3DNfbTN/yepxzaXFcSZtML4IJjgY543BDC+gQ/8bMTj4rsfrq0nQ53rIuaBHfPIN/3TH
         C+EV+4LejAWb+h6GVeFN28Yq78ezcCD7BaJle8V6HOBq7krhimv0WPj/MNiAT8PDfIOj
         twfcjxNqe8kWoFSeCMYj4f1mgmZFKS++paenjJmnULdk9U8PJEfrRA2Q9JVTKWjJuHU9
         hz6gZeO0U+bLYw+jR/DOUlJZgs5d5Wer2TXqYzIiJ+9BidIaKRfua1/hlDopU9G+LzbF
         6R7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708110379; x=1708715179;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G57ATopsWGdgfukCf+oinJCn957kvcdWv+8EF1OVrlg=;
        b=ujODdJAYcThCr6JFzQJtbGMB+dX0x6gisq+1vB+safDHQ/OrvJOXshZ8Kpq/kzUjo1
         nszOT+m5VVt7NAESLv+2mjncIozBobkgOC1mkfW6lCt2nwy8czpTincpbbO6D/blN2oW
         i0I50PAF955sZ7CWHhBkW3sUyLc7TfMNFJzzY8dH2aYLyl0w2vMkyeVM3dnRpw1p3gxC
         5zHzarH4ACZ1olXkz+wOkXDp6Jajb8q9KxfHi0KPHWydUjP9Heztv3i7kxldMrjj+fpt
         iGWHU211Qg5V6YZDNRsz3nzX0/vQbdMfYbx1wZvvPgs4ZiHAWYdZqKDpxlM0kYuKeqpE
         8CEA==
X-Forwarded-Encrypted: i=1; AJvYcCUEE0wg4YPb11MShNtPN+gLv9PNXLyajvuxLtlYB9JF0IOvT4zPv3g9k5Dic6WzWs2IEaxS2jcVzGlYz8JJFaS1Lknat6gY0ZdO7dSZ
X-Gm-Message-State: AOJu0YzkdZ2SX1ImRCI4gtI5UYPIeQOQGtK+WZrY6XgT797lGljLCPFU
	akRFY9P2sNXTkkc1BKAIVr6IDKW2+hKnkktVM6DGKF4RMoF9T4s8GKA/GOQFO+0=
X-Google-Smtp-Source: AGHT+IHYib0QY99Hae2xO/F1iLN49cqNkEPihSniQRy/XogBo6z3UOnPW2TTuRKdLELfbmQ5iRUjXQ==
X-Received: by 2002:a17:902:ec8b:b0:1db:b8da:ddfd with SMTP id x11-20020a170902ec8b00b001dbb8daddfdmr1220943plg.50.1708110379239;
        Fri, 16 Feb 2024 11:06:19 -0800 (PST)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id x12-20020a170902e04c00b001d958de13c7sm220415plx.0.2024.02.16.11.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 11:06:18 -0800 (PST)
Date: Fri, 16 Feb 2024 11:06:18 -0800 (PST)
X-Google-Original-Date: Fri, 16 Feb 2024 11:06:15 PST (-0800)
Subject:     Re: (subset) [PATCH v8 0/4] RISC-V: Add MMC support for TH1520 boards
In-Reply-To: <20231212-flammable-idiom-660b1d85e20d@spud>
CC: Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
  jszhang@kernel.org, guoren@kernel.org, wefu@redhat.com, Conor Dooley <conor@kernel.org>,
  robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, dfustini@baylibre.com,
  Conor Dooley <conor.dooley@microchip.com>, jkridner@beagleboard.org, robertcnelson@beagleboard.org,
  linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Conor Dooley <conor@kernel.org>
Message-ID: <mhng-a8843466-ecdf-4e7b-a866-c0cd2683774f@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Tue, 12 Dec 2023 11:13:25 PST (-0800), Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>
> On Wed, 06 Dec 2023 00:09:20 -0800, Drew Fustini wrote:
>> This series enables the MMC controller in the T-Head TH1520 SoC and
>> enables the eMMC and microSD on both the BeagleV Ahead and the Sipeed
>> LicheePi 4A.
>>
>> The drivers/mmc/host patches from v6 were applied by Ulf and are already
>> in the linux-next [1][2] as well as the bindings patch [3]. Thus v7 was
>> only a defconfig patch and three device tree patches. This v8 is a
>> followup to change the dwcmshc node names to match the documentation.
>>
>> [...]
>
> Applied to riscv-dt-for-next, thanks! The defconfig patch is Palmer's
> to take :)

Sorry I missed this.  It's on my staging branch, but I'm still debugging 
some boot hangs post-merge so it might take a bit to show up on 
linux-next...

>
> [2/4] riscv: dts: thead: Add TH1520 mmc controllers and sdhci clock
>       https://git.kernel.org/conor/c/a77f02e84896
> [3/4] riscv: dts: thead: Enable BeagleV Ahead eMMC and microSD
>       https://git.kernel.org/conor/c/18d92a03b319
> [4/4] riscv: dts: thead: Enable LicheePi 4A eMMC and microSD
>       https://git.kernel.org/conor/c/b6b5028473ce
>
> Thanks,
> Conor.

