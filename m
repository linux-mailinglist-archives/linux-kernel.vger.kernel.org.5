Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E36E7F911B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 04:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjKZDEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 22:04:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKZDEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 22:04:53 -0500
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1674710D
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 19:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1700967896;
        bh=OJTiWNg24k+s2OI5Z/otgF76TPhxPTLD1e1T9SDhp1o=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=bK+n7mPwNDxerWr9vspeXyzsdCkMKQxIgEQEJZQttDRrAZiH6lqbrlb2yBDtnV9jM
         qivwdFTMKi+LtQRmbEzshV6Hddim40Hs0HLRXqBvygb1cr1qxJ1FWGd1IBV93WzVcY
         evpkvsijM/Ts6pmn66GlavSTQwPUzCMk254vstfQ=
Received: from [192.168.10.134] ([120.245.114.155])
        by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
        id 134B303E; Sun, 26 Nov 2023 11:04:52 +0800
X-QQ-mid: xmsmtpt1700967892ta0h25e8b
Message-ID: <tencent_B96B540A71C98045E8392BED324B65E89505@qq.com>
X-QQ-XMAILINFO: N+tZcXNNUKPOwN8ITHEbltotrVgPHmWay8jHZCPMsYuUhxvbYPYsq8+m7SFO4R
         9Q4ML9nmyxGfx9lpccBVw4GaiOU6e+ovEHWk80+2QTmXTH9T43Py+nxoUXrVG1C9wtVkd5GXuWzI
         /zM6THSQrnTq5aFfdttH+qJBVrWZiTMt9Z8yqrd7qaeMyzmDJkYegK1nNdIKMPCAKU6a0Wz+Lcyd
         nL2ScPcDpDylzQtU8m8Dt9zEhmcaO/+l0Ui4Q1v+6Uw/jwSgbjiYZ9ezXdBL05MqA2KL6Twgt+n2
         btL1jJ8zxnDSNCFYOfb7RZ9eLs06c9Cthy8ROVIQRkDUFHwZtOLoY1h83Agzuj/7oFMOyE18BJg8
         gh+LwVCpYMIOPOuKDaJ1xCblrlf8rPfNcWG3fzgGiscP/wY8V2gopQfKeIhDINLnAJ3m+/opyzC5
         ojjEf5OX10+EqAVvtPYFXlAMnWk+c6ACMgv4UEQMGk89E51y5XPLzMWUO82Ak6sohfBb0Igyt1hD
         ewHznwvf3ixQR4i/35BZPXU3a0cK6q90JevKZBBar/duK/HHCS+SlVG2ZEaZrzOnQ1hFrAMPSKKy
         kt/gf8vVS5f06R1vHrSd5WxOi1xLV1fr9KoGlA3au9kGzXc2TybJLev/R9Vry0C66tKYH1yKCuut
         6sHA6v78W5jEZwudCy1XnTjOe9Td2PFc2VMW9vnYjSY9nM92o+R9b68lObHtDFCg9o6+LYPpouov
         uTxkG3UTajZQ86VWPhOOWK6MseT/ET034Cqw8O9qV4CrFBZA6svPOEARSfvvzmbYktmeGrbMJF9x
         qDiufXUKwb1h4X75RQhR5SN2I5kmfZhvn4HJk9VeQcN+nOS9QmFtAz6ivD/bWhu0WFjTEbSIkwdg
         7mSfiwgKdV/LTLwnTxGE4Qp49gUyvTPBhIp4MigkKbMWawsVR2g5ybvtuhFn/kYbtkifXuwc1WFf
         a6RRLPaG2CuiVq2rRTkrqytN7Gcs+n8oDQKwbfwzzCOcABYTwhsbDr8gHSxsiq62tMHOObTcI=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-OQ-MSGID: <bafad09b-19c9-4753-be2b-b94b2a5b40ce@foxmail.com>
Date:   Sun, 26 Nov 2023 11:04:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] prctl: Get private anonymous memory region name
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Florent Revest <revest@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        David Hildenbrand <david@redhat.com>,
        Stefan Roesch <shr@devkernel.io>,
        Andy Chiu <andy.chiu@sifive.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Joey Gouly <joey.gouly@arm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>, rongtao@cestc.cn
References: <tencent_977CBF8E8CA6234A1B740A35655D5D7EAA0A@qq.com>
 <20231125155651.GA23245@redhat.com>
Content-Language: en-US
From:   Rong Tao <rtoax@foxmail.com>
In-Reply-To: <20231125155651.GA23245@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/25/23 23:56, Oleg Nesterov wrote:
> On 11/25, Rong Tao wrote:
>> +static int prctl_get_vma(unsigned long opt, unsigned long addr,
>> +			 unsigned long buf, unsigned long arg)
>> +{
>> +	struct mm_struct *mm = current->mm;
>> +	const char __user *u_buf;
>> +	int error;
>> +
>> +	switch (opt) {
>> +	case PR_GET_VMA_ANON_NAME:
>> +		const struct anon_vma_name *anon_name = NULL;
>> +
>> +		u_buf = (const char __user *)buf;
>> +		error = 0;
>> +
>> +		mmap_read_lock(mm);
>> +		anon_name = madvise_get_anon_name(mm, addr);
>> +		if (!anon_name) {
>> +			mmap_read_unlock(mm);
>> +			error = -EFAULT;
> may be another error code makes sense to distinguish this case from
> the copy_to_user() failure?
>
>> +			break;
>> +		}
>> +
>> +		if (copy_to_user((char __user *)u_buf, anon_name->name,
>> +				 strlen(anon_name->name) + 1))
>> +			error = -EFAULT;
> and I guess you can simplify this code a bit,
>
> 		anon_name = madvise_get_anon_name(...);
> 		if (!anon_name || copy_to_user(...))
> 			error = -EFAULT;
Thanks a lot, I just modify the code, please review.
> 		
> 		mmap_read_unlock(mm);
> 		anon_vma_name_put(anon_name); // safe if anon_name == NULL;
>
>> +const struct anon_vma_name *madvise_get_anon_name(struct mm_struct *mm,
>> +						  unsigned long start)
>> +{
>> +	struct vm_area_struct *vma;
>> +	struct anon_vma_name *anon_name;
>> +
>> +	vma = find_vma(mm, start);
>> +	if (vma) {
>> +		anon_name = anon_vma_name(vma);
>> +		if (anon_name) {
>> +			anon_vma_name_get(anon_name);
>> +			return anon_name;
>> +		}
>> +	}
>> +
>> +	return NULL;
> Again, afaics this can be simplified,
>
> 	struct anon_vma_name *anon_name = NULL;
>
> 	vma = find_vma(mm, start);
> 	if (vma) {
> 		anon_name = anon_vma_name(vma);
> 		anon_vma_name_get(anon_name);
> 	}
>
> 	return anon_name;
>
> Oleg.
Thanks again.

Rong Tao

>

