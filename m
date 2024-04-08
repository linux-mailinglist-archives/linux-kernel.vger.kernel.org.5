Return-Path: <linux-kernel+bounces-134709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6272989B5CF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 04:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D39F8281765
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 02:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BD01852;
	Mon,  8 Apr 2024 02:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPA68T9+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2E610E9;
	Mon,  8 Apr 2024 02:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712542027; cv=none; b=DNbAR3NkE1P0FZ2dcGHI+iY0Mw8sztNUbSoQqQ6dDbnEe9XXAy0pDJqKnkqw3R1xprnTndeiLnQiucKrL5Zg+Y9FLA/QqNMQ11uryPiKwm0U8MikvYRyCAZBdxmyEPM2u8vemlUw1bBa8IXXw/M4RCKRf3Ef3U91EGIYwHFVCag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712542027; c=relaxed/simple;
	bh=gJ6UlRcTkB0WavipLjmIAgsGb+Nmj4NdTfMUmv+EcRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nA7Vz5z+WEm4nkArsTIK+skyMRa2XEwDv0JA+2ZFK/WRgpkU5SlkcgbMyoYXSVr9KNoQPx07cYJxk8qrr6wAoRkjAIZA7+v5tr3lyjlIp5QBbD9Y7WMgRHMBNlRut4B/d3oiUhjQJfAjeZic0xYQqbuixKDPDM80L0WlOaO/Pao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPA68T9+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D9E8C433F1;
	Mon,  8 Apr 2024 02:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712542026;
	bh=gJ6UlRcTkB0WavipLjmIAgsGb+Nmj4NdTfMUmv+EcRY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RPA68T9+ZkQn60kLZoFN83goTQXivZ4/dofusmbXd/4A0IQXNn2ZvrbIZXkKs1wHC
	 JOvbj8+esXmpuMVCkzL+7Qqk/xs5sN4taIccbTb2+w4cBgCnxoksqiIHZ2ZoT2rsB8
	 KGB+y75LAmrDYjZOpZVGHltUDdXIE6KcUDjOzP8D0HyIfb34xeIfn/5D2qWKUypezi
	 Yaloio9UHJb/y6xvgDb8TwVqgbyOF/xSc5fVRf+Ps5H9Pkmlap7XGKrq2TP38X7jYu
	 ZBSvOBbCqj0/9Bi1l7/p1yQoqNwk9jqtwFqwxYn+g/5HuZzBsiIjZYcRBhU0OsVK1F
	 BxvqMr/GEMrJQ==
Date: Sun, 7 Apr 2024 22:07:05 -0400
From: Sasha Levin <sashal@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.1 04/52] arm64: dts: qcom: sdm630: add USB QMP
 PHY support
Message-ID: <ZhNRSdE2E_l7mnvq@sashalap>
References: <20240329124605.3091273-1-sashal@kernel.org>
 <20240329124605.3091273-4-sashal@kernel.org>
 <42ef5a02-a50e-4a4a-9d07-2f5848857560@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <42ef5a02-a50e-4a4a-9d07-2f5848857560@linaro.org>

On Fri, Mar 29, 2024 at 02:16:00PM +0100, Konrad Dybcio wrote:
>On 29.03.2024 1:44 PM, Sasha Levin wrote:
>> From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>
>> [ Upstream commit bb5009a24ec3f2f2ec1e2ed7b8a5dcde9a9e28d9 ]
>>
>> Define USB3 QMP PHY presend on the SDM630 / SDM660 platforms. Enable it by
>> default in the USB3 host, but (for compatibility), force USB 2.0 mode
>> for all defined boards. The boards should opt-in to enable USB 3.0
>> support.
>>
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> Link: https://lore.kernel.org/r/20240116-sdm660-usb3-support-v1-3-2fbd683aea77@linaro.org
>> Signed-off-by: Bjorn Andersson <andersson@kernel.org>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>
>Hi, this depends on other kernel changes and can possibly regress something
>if EPROBE_DEFER isn't handled correctly (because it will never probe)
>
>Please drop it from all queues

Dropped, thanks!

-- 
Thanks,
Sasha

