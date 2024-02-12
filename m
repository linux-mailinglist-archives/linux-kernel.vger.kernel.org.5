Return-Path: <linux-kernel+bounces-61400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 738698511E4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F06101F21859
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9454238DDB;
	Mon, 12 Feb 2024 11:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S/kLZ/F5"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9150028DDE
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 11:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707736201; cv=none; b=NZZq97I7vtzdr6hVlMbL2x5UtTyrW8fQPaM48Z9BC3b36Afdx62NFCsEKZj9ysm60MlMh8yVBWcYZ0Glew9ehlZ/FTs3JbJ0aVhqGo8QVmJqXqP34VLqN8oubYV8y8rM5iKzvs4i1qJgKSAQzo4qKL2RpRnEu9ALnQc+hEpEvE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707736201; c=relaxed/simple;
	bh=yAgrAtxt8BCNU0tIwcYM1Jelk8Vrb3AgxbH5KtMyk0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ir3n1GDttla0SSB6Tk+GJ9pfJKIyhkkylk4X3v2Tj9+2GPMYH7XRwJlPcEmVIm/naMf2cedaLPLSQWmdXAS8Aa0FBBzXmZbeZgEZdizzES59qlREFAF3uqM9T3WHOBywiymvuGvnFzOTx3CAKoznvZAgnjUf4nzdXrnsFAEjak8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S/kLZ/F5; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a3122b70439so383411166b.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 03:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707736198; x=1708340998; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h2ngoHXJTjU4oIVSvKbQ+GmXKxLqsTRTMTkcPaRKNIY=;
        b=S/kLZ/F5XQ5Cn9bL7nLx9t3O6TyBcg+LEqa8KKuDexemW8/evasu4AV/wl6icggOD5
         2s7PrTqUvSwRFSc25LsMwu8J2hJIwzS3O7j5gaSx9CSHm22kjLM3zmwvaNXVMsjbEndY
         zEocabjjwcAspCiPvaW1kECelBYxm5iCqE/1nk3ySNw+YMVbpwIMboyUoXozTo10OLMM
         WfN2OEK3iAIPDy0gGFX+To8s8d1fF05Hhxp/CDd7/dCNHgv5q4sjno6Ykmsnj3SrWrOl
         NDF7CcZ21qotbeaOeCybu68VLmNdvWFGCPLh0pGedapqz2h2UXx1YK52AxOTaSofgRN8
         Fnqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707736198; x=1708340998;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h2ngoHXJTjU4oIVSvKbQ+GmXKxLqsTRTMTkcPaRKNIY=;
        b=fg1SEkZVa2NFfqVX7dyd5e7FIJtlGO1m5T3BlUsgN/fzzqpigQGs1WO6rmBJ/aQZ6W
         MnQKoxFJJi4YbLh1Msgad9Pk1oWTxuGekvTCdT/acIec/FWj4yatoumDUqlDDV3rmUxF
         iIL+MhswAbEZ7ar2dk1oxmvG0ZQvYlQh+RCLl0CgO/iJ7s703ZKxXZcN/nuaRis+cZMs
         J+Gz0CsmDKoS5eYIAbSixieCi1NcPo8jw05FxVvlVf12jOduEiPqbKhe+6leI8SsgSad
         voF+XjuqxohDYSOhJYedolXCBCLPIaNnzrt7Df15BpBkffqE3UgCKy7z5UI9IKHdvclp
         ewGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkCqQBGSdgfZ/VoqxXSDpo6jLzSs0R9Tjrdw75ikmd7lGnP72ek73JBtCkH97ZtylutOjL5JL4Jaz2Fnq0tigp65vJVfNAuMkH5S+i
X-Gm-Message-State: AOJu0YwhfdVwSV0cXHreyc/XArXuEuO7+3m7lUckBrNtvjluHD41DNq4
	TsEqobFpeqy3CAWQSK7hmYQscpp3qcPOTW5uFHfBx+VnpAVRALX6qi/z0ydJhBA=
X-Google-Smtp-Source: AGHT+IExp1x2u3U5MtL0BwOkp0z38bW+A3nYjV5W1rsYK4V5VsUVQ7Y5U5EqPYfyv4fjcY701eFI5A==
X-Received: by 2002:a17:906:a407:b0:a3c:15ea:8afb with SMTP id l7-20020a170906a40700b00a3c15ea8afbmr4493145ejz.58.1707736197782;
        Mon, 12 Feb 2024 03:09:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUwFgQQd80vaQQEvTxzSj4OhzD5qhUoW1VVaQEETbeACUR+xkcD2YcmAwiDnsO4pk35F6aPiezR49rRTKFQjBLYe87SU6Lf3wNN2/uzM1F9Y8fMUg9gKH23cSZOJEqbzWkS7TPFQxdxCfRZtU1xe+6GWhBmIqnKi6oMtGfbtAcujpfNqcgB/qCwx4i4e3+vVCJLk3UPGQjlGTBbfl21PvDxvXB2JlD+1k+NvIFfCt6rTipSg0Fqh7xI53fO9/MJzRbWpniCDYskfVf7y9f+dOlI8OgcAaabAGqeM0JEQE2eP24e1NsXb+IUNhRmcpwHO66XKcRnVO2E6oQPxp6ZqaC25DNQZuWFzxW1CL7Rn9lFQzWjJ+ZrllzTj8WtRelYq62ocQAohReVML1ZyRXP12sUi0SJnoRFjT2+EKVOBf7jng==
