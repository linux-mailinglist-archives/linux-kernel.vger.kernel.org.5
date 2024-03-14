Return-Path: <linux-kernel+bounces-103104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC6C87BB14
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C15D41C20B51
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206796E616;
	Thu, 14 Mar 2024 10:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XxJMxkdJ"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B24E6CDD6
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 10:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710411312; cv=none; b=qjEVwTUou8iu7qTeU0i1bJTR0gEbKOSnPqHnec/Om00wHsPa/5+GTxR4Rt4ljQsicru+YEcrDICS6Wou+INP/eZkJsWWZlafs/g8wWPks/1L+C1aUM92dGK/qWN/PaxtWi7DMe4DbiG4km/QlIPQc6w40O6YUowckWLk9/ZvPu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710411312; c=relaxed/simple;
	bh=e2hMg1PcRj/if0h8E4gfrvv9mpOExDFnx1LdFeRRap4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WPO0do2OJltYCQyjQa+tnOgVPhTzTN/Ltyd9AEQoD4nh/D20S4bAwHQU14Lq1C8oGcOoEtmc3VmqJaCu9Hbwz6Jo58Zwij+rbFwk5HwYpZkB3vAOvO5hkEgL5/emBLRnV6Z08paLheUO+R1MdRQH8RbmfVSDwG7eCqymFj/i5y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XxJMxkdJ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-413f7a5bf11so1237835e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 03:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710411309; x=1711016109; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t7/LwgM4aaqGh3YYtB4JlSHRqD8NOvEpoMUFC+HxinQ=;
        b=XxJMxkdJO+ETZyPhe3Ap/2ajIN20IHA3xaJML8EsuZ1Ryn71+NFssXacDs3vabp060
         5sYIJODoFuAVQkZ+y5UF7SxJW5fJJ8o9s3V4IR2WvwUVaJiDCSVPOcy5N+OX3pUasRHK
         jxiBotOaJF4qZmGCFmPnFo8SB7ctGSMdNihS2xxo9Vk5sAtxDQQ+1CrFRG5H982j7Ur/
         FJxVDfpubL3G6Frl1SJDU0QACHLnAdApIzwpHkKlqzmLHMPcOw8aYuAAOvzoPZ5vAfOo
         9h2m5TohnezhCwcjXu1BQltEGJLsQMmnPRknJ3lv0/FKaG1gWAYKtGSKl2SHa4ceWXZ0
         hAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710411309; x=1711016109;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t7/LwgM4aaqGh3YYtB4JlSHRqD8NOvEpoMUFC+HxinQ=;
        b=bIP12ZRqLjkoiXUGrxICTOwnsq9g9PBVgzQ65N456MR1MvljxiytkrDtSK95YsdZ/e
         m16iwzYalCJeSaunL6lQ9No9WXwcNZQmBXKMoCsnHFVCFL3WBcabmK+dNtJjHwq0jt3B
         7VbzRrKquxOqomyDjT4XNupTLXrdhhsn5F3zBoTP3SBb3idOaMc24Jb/nwe3kfVEuXIV
         Gz5KgWKFyBz1j7zBOW/BtQBs2zmR/62P0bYqqqDLBfKGKIgnY2U45Uw/ZQMP5HUTMvdt
         mZbY1lrR4qnsy6cEz1EoXEDfcjMJxNo6K6hg3/tTlVqewsUf/y+Crle4dxy/ztNtQwb4
         57Xg==
X-Forwarded-Encrypted: i=1; AJvYcCWRZajhMTAB5djETxfbop8gWNbf9G84Iju1zlaedSWuOhZM/IBhKSZj71HuwD+YJDzhgxPQJ8Sr1csXo870xTw9kn0RzwqPD9/7i0Wz
X-Gm-Message-State: AOJu0YyiWpBY2kTx/P6Pk6aCv27YvTB6jTRSO2zRuKs9TGsuU4a8T25H
	cVVIZFhKDD0t4J18rgtD7fHgLHNPlhJUKSxT2F5jGVG7zj2vGxLwqirFk50tySs=
X-Google-Smtp-Source: AGHT+IHbnSE7BF/cQ8UyDL4Hwsh1EghhNT1fgPx1aFHv6UbhkU0VaZDv4SBIaB18nPd1qiqduYvMXA==
X-Received: by 2002:a05:600c:1c89:b0:413:1047:362f with SMTP id k9-20020a05600c1c8900b004131047362fmr1191898wms.30.1710411308990;
        Thu, 14 Mar 2024 03:15:08 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id bi17-20020a05600c3d9100b00413f50e944fsm891595wmb.45.2024.03.14.03.15.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 03:15:07 -0700 (PDT)
Message-ID: <c6a97c53-3220-413d-bc48-f23119c86ce3@linaro.org>
Date: Thu, 14 Mar 2024 11:15:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: clock: qcom: Update SM8150 videocc
 bindings
Content-Language: en-US
To: "Satya Priya Kakitapalli (Temp)" <quic_skakitap@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Cc: Ajit Pandey <quic_ajipan@quicinc.com>,
 Imran Shaik <quic_imrashai@quicinc.com>, Taniya Das <quic_tdas@quicinc.com>,
 Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org
References: <20240313-videocc-sm8150-dt-node-v1-0-ae8ec3c822c2@quicinc.com>
 <20240313-videocc-sm8150-dt-node-v1-1-ae8ec3c822c2@quicinc.com>
 <e8037775-78cf-4d18-9f8b-9dc5f497ad14@linaro.org>
 <a69f6dda-f488-a1be-803d-258fb8c6cb7b@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <a69f6dda-f488-a1be-803d-258fb8c6cb7b@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/03/2024 10:13, Satya Priya Kakitapalli (Temp) wrote:
> 
> On 3/13/2024 10:21 PM, Krzysztof Kozlowski wrote:
>> On 13/03/2024 12:08, Satya Priya Kakitapalli wrote:
>>> Update the videocc device tree bindings for sm8150 to align with the
>>> latest convention.
>> Everything is an update. Please explain what you did and why. The "why"
>> part you tried to cover but I just don't understand what is "align with
>> the latest convention". What convention?
> 
> 
> As per the recent upstream discussions, it is recommended to use 
> index-based lookup instead of using clock names. The current bindings is 
> not aligned with this, hence updating. I'll add the details to commit text.

Yes, please.

> 
> 
>>> Fixes: 35d26e9292e2 ("dt-bindings: clock: Add YAML schemas for the QCOM VIDEOCC clock bindings")
>> What is the bug being fixed here?
> 
> 
> There are 2 clocks required for this, AHB and XO. Only one clock is 
> mentioned in the bindings for SM8150, this is one of the reasons to move 
> to latest sm8450 bindings apart from clock names. Hence added a Fixes tag.

This should be in the commit msg.


Best regards,
Krzysztof


