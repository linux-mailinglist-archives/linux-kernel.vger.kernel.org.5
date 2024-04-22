Return-Path: <linux-kernel+bounces-152906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D81E8AC5F8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E976F1F21415
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94EB42233A;
	Mon, 22 Apr 2024 07:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u4qienJu"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9F94E1A2
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 07:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713772247; cv=none; b=mboFF9iPxRO9wUwlBqaMNgCG4qwDHn7OZiA42dbnZw9HoEcY9r06AqHQO/PT3vj9sPZPuwfq+5pXllD7XGUq3yX/oIqQ/FKHPU+s2xf1tD1ofZ8NoXNgU31E5bsz6LJ0DGpsAoxHsQiTGxOWiZBmbuWdC7eYkSV9FL6pSYDrN84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713772247; c=relaxed/simple;
	bh=ll7xpI05vG+OSYFaHbFKnPZj/8mZGc85w/FkFElFwjw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FJ/LFrnMEcav0lcQEyLL/1EBki8p+48EYsgTTo3nsNp24U6j1CHZtnIvLhQgCFffnqik3q9dXJgen0oFweP99snO1jJZKa0T2613QYwwyeFAvPUQshG8v1CGPqRWZad1/bjnsxGkYiKV6DYCHOXUmis61nymoDcphQoImU0n/sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u4qienJu; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2da08b06e0dso47989121fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 00:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713772244; x=1714377044; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v+71MZ9wrQ9ox9rnQ8IGeE2LhRSl4xdE1GR9dh+ng9Q=;
        b=u4qienJuFWayQfLR+rXFP6p7HKtoJTr8WkYR/bQUXqjGVswXq0fxL/J6dApyV2JPy+
         PsfIoeN0jHr7SJwMIkF9lHmx51qcoN+M70bN++5wBZxsIzOkyJIfv0wZmRovB3QDjRWF
         WN+0KnGGrP8q26gDNPUgtCqE/gphN94UqKiPEbThOwEpqDFMVZa6NHW1gzTEkA0O7Nc7
         +vNY89qLqYguk0BsODeQ1kN85Il2+/eTy8uXoAz9ofysJoZ5IIFR3xrmPE69OqReHmUI
         DlGWfnYPaPMdKuClbum+JPsAIK5/jdM8xaSgg4MFo+kHE/FudHivDY/0CEzgOyJEf+Ip
         xqKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713772244; x=1714377044;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v+71MZ9wrQ9ox9rnQ8IGeE2LhRSl4xdE1GR9dh+ng9Q=;
        b=hAQLnwkym/xHUiK549DS9HHHFTM8I7uStlTfitYXyPBatYnVCy8uumvkzxQBvc5fUy
         z4TE47q/+Hkt4fw5SkC1SYaE62fI3zAevlDLY5C3CCnXJdTdqKww5HCgdiOhGlFARofL
         su5uvrW809eQNScYP3wF2ifYjgjsffGTLpBw5p6Ff17D4uUAXkrK7DSjz7EfpnJuNLuz
         TB+QChK/NAMgku8SrEZXycLzxROVCoPxosBFrLm/xiQ9KZsvjounF3AQKHBZMx66NMUD
         32eQ6nC49L49JTEgf4ZQ2irbaSMvU+M0QZHm5IOnXjQR7Wpv3CCCtDoRjk2MOisL1fgI
         AtaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWtWPcIFx4zlBZNhGvsubnhHNxEns8/OTe3uKfRKbkFYGboAFtzmnZz8X4Umfq8gs7/obvq1vgNin2jj27N6aEDgs78NqsPO8WEL28
X-Gm-Message-State: AOJu0YzPI/kv7lgpqumkle+HBmkqujhOcxWE6K8obp3i3+fL9JXIGfOZ
	FirHqSGRlhubODM4IM5CxVTkkacVMO8qT0rIC5nqnwV7oSFdVW82iPxtuxhspzU=
X-Google-Smtp-Source: AGHT+IEO+hs7djOE8BhqvbO1jw9iehaX2qdysNQjBTx57bMY99Rnnu0XpYuWpXJnIxcp1ufaEMbYgQ==
X-Received: by 2002:a2e:380b:0:b0:2d8:68fb:399b with SMTP id f11-20020a2e380b000000b002d868fb399bmr5464268lja.7.1713772244119;
        Mon, 22 Apr 2024 00:50:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:e5e5:892f:e81f:7cad? ([2a01:e0a:982:cbb0:e5e5:892f:e81f:7cad])
        by smtp.gmail.com with ESMTPSA id ay39-20020a05600c1e2700b0041a7a923502sm982614wmb.3.2024.04.22.00.50.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 00:50:43 -0700 (PDT)
Message-ID: <a27572a5-2f1c-46ff-8528-4cae17c8e5e9@linaro.org>
Date: Mon, 22 Apr 2024 09:50:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 00/15] tty: serial: switch from circ_buf to kfifo
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org, Al Cooper <alcooperx@gmail.com>,
 Alexander Shiyan <shc_work@mail.ru>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Baruch Siach
 <baruch@tkos.co.il>, Bjorn Andersson <andersson@kernel.org>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 "David S. Miller" <davem@davemloft.net>, Fabio Estevam <festevam@gmail.com>,
 Hammer Hsieh <hammerh0314@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Chunyan Zhang <zhang.lyra@gmail.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Kevin Hilman <khilman@baylibre.com>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
 Laxman Dewangan <ldewangan@nvidia.com>,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 "Maciej W. Rozycki" <macro@orcam.me.uk>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Michal Simek <michal.simek@amd.com>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Nicholas Piggin <npiggin@gmail.com>, Orson Zhai <orsonzhai@gmail.com>,
 =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Peter Korsgaard <jacmet@sunsite.dk>,
 Richard Genoud <richard.genoud@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Sascha Hauer <s.hauer@pengutronix.de>,
 Shawn Guo <shawnguo@kernel.org>, Stefani Seibold <stefani@seibold.net>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Taichi Sugaya <sugaya.taichi@socionext.com>,
 Takao Orito <orito.takao@socionext.com>,
 Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>,
 Thierry Reding <thierry.reding@gmail.com>, Timur Tabi <timur@kernel.org>,
 Vineet Gupta <vgupta@kernel.org>
References: <20240405060826.2521-1-jirislaby@kernel.org>
 <daf06969-15fd-470e-88b8-a717066fe312@linaro.org>
 <2024042030-gumdrop-outdoors-fc81@gregkh>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <2024042030-gumdrop-outdoors-fc81@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Greg,

On 20/04/2024 07:42, Greg KH wrote:
> On Fri, Apr 19, 2024 at 05:12:28PM +0200, Neil Armstrong wrote:
>> This patchset has at least broken all Amlogic and Qualcomm boards so
>> far, only part of them were fixed in next- but this serie has been
>> merged in v1 with no serious testing and should've been dropped
>> immediately when the first regressions were reported.
> 
> What is not yet fixed with the recent patch that was just sent to the
> list?
> 
> Doing core changes like this is hard, I have seen no lack of willingness
> to fix reported problems or major breakages that would deserve a revert.

It broken all Amlogic and Qualcomm boards, are we sure it didn't break other systems that are not CI tested on -next ?

This serie clearly deserved a v2, patch 11 wasn't seriously reviewed, and it deserved a ping on the RFT before sending a v1.

I don't understand why speeding up this changeset and applying it without any reviews nor tests was so important.

Thanks,
Neil
> 
> greg k-h


