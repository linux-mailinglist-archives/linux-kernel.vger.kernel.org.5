Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D128975B590
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 19:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbjGTRWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 13:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbjGTRWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 13:22:48 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6457FB7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 10:22:45 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b8b2886364so6562975ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 10:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689873765; x=1690478565;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Dlg+JAj788vjwue8GDOXQLi5ai5XH7Nv+Bc4dqp67fg=;
        b=XD4/M9W71yRz04M0M+l/mmVz0KvgllmBy6TxaS3iu4VO+ZaSN+kC21KSKWJWAUL2bN
         LtN5WSPOhw1gDIry+MGhiTfoCXp/LKKlZWw5JqgvPe21pbhtB36FTWYLXdJ9Yh1ocBkQ
         CVkT/qM5VCoUQZap7oPrlzFfVYHSUeP7NYdHDx+ve8D9fV62zE34D/fUTKodanmaa7wx
         m4las+s0N5DW1LO5ajDsWAXDdKC4sxTtraltaVVBasXpDw/4zIoXAB6lyo3EaIU3rJWb
         2Z6bOn0s2FdtVl3TfTRgAIA/G6M/fjqpHtEKnOdGjZaw2W6mlT9S1GtjdclKvIzGaK7w
         HD5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689873765; x=1690478565;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dlg+JAj788vjwue8GDOXQLi5ai5XH7Nv+Bc4dqp67fg=;
        b=HTRu/W2nbyzOTKUUsZPvI+iBlN/c6OGuoFs6K4Y5/7MATUezl6TjI7d8+IPv8cv/7F
         Kt013ZylPyuO91qm/Q+p8F7i2xMNiYhcjB8G+4FDx2Pm9VPuBCUggMV/0kIkAc/aYb5/
         HxvXCe67vRmlhyNdM79Rv9ECNzmWOUoLVwebJFXcXcvLl/Rcx6IrYJvCRvOM0QV7GBIH
         /FsCRUHrZXN3Xgbkw3rVCVgb1cCZtykuD015wCXmAKjlsghGavzBACnVSxzfm3nisx/I
         x77wAoKfJwn5MbVq8tXka1vOPs4ayvOqLfpP5HPQDul/iSN1snMkqpD1j61P+v0XAV5E
         vz0g==
X-Gm-Message-State: ABy/qLbAfnGx5Le2D7kY8m8pt5n/CJZ1iolxrVfyjFcBZZg0sVQ8qGkd
        ImdZ4VRQM6JWI9xoJgUy8g4=
X-Google-Smtp-Source: APBJJlEOPwY5lFojZwF94EMbwRc5gtRaMDp/5745d6qZuj9C9BIc1YsT4TfzU+zyDQ0+uGUvqxKzCA==
X-Received: by 2002:a17:903:190:b0:1b8:7bd2:f77d with SMTP id z16-20020a170903019000b001b87bd2f77dmr2178plg.64.1689873764735;
        Thu, 20 Jul 2023 10:22:44 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w2-20020a170902e88200b001a24cded097sm1638661plg.236.2023.07.20.10.22.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 10:22:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c77080a5-255d-9584-4031-2dd27dc8fa51@roeck-us.net>
Date:   Thu, 20 Jul 2023 10:22:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Traceback with CONFIG_REGMAP_KUNIT=y+CONFIG_DEBUG_ATOMIC_SLEEP=y
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
References: <ee59d128-413c-48ad-a3aa-d9d350c80042@roeck-us.net>
 <336fc14e-f734-49ea-97ce-802f03fa4422@kadam.mountain>
 <198c4edf-045c-8d85-1d5c-018378eeb490@roeck-us.net>
 <055f2564-551d-4b5f-a6e3-d54ae104d5c9@sirena.org.uk>
 <d29552c2-f20c-cf68-76ae-e03a2cc7e0ba@roeck-us.net>
 <12e6144c-0d24-4556-beef-d754273992e4@sirena.org.uk>
 <e3799cbf-daf2-c805-4c70-09679c4b6cf5@roeck-us.net>
 <9595effb-e01c-6c5c-362e-b8e8ad364fd7@roeck-us.net>
 <0e64a83a-fb53-48c4-b790-8e8dfa888ef3@sirena.org.uk>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <0e64a83a-fb53-48c4-b790-8e8dfa888ef3@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/23 09:48, Mark Brown wrote:
> On Thu, Jul 20, 2023 at 09:41:42AM -0700, Guenter Roeck wrote:
> 
>> After adding the GFP_KERNEL -> map->alloc_flags changes to the maple tree
>> code while skipping the init functions, I no longer see the traceback.
>> This is without my patches.
> 
> Ah, excellent - yes, that should sort it.  I've already queued your
> original patch for CI for 6.5, we could then apply both your new patch
> and Dan's for 6.6 to support anyone who for some reason does want to try
> dynamic allocation at runtime in atomic context.

Makes sense. I submitted a patch to address the problem in the maple tree
code. I assume Dan will submit one for the rbtree code. Dan, let me know
if you want me to handle that one as well.

Thanks,
Guenter

