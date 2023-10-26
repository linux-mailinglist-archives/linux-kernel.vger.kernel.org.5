Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978B17D83ED
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 15:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345123AbjJZNy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 09:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjJZNy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 09:54:56 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C4A183
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 06:54:53 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9bf86b77a2aso140195066b.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 06:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1698328492; x=1698933292; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=RL5osrDEQ87n/4mThputqqQ15jh3fPvDrdMpkrMYZwo=;
        b=R2Bcpb8VHK3+4AB3rOmAVJ+zQi8ltXZ7ckT/XbBmbeN2R5R2FFPxLZwSoEWLwlEEKN
         f9RrDNmDeYIk0lFWiFn5/Uls88K6eWKKq0ED72KVYqDOTHIovFhMPvqtTpTYR7O/fM6+
         um6qpDyG+/YIUXj6YoB0aIvuVlqv3utQYfmtIFBIRJSBPAKVihD/Xlak8pTZyJ024U8c
         bOehicuVlfj6c7IJ6OA1aO07AlSErcx0Y+ISCJNnCXPYmLbzpu+ZD1sSa3+R9vFkHDYq
         hEal+o46rYcZZTU1u6wEaGz7cBFhWT+T8I3Ff6BR2bSSd+AF+MP9jiNWYkf2gl9f/Jgp
         RMKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698328492; x=1698933292;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RL5osrDEQ87n/4mThputqqQ15jh3fPvDrdMpkrMYZwo=;
        b=tHfh8ZBu4Ut2V1SJyHeNdsZC2ORQ8AqwGDX37OsCN4uA2Lsx3Gb0p1xR0UYMgzVJd7
         jym5DIIbiRFTXNZDShbjnH1bM/OfdzAg7BYZya25VGRvMy/mh8G5L9XsHx18OEfRn5VU
         HUCp3bV74a6idL90E2N0RpYnWnCfxNpOeHGlwwCJUPSd96fdsIgRVg29pk4nzwXF7y48
         4zb/yCnxEGd1QDBriJHehp/TcXnbE3bA6PXOnC7uXG9agAko2i7DcIToOA4IBYtqIO4n
         5xVe41It1Q+f7wBJCCioRd1jiFWK16zjBQFHwiY9xmm5gZwgOG4Wa3OsjqaVB/Xz0b6G
         mM2A==
X-Gm-Message-State: AOJu0YzL6vBXMcO/xs/d1xtrc0liq2g/S+e2ub1REiPhqJezTntdtDjA
        Xz2mcVdJ5mm2GEP1HygfTDY7vlC31umTck+c5LQcpw==
X-Google-Smtp-Source: AGHT+IGr4iHSMTDRLESyOEUBRzMl2gH1lhsl3OcVRqPecIknF2GaTqvf5/BxfyUMFmE2vm3zHsqpAA==
X-Received: by 2002:a17:907:72c2:b0:9be:a2b6:7eae with SMTP id du2-20020a17090772c200b009bea2b67eaemr15232590ejc.52.1698328491735;
        Thu, 26 Oct 2023 06:54:51 -0700 (PDT)
Received: from cloudflare.com (79.184.154.62.ipv4.supernova.orange.pl. [79.184.154.62])
        by smtp.gmail.com with ESMTPSA id o14-20020a17090611ce00b009b29553b648sm11586157eja.206.2023.10.26.06.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 06:54:51 -0700 (PDT)
References: <20231025141517.375378-1-jakub@cloudflare.com>
 <878r7q5upq.ffs@tglx>
