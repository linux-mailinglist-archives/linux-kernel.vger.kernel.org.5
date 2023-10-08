Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D978D7BCF09
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 17:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344822AbjJHPEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 11:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbjJHPEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 11:04:51 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD409AC
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 08:04:49 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-690d2441b95so2727815b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 08:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696777489; x=1697382289; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OODJSi/tm/FeIBQkuc3CaKDuP+abCdAu1wDZTk5E+qw=;
        b=X32FT1Se6qU60QsxGyg900v0ftDAu0W04HgPBUrPc5AU2+UMquj2NMP1GmKfUzKW4I
         tgmqe1p0IDuZ8lMuRtO6kdmGjymQhZ5tEkNUWMLgFtKD2W0maxrT+Y+CQ0Vq87S4bIaw
         MUHDQACj2Z2o6ux+v7xM1Xg0wNbZNdl++Hj0+UFL7FGNIHKANR4s2Dkv9LiszKQNcPyv
         ENvYWWEFfFPq7KmltL0vJ9h7zMM6uFYIbyj453Dvs5YxQhrQ9//Pz17mzItU8zUx19+f
         /tAe2zSmwDn/aplbpO/dKiVqh4Cp6kFZ+WF4mU81D+M0jxpH9p9ZVd5o+WMA6Uc7+6CA
         NctA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696777489; x=1697382289;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OODJSi/tm/FeIBQkuc3CaKDuP+abCdAu1wDZTk5E+qw=;
        b=FrACUXtonUHgThpxKo4FUVetH2oB2ax24eKqDHKH7sCWw9c0ZpAoMLQChuOjUPv2Cf
         zo8bI8RWiHEGo4R9dThJqVHtc1gwlBW6o7/6NN+qrQYlOUIFgYPzmb+WFnDRkZ/tVWXg
         /K+MKr5F0sy9x6d3PvwwjiQzjcNTZKH8ZlCYZ7dTtFVu6RpPpI7qYoWvYGfiJyQ52U+b
         Jrc68vgRHVQQVTSMmxVxK05kRXRRfcdjxvHM1OTYom1Mu+cz+9SV0Eewabsh1zbo0bIF
         xACh20gelNjI1gbWsi5x7If+sfcj78VAnKq9KaaioTAjAH3hWUdkUGHT0nNYUFBuUkCR
         qKyQ==
X-Gm-Message-State: AOJu0YwsVfvMIYf3uPrXtGI9+AfkWDZR5PeLx4JJPPSxa1wur9c+UTGm
        YWN9VXTEF+52NU4FnHzPA5Y=
X-Google-Smtp-Source: AGHT+IE3CKNjYCAYtwrxHuUCXAV5njlEKEioE9M3TVpjD3g61WbLxxKm+dC2wlUOFCS4rn6AFkIj6Q==
X-Received: by 2002:a05:6a00:99c:b0:690:fd48:1aa4 with SMTP id u28-20020a056a00099c00b00690fd481aa4mr14991631pfg.0.1696777489181;
        Sun, 08 Oct 2023 08:04:49 -0700 (PDT)
Received: from [192.168.1.13] ([27.5.160.191])
        by smtp.gmail.com with ESMTPSA id z11-20020a6552cb000000b00578afd8e012sm5745698pgp.92.2023.10.08.08.04.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Oct 2023 08:04:48 -0700 (PDT)
Message-ID: <1d0ab3e1-915a-4dcc-bc7b-86dd7cae2ea1@gmail.com>
Date:   Sun, 8 Oct 2023 20:34:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/nouveau: fix kernel-doc warning
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>, kherbst@redhat.com,
        lyude@redhat.com, dakr@redhat.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20231008070618.20640-1-bragathemanick0908@gmail.com>
 <ZSK4eNUPYIqPF3fM@debian.me>
