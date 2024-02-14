Return-Path: <linux-kernel+bounces-64985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5BD854636
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C9DF1C203A2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71299171BC;
	Wed, 14 Feb 2024 09:36:17 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47058171A8;
	Wed, 14 Feb 2024 09:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903377; cv=none; b=p/tmF+whNaZ+K6VJ93Gp75eeEI8Fe6xYxthshDfZ0oxmvuxXAYTY04eWs2RWGxw7/Jh7A56wpv210VwjsOnJBEEQr6wYAxSHDKdF8Aqu86mF3xXYlPK3wC6iwwweg18aSPENUrrjYhwS9yxqlhF+H38qLyfkBwWZ6zOqxcf60aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903377; c=relaxed/simple;
	bh=5kLoz2/KdhnPXN8zihUJoO8TpE72NNonn4kqQWWIPzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MAjeUHOSUYNvYNZuk68RGPih6MijVCg0kZuQSltxQkOyFrO8KKS0pkYAxzmGXi1NLDGOe0z0kcQW4+Z2PsO0IN05wj1rUxO4ocZeVIRNh+RnHeR4xKjksdzDiYx5CUZYRJVd9q14Ha8TXsJByh8KEJF4SUTTaUKXQzoMUauT3ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B92B31FB;
	Wed, 14 Feb 2024 01:36:54 -0800 (PST)
Received: from [192.168.1.100] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A55553F766;
	Wed, 14 Feb 2024 01:36:11 -0800 (PST)
Message-ID: <df3162c0-4b29-77a2-20b5-b36637fb11cf@arm.com>
Date: Wed, 14 Feb 2024 09:36:10 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 1/2] dt-bindings: arm: qcom,coresight-tpdm: Rename
 qcom,dsb-element-size
Content-Language: en-US
To: Jinlong Mao <quic_jinlmao@quicinc.com>, Rob Herring <robh@kernel.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
 Mike Leach <mike.leach@linaro.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Tao Zhang <quic_taozha@quicinc.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240213160521.15925-1-quic_jinlmao@quicinc.com>
 <20240213160521.15925-2-quic_jinlmao@quicinc.com>
 <20240213222957.GA2502642-robh@kernel.org>
 <a062ce8d-638a-4a33-8afa-45ad47efcd72@quicinc.com>
From: James Clark <james.clark@arm.com>
In-Reply-To: <a062ce8d-638a-4a33-8afa-45ad47efcd72@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 14/02/2024 01:43, Jinlong Mao wrote:
> 
> On 2/14/2024 6:29 AM, Rob Herring wrote:
>> On Tue, Feb 13, 2024 at 08:05:17AM -0800, Mao Jinlong wrote:
>>> Change qcom,dsb-element-size to qcom,dsb-element-bits as the unit is
>>> bit.
>> That may be, but this is an ABI and you are stuck with it. Unless, you
>> can justify why that doesn't matter. (IIRC, this is new, so maybe no
>> users yet?)
> 
> Hi Rob,
> 
> Because for CMB type, it uses qcom,cmb-element-bits. So I change the
> format to be the same as
> CMB.
> 
> Thanks
> Jinlong Mao
> 

I think what Rob was trying to say was that in the interest of not
breaking existing DTs it's best to leave the existing names as they are,
even if they aren't technically correct. And to only add new parameters
with the -bits suffix, even if it's inconsistent with what's already there.


