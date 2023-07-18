Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADDDE757782
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 11:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbjGRJNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 05:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbjGRJM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:12:56 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF0E186;
        Tue, 18 Jul 2023 02:12:55 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fb7589b187so8766462e87.1;
        Tue, 18 Jul 2023 02:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689671573; x=1690276373;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ddz5Teg3F/Td50LbJBAOhN/pYgovWCgEfCfYdK31aFE=;
        b=WrJ/4DJrAueAMkZpdITv8UUlp10+QeDa/Jklo1H2g3VbMLsLgQbOl0qaQq9jH6DEZg
         3A6A1mEfoqSNaA51JuJKjs9akhbgRqg7J0px44aDMbgB/0Hfd1YbFwnbY4fY4xtNd8ei
         x03DxeRpGhktwUBMmk9orNWp8/5W0Oft2Cq2rChZAYbFQmp3WHieCX05j5cd5n/4agkP
         6Dn049MuV4hPIgW/ONjui44dCw9tLVLxZL5G11GXcCoPb/tsKTsriHV1k9eNu5BpKyaY
         graAayYKPO0UyjDjxG+LAIHqXeiuawEtCOGVZMnjYChxf88VsFLC6BN44jW6W3Jx86fp
         bqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689671573; x=1690276373;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ddz5Teg3F/Td50LbJBAOhN/pYgovWCgEfCfYdK31aFE=;
        b=E6qIbhxK57+bXVEZnnHyekNnrwYN7ZZ/aj0FQ6pbZB3FAp6p7ZyCy0mQfc/T+R/y10
         /XJi7ofJf48bFfDvYIWqirHSow1atEglLSu2mELur5H2SxhsjL+ayXCrx0fQQAGxZTQ4
         cKVShK0geQchceDcGpsWl5/OxC0AS0NSip6Wbo/12f42PCHKD+CIRR9ocBpjkys6Ts1K
         bf2znAlNG8OyyhBl2wHcCovmsMJ5PwjhRFEgOlc6V+GzqwLg+KcuYHYPlnE5x7ZwETvV
         Eh3vu2bESJM/tSjY20W1sF9ZTWUKHJ001tPwYaRxD8H7vajaq57dnUmQJv6//SfTMNNX
         pf+w==
X-Gm-Message-State: ABy/qLbcEpYH6H1h9JQhVnHvcKmUOo6jehIFu5ul68CLIS365RErG4xf
        fI5EZQsvHplBHon2k6w6Bmo5DVPg6bc=
X-Google-Smtp-Source: APBJJlFBHgXpbjKvsg2fV5FIfmmDwomZh1AzvGxM1oKFoo6VhvA/pONRWlP7M29VuQGUXzpHlTl6dw==
X-Received: by 2002:a05:6512:2820:b0:4f8:49a7:2deb with SMTP id cf32-20020a056512282000b004f849a72debmr10375270lfb.8.1689671573333;
        Tue, 18 Jul 2023 02:12:53 -0700 (PDT)
Received: from [192.168.1.103] ([31.173.85.68])
        by smtp.gmail.com with ESMTPSA id t17-20020ac243b1000000b004faeedbb29dsm347416lfl.64.2023.07.18.02.12.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 02:12:52 -0700 (PDT)
Subject: Re: [PATCH] ata: remove whitespace after '(' and before ')'
To:     hanyu001@208suo.com, dlemoal@kernel.org
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <tencent_6714ED434F83826DD33A8EE7B99064165309@qq.com>
 <07f7ac9c59d027f959a69836fee9940c@208suo.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <5b055482-1adc-6915-b693-f3a95ebc64a1@gmail.com>
Date:   Tue, 18 Jul 2023 12:12:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <07f7ac9c59d027f959a69836fee9940c@208suo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/18/23 11:53 AM, hanyu001@208suo.com wrote:

> This patch fixes the following checkpatch errors:
> 
> ./drivers/ata/pata_sis.c:691: ERROR: space prohibited after that open parenthesis '('
> ./drivers/ata/pata_sis.c:691: ERROR: space prohibited before that close parenthesis ')'
> 
> Signed-off-by: Yu Han <    hanyu001@208suo.com>

   What happened to your email? :-)

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>

   Altho I'm not sure whether Damien would want to apply that...

[...]

MBR, Sergey
