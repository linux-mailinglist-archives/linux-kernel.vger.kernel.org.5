Return-Path: <linux-kernel+bounces-34753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAD6838721
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 07:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1DB61F24046
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 06:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A7B4F20C;
	Tue, 23 Jan 2024 06:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cNRO6RFu"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9113F4EB55
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 06:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705990197; cv=none; b=OMxA2OiHOT/iNXtShW5oUK8KvXQbbFdfVHs0yWM6QfUaT4eyiIDBpK+X4POnvXJWtdEny/jnsAOf7TrxYXnflJcFTRmY/FrE40FJJV1EKwB9sDNfS+uKmmfPYexflR9yY1l7ADL+O8i8msMxlgQ0uh85tmETBz+b4bK6xrMp9zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705990197; c=relaxed/simple;
	bh=fICYgU/e513dmMdbagqrvMAVnM53SUgfbQwsBjy+Yos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l9Q/CLA0vA/znZIPMElZxoEWv7MykCoC8bzDL5/mZE2Z8cqiI81gcV6Lu6sM96NiN9rzCQCvHLXOkGGc0v8jrMl/AIv/K6wUfaDCstXqAlr5WDs7BzOW/jIJ/cNoIosMtJz89U50SsDxQ1yVyigO3+KpsEgRDUoF8Hy3uQ6aka4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cNRO6RFu; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6dde1f23060so2510625a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 22:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705990194; x=1706594994; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gH5uJ9kMxbNgHS2YfX23GkOHBxHF1R2S8Ddt4Z+/Q6A=;
        b=cNRO6RFujdUoG9tD0smiK15hLZ5J3zS5hkUPx9zzpf2ZLUiRvk8qTCUFzU7dWDuAhT
         3a3ovEpoYJ9/AlNO6b3XBxm37W3zlMQqFV9HKMhMsx9Gx4S+SPgTeL9J+ADGdm0e++fV
         YzQRt/q7J3eb5GPwkYaK+dYlf5QiAr3WxSIL4ddFa80sBHuuqYuXpzkjHLcIUfuCMsb3
         EZ5/TqaQ4li3PZ51ZrMs5Vu8gjw7YQBd+kQrL60NYmDFG1z6idhYHtKz5zJnMEk0W1Ye
         /nxGUKaLWvvo9ZckZMx1WZ9vX2TudRik1KfnLMcSGUiZq+QUczLKQ+qjyj4EyZXkuA7E
         Kstw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705990194; x=1706594994;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gH5uJ9kMxbNgHS2YfX23GkOHBxHF1R2S8Ddt4Z+/Q6A=;
        b=mZHu90Fnr5QmotCpQ6z4H+d68/Y/3KBtunTLFLMlj2tOol+6enEd0ND7w2gcJLj1Kd
         7DR2/XlW+rB4uMAvi60JrBXXDci3qAIOf4E6dVBhxrunB7HI1KYWiupaUGDuXq5JchU8
         SKtIZ1fmvF/h0qFN5Tm8CSeYD8Bpkg4aSVopYKO0Lo4rqTGC1GhrVx9LdH8oMroKV6sj
         9H6Vz6OHv/djQTOiQcEWC8/zqDwvxyZXQhUObHOUn52upYKmXILa7FKcO8YLcpRxz+Gs
         sfRman/68uV5n0YuQeM39avt2A/uzJxkUVScY6BdR+144iV+FZWdKgrPQeWFHEWJXkIT
         goUg==
X-Gm-Message-State: AOJu0Yyxji9jj2Pbqpm0Ww/KUPG7u6If4oCexIwQwhbBalxoVoCOV6xQ
	ZZulvUeYzBGKnHYslLUyqSgNzt5a1UUUwTbBt53ojfCktdMK0Mp++g/IVsJNjtI=
X-Google-Smtp-Source: AGHT+IEa6u4y25PmtAOJIzMLZ7kuLsaH6aiw8FXp0uievkuh4/VBS03zIAsrfkYHzALHuHoy/WXCXA==
X-Received: by 2002:a05:6358:281a:b0:174:f664:e477 with SMTP id k26-20020a056358281a00b00174f664e477mr5037598rwb.60.1705990194606;
        Mon, 22 Jan 2024 22:09:54 -0800 (PST)
Received: from localhost ([122.172.81.83])
        by smtp.gmail.com with ESMTPSA id s4-20020a62e704000000b006dbd59c126fsm4198271pfh.11.2024.01.22.22.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 22:09:53 -0800 (PST)
Date: Tue, 23 Jan 2024 11:39:51 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>, kernel@collabora.com,
	"Hector.Yuan" <hector.yuan@mediatek.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 2/2] cpufreq: mediatek-hw: Wait for CPU supplies
 before probing
Message-ID: <20240123060951.2m6h6t537bu27ois@vireshk-i7>
References: <20240110142305.755367-1-nfraprado@collabora.com>
 <20240110142305.755367-3-nfraprado@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240110142305.755367-3-nfraprado@collabora.com>

On 10-01-24, 11:23, Nícolas F. R. A. Prado wrote:
> Before proceeding with the probe and enabling frequency scaling for the
> CPUs, make sure that all supplies feeding the CPUs have probed.
> 
> This fixes an issue observed on MT8195-Tomato where if the
> mediatek-cpufreq-hw driver enabled the hardware (by writing to
> REG_FREQ_ENABLE) before the SPMI controller driver (spmi-mtk-pmif),
> behind which lies the big CPU supply, probed the platform would hang
> shortly after with "rcu: INFO: rcu_preempt detected stalls on
> CPUs/tasks" being printed in the log.
> 
> Fixes: 4855e26bcf4d ("cpufreq: mediatek-hw: Add support for CPUFREQ HW")
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Applied 2/2. Thanks.

-- 
viresh

