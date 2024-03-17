Return-Path: <linux-kernel+bounces-105350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E72887DC82
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 08:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A22661F216BF
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 07:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A207B1D543;
	Sun, 17 Mar 2024 07:34:21 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AB21D529
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 07:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710660861; cv=none; b=dyNWyGnX1D7Tpi6nXLwqyQqYy6LZx7UVJvvIzPnUqyjZd3p5oyrP2e4uELThW9O/lMeNUlpRFPn9895bkIHTbDn1JQdQItrtelRrUGXDMnutTWT9cwA2R4Iy3JrLDNaYCey4W7p0H6aggN0GtZOqhDMulJhIV03H9wepXSlLWos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710660861; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NKGaELXnYqxCXcTJolUJUhRDeDdyntx4AlZVgrfyJU67xtmCVVSN1QyB6ZY0oHHRbEusL60SJfAV1ux3UYcnBAjzpBnRzvUdCixTFowcYz+YfZRD0ScsZHNWod/8kFHR4mIUbtAPrE7gOhuTcgNLxkq/HRgTxKn3s9y4sjqYxkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33ec94c7ca1so845882f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 00:34:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710660858; x=1711265658;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=ms5WYu8Haek+FfhjlWAnHljH4BQ4E1jz4QxyegKSEjk6nDXyu3Hw5ImSC22xtLWHog
         s1vZ9elg2/efLtW7UQPsH410At+HiLrjp+yY5yhdczrQXYJJbX8gV8apYh0MXWQG3ngt
         M9riHb1yIMoO1+7ufc2fOuG0uwuXdymYvOeuWyPTd/v9go9gqB0Xp9lldSq2lLXYlHWY
         1FyqG4xZ6XPD7LJ3CP29ojs2pqNFVZnBtPbsJyOPSHoS6JwC0agejkzzASdiqeFtdMfI
         /GNEJ5InC9yrCcR6kjAZvSNeCuMwzb3cq4x7it6lKHRzCD8NoPmou5QCrHxfa8gSfPB3
         9SnQ==
X-Gm-Message-State: AOJu0YxIUyE6ONWclqOYx3IRvzWUTHN6GZa0vyJ+iJ0a+7hSjjbAFCdw
	7iQI+WfleIwgH1AFfMVBJMJp6RwAcPwKT5ktfN4kFpbtQp12yPQy
X-Google-Smtp-Source: AGHT+IE/o7X60HvPX9bd6eKTj+xZxjK3TOTidyqM0UZRPlt80TdREw//a4SDFk6Qmj3dBm11We7Exw==
X-Received: by 2002:a05:600c:1d9b:b0:414:9e7:152 with SMTP id p27-20020a05600c1d9b00b0041409e70152mr1532656wms.3.1710660858009;
        Sun, 17 Mar 2024 00:34:18 -0700 (PDT)
Received: from [10.50.4.153] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id d6-20020a05600c3ac600b004140b96dd4dsm1503659wms.21.2024.03.17.00.34.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Mar 2024 00:34:17 -0700 (PDT)
Message-ID: <b1f351b3-4258-40d5-9074-5d0390d2afde@grimberg.me>
Date: Sun, 17 Mar 2024 09:34:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers/nvme: Add quirks for device 126f:2262
Content-Language: he-IL, en-US
To: iBug <i@ibugone.com>, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
 linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
References: <20240315192747.1749119-3-i@ibugone.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240315192747.1749119-3-i@ibugone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

