Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA1C7EA3C3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 20:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbjKMTbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 14:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKMTbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 14:31:47 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1956E18D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 11:31:44 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6bd20c30831so762969b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 11:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699903903; x=1700508703; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y/ya4lKSeDeZMEtHM/vOqEa/CuouJ2vfBkewF1j97GI=;
        b=jADRYq1GRWYDIex26yYAyHm2pLtk/topKWgrnt6t+sKs98OLl8ijqhGBGCBOQgxJnA
         xRY2lDIWc4Nc1f3iO9FJKGDuZwq5fqEVZ6a42wDri1PH09Gn5hKPPv22KWXH0HhPnmyG
         CZ8FkPAAVSY5kIKYkVXTTT6/DJuiAqLC+WOLd5d+q/SEywKZbP0GoTjDdCoqgIxtZxEE
         f4ijfa/KKTk6o/6XPxMviNY4EfmDonEXLb3/APtZB9g7vwr+fb6lx6xG/wNXIbs1s8Uz
         sN2DsNKG+gyW5L+i7KB+/hF95xqcmfb3tmzuke1smszmeL/1WePx17UT2d6T2UlXMuzR
         6xJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699903903; x=1700508703;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/ya4lKSeDeZMEtHM/vOqEa/CuouJ2vfBkewF1j97GI=;
        b=oHofnf0a4DeHNY0e4xB7bwc9h8iQ+AicE/+TT5Qu3vpwUtd0IyGQvxY0wH47e/v6K9
         z/WosdpssksOMfIKfjkM7/SQL9rscaH2UZV10Pan8YFFc9bRP30OMT1wTe6Q9t++ww6w
         ZDOyOLeZpOqaYdjfSRzLmgocQy+aFbVjA4i7Ht7mfVru8LlVjtUs/DPBVNklD6Np5MuI
         zuQCL4kqI3xGMqyGj6/DptyMrZc+43tX+IDsGO0N58vd1ejE0vM/nobB2HfOq0Djuq0z
         DFy9vyrCTjMbwqm2ImFuDPIcM4Rwk+ywnLiZl4ZbMeVBs5MUXXqj4C623OJdC6FBtc03
         pIlw==
X-Gm-Message-State: AOJu0YwTNuVGUrzjCfUcMNn1B6zAKq2Aexj2T1T176/Ig3qMIMW7XkyT
        rKTFRp16ogm/5lSKAeCmBw0=
X-Google-Smtp-Source: AGHT+IHY3zaBuTI7fce0sQWhI+Z7AUzp84RcB6fLnCjZ28J35T5xGuGiZVl899gjrlTg6KyEo4oT3w==
X-Received: by 2002:a05:6a20:8406:b0:186:e43:c60e with SMTP id c6-20020a056a20840600b001860e43c60emr362303pzd.1.1699903903458;
        Mon, 13 Nov 2023 11:31:43 -0800 (PST)
Received: from [192.168.0.152] ([103.75.161.208])
        by smtp.gmail.com with ESMTPSA id d17-20020a170902c19100b001c60c8d6b4asm4369489pld.149.2023.11.13.11.31.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 11:31:42 -0800 (PST)
Message-ID: <1b5836af-3dbd-4031-a759-01f9885777bf@gmail.com>
Date:   Tue, 14 Nov 2023 01:01:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] driver: gpu: Fixing warning directly dereferencing a
 rcu pointer
Content-Language: en-US
To:     kherbst@redhat.com, lyude@redhat.com, dakr@redhat.com,
        airlied@gmail.com, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <8e9efe54-2799-4539-a8b0-aa199f8052f6@redhat.com>
 <20231113191303.3277733-1-singhabhinav9051571833@gmail.com>
From:   Abhinav Singh <singhabhinav9051571833@gmail.com>
In-Reply-To: <20231113191303.3277733-1-singhabhinav9051571833@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/23 00:43, Abhinav Singh wrote:
> This patch fixes a sparse warning with this message
> "warning:dereference of noderef expression". In this context it means we
> are dereferencing a __rcu tagged pointer directly.
> 
> We should not be directly dereferencing a rcu pointer. To get a normal
> (non __rcu tagged pointer) from a __rcu tagged pointer we are using the
> function unrcu_pointer(...). The non __rcu tagged pointer then can be
> dereferenced just like a normal pointer.
> 
> I tested with qemu with this command
> qemu-system-x86_64 \
> 	-m 2G \
> 	-smp 2 \
> 	-kernel bzImage \
> 	-append "console=ttyS0 root=/dev/sda earlyprintk=serial net.ifnames=0" \
> 	-drive file=bullseye.img,format=raw \
> 	-net user,host=10.0.2.10,hostfwd=tcp:127.0.0.1:10021-:22 \
> 	-net nic,model=e1000 \
> 	-enable-kvm \
> 	-nographic \
> 	-pidfile vm.pid \
> 	2>&1 | tee vm.log
> with lockdep enabled.
> 
> Signed-off-by: Abhinav Singh <singhabhinav9051571833@gmail.com>
> ---
> v1 -> v2 : Replaced the rcu_dereference(...) with unrcu_pointer(...) and
>             also removed the rcu locking and unlocking function call.
> v2 -> v3 : Changed the description of the patch to match it with the actual
> 	   implementation.
> 
>   drivers/gpu/drm/nouveau/nv04_fence.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nv04_fence.c b/drivers/gpu/drm/nouveau/nv04_fence.c
> index 5b71a5a5cd85..cdbc75e3d1f6 100644
> --- a/drivers/gpu/drm/nouveau/nv04_fence.c
> +++ b/drivers/gpu/drm/nouveau/nv04_fence.c
> @@ -39,7 +39,7 @@ struct nv04_fence_priv {
>   static int
>   nv04_fence_emit(struct nouveau_fence *fence)
>   {
> -	struct nvif_push *push = fence->channel->chan.push;
> +	struct nvif_push *push = unrcu_pointer(fence->channel)->chan.push;
>   	int ret = PUSH_WAIT(push, 2);
>   	if (ret == 0) {
>   		PUSH_NVSQ(push, NV_SW, 0x0150, fence->base.seqno);
Hi, just for the sake of my own confirmation, the patch is merge ready 
right? once the CI runs successfully it will be merged right?


Thank You,
Abhinav Singh
