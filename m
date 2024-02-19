Return-Path: <linux-kernel+bounces-70789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 091C1859C67
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 07:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DFC91F22414
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 06:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A5D208D2;
	Mon, 19 Feb 2024 06:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pRmfWBpH"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BD9208C5
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 06:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708325681; cv=none; b=gvzuE05RxrI0cVgn+gRUjoINtErsiFr5648frt1aF+fxsPmogqMSEoD3DCYUrjO1wj5PCW6/Nx8ODz4G9+fHEWF39MAK3aN5cQOkRV3jTJdwxrTTh4aLQT4AL6etJd1Edz7sH1omEwI0M1QbI2T/GCdNMTHveLmtHkF1wHr1q9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708325681; c=relaxed/simple;
	bh=1NgcMtzPO0m3SO7u5i6Aa92xKwAGy2C4+8bSY9cjPYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RKx/q0BB1uDtOvetGj7644mxn340XppcSd7ShQ5sQ9OUobbilWLcs0/DL57auyNklzDpe+VnzS0F3QotRNhBDoe4aPK9AhBpnD8ggF2nqOc2Dmvv/ihV/GdZ67+itgelF6M+xH8WgsSYolua/x9fcVkIhhFS/Loo5ln0ZI6IyIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=pRmfWBpH; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708325678;
	bh=1NgcMtzPO0m3SO7u5i6Aa92xKwAGy2C4+8bSY9cjPYE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pRmfWBpHhI9zLfp2ryK8ApD+TEYRjegeILqiXYsaD3AUQLLfBmQM3KDz7M0yEBKtn
	 m2vLXxrJ+XI+/44hgIZHndL/TFThnSyKY3b11KmNC4ZaNpiYL6CtUnumv7W8u+bRIz
	 qzy5xpmJyJ9lmo4ceRaW8U/HMHL6a6TOeM9rPaBZ82uCz4AgG3d1vKhKeD5KivNGoJ
	 vqXIFjloMTlEZisZ0hEe9J/MNdgtSfTj9UhZtEJ6d5pHywnlQBAvvafTSjl6iBDKli
	 8b8ks2+KRVyua9rrmvkvlwpEgzBsHSC5/PXPksQytFrr5i7Do9frxGU0RHnZ3MTDFf
	 zLFNWZz2e3zQg==
Received: from [100.66.96.193] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C1A8A3781FE3;
	Mon, 19 Feb 2024 06:54:35 +0000 (UTC)
Message-ID: <bc7df152-51c1-0ba9-dbe4-8b571c199ad4@collabora.com>
Date: Mon, 19 Feb 2024 12:24:33 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4] drm/ci: add tests on vkms
To: Helen Koike <helen.koike@collabora.com>, dri-devel@lists.freedesktop.org
Cc: hamohammed.sa@gmail.com, daniels@collabora.com,
 rodrigosiqueiramelo@gmail.com, david.heidelberg@collabora.com,
 guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com,
 linux-kernel@vger.kernel.org, melissa.srw@gmail.com, mairacanal@riseup.net,
 daniel@ffwll.ch
References: <20240201065346.801038-1-vignesh.raman@collabora.com>
 <ae4e612a-47d2-4190-8547-2c8dc13b2cd6@collabora.com>
Content-Language: en-US
From: Vignesh Raman <vignesh.raman@collabora.com>
In-Reply-To: <ae4e612a-47d2-4190-8547-2c8dc13b2cd6@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Helen,

On 09/02/24 23:17, Helen Koike wrote:
> 
> 
> On 01/02/2024 03:53, Vignesh Raman wrote:
>> Add job that runs igt on top of vkms.
>>
>> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
>> Acked-by: Jessica Zhang <quic_jesszhan@quicinc.com>
>> Tested-by: Jessica Zhang <quic_jesszhan@quicinc.com>
>> Acked-by: Maxime Ripard <mripard@kernel.org>
>> Signed-off-by: Helen Koike <helen.koike@collabora.com>
>> ---
>>
>> v2:
>> - do not mv modules to /lib/modules in the job definition, leave it to
>>    crosvm-runner.sh
>>
>> v3:
>> - Enable CONFIG_DRM_VKMS in x86_64.config and update xfails
>>
>> v3:
>> - Build vkms as module and test with latest IGT.
>>    This patch depends on 
>> https://lore.kernel.org/dri-devel/20240130150340.687871-1-vignesh.raman@collabora.com/
>>
> 
> Do you have a link of a pipeline with this job passing?

Here is the pipeline with the job passing,
https://gitlab.freedesktop.org/vigneshraman/linux/-/pipelines/1092194

Regards,
Vignesh

