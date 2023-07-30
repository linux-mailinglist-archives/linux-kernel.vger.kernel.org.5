Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC3376872A
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 20:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjG3SrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 14:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjG3SrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 14:47:13 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FE210EB;
        Sun, 30 Jul 2023 11:47:12 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99bcfe28909so537723466b.3;
        Sun, 30 Jul 2023 11:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690742831; x=1691347631;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jODm2bxmR0hsMYM8Q0ObNJZ8dSyPCpf1EZ3thXMcrxk=;
        b=nAvYWRGlNuqoZUEQ5tU+ZkL8bQjFGY2CiAZ2JXmnZnLC9ESCDb+2oMcQ4eZW+HZDjZ
         /Bo874WtHJjArVpR3YIBaBiCN0INPoB95JZOOfTGyKkKgSffIzF23ppUgWDpqq0BrkC2
         OGH43elSRcmwMBGwXNh22AeLPKCqCyDzQMYYLTH0kcJlYsmOh1EV91Z6KTXrbf15VBPJ
         u9HzVUQ7/ZLTL3v7TUHIF/LXOGlLWt8nONbW7fFREuWlp083DdCRt4Vfd60WYk+vCfLK
         B6zz55gedMuMX31U688A74mLU/Diwjg8UA9jzOeoUWKhKiHGbDXw7VERKjDT0zf3jHzw
         ROuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690742831; x=1691347631;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jODm2bxmR0hsMYM8Q0ObNJZ8dSyPCpf1EZ3thXMcrxk=;
        b=A6mw0DmgMe8IFaK2+mvcvZK5bWMHCXeQNGhdoHLSn8LeexH386cEwk/uAq5vU08ECF
         dYGSO6EhzwHAy9wL+mQunKhZCTNiW9Tf1Cm+HTosiqRXOWPhvgVN/VG0/YFwIdtCmglr
         3eIFndMSI9c9/KZ06Vd8FEBWdSrMCabiZRhUS65s4CygqV8FPVB3XBlXkaWQ9TRMaBYz
         q8T8NObG1KG2QT9H9bJgTYvE78VDhafjJ6sUirXQzWKNLdaystsuWFWDGBXnp3oVpzFS
         YJn0t8JT3ZHaeUToqaI08akkan+dCIrhyY+ZnHe7z+hjFmwpAFayFr5J2hu7Fj04XAzz
         troQ==
X-Gm-Message-State: ABy/qLZ9/CrO3WmLKrRnKRkeg31RlnbjptYie1ojCl5VFAxmKGWocFU6
        VofkRWjZOKXVmrFStA6rdLQx2pLjzM8=
X-Google-Smtp-Source: APBJJlG0eA33vbglj1HYWANle2bxauiFjQE2Z+q+ylKTJH0k3LQ65oyWzIKRhfAjqLpOPN9lwrJgiQ==
X-Received: by 2002:a17:907:270d:b0:993:f540:5bb1 with SMTP id w13-20020a170907270d00b00993f5405bb1mr5136244ejk.41.1690742830961;
        Sun, 30 Jul 2023 11:47:10 -0700 (PDT)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id f25-20020a170906085900b00991d54db2acsm4972556ejd.44.2023.07.30.11.47.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jul 2023 11:47:10 -0700 (PDT)
Message-ID: <bb80fc94-7a80-f951-13a9-a0c055c8dbc8@gmail.com>
Date:   Sun, 30 Jul 2023 20:47:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] firmware: qcom_scm: Add support for Qualcomm
 Secure Execution Environment SCM interface
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Johan Hovold <johan@kernel.org>,
        Steev Klimaszewski <steev@kali.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230730161906.606163-1-luzmaximilian@gmail.com>
 <20230730161906.606163-3-luzmaximilian@gmail.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <20230730161906.606163-3-luzmaximilian@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/30/23 18:19, Maximilian Luz wrote:

[...]

> diff --git a/drivers/firmware/qcom_qseecom.c b/drivers/firmware/qcom_qseecom.c
> new file mode 100644
> index 000000000000..e9edd500c3d9
> --- /dev/null
> +++ b/drivers/firmware/qcom_qseecom.c
> @@ -0,0 +1,128 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Driver for Qualcomm Secure Execution Environment (SEE) interface (QSEECOM).
> + * Responsible for setting up and managing QSEECOM client devices.
> + *
> + * Copyright (C) 2023 Maximilian Luz <luzmaximilian@gmail.com>
> + */
> +#include <linux/auxiliary_bus.h>
> +#include <linux/platform_device.h>
> +#include <linux/types.h>

This is missing a linux/slab.h include for kzalloc() and kfree(). Fixed
for v6 as well.

Kernel test robot caught this as well... I guess I need to look into
building with more warnings enabled because I didn't catch that on my
system.

Regards
Max
