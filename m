Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1837B3314
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 15:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233236AbjI2NJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 09:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233265AbjI2NJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 09:09:00 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974981B0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 06:08:57 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-323ef9a8b59so4488977f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 06:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695992936; x=1696597736; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cWXuQ5u9+U/7bo3jOMCaQRH1Us0wBmf5+hPjlAUO1BE=;
        b=x7xirlOv7Cj15S6OZVSTdZbOTVVS50IKXIS9slkORL6JZVyhvF5Se6rUs41SIms16Y
         oPGabz9rfQFb3NXTaGAzRLcGMU7XGKGExxyMQ/7G2nOU+bM79xWyPq0rSMMWanYbz/uu
         RwcpoIUiWou3wX7rsYsku03EnJc8qc8Gpun3p1d2/BG7UTjHvQvdyxMRkb3Oa7mBNStm
         b9wlR9GJB+4O9iSzrFFfAL24Equd6FEhLID7TVJD9bAeO20dSMP/YEd2BILOzG/CWbvC
         eV0ymEHg7xhreif/8tMohP0QzhpnlKZZA1KqWp3xwMbFb+Ji8KxJo147Bua9Q51O4Tox
         Ms3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695992936; x=1696597736;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cWXuQ5u9+U/7bo3jOMCaQRH1Us0wBmf5+hPjlAUO1BE=;
        b=j5kEAndZy02r6LfKxYBPsMb2JmTh1j2/qbkb7IclwkwQqo+2d2l4o9chQdeQrVeBR0
         6pszF12nMxY1n7eScEeTM0kV1L6tR0YLipvCd8HDSD2567MqV0x1tIClvthkkQu6W55+
         mUuRSX+TIo3bG9M3GFvtnanZiWHCwdJ34seFTfn4h4E2ZcyL7ZeaowGcoNpiU/VnTiA5
         IDBBRIgV6660zHRQqt7S5IiIbFbDwDpqW4oQvrtxVEzYFdxqKjOvTZeTHbPyMQRaJ1CN
         +5zMTbcUAYh92wAYy59lpnXocEA1YIUxY56bgEftPPQf4auZ497wIpSxOol88oNoRpkV
         Zqxg==
X-Gm-Message-State: AOJu0Yx3UwuX1BrstOE+Mifbjq+qSUPHn7rhb85yW0FhtV0CxQcpfyh8
        9VOtcmaLm846CXJJa9DsRcEjKQ==
X-Google-Smtp-Source: AGHT+IENZfhhmJUpQ2Eg+PegrVKDWmUVs7WCrKpk+ZRZx4UwEKqF5KcuKHpEm39nszkThBvif0sZQw==
X-Received: by 2002:a5d:460a:0:b0:319:775f:d553 with SMTP id t10-20020a5d460a000000b00319775fd553mr4064660wrq.9.1695992934949;
        Fri, 29 Sep 2023 06:08:54 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id c5-20020adfed85000000b0032196c508e3sm21526411wro.53.2023.09.29.06.08.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Sep 2023 06:08:54 -0700 (PDT)
Message-ID: <f6e4413b-eac1-4c0d-9ecd-ff28138617ff@linaro.org>
Date:   Fri, 29 Sep 2023 14:08:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/2] Add partial initialization support
Content-Language: en-US
To:     Sarthak Garg <quic_sartgarg@quicinc.com>, adrian.hunter@intel.com,
        ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sayalil@quicinc.com,
        quic_nitirawa@quicinc.com, quic_sachgupt@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_narepall@quicinc.com
References: <20230929102831.9702-1-quic_sartgarg@quicinc.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230929102831.9702-1-quic_sartgarg@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/2023 11:28, Sarthak Garg wrote:
> Add the ability to partially initialize the MMC device by
> using device sleep/awake sequence (CMD5).
> Device will be sent to sleep state during mmc runtime/system suspend
> and will be woken up during mmc runtime/system resume.
> By using this sequence the device doesn't need full initialization
> which gives 25% time reduction in system/runtime resume path.
> Also enable this feature for qualcomm controllers.
> 
> Sarthak Garg (2):
>    mmc: core: Add partial initialization support
>    mmc: sdhci-msm: Enable MMC_CAP2_SLEEP_AWAKE for Qualcomm controllers
> 
>   drivers/mmc/core/mmc.c       | 162 +++++++++++++++++++++++++++++++++--
>   drivers/mmc/host/sdhci-msm.c |   1 +
>   include/linux/mmc/card.h     |   4 +
>   include/linux/mmc/host.h     |   2 +
>   4 files changed, 160 insertions(+), 9 deletions(-)
> 
> --
> 2.17.1
> 

A terrible nit pick on my part however, you should include the name of 
the subsystem/driver in the title of the series.

"mmc: Do this awesome new thing"

---
bod
