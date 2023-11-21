Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98BF87F283F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 10:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjKUJAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 04:00:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKUJAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 04:00:02 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DE195
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 00:59:58 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1ca85ff26afso9393235ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 00:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700557198; x=1701161998; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jJ/AFKPeVxjAnYg0rcHdI79h+dhe0CVTx872xJ/48GQ=;
        b=AuZvg8VTWfmgmwopQCFIQRvNxKA0sNX5pYYAb0c0XKa4qfYvHUn2WnudDixiF/O0Ro
         oBbVo0KpT1+d74Ufvzm9vjJsYXQTqrE18BFbgcYNVRtYEGEwfg0eTtGn0ulLVOCyblDw
         v44TSAElUhLsuUEbC+GA8W5cEAkqnWbEfdWbsuP9z01/hgW4aknvuZiHNmVsMVFwulUM
         0D4943ZGsEsVq2WnfBpoxZUzO4uxF9hFy3fjLF2Uv7gMuVmvGpd9lTlO/YD5r+LSw2BD
         gj1dRZaB9KENG4CE4Af/0vK0HGJN4i42RGqruH4K5y5tLszEy+V83n6qhghdaaAfalW2
         hghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700557198; x=1701161998;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jJ/AFKPeVxjAnYg0rcHdI79h+dhe0CVTx872xJ/48GQ=;
        b=jmTehNbsHI6yyu92UN9SgmqQwdmFMkqWTrxKowp9NKpxnrjBqxaVMk/Rf3D/XL0Mun
         pfhZP94gMq95UIOxpMUHibOB5q3IX7zJ9pVWQNymN32bv4Ww0mbDDmsB9wFA+RCK3RA6
         mqM+gIN92PPe6YheFvFHrTxCk7vwekcDlIUx0UZKGFpdvbbTgz6NXJOAndBiWhS8l6PT
         O5ix17wD8NYsMenbaXYVZC4zL10OZDnSEARJkt+dBjXcroHWiclyEwdjC5W9BIOEio1a
         lkdo5WMcAMw9MDgANJf64ulSHOm62B9kqiBjJwJ6LVcDysUc/U5oikXG5nH0/2v5CBDy
         Al9w==
X-Gm-Message-State: AOJu0Yw68tgi+9A/Z+6PhmPHNA73CHv0xYawSc6kBnWKFr793pOVlehP
        l/nAO88pzCrwx0Htsq1YG5EaWxmjkto=
X-Google-Smtp-Source: AGHT+IHuciNeLfXvkTnSw1GZl4bJP7c7mXwIB2Y7kIFG4zpwMN7QUV1San6rTxEbjcx5PX2Gvul0Yg==
X-Received: by 2002:a17:902:eccd:b0:1cf:6a75:e989 with SMTP id a13-20020a170902eccd00b001cf6a75e989mr3141227plh.6.1700557198184;
        Tue, 21 Nov 2023 00:59:58 -0800 (PST)
Received: from [192.168.0.152] ([103.75.161.209])
        by smtp.gmail.com with ESMTPSA id y4-20020a17090322c400b001bbb7af4963sm7401133plg.68.2023.11.21.00.59.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 00:59:57 -0800 (PST)
Message-ID: <38a45214-7cd0-482a-a330-65c5be488fba@gmail.com>
Date:   Tue, 21 Nov 2023 14:29:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] driver: gpu: Fixing warning directly dereferencing a
 rcu pointer
Content-Language: en-US
To:     Danilo Krummrich <dakr@redhat.com>, kherbst@redhat.com,
        lyude@redhat.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <8e9efe54-2799-4539-a8b0-aa199f8052f6@redhat.com>
 <20231113191303.3277733-1-singhabhinav9051571833@gmail.com>
 <0754e669-8b00-461c-b6fe-79c659bf59a3@redhat.com>
From:   Abhinav Singh <singhabhinav9051571833@gmail.com>
In-Reply-To: <0754e669-8b00-461c-b6fe-79c659bf59a3@redhat.com>
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

On 11/21/23 06:50, Danilo Krummrich wrote:
> On 11/13/23 20:13, Abhinav Singh wrote:
>> This patch fixes a sparse warning with this message
>> "warning:dereference of noderef expression". In this context it means we
>> are dereferencing a __rcu tagged pointer directly.
>>
>> We should not be directly dereferencing a rcu pointer. To get a normal
>> (non __rcu tagged pointer) from a __rcu tagged pointer we are using the
>> function unrcu_pointer(...). The non __rcu tagged pointer then can be
>> dereferenced just like a normal pointer.
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
> 
> Applied, thanks!
> 
> There are a few more such occurrences. [1][2] Plan to fix them as well?
> 
> [1] 
> https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/nouveau/nv10_fence.c#L35
> [2] 
> https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/nouveau/nv84_fence.c#L88
> 
>> ---
>> v1 -> v2 : Replaced the rcu_dereference(...) with unrcu_pointer(...) and
>>             also removed the rcu locking and unlocking function call.
>> v2 -> v3 : Changed the description of the patch to match it with the 
>> actual
>>        implementation.
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
Thanks a lot for merging this.
Yeah sure I will submit the patch for the issues soon.

Regards,
Abhinav Singh
