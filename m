Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6777EEEC0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 10:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235722AbjKQJcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 04:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235798AbjKQJc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 04:32:28 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DEE8D75
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 01:32:22 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-53dfc28a2afso2580372a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 01:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700213540; x=1700818340; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fK3T7eD2t8L/Xy9XBzTKHmjBPpvXZhYpiMTcL8KJC2Q=;
        b=G/NOh8vekdncVa0upxmpI5bPQzku1MzYyFwECf2fYO59VQLzfWJqc5Rbtl1ep19Sok
         F8ZOeO3WdlGAcAu60mtLaz4zHIOxc9VtD4uXGJzFddGrQO1lb1DsNJfHcsDa/oocBAGg
         7ItmqJw4fJg5NHsuGtN8syNgi9K1dcawlIEFZLj6tzPZoJMW4ZnylyhyiD5e8biqa783
         EjX90YOo7549aw1go6uytTbUgcCiNq8Dc41UqKyaeEk/BnDJ7ar3BYOC76QQVDw5R8gh
         R/Z5sGoDSSOiYy6TMEXIr9D8ONZkLz0TIG19+bCB4ltej6f8TGYvZWiPCd3Db1PR6qeF
         8yUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700213540; x=1700818340;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fK3T7eD2t8L/Xy9XBzTKHmjBPpvXZhYpiMTcL8KJC2Q=;
        b=LXS0T65vh5Am5Ym/+DSCG7WJ/QYDI4YmcSzRf/XZtNi9o/ITyfkoMAv0m4/YdLadoc
         yESVCPjBgHUxREI10NHNDBICiqWg8QayIYmIqFcVL8USnt4Th2rkHn9HOaqgrOlNdMDR
         /p7c7IGc1N2VVPUHsY5RHaU+OLu/NaJjeTNJwMk6wrBZ6mX5wKEOp+a0wa8ZmHdUz/kc
         GA31/vZrjj3ZbxqxYoG07jbsIFfmvlCvJAClNV9i2QRmD8blR+OpuukWYW9/+2LFDqxC
         CTsN621unmW7aTGPvgIvznlzeBFAYZ9fGbTy9PF0821inZDa9dTKqCr4CmKeIyjmYMbU
         B2+A==
X-Gm-Message-State: AOJu0YxJBjyHHU8jT0I99KoB3MdgU9L1D6ly00awoYhqk0l2tKr/FGLj
        Z+PW3p+SlmL7nE51lJXtHJKpoA==
X-Google-Smtp-Source: AGHT+IE0GOjwhP8Lawu9hYoojUPq9njj37wDH95KaBc3EI7tCnfwvxV09sRI3ejqqlKO0oxqX5ge9w==
X-Received: by 2002:aa7:d944:0:b0:543:56d8:eb26 with SMTP id l4-20020aa7d944000000b0054356d8eb26mr13577516eds.35.1700213540507;
        Fri, 17 Nov 2023 01:32:20 -0800 (PST)
Received: from [192.168.1.111] ([37.251.220.47])
        by smtp.gmail.com with ESMTPSA id z6-20020a509e06000000b0053f10da1105sm551573ede.87.2023.11.17.01.32.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 01:32:20 -0800 (PST)
Message-ID: <054c1d8f-fb23-4793-b6d1-5d8814209992@linaro.org>
Date:   Fri, 17 Nov 2023 09:32:17 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] spi: Replace -ENOTSUPP with -EOPNOTSUPP in op
 checking
Content-Language: en-US
To:     AceLan Kao <acelan.kao@canonical.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Dhruva Gole <d-gole@ti.com>, linux-mtd@lists.infradead.org,
        Mark Brown <broonie@kernel.org>,
        Kamal Dasu <kamal.dasu@broadcom.com>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Mario Kicherer <dev@kicherer.org>,
        Chuanhong Guo <gch981213@gmail.com>,
        linux-kernel@vger.kernel.org,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
References: <20231116024338.337304-1-acelan.kao@canonical.com>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20231116024338.337304-1-acelan.kao@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I included linux-spi@vger.kernel.org. Please do the same if you're going
to send a new version.

On 11/16/23 02:43, AceLan Kao wrote:
> --- a/drivers/spi/spi-mem.c
> +++ b/drivers/spi/spi-mem.c
> @@ -323,7 +323,7 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>  		return ret;
>  
>  	if (!spi_mem_internal_supports_op(mem, op))
> -		return -ENOTSUPP;
> +		return -EOPNOTSUPP;

this will break user-space if someone uses the return code of
unsupported operations, but I'm not against taking the risk and changing
the return code, as I doubt it's used. Anyway, if we're taking this
path, please specify the risk in the commit message and why we're taking
this risk.
