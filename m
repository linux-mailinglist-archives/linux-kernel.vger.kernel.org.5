Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3861780690F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 09:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376843AbjLFIBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 03:01:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjLFIBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 03:01:36 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F9E18D;
        Wed,  6 Dec 2023 00:01:43 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1d06819a9cbso28244085ad.1;
        Wed, 06 Dec 2023 00:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701849703; x=1702454503; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NsJi+rAf1/pjE2JHoHBlEmIyNC7axeV0xxI+MHCEAm4=;
        b=fP0yvDmxQqRudG4Pdu43JNlIHNl9YH7IUUsIrL+vM/acSlwTUDKOpC2/GgO7dcqfwP
         TdwAq0zLRodGjfs7mk/dPMpTqYtIx2NMNO/XS1OUGKF/M+cZPsjPOoV+eX9NBBp6hPyZ
         eaLv+yP4tvQj/xYuWPrgkREF8lhtTKcBvb3u/51d2LKzzxiIcqese8kWAtLME5LqdLtT
         Ne+3yJGsJRi95r86O9k66hJ8NTh2Gb++mPoDhOFYCQRmbE8HXRHdHLEtbTG5rTNz6Az3
         EuTzmhRPCNdrwUn0hRjgyZz3hCDDjhioI/SfN9l7Il6QaF64JQwEp28XHcm7OEw6OFlW
         ZJZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701849703; x=1702454503;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NsJi+rAf1/pjE2JHoHBlEmIyNC7axeV0xxI+MHCEAm4=;
        b=Pu+GXrPxVL6DrtfTiBaeLoL8F1Vwk50ArC1h6DjzzygGmqZJE97W1v2tcJFrV5pjoF
         nAoBsNCe5+dB7x0pLupdqiwmuhrOeiNLimU5SQnYFx0IlSNdSEedwrLh3qlwtoKjcZef
         GVqohVuL5OO8wAFvFpbSY5KuBpJ8s0X+nxYyqWipzztkE3I6yqnU0dyjRi0xqYee9e0x
         ahICLvzxLlkJnIoov323swCcg9aXUTJo9dTz3v9Drmn7RIw7pYyouyILzzdlDHxcUzRS
         aXebGDvTSSigQOMLXMa0mS3sC+qg5OgXWb4uM113EhecRzfNnzPeKBx0CIw3cdg/M+OB
         DyUg==
X-Gm-Message-State: AOJu0YzpWb1bdnKVDxrklF70S1vpHRgpiUbaRnKtY22fSBhbwCn21NjQ
        cVN8/pwWp/m5SRsMd2QFw14=
X-Google-Smtp-Source: AGHT+IGA+NdMOoVaQo27rb8nuihulPx4cilWx0f3Si9dfTy/8wUKfwgUOGwMnzP3PtmBSojs/chvDQ==
X-Received: by 2002:a17:903:1208:b0:1d0:6ffd:ae04 with SMTP id l8-20020a170903120800b001d06ffdae04mr321640plh.107.1701849702755;
        Wed, 06 Dec 2023 00:01:42 -0800 (PST)
Received: from localhost.localdomain ([1.245.180.67])
        by smtp.gmail.com with ESMTPSA id x4-20020a170902ec8400b001d08bbcf78bsm5976368plg.74.2023.12.06.00.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 00:01:41 -0800 (PST)
Date:   Wed, 6 Dec 2023 17:01:27 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Marco Elver <elver@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        cgroups@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 04/21] KFENCE: cleanup kfence_guarded_alloc() after
 CONFIG_SLAB removal
Message-ID: <ZXAqV8wCjw/KAiRp@localhost.localdomain>
References: <20231120-slab-remove-slab-v2-0-9c9c70177183@suse.cz>
 <20231120-slab-remove-slab-v2-4-9c9c70177183@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120-slab-remove-slab-v2-4-9c9c70177183@suse.cz>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 07:34:15PM +0100, Vlastimil Babka wrote:
> Some struct slab fields are initialized differently for SLAB and SLUB so
> we can simplify with SLUB being the only remaining allocator.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Marco Elver <elver@google.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/kfence/core.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index 3872528d0963..8350f5c06f2e 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -463,11 +463,7 @@ static void *kfence_guarded_alloc(struct kmem_cache *cache, size_t size, gfp_t g
>  	/* Set required slab fields. */
>  	slab = virt_to_slab((void *)meta->addr);
>  	slab->slab_cache = cache;
> -#if defined(CONFIG_SLUB)
>  	slab->objects = 1;
> -#elif defined(CONFIG_SLAB)
> -	slab->s_mem = addr;
> -#endif
>  
>  	/* Memory initialization. */
>  	set_canary(meta);

Looks good to me,
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

> 
> -- 
> 2.42.1
> 
> 
