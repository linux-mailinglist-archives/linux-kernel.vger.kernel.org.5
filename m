Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032C97725EE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbjHGNhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbjHGNhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:37:20 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56ECB3
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:37:18 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fe457ec6e7so7450397e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 06:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691415437; x=1692020237;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SLFeqNP9cvX5rxBkjJIc2Q28m18cFPLW2YKzn9uUvsk=;
        b=j4kCpCB2yBX9es+3hToWz8jnruUULyAzBB7uD2PMluCQdeoz0Y+qZsdWyhDQjvxYkE
         jb3MhkvPupayFBJ1VjMDaT4QALdIH0KZrD+y3UcJgvgEkwYG4EXHksxpjNzLWc/O7ydd
         36l1gbyPlK8cMHoDuzUxwYd+GZNCZjTDPp4qXxoHIUg3ZB9PTsrl79cwNvxu3vB9sCbV
         3/xyhXnFHKKFD2uXu9HFGWymrP80t5zXSftVZMozSzpSWoijo7ILZa//NEi6Gi+kBp9j
         Vy+QdB9f1dAwRZdeaIuCf3gKNZpeT0uAUemtRwzJbYUHBQlPyf374ySSlk1EWlFeYl2w
         Z1Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691415437; x=1692020237;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SLFeqNP9cvX5rxBkjJIc2Q28m18cFPLW2YKzn9uUvsk=;
        b=Cidoa9REZa59AMZX9Eq8oVjHivhGMh0me/RSGeDVTJpo+3h+F1rWiWsBNC/k7NPm4J
         6jSdGmLgWls2mEs8NOGetQBYFbZ5HBJ4lTnAIvHihwdIcCi6rMhyTBFlTkZKz55VmyQ0
         WlK/1yhW+zi0A7VbJkUpdPE7h0cVNGVoClIc5NoLxhuA9SklkFADzTnZMxMn0jBmqjvi
         29rCkpzhtLQA+GE3g4HsH3iZ1kM/01YxVP2xvrV/zMmHjn6b97FGqE9ldKmasZ+diq08
         HDLAw95EH+ugkFkxi3XjweOFdS8lbuacDuY0ovdyezzMPIJR64qsTC1jqI18ZE+c9zbx
         ppWw==
X-Gm-Message-State: AOJu0YyadRTkhyBIL2UPiYdMMEGNelgSCe6guplZGFdwwiHgfQOI6mbq
        pxmjaswZL9lxudz3yfQpTIr0+KgeNf/5LEZRV6Q=
X-Google-Smtp-Source: AGHT+IE69Cn2n8J+ESAx6ju+5o6E7v+QPH5RgfcqhGFZDx1TZVMcUJlmxYUuGcOntUHFSX2cZCgKsA==
X-Received: by 2002:ac2:5b8f:0:b0:4fe:676:8bf2 with SMTP id o15-20020ac25b8f000000b004fe06768bf2mr5602260lfn.10.1691415437076;
        Mon, 07 Aug 2023 06:37:17 -0700 (PDT)
Received: from [192.168.1.101] (abxi185.neoplus.adsl.tpnet.pl. [83.9.2.185])
        by smtp.gmail.com with ESMTPSA id d6-20020ac244c6000000b004fe4833ca5csm1507832lfm.237.2023.08.07.06.37.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 06:37:16 -0700 (PDT)
Message-ID: <7ed38a0a-371e-4c43-b90f-6b1ec13f626c@linaro.org>
Date:   Mon, 7 Aug 2023 15:37:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: arm: qcom: add sc7180-lazor board
 bindings
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>,
        Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20230804095836.39551-1-sheng-liang.pan@quanta.corp-partner.google.com>
 <20230804175734.v2.1.I7a950de49ec24b957e90d7fe7abd5f2f5f2e24c3@changeid>
 <CAD=FV=WKPu2R_j3yh5OJcc95SmxgJsc3+HxSi9_Ks6TvUOYJ1w@mail.gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <CAD=FV=WKPu2R_j3yh5OJcc95SmxgJsc3+HxSi9_Ks6TvUOYJ1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4.08.2023 18:30, Doug Anderson wrote:
> Hi,
> 
> On Fri, Aug 4, 2023 at 2:58 AM Sheng-Liang Pan
> <sheng-liang.pan@quanta.corp-partner.google.com> wrote:
>>
>> Introduce more sc7180-lazor sku and board version configuration,
>> add no-eSIM SKU 10 for Lazor, no-eSIM SKU 15 and 18 for Limozeen,
>> add new board version 10 for audio codec ALC5682i-VS.
>>
>> Signed-off-by: Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
>> ---
[...]

> 
> You should be running "make dtbs_check" at the end of your series. As
Ideally on each patch separately, with:

# or you can set git config alias.last describe --abbrev=0, thx Bjorn
git rebase -i $(git describe --abbrev=0) 
replace 'pick' -> 'edit'
while (rebase is ongoing, can probably check retval of git rebase --continue)
do "make ... dtbs check something.."

as otherwise you may slip in a breakage inbetween that you fix later on

Konrad
