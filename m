Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2167C76BD83
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 21:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbjHATQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 15:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjHATQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 15:16:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EAA1BF0;
        Tue,  1 Aug 2023 12:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=/uG5YuIody+hzN8XW34EjJfYB8YBu85awJMxvbTsR0U=; b=nZb3jdNV9pDRrob/YUA4R2AdxT
        d4OGUQW4mPOpYYhOlP6RZo5aMckUC+eMj/Osevp3aMAix17jcr2Cycvp9Vws7XQsaeWhGIRtZLccP
        gjDnlTAhh6XRdRQ1aY18sZu/dLXlOgb5E/eaSIvPO5eamrxQ2VUUDzQUVOEEjXNOXPAkmfrQd4zRu
        0amfY19Yu+U3xVl5jP960puoEx4uXkQWLIr7j7yGgWWKV1P8j6S4aJje2UQAzw+IykwFsmKkH6sVK
        sGsCqVTuu4SRN+2EeJrqOGkPx9Es21MyLltzX3DHBOEjNu58FnemFiRD2esFkxrtWRn/G4sv2NE+e
        /hhxWVZw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qQurK-0037O0-1t;
        Tue, 01 Aug 2023 19:16:42 +0000
Message-ID: <188bcc4c-7388-ca39-5c3c-629edd78cc9f@infradead.org>
Date:   Tue, 1 Aug 2023 12:16:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/3] clk: qcom: add clock controller driver for
 qca8386/qca8084
Content-Language: en-US
To:     Luo Jie <quic_luoj@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        p.zabel@pengutronix.de
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_srichara@quicinc.com
References: <20230801085352.22873-1-quic_luoj@quicinc.com>
 <20230801085352.22873-4-quic_luoj@quicinc.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230801085352.22873-4-quic_luoj@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/1/23 01:53, Luo Jie wrote:
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 263e55d75e3f..a17e8fa5a7e1 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -195,6 +195,14 @@ config IPQ_GCC_9574
>  	  i2c, USB, SD/eMMC, etc. Select this for the root clock
>  	  of ipq9574.
>  
> +config IPQ_NSSCC_QCA8K
> +        tristate "QCA8K(QCA8386 or QCA8084) NSS Clock Controller"
> +        help

The 2 lines above should be indented with one tab (only; no spaces).

> +          Support for NSS(Network SubSystem) clock controller on

The line above should be indented with one tab + 2 spaces (like the following
3 lines).

> +	  qca8386/qca8084 chip.
> +	  Say Y if you want to use network function of switch or PHY
> +	  function. Select this for the root clock of qca8xxx.

-- 
~Randy
