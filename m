Return-Path: <linux-kernel+bounces-17665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 130E18250E7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 10:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 885BF284B14
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 09:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E10124B41;
	Fri,  5 Jan 2024 09:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMDllt2i"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A7328DD1;
	Fri,  5 Jan 2024 09:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40d5d898162so10251675e9.3;
        Fri, 05 Jan 2024 01:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704447308; x=1705052108; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lJUyDVGU0XKgaKwYDjGSDxNTROvNmlr5rGkLfg67AJU=;
        b=AMDllt2iyTzlBWmQyE3NO73rVFCrt/dxy4ZZ4R7V+rAsUveRi4qBVcRd9g2Zus0Vnb
         piFNJuQWLZPAeqqPFGOs7qSTm/o9BN6H6MH1nEn/+QaKJKiAyw9bx6I2SOLvEKWZhz+e
         HPmYJRluNclOctNr6auDv1f3WSXTXV2Qs/cpPRaNxGdjLOyUYreKQCEta7PbO779bApk
         LxR2Jvh4bwX/Seg4EyS4I/15GOaVyKY5zmo5Qzv7FStux2662v+Xdhl60Jjz1LiUrO0K
         /JgU65dryqk+x0aJmLPWA0rC/ETWvpIqhoAOJmNUy5Zyo3eZI6Vb+EkUg1C5FLcMguDV
         1dmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704447308; x=1705052108;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lJUyDVGU0XKgaKwYDjGSDxNTROvNmlr5rGkLfg67AJU=;
        b=Abq8Jm3QaFbgBmMaazJla7vTmU9l5KGeyx/R91+edTmSYo7SOLosYHeujuePNmijwJ
         U7cp4CjkueMLiBOnJdQepr92SGzKyrzJINDnbhXKuis1GSj4WL45XHLSfOlEUtEaieKn
         7MzYCJv8O9024bLtx9Jo0g8Te3+OsY5cDQAi1VDakX84e2GaFRFDt12GqmQMrj5Q/P4Z
         eheHdzE/jMqxCyXdWuwjvPZUObQXAYxa6K8tMvWR9C+UPl6fLo36nlAqufEvW0184Y8n
         ecSuXwLwWqct3PjaK0FkAQTo3nGmwpS82wHaKt2AY7/qQLD9vc+Wsh9bNDtLJPqiUNGT
         44Lg==
X-Gm-Message-State: AOJu0YxTLNipcv2z64D7al0yNU02KUObWxaxtJ2q3yAoEaUyTagL3GXe
	AS1hRuSxHEnO7V063a1SSgc=
X-Google-Smtp-Source: AGHT+IGdYoX12msFQex2gQBmL00N+tTwnAfTSgVHTKvPHEqpTgUu6NAX8rJzRZKET7C6gVrEN0zBkQ==
X-Received: by 2002:a05:600c:4fcb:b0:40e:347e:b4d with SMTP id o11-20020a05600c4fcb00b0040e347e0b4dmr1100921wmq.89.1704447308037;
        Fri, 05 Jan 2024 01:35:08 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
        by smtp.gmail.com with ESMTPSA id j26-20020a05600c1c1a00b0040e3804ea71sm1002466wms.10.2024.01.05.01.35.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jan 2024 01:35:07 -0800 (PST)
Message-ID: <160df81d-e5fa-4798-96d4-5ab1809a9680@gmail.com>
Date: Fri, 5 Jan 2024 10:35:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] dma-buf: heaps: Add secure heap
Content-Language: en-US
To: Jeffrey Kardatzke <jkardatzke@google.com>, Simon Ser <contact@emersion.fr>
Cc: Pekka Paalanen <ppaalanen@gmail.com>, Joakim Bech
 <joakim.bech@linaro.org>, Yong Wu <yong.wu@mediatek.com>,
 Rob Herring <robh+dt@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 christian.koenig@amd.com, Matthias Brugger <matthias.bgg@gmail.com>,
 dri-devel@lists.freedesktop.org, John Stultz <jstultz@google.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Vijayanand Jitta <quic_vjitta@quicinc.com>,
 Nicolas Dufresne <nicolas@ndufresne.ca>, jianjiao.zeng@mediatek.com,
 linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>, linaro-mm-sig@lists.linaro.org,
 linux-mediatek@lists.infradead.org, tjmercier@google.com,
 linux-arm-kernel@lists.infradead.org,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 kuohong.wang@mediatek.com, linux-kernel@vger.kernel.org
