Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8E47A5E3D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 11:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbjISJjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 05:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjISJjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 05:39:39 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970939E
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 02:39:33 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9a65f9147ccso719392766b.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 02:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695116372; x=1695721172; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dhbUlueLwG/r1Ec1jRuM74oRQ8GVWOc98/czczQGIIE=;
        b=OfQWAaYWMxZnlIDeLP75B2kDBGSPljGeKzbgvrgoVeUCqVSAPalLy2LYR/jE7oroBB
         oWignSvQuISrWiywnh5mxD8gnqnAX450nxzZ1Afp4zBcWBaMhoTLLwqJgiYQB26hCcuS
         tYlQKtB2QAw9c7WOPGZqspoBdHXLoewu0tREVacupSMAqpk389MBMuI3P6teF31qDvGl
         zj/kupAeJYTAuXR1PU4oUF+OfrKYPYTSOGaR02jJ5f7Q1gFlSc+f9tEoVPHR0K0ucKKx
         YiEM3ZoZUh6LWjNJ126hZnVmSRtIotYk4801BPzE0czs9hJdsB3XR7/g0W1SCP6n3Kpi
         a4NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695116372; x=1695721172;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dhbUlueLwG/r1Ec1jRuM74oRQ8GVWOc98/czczQGIIE=;
        b=otL7Bpbq/jExKuQtAkMa8Vgl0GNZEA4H3E4ffYCbgL8ilODpNNsmpBKRbVHTUCuUO/
         zyJ6v+yvgoVKIzcsgQisSLFqAyXq+yed7pOTHgKip2QAhvQQ59g0QgnY5RjMdjc8C558
         Czcwzy6P25MqGgGPPA3e9qUzBfg+3ev1FbCLaoQLX9REB27of9DHjzgpucXCWz3P42xw
         UdzaOYDmlvE70fdWcEN3UcLfEm+2Xsmrd/NLkAu27K6ki0cLnn6JZZFiFA2pX38MCRpQ
         Gbgd52gDLKj0ZtkENnmFc8jmilms+ckdbb3lMo2ffIIlMUb/yGixcAurHigvbV5O2CXG
         b86g==
X-Gm-Message-State: AOJu0Yzwc3UqHnPNdtPEUQDBOjgvbYaBX1nnGugwbCvKxv3gz8annMId
        td112VXHaQvzmy9xWvyc3hOdOA==
X-Google-Smtp-Source: AGHT+IEloqdlvufW6mI6LmUIXNtWYxF9AGR9eR0sjhvD9WKKkHWY8/+nTQOaU4W8KPXLI/2FvFrX6g==
X-Received: by 2002:a17:907:6087:b0:9a5:cf6f:3efc with SMTP id ht7-20020a170907608700b009a5cf6f3efcmr8477878ejc.77.1695116371999;
        Tue, 19 Sep 2023 02:39:31 -0700 (PDT)
Received: from [172.20.101.114] (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.gmail.com with ESMTPSA id rp26-20020a170906d97a00b009ad829ed144sm7490622ejb.130.2023.09.19.02.39.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 02:39:31 -0700 (PDT)
Message-ID: <11380d64-09dd-352a-a6bf-3b8be332ec1c@linaro.org>
Date:   Tue, 19 Sep 2023 12:39:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3 00/41] mtd: spi-nor: clean the flash_info database up
Content-Language: en-US
To:     Michael Walle <mwalle@kernel.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
References: <20230807-mtd-flash-info-db-rework-v3-0-e60548861b10@kernel.org>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230807-mtd-flash-info-db-rework-v3-0-e60548861b10@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08.09.2023 13:16, Michael Walle wrote:
>  - w25q32dw/layerscape spi
>  - w25q32dw (with empty size and empty no_sfdp_flags)/layerscape spi
>  - w25q16dw/mediatek spi

all looks good, Michael, thanks for specifying the tests done.
I'll queue the patches with or without the small comments addressed,
just waiting for a couple of hours to get a response from you.

Cheers,
ta