Received: from [192.168.192.135] (037008245233.garwolin.vectranet.pl. [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id z11-20020a170906074b00b00a3a40b7ecdbsm99569ejb.69.2024.02.12.03.09.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 03:09:57 -0800 (PST)
Message-ID: <b65d6328-e7bd-4752-a82f-36323b41ef13@linaro.org>
Date: Mon, 12 Feb 2024 12:09:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: qcom_scm: Introduce batching of hyp assign
 calls
Content-Language: en-US
To: Dibakar Singh <quic_dibasing@quicinc.com>, andersson@kernel.org,
 krzysztof.kozlowski@linaro.org, luzmaximilian@gmail.com,
 bartosz.golaszewski@linaro.org, quic_gurus@quicinc.com,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 quic_guptap@quicinc.com, quic_pkondeti@quicinc.com, quic_pheragu@quicinc.com
References: <20240209112536.2262967-1-quic_dibasing@quicinc.com>
 <7fhl7uvhl26whumcl3f5hxflczws67lg3yq4gb5fyrig2ziux6@chft6orl6xne>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <7fhl7uvhl26whumcl3f5hxflczws67lg3yq4gb5fyrig2ziux6@chft6orl6xne>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9.02.2024 19:06, Elliot Berman wrote:
> On Fri, Feb 09, 2024 at 04:55:36PM +0530, Dibakar Singh wrote:
>> Expose an API qcom_scm_assign_table to allow client drivers to batch
>> multiple memory regions in a single hyp assign call.
>>
>> In the existing situation, if our goal is to process an sg_table and
>> transfer its ownership from the current VM to a different VM, we have a
>> couple of strategies. The first strategy involves processing the entire
>> sg_table at once and then transferring the ownership. However, this
>> method may have an adverse impact on the system because during an SMC
>> call, the NS interrupts are disabled, and this delay could be
>> significant when dealing with large sg_tables. To address this issue, we
>> can adopt a second strategy, which involves processing each sg_list in
>> the sg_table individually and reassigning memory ownership. Although
>> this method is slower and potentially impacts performance, it will not
>> keep the NS interrupts disabled for an extended period.
>>
>> A more efficient strategy is to process the sg_table in batches. This
>> approach addresses both scenarios by involving memory processing in
>> batches, thus avoiding prolonged NS interrupt disablement for longer
>> duration when dealing with large sg_tables. Moreover, since we process
>> in batches, this method is faster compared to processing each item
>> individually. The observations on testing both the approaches for
>> performance is as follows:
>>
>> Allocation Size/            256MB            512MB            1024MB
>> Algorithm Used           ===========      ===========      ============
>>
>> Processing each sg_list   73708(us)        149289(us)       266964(us)
>> in sg_table one by one
>>
>> Processing sg_table in    46925(us)         92691(us)       176893(us)
>> batches
>>
>> This implementation serves as a wrapper around the helper function
>> __qcom_scm_assign_mem, which takes an sg_list and processes it in
>> batches. We’ve set the limit to a minimum of 32 sg_list in a batch or a
>> total batch size of 512 pages. The selection of these numbers is
>> heuristic, based on the test runs conducted. Opting for a smaller number
>> would compromise performance, while a larger number would result in
>> non-secure interrupts being disabled for an extended duration.
>>
>> Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
>> Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
>> Signed-off-by: Dibakar Singh <quic_dibasing@quicinc.com>
>> ---
>>  drivers/firmware/qcom/qcom_scm.c       | 211 +++++++++++++++++++++++++
>>  include/linux/firmware/qcom/qcom_scm.h |   7 +
>>  2 files changed, 218 insertions(+)
>>
>> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
>> index 520de9b5633a..038b96503d65 100644
>> --- a/drivers/firmware/qcom/qcom_scm.c
>> +++ b/drivers/firmware/qcom/qcom_scm.c
>> @@ -21,6 +21,8 @@
>>  #include <linux/platform_device.h>
>>  #include <linux/reset-controller.h>
>>  #include <linux/types.h>
>> +#include <linux/scatterlist.h>
>> +#include <linux/slab.h>
>>  
>>  #include "qcom_scm.h"
>>  
>> @@ -1048,6 +1050,215 @@ int qcom_scm_assign_mem(phys_addr_t mem_addr, size_t mem_sz,
>>  }
>>  EXPORT_SYMBOL_GPL(qcom_scm_assign_mem);
>>  
>> +/**
>> + * qcom_scm_assign_mem_batch() - Make a secure call to reassign memory
>> + *				   ownership of several memory regions
>> + * @mem_regions:    A buffer describing the set of memory regions that need to
>> + *		    be reassigned
>> + * @nr_mem_regions: The number of memory regions that need to be reassigned
>> + * @srcvms:	    A buffer populated with he vmid(s) for the current set of
>> + *		    owners
>> + * @src_sz:	    The size of the srcvms buffer (in bytes)
>> + * @destvms:	    A buffer populated with the new owners and corresponding
>> + *		    permission flags.
>> + * @dest_sz:	    The size of the destvms buffer (in bytes)
>> + *
>> + * Return negative errno on failure, 0 on success.
>> + */
>> +static int qcom_scm_assign_mem_batch(struct qcom_scm_mem_map_info *mem_regions,
>> +				     size_t nr_mem_regions, u32 *srcvms,
>> +				     size_t src_sz,
>> +				     struct qcom_scm_current_perm_info *destvms,
>> +				     size_t dest_sz)
>> +{
>> +	dma_addr_t mem_dma_addr;
>> +	size_t mem_regions_sz;
>> +	int ret = 0, i;
>> +
>> +	for (i = 0; i < nr_mem_regions; i++) {
>> +		mem_regions[i].mem_addr = cpu_to_le64(mem_regions[i].mem_addr);
>> +		mem_regions[i].mem_size = cpu_to_le64(mem_regions[i].mem_size);
>> +	}
>> +
>> +	mem_regions_sz = nr_mem_regions * sizeof(*mem_regions);
>> +	mem_dma_addr = dma_map_single(__scm->dev, mem_regions, mem_regions_sz,
>> +				      DMA_TO_DEVICE);
>> +	if (dma_mapping_error(__scm->dev, mem_dma_addr)) {
>> +		dev_err(__scm->dev, "mem_dma_addr mapping failed\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	ret = __qcom_scm_assign_mem(__scm->dev, virt_to_phys(mem_regions),
>> +				    mem_regions_sz, virt_to_phys(srcvms), src_sz,
>> +				    virt_to_phys(destvms), dest_sz);
>> +
>> +	dma_unmap_single(__scm->dev, mem_dma_addr, mem_regions_sz, DMA_TO_DEVICE);
>> +	return ret;
>> +}
>> +
>> +/**
>> + * qcom_scm_prepare_mem_batch() - Prepare batches of memory regions
>> + * @sg_table:       A scatter list whose memory needs to be reassigned
>> + * @srcvms:	    A buffer populated with he vmid(s) for the current set of
>> + *		    owners
>> + * @nr_src:	    The number of the src_vms buffer
>> + * @destvms:	    A buffer populated with he vmid(s) for the new owners
>> + * @destvms_perms:  A buffer populated with the permission flags of new owners
>> + * @nr_dest:	    The number of the destvms
>> + * @last_sgl:	    Denotes to the last scatter list element. Used in case of rollback
>> + * @roll_back:	    Identifies whether we are executing rollback in case of failure
>> + *
>> + * Return negative errno on failure, 0 on success.
>> + */
>> +static int qcom_scm_prepare_mem_batch(struct sg_table *table,
>> +				      u32 *srcvms, int nr_src,
>> +				      int *destvms, int *destvms_perms,
>> +				      int nr_dest,
>> +				      struct scatterlist *last_sgl, bool roll_back)
>> +{
>> +	struct qcom_scm_current_perm_info *destvms_cp;
>> +	struct qcom_scm_mem_map_info *mem_regions_buf;
>> +	struct scatterlist *curr_sgl = table->sgl;
>> +	dma_addr_t source_dma_addr, dest_dma_addr;
>> +	size_t batch_iterator;
>> +	size_t batch_start = 0;
>> +	size_t destvms_cp_sz;
>> +	size_t srcvms_cp_sz;
>> +	size_t batch_size;
>> +	u32 *srcvms_cp;
>> +	int ret = 0;
>> +	int i;
>> +
>> +	if (!table || !table->sgl || !srcvms || !nr_src ||
>> +	    !destvms || !destvms_perms || !nr_dest || !table->nents)
>> +		return -EINVAL;
>> +
>> +	srcvms_cp_sz = sizeof(*srcvms_cp) * nr_src;
>> +	srcvms_cp = kmemdup(srcvms, srcvms_cp_sz, GFP_KERNEL);
>> +	if (!srcvms_cp)
>> +		return -ENOMEM;
>> +
>> +	for (i = 0; i < nr_src; i++)
>> +		srcvms_cp[i] = cpu_to_le32(srcvms_cp[i]);
>> +
>> +	source_dma_addr = dma_map_single(__scm->dev, srcvms_cp,
>> +					 srcvms_cp_sz, DMA_TO_DEVICE);
> 
> Please use the new tzmem allocator:
> 
> https://lore.kernel.org/all/20240205182810.58382-1-brgl@bgdev.pl/

And the new __free annotations, please

Konrad

