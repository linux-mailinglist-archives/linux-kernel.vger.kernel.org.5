Return-Path: <linux-kernel+bounces-18316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FF1825B71
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 21:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8718D1C238CC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 20:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D033360A0;
	Fri,  5 Jan 2024 20:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKq2+axj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F343635F0E;
	Fri,  5 Jan 2024 20:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40d5336986cso21630335e9.1;
        Fri, 05 Jan 2024 12:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704485674; x=1705090474; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H5v4lJQ5FBDH9m0m4us0aR2gRwVokV9Ch1chBRNOEtk=;
        b=UKq2+axjFBtD1DSjVqVbHlMCgZ7zdQMKV/XmZHPqhTVL4P3YeEQMkEvcDVMB9DXcr6
         n4Z32Kb0SpBLZ8xpwOpuYWJ1oy3RWEsgkNpbdYjOc4qUu1Bq4sgSH5SG2WHis4LvoiL0
         aT9EC1VKrIzMw+Hsl1BeYjqYRGmKHhXuGgCVAh18fRn30bljEsNzjo9wwqMU5tfw68ix
         n44vpC30hlf4Z57hA2CCx2xsDvpulYaP16i4UIK7MFj9YoT2tXx26s0MRMU+pfkyfC2v
         kkDNvyhxzMlMGPUWg0xgYwOhzyNpse6/jHCcj1BkjDNbTH2Heqx5m9XPPCn/pz8jYH6g
         Ssew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704485674; x=1705090474;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H5v4lJQ5FBDH9m0m4us0aR2gRwVokV9Ch1chBRNOEtk=;
        b=BVSnH6Qvkv9z7DIwoEy5Ve2M9as68/5l2b/N4E9DLdEcwwgscfcp3wU95yzDIsQmqg
         gqQS8WCQ3Qu9fp4xrGad/ARfebsw5QZhZOHP1UXkHWVz9tfFDDIwDpHUXcOHMENQqa3i
         AhsFi8lzyLTVKaPh8o+z8XgWwrE1Y+KgvKQyK5AyQGdnUUui6W4vmsmfICNnh0sBycEm
         1xx33kolP1WSRrZWfJGGre76RoCH3h2oXMJYhc8fa7/8Xj96l24ZuZtyxxOOIZa/z37v
         F2ZQSeifLTkdQRQpnA9H3BPMOCEXNpombe6Hr8FtUpa3G04mI+BE5IEpfKZy7/T7eCjy
         8rfw==
X-Gm-Message-State: AOJu0YwDVsp0Irt/ozKqdbWLg3J6nf0Rk9trYI7ZgdAltsckxK8jG2Te
	VHwi1kr/qDMTfhUrwN3/8BE=
X-Google-Smtp-Source: AGHT+IFze9sCHhyNc+zVvhduYpNez49M+qfUp0nS1bBjaYDBY+nfbVYc0kUsXXE5eZyWK9FZdIoybg==
X-Received: by 2002:a05:600c:2284:b0:40e:3524:4a53 with SMTP id 4-20020a05600c228400b0040e35244a53mr28919wmf.76.1704485673912;
        Fri, 05 Jan 2024 12:14:33 -0800 (PST)
Received: from [192.168.0.3] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id h12-20020a05600c314c00b0040d5ac00dc6sm2554821wmo.8.2024.01.05.12.14.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jan 2024 12:14:33 -0800 (PST)
Message-ID: <d639824c-74e2-45f4-bd8a-7e20fad8d61b@gmail.com>
Date: Fri, 5 Jan 2024 22:14:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] support ipq5332 platform
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jie Luo <quic_luoj@quicinc.com>, agross@kernel.org, andersson@kernel.org,
 konrad.dybcio@linaro.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 hkallweit1@gmail.com, linux@armlinux.org.uk, robert.marko@sartura.hr,
 linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 quic_srichara@quicinc.com
References: <20231225084424.30986-1-quic_luoj@quicinc.com>
 <a6a50fb6-871f-424c-a146-12b2628b8b64@gmail.com>
 <cfb04c82-3cc3-49f6-9a8a-1f6d1a22df40@quicinc.com>
 <dd05a599-247a-4516-8ad3-7550ceea99f7@gmail.com>
 <8ef607b9-1fc6-485b-a6fb-a8d468cc1954@lunn.ch>
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <8ef607b9-1fc6-485b-a6fb-a8d468cc1954@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

On 05.01.2024 15:52, Andrew Lunn wrote:
> On Fri, Jan 05, 2024 at 04:48:31AM +0200, Sergey Ryazanov wrote:
>> Hi Luo,
>>
>> thank you for explaining the case in such details. I also have checked the
>> related DTSs in the Linaro repository to be more familiar with the I/O mem
>> layout. Specifically I checked these two, hope they are relevant to the
>> discussion:
>> https://git.codelinaro.org/clo/qsdk/oss/kernel/linux-ipq-5.4/-/blob/NHSS.QSDK.12.4.r3/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>> https://git.codelinaro.org/clo/qsdk/oss/kernel/linux-ipq-5.4/-/blob/NHSS.QSDK.12.4.r3/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>>
>> Please find my comments below.
> 
> Hi Sergey
> 
> There is a second thread going on, focused around the quad PHY. See:
> 
> https://lore.kernel.org/netdev/60b9081c-76fa-4122-b7ae-5c3dcf7229f9@lunn.ch/

Yeah. I had read your discussion yesterday before coming back to this 
clock discussion. It is a monster chip and looks like you have a hard 
time figuring out how it works and looking for a good code/DT model.

> Since it is very hard to get consistent information out of Luo, he has
> annoyed nearly all the PHY maintainers and all the DT maintainers, i'm
> going back to baby steps, focusing on just the quad pure PHY, and
> trying to get that understood and correctly described in DT.
> 
> However, does Linaro have any interest in just taking over this work,
> or mentoring Luo?

I should clarify here a bit. I found this discussion while looking for a 
way to port one open source firmware to my router based on previous IPQ 
generation. And since I am a bit familiar with this chip family, I chose 
to put my 2c to make implementation discussion more structured. Long 
story short, I have no idea about Linaro's plans :)

If I am allowed to speak, the chosen baby steps approach to focus on 
pure PHY seems to be the only sane method in that case. Considering 
Alex's promise, we can assume that the next release will support this PHY.

--
Sergey

