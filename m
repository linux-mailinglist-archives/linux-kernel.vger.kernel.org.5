Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3F47ADB6F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjIYPbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbjIYPbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:31:47 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD8F101
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:31:40 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3231df054c4so2873383f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695655898; x=1696260698; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CwhduR0PBRru9TfBtXmQap3pf9B8mygp5A+8/TOKmUE=;
        b=awwcrCyQO7bkOawFnDPA6xPJXMnMEw/6sfCd/ioG43ktoQFomEMydjIG2L+wMiz07+
         7ppkFXSVzwuygrPTBep1m+SlAjRZNw39FkFGYPPUY3LbYm4MyPsfVn00blmx16qcErnc
         wkXEpRd3sWIymEcmgI/Z+JE4SB0/C4PCOpqIxvMwhpmijPIscqdcTjC7UqjFek4+FmIs
         Rerl6NlHBmYBqBq4up0dW0f6kj1fuyIqhffCg71poBCqEYPJ3qCiaG0GGYXuYLUBz5yd
         mx3a8oCitdg1Pb7DLkh57bXWvxKwMWN2Ijn08+Pbt7yC5Hj/HDBMd/jIOtes+JZVdtJ2
         WUlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695655898; x=1696260698;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CwhduR0PBRru9TfBtXmQap3pf9B8mygp5A+8/TOKmUE=;
        b=Ctq9Kinua7XRmoe7qgAMAPpCQriGoJH0LJsah836Jk16u0kwSoylhQjK1IVTpZCa93
         zRlBPE2tgxtj1jYbd6UE5Mvud4RHOqtfvsLBcYNsA/3xAiN+TzzynRNLRioSfCuNNhAW
         RdCkQil03+T7ZK8zgvNkDDl2LnNvk7SldYJEpOsOgjiHxRGntR5uDL85I45hbJDdQwNQ
         HQgdWtlp9W5ldHo7nPMDcZoPEQ/33dbDcFAg3jPZ7n5yeX8EV/IpAu+nIN24T++pUVAw
         eVdnkFn0OgaXbMmssUJ7a7vSllam071cwNlm2Rm/8ZYhpiG3wONQ+Drve0nnPqjyToay
         mOqw==
X-Gm-Message-State: AOJu0YxAWHr84JJh2UVTiGlo0qapfaVoFsxlqVfmDbaAk7+5lbWZKo8B
        P2FMXUInA2rPZco0sKdcGacqZg==
X-Google-Smtp-Source: AGHT+IElg9Lgcl2vkKFmDLvL1YGhqWu9vGNT9vdBSUuBJMDElnomzw7h19XWAu7SzeScUhISgbwCbA==
X-Received: by 2002:a5d:440a:0:b0:319:83e4:bbbf with SMTP id z10-20020a5d440a000000b0031983e4bbbfmr6739536wrq.20.1695655898528;
        Mon, 25 Sep 2023 08:31:38 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c0e1:63ab:648b:6287? ([2a05:6e02:1041:c10:c0e1:63ab:648b:6287])
        by smtp.googlemail.com with ESMTPSA id x11-20020a5d650b000000b00318147fd2d3sm12144144wru.41.2023.09.25.08.31.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 08:31:37 -0700 (PDT)
Message-ID: <06ca2e6b-13ce-f097-b17c-8287e2130e52@linaro.org>
Date:   Mon, 25 Sep 2023 17:31:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 2/9] ACPI: thermal: Fold acpi_thermal_get_info() into
 its caller
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <5708760.DvuYhMxLoT@kreacher> <2296248.ElGaqSPkdT@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2296248.ElGaqSPkdT@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/2023 20:36, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> There is only one caller of acpi_thermal_get_info() and the code from
> it can be folded into its caller just fine, so do that.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