References: <20231212024607.3681-1-yong.wu@mediatek.com>
 <DPBmATfmfvSP8Cwjz99kj_JvCEiAqRfuMFJZEBF2aIgl8NZqWFR66eyPTX1E8bHyOlimBihEE3E80p9bfOJ-0SNu8pwoIzL9gD2Xae6r97g=@emersion.fr>
 <20231213110517.6ce36aca@eldfell>
 <20231213101549.lioqfzjxcvmqxqu3@pop-os.localdomain>
 <20231213133825.0a329864@eldfell>
 <20231213132229.q3uxdhtdsxuzw3w6@pop-os.localdomain>
 <20231213161614.43e5bca8@eldfell>
 <9m8eC1j8YSwxu9Mr8vCXyzF0nfyCSHpFbfc__FtUjjKppew65jElBbUqa-nkzFTN-N_ME893w0YQRcb3r3UbIajQUP-Y5LxnHKKFoiBepSI=@emersion.fr>
 <CA+ddPcOew7Wtb1-Cakq_LPN1VwtG+4vpjpLFvXdsjBunpefT1A@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CA+ddPcOew7Wtb1-Cakq_LPN1VwtG+4vpjpLFvXdsjBunpefT1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 04.01.24 um 20:50 schrieb Jeffrey Kardatzke:
> Any feedback from maintainers on what their preference is?  I'm fine
> with 'restricted' as well, but the main reason we chose secure was
> because of its use in ARM nomenclature and this is more for ARM usage
> than x86.

Well AMD calls this "trusted", but I think that's just slightly better 
than "secure".

+1 for using "restricted" cause that seems to match the technical 
consequences.

Regards,
Christian.

>
> The main difference with similar buffers on AMD/Intel is that with
> AMD/Intel the buffers are mappable and readable by the CPU in the
> kernel. The problem is their contents are encrypted so you get junk
> back if you do that. On ARM, the buffers are completely inaccessible
> by the kernel and the memory controller prevents access to them
> completely from the kernel.
>
> There are also other use cases for this where the hypervisor is what
> is controlling access (second stage in the MMU is providing
> isolation)....and in that case I do agree that 'secure' would not be
> the right terminology for those types of buffers.   So I do agree
> something other than 'secure' is probably a better option overall.
>
>
> On Fri, Dec 22, 2023 at 1:40 AM Simon Ser <contact@emersion.fr> wrote:
>> On Wednesday, December 13th, 2023 at 15:16, Pekka Paalanen <ppaalanen@gmail.com> wrote:
>>
>>>>> It is protected/shielded/fortified from all the kernel and userspace,
>>>>> but a more familiar word to describe that is inaccessible.
>>>>> "Inaccessible buffer" per se OTOH sounds like a useless concept.
>>>>>
>>>>> It is not secure, because it does not involve security in any way. In
>>>>> fact, given it's so fragile, I'd classify it as mildly opposite of
>>>>> secure, as e.g. clients of a Wayland compositor can potentially DoS the
>>>>> compositor with it by simply sending such a dmabuf. Or DoS the whole
>>>>> system.
>>>> I hear what you are saying and DoS is a known problem and attack vector,
>>>> but regardless, we have use cases where we don't want to expose
>>>> information in the clear and where we also would like to have some
>>>> guarantees about correctness. That is where various secure elements and
>>>> more generally security is needed.
>>>>
>>>> So, it sounds like we have two things here, the first is the naming and
>>>> the meaning behind it. I'm pretty sure the people following and
>>>> contributing to this thread can agree on a name that makes sense. Would
>>>> you personally be OK with "restricted" as the name? It sounds like that.
>>> I would. I'm also just a by-stander, not a maintainer of kernel
>>> anything. I have no power to accept nor reject anything here.
>> I'd also personally be OK with "restricted", I think it's a lot better
>> than "secure".
>>
>> In general I agree with everything Pekka said.


