Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C927F385E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 22:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjKUVet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 16:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjKUVer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 16:34:47 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6D419E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 13:34:43 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-359d27f6d46so19379765ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 13:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1700602482; x=1701207282; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UcSKcdxnUfKBu2d5/g+3TbLVP4zLtrrfABbMZ6ds6hs=;
        b=fB34akBRPI3ZdNq+mxTlMrrIxnShLNRaGvLhwAofyUSovb2qMvjYft1aMq7cidsmjs
         iV2o7DzfwcEesxbJr92BLa5WSX4aaWRcRtwDqIsGlLBMwLC/IAPRipuNUyJPILpZDoZr
         SYfPJjyBj8hG2gr2rmcUpGIMcKs31UMOT66S1fJZ3BFUPn50ktRo6kHvHdEHafRHsPio
         4x9D9x4HOrRIjF8Ppmi0kgw0nUZIxMjY30qdqt1wzJr0ZfXPjGVS+iWgScydDpLlvlx5
         epNo9nb3JpFZSk/mFy1H6qvUDIHZp8SVUuSPdfTMqLNCerA9Tig/WwqdicJUziXd4XwB
         PJQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700602482; x=1701207282;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UcSKcdxnUfKBu2d5/g+3TbLVP4zLtrrfABbMZ6ds6hs=;
        b=mOn8/13cRVDMr66bfl3iZFRauMNbo7T1UhZj9BDBkUQdDVMRWlgndcK7veOV0rVZib
         2okfq5mZlnLXm+AT/cXNPc7kqSOiD6d7tVZucUC3JEhhdP1Vnen9WfN7WPSBNJBxgU4h
         8Ykmn2lYin1RYvjxXtSpNX2gUyh4SSk0b8bOTlUVuYq3db7fpp7J7Ssdm5OEQ2N34rhE
         M4chrbso/XWDdN+dYw5pEhsu5hEcQ12yLoz4SZEaUER2CqmbtY6wq1SQKcMGqV54E7hT
         +8LNU8L92ZB0Mgc75UgPujkiV0cTUY9gcxvi4HURsv3W+aUTz3Znbd1Px+4SHzUDeZwF
         hT8Q==
X-Gm-Message-State: AOJu0YzEhOhyWFos948i9SCyqZL/pY0VfrqGU0lBLM1SmLAChs2yL30p
        8b/rPrOURE//smL6le8iuE9tngJNU+HxG5p8JUo=
X-Google-Smtp-Source: AGHT+IGyy2hqdVq+PwIZK0YElPHj6ujvJ1KtZRpYE0Xkab/Kl3wLymNCeMm88RO6rlGDt69JhGf9zA==
X-Received: by 2002:a92:d7c3:0:b0:359:d2ed:15f4 with SMTP id g3-20020a92d7c3000000b00359d2ed15f4mr266401ilq.8.1700602482651;
        Tue, 21 Nov 2023 13:34:42 -0800 (PST)
Received: from ?IPV6:2605:a601:adae:4500:9465:402f:4b0a:1116? ([2605:a601:adae:4500:9465:402f:4b0a:1116])
        by smtp.gmail.com with ESMTPSA id cn16-20020a056e02389000b00359c464b632sm3413438ilb.52.2023.11.21.13.34.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 13:34:42 -0800 (PST)
Message-ID: <28d68897-14e4-4dd2-941f-2352d1313fa7@sifive.com>
Date:   Tue, 21 Nov 2023 15:34:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: mm: implement pgprot_nx
Content-Language: en-US
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
References: <20231121160637.3856-1-jszhang@kernel.org>
From:   Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20231121160637.3856-1-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-21 10:06 AM, Jisheng Zhang wrote:
> commit cca98e9f8b5e ("mm: enforce that vmap can't map pages
> executable") enforces the W^X protection by not allowing remapping
> existing pages as executable. Add riscv bits so that riscv can benefit
> the same protection.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/include/asm/pgtable.h | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
Tested-by: Samuel Holland <samuel.holland@sifive.com>

