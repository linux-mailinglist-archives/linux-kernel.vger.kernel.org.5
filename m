Return-Path: <linux-kernel+bounces-110980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F19D98866A2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21ED21C21D75
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 06:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F351097D;
	Fri, 22 Mar 2024 06:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TlGhXMVk"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E15AC2C6
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 06:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711088086; cv=none; b=kwBEw1dDBxzVf1XHxPRwoiQ8Qmeg/Q54KJDumIcV9R0ia660LjMPJtr49MMU6SdxtWE1vBxEByfmR+Nyva2+7jdnwPp9QCjNr3+RuPUV3ksHYv1/0frFoc8MnzcjUJ4HzwYGw+XJjl59kOyIjPbAZF/eXJINMEzjxHh3v9UZSPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711088086; c=relaxed/simple;
	bh=QLdcpiP4QGQt6dEBc5+wv7kbQLy2Bj0aGCo7AjhxoW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bvkvHjU4HdqPrjMDmZ6STvoMOfFZtSbFr8cSYZxmUx4t8GrO/K9WeGRfYhfm2D/ZQCye9zrktaJJsaJ8xO82JbZgLsDs/PUgf9jjD2PsUsj8PTxG+D5qx8EA/7Cy36sGgWdEsTr0ktOjgd1FaBndcYtZcai3wPqVkB8e9WmnChE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TlGhXMVk; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a470d7f77eeso199922066b.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 23:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711088083; x=1711692883; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wQz4TAf9ZoFSpiweEBuy/+ZB61e9rJcmusB5GX6HuoQ=;
        b=TlGhXMVkCkMqAv1M0Wll0nb61m+zyeItJot/0zqSLMd6Tw63AUbjANpqnt1GXutWF5
         YNOH62zc3MSTUa9s6bJl93lSbRyEGDd/+i2cYVTnY1JK4+Rpb78QxdrtHVvpxKDoFLP+
         Uc9zD/KdyXbsXmBrnWZpSxjF9uxpKibFa49YKNQfbX1POwz0AqGqFFZo4mPBKod3G2w1
         +1zzleQQbGPI00kWIl6YCdAJtRIeAywt5agpFJRRwnb8sZ/VzkkxBwjY9i0V6yTpzbci
         EVFjqtOPCbyFcHD+pP7F1wTHeWJ/7UuCeC9F0lvjTwN3HmnoigedvzS68UJQv7bWqRCf
         5+8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711088083; x=1711692883;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQz4TAf9ZoFSpiweEBuy/+ZB61e9rJcmusB5GX6HuoQ=;
        b=DOBaXjvrqAru2YTMtvqafz4Z7gI/03Ka3RZWTw8itXCUApBk7qg1MUqjEiIq+gE2xR
         JYzbxuMre5o+iBo5bzR6sXitCpWnvmF0EaKKhiqAgatSozh/gP0RWF2U8UbFve3XM78Z
         q463yyzd0b3lEMBh5KnrUfUsULNSzM9WBDtiBp+buyayp8DUfwx5a8ZL3wjc1w+W9P9z
         w9AvyVLRKSmVt9jqc1eLL6IvfqYKPs5lQoPu2UgiWH0kAqx7NuJVbvctamCvom5IE2wX
         02KZqg0CxrQq8AwBBQyFcq3g15RBIQeuXa5CGwAf29H+nWH1wHiYMelCOnX3V0S9Tfga
         7G3w==
X-Forwarded-Encrypted: i=1; AJvYcCVyKxhBY4AZPvhOfvbuA1Fv6IWlb6uSroFzXB1GVLpSmOIzDQPLUK4K4Tyj/7jFezknasJiVmbLUaB7pq+mQ+cSOsF/uy9B60b1++qJ
X-Gm-Message-State: AOJu0YxWxpdXzpSBm6A4Ck7oiFxa4RUeFBNYcYBt7VejkLzpIabJBBjM
	f6AfkekY4M8VzFMyHtqe6QXcPkJEsDckGXtTCItXVBUjLnLlWxUpgXQFZ9gFsyA=
X-Google-Smtp-Source: AGHT+IGJ8XTCMYF6ArlCaO00VWVw5b7TAkCV/uSZ22YymABLPyq0kGJtYA/iJjcz346YbMpxcom0aA==
X-Received: by 2002:a17:906:a20c:b0:a47:1b77:7c4 with SMTP id r12-20020a170906a20c00b00a471b7707c4mr1012832ejy.48.1711088082837;
        Thu, 21 Mar 2024 23:14:42 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id s24-20020a170906169800b00a46aba003eesm649079ejd.215.2024.03.21.23.14.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 23:14:42 -0700 (PDT)
Message-ID: <93c09c90-a4d0-44d6-99cb-34bd0bcffe14@linaro.org>
Date: Fri, 22 Mar 2024 07:14:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] nfc: nci: Fix uninit-value in nci_dev_up and
 nci_ntf_packet
To: Ryosuke Yasuoka <ryasuoka@redhat.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jeremy@jcline.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syoshida@redhat.com, syzbot+7ea9413ea6749baf5574@syzkaller.appspotmail.com,
 syzbot+29b5ca705d2e0f4a44d2@syzkaller.appspotmail.com
References: <20240320005412.905060-1-ryasuoka@redhat.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240320005412.905060-1-ryasuoka@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/03/2024 01:54, Ryosuke Yasuoka wrote:
> syzbot reported the following uninit-value access issue [1][2]:
> 
> nci_rx_work() parses and processes received packet. When the payload
> length is zero, each message type handler reads uninitialized payload
> and KMSAN detects this issue. The receipt of a packet with a zero-size
> payload is considered unexpected, and therefore, such packets should be
> silently discarded.
> 
> This patch resolved this issue by checking payload size before calling
> each message type handler codes.
> 
> Fixes: 6a2968aaf50c ("NFC: basic NCI protocol implementation")
> Reported-and-tested-by: syzbot+7ea9413ea6749baf5574@syzkaller.appspotmail.com
> Reported-and-tested-by: syzbot+29b5ca705d2e0f4a44d2@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=7ea9413ea6749baf5574 [1]
> Closes: https://syzkaller.appspot.com/bug?extid=29b5ca705d2e0f4a44d2 [2]
> Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
> ---
> 
> v2
> - Fix typo in commit message
> - Remove Call Trace from commit message that syzbot reported. Make it
>   shorter than the previous version.
> - Check the payload length in earlier code path. And it can address
>   another reported syzbot bug too. [2]

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


