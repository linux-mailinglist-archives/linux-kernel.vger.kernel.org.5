Return-Path: <linux-kernel+bounces-20735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A89828460
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 11:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A806BB22D07
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 10:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BE236AE1;
	Tue,  9 Jan 2024 10:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="xm9Q/TYf"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6C31E495;
	Tue,  9 Jan 2024 10:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4098wWJL024538;
	Tue, 9 Jan 2024 11:57:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=WJM+FN3BbJguoxYj18CJqgexwYJ67ZV2CrCougHEDh8=; b=xm
	9Q/TYf+GLG7ERgGgeyJh4b4z381lvJnmpsbSOgIW8CjcaktUhATy7mJ9o4YYnTrN
	fpohYgil80XjJt+JW4sCNSYgGXrE1iv4qQ5dGr6fyxIqDI+Q5oMsgB/+gUVZeRIi
	Uo4QDbNe7rnXMEUCkv+K4RndYgMsuD1zek7HKIg9zDNAzLcMeVixxlMvf3n1avHV
	VUa+V0/wQ8t7sRfnMJWajdf01kwL8vv5q3z6DCri8Z2UxPGSY2VGOpm40YUgouNx
	b6zLuRRUDGu/N5DsSL44hoRENQpYrjSAAWv0DIZT51sRv4/6vGlSJvRjTovFpOC5
	NBf0jy9v0J8p8/viHB9A==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vfha4h5fm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 11:57:56 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 867DF10002A;
	Tue,  9 Jan 2024 11:57:55 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4C8512088EF;
	Tue,  9 Jan 2024 11:57:55 +0100 (CET)
Received: from [10.201.20.75] (10.201.20.75) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 9 Jan
 2024 11:57:54 +0100
Message-ID: <77fb1d8b-0db8-43f4-99bc-705a73dbc820@foss.st.com>
Date: Tue, 9 Jan 2024 11:57:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] remoteproc: virtio: Fix wdg cannot recovery remote
 processor
Content-Language: en-US
To: <joakim.zhang@cixtech.com>, <andersson@kernel.org>,
        <mathieu.poirier@linaro.org>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <cix-kernel-upstream@cixtech.com>
References: <20231217053659.3245745-1-joakim.zhang@cixtech.com>
From: Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Organization: STMicroelectronics
In-Reply-To: <20231217053659.3245745-1-joakim.zhang@cixtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-05_08,2024-01-05_01,2023-05-22_02



On 12/17/23 06:36, joakim.zhang@cixtech.com wrote:
> From: Joakim Zhang <joakim.zhang@cixtech.com>
> 
> Recovery remote processor failed when wdg irq received:
> [    0.842574] remoteproc remoteproc0: crash detected in cix-dsp-rproc: type watchdog
> [    0.842750] remoteproc remoteproc0: handling crash #1 in cix-dsp-rproc
> [    0.842824] remoteproc remoteproc0: recovering cix-dsp-rproc
> [    0.843342] remoteproc remoteproc0: stopped remote processor cix-dsp-rproc
> [    0.847901] rproc-virtio rproc-virtio.0.auto: Failed to associate buffer
> [    0.847979] remoteproc remoteproc0: failed to probe subdevices for cix-dsp-rproc: -16
> 
> The reason is that dma coherent mem would not be released when
> recovering the remote processor, due to rproc_virtio_remove()
> would not be called, where the mem released. It will fail when
> it try to allocate and associate buffer again.
> 
> Releasing reserved memory from rproc_virtio_dev_release(), instead of
> rproc_virtio_remove().
> 
> Fixes: 1d7b61c06dc3 ("remoteproc: virtio: Create platform device for the remoteproc_virtio")
> Signed-off-by: Joakim Zhang <joakim.zhang@cixtech.com>

LGTM

Acked-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>

Thanks,
Arnaud

> ---
> ChangeLogs:
> V1->V2:
>         * the same for of_reserved_mem_device_release()
> V2->V3:
>         * release reserved memory in rproc_virtio_dev_release()
> ---
>  drivers/remoteproc/remoteproc_virtio.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
> index 83d76915a6ad..25b66b113b69 100644
> --- a/drivers/remoteproc/remoteproc_virtio.c
> +++ b/drivers/remoteproc/remoteproc_virtio.c
> @@ -351,6 +351,9 @@ static void rproc_virtio_dev_release(struct device *dev)
> 
>         kfree(vdev);
> 
> +       of_reserved_mem_device_release(&rvdev->pdev->dev);
> +       dma_release_coherent_memory(&rvdev->pdev->dev);
> +
>         put_device(&rvdev->pdev->dev);
>  }
> 
> @@ -584,9 +587,6 @@ static void rproc_virtio_remove(struct platform_device *pdev)
>         rproc_remove_subdev(rproc, &rvdev->subdev);
>         rproc_remove_rvdev(rvdev);
> 
> -       of_reserved_mem_device_release(&pdev->dev);
> -       dma_release_coherent_memory(&pdev->dev);
> -
>         put_device(&rproc->dev);
>  }
> 
> --
> 2.25.1
> 
> 
> 
> This email (including its attachments) is intended only for the person or entity to which it is addressed and may contain information that is privileged, confidential or otherwise protected from disclosure. Unauthorized use, dissemination, distribution or copying of this email or the information herein or taking any action in reliance on the contents of this email or the information herein, by anyone other than the intended recipient, or an employee or agent responsible for delivering the message to the intended recipient, is strictly prohibited. If you are not the intended recipient, please do not read, copy, use or disclose any part of this e-mail to others. Please notify the sender immediately and permanently delete this e-mail and any attachments if you received it in error. Internet communications cannot be guaranteed to be timely, secure, error-free or virus-free. The sender does not accept liability for any errors or omissions.

