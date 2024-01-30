Return-Path: <linux-kernel+bounces-45439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA348430CC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D1A81C23EFE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76C67EF15;
	Tue, 30 Jan 2024 23:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/4bDsru"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DB77EF06;
	Tue, 30 Jan 2024 23:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706655693; cv=none; b=O2p8wKuQsIBEbglnWyhtTaTr2l65jvfdeZB/1xeMuSn/ttExredTjEM5b4oO5If91IVvWRV8dNd2CoPCXTKdq7HSB99XLSyrsbn/3mZwJezhnY7iiOjSab0MUIDRte3TjRd5/a2l5OlIk6qkOsfSwHJlcDI2wlH14MaNR7y8zeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706655693; c=relaxed/simple;
	bh=ku1C/ZkbKX+29BRUe76r+E2vI8ZO7+6hPMyFCOiFLQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FiizZ2rotWRU+zfJ/KgqSuBZ1NSw+erq9SNQtm/OY0aYGZ1RokU0ENAeZ16REWD5kVooijriEEhAsDQkHoPCFQcc4NqCdLj8Z1ntNhHVfRj0agvFrLmPlj3Zw7lA2nZkvjmAkNTJSTF5PMhapEjYzL5RIQrI/YyvRywluXqF5eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/4bDsru; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 673B8C433C7;
	Tue, 30 Jan 2024 23:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706655692;
	bh=ku1C/ZkbKX+29BRUe76r+E2vI8ZO7+6hPMyFCOiFLQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D/4bDsruR054m2eZrmHx9bopxrE7FZ6qZLIETLGBtVSr1Klv3+vKCOGaLfD09IpK0
	 QLusj9nMEU2zhFJOCloZsME3p6H6Spz5WOKFVCxl3P3/ZD2H9x12Tqj3rTiVKWKRd8
	 lZcWgUru/vix1hPpGdIJ8NB73EQt/naxYOkPhg9bAhHsCXkCvNvQE0rhZ42ClEKlc/
	 Lu1RKry+swCBJqxifi5fcxiNo+WLIg57pt+r1SmviioOBT8i+25XBxjwyYctAkG/1q
	 HxUkrLvVa5R9Yv6kyWTpej5genuaZfEIr/1QucvIONqt0EouWdoMwzyDTFRJFrK2ac
	 6OCK/MK1Kl7YQ==
Date: Tue, 30 Jan 2024 18:01:31 -0500
From: Sasha Levin <sashal@kernel.org>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Luca Weiss <luca.weiss@fairphone.com>, andersson@kernel.org,
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH AUTOSEL 6.7 15/39] power: supply: qcom_battmgr: Register
 the power supplies after PDR is up
Message-ID: <Zbl_y-KmQhCnN7Tu@sashalap>
References: <20240128161130.200783-1-sashal@kernel.org>
 <20240128161130.200783-15-sashal@kernel.org>
 <rtghydsz532x6atjeshexkgevqlfxmw5owjexmnczwepeefvlb@gxinnf23tzij>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <rtghydsz532x6atjeshexkgevqlfxmw5owjexmnczwepeefvlb@gxinnf23tzij>

On Mon, Jan 29, 2024 at 02:03:14PM +0100, Sebastian Reichel wrote:
>Hi,
>
>On Sun, Jan 28, 2024 at 11:10:35AM -0500, Sasha Levin wrote:
>> From: Konrad Dybcio <konrad.dybcio@linaro.org>
>>
>> [ Upstream commit b43f7ddc2b7a5a90447d96cb4d3c6d142dd4a810 ]
>>
>> Currently, a not-yet-entirely-initialized battmgr (e.g. with pd-mapper
>> not having yet started or ADSP not being up etc.) results in a couple of
>> zombie power supply devices hanging around.
>>
>> This is particularly noticeable when trying to suspend the device (even
>> s2idle): the PSY-internal thermal zone is inaccessible and returns
>> -ENODEV, which causes log spam.
>>
>> Register the power supplies only after we received some notification
>> indicating battmgr is ready to take off.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> Tested-by: Luca Weiss <luca.weiss@fairphone.com>
>> Link: https://lore.kernel.org/r/20231218-topic-battmgr_fixture_attempt-v1-1-6145745f34fe@linaro.org
>> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>
>Please drop it, I have a patch queued reverting this patch.

Dropped, thanks!

-- 
Thanks,
Sasha

