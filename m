Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6BF7B7B4D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 11:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241973AbjJDJKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 05:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241966AbjJDJKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 05:10:30 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F16BB
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 02:10:25 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-533c8f8f91dso3247145a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 02:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696410624; x=1697015424; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9T6JjI7drWgvRRXYPgb2KLbZPlJFvP44AhAzPqww2Ls=;
        b=cVkFfrzWdXjMqFW7fFQ9UsmjyxTzxkmIe0k+aPUtF+RftYVMjHtkU6WrfN1BPH6ihC
         XpP2S8uaTtx0oYQYTImAZYqnM+sO6jPehcgYDiaYBojm+ZJosIJp8S4ANO7WFJnw9Epa
         Pc0CvXDCpuJgf8GLCI+q9NjIxw2G80IbVQoFYbDmjLthB0py17SwCuYO4+VUpfY0SiBW
         aoSR5GrvP9CaQt+JinDaA63COJ0fUXoR3zyRPkCWInQN/3MUpA4SgiRzfD68dGRZFFfc
         Rn2OlhSdN0yeZqD8lWxWB4tsCy+BCpmvaoqqbDz0GwrWYndLjUH2jBjCrOZnSyaNyxqw
         9SDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696410624; x=1697015424;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9T6JjI7drWgvRRXYPgb2KLbZPlJFvP44AhAzPqww2Ls=;
        b=wYXRCWloD8lioLdC7Rv8k+KsedCUsvWwu5Mu49890X3AasF873H1sN7dj/XKDNCysS
         C+l6CpSrzVYpadQFmHyMFX4hZEf65YT7SREWYcS8ctTqQ3CCw2QfpioPtHWO/0KuYRHx
         VQTqU05FfV94BfNk0SmI3vQEs/cX+6Ag8Vyh79Urw644xEDUwRbttVyJgA9wura0rydO
         11sYVBuwgMI6jZuTPLde/nIDbPs2snWvtgzK5OGEKgDw8G7jzabysAlpgWGW2oKXrdxy
         a8WwccdkdJx65PB+OJRT34liqjjnsT837Y8gyAUJIDDY7giBWtfLEhMntq0AA1VjPy++
         2Sew==
X-Gm-Message-State: AOJu0YwCQyXZ2wZlXHKPodMyD3+4hMoZMRkt6TZtb8dUhx46kNsP0jqH
        bfKEVOeVgd9QRjpBH+b7V/1gUg==
X-Google-Smtp-Source: AGHT+IFWb2wXrOaI1fLRqOC3q72ZyvU7YPqW/UnhUc0jcobnUQSs+t4/GnxNr9CRVEfecMe3eKL5RA==
X-Received: by 2002:aa7:cfd2:0:b0:534:6668:605b with SMTP id r18-20020aa7cfd2000000b005346668605bmr1407846edy.22.1696410623755;
        Wed, 04 Oct 2023 02:10:23 -0700 (PDT)
Received: from rayden (h-46-59-78-111.A175.priv.bahnhof.se. [46.59.78.111])
        by smtp.gmail.com with ESMTPSA id d18-20020a50fb12000000b0053801ca9a09sm2110849edq.33.2023.10.04.02.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 02:10:23 -0700 (PDT)
Date:   Wed, 4 Oct 2023 11:10:21 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marc Bonnici <marc.bonnici@arm.com>,
        Coboy Chen <coboy.chen@mediatek.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Olivier Deprez <olivier.deprez@arm.com>
Subject: Re: [PATCH v3 07/17] firmware: arm_ffa: Implement the
 NOTIFICATION_INFO_GET interface
Message-ID: <20231004091021.GA1091193@rayden>
References: <20230929-ffa_v1-1_notif-v3-0-c8e4f15190c8@arm.com>
 <20230929-ffa_v1-1_notif-v3-7-c8e4f15190c8@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230929-ffa_v1-1_notif-v3-7-c8e4f15190c8@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 04:02:56PM +0100, Sudeep Holla wrote:
