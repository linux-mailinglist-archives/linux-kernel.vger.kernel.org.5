Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3547AD043
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 08:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbjIYGgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 02:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbjIYGfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 02:35:54 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3EDCF;
        Sun, 24 Sep 2023 23:35:45 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50437f39c9dso6662001e87.3;
        Sun, 24 Sep 2023 23:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695623744; x=1696228544; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XdVp8fabZrl+SetbhyIwcfplRAGrgJKdiRNDgwwsIts=;
        b=c98MR4y/+gV/jfdxnD7jHhVs2a7uzLX8KxBti8T3VwDmbgyPaW2oJQdMXSoe371ow+
         rNtXzuggOXNmXxXklNTkgzwThMxKSPsrEpUiT9+GiWJLoOnAsgd1cYD4SVnldAhCVQbV
         NzFszOo0THs6ly6br/DFMZKd59S/x2Le1bs3IXaxMBxlx7lsRerCzA2znWFMQlKTTk30
         1s4B+IxMMtw8cyaIoL1uNMoOVSYGqyDd4z26iDxUkFXdl/NTV53ByQc6BaEL5exvkTIx
         0y4gK1dRi3HYzOn8Et8PWU+hOcrHbsYeecWCBw2OwAwIGdwm3j0jl5NEbDjBYAw7GDg/
         Cebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695623744; x=1696228544;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XdVp8fabZrl+SetbhyIwcfplRAGrgJKdiRNDgwwsIts=;
        b=bGmhF8PMIa9Pn8QeTZ2sj9VPec2rN9TIUqM4zuC8suBW/cl3cxg+hhgi8ux5bDrTJ7
         KIZmugJrIsyTMFSzOI3LE5KuB7XuupGa+gnRUQdF/na3k0ywdQNjIWGdOylHlPCfbwUm
         aWGQRVHf4MlSrCKtCBYKbP3pkO5nalCHLhAXBjbi/80iEgN3/8VcRwcvi1Ls49jie2EJ
         gM70SjfcwbJoMngtj7wPwXGltqzLByk6hku6Kco/kHc5Do8ItfToYuqwdHKeB8Akqzq0
         BE0k/jJVS/VI5ZJlhHQFVgN5smJFg8iL2F2k6VgUZSUSinHjzsJZ9d6IFOm83xnX68Pb
         FXYg==
X-Gm-Message-State: AOJu0Yz5FNjjVF+IFncNbL2piMJgrOhQj/uVKD0dwgOFNnwJqJ90bwao
        dHISaaEtS0YEhaXgAOIii+0VS/BjJEQ=
X-Google-Smtp-Source: AGHT+IEZQJlUOwrQ/1uHkcqDpKZKmdLFnmpC+JeDRRVV2XBilkNnduNyMZVzgX5x3uTMWVKJ0OF5PA==
X-Received: by 2002:a05:6512:e85:b0:500:adbd:43e7 with SMTP id bi5-20020a0565120e8500b00500adbd43e7mr5490959lfb.8.1695623743244;
        Sun, 24 Sep 2023 23:35:43 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f8:1500::1? (dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::1])
        by smtp.gmail.com with ESMTPSA id r28-20020ac252bc000000b00501c1794883sm1717087lfm.251.2023.09.24.23.35.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Sep 2023 23:35:42 -0700 (PDT)
Message-ID: <59000a48-cb01-b92b-0a36-24227a990976@gmail.com>
Date:   Mon, 25 Sep 2023 09:35:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Andreas Klinger <ak@it-klinger.de>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Benjamin Bara <bbara93@gmail.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1695380366.git.mazziesaccount@gmail.com>
 <20230924165331.6df2e9c1@jic23-huawei>
Content-Language: en-US, en-GB
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v3 0/6] Support ROHM BM1390 pressure sensor
In-Reply-To: <20230924165331.6df2e9c1@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/23 18:53, Jonathan Cameron wrote:
> On Fri, 22 Sep 2023 14:14:52 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>>
>> Revision history:
>> Major changes here, please see the head room of individual patches for
>> more detailed list.
>> v2 => v3:
>> 	rebased on v6.6-rc2
> 
> Stick to rc1 though I doubt it makes much difference.

It shouldn't probably change much - but it 's still good to know -rc1 is 
what you'll stick at :) Thanks for pointing it out.

> The IIO tree
> will remain based on v6.6-rc1 until it is rebased after Greg takes
> a pull request.
> 

Yours,
	--Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

