Return-Path: <linux-kernel+bounces-163911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6068B75A5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 815591C21FAD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339D31419BC;
	Tue, 30 Apr 2024 12:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xflb2RUJ"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3C7140E29
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 12:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714479840; cv=none; b=eTZM7RmqiI7Qc65RwVgUGBZ102Qvv3S49WmRqXROlWeCvFjtzY2woHDJ/+XRxIGrFrygfSxSAaXPXegAzi/fD49oG9aTdqt1r/FwbSg2iTJnZWsrFEAk53gYkKVajuBDuu+UvgNhhuMyVv8igDC+xb7Ndhz6OA2E0lBdkygmdbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714479840; c=relaxed/simple;
	bh=M/fuDa4TAzKrY/SjEcNRdbZHf4Z3egbSsIA7E94Rks0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TScBPLjDUgfFJub2ospckfsiAoztXifE0d3G50LMBDHzycPhvjLxfHCcUCClBmOd2ZZGjLoEEvNsBbQfXyxeuwh8bX4ZKw43wraTgCY4aOORTAa82IXg0SqXxjlwpEmZ13K7NtZaWtz1rojXc/TD6ftM6RuIF5ayYd/wy3zsaaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xflb2RUJ; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-572a092dd2dso498093a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 05:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714479836; x=1715084636; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=q9pjVXVco1U/cWiglm8CxhJD4WMHoae/pXQiNWOvnas=;
        b=xflb2RUJPzgzptSswtIBXcVfeLSs3D/PkgTqoPfuTutBlfcpezyf3JDgW+QMpwT718
         owAX85RSnAx7xjrFhV1lJCqcR0VBtQ1LUT70JG0Pv0aozlazxCKbKOi7jUaP9BpiDOCh
         LNy8kOJ00T3A03DWmBddv+lr1hjKbtKbw8Gooxh6bf+kjbi6kGaBQ1BUOkZ1SvsNGjiI
         xhgfB/wtg8+22OVLPQPpVwKwkbtXDUH2kLZ8Ws6udvqGkASGbrQgVQwNKEzTbyb9MNqD
         Tbe+1zYlyUgb6cFc3brGDWS8lhtrgE/6ZEHdrKdZpiVoDJQOYKtlU77O6goWql0NA/MP
         kdPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714479836; x=1715084636;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q9pjVXVco1U/cWiglm8CxhJD4WMHoae/pXQiNWOvnas=;
        b=Tsjykf5ONEWxDb0gan4V6GtZ/nR13bp94djkiTUOm0wE0W2dXn5AtZn1/+owp56V1v
         FUgJNX4hd75kXkPJEi1bOCWH+oAhUWI/VXITf/LYuwqT0Ux8bOc1k/h7UGV7VGf3HGFL
         BVYO1/7Cr0agXQZVl+D21IyemqsyZ4QN8glcSZAMz+RoD887z6ZN8mAJIf3cLP7JZKsr
         NDDqIKlHxSFTbAg2l8IBNjBLisLf5JH7ULjN1zuYal4igXj33WMNg9Xk4DT5dsdJJvGa
         JwiVNP+CLgtO3Biq+KFoP3TvhWmdhMOPUzMDil+QXfdJdjWl7BHqC5bWl0IYl6VR30kh
         KMgw==
X-Forwarded-Encrypted: i=1; AJvYcCWH8fxOlzRex+Zgui+xSBIESDowCFc4+Q11S9kX07MqEoRFohXLkjFUkwoju5c3exwyF+FH2ep8Wgqzb754adEFYcgwB4h+oCPP/i4t
X-Gm-Message-State: AOJu0YwqKocYTXMsA9idUqOE/eU2CIY1rgnAF/SB13cVJJ8AtRv+Pq+c
	fRSvBegIlAzKmpUafqlLDyclghzmhxhf5HV4e5k9vv8sW38opWX4HQ2uNAjUxpg=
