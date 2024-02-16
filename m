Return-Path: <linux-kernel+bounces-68743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3C0857F4C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47F211F23C10
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CDE12CDB3;
	Fri, 16 Feb 2024 14:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tnVLpvzm"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA5E78B4C
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 14:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708093626; cv=none; b=gHA98p6oGBUNpyK236CnyNXYeiRY15kobDju543lrECAFyPS6xpblCJ23PcHZDBq0uqKImWTnEdCRr8ZSMj8Hu9hz/WpstdKcOlDiZVwK7LX/fH5dF6LDk99+i3ZshiSHsVomM4DNLBZBjEI8DLM7mhsCU6/JF7xTn29e90NS+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708093626; c=relaxed/simple;
	bh=Edz8EsekUiMLzOhyQJud0Qpszc8nikksU/CeG6aT/44=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OTjAAUHg7p0FblaH2w4n4d0pwhDYsaYQswYirAF1oyujjKlpSKJBNGQfMvxUQado1IzVJOKDNPr/A3tvztEJB91vhrjOf0F8axzD/19xo6xMo5cd7ctjBZwLB8cbdcCHLD0lUJ7u8Gq+EQkp6wAT5zjYowdVnb8nZReXUmfJ0Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tnVLpvzm; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55ad2a47b7aso2934989a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 06:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708093623; x=1708698423; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YX3KVONGaKL/+cfVdIf5qOfUj2ReaxP0KFNOM/lKY8g=;
        b=tnVLpvzmyGgcrU207vb32Py2+pR2Q4Ilcy62uKmgkwOEp6+etCop8z64fRj9RNB7pF
         NGOg69T+IodyRYWEiZ4Nk970GNTuKuYlGbjdB9FrBiUe3I/pWwJUYHUPxhC8eEF0TQQH
         z4sy3JVHgEe0/YKvv1aq1VV3qvZ8vgguxzAu260ayiCjHYzMziEnQq9WvjlV4aWJgbUO
         xQTphZ0ijBiGM0uClrQ7ZvLVZfNEBR3zD6Cro0u5pyeXgX5MabmeTrmc7xqtAO29e5Zn
         NAbos5o6rKzv6CSTTyRE+kmU8MFQITErhamByYtCQf8fX4mUsfP75nuaLwNS+E3PnGKN
         vkjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708093623; x=1708698423;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YX3KVONGaKL/+cfVdIf5qOfUj2ReaxP0KFNOM/lKY8g=;
        b=MY6KVaQfO/vXtBG5KBiMLVCfEEzA/VmYI8v+xw7fWVlGD50HWwhMcTKLBVe5YrztxJ
         PN/YVKCn2rcfovp6DKAK2Qm7+AAw0ubWH3fFy6b8LRYrlTsK1OLHBoEb/2guhE2sOypj
         njXp9oTXT149wssxpYq9NWBpuIW+Ol+rhvNQcQZEJUUeLdfiZXpGKiWxYx7Xu9FhKIHD
         WMSRcLrYG4A9GCAanSeEc7j8xh9GwIjIYDp8L3eeeWFOLivKTQsQL3ALbmt8ypo94R0g
         274nm23dOX4CsoRxveTvrcOdZhiAJ6YrwuHfC2t/Oh+vJW1meCmmjxM3Js9gb/bntyDs
         tW/A==
X-Gm-Message-State: AOJu0YxdIJ2f4EJVBOd3CJToVLeKFL5H9tk1c4R+yIbshU19hrPEXSbo
	COGjw8mhNTn/FImkhrLVneXF+2tOa+TDitWcEeSP7N+oY19NvuxLnmeEOEGDMot6uO7s0UCq+AI
	z
X-Google-Smtp-Source: AGHT+IHugTV6Jok5OHz7GlnSz+q/H3J1cRw1PJgwcuyGVl2rBOMyj1xn3Mds6N5/PpVu/nAw3txNPQ==
X-Received: by 2002:a17:906:d86:b0:a3d:7559:6ed1 with SMTP id m6-20020a1709060d8600b00a3d75596ed1mr3539918eji.4.1708093623188;
        Fri, 16 Feb 2024 06:27:03 -0800 (PST)
Received: from rayden (h-217-31-164-171.A175.priv.bahnhof.se. [217.31.164.171])
        by smtp.gmail.com with ESMTPSA id p19-20020a170906b21300b00a3dad483948sm1249648ejz.182.2024.02.16.06.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 06:27:02 -0800 (PST)
Date: Fri, 16 Feb 2024 15:27:00 +0100
From: Jens Wiklander <jens.wiklander@linaro.org>
To: arm@kernel.org, soc@kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] Make tee_bus_type const for v6.9
Message-ID: <20240216142700.GA3863398@rayden>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello arm-soc maitainers,

Please pull this small patch making tee_bus_type const.

Thanks,
Jens

The following changes since commit 41bccc98fb7931d63d03f326a746ac4d429c1dd3:

  Linux 6.8-rc2 (2024-01-28 17:01:12 -0800)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git/ tags/tee-bus-type-for-v6.9

for you to fetch changes up to 1d044941d53855ca06e4fa34936ff7273c8641dd:

  tee: make tee_bus_type const (2024-02-15 08:28:24 +0100)

----------------------------------------------------------------
tee: make tee_bus_type const

----------------------------------------------------------------
Ricardo B. Marliere (1):
      tee: make tee_bus_type const

 drivers/tee/tee_core.c  | 2 +-
 include/linux/tee_drv.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

