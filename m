Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB6E755D80
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 09:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbjGQHvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 03:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbjGQHvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 03:51:37 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCD710D0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 00:51:35 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-52165886aa3so4132704a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 00:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689580294; x=1692172294;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uvg71QsN0uCFu9CbEe1Sgbll38wTsgcP92il4EjQ13Q=;
        b=afUDFnWslzRUMlvGsAyM5A/z8Bgtlq808C4XiCAFTBhDVGlcc1DArSGKnmTN18sx3r
         VdlQb7AHdvUMrbi/Uwwk0d1yLXJRa6NbD4LK0CW/kuR64GlgSMBp635g69iIEFyAza8r
         5TihJlZ37HbgiCIToe5/KsXb8leVQ5cvE1LPhPLYVSmL6aHHykf2G5sMW/hhyBf369d6
         gZzA4Q3O8kl3EWM7Shkp+smySIQDaWIdP6qWFbjMvOEiAblXtD0MTc++C7Cl7xs2EMsn
         2fUIRUfXW7fWLePSK3kWZ+8NTVP3nh+epbxz8zqqRV21SdlZfgKNF9mU0gFU6ahbmcAH
         4P8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689580294; x=1692172294;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uvg71QsN0uCFu9CbEe1Sgbll38wTsgcP92il4EjQ13Q=;
        b=cNUlnsBi2rqhJ0kXIzx1rW2MRxDYr7yekdo0nnJRu1Vsn0UveyEthat2hjHyVKIdDy
         YhkSWyQ3NvfhW0kWt5qz8Y+B8ayxAvMvu754WNTxenfhiSH3BtnPwgiV3ogSm/vhTeNC
         4OJ7nzaXK8w93+dsH4hDDLoc1ppU0DCjCX939jWwr402fdkPZHbFbqCC8OvL809FxUFF
         zTXn5Qc9hrgX7fzEQcunVs20iLY0OwyDDG1+3cCd0aDfmiK43F+5OxR0vkV6l4j6pVS0
         7JeJTiPzmRQw9pk1VyPu9XPfgq6ASHvyawhH5Rfyl14E+2AtmCyAL0nfZpk9xqeISDJL
         dzdw==
X-Gm-Message-State: ABy/qLau2Vl4saqc5Ao1ef4OlhfkcTxV0EUn+gq5GrTlZEj1Hs+gGOd2
        3NdHs0l5PzbWUeThwu0VqmY68g==
X-Google-Smtp-Source: APBJJlHmmTlSB2Ghvbk6jeJZtE3VwyqV0OVfQcEjYy7JfCuFCYa6mTUTHJIFKKAjd+BkT2SKHTXiaQ==
X-Received: by 2002:a17:906:2096:b0:992:630f:98b6 with SMTP id 22-20020a170906209600b00992630f98b6mr10600981ejq.37.1689580294094;
        Mon, 17 Jul 2023 00:51:34 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id u11-20020a1709063b8b00b0098e4aef0791sm8863674ejf.66.2023.07.17.00.51.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 00:51:33 -0700 (PDT)
Message-ID: <4963b85c-c0ff-92a1-e5d6-ca76f1882f93@linaro.org>
Date:   Mon, 17 Jul 2023 09:51:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/3] Documentation/process: maintainer-soc: add clean
 platforms profile
Content-Language: en-US
To:     dsterba@suse.cz
Cc:     Conor Dooley <conor@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Nishanth Menon <nm@ti.com>, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20230714084725.27847-1-krzysztof.kozlowski@linaro.org>
 <20230714084725.27847-2-krzysztof.kozlowski@linaro.org>
 <20230714135914.GI20457@twin.jikos.cz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230714135914.GI20457@twin.jikos.cz>
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

On 14/07/2023 15:59, David Sterba wrote:
> On Fri, Jul 14, 2023 at 10:47:24AM +0200, Krzysztof Kozlowski wrote:
>> +Overview
>> +--------
>> +
>> +SoC platforms or subarchitectures follow all the rules from
>> +Documentation/process/maintainer-soc.rst.  However platforms referencing this
> 
> Just a drive by comment, references to highly relevant documents should
> be clickable, so :doc:`Documentation/process/maintainer-soc` , with
> exceptions like if the document has been referenced already.

Is it needed though? The link is anyway detected by sphinx.

Best regards,
Krzysztof

