Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25EC75DA1B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 07:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbjGVFOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 01:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjGVFOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 01:14:21 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEDB19A2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 22:14:20 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-992f6d7c7fbso419719966b.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 22:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690002859; x=1690607659;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W/fJ++rD7IhcYQa3mlA8l9n2h0lbuUQyxIsuA/Pokas=;
        b=x9i43kGUm52Dw2XwZ9G0GWo2GtlHg/ZIY0QxwXWGSLd3ougP4ahxD/mLXXNrmLOQ4K
         FubkTtuGUKX8dkhf5oWiDkOamtN+NiW5Gy79d2lG1EMJBNzpVs8GCbYAjmIqqnNGo5ir
         xQh1GzO4q9uRADlOxXzkGiZA/NjJL9T+JxAlFtgUEOAqvZZXyh6ix/0PJBx9UO/PRnYc
         Gfk4Os3Qec7dP4SuMY8Qe3fVi6bz1Af6/vK9UnGHt+AJJve3kr1iK7RlZmEEFg1r9nYT
         R40XCBR2Y6KsBrn5Wp+I5+inIkc1ubj+4UdbUwIj6ZLOj3x6thnV+BMrGtYkkPdM0p4c
         3c2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690002859; x=1690607659;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W/fJ++rD7IhcYQa3mlA8l9n2h0lbuUQyxIsuA/Pokas=;
        b=EESvp6bcX6ADtn6CD2n9RuOeSK0ZmwrwOVG8JnIoQyXwceXPxy3gFwtDo9WC06JfNU
         M5wEPIzZAgseO4yY7E595T8IF4xIHJTiosCFrS/MUUWykzrH4U5Sp4q85mffZavIqlOb
         ixw+JsZUkojx9Ydq43qD/WUA7XS4E803BmrACp83VjhokBQHqIF2kBqLPH7I7tpd7k5U
         Qw+NztTYV3EVq+pavNqPSsbudqDjIx2kpvuzZeYE+bpF2c/7YvZPglt2EaQZuDoNisS4
         9Ovsns8JPUM8xR0NvTOXTCAqSvWgjTgEUgeBE0xZapxsxIm0wnpsBYGbWR3mPdxlSxvB
         Xb1g==
X-Gm-Message-State: ABy/qLZQFfXpHSBO+4t6z4HGNKr+QD3uzkU3fxlQ1KWvUa2dsJbR871/
        ag+m0fnk3WVfd/ClGbmjng/wAA==
X-Google-Smtp-Source: APBJJlFmNhatXmfajxatwljET+9ZqXKrHVZ2b/TAtg7AtDfB4aOnw9zNm++j9SEQIJAT2QTgtgwv2g==
X-Received: by 2002:a17:907:7606:b0:994:522f:3f4a with SMTP id jx6-20020a170907760600b00994522f3f4amr3451668ejc.29.1690002859078;
        Fri, 21 Jul 2023 22:14:19 -0700 (PDT)
Received: from [192.168.2.173] ([79.115.63.16])
        by smtp.gmail.com with ESMTPSA id d19-20020a170906041300b009883a3edcfcsm3078107eja.171.2023.07.21.22.14.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 22:14:18 -0700 (PDT)
Message-ID: <fd57fe7e-ca0e-27d4-1692-d6d9301fb79c@linaro.org>
Date:   Sat, 22 Jul 2023 08:14:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] mtd: spi-nor: let SFDP determine the flash and sector
 size
Content-Language: en-US
To:     tkuw584924@gmail.com, takahiro.kuwano@infineon.com,
        michael@walle.cc, pratyush@kernel.org
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        bacem.daassi@infineon.com, miquel.raynal@bootlin.com,
        richard@nod.at
References: <20230722045901.9872-1-tudor.ambarus@linaro.org>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230722045901.9872-1-tudor.ambarus@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

subject should have started with "mtd: spi-nor: spansion:"
