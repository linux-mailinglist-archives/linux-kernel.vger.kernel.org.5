Return-Path: <linux-kernel+bounces-158885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC658B2641
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57D241F2422D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C805514D2B4;
	Thu, 25 Apr 2024 16:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJ/V4Z0o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097772D60A;
	Thu, 25 Apr 2024 16:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714062105; cv=none; b=mqfQLSfrmwt9j5YrsolTHu+eMuOA5RNrWDRmGJ0Z4MvNoPzaMFjYIflUymxDoh7RwAJ0k9zblTKuFYsUAyAKB/D/fM5a1hCAwzuvNKiLaDofWoqXoDDcRDKTFJqxt0IDroaPz1QODC2Y+ZWd19SGRznxIqz8d68vyflDr9UhVVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714062105; c=relaxed/simple;
	bh=eNhCNG+DMjObqRB26BLTw1alILboFKx0y4neqkl4G7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JTotyydE2E7rJxT0WbAvzD/1SArmHd+nAcpGPvmgDJwovYI6kgj3ZSn17hiP1rze71y9rp3aqVNaD910FpcEoIAsrpMpJl8SFbgEtKtwcVTPFY0wylHtsxptukhiboYCG6Z1QJIiaQ26Z8KJXGACGKjjsgkia28TxBEIyG8HhcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJ/V4Z0o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E2EC113CC;
	Thu, 25 Apr 2024 16:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714062104;
	bh=eNhCNG+DMjObqRB26BLTw1alILboFKx0y4neqkl4G7I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bJ/V4Z0oJcOCLOhyzy2NXI/RceqrUY6tt2K2VV7Zgy7FV5+JWpUYhmKf37AbpM+k5
	 2vpcYQnyq3o7NAESejvUHBILXaOsFwKvWw6X04D6LlSTSrvt5T4MKGwIulKV7YlweH
	 FZb5jWhu/kGptXh/81RjwCYVk7qveQJS/AYyX+8Vy8vt7iaar9D7yhtrxFhlktqYDx
	 jFuLYPZe03K//HVxKa4ApoONIoRXpC1fD/Mo/dBWjO1AfR70eVjzQne6Z2NI+347Gv
	 ucRp0qm+P2nbnLnHr7dC0AvVCNvpuEngzTdb2lpUiutfAUf1BTqyRrITC5S3jf/3C1
	 okwYxisXQY+Sw==
Message-ID: <024c4c07-18df-4cab-97e5-30969d189aa8@kernel.org>
Date: Thu, 25 Apr 2024 19:21:38 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/6] interconnect: icc-clk: Allow user to specify
 master/slave ids
Content-Language: en-US
To: Varadarajan Narayanan <quic_varada@quicinc.com>,
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: andersson@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 dmitry.baryshkov@linaro.org, quic_anusha@quicinc.com,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20240418092305.2337429-1-quic_varada@quicinc.com>
 <20240418092305.2337429-2-quic_varada@quicinc.com>
 <da8fc783-6b2b-495d-ab15-be297b0fa435@linaro.org>
 <ZiowMuNlBsxYQesc@hu-varada-blr.qualcomm.com>
From: Georgi Djakov <djakov@kernel.org>
In-Reply-To: <ZiowMuNlBsxYQesc@hu-varada-blr.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.04.24 13:28, Varadarajan Narayanan wrote:
> On Tue, Apr 23, 2024 at 01:00:48AM +0200, Konrad Dybcio wrote:
>>
>>
>> On 4/18/24 11:23, Varadarajan Narayanan wrote:
>>> Presently, icc-clk driver autogenerates the master and slave ids.
>>> However, devices with multiple nodes on the interconnect could
>>> have other constraints and may not match with the auto generated
>>> node ids. Hence, allow the driver to provide the preferred master
>>> and slave ids.
>>>
>>> Also, update clk-cbf-8996 accordingly.
>>>
>>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>>> ---
>>> v9: squash cbf-msm8996 change into this
>>> v8: Per review feedback, set master/slave ids explicitly. Dont autogenerate
>>>       https://lore.kernel.org/linux-arm-msm/f1b0d280-6986-4055-a611-2caceb15867d@linaro.org/
>>> ---
>>>    drivers/clk/qcom/clk-cbf-8996.c  | 7 ++++++-
>>>    drivers/interconnect/icc-clk.c   | 6 +++---
>>>    include/linux/interconnect-clk.h | 2 ++
>>
>> How is this going to be merged? :/
>>
>> icc-next? clk-next?
> 

Merging all patches via Bjorn's clk-qcom tree seems to be the best option, if he agrees of course.

Thanks,
Georgi

> Bjorn,
> 
> Can you help answer this.
> 
> Thanks
> Varada


