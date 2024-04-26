Return-Path: <linux-kernel+bounces-160121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC488B396B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06CE4B222A0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398E61487DA;
	Fri, 26 Apr 2024 14:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b="AKQocuZd"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFE17E573
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 14:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714140133; cv=none; b=Dfyj5wx5PlmyaGZucmk2I4esAsd3xPGFBYhY1oQxHK/9pHYBCx129AD+z6DvNfFcc5yua4r8mXiLwtFM52R+u179oxTPqxvVDR+qtbyOeeRzvC50mEsBDiC8NfZNSfICjvMdTeGm5LNvEpxEapT8r8XYZMNq++RuO/rGj1VgWps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714140133; c=relaxed/simple;
	bh=HZDsGbmh+YJvzqUYjBzipiRUUq1OHnGZ+Kln31mCXY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bgSucmBVBsnldLwGHh7CLnqH3ACRLwZ220lXixQR5yFhPhVsVpPhmIgEZbHrVuNejqVt67Smv+U6JFRK5yqCIsbMZZkd8D+WiCqtBbisFmbFYly39XXEubb03Tx/Y0iY4Qye+pQrczAJN1CYvPmtJF5ERbgpuTclNUPWxs/OLUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org; spf=pass smtp.mailfrom=postmarketos.org; dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b=AKQocuZd; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=postmarketos.org
Message-ID: <9c5b1759-24fd-44f8-bfee-d1ff61a3fd41@postmarketos.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1714140129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=set4n7Bfvg/nCVRqXHEkPOl5DaTKubnkbfpADbsPLsA=;
	b=AKQocuZdWNFvfJGaHtn03BiXdNglxDXGBarueV50w5UMXjGwSzsaZCc5s77EIgI85LQX27
	Cr6T/s5qeguXtKV128lBSAxqnsDOlXYWp15X6CvT7ZJ0fjTtqXeqYXRGVSPgJA9NUFQbFv
	zr+no3hgkVF4Vwgx/jfPgAuO+4M9EoMgyYpsei92lh41IE52wKphLUFb5ruN6woYPpZ0mg
	ZUJ3tiTD25dyjnXRu6zFzCPLUg7XRHnJuoA7bjhFpsiMGQKU+n/gSlqPmou76dgHExLd0/
	xWf2oIe/sKXJA54FMqolxZnfZ1oNDbZWD5QW4z+c7NQVEt3FhxdQja2ijwcIew==
Date: Fri, 26 Apr 2024 17:02:06 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v7 0/6] soc: qcom: add in-kernel pd-mapper implementation
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Sibi Sankar <quic_sibis@quicinc.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-remoteproc@vger.kernel.org, Johan Hovold <johan+linaro@kernel.org>,
 Xilin Wu <wuxilin123@gmail.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
References: <20240424-qcom-pd-mapper-v7-0-05f7fc646e0f@linaro.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Alexey Minnekhanov <alexeymin@postmarketos.org>
In-Reply-To: <20240424-qcom-pd-mapper-v7-0-05f7fc646e0f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 24.04.2024 12:27, Dmitry Baryshkov wrote:
> Protection domain mapper is a QMI service providing mapping between
> 'protection domains' and services supported / allowed in these domains.
> For example such mapping is required for loading of the WiFi firmware or
> for properly starting up the UCSI / altmode / battery manager support.
> 
> The existing userspace implementation has several issue. It doesn't play
> well with CONFIG_EXTRA_FIRMWARE, it doesn't reread the JSON files if the
> firmware location is changed (or if the firmware was not available at
> the time pd-mapper was started but the corresponding directory is
> mounted later), etc.
> 
> However this configuration is largely static and common between
> different platforms. Provide in-kernel service implementing static
> per-platform data.
> 
> Unlike previous revisions of the patchset, this iteration uses static
> configuration per platform, rather than building it dynamically from the
> list of DSPs being started.
> 
> To: Bjorn Andersson <andersson@kernel.org>
> To: Konrad Dybcio <konrad.dybcio@linaro.org>
> To: Sibi Sankar <quic_sibis@quicinc.com>
> To: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-remoteproc@vger.kernel.org
> Cc: Johan Hovold <johan+linaro@kernel.org>
> Cc: Xilin Wu <wuxilin123@gmail.com>
> Cc: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
> --
> 
> Changes in v7:
> - Fixed modular build (Steev)
> - Link to v6: https://lore.kernel.org/r/20240422-qcom-pd-mapper-v6-0-f96957d01207@linaro.org
> 
> Changes in v6:
> - Reworked mutex to fix lockdep issue on deregistration
> - Fixed dependencies between PD-mapper and remoteproc to fix modular
>    builds (Krzysztof)
> - Added EXPORT_SYMBOL_GPL to fix modular builds (Krzysztof)
> - Fixed kerneldocs (Krzysztof)
> - Removed extra pr_debug messages (Krzysztof)
> - Fixed wcss build (Krzysztof)
> - Added platforms which do not require protection domain mapping to
>    silence the notice on those platforms
> - Link to v5: https://lore.kernel.org/r/20240419-qcom-pd-mapper-v5-0-e35b6f847e99@linaro.org
> 
> Changes in v5:
> - pdr: drop lock in pdr_register_listener, list_lock is already held (Chris Lew)
> - pd_mapper: reworked to provide static configuration per platform
>    (Bjorn)
> - Link to v4: https://lore.kernel.org/r/20240311-qcom-pd-mapper-v4-0-24679cca5c24@linaro.org
> 
> Changes in v4:
> - Fixed missing chunk, reenabled kfree in qmi_del_server (Konrad)
> - Added configuration for sm6350 (Thanks to Luca)
> - Removed RFC tag (Konrad)
> - Link to v3: https://lore.kernel.org/r/20240304-qcom-pd-mapper-v3-0-6858fa1ac1c8@linaro.org
> 
> Changes in RFC v3:
> - Send start / stop notifications when PD-mapper domain list is changed
> - Reworked the way PD-mapper treats protection domains, register all of
>    them in a single batch
> - Added SC7180 domains configuration based on TCL Book 14 GO
> - Link to v2: https://lore.kernel.org/r/20240301-qcom-pd-mapper-v2-0-5d12a081d9d1@linaro.org
> 
> Changes in RFC v2:
> - Swapped num_domains / domains (Konrad)
> - Fixed an issue with battery not working on sc8280xp
> - Added missing configuration for QCS404
> 

I've tested this series on sdm660 device, with userspace pd-mapper
service disabled, and don't see any regressions - e.g Wi-Fi/BT
still come online and work as before.

Debug logs:
https://paste.sr.ht/~minlexx/bd03db4c582a3275078ce4fd05ea76ce46a52b8e

Missing cdsp_root and adsp_sensors PDs are not currently an issue,
because those are not enabled yet on SDM660 or hard to test, so

Tested-by: Alexey Minnekhanov <alexeymin@postmarketos.org>

-- 
Regards,
Alexey Minnekhanov
postmarketOS developer

