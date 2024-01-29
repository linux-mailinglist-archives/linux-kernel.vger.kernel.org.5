Return-Path: <linux-kernel+bounces-43028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A97840A66
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F139C1F2487B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844F51552EF;
	Mon, 29 Jan 2024 15:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ql5lWmSP"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E038154441;
	Mon, 29 Jan 2024 15:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706543199; cv=none; b=uVzh9Zt4zzf3gKtrujoRXZkSwMEwJXw64VFpWEJIxkY+C7QPsT/6ia71z5AODmKhcml6c35qa6MxTW4LKM7bhoEtWfp0s7BwZ4mFv8mHDRxSv7no/inaHim95sM6sCjTv0ib0EdhydgSNYUZDpm165VHFSOgwyUwIbjnHyfK3rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706543199; c=relaxed/simple;
	bh=ixehm3b3a4gEeewB46NTDjt7vk6MsfmtA5gMqeahkYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CWEmBAxJ2ScX2olEbZcKHKjNisX4hS3GucnFjf+NwEjkWsFprBYeutpCuMDoqCj2DkHpV6473Kyc2jHpYYHytVv5n4X5+0ybLTDycwI8gy4uRsq+qplKa/9layrCHEUHLovW2U+tqSDtiIWAIpBsuwLbRke87fL7SxNfRir8+aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ql5lWmSP; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3637f958e9dso1561855ab.1;
        Mon, 29 Jan 2024 07:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706543197; x=1707147997; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PTR4gc42r6P7IxG5//DXA7m+DF0lN1EzO5oHnNIEOkc=;
        b=Ql5lWmSPQBYcV3vVERAhuJmcfPGVl6NBY6Si3osMQGiUK1XByaVO8gQntnBfVZpBqT
         Z5T1OGPrPxuqCJ/9AmO0YydlOTOfySMJk6jtNwCSRZDQ2JCBwzZ1IjgzRiGn8B3Zx2iX
         hZbBDxmF1OO7HwqfEr0vu4DPo86/iRQ5JDTvcc23w//Q0++UUkKV0N+HykGCvj/l96wI
         Q44ctHVch5gdOL5WT6fRzUf5TegOPzxoSycQrF1voxeXjZLSJBDS/Ru3RZhzDPB8dAbS
         6LePasXmtFWZz0m9JToJBLY/6bmV0ZaVVmfc1PJN0FWUPBZ3YIEdjcFwfY5HNYNjhSLo
         O61A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706543197; x=1707147997;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PTR4gc42r6P7IxG5//DXA7m+DF0lN1EzO5oHnNIEOkc=;
        b=AM7rJe7ij8VcEQsapikHAKTtS0KiVEMzoCzsg8/e5FwovgBfRtED3CzgwoLT8qK8NX
         uvI15ewXz0AkCp6bNXhbhIJi2vNHKFdYncqtmmgdxu0DBS/tjH7yW+8Kf+2VgWxFlInA
         YFsz09JvPxVbRvhblC3KAc3UoZZyviUXdcaT+RZ8YKSjryr1qzE78Am70xd+y4EzSBk0
         8g2rK1etRqpW6NFhvg8MOqsl68sB8MykTh2O+y0JJhN/IVP+F+/qji6iiFLE8IVgZP4N
         7KZvvKP/xVyRD2TmA90HQViiY8O6UdzWjdiCfTNx2G625QwO/2scLHHw3/oLgzsFvVbe
         h72A==
X-Gm-Message-State: AOJu0YzTlVzZvYPuw8Lh186j2CnL4vS5wLWkML0DwBQZKWXqJcMpHwx8
	xmYOmw5WXclRD+hlJq+W7sof2bsI5SVz97vGPTlunI79w0zZ5qgZ
X-Google-Smtp-Source: AGHT+IFyMH33fG8OqyVHcL1JpzSL68arGEGxmNVpOvs6UtBvLuuamGIoZmNqkpRbkFTQWEAHlf0pLg==
X-Received: by 2002:a05:6e02:1a22:b0:363:8353:324b with SMTP id g2-20020a056e021a2200b003638353324bmr1967546ile.1.1706543197434;
        Mon, 29 Jan 2024 07:46:37 -0800 (PST)
Received: from [192.168.2.177] ([207.188.161.188])
        by smtp.gmail.com with ESMTPSA id co13-20020a0566383e0d00b00470d3ede912sm115912jab.49.2024.01.29.07.46.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 07:46:35 -0800 (PST)
Message-ID: <bf79f44f-5fa7-4341-8deb-605503d33c7c@gmail.com>
Date: Mon, 29 Jan 2024 16:46:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: media: mediatek-jpeg-encoder: change
 max iommus count
Content-Language: en-US, ca-ES, es-ES
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 tiffany.lin@mediatek.com, andrew-ct.chen@mediatek.com,
 linux-mediatek@lists.infradead.org,
 Eugen Hristev <eugen.hristev@collabora.com>, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, bin.liu@mediatek.com
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 robh+dt@kernel.org, kernel@collabora.com
References: <20240127084258.68302-1-eugen.hristev@collabora.com>
 <170652472373.127352.5854831299483160743.b4-ty@collabora.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
Autocrypt: addr=matthias.bgg@gmail.com; keydata=
 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
In-Reply-To: <170652472373.127352.5854831299483160743.b4-ty@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 29/01/2024 11:41, AngeloGioacchino Del Regno wrote:
> 
> On Sat, 27 Jan 2024 10:42:57 +0200, Eugen Hristev wrote:
>> MT8186 has 4 iommus in the list, to cope with this situation, adjust
>> the maxItems to 4 (instead of previous 2).
>> Add also minItems as 2 to keep compatibility with current devices.
>>
>>
> 
> Applied to v6.4-next/dts64, thanks!
> 
> [1/2] dt-bindings: media: mediatek-jpeg-encoder: change max iommus count
>        commit: b824b32dd5e98221cbe2e8bcccc6fb4134e35fc1

Hm, not sure why you took this one, as DT-Bindings normally go through the 
subsystem maintainer trees. Otherwise merge conflicts can occur. Just saying.

Matthias


> [2/2] arm64: dts: mediatek: mt8186: Add jpgenc node
>        commit: 4c5b46fbf52d52b0f392f0fc3913560bad438e49
> 
> Best regards,

