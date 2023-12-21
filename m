Return-Path: <linux-kernel+bounces-8926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8869481BE40
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA77D1C24CD9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B011F601;
	Thu, 21 Dec 2023 18:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y2Ijq54z"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11775848C
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 18:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703183488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iqzXGFTYPha3MJ2BS1hqMcmIVr1nRxinkoFODqmbVsw=;
	b=Y2Ijq54z5fUqQsvplkxgZEYRBo/0qic8x4/O3s2U+orHRpkEYkoMH9NpG0XYgbkGO53Eul
	0hgeLTkeAa3medOAV/eeZTQ28hQ1LwbCUyViWbJlLIKzR9YBdzAHGflbDHO2eGDFHqqX2d
	0B3dD7vwqSBBz4aP2qZsXDAacIVc2UU=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-OqMiN24YP5yuWe--4v_VwA-1; Thu, 21 Dec 2023 13:31:26 -0500
X-MC-Unique: OqMiN24YP5yuWe--4v_VwA-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-427a2626825so7214741cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 10:31:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703183486; x=1703788286;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iqzXGFTYPha3MJ2BS1hqMcmIVr1nRxinkoFODqmbVsw=;
        b=i9mPILXQABr0AD0ZcYBxnX0n+WOsV2XNkfB4GbwQP2/WEgGtHaLfzWkG09bUNOYUNv
         cn6ogjH0f5HPxJ0bNkrOB5uYF/23L2CowhrSTlDqJPYB1szzHrRCiF+xEB0zKXDOtV0o
         cGdZssksE+Tw2XFQshrxUcRbrYfWEt6YggtucPsvaU3bo/vMqPe9IJEyvX+iCYr1d8tL
         AOdT9Bbv0pjk74N49t6DLQ/uQgw/CHNPwHMmuZUaeJ6MPIrUyau/DApSUoJ90hTEKOjE
         DoIvrP+NhUOo5ypfdG3+5mrr8XGT0XIxbXBDyyCzuq/fFaQQLD5dJBmNTa5n/hD+XpmF
         Tnhw==
X-Gm-Message-State: AOJu0YwtpwIXYVGrfwCaUL7N5znaFm6Lzl7m8CkpKlvYLQR5njmkc6as
	5dl5uLWfPjikG05aXgyslwgjcO1AhzxckQ/jcTwFn66NcyEj6/4dwmf4FZQtB9zan0s+BLtBOyF
	N3WN1tR7cD876oj16/FCdZlCPjGRGYrMm
X-Received: by 2002:ac8:5b89:0:b0:419:a2c6:8207 with SMTP id a9-20020ac85b89000000b00419a2c68207mr203823qta.22.1703183486356;
        Thu, 21 Dec 2023 10:31:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExnOqmre6zMOO/OK2SOYzxK6qk5Jrhu44FrGAm4mJbz0gdlj3uPSaQ4tdXH639/O1zY0MQyQ==
X-Received: by 2002:ac8:5b89:0:b0:419:a2c6:8207 with SMTP id a9-20020ac85b89000000b00419a2c68207mr203812qta.22.1703183486097;
        Thu, 21 Dec 2023 10:31:26 -0800 (PST)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id hj10-20020a05622a620a00b00425e8c7d65fsm1036139qtb.23.2023.12.21.10.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 10:31:25 -0800 (PST)
Date: Thu, 21 Dec 2023 12:31:23 -0600
From: Andrew Halaney <ahalaney@redhat.com>
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	"James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Yaniv Gardi <ygardi@codeaurora.org>, Dov Levenglick <dovl@codeaurora.org>, 
	Hannes Reinecke <hare@suse.de>, Subhash Jadavani <subhashj@codeaurora.org>, 
	Gilad Broner <gbroner@codeaurora.org>, Venkat Gopalakrishnan <venkatg@codeaurora.org>, 
	Janek Kotas <jank@cadence.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Avri Altman <avri.altman@wdc.com>, Bart Van Assche <bvanassche@acm.org>, 
	Anjana Hari <quic_ahari@quicinc.com>, Dolev Raviv <draviv@codeaurora.org>, 
	Can Guo <quic_cang@quicinc.com>
Cc: Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 00/11] scsi: ufs: Remove overzealous memory
 barriers
Message-ID: <pnwsdz3i2liivjxvtfwq6tijotgh5adyqipjjb5wdvo4jpu7yv@j6fkshm5ipue>
References: <20231221-ufs-reset-ensure-effect-before-delay-v2-0-75af2a9bae51@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221-ufs-reset-ensure-effect-before-delay-v2-0-75af2a9bae51@redhat.com>

Sorry for the spam, b4 and smtp with google are not playing nice and
failed (but worked fine with --reflect). I'll send a v3 the old school way.

My apologies,
Andrew

On Thu, Dec 21, 2023 at 12:25:17PM -0600, Andrew Halaney wrote:
> This is an RFC because I'm not all the confident in this topic. UFS has
> a lot of mb() variants used, most with comments saying "ensure this
> takes effect before continuing". mb()'s aren't really the way to
> guarantee that, a read back is the best method.
> 
> Some of these though I think could go a step further and remove the mb()
> variant without a read back. As far as I can tell there's no real reason
> to ensure it takes effect in most cases (there's no delay() or anything
> afterwards, and eventually another readl()/writel() happens which is by
> definition ordered).
> 
> In this current series I don't do that as I wasn't totally convinced,
> but it should be considered when reviewing.
> 
> Hopefully this series gets enough interest where we can confidently
> merge the final result after review helps improve it.
> 
> I'll be travelling a good bit the next 2ish weeks, so expect little
> response until my return.
> 
> Thanks in advance for the help,
> Andrew
> 
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> ---
> Changes in v2:
> - Added review tags for original patch
> - Added new patches to address all other memory barriers used
> 
> - Link to v1: https://lore.kernel.org/r/20231208-ufs-reset-ensure-effect-before-delay-v1-1-8a0f82d7a09e@redhat.com
> 
> ---
> Andrew Halaney (11):
>       scsi: ufs: qcom: Perform read back after writing reset bit
>       scsi: ufs: qcom: Perform read back after writing REG_UFS_SYS1CLK_1US
>       scsi: ufs: qcom: Perform read back after writing testbus config
>       scsi: ufs: qcom: Perform read back after writing unipro mode
>       scsi: ufs: qcom: Perform read back after writing CGC enable
>       scsi: ufs: cdns-pltfrm: Perform read back after writing HCLKDIV
>       scsi: ufs: core: Perform read back after writing UTP_TASK_REQ_LIST_BASE_H
>       scsi: ufs: core: Perform read back after disabling interrupts
>       scsi: ufs: core: Perform read back after disabling UIC_COMMAND_COMPL
>       scsi: ufs: core: Perform read back to commit doorbell
>       scsi: ufs: core: Perform read back before writing run/stop regs
> 
>  drivers/ufs/core/ufshcd.c      | 10 +++++-----
>  drivers/ufs/host/cdns-pltfrm.c |  2 +-
>  drivers/ufs/host/ufs-qcom.c    | 14 ++++++--------
>  drivers/ufs/host/ufs-qcom.h    | 12 ++++++------
>  4 files changed, 18 insertions(+), 20 deletions(-)
> ---
> base-commit: 20d857259d7d10cd0d5e8b60608455986167cfad
> change-id: 20231208-ufs-reset-ensure-effect-before-delay-6e06899d5419
> 
> Best regards,
> -- 
> Andrew Halaney <ahalaney@redhat.com>
> 


