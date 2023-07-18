Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A6675785B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 11:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbjGRJrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 05:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbjGRJrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:47:11 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAA810E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 02:47:09 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fc02a92dcfso50658715e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 02:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689673628; x=1692265628;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qRC+fUJny3+iV5dLqvSo+20fNwTdI9JyfgDcGN7Kwaw=;
        b=Y1bqNunI4Va7gwNxV35SrSoD9AXfST1MED6IG2R4qgtO2DQNyoNwfz4vmjCBzPPzXB
         Z7T6uPnWlSTi6B6ufSbCWDH2b72hPXbCERxd6tYj0+/TqH/j8s6DXyQCYBrMA6vNDtgN
         LeK22N+X//FG/D2ND2oDZyJJU7cbqRJ6pcEdmqFPZne1awuusKJeaowNYdxu2YI4x7MH
         omO4NklAG7+t5HiR6G3j4fA+mW1LIwbY4Hb4+F9dXyYX3KhohhICvSXTcjDE3SfrUs0c
         vzMAfamYS20zlww+o4iS02XJ3K23SI8VXODS7+aZTm7GGotcyu5K5WS+vTFVHhDKX9Z5
         LY4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689673628; x=1692265628;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qRC+fUJny3+iV5dLqvSo+20fNwTdI9JyfgDcGN7Kwaw=;
        b=GtXfwrTk7tFJrwatRFrhlHhybP7eQiqWDUSlLjw3Uyrgyb76KuUGc46q7dz4Yw8Y2v
         fAw7oacPNYS06Czxy49MzjlLhi2ZHTSvyLBKGCtFtcQ6T1gU80D9sgYbvKIIB29kxHe0
         LRMOyUwMaGmvbzltcVTDSw78Chp2dmcFoX2ZEFJZ5P/TdSJtPxPvocaAu621JFcGN/ET
         sjHUz6jUvPX+9pcN8JQJY7fHpYsoheHQubn76bywwXCBWI0sQ9Oy4rFSDaLkSwjLP/iP
         SEoixujtK9xrR7/y7jgsNtaOLke5ctekQ/9rhpFRkU4iU0yTl8lDKYxebeOWCcRJGCGG
         XTew==
X-Gm-Message-State: ABy/qLYC+WYEW8gy3G0OqFK/f+k0eD6tawaenRvRqXA790ovqea1ZSiB
        co28oKXeua6y0aL0S5OU5oJKKA==
X-Google-Smtp-Source: APBJJlFy0+0RP3/c/Q29tZcuQks1DZkRQ6tQWvpm+qWkFPE4Rgo0/3QbOY/leUi38v+UhHR8ziL1pQ==
X-Received: by 2002:adf:db42:0:b0:314:53a4:42a5 with SMTP id f2-20020adfdb42000000b0031453a442a5mr1243681wrj.51.1689673628220;
        Tue, 18 Jul 2023 02:47:08 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.146])
        by smtp.gmail.com with ESMTPSA id p1-20020adff201000000b003141f3843e6sm1851838wro.90.2023.07.18.02.47.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 02:47:07 -0700 (PDT)
Message-ID: <ef557792-144e-12ef-ce14-f98982b608dc@linaro.org>
Date:   Tue, 18 Jul 2023 10:47:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] mtd: spi-nor: Correct flags for Winbond w25q128
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20230712-spi-nor-winbond-w25q128-v2-1-50c9f1d58d6c@linaro.org>
 <f00fa2ae-6d4a-90cb-3724-2bedb96cb4fb@linaro.org>
 <0525440a652854a2a575256cd07d3559@walle.cc>
 <d99d87e7-47ba-d6fe-735f-16de2a2ec280@linaro.org>
 <e642ff27fd0bc0f1f0e293972145f680@walle.cc>
 <2d71326c-023e-69af-9337-62672f50fed9@linaro.org>
 <62083227d40d7b631c2eeac1e40c6b56@walle.cc>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <62083227d40d7b631c2eeac1e40c6b56@walle.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Linus,

On 7/18/23 09:32, Michael Walle wrote:
> FWIW, I'm fine with the removed no_sfdp_flags if INFO(, 0, 0, 0).

We'll need a v5 where you test again the flash with mtd_utils,
as we want to get rid of n_sectors and sectors_size and instead
determine them from SFDP. We agreed that the flash entry should
be defined with the following params:

 	{ "w25q128", INFO(0xef4018, 0, 0, 0)
		PARSE_SFDP
		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
	},

Thanks!
ta
