Return-Path: <linux-kernel+bounces-3515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7117816D39
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B121B23A03
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849161C6AF;
	Mon, 18 Dec 2023 11:56:24 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3955322324;
	Mon, 18 Dec 2023 11:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C06511FB;
	Mon, 18 Dec 2023 03:57:05 -0800 (PST)
Received: from [10.57.46.32] (unknown [10.57.46.32])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B349C3F64C;
	Mon, 18 Dec 2023 03:56:18 -0800 (PST)
Message-ID: <ca624e71-c487-4004-abc4-126442b92f33@arm.com>
Date: Mon, 18 Dec 2023 11:56:17 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/8] dt-bindings: arm: Add support for TPDM CMB MSR
 register
Content-Language: en-GB
To: Tingwei Zhang <quic_tingweiz@quicinc.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Tao Zhang <quic_taozha@quicinc.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Konrad Dybcio <konradybcio@gmail.com>, Mike Leach <mike.leach@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Jinlong Mao <quic_jinlmao@quicinc.com>, Leo Yan <leo.yan@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Yuanfang Zhang <quic_yuanfang@quicinc.com>,
 Trilok Soni <quic_tsoni@quicinc.com>, Song Chai <quic_songchai@quicinc.com>,
 linux-arm-msm@vger.kernel.org, andersson@kernel.org
References: <1700533494-19276-1-git-send-email-quic_taozha@quicinc.com>
 <1700533494-19276-8-git-send-email-quic_taozha@quicinc.com>
 <e5fbbfab-02bf-4eda-8353-87c54c307af1@linaro.org>
 <1d57590d-2ecf-4bf6-9c8f-2a9d1ba08aaa@arm.com>
 <caa424d3-7af0-43e6-8e13-e87cde0c4f67@quicinc.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <caa424d3-7af0-43e6-8e13-e87cde0c4f67@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Tingwei Zhang

On 18/12/2023 11:23, Tingwei Zhang wrote:
> On 12/18/2023 6:47 PM, Suzuki K Poulose wrote:
>> Tao Zhang,
>>
>> On 21/11/2023 07:24, Krzysztof Kozlowski wrote:
>>> On 21/11/2023 03:24, Tao Zhang wrote:
>>>> Add property "qcom,cmb_msr_num" to support CMB MSR(mux select register)
>>>> for TPDM. It specifies the number of CMB MSR registers supported by
>>>> the TDPM.
>>>>
>>>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>>>> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
>>>> ---
>>>
>>> I prefer not to take any new Qualcomm Coresight bindings or Qualcomm SoC
>>> DTS nodes with Coresight till we fix all existing warnings. I don't know
>>> how to fix them, so I need help with them. No such fixing happened so
>>> far from Qcom, so pushback is my only way to get any attention.
>>>
>>> I already commented on this in other email thread.
>>
>> Are you addressing this ?
> The DT warning is fixed in 
> https://lore.kernel.org/linux-arm-msm/20231210072633.4243-1-quic_jinlmao@quicinc.com/.
> It's applied to linux-arm-msm yesterday.

How are you supporting remote-etm ? We haven't merged the support for it 
in drivers ? We haven't even reviewed the remote-etm support patches ? 
Why weren't the coresight maintainers Cc ed on the "new" binding support ?

Suzuki



>>
>> Suzuki
>>
>>>
>>> Best regards,
>>> Krzysztof
>>>
>>
> 


