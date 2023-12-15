Return-Path: <linux-kernel+bounces-1341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DA7814DAD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9DDC1C23A4E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1937D3EA78;
	Fri, 15 Dec 2023 16:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="0lflel1L"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D3D3EA60;
	Fri, 15 Dec 2023 16:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3BFEt2jl028439;
	Fri, 15 Dec 2023 17:55:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=0ApVVVLWHcX93yEw+eAHG/mefIxFRv8pbx/vnnZVjpc=; b=0l
	flel1LG0UbDG1dGh7ShRs/VYdtdDugsWNQ31ZegPyJem0SnhJcmGLoRr8JPplOmL
	uG6ZEeEu8uUXUIP+mc6qqBea48SBwGAOTkkHjKT1y6R9OBDInO21qenpjrkcXTZy
	xIYeu7cn6wOciBSW2Ef4l9Cw/6FbsVuhVi9CdYRtnyurBgwnNxrbS2k5kYCp8yXT
	QwFQvessWfzYZRykXSrHIfvXGEJX86vNT3FQLrVU1v4b69omjBlPqEn/SzrWbloB
	wkWJ5Y8A3tUU+JIkF0QX45OO4ML72vEOChV+hmJ9YoxH3YmB8mrAbRo1/x3+mdLI
	XsKvgrOmDB5w2PnJsz8w==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3uvehmu736-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 17:55:43 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0D522100052;
	Fri, 15 Dec 2023 17:55:41 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C85A6237D69;
	Fri, 15 Dec 2023 17:55:41 +0100 (CET)
Received: from [10.252.23.239] (10.252.23.239) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 15 Dec
 2023 17:55:38 +0100
Message-ID: <70376b4f-0fbe-4087-8c7c-eb7167191a37@foss.st.com>
Date: Fri, 15 Dec 2023 17:55:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] remoteproc: virtio: Fix wdg cannot recovery remote
 processor
Content-Language: en-US
To: <joakim.zhang@cixtech.com>, <andersson@kernel.org>,
        <mathieu.poirier@linaro.org>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <cix-kernel-upstream@cixtech.com>
References: <20231215145023.2248366-1-joakim.zhang@cixtech.com>
From: Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Organization: STMicroelectronics
In-Reply-To: <20231215145023.2248366-1-joakim.zhang@cixtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-15_10,2023-12-14_01,2023-05-22_02

Hello  Joakim,

On 12/15/23 15:50, joakim.zhang@cixtech.com wrote:
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
> We can see that dma coherent mem allocated from rproc_add_virtio_dev(),
> so should release it from rproc_remove_virtio_dev(). These functions should
> appear symmetrically:
> -rproc_vdev_do_start()->rproc_add_virtio_dev()->dma_declare_coherent_memory()
> -rproc_vdev_do_stop()->rproc_remove_virtio_dev()->dma_release_coherent_memory()
> 
> The same for of_reserved_mem_device_init_by_idx() and of_reserved_mem_device_release().
> 
> Fixes: 1d7b61c06dc3 ("remoteproc: virtio: Create platform device for the remoteproc_virtio")
> Signed-off-by: Joakim Zhang <joakim.zhang@cixtech.com>
> ---
> ChangeLogs:
> V1->V2:
>         * the same for of_reserved_mem_device_release()
> ---
>  drivers/remoteproc/remoteproc_virtio.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
> index 83d76915a6ad..e877ee78740d 100644
> --- a/drivers/remoteproc/remoteproc_virtio.c
> +++ b/drivers/remoteproc/remoteproc_virtio.c
> @@ -465,8 +465,12 @@ static int rproc_add_virtio_dev(struct rproc_vdev *rvdev, int id)
>  static int rproc_remove_virtio_dev(struct device *dev, void *data)
>  {
>         struct virtio_device *vdev = dev_to_virtio(dev);
> +       struct rproc_vdev *rvdev = vdev_to_rvdev(vdev);
> 
>         unregister_virtio_device(vdev);
> +       of_reserved_mem_device_release(&rvdev->pdev->dev);
> +       dma_release_coherent_memory(&rvdev->pdev->dev);
> +

At this step, the virtio device may not be released and may still be using the
memory.
Do you try to move this in rproc_virtio_dev_release?

Regards,
Arnaud

>         return 0;
>  }
> 
> @@ -584,9 +588,6 @@ static void rproc_virtio_remove(struct platform_device *pdev)
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

