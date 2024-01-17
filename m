Return-Path: <linux-kernel+bounces-29020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDF8830709
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 748131F25D7A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 13:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1C01EB55;
	Wed, 17 Jan 2024 13:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="RU13b9Td"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDC210799;
	Wed, 17 Jan 2024 13:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705497893; cv=none; b=E7IDz3xEreRRJFITEstqZ1TFLL6xbBLJdlry4EuPecSEUi7ZEESqltv2MMfkPnEcNYUbNNCYfA4OpGAxWKEtp+2rADsTQawPWhfJc7N6QhNeapqY2cvfBy7C8SY/oFRUMmG1C+uMNXRGzIe+j5ktwGItEvmAESIX4dA/DqYQDXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705497893; c=relaxed/simple;
	bh=uk0oEvzGdLc3yF4zp2bMI+rdHVz8vGNoe+a81asr5Uo=;
	h=Received:DKIM-Signature:Received:Received:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:CC:References:From:Organization:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy:
	 X-Proofpoint-Virus-Version; b=rvOogv/rl6rbSnm4lTjPfnQl2dHl2b82rTgg5wp/03klgDJpWOaz/BnluiPe5FCBbBl2AdZYXUxW+bes+mr0J5L5FmvR6gXbhGm6g9TDyJem7sNViH3pehVnT4XARAbgKblCex9Ng3wXCKPb8U1VT5XmIjjHjqXEn3skLH13VL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=RU13b9Td; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40H8PCcZ007691;
	Wed, 17 Jan 2024 14:24:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=Te5k9GkTLi4Sq5SrTeZvD0LQS6mMi38YJ0s674SsFqc=; b=RU
	13b9TdAMAL+P2hVT9WMM/28C2mJy9TDKtLPF7dQtrd4P3e4Pt1RUQJSMDr41RlK9
	RV5sErUS8kxEXrquN9KVH/+ZHgvwsNTrTIiqObUBoaQOiCP2NdQIMcvMPbnZuwgR
	VfgJ/2IH715yQAd/QZg0I+DBCfjZtq/sIazsX2uym40aMTB9kuEHeJ3XIR4JPxu5
	zVcT7MHVytT4J7RonRH6GyWnWayxtGzMNFkA8k1cwk5ZM7Z7aCS6v+vDI3I+smCV
	24vCYB2S/aYQsZj6SzEqRni5cXv/pTx/mFtU+c5CBoMqb6xrsko6nGUzMuWNjLS0
	c2ZrrN9OJLH9uJtDQIng==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vkmfym3e4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 14:24:44 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7D7A8100079;
	Wed, 17 Jan 2024 14:24:43 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6EF5E208D45;
	Wed, 17 Jan 2024 14:24:43 +0100 (CET)
Received: from [10.252.22.63] (10.252.22.63) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 17 Jan
 2024 14:24:41 +0100
Message-ID: <96941fae-8341-4834-9283-4f6def47b1f0@foss.st.com>
Date: Wed, 17 Jan 2024 14:24:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] remoteproc: stm32: Fix sparse warnings
Content-Language: en-US
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier
	<mathieu.poirier@linaro.org>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20240117131817.3338146-1-arnaud.pouliquen@foss.st.com>
From: Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Organization: STMicroelectronics
In-Reply-To: <20240117131817.3338146-1-arnaud.pouliquen@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_08,2024-01-17_01,2023-05-22_02

Hi,

On 1/17/24 14:18, Arnaud Pouliquen wrote:
> Fix warnings reported by sparse using make option "C=1"
> 
> Arnaud Pouliquen (2):
>   remoteproc: stm32: Fix incorrect type in assignment for va
>   remoteproc: stm32: Fix incorrect type assignment returned by
>     stm32_rproc_get_loaded_rsc_tablef
> 
>  drivers/remoteproc/stm32_rproc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> 
> base-commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a

I faced an issue with the ST server message that blocked a part
of the mails associated with this series. Please ignore this series,
as I will resend it.

Regards
Arnaud

