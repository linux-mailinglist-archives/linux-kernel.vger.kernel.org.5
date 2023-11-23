Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7AA7F62B0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 16:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346075AbjKWPYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 10:24:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346082AbjKWPYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 10:24:07 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2E210F1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 07:24:11 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-332e58d4219so299412f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 07:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700753050; x=1701357850; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qEinn40liA1Wq5VZRVw57Dr0obouosWn9g7g0dlK6JY=;
        b=OGQl0c5ODriWH9Idn9Depm4X0hGii8sSYPfyBXkfxNAB9bBNaUX/fXi/tZgZMyfHrH
         adhe1JLHXd1sDjXPwUGyO+kUVcF461SLrRP1343CLrFOBmDv0u54uL6ODquq0jdasBGT
         dA9E/7YwJboDhNgccLH1Gnss9jbIPpX5jmxCfsoFrCPoU/cJ+pF5YNCpbXEQ9cnqIKSq
         tdbdoOAOFxG0eLk1gBVux+2AAkS3zFzK5d3bggRj+tDl3GLZcUHpZfyuHwCluqjqCHTM
         UdazQm06dBHVHdKwoYI6udf6x0ByLIwAR365jLn65gsoHhvX5nGR5o92S6jCoIBSRNx0
         zo/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700753050; x=1701357850;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qEinn40liA1Wq5VZRVw57Dr0obouosWn9g7g0dlK6JY=;
        b=tQtQCXjApTLTmoEbDQuVb2gB9yTAuFVHsywjSFsvlLL2OozkFg3Qtz6PcK8CycMGFg
         1v6/mX7bSwXzMW8r42P8CBSFUlEAzRFFBUkyRTEdOYsQyI1C8qMzerccwyzBOA5rmOK7
         wHZnWg/rXBmPEpAzILsZKvODxaBjhfIrxYtQcWs4NDi9n90gz84fVNUxgPumfH4dA4gD
         EJxatThAelg+WB7/pYggb3/ZaV2ZzU2xjOlTqBe23dUUFMWrreJwYx2rUnERDv504n2n
         A5709dha0/bs5pREVBRWqfFjSYHmQgD6QEBe/xgygilEaewvw9MBrCxSvp8Z+/3gOO0Q
         yfaQ==
X-Gm-Message-State: AOJu0YxsBHMZm7458E47u3pXOeAInnRsIuIeXMdJZHldYcCMHpUIiVHe
        B8L5N6W2M1/2CB8Q7o3fuE9Pog==
X-Google-Smtp-Source: AGHT+IH7pTy4FnZhd4fKfF3loD/98TfZSI67b0QPFriXigNT+iLnOj7QEw2V/Yr34spAxJ4w73j4Og==
X-Received: by 2002:a05:6000:4028:b0:332:c593:16c with SMTP id cp40-20020a056000402800b00332c593016cmr3974822wrb.45.1700753049772;
        Thu, 23 Nov 2023 07:24:09 -0800 (PST)
Received: from [192.168.100.102] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id n7-20020adff087000000b003316d1a3b05sm1880623wro.78.2023.11.23.07.24.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Nov 2023 07:24:09 -0800 (PST)
Message-ID: <754f279b-dbe4-46fa-95c9-2cae0481584c@linaro.org>
Date:   Thu, 23 Nov 2023 15:24:08 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/7] media: qcom: camss: Move VFE power-domain
 specifics into vfe.c
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        matti.lehtimaki@gmail.com, quic_grosikop@quicinc.com
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231118-b4-camss-named-power-domains-v5-0-55eb0f35a30a@linaro.org>
 <20231118-b4-camss-named-power-domains-v5-4-55eb0f35a30a@linaro.org>
 <84a97960-dfef-4d2f-8462-d3acb6f5a125@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <84a97960-dfef-4d2f-8462-d3acb6f5a125@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/11/2023 12:04, Konrad Dybcio wrote:
>> +    const struct camss_resources *res = camss->res;
>>       int i;
>> +    int vfepd_num;
>>       int ret;
> Reverse-Christmas-tree, please

yes but ret last
