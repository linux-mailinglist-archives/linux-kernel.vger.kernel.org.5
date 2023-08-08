Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDBDC774932
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbjHHTt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbjHHTtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:49:42 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030CA5091B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:55:02 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51d95aed33aso7837986a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691513700; x=1692118500;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gMnxgsCoh82ZoNEGZ3gXMUz0wSz2MoqQmZYxTHk1iuo=;
        b=Ax5iQxbOYK94IiFMubdclYKqkilZ9vXSGbsTfFA9MRShWWaN4RT389Z6LSNSksyj7X
         4o4Ad4B46tTAGtnVHPcdPBIbgIJj2iHAVSD7Ugt1SAKohSEztNTJKbfozqOsRB35CGDv
         Kmp3wn7Q7ngptEidv2EmxdNBMgh3NQu3UOOJcgKD/1xl3DfJetkr21fSMHn+eQPQQP3K
         yobrKBPCdzt0+sPO1JZ62TiaHq7ztADz13DZgeUb0Mk2rKLw7xZOSqe6DysAdSXOUeEZ
         PETzGqHDdOVThPs3ziNGX/ic30q5Tmx5ZzuLKGDaxozoBFZjns5YLrhN9OLFAUDyQMwC
         tq2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691513700; x=1692118500;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gMnxgsCoh82ZoNEGZ3gXMUz0wSz2MoqQmZYxTHk1iuo=;
        b=fTzjXj6Ekq0kxbFqSSYyBhjGZWux2u4kE5B1xQHFDTWZNbV+XFgCjbI3rdyXBKhILz
         CVOsMg49qRftb9KhyTDPPnXU8kreHntVGa+aMLS5FVSwOQycS8BXhiWu9nGLS9UFzVm9
         ovxECdLrn0wQ51yvvcDB6wTwqEU1ajMuJzBeO2o2z42L5cb0L1835e2dOTqhYK2N3Y/9
         1L8eHe9m2pAPcxIzdqteJy2iaKnR7SvzHKqsohYRWh57zGObPOrtmTP82Esk3Jt8Z6cL
         sC7aNI23vjvwCjdALmdVHl4JnFWWPHJBc+vg8ifqRhe5290ZCX0moI57Ro2S+qAHpZkd
         DABw==
X-Gm-Message-State: AOJu0YxFkvF5iJo16Ly0Eo7EYZp3pI5w0r0rlVOILYQmR0I2YeUgl+n8
        8zhWz/KaQylwNCFHP5Rvez1/83UlldtyUC7334M=
X-Google-Smtp-Source: AGHT+IGh6quNsM0lZU6+CofawmyTZRbZPfDUraQexF9fMQWdjRw/ox0syxTlOeazcQZlc3UFNsK4eQ==
X-Received: by 2002:adf:dfc8:0:b0:317:f1dc:36ed with SMTP id q8-20020adfdfc8000000b00317f1dc36edmr2849673wrn.47.1691487575619;
        Tue, 08 Aug 2023 02:39:35 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.177.253])
        by smtp.gmail.com with ESMTPSA id o10-20020a5d474a000000b003141a3c4353sm13080004wrs.30.2023.08.08.02.39.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 02:39:35 -0700 (PDT)
Message-ID: <794d4bfc-2404-9f4f-4a00-f5edf44a3f5a@linaro.org>
Date:   Tue, 8 Aug 2023 11:39:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 3/3] mips: remove <asm/export.h>
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <20230807153243.996262-1-masahiroy@kernel.org>
 <20230807153243.996262-3-masahiroy@kernel.org>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230807153243.996262-3-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/8/23 17:32, Masahiro Yamada wrote:
> All *.S files under arch/mips/ have been converted to include
> <linux/export.h> instead of <asm/export.h>.
> 
> Remove <asm/export.h>.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>   arch/mips/include/asm/Kbuild | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


