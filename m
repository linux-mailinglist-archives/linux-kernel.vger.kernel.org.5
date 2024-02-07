Return-Path: <linux-kernel+bounces-56331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9739584C8CC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E990281661
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B481B7E3;
	Wed,  7 Feb 2024 10:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rtp9rnzJ"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48671A27E
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 10:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707302373; cv=none; b=W6aqIBFLdlUA5M32dDlLTg6rMa7uVdL8IoiRuUZVN25n0W0zPpxMbnpGA8hj6yH5PFOViVZZH/wYwO8YHyGbL/y81SbRmXc+PvjgzWBgY3o+kjq2LlsfQu8nG5QnydgOjBDScqI3cZIzodnJckiTNg1BckNYFek16ovCj6bIE1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707302373; c=relaxed/simple;
	bh=LBNaRECj6dZYj4opxjeNoC/rrJW1imtvz7hMKf392Xw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dIsRug9eolD0kD0faL6P4YLc2a1MiBcFiPHQ7t9ZxnbDqSh10/l4q4lFWke47Tu4TSDnsIU9ExxXAwqeuzQBUIwtrkoKUcOLuDFX7Bv4qPzThrDmn1Y1SidSZjaBBjm+8fE2cLjc+shob7nmkbO5Q2hJ+a3Oqg7uvbPMdLm/HXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Rtp9rnzJ; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-511531f03f6so523874e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 02:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707302370; x=1707907170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dfn60JJbW7ZmqouExzAHtYMCfc4R1yQ5pVABs7D1eOk=;
        b=Rtp9rnzJclTqjeENtiZDTT6odbQdV9BhShSn4GnIlFhKdr04U+Dg4u/KG01XY84oVA
         CkHf9rljMOGtscS0vEETwNgEK+UTCvQIwK167b4GgsZgH6LYmv95LIP7UkFAYH9ZNUtH
         3ikUREb1MnVbgR2jQ9PZjf1DFRFmWaAbAux80QNBJ4ZYspmAB2airrzj+mJ7+Qk2WTG1
         Z5OKRY4psLoryyVXZebDhgm+PWwivymGYaLagw5SlFz7IG/SesWpqnhtAlsdwGil4y7g
         PlN+WKrvIx7+Ifv73NLOVFmDalT1pEYqjwjKzif7HfDF3Sn0H/yxEy0eH1h9iNuvcZm4
         WSYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707302370; x=1707907170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dfn60JJbW7ZmqouExzAHtYMCfc4R1yQ5pVABs7D1eOk=;
        b=b16w62dqteeZ3ixVOOQIoq9kk+fiGOaxgMCl2yswQXTbu86JLEp25YbKZt972GBF/8
         medjUl7+GkVm3Q9sQXyH7WR4Ai8A8iNwEMvfseCrUMuuYfjit8aGw8P+jS/s+gZc46em
         gTXW/BwjNs4PggBuyHQglkDmPWOmWenxZqcsnErCWFwjPDwfXxHkFsB0cUIVLTMQdgsv
         tHV1Y6IwT/GLJCrpnMXuMbKwFKlWxJKn/tBTYR4Bs+JnQQ6dSFAMXDzbfZMFWr5npkat
         izDneLCWSwE5gYoWQFnR08+OSyS6cpEYQplMKrVZDAFQUlcsBLp2VF0qiiItJMZm+Ftv
         Hp0g==
X-Forwarded-Encrypted: i=1; AJvYcCUfKiV7xlcGRFOCGQKK0IXHHUk1JMH8SyXCQJmdjxwxEaN8q1JpoHxg/4bYMhvSM1VnuGieQQIbpW3xPLmOJVyQLsdvT1r1fudosqi6
X-Gm-Message-State: AOJu0YxURTmp72XboKrCHnHDVe2Q59FvkqxUyq2OI2bEkMb7Fa2RDEe0
	pSagVvzfuC+8Z8Dw62TzDZzDqL5fe0yB8VrLJLlta4Ly+Bq36C+LVtaM9bJqHiA=
X-Google-Smtp-Source: AGHT+IEipOfbNK9V08XJPCsd03wUBBzs9t3wZxjrqCsg9IqwLKFhr/huOTxY1ppV6pEIHt6ZJdr1+A==
X-Received: by 2002:a05:6512:29e:b0:511:4ff2:ee40 with SMTP id j30-20020a056512029e00b005114ff2ee40mr4008102lfp.2.1707302369783;
        Wed, 07 Feb 2024 02:39:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVD8EdgZc3nksJaP0oIYnia74Z174M64l+MZjJP2i/5YDCnM3T2yVRG8smRau9je/Pk106Y6OLEaHc/LlYnctkgmosO3vqqIH0P5XoHGc1GbH+1Gb6d1n6ZoC3n/1JOx3hWM1siqixifmHRv15dntCs51lnl0um9O2dK86p/CZ6re2NClJo4yZivR4OsYuj9Cg/3gXKhZ35t9JsGFwscFx5WcGaewxtPA8lr5HlHk3nB/mz1vMtx84tV7Vtt30Ssf8Z7YgOXQaqrexJ+A==
Received: from eriador.lan (dzyjmhyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a00e:a300::227])
        by smtp.gmail.com with ESMTPSA id z2-20020a056512308200b0051156758496sm135106lfd.92.2024.02.07.02.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 02:39:29 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	"Ricardo B. Marliere" <ricardo@marliere.net>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/2] drivers: drm: struct bus_type cleanup
Date: Wed,  7 Feb 2024 12:39:26 +0200
Message-ID: <170730233341.360722.2569543187695193129.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203-bus_cleanup-gpu-v1-0-1b6ecdb5f941@marliere.net>
References: <20240203-bus_cleanup-gpu-v1-0-1b6ecdb5f941@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sat, 03 Feb 2024 15:25:02 -0300, Ricardo B. Marliere wrote:
> This series is part of an effort to cleanup the users of the driver
> core, as can be seen in many recent patches authored by Greg across the
> tree (e.g. [1]). Specifically, this series is part of the task of
> splitting one of his TODOs [2].
> 

Applied to drm-misc-next, thanks!

[1/2] drm: display: make dp_aux_bus_type const
      commit: 78cb1f1d19b600ed288ed7ad1fd7b9378302cbc5
[2/2] drm: mipi-dsi: make mipi_dsi_bus_type const
      commit: 2c8ba564a42c7418a726367c73d7c88454848fdc

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

