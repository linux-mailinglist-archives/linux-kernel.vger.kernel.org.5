Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B1E760FA5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 11:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbjGYJqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 05:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbjGYJqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 05:46:34 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724A711B;
        Tue, 25 Jul 2023 02:46:30 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-313e742a787so3393289f8f.1;
        Tue, 25 Jul 2023 02:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690278389; x=1690883189;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x1dn5lNZqmwY15rBpdBpJTcWOK1VivmrD2jmZ3IZxi4=;
        b=Z51pyJ5/nycopIH5zIHEHDVQYAq2V7diulALk4BHl55COuR7x6J3JGUbbWKheci3xm
         r/E9pwlUU3X/vKswxR1612lmt3jgGeAkK5G3sswsGwgGUMJoExBpw1iiunb4qPGV4vWn
         L8RnuaU143TlsB1OPR9NN5V9HtbJxVHwiKOWB5i44PKcRKpD6v1PC6diyvYqiL7ca+TR
         Zpr0I0PtBzXF/d2NnxjUBkIk1/0PFNiGZjKufaiWoBca0thMIkaE4qZyYY2/m1WD7pL/
         lXdLZAjx6nf4QnTgNRz0gfeHhbMp/JaSAjCzIvQ46qXSJalSw54O7cCoKzTlinyTMB1Z
         9RGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690278389; x=1690883189;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x1dn5lNZqmwY15rBpdBpJTcWOK1VivmrD2jmZ3IZxi4=;
        b=NW3n+SIdNP9xThCogwNDqBcy9AeTZr5+n95xDntktA0aqbxePNwqyFf0+gmQC1Mr7u
         zFSkEpllE8q9ATGha5wgoW08e8j+CC19thMmXzDXjq6zVCK2ZPJvCYfVoq7VdIl3C9jv
         hSWzKgcU7A9VTjfelsVxwejc14jfBzAWEsVhECqfXBZ3iJgjLasHM+31OKYJqc1Dvjdf
         yayK9uxX3GkKVwXJxQhscGFGJm6l13VcEfB0tSH/wbZ3Wtvl1vN1st+PC2Nk+VACuxHu
         //LSfDx0Gn60cPxoDcnuZw5TNZOY0FFpMLdOEaooUuwy6jWpsWvMOTfy8lozq4siTrrw
         TYRw==
X-Gm-Message-State: ABy/qLaguNYFuCjDKGd4WhS8xe8GFYKwO/VB/WQApipeTvmm9FKG4IIx
        3M0+srKdRQzOlvPntBudjF8TGnxCkpTAqw==
X-Google-Smtp-Source: APBJJlEssHXAU9u+CHEEFVKJsaYPTIj+RSJJ0AdcGXaasOWgN4UXMrXvvemxECzYlMn5VGYiBrXiIQ==
X-Received: by 2002:adf:f8c7:0:b0:311:360e:ea3a with SMTP id f7-20020adff8c7000000b00311360eea3amr1706865wrq.34.1690278388631;
        Tue, 25 Jul 2023 02:46:28 -0700 (PDT)
Received: from [192.168.1.107] (ccx116.neoplus.adsl.tpnet.pl. [83.30.147.116])
        by smtp.gmail.com with ESMTPSA id q17-20020adff511000000b0031272fced4dsm15728148wro.52.2023.07.25.02.46.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 02:46:28 -0700 (PDT)
Message-ID: <6008bc09-7746-546f-2c00-9b9812854ff7@gmail.com>
Date:   Tue, 25 Jul 2023 11:46:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] arm64: dts: qcom: msm8976: Split lpass region
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230723160827.22660-1-a39.skl@gmail.com>
 <20230723160827.22660-7-a39.skl@gmail.com>
 <fda13f70-1062-c3dc-b3ed-c7f1ad9a07db@linaro.org>
From:   Adam Skladowski <a39.skl@gmail.com>
In-Reply-To: <fda13f70-1062-c3dc-b3ed-c7f1ad9a07db@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 25.07.2023 10:44, Konrad Dybcio wrote:
> On 23.07.2023 18:08, Adam Skladowski wrote:
>> Some devices like Sony Loire uses Broadcom module over sdc3 however others
>> utilize qcom WCNSS, split shared region based on downstream pil-tz loader.
>>
>> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
>> ---
> Looks like 0x1800000 is the generic configuration:
>
> https://git.codelinaro.org/clo/la/kernel/msm-3.10/-/blob/LA.BR.1.3.7.c26-05300-8976.0/arch/arm/boot/dts/qcom/msm8976.dtsi#L93-98
>
> Konrad

Yes, indeed however as you probably noticed this region isn't called lpass rather reloc.

Downstream sometimes tends to define pools of memory where loader will do its own job.

If you read later wcnss/lpass both point to same shared memory which im not sure without reworks will work with mainline.

On top it's not really that it will even hurt Loire at the end, if you browse around internet you can easily find gists
from Pavel which have logs of pil-tz loading of lpass:

https://gist.github.com/bartcubbins/c2ff215f39fe2b3ed5d3f8444bcec83b#file-gistfile1-txt-L1289

As you can see even on loire where region is bigger it only loads first 0x1000000.
Do we really need to complicate things just for everyone else for sake of not ending with one platform having to adjust
or even not(it probably wouldn't even make a difference for loader as it will fit anyway)

On the ending note i apologize if this msg gets broken formatting first time using thunderbird
and after redesign im unable to find most options mentioned in guide.
.