> The receiver’s scheduler uses the FFA_NOTIFICATION_INFO_GET interface
> to retrieve the list of endpoints that have pending notifications and
> must be run. A notification could be signaled by a sender in the secure
> world to a VM. The Hypervisor needs to determine which VM and vCPU
> (in case a per-vCPU notification is signaled) has a pending notification
> in this scenario. It must obtain this information through an invocation
> of the FFA_NOTIFICATION_INFO_GET.
> 
> Add the implementation of the NOTIFICATION_INFO_GET interface
> and prepare to use this to handle the schedule receiver interrupt.
> Implementation of handling notifications will be added later.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/firmware/arm_ffa/driver.c | 70 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
> 
> diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
> index 02eedb7bc171..dfeeb751bebe 100644
> --- a/drivers/firmware/arm_ffa/driver.c
> +++ b/drivers/firmware/arm_ffa/driver.c
> @@ -602,6 +602,13 @@ static int ffa_notification_bitmap_destroy(void)
>  	(FIELD_PREP(RECEIVER_VCPU_MASK, (vcpu_r)) | \
>  	 FIELD_PREP(RECEIVER_ID_MASK, (r)))
>  
> +#define NOTIFICATION_INFO_GET_MORE_PEND_MASK	BIT(0)
> +#define NOTIFICATION_INFO_GET_ID_COUNT		GENMASK(11, 7)
> +#define ID_LIST_MASK_64				GENMASK(51, 12)
> +#define ID_LIST_MASK_32				GENMASK(31, 12)
> +#define MAX_IDS_64				20
> +#define MAX_IDS_32				10
> +
>  static int ffa_notification_bind_common(u16 dst_id, u64 bitmap,
>  					u32 flags, bool is_bind)
>  {
> @@ -673,6 +680,69 @@ static int ffa_notification_get(u32 flags, struct ffa_notify_bitmaps *notify)
>  	return 0;
>  }
>  
> +static void __do_sched_recv_cb(u16 partition_id, u16 vcpu, bool is_per_vcpu)
> +{
> +	pr_err("Callback for partition 0x%x failed.\n", partition_id);
> +}
> +
> +static void ffa_notification_info_get(bool is_64b)
> +{
> +	int idx, list, max_ids, lists_cnt, ids_processed, ids_count[MAX_IDS_64];
> +	ffa_value_t ret;
> +	u64 id_list;
> +
> +	do {
> +		invoke_ffa_fn((ffa_value_t){
> +			  .a0 = FFA_FN_NATIVE(NOTIFICATION_INFO_GET),
> +			  }, &ret);
> +
> +		if (ret.a0 != FFA_FN_NATIVE(SUCCESS)) {

The specification doesn't require a response using 64-bit SMCCC, it is
valid to respond using 32-bit SMCCC too.

Thanks,
Jens

> +			if (ret.a2 != FFA_RET_NO_DATA)
> +				pr_err("Notification Info fetch failed: 0x%lx (0x%lx)",
> +				       ret.a0, ret.a2);
> +			return;
> +		}
> +
> +		ids_processed = 0;
> +		lists_cnt = FIELD_GET(NOTIFICATION_INFO_GET_ID_COUNT, ret.a2);
> +		if (is_64b) {
> +			max_ids = MAX_IDS_64;
> +			id_list = FIELD_GET(ID_LIST_MASK_64, ret.a2);
> +		} else {
> +			max_ids = MAX_IDS_32;
> +			id_list = FIELD_GET(ID_LIST_MASK_32, ret.a2);
> +		}
> +
> +		for (idx = 0; idx < lists_cnt; idx++, id_list >>= 2)
> +			ids_count[idx] = (id_list & 0x3) + 1;
> +
> +		/* Process IDs */
> +		for (list = 0; list < lists_cnt; list++) {
> +			u16 vcpu_id, part_id, *packed_id_list = (u16 *)&ret.a3;
> +
> +			if (ids_processed >= max_ids - 1)
> +				break;
> +
> +			part_id = packed_id_list[++ids_processed];
> +
> +			if (!ids_count[list]) { /* Global Notification */
> +				__do_sched_recv_cb(part_id, 0, false);
> +				continue;
> +			}
> +
> +			/* Per vCPU Notification */
> +			for (idx = 0; idx < ids_count[list]; idx++) {
> +				if (ids_processed >= max_ids - 1)
> +					break;
> +
> +				vcpu_id = packed_id_list[++ids_processed];
> +
> +				__do_sched_recv_cb(part_id, vcpu_id, true);
> +			}
> +		}
> +	} while (ret.a2 & NOTIFICATION_INFO_GET_MORE_PEND_MASK);
> +}
> +
>  static int ffa_run(struct ffa_device *dev, u16 vcpu)
>  {
>  	ffa_value_t ret;
> 
> -- 
> 2.42.0
> 
