Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0924175ED8D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 10:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbjGXI2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 04:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbjGXI2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:28:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B958AE41
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 01:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690187252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=95yU/Tppmz3W6Wgx0aprDygFp+YkQiriuNqIdtc06vU=;
        b=Zak7PIYysqo4CaAQ7yW4R2bzNbHNS8dySIakA54msKMcwjk+yxN4CuSaTIbTWJkSE1h5YP
        RV5R5WwR3N2NnQAzYj7j0DTm9ryADz6pvNrFMP+JT5uMmEyn2wSZ8KJRcySXHMnFd9nerC
        N5Uf6bwQb68LJHTZcC66dezJz3Xt1wU=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-49HtO0IwMZmZOtvuXZw0aw-1; Mon, 24 Jul 2023 04:27:30 -0400
X-MC-Unique: 49HtO0IwMZmZOtvuXZw0aw-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-4fb7ea6652bso3497176e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 01:27:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690187249; x=1690792049;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=95yU/Tppmz3W6Wgx0aprDygFp+YkQiriuNqIdtc06vU=;
        b=b2QqUZ7BbghvIvVxQiLLeSI7bEF9AHUKJ9g4JZjRlnpm2VPvZw+SKAh4c5QHCIOsmd
         InAO9qr09lOMg+Hr9YzMS0ya98cBBE1KFjn+fwDAv0T55iXUXC2E+CAv3EDRXwyRiq2M
         omRbP014rpbrSwCP4jGBvW1VFIgS5to4BeyTIOXE+Fh9DCN1fs+bFzJT2BSdOCqTfAFj
         obdqbbBMb0z/+yWV2cXmtEBuXEPhEpo44KAjtJf1GlBDWw7cU/UwOO6/VqsNRLyqUPcQ
         c3eHVKGzRGO0VLqSw6cf0cAoOAWi28hkm1vGK5V25NVgactdeb+8YQwVCxtmLlBZsd6X
         kxOQ==
X-Gm-Message-State: ABy/qLYcpAhExwXdloeU+OCr+7xNYxGtKldUZttzDMnGbqPESflSvAuD
        DqbQUuP/GFicmATRUD1lx21iJfslyDjxSNa+IrbFmP1y/6aMYOiIZUEbt3gll/PyQ8KdscIPT57
        XlLT0JIg9GjlXZf6lZs46VaYB
X-Received: by 2002:ac2:505c:0:b0:4f8:5604:4b50 with SMTP id a28-20020ac2505c000000b004f856044b50mr4339165lfm.64.1690187249271;
        Mon, 24 Jul 2023 01:27:29 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHCEMOq1o4lei/ac0I0Ri//BOpQqln7ql1w8BcwesPNHuyuLe8cISemFtN93mHRCisihMVloA==
X-Received: by 2002:ac2:505c:0:b0:4f8:5604:4b50 with SMTP id a28-20020ac2505c000000b004f856044b50mr4339142lfm.64.1690187248874;
        Mon, 24 Jul 2023 01:27:28 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f45:d000:62f2:4df0:704a:e859? (p200300d82f45d00062f24df0704ae859.dip0.t-ipconnect.de. [2003:d8:2f45:d000:62f2:4df0:704a:e859])
        by smtp.gmail.com with ESMTPSA id s14-20020adfea8e000000b003143be36d99sm12106076wrm.58.2023.07.24.01.27.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 01:27:28 -0700 (PDT)
Message-ID: <c5944b74-db61-8383-cf15-13a9915ff7e5@redhat.com>
Date:   Mon, 24 Jul 2023 10:27:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 3/6] KVM: s390: interrupt: Fix single-stepping
 kernel-emulated instructions
Content-Language: en-US
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Sven Schnelle <svens@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Freimann <jfreimann@redhat.com>
References: <20230721120046.2262291-1-iii@linux.ibm.com>
 <20230721120046.2262291-4-iii@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230721120046.2262291-4-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.07.23 13:57, Ilya Leoshkevich wrote:
> Single-stepping a kernel-emulated instruction that generates an
> interrupt causes GDB to land on the instruction following it instead of
> the respective interrupt handler.
> 
> The reason is that kvm_handle_sie_intercept(), after injecting the
> interrupt, also processes the PER event and arranges a KVM_SINGLESTEP
> exit. The interrupt is not yet delivered, however, so the userspace
> sees the next instruction.
> 
> Fix by avoiding the KVM_SINGLESTEP exit when there is a pending
> interrupt. The next __vcpu_run() loop iteration will arrange a
> KVM_SINGLESTEP exit after delivering the interrupt.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   arch/s390/kvm/intercept.c | 17 ++++++++++++++---
>   1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
> index 7cdd927541b0..d2f7940c5d03 100644
> --- a/arch/s390/kvm/intercept.c
> +++ b/arch/s390/kvm/intercept.c
> @@ -583,6 +583,19 @@ static int handle_pv_notification(struct kvm_vcpu *vcpu)
>   	return handle_instruction(vcpu);
>   }
>   
> +static bool should_handle_per_ifetch(const struct kvm_vcpu *vcpu, int rc)
> +{
> +	/* Process PER, also if the instruction is processed in user space. */
> +	if (!(vcpu->arch.sie_block->icptstatus & 0x02))
> +		return false;
> +	if (rc != 0 && rc != -EOPNOTSUPP)
> +		return false;
> +	if (guestdbg_sstep_enabled(vcpu) && vcpu->arch.local_int.pending_irqs)
> +		/* __vcpu_run() will exit after delivering the interrupt. */
> +		return false;
> +	return true;
> +}
> +
>   int kvm_handle_sie_intercept(struct kvm_vcpu *vcpu)
>   {
>   	int rc, per_rc = 0;
> @@ -645,9 +658,7 @@ int kvm_handle_sie_intercept(struct kvm_vcpu *vcpu)
>   		return -EOPNOTSUPP;
>   	}
>   
> -	/* process PER, also if the instruction is processed in user space */
> -	if (vcpu->arch.sie_block->icptstatus & 0x02 &&
> -	    (!rc || rc == -EOPNOTSUPP))
> +	if (should_handle_per_ifetch(vcpu, rc))
>   		per_rc = kvm_s390_handle_per_ifetch_icpt(vcpu);
>   	return per_rc ? per_rc : rc;
>   }

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