User-agent: mu4e 1.6.10; emacs 28.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] genirq: Own affinity hint
Date:   Thu, 26 Oct 2023 15:05:26 +0200
In-reply-to: <878r7q5upq.ffs@tglx>
Message-ID: <871qdh32vp.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 10:10 PM +02, Thomas Gleixner wrote:
> On Wed, Oct 25 2023 at 16:15, Jakub Sitnicki wrote:
>> @@ -55,26 +55,33 @@ static int alloc_masks(struct irq_desc *desc, int node)
>>  {
>>  	if (!zalloc_cpumask_var_node(&desc->irq_common_data.affinity,
>>  				     GFP_KERNEL, node))
>> -		return -ENOMEM;
>> +		goto err_affinity;
>> +	if (!zalloc_cpumask_var_node(&desc->irq_common_data.affinity_hint,
>> +				     GFP_KERNEL, node))
>
> This gets allocated for every interrupt descriptor but only a few or
> even none will ever use it. Seriously no.

Makes sense. I wanted to start the simplest possible approach first.
I expect allocating it lazily will be more involved - have to cover the
not-allocated case.

But thinking about it some more - perhaps what makes more sense is, for
irq_set_affinity[_and]_hint users who don't want to bother with managing
a cpumask on their side, to switch to irq_set_affinity.

That interface doesn't require the cpumask to outlive the call, AFAICT.

After all, setting the affinity hint only buys you an ability to read it
out from /proc/irq/<N>/affinity_hint. Same information is available from
/proc/irq/<N>/smp_affinity. Please set me straight, if I'm missing
something here.

>
>> +		goto err_affinity_hint;
>>  
>>  #ifdef CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK
>>  	if (!zalloc_cpumask_var_node(&desc->irq_common_data.effective_affinity,
>> -				     GFP_KERNEL, node)) {
>> -		free_cpumask_var(desc->irq_common_data.affinity);
>> -		return -ENOMEM;
>> -	}
>> +				     GFP_KERNEL, node))
>> +		goto err_effective_affinity;
>>  #endif
>>  
>>  #ifdef CONFIG_GENERIC_PENDING_IRQ
>> -	if (!zalloc_cpumask_var_node(&desc->pending_mask, GFP_KERNEL, node)) {
>> -#ifdef CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK
>> -		free_cpumask_var(desc->irq_common_data.effective_affinity);
>> -#endif
>> -		free_cpumask_var(desc->irq_common_data.affinity);
>> -		return -ENOMEM;
>> -	}
>> +	if (!zalloc_cpumask_var_node(&desc->pending_mask, GFP_KERNEL, node))
>> +		goto err_pending_mask;
>>  #endif
>>  	return 0;
>> +
>> +err_pending_mask:
>
> How is this supposed to compile with CONFIG_GENERIC_PENDING_IRQ=n ?
>
>> +#ifdef CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK
>> +	free_cpumask_var(desc->irq_common_data.effective_affinity);
>> +#endif
>> +err_effective_affinity:
>
> and this with CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=n ?

If it wasn't for the unused label (my bad) both cases LGTM.

But I double checked. If I force feed it through the preprocessor:

* CONFIG_GENERIC_PENDING_IRQ=n :

static int alloc_masks(struct irq_desc *desc, int node)
{
 if (!zalloc_cpumask_var_node(&desc->irq_common_data.affinity,
         ((( gfp_t)(0x400u|0x800u)) | (( gfp_t)0x40u) | (( gfp_t)0x80u)), node))
  goto err_affinity;
 if (!zalloc_cpumask_var_node(&desc->irq_common_data.affinity_hint,
         ((( gfp_t)(0x400u|0x800u)) | (( gfp_t)0x40u) | (( gfp_t)0x80u)), node))
  goto err_affinity_hint;
 if (!zalloc_cpumask_var_node(&desc->irq_common_data.effective_affinity,
         ((( gfp_t)(0x400u|0x800u)) | (( gfp_t)0x40u) | (( gfp_t)0x80u)), node))
  goto err_effective_affinity;
 return 0;
err_pending_mask:
 free_cpumask_var(desc->irq_common_data.effective_affinity);
err_effective_affinity:
 free_cpumask_var(desc->irq_common_data.affinity_hint);
err_affinity_hint:
 free_cpumask_var(desc->irq_common_data.affinity);
err_affinity:
 return -12;
}

* CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=n :

static int alloc_masks(struct irq_desc *desc, int node)
{
 if (!zalloc_cpumask_var_node(&desc->irq_common_data.affinity,
         ((( gfp_t)(0x400u|0x800u)) | (( gfp_t)0x40u) | (( gfp_t)0x80u)), node))
  goto err_affinity;
 if (!zalloc_cpumask_var_node(&desc->irq_common_data.affinity_hint,
         ((( gfp_t)(0x400u|0x800u)) | (( gfp_t)0x40u) | (( gfp_t)0x80u)), node))
  goto err_affinity_hint;
 if (!zalloc_cpumask_var_node(&desc->pending_mask,
         ((( gfp_t)(0x400u|0x800u)) | (( gfp_t)0x40u) | (( gfp_t)0x80u)), node))
  goto err_pending_mask;
 return 0;
err_pending_mask:
err_effective_affinity:
 free_cpumask_var(desc->irq_common_data.affinity_hint);
err_affinity_hint:
 free_cpumask_var(desc->irq_common_data.affinity);
err_affinity:
 return -12;
}

I did forget, however, to clean up the "old" affinity_hint field from
irq_desc struct.

Anyway - not planning on sending a v2, unless you see value in doing a
lazy allocation of the hint from within irq subsys.

Thanks for feedback.
