Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B4F75A6F4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 08:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjGTGxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 02:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjGTGxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 02:53:50 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CAB9E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 23:53:49 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fdd14c1fbfso669728e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 23:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689836027; x=1692428027;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dTYti2msJuMkF2fFgZqBRwaKrMax7bGDLlfMmplPvvg=;
        b=wJJ4ewUjsh7r6wUXj7VvA3lxXNye1xdJbhbWKFSZUQtqd4qMg7HxeHfrILhUhvjUyR
         c8J78mKuixnMCo58ZCECxq52INslKpDiFcMUg9gpLc7Im8nP/ExdrLcdggVY907gVpqQ
         zcWELNFYrPPyhH4v2ZL61dGCcFc2PjqfO8D1yvtBEhA+6ydMPmnTDpRBI001Dak1/nfG
         6AmLTLnW34A4nv1lHozibXkwrCqLHpcfc7rbta/3/dZA2NWQT+EvXKtRIiMNluLYiJSh
         475Aag7ZsW+s9atyLlsJDFfACg37JhJ3TutBl4AN6LNX+5TxGH082CZzJegvQk8yG/Xe
         J1tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689836027; x=1692428027;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dTYti2msJuMkF2fFgZqBRwaKrMax7bGDLlfMmplPvvg=;
        b=KQJTK1F0RGzmwAEUM3dfjAxhGU+CyZN9AqhCI50tOTMoAg94WE5vl8NfsyTPzj+8M7
         +On4AVap+6FvN8twOm9HcIX8P0XQaRG/3L6kB9bjN0sQEjY+tptk5gpx9Gt0svI7TyN9
         aD2SUTqrgeh5asbhKmsNS1Fv1Mx3WNz1xUXUWDJSDAafT0UqGkqkKq/iwn4si452XidG
         niZDTEM0K9bsuhZINxUdXdNZpJbWnKMPq+AsKFwCVfysYR1+e8kUIL/XVH/Z4Cri6z9A
         Ui/5k1tyaafsvaQDbWEJIA/ufk4rw7k9vB5VvbeSKNdtr25PXPeZO4Xa0fBhFYGYVTcv
         qZlA==
X-Gm-Message-State: ABy/qLY4XWrFsHnmxpL7cnNdKGi0FYqEMJw2K5aeluE+SW4yGi5FoYfT
        rfgXzX6+S3VnlSFlqyjW7mVW7g==
X-Google-Smtp-Source: APBJJlEbfLygNs+/rmSsrdJE9i65NUF2ppc8cecofdF2ORYAIysqb44pU112yXKT82GnEgHOdGNMBA==
X-Received: by 2002:ac2:4bd2:0:b0:4fd:d0d5:8771 with SMTP id o18-20020ac24bd2000000b004fdd0d58771mr1917762lfq.18.1689836027458;
        Wed, 19 Jul 2023 23:53:47 -0700 (PDT)
Received: from [192.168.0.107] ([79.115.63.16])
        by smtp.gmail.com with ESMTPSA id t8-20020a1c7708000000b003fa74bff02asm418605wmi.26.2023.07.19.23.53.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 23:53:47 -0700 (PDT)
Message-ID: <c88f0e23-124f-cd29-7ea3-bfe152291b69@linaro.org>
Date:   Thu, 20 Jul 2023 07:53:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V1 1/1] linux: drivers: mtd: spi-nor: gigadevice.c
Content-Language: en-US
To:     Victor Lim <vlim@gigadevice.com>, pratyush@kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        akumarma@amd.com
Cc:     michael@walle.cc, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, vikhyat.goyal@amd.com
References: <20230720042834.12296-1-vlim@gigadevice.com>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230720042834.12296-1-vlim@gigadevice.com>
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

Does these flashes support SFDP tables? Here's how you can
determine that:
https://lore.kernel.org/linux-mtd/cover.1686557139.git.Takahiro.Kuwano@infineon.com/

If yes, then you could use the generic spi-nor driver,
thus you won't need to explicitly define flash entries.
See:
773bbe104497 mtd: spi-nor: add generic flash driver
