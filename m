Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090107BA5F5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242760AbjJEQWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234753AbjJEQQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:16:07 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D728261AC;
        Thu,  5 Oct 2023 07:32:04 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-32487efc319so1087828f8f.1;
        Thu, 05 Oct 2023 07:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696516323; x=1697121123; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7lZZZ4/1+PKPxfykJQx+K5x1JSysyKZLvsajzTAsxdk=;
        b=CHng4znOka8e2CaMAUbtju/CQPCGjhDylrw69IhJnJOdb4K8P50BbfSMCz4mceADwU
         XibqNLGW/6Brm1G1MaDYRnaXSIsTghmYkMTWU2Z3YWge2fznuOOvrxsX9gZSsi8WGfit
         S5j30SHhCsqa/qVUSDa7VZIzdALI2k0fx4lYgxNKok9vKM4H1u1JFrOK+F7739kaX4Uo
         8HwtJ9ixm3Wttgm3j3Wmup8ODw0uzOoF7tEXurdew2VIy9HseWQGnS7T6XvM1gL543io
         2YTRzUZO37sppocmS1B2jG4EflDEk0LZcZeJlayQuOix2kdkpyG53uBH1+1OGX/6DFXO
         ArHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696516323; x=1697121123;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7lZZZ4/1+PKPxfykJQx+K5x1JSysyKZLvsajzTAsxdk=;
        b=RcvfkKrQJAoslCQZtPaeOrndbrvGNGbsVc4up1W664KkntgLefUDhEC+8haaxVCj2s
         sGds4z3sV0FanCs9BQIsQZdrAJNevkSK8koPS8yOQsSC0OKa1lJxx9JyQEGE9lbmcY3q
         Y4/xF6EOa0jW7UYqRarA8RmL3tvdB4cFQ9aPTZxECb3ki+yeTHvqoOAu0XCHTOmo42Ee
         8ilcHHdFpoo3/URP99hSJXqwat3OI/j1ykgZVYAeJjNtlowiOtbdChLP6ayqI7cdq890
         Q/op98E8l6ve6JvKwA+0cWKYJz7qm8+QuRvSRL2R8P5eWI2DVfjDzXFW9IS8EPfQJvSc
         s6OA==
X-Gm-Message-State: AOJu0YzVkx2e5lkL9SzEyJcfA2lA+3UdCS/SQkW1GdV4bRVzoVsydjId
        xGp2ZN+boECPDzZjdGwSphY=
X-Google-Smtp-Source: AGHT+IGeNwFRiaR2N0eH2gDEphyHTycBq3NZEolG4ZYAdI003Zqp47OEBzOniXtW8LVUM2/Bd1MTnw==
X-Received: by 2002:a05:6000:1946:b0:327:e073:d604 with SMTP id e6-20020a056000194600b00327e073d604mr4536663wry.45.1696516322757;
        Thu, 05 Oct 2023 07:32:02 -0700 (PDT)
Received: from [10.254.108.106] (munvpn.amd.com. [165.204.72.6])
        by smtp.gmail.com with ESMTPSA id b18-20020a5d4d92000000b00327cd5e5ac1sm1954639wru.1.2023.10.05.07.32.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 07:32:02 -0700 (PDT)
Message-ID: <ca2006f4-a038-460d-a9ca-d14dca8e4a8b@gmail.com>
Date:   Thu, 5 Oct 2023 16:31:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Annotate struct amdgpu_bo_list with
 __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Alex Deucher <alexander.deucher@amd.com>
Cc:     llvm@lists.linux.dev,
        Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
        Tom Rix <trix@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-hardening@vger.kernel.org
References: <20231003232952.work.158-kees@kernel.org>
From:   =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20231003232952.work.158-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 04.10.23 um 01:29 schrieb Kees Cook:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
>
> As found with Coccinelle[1], add __counted_by for struct amdgpu_bo_list.
> Additionally, since the element count member must be set before accessing
> the annotated flexible array member, move its initialization earlier.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian König" <christian.koenig@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: Luben Tuikov <luben.tuikov@amd.com>
> Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-hardening@vger.kernel.org
> Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | 2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> index 6f5b641b631e..781e5c5ce04d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> @@ -84,6 +84,7 @@ int amdgpu_bo_list_create(struct amdgpu_device *adev, struct drm_file *filp,
>   
>   	kref_init(&list->refcount);
>   
> +	list->num_entries = num_entries;
>   	array = list->entries;
>   
>   	for (i = 0; i < num_entries; ++i) {
> @@ -129,7 +130,6 @@ int amdgpu_bo_list_create(struct amdgpu_device *adev, struct drm_file *filp,
>   	}
>   
>   	list->first_userptr = first_userptr;
> -	list->num_entries = num_entries;
>   	sort(array, last_entry, sizeof(struct amdgpu_bo_list_entry),
>   	     amdgpu_bo_list_entry_cmp, NULL);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
> index 6a703be45d04..555cd6d877c3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
> @@ -56,7 +56,7 @@ struct amdgpu_bo_list {
>   	 */
>   	struct mutex bo_list_mutex;
>   
> -	struct amdgpu_bo_list_entry entries[];
> +	struct amdgpu_bo_list_entry entries[] __counted_by(num_entries);
>   };
>   
>   int amdgpu_bo_list_get(struct amdgpu_fpriv *fpriv, int id,

