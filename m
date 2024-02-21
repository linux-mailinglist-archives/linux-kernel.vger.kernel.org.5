Return-Path: <linux-kernel+bounces-75036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3370285E1FD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5322C1C244F7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241B880C1F;
	Wed, 21 Feb 2024 15:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bg7bBTuj"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845958002D
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708530812; cv=none; b=f8tiW92mNImbJxcYHqLOF0va59BcuhlPDr2bu6j+ycdcmF4x19a1tQYds1gfTlc0SexOQC9M+2Ez7us1oUdAOCpjc1Zj4iEAAsxLZkwEk+m/F2n+0qk9CcoZ4o3+0DMFVBFo9L9W8GzXz5w7pN0jrfh//k+exNOYLx0FBhkUaXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708530812; c=relaxed/simple;
	bh=Ujy+9Txxe8sQf42ssMTRoWZqJhSdV44XMa2hitP/kgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W1u8aqCIEoNYRu7SdHru+dLZi1JURycWfQuMhVsbm4uYVhAvkz/ilB4HOY6T5bWFyuDABwenbykINStC2mBIEnFbfW7xuHvmot5LgmB73GHJKBMMYlibCWd/kU8f2IFbUxuJO+rMMAKb/1p4/kYJEfIk3+Ja4QrBGZ0bQm93rCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bg7bBTuj; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5645960cd56so5005387a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708530809; x=1709135609; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SwFqCk+Fw8IHxc60+45f2kIMjdWilJjXld6Waiyir1s=;
        b=bg7bBTujrTCPX7VLn9s2IT6W9esGNlLq+NwlCNFOy55i07WgsBEiN42Nxj0pHHotuX
         ZMaM2xPEkYTjAu1jhhD1wFYMSmhxDFzZdsVmrZtprre0ckEBSAA+yu7PeIvYlSOiwRw/
         AjIa6x1R5FQ3A0kJKhZyqjYRNmidos5rW+D45/QWXAmDBRGIhQm5m2EXbJ8bXASx5E8X
         wz5QE7dot72RGVEkbXEY0m4MTww7JxCZTChjyZv0jW9Qt7Etc5A/htlmIZUq/+JVXXB5
         B8pokrarsUNmMaZUVpgteXQmKW3lR8RqqbwvQyYdoqrG5+ZKOxZqrnUarrf2L+7nCJk1
         7Y4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708530809; x=1709135609;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SwFqCk+Fw8IHxc60+45f2kIMjdWilJjXld6Waiyir1s=;
        b=ht3lD5B1pVKQPWXBjLisnhgIrBCei6TfnMhyL4mZaY79sBajaDsyUWhL0kdWPF1Vm4
         IIdu1zSLjE0RjiEKY7Igjj2MzTZoVGrPnpEzkdScaBVDfVK9zmJ6Vy3jc6UyUB4qiH5v
         Qmrg9Yj/cq2a2ffWpnNBD5Khb9k4mUTwAmDaGZ5uiHrQKESr49pSj4SQ63XwOqahi6w5
         jBSw3f9CwPW71jIV0cCqF2UA/fbzQ7LUjapIf3R6yGx/i4VHmh/3yf4xMdXuvpy7xWwa
         s1zWqM0EIwO7/Mi87b0Hzhtm9xhRHURCvpzMfxdu5jjPK7fI/b+LipJVzFQJ57+Avf5J
         Rctg==
X-Forwarded-Encrypted: i=1; AJvYcCX/ndaNgshqv2m9WcwuR1MjMs0O2YjG+W15VwNd8hRi/uHPNukoQ0g2TXyW6qInVpvtLXdF4EUZa8ARK34/fG2IXoBGZTrjAtsN5+HO
X-Gm-Message-State: AOJu0Yxr3XTRwZ17CceQNK7kLGyN0yf/ZPWXjwloTilnwygt4XMIEy+G
	vZdisHmiz6rtRGEeIL326J92ggw0o7ZtLIplwEv94AjcyT1hKlhh7OX2MO4Jh8g=
X-Google-Smtp-Source: AGHT+IE8mUKZrEG3MftX6NxLVmqzQ1XBfHTLJoxxAsSXcxV76UItSSMKfchF6hvnTa77i/hh/nxfPg==
X-Received: by 2002:a17:906:b0d9:b0:a3d:2e0e:3f52 with SMTP id bk25-20020a170906b0d900b00a3d2e0e3f52mr13906383ejb.37.1708530808790;
        Wed, 21 Feb 2024 07:53:28 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id y14-20020a170906448e00b00a379ef08ecbsm5062578ejo.74.2024.02.21.07.53.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 07:53:28 -0800 (PST)
Message-ID: <8ad96253-2053-4dc1-8dc1-d01d1fa36877@linaro.org>
Date: Wed, 21 Feb 2024 16:53:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: defconfig: Enable zram, xfs and loading
 compressed FW support
Content-Language: en-US
To: Maxime Ripard <mripard@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 linux-kernel@vger.kernel.org, Enric Balletbo i Serra <eballetbo@redhat.com>,
 Erico Nunes <nunes.erico@gmail.com>, Brian Masney <bmasney@redhat.com>,
 Bjorn Andersson <quic_bjorande@quicinc.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org
References: <20240221141350.3740488-1-javierm@redhat.com>
 <1f28256c-e436-4add-aa67-2cfb2248b220@linaro.org>
 <6scz7iti3tzzrd4ph3gnuc2pvkcbtuuicgfgujh3pa3c34kdkt@bhfa4xbxeu7t>
 <cb8bf006-57df-494e-80f3-947582ec71f1@linaro.org>
 <fy3wffb2jwv4veo3golfn5olri77clxywbuwuokese7sbobixd@mird5k66cl2w>
 <56625c21-1b34-479b-b5b2-4c4d8b7a11b3@app.fastmail.com>
 <724jnhrbs6r4q6whynr3aon5w7mhfvetlgcnts4nukvtxbuium@mrjv6apjqk7r>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <724jnhrbs6r4q6whynr3aon5w7mhfvetlgcnts4nukvtxbuium@mrjv6apjqk7r>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/02/2024 16:51, Maxime Ripard wrote:
>>> Sure, but you're not just arguing for XFS there.
>>>
>>> What I really don't get is this: this makes the life of people easier.
>>>
>>> Being able to test an upstream kernel quickly when you have a bug in a
>>> downstream distro is super valuable for any distro developper. And on
>>> the long run, if we don't make the switch from a kernel distro to a
>>> mainline kernel relatively easy, we're the ones that will lose out.
>>> Because people just won't bother, or be frustrated and thus super
>>> reluctant to do that work.
>>
>> We had previously discussed adding config fragments for common
>> distros the way we have kvm_guest.config, but if the Javier's
>> patch is all that is actually needed for Fedora, that seems better
>> to me than the added complexity of fragments.
> 
> Oh, right. Fragments would be a great tool to reconcile the need for
> minimal boot time and supporting reasonable use-cases.
> 
> I guess it's even more of a struggle with the single arm64 defconfig vs
> the minimal vs batteries included defconfig setup we had for arm.

It would be cool to group also all the per-SoC needs in dedicated
fragments...

Best regards,
Krzysztof


