Return-Path: <linux-kernel+bounces-152384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC8B8ABDA8
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 01:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4121B20E98
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 23:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AD54D583;
	Sat, 20 Apr 2024 23:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yr5uPDGS"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CDC495F0
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 23:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713654033; cv=none; b=OqmnmzPG8EaN8KUyHsw4fzs9SfwZ6xn7yMLv8J1Il0+sheInNwsO4s9DVxPn/Aum7jyyyNiPs0Aex8PcGVnKybIZUbKHhACeb839p9TQLZe/DXN5NYlwxze9ErgSyP1kEyOob/NyyxSQ9BuOP6Kcez6WcDPoSKzUov5yVMHoQok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713654033; c=relaxed/simple;
	bh=4W4kNBK/xrEcrUApwzCM7sLtC45HuF/KUzFjcCmXLt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oHinww1amDT+ddUdrk7elNVhMX5heti7e7AqDB+G6Dgos2z2gP1xuHJlhxA+0ar4S5lNXDwqDzAhsVCeB4JhZs9iqv9rekri4ftwcqk2n0Tc+HQnGqvycwl8fa12IDSpCBrZmf+JjtCLFRqiu41VO8uhE97eW+ZPNm7pUX27A+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yr5uPDGS; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56e136cbcecso4482789a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 16:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713654030; x=1714258830; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gS/avcdT3uZE+/g4l+u7eNrKfkVrRBnHoxOYygE+RDE=;
        b=yr5uPDGSisSRWg2BdtLz4v/8WoQaybLA7Pyun9XdF+c2IjnCoJEE+28J0xFgKDDFUA
         jLy+1Ozibv+WHlOotmMQIzz7Z9UDCUBXKnvHmD+40IFh6LhkgWnkb1sUyD07WI/dK5eI
         74ZZo9DP3bxK1rUBP+g3y+19ehWxbKCnYUZQnB/EwNq5QPEXaiRutWzZOdPjzStM7pvA
         +x15lAWyTKucfjzbirdYgmDwy4ZLQ9i8De9vBC77mdCD3xJYXzOGrj4JhacqcTQJOBPB
         uXsFxQ8ML2FJwIgERF7kFGec4d6/ZxJHi/FPJa0cwiwotn1wXqNSdkVOuJKN1Q5ZonZJ
         9GOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713654030; x=1714258830;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gS/avcdT3uZE+/g4l+u7eNrKfkVrRBnHoxOYygE+RDE=;
        b=jkZw5/uCILW5Ebuxzu/muvZ0Mno30IN18u0ulRRvCmrnPwfU4gmCsjSECioD3TbcrD
         CZWVRlQG4wnvWMlEmA35vY5c/DDEOGj5k5DG6V3tVZ0VNkGqsRFES3ARFY3ru6EjGLv9
         YlU7pheRGocqEPu4tftm4p3Y0VChC7niH0d7uLWvk+bpWbpO16bxapZle1aSK3yGoWmE
         USvRMcR0eRLJwvzOofI7mJy4wrUBY4lE7JkPajCqse0eI8xT6PWvBa/9JFTFE7rc7PrC
         rJR5dxXZfzIjN3niyiTqmuGAYA4JNticsHWXn54YAy5ndznH3OmibtfYqHyIC3Mz1P7x
         eykw==
X-Forwarded-Encrypted: i=1; AJvYcCWA5nH1JoD5Fz48akQ1ryFKlwOchmIVD2ek2tupRyFIN/lkNl+gWaLZvcJbyxT0nChY5fOBtuBeuNEeJ7rBnKw8gFEVB2A3mmlMPr2Z
X-Gm-Message-State: AOJu0YzLCKSz4ttCBxGbIKoIs9IEf1w61Icxyu3YWP8kJnpNNT+l5Rs+
	xfRuKr1+nLD+BcUsVCLvp3LrAk3qcSN7DK5vqP4V7SIS1qz2EcwSrFLxvHM+GBw=
X-Google-Smtp-Source: AGHT+IH4lwqPioLpoIzW6dLhOLlXPP3zMShUOxH0TJXNnW3DIij9PpcqOmEnmKfQrSavTUI2UaMo9Q==
X-Received: by 2002:a50:9ece:0:b0:570:cd6:8ef with SMTP id a72-20020a509ece000000b005700cd608efmr4297896edf.29.1713654029517;
        Sat, 20 Apr 2024 16:00:29 -0700 (PDT)
Received: from [192.168.0.102] ([176.61.106.68])
        by smtp.gmail.com with ESMTPSA id eo9-20020a056402530900b00571ef2c1308sm913940edb.12.2024.04.20.16.00.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Apr 2024 16:00:29 -0700 (PDT)
Message-ID: <9f44c386-4be9-4904-bf67-f0e664773baa@linaro.org>
Date: Sun, 21 Apr 2024 00:00:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/26] media: pci: mgb4: Refactor struct resources
To: Ricardo Ribalda <ribalda@chromium.org>,
 Martin Tuma <martin.tuma@digiteqautomotive.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Hugues Fruchet <hugues.fruchet@foss.st.com>,
 Alain Volmat <alain.volmat@foss.st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Chen-Yu Tsai
 <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Sowjanya Komatineni <skomatineni@nvidia.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Hans Verkuil <hverkuil@xs4all.nl>, Sergey Kozlov <serjk@netup.ru>,
 Abylay Ospan <aospan@netup.ru>,
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
 Dmitry Osipenko <digetx@gmail.com>,
 Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
 Sylvain Petinot <sylvain.petinot@foss.st.com>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
 linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org
References: <20240419-fix-cocci-v2-0-2119e692309c@chromium.org>
 <20240419-fix-cocci-v2-1-2119e692309c@chromium.org>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20240419-fix-cocci-v2-1-2119e692309c@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/04/2024 10:47, Ricardo Ribalda wrote:
> The struct resource end field is inclusive not exclusive, this is, the
> size is (end - start) +1.

", this is," doesn't parse on my end

"i.e" => that is, would be more appropriate I think.

"The struct resource end field is inclusive not exclusive of the size" 
which I still think is a confusing statement.

Perhaps something much easier to understand is called for

"The struct resource end field signifies the end address not the 
relative offset from the start field i.e size == (end - start) + 1.

Amend the .end field to specify the end address not the relative size 
from the offset as is currently given."

Other than that, I think its reasonable to assume the mapping != 0 - 
0x100 inclusive.

Please consider updating your commit log and if you do add my

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

---
bod

