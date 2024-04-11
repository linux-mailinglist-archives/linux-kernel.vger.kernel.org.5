Return-Path: <linux-kernel+bounces-141263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A268A1BAC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2FB41F2245D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A964B1353E1;
	Thu, 11 Apr 2024 16:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="hP1+J8LP"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EDE134750;
	Thu, 11 Apr 2024 16:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712851403; cv=none; b=Nowc/o5hr9hMQ1ePJnK9Y+fc20LEVuBvg0y6SJx0TcjNitrKqFuckFJkeb0FLnu4jLLUiEDy3NXSBPnTaKSlaz9+6WjuW5lRvU4C0/tKKrnQ/xrX8fpjJtyN1J6MAA5CVyP+j05FNR0PH2TUAFre0TSs7jOZTBiFtlWQP66Vb9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712851403; c=relaxed/simple;
	bh=BduVLd6senfYQDjjc2EDd4dHZbvRxRDiGRqpAmy1XG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GZeUllPdSN9R7D8sg1yIo6yKArCVgWnb2aQ0JLqiIlyUvxY4J2ItbvsZPSXTVuWVYfD3gV9eX+6ur/OCzVmum3Lu6ILBLQNBiDFGTCktOd3ohE6KHZi+GIaQXtDsmjEvLJIb3ttHA3dDrXaEV/3vRxksn+rnnjOn7tDlO8J6T84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=hP1+J8LP; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43B4cAmU024765;
	Thu, 11 Apr 2024 11:02:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	PODMain02222019; bh=/twGumiTIF1zrVK9lUsJUzl36p7oTXhdLfL49IKSSZ8=; b=
	hP1+J8LPZgg3mX5BGq5T5F3+biTC4zzO8c3RN3jBiLdVVbcUMrgms2rIeCRxGuLQ
	S1tM4IFVCk0KO3XchWAYzNYIP6TaykTa7N4LQ5oTNDAOoJXFVXqKnAOA9TXewiiH
	pUUc1IPBLbIF/n5PYkx0UYbLyia738KDo8aBZm/n9BB1CV7L5z1rygnFt1PFcNQk
	o72mC5dzRP6ZVbu1qkvc4nzjd0kMZeVeSmV3GZcIPj7YWF+UVkZF6jcAYuHgSJhG
	rY4xqnKfZ074SggSgZx4aWt2aK87jdN1N8jRMsbaPjqaBEWKi0bLNIFdiLgDVAfV
	cyfZtB6R/qhPIaeu1jm8SQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3xb3sxq94m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 11:02:44 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 11 Apr
 2024 17:02:42 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Thu, 11 Apr 2024 17:02:42 +0100
Received: from [198.90.208.18] (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 50939820242;
	Thu, 11 Apr 2024 16:02:42 +0000 (UTC)
Message-ID: <a49dc5e4-9e04-4f18-85bf-e3edf0baa3e4@opensource.cirrus.com>
Date: Thu, 11 Apr 2024 17:02:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ASoC: cs35l41: Update DSP1RX5/6 Sources for DSP config
To: Stefan Binding <sbinding@opensource.cirrus.com>,
        Mark Brown
	<broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
References: <20240411142648.650921-1-sbinding@opensource.cirrus.com>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <20240411142648.650921-1-sbinding@opensource.cirrus.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: WxM7XQ2Y3OO6eWFsJB2nx3a-2_V6AIvt
X-Proofpoint-GUID: WxM7XQ2Y3OO6eWFsJB2nx3a-2_V6AIvt
X-Proofpoint-Spam-Reason: safe

On 11/04/2024 15:26, Stefan Binding wrote:
> Currently, all ASoC systems are set to use VPMON for DSP1RX5_SRC,
> however, this is required only for internal boost systems.
> External boost systems require VBSTMON instead of VPMON to be the
> input to DSP1RX5_SRC.
> Shared Boost Active acts like Internal boost (requires VPMON).
> Shared Boost Passive acts like External boost (requires VBSTMON)
> All systems require DSP1RX6_SRC to be set to VBSTMON.
> 
> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>

Reviewed-by: Richard Fitzgerald <rf@opensource.cirrus.com>

