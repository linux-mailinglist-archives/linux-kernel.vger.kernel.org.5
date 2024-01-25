Return-Path: <linux-kernel+bounces-37958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2359E83B8D1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 05:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5690C1C2346E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 04:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7D379FB;
	Thu, 25 Jan 2024 04:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j+RPm/+r"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5301E67C4F
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 04:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706158738; cv=none; b=dluRUfTbK5aBFZk+8nlXMpqvGvNimd4LngjkTcsEmWLyryHPgXdbIZn9WQYGXTmww93RhaaM8yiA1a0pqbqX4/ZZFZ8LLJVpIS6IlW0uukS2xEmiQKYeukWsP8EMF28fIiX6s9qHaneinL9hnsdKXulmk/UUcnjxHSqOkkZadJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706158738; c=relaxed/simple;
	bh=jKgRaBrera7YyMCh7wCiTuLbZwe0CrLa611g0LvaYg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wa8bQxCVUigLcxmUm8w8J/J8o7B8FQwxhmI8Xd0/gVPn5k2s7vdq15y9hM48MP31y+cPParTPJL7vt9iaTky6PDTtk8OCf6JV/4+/YTeJNFbRE6dZU9vAf6pF1tAoc5zS0NgQf0vzTGXj/HWJhFLp5tSs9VnAkeQD/nWGy+6jtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j+RPm/+r; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6dc8b280155so2866547a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 20:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706158735; x=1706763535; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tpo7S81Q6e7picJzGDOqqGEtmvErnEcq2Z13Hltk/j8=;
        b=j+RPm/+rhD2K5zx8ZglGmSn8BX5eFhM+76hB6UpKniqIwqWvpfXtIDlPikA4IGdyU4
         iItTN4nJXN8tf1+Vy94QSJdH8/VypVCzeMJMBUA7fjiZrZrXYmLDnuj1cI0gcV++OgNU
         L4bUBy1KBu1SWwEbp2WlsYBIYU3a0qf/YgWigRFWMxzxETISem0yzm79om7Ww13h8WIj
         JX58oS0acO+jeLGcy6MK46wdnyIKvz5xo3kx2to1cjbMl834hghBH3iMqujLL2yc6YrD
         8m7+l1biDiXuUFbtVrgEstFt4JXV0aJLAVpSs/l9kBhnwIKV/FjAzx6P88z/Ho3jB4Dz
         jerg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706158735; x=1706763535;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tpo7S81Q6e7picJzGDOqqGEtmvErnEcq2Z13Hltk/j8=;
        b=DYZHWHZ8ao2PpeWAoMDdwiaGG6Pjl7eQc+p99iQHR3TJcBNL3jpExsRMuBguD1+1az
         QiHVGJ5K3wRJ1QnDsZHkFg0MnrUDQqq640P4ll9KfiAQUgLPZApUwWnfS1uATZxmL9O4
         r5eD2FcUd6RS2uNvhVBcVMNRezxBKL1X4NAGXVWAQOEMuqVxA7Cv2WvzrNcKoIbh3Tup
         eCMKNUkPQ0ZORzYWdi+8fT+HqeiL52irXePzSMo6rt+BIhGEsKX2M3zulxKYczHWlZYt
         3HnQTXGByNsuiAc45s8PdGJ2Cu0uPTvV11cI578uVzmqJXcSlwIsGt5zgDAf/kgLhhte
         VqWA==
X-Gm-Message-State: AOJu0Yxe4xhEFJAQMK6TSPqi6VHSXXGxlZnGvKe8gPxvUOR5eZuJASW4
	2r4ZyEg3FxSpU+LsmGbmNh7kIU3hDvBb0VuFXAek4uTmMinbSgD6n1B2EMIBTl0=
X-Google-Smtp-Source: AGHT+IH73ljD+tyH98GgQeFlyFzdp++7wNKTqWqkYp/Jj3Cf3NjheYdC9xQZhkIOcBEa0yaqPJi7jw==
X-Received: by 2002:a9d:7842:0:b0:6e0:e0e2:9e2d with SMTP id c2-20020a9d7842000000b006e0e0e29e2dmr209980otm.41.1706158735392;
        Wed, 24 Jan 2024 20:58:55 -0800 (PST)
Received: from localhost ([122.172.83.95])
        by smtp.gmail.com with ESMTPSA id t26-20020a63955a000000b005d5a7ddd656sm1109237pgn.36.2024.01.24.20.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 20:58:54 -0800 (PST)
Date: Thu, 25 Jan 2024 10:28:52 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	kernel@collabora.com, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	"kernelci.org bot" <bot@kernelci.org>
Subject: Re: [PATCH] cpufreq: mediatek-hw: Don't error out if supply is not
 found
Message-ID: <20240125045852.urocd3yzts5ajmbh@vireshk-i7>
References: <20240124-mtk-cpufreq-hw-regulator-enodev-fix-v1-1-6f9fb7275886@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240124-mtk-cpufreq-hw-regulator-enodev-fix-v1-1-6f9fb7275886@collabora.com>

On 24-01-24, 17:31, Nícolas F. R. A. Prado wrote:
> devm_regulator_get_optional() returns -ENODEV if no supply can be found.
> By introducing its usage, commit 788715b5f21c ("cpufreq: mediatek-hw:
> Wait for CPU supplies before probing") caused the driver to fail probe
> if no supply was present in any of the CPU DT nodes.
> 
> Use devm_regulator_get() instead since the CPUs do require supplies
> even if not described in the DT. It will gracefully return a dummy
> regulator if none is found in the DT node, allowing probe to succeed.
> 
> Fixes: 788715b5f21c ("cpufreq: mediatek-hw: Wait for CPU supplies before probing")
> Reported-by: kernelci.org bot <bot@kernelci.org>
> Closes: https://linux.kernelci.org/test/case/id/65b0b169710edea22852a3fa/
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>  drivers/cpufreq/mediatek-cpufreq-hw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied. Thanks.

-- 
viresh

