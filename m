Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67479778210
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 22:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235668AbjHJUVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 16:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234424AbjHJUV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 16:21:27 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB81D10F5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 13:21:26 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-686e29b058cso1029720b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 13:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691698886; x=1692303686;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=niZ+vrNDQ4GMStTL9kRLMxjukCY/VFRh2rGg2sfT98M=;
        b=CA/+LIC3HH9ropBEzZi69+cyKgmDHdEThksaK6msMAFhGvl2Mfm7X9HAK0vbjKxE95
         TmA846t5rsevs1uu52TwWWlPzCWbBqVYRHx7+imft5hL5eJH3YrFgq4/zcUnm3VaJC0Q
         2+j1Be3W3YLcg3WUDICYJbn7LwvaGudzZ0KSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691698886; x=1692303686;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=niZ+vrNDQ4GMStTL9kRLMxjukCY/VFRh2rGg2sfT98M=;
        b=hAKSkp3I0zGVy6FZVIf47yDwX1TGu1Y9WL132mnR5zHzSrJLP5n1DlrIMeuaXGk7ub
         dxgrHU0S9Q6bUaZMw7JkCDysrYMrBh7zYemvb1uR3CFcRiy3GCwQ7gdJV1vQwBDpKWD8
         fcXWZhoX+SYIQ83Ukc+O/cec4pKXuW658p+ruNbDywKCUHoLmsBOr1IWgxhgYcoDdn1U
         ON6hDcWcXn5tYNpGwxlP75OomCTuCM9Tv4zkDlpe/IaN2VNdl922kWKXdB9kpdMsp7p1
         V+DLZ9+EeWZwLJ1oWXt/x3Rf9S5QQKFESfGDq0x4tK2pfRDW818GarMq+Z2g3IbzXAjK
         IguQ==
X-Gm-Message-State: AOJu0YxQ1THdBWG5lwyiXnlNG2C1tED9djvNOBI1FmGqfk71HCncpQaK
        6IVAxpHwG0MkZYIT4WE0zT8f0w==
X-Google-Smtp-Source: AGHT+IH+bWBYIE/hcCSfEGYoeswt2A5wZB8OQT2bN7ubfqIok10sb3G5WtjpwJDeHbU8icCF5iuJIA==
X-Received: by 2002:a05:6a00:1acd:b0:687:4dd1:92f8 with SMTP id f13-20020a056a001acd00b006874dd192f8mr3900114pfv.10.1691698886324;
        Thu, 10 Aug 2023 13:21:26 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x42-20020a056a000bea00b006661562429fsm1982331pfu.97.2023.08.10.13.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 13:21:25 -0700 (PDT)
Date:   Thu, 10 Aug 2023 13:21:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Roopa Prabhu <roopa@nvidia.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>, gongruiqi1@huawei.com
Subject: Re: [PATCH v3] netfilter: ebtables: fix fortify warnings in
 size_entry_mwt()
Message-ID: <202308101321.2FDE98DC57@keescook>
References: <20230809074503.1323102-1-gongruiqi@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230809074503.1323102-1-gongruiqi@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 03:45:03PM +0800, GONG, Ruiqi wrote:
> From: "GONG, Ruiqi" <gongruiqi1@huawei.com>
> 
> When compiling with gcc 13 and CONFIG_FORTIFY_SOURCE=y, the following
> warning appears:
> 
> In function ‘fortify_memcpy_chk’,
>     inlined from ‘size_entry_mwt’ at net/bridge/netfilter/ebtables.c:2118:2:
> ./include/linux/fortify-string.h:592:25: error: call to ‘__read_overflow2_field’
> declared with attribute warning: detected read beyond size of field (2nd parameter);
> maybe use struct_group()? [-Werror=attribute-warning]
>   592 |                         __read_overflow2_field(q_size_field, size);
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> The compiler is complaining:
> 
> memcpy(&offsets[1], &entry->watchers_offset,
>                        sizeof(offsets) - sizeof(offsets[0]));
> 
> where memcpy reads beyong &entry->watchers_offset to copy
> {watchers,target,next}_offset altogether into offsets[]. Silence the
> warning by wrapping these three up via struct_group().
> 
> Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>

If a v4 is sent, please fix the "beyong" typo that was pointed out.
Otherwise, it looks okay to me:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
