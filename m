Return-Path: <linux-kernel+bounces-90112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5572986FA7E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B0B01F2103B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 07:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D44134BF;
	Mon,  4 Mar 2024 07:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UlxHZzva"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A66B13FEB
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 07:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709536155; cv=none; b=D2KzZg1oBogFugynYNGGg68otrrAm0BVnMe9358z90j0903ahEtDgAIZyaqILZN8wGIIMZDVLvzyNsNIf6jA3NdyBlUggWlnaFqPyuFXQPWkhkiqslVVi13Cjom7xqQ/f+GZbweGchF9X6fVbDe20a1MfJKkEqbUdm8eNMGtJGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709536155; c=relaxed/simple;
	bh=+A9vsuYrYL7prLESEnutlZM5tyD4hloL5PPKBkU/1yI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJTWOpw6lnnyQx4ciEElN1Qa2be2wRRAazw90uCo+1UKFWEAXGMOOFecVK1m7GG5bmKS4KJ8ib30e6LthtNP+nTzLQN+3Q0THZ4IViyZD1ldQyd0ru3ngHcommpg1thYZH+jpk+BANV1hCTQt2hNJF0K+e2wDBw3EnSUnXOnkLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UlxHZzva; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dcd0431f00so25523135ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 23:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709536153; x=1710140953; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n+zV8At+QIPEvAtFzvpCNXCNPoGBw00JoBxGHFZGbLM=;
        b=UlxHZzva85PRbTojHEfpKtD8RvQci8xwjEnaAygal5I55X6jFdMZq6wZ0tPn+5BoRv
         aNCDGBqPNqZeGfcDhg4bAvV8j1gwiYPUACaVt8m9Gnz261oBuIUYve1zDgaGxdqs7uNk
         U6QFurIjHkLwYp0CrtddNEvI+os878SsM4+x6i3VJCwz4GkJf+lyN+6mmfCnlus27dmw
         /MxKZ5o2nKNeS+GJZN73cZY/0evEGGx2yrAHgJhTxUojvWNVqDuytgKXZYXa9bZvONGk
         ggOHGk6na7jKYQR5cwJL2Iz5m6knyho0vkf+ceL+sy6e8RLK7VCUHjc6P2YTPbFeg4bZ
         meWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709536153; x=1710140953;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n+zV8At+QIPEvAtFzvpCNXCNPoGBw00JoBxGHFZGbLM=;
        b=a5JdCalPN4WFvfOohBtGrjmveiWzTy01E0/rPufC81iXET0tZpPQ3UNflMFCWaa0lA
         6Bq8SQh2C7aqK4WaO51yJfSYelKxSNHql82IoF4BxAY44/B1lgah4ByRtX2Hze8Vn4qh
         82sRmqmiWstSsjdRu+qpKl8/GALtrKzIjd6ZwJ0odT/1y+orR/k7RW6oLWtio7Nhncm6
         3hPo6bLnuneoETtrBqCcYGteTVF+/FCAaJ0glXGFvvSeI+ETO7O4Z7opWu6mhZ19GBR9
         Pyk4df2UvQtG+5eTc5uR+HXVQ71NaPU2Dk0DeBM4aIM/Y/Do3U7fD4HwCMeEQOopYSFw
         FW6w==
X-Forwarded-Encrypted: i=1; AJvYcCXI4uPtcD77Gx+VItwkan/LBy8hMjmCdgCHguOC34X7OsN+6DlM9ZeQv5N9Qei34xAaIBnKfF//CSBGvwzKxSkibw3VS4qALrgiUKTI
X-Gm-Message-State: AOJu0Yzw1MAOcthkINDJqxEiFCuO+01LYSccyNQhbXLBhsA8EvnfCuDl
	zuCMqsDhQMmYoUg8cBRC6cPWi1vq9I6vIYZUF8o7aSltr7Xb1Bc3h7fDosUi3Pc=
X-Google-Smtp-Source: AGHT+IHJxyX4EeUgRH56ZjuDB4mXGWhmRD9wMKWNWNmFh6nkhr1j78oSpV79A3Sr6Lv0eXlAvlfSaw==
X-Received: by 2002:a17:902:a385:b0:1dc:afd1:9c37 with SMTP id x5-20020a170902a38500b001dcafd19c37mr6968268pla.24.1709536153521;
        Sun, 03 Mar 2024 23:09:13 -0800 (PST)
Received: from localhost ([122.172.85.206])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902c20c00b001dbab519ce7sm7689865pll.212.2024.03.03.23.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 23:09:13 -0800 (PST)
Date: Mon, 4 Mar 2024 12:39:11 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: sudeep.holla@arm.com, Sibi Sankar <quic_sibis@quicinc.com>
Cc: cristian.marussi@arm.com, rafael@kernel.org, morten.rasmussen@arm.com,
	dietmar.eggemann@arm.com, lukasz.luba@arm.com, sboyd@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_mdtipton@quicinc.com,
	linux-arm-msm@vger.kernel.org, nm@ti.com
Subject: Re: [PATCH V2 0/3] cpufreq: scmi: Add boost frequency support
Message-ID: <20240304070911.lr6uye75ykz4gilj@vireshk-i7>
References: <20240227173434.650334-1-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227173434.650334-1-quic_sibis@quicinc.com>

On 27-02-24, 23:04, Sibi Sankar wrote:
> This series adds provision to mark dynamic opps as boost capable and adds
> boost frequency support to the scmi cpufreq driver.
> 
> V2:
> * Document boost flag. [Lukasz]
> * Remove sustained_freq check. [Pierre]
> * simplify sustained_freq_khz calculation. [Sudeep]
> * fix default per-policy state. [Dietmar]
> * fix typo in commit message in patch 3.
> 
> Depends on:
> per-policy boost: https://patchwork.kernel.org/project/linux-arm-msm/cover/20240227165309.620422-1-quic_sibis@quicinc.com/

It doesn't really depend on it, just that there is a bug that needs to
be fixed.

> Sibi Sankar (3):
>   OPP: Extend dev_pm_opp_data with turbo support
>   firmware: arm_scmi: Add support for marking certain frequencies as
>     boost
>   cpufreq: scmi: Enable boost support

Sudeep,

Can I apply this series ?

-- 
viresh

