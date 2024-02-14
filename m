Return-Path: <linux-kernel+bounces-65469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB3E854D76
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31B531F28F1A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC185DF05;
	Wed, 14 Feb 2024 15:56:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254F35FB8A;
	Wed, 14 Feb 2024 15:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707926175; cv=none; b=KZ10i3F/MX0AfwkflYnHmn1Mmf5hnZZN0l6rLOU9Fg+pFj8V37nWZqFw3hMsNTAUBcx01KW54R/ForbApKnCb5OPzUeRa4Urjm9/3vd1G5AKrBbAAUziJ/ZQQ65JpNEGdvDGIpaqPBz3c0gdJBr4zFGFgEix34QJg/uIyOdatHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707926175; c=relaxed/simple;
	bh=8wE9VeZZ/pE3GTv1zR5T7QMkoHUzBLH+y37aO4m/9PU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sZBaKayq+1pBi8J6dUv4vgO0oD4Wvw6IB2b/XUPjw3f2cqg5W/Tsx7VUDog63l3RMZfL7A0PwxsrcIlRga/J7cGr4IW/8BwChyTBLKr2B8vT4FOc0kHxxe+gnK9iLXr0tATdL2qcxJ/8SSIyei7Taej1Yr6T8F4gznBAU4plToA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 043451FB;
	Wed, 14 Feb 2024 07:56:50 -0800 (PST)
Received: from [10.57.49.250] (unknown [10.57.49.250])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E4E003F762;
	Wed, 14 Feb 2024 07:56:06 -0800 (PST)
Message-ID: <c70df5a6-20af-4cee-b147-5847751fa36b@arm.com>
Date: Wed, 14 Feb 2024 15:56:05 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] dt-bindings: arm: qcom,coresight-tpdm: Rename
 qcom,dsb-element-size
Content-Language: en-GB
To: Rob Herring <robh@kernel.org>, Mao Jinlong <quic_jinlmao@quicinc.com>
Cc: Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@arm.com>,
 Bjorn Andersson <andersson@kernel.org>,
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
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20240213222957.GA2502642-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/02/2024 22:29, Rob Herring wrote:
> On Tue, Feb 13, 2024 at 08:05:17AM -0800, Mao Jinlong wrote:
>> Change qcom,dsb-element-size to qcom,dsb-element-bits as the unit is
>> bit.
> 
> That may be, but this is an ABI and you are stuck with it. Unless, you
> can justify why that doesn't matter. (IIRC, this is new, so maybe no
> users yet?)

This was added and support queued in v6.8. This change won't make it to 
v6.8 (given it has to go via two levels and is technically not a fix).

As James also pointed out, it doesn't matter what the name is (now that
it has been published).

Suzuki


