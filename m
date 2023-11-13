Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0AB7EA31C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 19:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjKMSzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 13:55:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjKMSzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 13:55:33 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CF710DA
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 10:55:30 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6bd20c30831so753720b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 10:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699901730; x=1700506530; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G+f4rJoyzPIE0y6h0wORDQt+kRBF7nK+PXXMCBjyvGI=;
        b=dMuCpyzbCchqX31mYgMW9DkowBYRcjyY7UsXCS4NS09etA0eWmptSNyCwM5oqjypJ0
         iPG5Yh45gm8Eqlg2OS9YdSiy21yLYOtZyOvSp/Z09bL9/TmoAFQWfiilNc4MJv29Tydm
         p0sepQ+mH0vZYYP3VXEsjG3+ok+VMi9ParVQy7NHSLnHJv/hdfb5sJ1OcGBVHCCxlIjU
         dK4EWEpxzBRbtkJbJwo3Ql1E93AsUcWwzfRpadTPhNJsBWjxYLZEFNJPCpGkUDIp3GmU
         LtcOdDxhGb4eWPzg+pxpn2kke6gKQX12qqgYiTRCagfqdYyN8JbKqpIZInCgxOcjJBSb
         Sh7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699901730; x=1700506530;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G+f4rJoyzPIE0y6h0wORDQt+kRBF7nK+PXXMCBjyvGI=;
        b=oJO2iJ8/SnRFpAQbHxS9JSmMKEfRqg1iV2tZbT9zZAH13Sy7nM573SwzzXlr4CpO3S
         F9Gq0vqbU/UFDtaFbWGf3/+mPLc9yY3z+CMBHS0ig0zcuCSeY21Q2az7Z8d8x94xsrl/
         eyFCp3Fq9yfROtR+ZFVeloxZRD/RXYYCQiCDcGuh0YiKaDe/1QG7+nW80rEFx3OVXHxq
         SqxxonB4Nk1/52uVI9KmHk5KYTBRrKCrLsxFpn1HhzY1xf+ZIy1oh5VUy5fe1R8+NDpW
         QIkb95NKbkpz8kFcADhWScbZPuObeyHa6pSE+yZRxoZy7FuPvB6kCRNborGtKXHhQmOr
         sTWg==
X-Gm-Message-State: AOJu0YyOd530dp6261v5MTm+/BJs28L82gV/zXN2tqmp0FU3WhCQ8h1y
        bEZHvbIRA/teuiehzVdRXAGrw4kYV9v21g==
X-Google-Smtp-Source: AGHT+IE5duZlYWLgqLzfa5RiDEmFjpMM0G68cLOdfphgOn3YyS8OIU25TqGIK0nk9u3XKZly5FW4rQ==
X-Received: by 2002:a05:6a20:9381:b0:163:d382:ba84 with SMTP id x1-20020a056a20938100b00163d382ba84mr130227pzh.5.1699901730166;
        Mon, 13 Nov 2023 10:55:30 -0800 (PST)
Received: from [192.168.0.152] ([103.75.161.210])
        by smtp.gmail.com with ESMTPSA id ka27-20020a056a00939b00b0069102aa1918sm4091818pfb.48.2023.11.13.10.55.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 10:55:29 -0800 (PST)
Message-ID: <d0b1fb36-d2a6-446c-8a04-2101981f3a00@gmail.com>
Date:   Tue, 14 Nov 2023 00:25:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] driver: gpu: Fixing warning directly dereferencing a
 rcu pointer
Content-Language: en-US
To:     Danilo Krummrich <dakr@redhat.com>, kherbst@redhat.com,
        lyude@redhat.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <d33fc41b-5a1f-4186-a0b2-3c82dcb8f00b@redhat.com>
 <20231113184238.3276835-1-singhabhinav9051571833@gmail.com>
 <373d97fc-0612-40da-ae9d-6702aa4483ba@redhat.com>
From:   Abhinav Singh <singhabhinav9051571833@gmail.com>
In-Reply-To: <373d97fc-0612-40da-ae9d-6702aa4483ba@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/23 00:19, Danilo Krummrich wrote:
> Hi,
> 
> thanks for sending a v2.
> 
> On 11/13/23 19:42, Abhinav Singh wrote:
>> This patch fixes a sparse warning with this message
>> "warning:dereference of noderef expression". In this context it means we
>> are dereferencing a __rcu tagged pointer directly.
> 
> Better use imperative here, e.g. "Fix a sparse warning ...".
> 
> Wouldn't ask you to send a v3 for that alone...
> 
>>
>> We should not be directly dereferencing a rcu pointer, rather we should
>> be using rcu helper function rcu_dereferece() inside rcu read critical
>> section to get a normal pointer which can be dereferenced.
> 
> ...but this doesn't seem accurate anymore as well.
> 
> - Danilo
> 
>>
>> I tested with qemu with this command
>> qemu-system-x86_64 \
>>     -m 2G \
>>     -smp 2 \
>>     -kernel bzImage \
>>     -append "console=ttyS0 root=/dev/sda earlyprintk=serial 
>> net.ifnames=0" \
>>     -drive file=bullseye.img,format=raw \
>>     -net user,host=10.0.2.10,hostfwd=tcp:127.0.0.1:10021-:22 \
>>     -net nic,model=e1000 \
>>     -enable-kvm \
>>     -nographic \
>>     -pidfile vm.pid \
>>     2>&1 | tee vm.log
>> with lockdep enabled.
>>
>> Signed-off-by: Abhinav Singh <singhabhinav9051571833@gmail.com>
>> ---
>> v1 -> v2 : Replaced the rcu_dereference(...) with unrcu_pointer(...) and
>> also removed the rcu locking and unlocking function call.
>>
>>   drivers/gpu/drm/nouveau/nv04_fence.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/nouveau/nv04_fence.c 
>> b/drivers/gpu/drm/nouveau/nv04_fence.c
>> index 5b71a5a5cd85..cdbc75e3d1f6 100644
>> --- a/drivers/gpu/drm/nouveau/nv04_fence.c
>> +++ b/drivers/gpu/drm/nouveau/nv04_fence.c
>> @@ -39,7 +39,7 @@ struct nv04_fence_priv {
>>   static int
>>   nv04_fence_emit(struct nouveau_fence *fence)
>>   {
>> -    struct nvif_push *push = fence->channel->chan.push;
>> +    struct nvif_push *push = unrcu_pointer(fence->channel)->chan.push;
>>       int ret = PUSH_WAIT(push, 2);
>>       if (ret == 0) {
>>           PUSH_NVSQ(push, NV_SW, 0x0150, fence->base.seqno);
> 
Hi maintainers thanks a lot for reviewing this patch.
I think I should fix my mistake by sending in another patch so that the 
code changes and description matches. So should I send another patch ?

Thank You,
Abhinav Singh
