Return-Path: <linux-kernel+bounces-93418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3665872F7B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F29AB256FE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 07:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A016E5C90E;
	Wed,  6 Mar 2024 07:20:34 +0000 (UTC)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B655A783;
	Wed,  6 Mar 2024 07:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709709634; cv=none; b=lIvyE9L1v3sGEG01jEUIkovU3abpKl26QxT9iQRV29pgvrObFY+m8EsCakgOpbS/BFEIGwBsfjHcQGKHYuYs6qG4gnQRbkZXEq+yR6aoKP/p3gYrJojvjEYLtjbeid/Ji4vSScCoJ2JQIV6JR0D7ohrdkicg+lawBq6cArIs1kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709709634; c=relaxed/simple;
	bh=HAP+iMl7BUZdNXqZwAThepZm1K7kacwAMmWl+dtV+7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dr5sTfvs6kkXbT+yUJyUZwlJTE1eOSAxNO8HWsecpgCskxj63DQeboPqqoqG06QpkR7CZCETLk7CRfmr8EYlvGtpJMyz6iDMP9mmnLQlXEyUzQt5yeaWvAJCjv584bvOBduG9Kzc3PtpF4WVe66RT0ynhkcK69qS9Ax5sXRoMSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp70t1709709583ts91r9nd
X-QQ-Originating-IP: p4pVVYXG8UKSO1Htum6vp1WgSp9sIHOFpaemxhXGfzU=
Received: from [127.0.0.1] ( [223.112.234.130])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 06 Mar 2024 15:19:41 +0800 (CST)
X-QQ-SSF: 00400000000000B0B000000A0000000
X-QQ-FEAT: qO3Ke1AXI6F1dreDptSiRTmiAnB+l5LDO3YcMSKeHKiRL1DlwaBEDMxG6Oqwi
	E+QOlXgMrpjFt7CF1WJgX4smAQKP4Lm/8fCCiJe8WBRgzfMXgNYv9G0qsCLQwpuLg/15HjU
	lI3At+WRKGuNTG2C7dRGAC0XmmV+oWCPvvEhRKcYYbuCaKx4HDzpwRKc3M3hgfXwJFi8gUq
	d7kPmoFyOb7dwXCwyA+ig3KAkO7UaWkr+y9CRDb+/oh0SzpeneZSuJjG5XTKEmpIds2Oln9
	CtZaHOrL4jdgGksSNRFSMcMKARZzTQBCsJ/9gpl0NAln32OAMPrrGQT7diwTiKL13ja9pax
	6wxzhhsZXxNGG8ZnWoeUYGp0lJmXdifa11/kExoD0ZVbbjoNJNM7z74102Fo41xznjimtSz
	Bx9OCSbW9+QimKa4YKbxHg==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 16879831237417784052
Message-ID: <CB998A5566DC04D2+c2e15da5-9b6b-40fc-8651-7b3a631b0e45@shingroup.cn>
Date: Wed, 6 Mar 2024 15:19:40 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] dt-bindings: Add HEXIN Technologies Co., Ltd.
 vendor prefix
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: shenghui.qu@shingroup.cn, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
References: <cover.1709694173.git.jialong.yang@shingroup.cn>
 <f674ec19ce824dfc13258396931256c3d33cd207.1709694173.git.jialong.yang@shingroup.cn>
 <74debf9c-d83a-4e97-93c3-3a1322f1b5fe@linaro.org>
From: =?UTF-8?B?WWFuZyBKaWFsb25nIOadqOS9s+m+mQ==?= <jialong.yang@shingroup.cn>
In-Reply-To: <74debf9c-d83a-4e97-93c3-3a1322f1b5fe@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz6a-1



在 2024/3/6 15:10, Krzysztof Kozlowski 写道:
> On 06/03/2024 07:16, JiaLong.Yang wrote:
>> Update file vendor-prefixes.yaml to include hexin as a vendor prefix
>> for "HEXIN Technologies Co., Ltd.".
>>
>> Signed-off-by: JiaLong.Yang <jialong.yang@shingroup.cn>
>> ---
>> v1 --> v2: Not changes this file and give warning.
>> v2 --> v3: Add this patch to fix the warning.
>>
>>   Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
>> index 1a0dc04f1db4..3a82104ac8a7 100644
>> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
>> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
>> @@ -619,6 +619,8 @@ patternProperties:
>>       description: HwaCom Systems Inc.
>>     "^hxt,.*":
>>       description: HXT Semiconductor
>> +  "^hexin,.*":
> 
> Please fix order of entries.

OK. Thanks.

> 
> Best regards,
> Krzysztof
> 
> 


