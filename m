Return-Path: <linux-kernel+bounces-125451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C22C892655
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 22:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0C9BB22C45
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 21:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4BB13C9D4;
	Fri, 29 Mar 2024 21:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="s/Dvxr52"
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A407B1E897;
	Fri, 29 Mar 2024 21:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711748918; cv=none; b=VPhuwEAboN1B1KPk5aQyEpkEMVWrWWP/IdhXXV5eLRCna7HEkKp7BM3rDJITZyXyt8X5jXK27fGKjIROL6xPPOAD8uOa4c0AAx40IPrO74Zh4xrC8gGZ9PiycA8fnItZ3mHiYd/ItOjFlY6RNVHfYc2jgWXvIJ7ylR8YlG3YAOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711748918; c=relaxed/simple;
	bh=FRIggP1YvWWV3rj+5WU1Cj2nMoZrQOSbDSPE/2jMC40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SmDDcUb1o/8HWQ8aWmJe3HtVNcfO4grSSaHP13RUl9LUDfyLMpOL9+9yB7FyWMajHfhBW/ni5MFQUW3gIkzS6Hf97oHNP8Rj2SM5sAItR1w0hsv7U9UnTkGpPN4TYxFFlNTmebJbbnr5cUtp0oI1Dhl+qjQ4pNAUeUBCQdtMkdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=s/Dvxr52; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4V5vDM6fVsz6Cnk8t;
	Fri, 29 Mar 2024 21:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1711748911; x=1714340912; bh=FRIggP1YvWWV3rj+5WU1Cj2n
	MoZrQOSbDSPE/2jMC40=; b=s/Dvxr52XitclrTlpgcZFz1EvTsZ6IJyetgiEUoc
	fGPCO+2x16JzhzlNHQ8RX0ZgBiZDvWPA9xqloF7JTB1Zqve2kpgh9ayH1QM7g6sr
	gfdVpHECtsbtLnA0NEzWVfy7UULP0qh790n3BUwTAOSVpq/L/UN2lJcOZibeOzvL
	S1QB6xOn9LmNJ5yMxY0cQQSSGywBxihLBMyeO9yj4KnmuUhIK3O9/rO/XQzRn4vi
	sNMTNIFdrN/1s79czI9ponzXiHo4bF8N/ica5CsWXf+Md1hVGOlSxq3ALbB8Nf6E
	VlQfHFOvYCkVIQ0tUmNfxBk1tBNrmhcESEEEaTL2NZncMA==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id NlkahUp5hM66; Fri, 29 Mar 2024 21:48:31 +0000 (UTC)
Received: from [192.168.3.219] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4V5vDC1kGyz6Cnk8m;
	Fri, 29 Mar 2024 21:48:26 +0000 (UTC)
Message-ID: <abaf0f8d-8531-42b8-a714-cc02ae658646@acm.org>
Date: Fri, 29 Mar 2024 14:48:25 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/11] scsi: ufs: core: Remove unnecessary wmb() after
 ringing doorbell
To: Andrew Halaney <ahalaney@redhat.com>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Hannes Reinecke <hare@suse.de>, Janek Kotas <jank@cadence.com>,
 Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>,
 Can Guo <quic_cang@quicinc.com>, Anjana Hari <quic_ahari@quicinc.com>
Cc: Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240329-ufs-reset-ensure-effect-before-delay-v5-0-181252004586@redhat.com>
 <20240329-ufs-reset-ensure-effect-before-delay-v5-10-181252004586@redhat.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240329-ufs-reset-ensure-effect-before-delay-v5-10-181252004586@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

