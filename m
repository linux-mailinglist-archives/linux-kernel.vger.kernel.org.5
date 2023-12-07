Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBA080890F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 14:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379550AbjLGNXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 08:23:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjLGNXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 08:23:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775D2AA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 05:23:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2B9BC433C8;
        Thu,  7 Dec 2023 13:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701955388;
        bh=I6VKUBz8o9t+7VdPGnfzwU3XXwc4tF4BarRxfr/X83k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=aXrrkKzycQXF1DaodPy9EJobslQMnXI0fllif8Ux+xDjbWBqC/2Fwc8pRbfkxoumD
         cb2L5XnVGYt6TSjJETgI11pn+XZCwCU6AvFWGHo+o9E0jQyD+RNlLZLX3izgCiYaUr
         IOrLyv+qH27KhC/79h8C6G7e/1WrNJM6GWDx4okJ3N4oFk1cGNoX8Uv7uo5n/gBTmu
         s5rDZdi1uCtvGfcG3AHEbCkBhus2sHP8BlZkJjxGlZmcUeJi7P2oKhcCkr+V3PzFne
         IWdJmxIYXmpcseziC24K2fAYIogq5qYsgNz+QHN7lFellBNzsOZ1Owm6ukg7wvBhio
         4d3oKW+3GlzGQ==
Message-ID: <5f0d75dc-dd44-45b7-bad3-551a3c33e9ae@kernel.org>
Date:   Thu, 7 Dec 2023 15:23:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] SM6115 interconnect
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        Konrad Dybcio <konradybcio@kernel.org>
References: <20231125-topic-6115icc-v3-0-bd8907b8cfd7@linaro.org>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20231125-topic-6115icc-v3-0-bd8907b8cfd7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.11.23 16:41, Konrad Dybcio wrote:
> As it says on the can.
> 
> Georgi, Bjorn, can we please set up an immutable branch with the bindings?

Thanks for the patches, Konrad. Here is the branch:
https://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git/log/?h=icc-sm6115

BR,
Georgi

> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> Changes in v3:
> - Actually define clock-names before using it in conditional blocks (oops)
> - Link to v2: https://lore.kernel.org/r/20231125-topic-6115icc-v2-0-69d05d90871b@linaro.org
> 
> Changes in v2:
> bindings:
> - Remove unnecessary '|' after description:
> - sort property definitions in a manner that resembles their proper ordering
> - define clock{s/-names} before using them in conditional blocks
> - drop unnecessary allOf:
> - move unevaluatedProperties after the conditional blocks
> - disallow clock{s,-names} when unnecessary
> - fix up the example
> C:
> - Apply my own fixup (ebi channel configuration)
> - Link to v1: https://lore.kernel.org/r/20231125-topic-6115icc-v1-0-fa51c0b556c9@linaro.org
> 
> ---
> Konrad Dybcio (2):
>        dt-bindings: interconnect: Add Qualcomm SM6115 NoC
>        interconnect: qcom: Add SM6115 interconnect provider driver
> 
>   .../bindings/interconnect/qcom,sm6115.yaml         |  152 +++
>   drivers/interconnect/qcom/Kconfig                  |    9 +
>   drivers/interconnect/qcom/Makefile                 |    2 +
>   drivers/interconnect/qcom/sm6115.c                 | 1427 ++++++++++++++++++++
>   include/dt-bindings/interconnect/qcom,sm6115.h     |  111 ++
>   5 files changed, 1701 insertions(+)
> ---
> base-commit: 48bbaf8b793e0770798519f8ee1ea2908ff0943a
> change-id: 20231125-topic-6115icc-a187f5989af7
> 
> Best regards,

