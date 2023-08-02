Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486E276CC20
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 13:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbjHBLzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 07:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbjHBLzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 07:55:24 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B8610C1;
        Wed,  2 Aug 2023 04:55:24 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-52227884855so10286610a12.1;
        Wed, 02 Aug 2023 04:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690977322; x=1691582122;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fg0YpcOtBUtEKMYPGJH2ccsPOpJLUWE6oV7KZ4RIkBY=;
        b=sxL8jAWNHpZKH1kgVp7WtInxNhdYc10cPQtW3bdSnBLzYGpKwexkVHPruJSFotXs0T
         LxjVyz0nsjFZgw0khNVJC8M822cUyaPZaoWmMtiam52oW82Fi48M3tsAbM0bbd76v5Oq
         gsfvJtYlTlfoIhJDStqNNjrcs3VK7zNSUiR8NkUO4c4wMYDWRAp0/peP39FfNmF8PVnA
         9qBjrofEzp5O9eQdTJAsDlNDdIznk+Gkc/Vc/ZYgc/F9Vsmzn3DqrHlalPiVc1/c9UBO
         DFfm5uk4anZpqbGobIGzqC84wzWIK5yglQovCxQc9y7ziH/qTr0Lmk7ssHqjBvTB6lra
         LQdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690977322; x=1691582122;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fg0YpcOtBUtEKMYPGJH2ccsPOpJLUWE6oV7KZ4RIkBY=;
        b=OTUsAaeDctOwsDmyxoxZQW8G3K8PN/FfwuCoUXFEHWU8hskTAkW7NSl8cNLctuKrL8
         SLujEA2R02qu+nfcBDXIo+HOzW5xitg6ifBiLBks0df4KJW1nNZsRM57bsx1jmZnyFPA
         EDaHQm0PCSsELzch4rQjtM0dHNbgaxa0MObQkIV2pEG/J+9eeiTqVCqJUTdX9uUnaWxp
         u7I+7kkvaRndPDKQsmnggAKa/fEBZ1nT1vnMFAXirVyvy/hKEGAwDJhVEmdYAq1gM1/F
         ui7yBSK/1YoK2hjqTuBzTInkTWaKyC8oyZ532/s6WHN3mW5FV3DJbZ/zzy1LZow/batg
         2OLA==
X-Gm-Message-State: ABy/qLZxEC9//0C/uGijQSsrebdyPSwRd0zMQH7unqmixzLtJBqij+o1
        uGiwhB4Gks0cgIB1etQKR57js9y7O9s=
X-Google-Smtp-Source: APBJJlFAdvAaDjxvCM5PvcAsGwsuvHU/MEEusmZmMUEt48yqwiy3h8p/XqFqbmX/s9jRY4+xORcupw==
X-Received: by 2002:a05:6402:8d5:b0:51d:d4c3:6858 with SMTP id d21-20020a05640208d500b0051dd4c36858mr5012317edz.12.1690977322422;
        Wed, 02 Aug 2023 04:55:22 -0700 (PDT)
Received: from [192.168.1.19] (62-73-122-38.ip.btc-net.bg. [62.73.122.38])
        by smtp.gmail.com with ESMTPSA id g12-20020a056402180c00b00522ce914f51sm3823937edy.67.2023.08.02.04.55.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 04:55:22 -0700 (PDT)
Message-ID: <21fad6fd-eddf-9edd-6dd8-58a32b9be9ef@gmail.com>
Date:   Wed, 2 Aug 2023 14:55:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] media: venus: firmware: Use of_reserved_mem_lookup()
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230529-venus-of-rmem-v1-1-dfcdc5047ffb@gerhold.net>
 <ZMoak_qaUSX-pkP2@gerhold.net>
Content-Language: en-US, bg-BG
From:   Stanimir Varbanov <stanimir.k.varbanov@gmail.com>
In-Reply-To: <ZMoak_qaUSX-pkP2@gerhold.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephan,

On 2.08.23 г. 11:57 ч., Stephan Gerhold wrote:
> Hi Stanimir,
> 
> I see that you already tagged the Venus updates for 6.6, but could you
> try to still apply this patch as well for 6.6? It's a requirement for
> some DT cleanup I'm working on and ideally needs to go in a kernel
> release earlier to avoid bisect problems.
> 
> AFAICT it's been on the list for more than two months now with two
> Reviewed-by, so should be fine to just apply it. :)
> 

Done, thanks for the reminder.

-- 
regards,
Stan
