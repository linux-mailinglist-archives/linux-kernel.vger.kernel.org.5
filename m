Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549B3802F52
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjLDJxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 04:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjLDJxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 04:53:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D20D6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 01:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701683592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WqARk7fzedhZASB+ixpYpvasPr2FrtXK3g7WtNb8hEQ=;
        b=OpqegxrMOzV0ZkqgflZp7I31dVpAAHjTHkc1daW2mXLqrR2dA751zHRJTAAc1cNH+JvG3c
        DuUwa+k1d0S08pzOwynmR4MK4CtfOPYONg2yfPQMX8vrGCcCOWluyiND+oJTbfVDRh8Fmn
        Q9VJwc15M+5SmKkO+nrmWd3JuLLCguU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-DXcroBGOMK2mGA6pGqSkKA-1; Mon, 04 Dec 2023 04:53:08 -0500
X-MC-Unique: DXcroBGOMK2mGA6pGqSkKA-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5411d71889aso3253626a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 01:53:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701683587; x=1702288387;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WqARk7fzedhZASB+ixpYpvasPr2FrtXK3g7WtNb8hEQ=;
        b=gBDK8yKeTL5+4Vz4gZhUsAIEVs2GsB97h/7AcZnsDQzrnVJmEYvsi+ibw9mt1YOEmQ
         1oygZl7szqL0bLkhoRnn1I7y4uc2UPwAcM/Ydh5WLr+k4DwAACnCxbvuSEX5rLpL/DNg
         cWJ+M5Vzgi2bIf6rn/DsVMys/cNHCjbrBoamAO14kKeerhClhi3Z/bpXGB5uTdy5tH5F
         IJGRVwoirYsyg7lHIwGWjaGRbqTzd3YpTXLk9tIC6tu7Judh50W1dMYV+J4RVM+ajO6x
         WyIAlrbnEDQ6JhbFRMpgW71d8tgcUap1IqfJDm0lIg+9cAVaayPIysvQ86SxRaVJl1Lo
         Mpqg==
X-Gm-Message-State: AOJu0YzxWaImUbDq1TgjX1T0CgkIA0dmUFy+GRxwHRKpr2J2yHmtZHey
        5pPacy46zYGhuEzxdHXyfphbvqoL/KFHVW3eouQ464GsWPV8qWcoaYfQHlfK9P3bXdLhJ9taKYY
        lzoBvsRbUqfk3AaiInJhgFb6Z
X-Received: by 2002:a50:f60d:0:b0:54c:f3fe:b724 with SMTP id c13-20020a50f60d000000b0054cf3feb724mr153237edn.34.1701683587631;
        Mon, 04 Dec 2023 01:53:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF04QieaiEA7DXjahNmUbcVj8SS98n8SEAEc72dIfo2YTSyeHeRT8v2xB10JSGbm972QJhB8g==
X-Received: by 2002:a50:f60d:0:b0:54c:f3fe:b724 with SMTP id c13-20020a50f60d000000b0054cf3feb724mr153211edn.34.1701683587289;
        Mon, 04 Dec 2023 01:53:07 -0800 (PST)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id a94-20020a509ee7000000b0054c9df4317dsm2169119edf.7.2023.12.04.01.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 01:53:06 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>, Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: Re: [PATCH v2 13/35] KVM: x86: hyper-v: optimize and cleanup
 kvm_hv_process_stimers()
In-Reply-To: <20231203193307.542794-12-yury.norov@gmail.com>
References: <20231203192422.539300-1-yury.norov@gmail.com>
 <20231203193307.542794-1-yury.norov@gmail.com>
 <20231203193307.542794-12-yury.norov@gmail.com>
Date:   Mon, 04 Dec 2023 10:53:05 +0100
Message-ID: <87h6kymgzi.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yury Norov <yury.norov@gmail.com> writes:

> The function traverses stimer_pending_bitmap in a for-loop bit by bit.
> We can do it faster by using atomic find_and_set_bit().
>
> While here, refactor the logic by decreasing indentation level.
>
> CC: Vitaly Kuznetsov <vkuznets@redhat.com>
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  arch/x86/kvm/hyperv.c | 39 +++++++++++++++++++--------------------
>  1 file changed, 19 insertions(+), 20 deletions(-)
>
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index 238afd7335e4..a0e45d20d451 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -870,27 +870,26 @@ void kvm_hv_process_stimers(struct kvm_vcpu *vcpu)
>  	if (!hv_vcpu)
>  		return;
>  
> -	for (i = 0; i < ARRAY_SIZE(hv_vcpu->stimer); i++)
> -		if (test_and_clear_bit(i, hv_vcpu->stimer_pending_bitmap)) {
> -			stimer = &hv_vcpu->stimer[i];
> -			if (stimer->config.enable) {
> -				exp_time = stimer->exp_time;
> -
> -				if (exp_time) {
> -					time_now =
> -						get_time_ref_counter(vcpu->kvm);
> -					if (time_now >= exp_time)
> -						stimer_expiration(stimer);
> -				}
> -
> -				if ((stimer->config.enable) &&
> -				    stimer->count) {
> -					if (!stimer->msg_pending)
> -						stimer_start(stimer);
> -				} else
> -					stimer_cleanup(stimer);
> -			}
> +	for_each_test_and_clear_bit(i, hv_vcpu->stimer_pending_bitmap,
> +					ARRAY_SIZE(hv_vcpu->stimer)) {
> +		stimer = &hv_vcpu->stimer[i];
> +		if (!stimer->config.enable)
> +			continue;
> +
> +		exp_time = stimer->exp_time;
> +
> +		if (exp_time) {
> +			time_now = get_time_ref_counter(vcpu->kvm);
> +			if (time_now >= exp_time)
> +				stimer_expiration(stimer);
>  		}
> +
> +		if (stimer->config.enable && stimer->count) {
> +			if (!stimer->msg_pending)
> +				stimer_start(stimer);
> +		} else
> +			stimer_cleanup(stimer);

Minor nitpick: it's better (and afair required by coding style) to use
'{}' for both branches here:

	if (stimer->config.enable && stimer->count) {
		if (!stimer->msg_pending)
			stimer_start(stimer);
	} else {
		stimer_cleanup(stimer);
	}

> +	}
>  }
>  
>  void kvm_hv_vcpu_uninit(struct kvm_vcpu *vcpu)

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

