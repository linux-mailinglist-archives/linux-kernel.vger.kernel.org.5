Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D69D7800F3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 00:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355695AbjHQWRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 18:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355701AbjHQWRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 18:17:08 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFA8100;
        Thu, 17 Aug 2023 15:17:07 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6bcde3d8657so73336a34.0;
        Thu, 17 Aug 2023 15:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692310626; x=1692915426;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T5MAncDaZGexQ1tmu5Qrgy4pmPtweT2noBzMsUBFHqU=;
        b=UsxQgwNbeSqbLD9EGDrOiWwGxW+5dJfY39o357kzuUKu/gjaANup3lHFlJ/Ps6QX8K
         2AZ8HrigZzFcBP3JYNS/6Ay6mWcZxl8+KCdJUuGoRYZl40bC0UmRVtF+1fR2/c6hf4Or
         ZM1KX9TDUcHhnOpA5aRspQ6MQ2fCAuHl7JuqQBoGfwiIKDv/PvtkkQeWccFoFkfoZBKa
         8xgZvPoIKiE89xyGsMjHo9pBPRDTFBj9+cPsWcjQB5vS+eko5UBankWIT7ALx6NjRRDK
         G1+pJvllNCgQlaA6j99RmzvVx1quLhtCSwZKMw/AuORmbRXhPCliuePqvlSf3h+M5OHX
         b1UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692310626; x=1692915426;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T5MAncDaZGexQ1tmu5Qrgy4pmPtweT2noBzMsUBFHqU=;
        b=dWIJ8fppDhrVe9I0z1rFEh5cDYTSW57Opg9kFOqu8G8hVtzdhSTQBCTSY5kTgcLEHF
         EPzOhk55G+JlFIvdwBJckaNHcLJTnNrchHY0rqsFjoK0jpbqWsWEGhR7JM0RqM8g9/Ip
         sIL8B/JFnbYvyB3NZLD2gOcrnFmkjypTZHGizLnQsc2I6QodxRF8aNVfICqq2PKNEftF
         +MsGgLzr5OM8SWt+JU0WdMqPBeraEG29j60K4ra6S4nozmf4SMcUKZYs+tZ6IYIlnOGG
         ilJBBeysMxgexXOLHNIs5ywBqnQTMrslv91oXJwyt5DNd8XFlOPP7ALucrFuW/9Pu5Ys
         TETw==
X-Gm-Message-State: AOJu0Yw710d7M5o7zSPR780Pvv2UKbQ328t0jfTCRtkSxWQ3eAPMbG02
        mEWXD5f+TQEI5xOptnfXJdtm1UHIXpU=
X-Google-Smtp-Source: AGHT+IGIJKVg8WcFDAVKpuLsaZKuRmduwyuqoLk3eEzOOtHYE6jY0vAAMvkGW3kOA24i3aV8AfExkQ==
X-Received: by 2002:a05:6870:568d:b0:1be:f764:2887 with SMTP id p13-20020a056870568d00b001bef7642887mr812902oao.2.1692310626410;
        Thu, 17 Aug 2023 15:17:06 -0700 (PDT)
Received: from [192.168.0.82] ([67.6.79.63])
        by smtp.gmail.com with ESMTPSA id e9-20020a0568301e4900b006b58616daa1sm300170otj.2.2023.08.17.15.17.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 15:17:06 -0700 (PDT)
Message-ID: <500b52ee-02e5-4809-b03b-21a9ad6d2b30@gmail.com>
Date:   Thu, 17 Aug 2023 17:17:05 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/2] Input: Add Novatek NT36xxx touchscreen driver
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dang Huynh <danct12@riseup.net>,
        Amit Pundir <amit.pundir@linaro.org>
References: <20230808-topic-nt36xxx-v10-0-dd135dfa0b5e@linaro.org>
 <20230808-topic-nt36xxx-v10-2-dd135dfa0b5e@linaro.org>
 <2980f5e6-40b0-4ab2-ae73-bceeb97b4de5@gmail.com>
 <17542518-42ff-46f6-8304-fb8a214bfa77@linaro.org>
From:   Joel Selvaraj <joelselvaraj.oss@gmail.com>
In-Reply-To: <17542518-42ff-46f6-8304-fb8a214bfa77@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konrad,

On 8/16/23 12:36, Konrad Dybcio wrote:
> Do you have your end outcome somewhere?

Here is the driver changes on top of upstream 
"drivers/input/touchscreen/novatek-nvt-ts.c"

Link: 
https://gitlab.com/sdm845-mainline/linux/-/commit/d2f7702a7f6a72eaf2655840036668398942c194

and here is how I specified it in the Poco F1 dts:

Link: 
https://gitlab.com/sdm845-mainline/linux/-/commit/4dd6e4578cc737d2584c7f9657f9f185effe9035

Regards
Joel Selvaraj
