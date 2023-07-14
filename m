Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E2775329F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 09:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235210AbjGNHLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 03:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbjGNHL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 03:11:28 -0400
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396991727;
        Fri, 14 Jul 2023 00:11:27 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-4fb41682472so2488775e87.2;
        Fri, 14 Jul 2023 00:11:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689318685; x=1691910685;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b5iPI8hWmCK9XFWSynDHqauVU6Gjyq6if7QTIUYaQJU=;
        b=JSE3eIGNPl0c0ctWBKoX/HMro9ZcaVpq2/fkTRsGPgRPD/rRR3nm3EdYCkeBV07BsI
         Vrh1RS3z0C58hd9k7ym8SPCPpoQSLxHv8+wWCh2XnltRLNZg677ApsEPCE17sELRQS28
         8QcG8dvAxbBNWFkfwPfZiX8zmP9FLR7VCGVltVz/FVpkMxP/y5jmzn/GSERGE+cYV1pD
         0yc5K8yFn7OO1TRcoHP1VGCZ1aS4BVA7oPiE7HjTdGCaAQOMJrvCTL1QQmI3b9dExVHk
         X/c1qoYLxr+G/wqyICO2mrJ3RN+0BShwEwmYlXbbuH1HMmAEzfK/G24wT4Ml8lhtIJmB
         MgDA==
X-Gm-Message-State: ABy/qLY+9w1+AZuwfcTeTzf+EfyJEEjVEeX/ARCLyOXT53RzgKcRn+pe
        DPWjGF25XsMkEWubiOLTTaF9lKGSWwI=
X-Google-Smtp-Source: APBJJlHZDogVIK3v5qJxwOJsO5cLmycgyqXASWgNpNGCcQa9GK6FtgtYSuxqcBnCJKpeJnpyzoeuNw==
X-Received: by 2002:a19:6507:0:b0:4f8:5713:7dd5 with SMTP id z7-20020a196507000000b004f857137dd5mr2985939lfb.10.1689318685209;
        Fri, 14 Jul 2023 00:11:25 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id w22-20020a056402071600b0051de3c6c5e5sm5299564edx.94.2023.07.14.00.11.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 00:11:24 -0700 (PDT)
Message-ID: <0eabcf39-dfd3-bff9-5d61-ff8fca7e3ba1@kernel.org>
Date:   Fri, 14 Jul 2023 09:11:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5] wifi: ath5k: remove phydir check from
 ath5k_debug_init_device()
Content-Language: en-US
To:     Minjie Du <duminjie@vivo.com>,
        Nick Kossifidis <mickflemm@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kalle Valo <kvalo@kernel.org>,
        "open list:ATHEROS ATH5K WIRELESS DRIVER" 
        <linux-wireless@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     opensource.kernel@vivo.com
References: <20230714071002.1264-1-duminjie@vivo.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230714071002.1264-1-duminjie@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14. 07. 23, 9:10, Minjie Du wrote:
> 'phydir' returned from debugfs_create_dir() is checked against NULL.
> As the debugfs API returns an error pointer,
> the returned value can never be NULL.
> 
> Therefore, as the documentation suggests that the check is unnecessary
> and other debugfs calls have no operation in error cases,
> it is advisable to completely eliminate the check.
> 
> Signed-off-by: Minjie Du <duminjie@vivo.com>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

thanks,
-- 
js
suse labs