From:   Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
In-Reply-To: <ZSK4eNUPYIqPF3fM@debian.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/10/23 19:37, Randy Dunlap wrote:
> Hi,
>
> On 10/8/23 00:06, Bragatheswaran Manickavel wrote:
>> Identified below document warning in latest linux-next.
>> ./include/uapi/drm/nouveau_drm.h:49: warning: Cannot understand
>> * @NOUVEAU_GETPARAM_EXEC_PUSH_MAX: on line 49 - I thought it was a doc line
>>
>> Also, on running checkpatch.pl to nouveau_drm.h identified
>> few more warnings/errors and fixing them in this patch
>>
>> Signed-off-by: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
>> ---
>>   include/uapi/drm/nouveau_drm.h | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/uapi/drm/nouveau_drm.h b/include/uapi/drm/nouveau_drm.h
>> index eaf9f248619f..a523ca5aa865 100644
>> --- a/include/uapi/drm/nouveau_drm.h
>> +++ b/include/uapi/drm/nouveau_drm.h
>> @@ -46,7 +46,7 @@ extern "C" {
>>   #define NOUVEAU_GETPARAM_HAS_PAGEFLIP    16
>>   
>>   /**
>> - * @NOUVEAU_GETPARAM_EXEC_PUSH_MAX
>> + * NOUVEAU_GETPARAM_EXEC_PUSH_MAX:
> Yes, this does quieten the kernel-doc warning, but the produced html output
> is not correct.
>
> I had sent a patch for this but it was incomplete (missing full commit message).
> I have just sent a v2:
>    https://lore.kernel.org/lkml/20231008140231.17921-1-rdunlap@infradead.org/
Okay, Thanks Randy

On 08/10/23 19:41, Bagas Sanjaya wrote:
> On Sun, Oct 08, 2023 at 12:36:18PM +0530, Bragatheswaran Manickavel wrote:
>> @@ -458,15 +458,15 @@ struct drm_nouveau_svm_bind {
>>   
>>   #define DRM_IOCTL_NOUVEAU_GETPARAM           DRM_IOWR(DRM_COMMAND_BASE + DRM_NOUVEAU_GETPARAM, struct drm_nouveau_getparam)
>>   #define DRM_IOCTL_NOUVEAU_CHANNEL_ALLOC      DRM_IOWR(DRM_COMMAND_BASE + DRM_NOUVEAU_CHANNEL_ALLOC, struct drm_nouveau_channel_alloc)
>> -#define DRM_IOCTL_NOUVEAU_CHANNEL_FREE       DRM_IOW (DRM_COMMAND_BASE + DRM_NOUVEAU_CHANNEL_FREE, struct drm_nouveau_channel_free)
>> +#define DRM_IOCTL_NOUVEAU_CHANNEL_FREE       DRM_IOW(DRM_COMMAND_BASE + DRM_NOUVEAU_CHANNEL_FREE, struct drm_nouveau_channel_free)
>>   
>>   #define DRM_IOCTL_NOUVEAU_SVM_INIT           DRM_IOWR(DRM_COMMAND_BASE + DRM_NOUVEAU_SVM_INIT, struct drm_nouveau_svm_init)
>>   #define DRM_IOCTL_NOUVEAU_SVM_BIND           DRM_IOWR(DRM_COMMAND_BASE + DRM_NOUVEAU_SVM_BIND, struct drm_nouveau_svm_bind)
>>   
>>   #define DRM_IOCTL_NOUVEAU_GEM_NEW            DRM_IOWR(DRM_COMMAND_BASE + DRM_NOUVEAU_GEM_NEW, struct drm_nouveau_gem_new)
>>   #define DRM_IOCTL_NOUVEAU_GEM_PUSHBUF        DRM_IOWR(DRM_COMMAND_BASE + DRM_NOUVEAU_GEM_PUSHBUF, struct drm_nouveau_gem_pushbuf)
>> -#define DRM_IOCTL_NOUVEAU_GEM_CPU_PREP       DRM_IOW (DRM_COMMAND_BASE + DRM_NOUVEAU_GEM_CPU_PREP, struct drm_nouveau_gem_cpu_prep)
>> -#define DRM_IOCTL_NOUVEAU_GEM_CPU_FINI       DRM_IOW (DRM_COMMAND_BASE + DRM_NOUVEAU_GEM_CPU_FINI, struct drm_nouveau_gem_cpu_fini)
>> +#define DRM_IOCTL_NOUVEAU_GEM_CPU_PREP       DRM_IOW(DRM_COMMAND_BASE + DRM_NOUVEAU_GEM_CPU_PREP, struct drm_nouveau_gem_cpu_prep)
>> +#define DRM_IOCTL_NOUVEAU_GEM_CPU_FINI       DRM_IOW(DRM_COMMAND_BASE + DRM_NOUVEAU_GEM_CPU_FINI, struct drm_nouveau_gem_cpu_fini)
>>   #define DRM_IOCTL_NOUVEAU_GEM_INFO           DRM_IOWR(DRM_COMMAND_BASE + DRM_NOUVEAU_GEM_INFO, struct drm_nouveau_gem_info)
>>   
>>   #define DRM_IOCTL_NOUVEAU_VM_INIT            DRM_IOWR(DRM_COMMAND_BASE + DRM_NOUVEAU_VM_INIT, struct drm_nouveau_vm_init)
> Can you please split checkpatch fix above into separate patch
Hi Bagas,
Sure, will do that and send it as new patch.


Thanks,
Bragathe