X-Google-Smtp-Source: AGHT+IFRl5o5P3FNRrHDdOT/8k6oUKp6QFhP/pB5nIAIkyzqp1/5FDouny6Z+ogGHJgpEKQU5HpEQA==
X-Received: by 2002:aa7:c3d9:0:b0:572:9b20:fd with SMTP id l25-20020aa7c3d9000000b005729b2000fdmr956990edr.31.1714479836546;
        Tue, 30 Apr 2024 05:23:56 -0700 (PDT)
Received: from [192.168.114.15] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id bq22-20020a056402215600b005722ce89ae2sm7404659edb.38.2024.04.30.05.23.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 05:23:56 -0700 (PDT)
Message-ID: <ebc8813c-74eb-49d1-b8d0-a6f1821f711a@linaro.org>
Date: Tue, 30 Apr 2024 14:23:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/7] iommu/dma: Centralise iommu_setup_dma_ops()
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "open list:DRM DRIVER FOR MSM ADRENO GPU" <linux-arm-msm@vger.kernel.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, Christoph Hellwig <hch@lst.de>,
 Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 Niklas Schnelle <schnelle@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1713523152.git.robin.murphy@arm.com>
 <bebea331c1d688b34d9862eefd5ede47503961b8.1713523152.git.robin.murphy@arm.com>
 <Zi_LV28TR-P-PzXi@eriador.lumag.spb.ru>
 <CAA8EJprL8NbNfOvp17hrHoVNkKBpD39xfeu+STm6m9VObF2n9Q@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <CAA8EJprL8NbNfOvp17hrHoVNkKBpD39xfeu+STm6m9VObF2n9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29.04.2024 11:26 PM, Dmitry Baryshkov wrote:
