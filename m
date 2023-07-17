Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8921C7568A9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 18:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjGQQDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 12:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjGQQDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 12:03:44 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663E2F4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 09:03:42 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fbdfda88f4so42266085e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 09:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689609821; x=1692201821;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xzMEPTz588E46vXxy5mUnzrAFOkBW/+dR4TsONpfgDs=;
        b=hmC4JEUJ0yS2BhZmUzD1WFgoOgR+TL3jIxHmHWs+VaH1Eb/BudUEOgdcDRC2LyUWed
         NvjydtuzNLSrMdNuQEeUvawFb4q/HDG4pvdQ3B+dOlri/6ZfW8Qut7dPTDXCvXuTFnBQ
         5kRVmo/+wTHfUko6jftrEr7AyrRMwQMynSsVFb3I/eGrT5GJ2LYMCtBLZWYw/tixnwkD
         nJEU4xVIkzCuGkn/uhfvb8ikvQU90pVog14exKwHj49OnpOQs+Ja/9Y23N5/bmQ5o+q/
         b2zM1Bn/qcyJcvOjaVPeg80xhI2VaR+UMcZKX2WBx5xPNUhTtH85seIavgytdraOKIGT
         00CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689609821; x=1692201821;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xzMEPTz588E46vXxy5mUnzrAFOkBW/+dR4TsONpfgDs=;
        b=TUANRNJBl+HHayEG/qqxynOXs1kInbBat8iJfW5RS63+PsFqC0qcHHKDdgcvmWCe6d
         Yoz2RsFLWzltxLIsn1WcGcmYjfzWppjpGaciWinnh28FRRmTiQllWupCVls52+LA/Q4R
         GIlLLKY1/DqYTB6bfCn/hQiKV5VbzpSk6zc61OnItUa+stRO6CPz/sZTNj/GXVn110p4
         Txry8y3F0JWnMHlENrioBs67BBN8czN5TEcqgMN7KDd29dRjjpMlONHwWu8PD15h6jd1
         g0Ydt3Tuh1wTZq00mEHgqqPWij9/EhyaptkZMjxQNogkmM/NvDYbxVSH00PiUmo+WHZX
         ADpw==
X-Gm-Message-State: ABy/qLY0wtstSp94OADHNbaeV1ZbLoom0/azA9L+Itji9ggm2FRBVAv6
        x05UmBAIorVskcwTh9fORSzH4Q==
X-Google-Smtp-Source: APBJJlF8TV7G64+zI7mZZ9hBeDEcGqA32zWkkv1pZqt8gCcGrSJQ4UJFGTuB0sf4JFEZ790mkXyj9g==
X-Received: by 2002:a1c:7909:0:b0:3fb:fed9:1c7f with SMTP id l9-20020a1c7909000000b003fbfed91c7fmr9716416wme.8.1689609820868;
        Mon, 17 Jul 2023 09:03:40 -0700 (PDT)
Received: from [192.168.2.173] ([79.115.63.146])
        by smtp.gmail.com with ESMTPSA id m19-20020a7bca53000000b003fa96fe2bebsm93407wml.41.2023.07.17.09.03.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 09:03:40 -0700 (PDT)
Message-ID: <125a610b-b205-52ba-1fe6-e7e0add0f8b9@linaro.org>
Date:   Mon, 17 Jul 2023 19:03:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/2] Add support for gigadevice and macronix SPI-NOR
To:     Sridharan S N <quic_sridsn@quicinc.com>, pratyush@kernel.org,
        michael@walle.cc, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230717153536.25700-1-quic_sridsn@quicinc.com>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
Content-Language: en-US
In-Reply-To: <20230717153536.25700-1-quic_sridsn@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17.07.2023 18:35, Sridharan S N wrote:
> This series add support for SPI NOR devices mentioned below:
> 
> gigadevice:
> gd25lb256e   - This supports quad read and uniform 4K-byte erase.
> gd25d{2,4}0c - These supports dual read and uniform 4K-byte erase.
> 
> macronix:
> mx66u1g45g - This chip supports stateless 4-byte opcodes, dual and quad
>              read and uniform 4K-byte erase.
> Sridharan S N (2):
>   mtd: spi-nor: gigadevice: Add support for gd25lb256e and gd25d{2,4}0c
>   mtd: spi-nor: macronix: Add support for mx66u1g45g
> 
>  drivers/mtd/spi-nor/gigadevice.c | 6 ++++++
>  drivers/mtd/spi-nor/macronix.c   | 3 +++
>  2 files changed, 9 insertions(+)
> 

All these flashes should support SFDP, thus you don't need to explicitly
define them. See
https://lore.kernel.org/linux-mtd/bfc85475bdcea46ea6c3ece98cc1e9cc@walle.cc/T/#mf79010e7031b03bda31690b4229a4f27f712f3a7
