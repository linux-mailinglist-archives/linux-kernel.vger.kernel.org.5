Return-Path: <linux-kernel+bounces-59137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4BB84F1CA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 09:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEC9F281E4D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 08:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337B1664CC;
	Fri,  9 Feb 2024 08:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="AM0huqlX"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C165A4E2;
	Fri,  9 Feb 2024 08:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707468954; cv=none; b=L5rzrBZuAVE/uzWz/Q6ZBZ0PHRtsXNwiwXyU63LL2HmTTz0/JtRDJI97JPSbVcmIYm8vBvqAjUp53KIWpWKxw5OBLVaMIkZ1Smh3KfX75dcQVRxWLopjjFDpOBz7hXqIvVbFVpdziQzYaDNoKWSoJFM5iRs0qMOv63BQgclHlqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707468954; c=relaxed/simple;
	bh=E1U8J9iRraitj9JXUyYrMtOXpUYyeC0VxwLoad5cX3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=og2A07Yvjka3ksOSWh2QTBiHZHvsbHJ4DrF5SXu6xamCKbV7R4Rzf87i3BWjRKvCVJRO7U2sGGnTrjqfRkMh5WIoNq2PmfF1HBCaeh/mr/XcnOA8BF+I//wML9uq/wr53rko/G1ymGGBuRFFfxPMh/QvvFQtpVubDQ2z+cx2xjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=AM0huqlX; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4197UCZp005056;
	Fri, 9 Feb 2024 09:55:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=fiWSzdCEFiFP0/egHuEqBDpst3ABK0/e0ifDxf6Zt2k=; b=AM
	0huqlX8S7Ty0Q/cXX3ry7PeDLEY1OegE+hwJKzdfwMNCcQoxupOsSMZlLf02C5ON
	G+E9y46MdgTdBRAIvXrLx+UcxSqHLAjgw/9AMul67+i1e9xFRklSMtguxhidW0e5
	iU5ED0AlOMjhCd8sY7gG8Wtzh+UrPFpAI79t9BvbSBTM3ib/RsIlutE/ePfU+28m
	uMXipA95OsTdRw/PQywrezjuQyIpcZLP+5PnthmvJ4yxNLcyUphYqYqwc9VJVlBN
	F3+cwwQAJrRj5M4asSLru9IHkfuUfv+JMgpCPFvPuKWj04PU6Js2bafhj8wqSa+2
	C6M5Lw6BdchNQskze7ag==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3w1eym8018-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Feb 2024 09:55:41 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 02A0510004F;
	Fri,  9 Feb 2024 09:55:41 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EF7F32105B7;
	Fri,  9 Feb 2024 09:55:40 +0100 (CET)
Received: from [10.252.23.147] (10.252.23.147) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 9 Feb
 2024 09:55:40 +0100
Message-ID: <c744b760-4bed-44cf-b079-eb21f3697425@foss.st.com>
Date: Fri, 9 Feb 2024 09:55:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] media: i2c: st-vgxy61: remove redundant
 initialization of pointer mode
Content-Language: en-US
To: Colin Ian King <colin.i.king@gmail.com>,
        Sylvain Petinot
	<sylvain.petinot@foss.st.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        <linux-media@vger.kernel.org>
CC: <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240205220508.1851545-1-colin.i.king@gmail.com>
From: Benjamin Mugnier <benjamin.mugnier@foss.st.com>
In-Reply-To: <20240205220508.1851545-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-09_06,2024-02-08_01,2023-05-22_02

Hi Colin,

Thank you for your patch.

Reviewed-by: Benjamin Mugnier <benjamin.mugnier@foss.st.com>

On 2/5/24 23:05, Colin Ian King wrote:
> The pointer mode is being initialized with a value that is never
> read, it is being re-assigned later on. The initialization is
> redundant and can be removed.
> 
> Cleans up clang scan build warning:
> drivers/media/i2c/st-vgxy61.c:632:33: warning: Value stored to 'mode'
> during its initialization is never read [deadcode.DeadStores]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/media/i2c/st-vgxy61.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/i2c/st-vgxy61.c b/drivers/media/i2c/st-vgxy61.c
> index 2d64466d7ecf..b9e7c57027b1 100644
> --- a/drivers/media/i2c/st-vgxy61.c
> +++ b/drivers/media/i2c/st-vgxy61.c
> @@ -629,7 +629,7 @@ static int vgxy61_try_fmt_internal(struct v4l2_subdev *sd,
>  				   const struct vgxy61_mode_info **new_mode)
>  {
>  	struct vgxy61_dev *sensor = to_vgxy61_dev(sd);
> -	const struct vgxy61_mode_info *mode = sensor->sensor_modes;
> +	const struct vgxy61_mode_info *mode;
>  	unsigned int index;
>  
>  	for (index = 0; index < ARRAY_SIZE(vgxy61_supported_codes); index++) {

-- 
Regards,

Benjamin