> On Mon, 29 Apr 2024 at 19:31, Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
>>
>> On Fri, Apr 19, 2024 at 05:54:45PM +0100, Robin Murphy wrote:
>>> It's somewhat hard to see, but arm64's arch_setup_dma_ops() should only
>>> ever call iommu_setup_dma_ops() after a successful iommu_probe_device(),
>>> which means there should be no harm in achieving the same order of
>>> operations by running it off the back of iommu_probe_device() itself.
>>> This then puts it in line with the x86 and s390 .probe_finalize bodges,
>>> letting us pull it all into the main flow properly. As a bonus this lets
>>> us fold in and de-scope the PCI workaround setup as well.
>>>
>>> At this point we can also then pull the call up inside the group mutex,
>>> and avoid having to think about whether iommu_group_store_type() could
>>> theoretically race and free the domain if iommu_setup_dma_ops() ran just
>>> *before* iommu_device_use_default_domain() claims it... Furthermore we
>>> replace one .probe_finalize call completely, since the only remaining
>>> implementations are now one which only needs to run once for the initial
>>> boot-time probe, and two which themselves render that path unreachable.
>>>
>>> This leaves us a big step closer to realistically being able to unpick
>>> the variety of different things that iommu_setup_dma_ops() has been
>>> muddling together, and further streamline iommu-dma into core API flows
>>> in future.
>>>
>>> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com> # For Intel IOMMU
>>> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>>> Tested-by: Hanjun Guo <guohanjun@huawei.com>
>>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>>> ---
>>> v2: Shuffle around to make sure the iommu_group_do_probe_finalize() case
>>>     is covered as well, with bonus side-effects as above.
>>> v3: *Really* do that, remembering the other two probe_finalize sites too.
>>> ---
>>>  arch/arm64/mm/dma-mapping.c  |  2 --
>>>  drivers/iommu/amd/iommu.c    |  8 --------
>>>  drivers/iommu/dma-iommu.c    | 18 ++++++------------
>>>  drivers/iommu/dma-iommu.h    | 14 ++++++--------
>>>  drivers/iommu/intel/iommu.c  |  7 -------
>>>  drivers/iommu/iommu.c        | 20 +++++++-------------
>>>  drivers/iommu/s390-iommu.c   |  6 ------
>>>  drivers/iommu/virtio-iommu.c | 10 ----------
>>>  include/linux/iommu.h        |  7 -------
>>>  9 files changed, 19 insertions(+), 73 deletions(-)
>>
>> This patch breaks UFS on Qualcomm SC8180X Primus platform:
>>
>>
>> [    3.846856] arm-smmu 15000000.iommu: Unhandled context fault: fsr=0x402, iova=0x1032db3e0, fsynr=0x130000, cbfrsynra=0x300, cb=4
>> [    3.846880] ufshcd-qcom 1d84000.ufshc: ufshcd_check_errors: saved_err 0x20000 saved_uic_err 0x0
>> [    3.846929] host_regs: 00000000: 1587031f 00000000 00000300 00000000
>> [    3.846935] host_regs: 00000010: 01000000 00010217 00000000 00000000
>> [    3.846941] host_regs: 00000020: 00000000 00070ef5 00000000 00000000
>> [    3.846946] host_regs: 00000030: 0000000f 00000001 00000000 00000000
>> [    3.846951] host_regs: 00000040: 00000000 00000000 00000000 00000000
>> [    3.846956] host_regs: 00000050: 032db000 00000001 00000000 00000000
>> [    3.846962] host_regs: 00000060: 00000000 80000000 00000000 00000000
>> [    3.846967] host_regs: 00000070: 032dd000 00000001 00000000 00000000
>> [    3.846972] host_regs: 00000080: 00000000 00000000 00000000 00000000
>> [    3.846977] host_regs: 00000090: 00000016 00000000 00000000 0000000c
>> [    3.847074] ufshcd-qcom 1d84000.ufshc: ufshcd_err_handler started; HBA state eh_fatal; powered 1; shutting down 0; saved_err = 131072; saved_uic_err = 0; force_reset = 0
>> [    4.406550] ufshcd-qcom 1d84000.ufshc: ufshcd_verify_dev_init: NOP OUT failed -11
>> [    4.417953] ufshcd-qcom 1d84000.ufshc: ufshcd_async_scan failed: -11
> 
> Just to confirm: reverting f091e93306e0 ("dma-mapping: Simplify
> arch_setup_dma_ops()") and b67483b3c44e ("iommu/dma: Centralise
> iommu_setup_dma_ops()" fixes the issue for me. Please ping me if you'd
> like me to test a fix.

This also triggers a different issue (that also comes down to "ufs bad") on
another QC platform (SM8550):

[    4.282098] scsi host0: ufshcd
[    4.315970] ufshcd-qcom 1d84000.ufs: ufshcd_check_errors: saved_err 0x20000 saved_uic_err 0x0
[    4.330155] host_regs: 00000000: 3587031f 00000000 00000400 00000000
[    4.343955] host_regs: 00000010: 01000000 00010217 00000000 00000000
[    4.356027] host_regs: 00000020: 00000000 00070ef5 00000000 00000000
[    4.370136] host_regs: 00000030: 0000000f 00000003 00000000 00000000
[    4.376662] host_regs: 00000040: 00000000 00000000 00000000 00000000
[    4.383192] host_regs: 00000050: 85109000 00000008 00000000 00000000
[    4.389719] host_regs: 00000060: 00000000 80000000 00000000 00000000
[    4.396245] host_regs: 00000070: 8510a000 00000008 00000000 00000000
[    4.402773] host_regs: 00000080: 00000000 00000000 00000000 00000000
[    4.409298] host_regs: 00000090: 00000016 00000000 00000000 0000000c
[    4.415900] arm-smmu 15000000.iommu: Unhandled context fault: fsr=0x402, iova=0x8851093e0, fsynr=0x3b0001, cbfrsynra=0x60, cb=2
[    4.416135] ufshcd-qcom 1d84000.ufs: ufshcd_err_handler started; HBA state eh_fatal; powered 1; shutting down 0; saved_err = 131072; saved_uic_err = 0; force_reset = 0
[    4.951750] ufshcd-qcom 1d84000.ufs: ufshcd_verify_dev_init: NOP OUT failed -11
[    4.960644] ufshcd-qcom 1d84000.ufs: ufshcd_async_scan failed: -11

Reverting the commits Dmitry mentioned also fixes this.

Konrad


