Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921D27A53B4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 22:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjIRUP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 16:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjIRUP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 16:15:56 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4312110D
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 13:15:50 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-522bd411679so6331469a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 13:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695068148; x=1695672948; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M2m8Sbfwj+u+lTjFSP79r7yKZtx9J+wc0Oa9bsS9kLI=;
        b=IkQZv3hYill1oc2WZM3U2A6MzrRCHVOCHLqdsc2BMQnyo4dMUNktL2KwhgzSJPXsu0
         lOPlA1n/ha2zAHhX9i0fT43PjNPeGMafXVhD8NLXnSOQ9Yl+bPql8+attlACESQYQLzH
         +Pt2J26vcDlbOwgN/64tcScSHMJIFH6QczveNVJ32AlgIkAT9jjqXXaQsTvijB5eKQ87
         RGnBeg0QEv+5JqEFGScX77FutOAddfoFiAdpVBlxBFuMzWsvW+NQRWMcqV1u5ak4yZUe
         BsilOAZDjjFHPqFBDfO9rIY69f5dmr+7diNDvKrPCerMvqetM6S8P4zPQX/S95pGi6jP
         IIjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695068148; x=1695672948;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M2m8Sbfwj+u+lTjFSP79r7yKZtx9J+wc0Oa9bsS9kLI=;
        b=Rv/8/hZOFsVLE5pcZdZ5xTz6hunDkAGzFZKZjJJXde33nK476kfwcUPkdFgmNieiBr
         zMZ0O/zlZ0TLp9GGiqxX5/ZlYLz6ghRwLVuWNGIriIn5iXoXGojUddr0eT6LhbFEixil
         vAM1FmdwvRox0vaAhDtNfczpDI952YE2f0EsfMhYg+uwpc2DYj+wxvqrkTy4dDu1Umvx
         zeYeMVQVkro2ravtfvkpNwkrmbc2ULqnlrfKPKNkKBoXZElR/PWny1nNJnwbvcI8xWoV
         FuIrAAwT4qiGC9QHsvfwqY2JbHR+bouairyL9RAdUtvvvcOFQq4ZDcOIw8Llpu1a8kSg
         VuvA==
X-Gm-Message-State: AOJu0YzJtlg3lRLX0JkAze20HTcoUQ+Iww4DfSm2u9jn54DVpigWqJOu
        vc/b6ef4KvyXmarUis5CrmCQcw==
X-Google-Smtp-Source: AGHT+IGpwXjOHzqhVz9BxHPwLWhbOmaxmMQnWiyGQWOBpz6HZ2COGji7alRXtAxTCpE7TM6YqLpCQA==
X-Received: by 2002:a05:6402:4492:b0:531:9c1:8271 with SMTP id er18-20020a056402449200b0053109c18271mr3914020edb.14.1695068148443;
        Mon, 18 Sep 2023 13:15:48 -0700 (PDT)
Received: from [172.25.80.114] ([217.67.225.27])
        by smtp.gmail.com with ESMTPSA id dk13-20020a0564021d8d00b005312b68cb37sm1297313edb.28.2023.09.18.13.15.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 13:15:47 -0700 (PDT)
Message-ID: <0f25cc55-b353-9bec-009f-589b04e36cb4@linaro.org>
Date:   Mon, 18 Sep 2023 22:15:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 09/12] dt-bindings: serial: snps-dw-apb-uart: Add Sophgo
 SG2042 uarts
Content-Language: en-US
To:     Chen Wang <unicorn_wang@outlook.com>,
        Wang Chen <unicornxw@gmail.com>,
        linux-riscv@lists.infradead.org, conor@kernel.org,
        aou@eecs.berkeley.edu, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jszhang@kernel.org, guoren@kernel.org, chao.wei@sophgo.com,
        xiaoguang.xing@sophgo.com,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
References: <20230915072517.118266-1-wangchen20@iscas.ac.cn>
 <c4aa8d45-1248-5656-a045-a475ec737c0f@linaro.org>
 <MA0P287MB033226287163E5E20485433DFEFBA@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <MA0P287MB033226287163E5E20485433DFEFBA@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
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

On 18/09/2023 14:49, Chen Wang wrote:
> Hi, Krzysztof,
> 
> I see Emil has clarified in anther email, I copy it here for your quick 
> reference:
> 
>  >Sophgo and StarFive are not the same company. Sophgo are using RISC-V 
> cores from T-Head and StarFive are using cores from SiFive.
> 
> And SG2042 is chip from Sophgo, and JH7100 is chip from StarFive.
> 
> So I think it should be better to use a new entry for sg2042, what do 
> you think?

We talked about different things. Previous discussion was about
compatibility. Here, you should just not create your own enum, because
there is no single need. Just put it to previous enum.

Best regards,
Krzysztof

