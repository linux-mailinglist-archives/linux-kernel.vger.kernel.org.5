Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02AA1805E53
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 20:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbjLETGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 14:06:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbjLETGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 14:06:04 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA35129;
        Tue,  5 Dec 2023 11:06:09 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5c68b5cf14bso1701129a12.0;
        Tue, 05 Dec 2023 11:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701803169; x=1702407969; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P1pAlpuH5Xa5SLoWkygT7UiOceoXCeggodj1re8Nc1s=;
        b=S8QtKoWCpIV5inwhdQ+T3t+2ZF5hrYMe0AsiKcdw6WlDE0QgyAXutomhYqqdTfrlUA
         7kOw0EMWMoYo+p+SUlNqnj/6TtLEZ7TQPCd9ZVnVUrWSv52hF4pUkwEHHaDqFuQOJMfh
         0rWOlUod7+geT+w9d95kJ295wCC0icNgvYGT+q1mvDmFak1SHUs/757QCUxbyk3InBe4
         I3YFXNritC+nx+o/LGVFxYyCTXdgSlWCzobY8A171GN1gUKSsgj12xkN1wZRuDXyQYb1
         W5iYhO2CuAdcf7Arx5WKGNpEz+x1ahSXQU1evEUMpq06lZu1QnPvAYMtNWhiQEYzFNZg
         nwHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701803169; x=1702407969;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P1pAlpuH5Xa5SLoWkygT7UiOceoXCeggodj1re8Nc1s=;
        b=dJ4oGn+SD0CSVRERLSDlOCK+ZqDVsQjSaMtamc4rFsaulnU+pSL+D5qnITKqIS42pJ
         JvFFdvQvCcwu3Cj9W+rvqTZI5DwvP+sWTAW1kdi+sGmr0e7bLZmhw7ck6FsJ7onKFa5t
         kaCVaWKQXgsrHi2o9T+LYY2GU2oP0WPkHUmJI1qojpx0ZGufg63Arajon6/nh8HNsHhm
         aRiYNkMo3oPbmyYU5dVNIjNYbUT3qAKcIIxYfe4SHR5Rnnz4dO1eLjRlMoykNgfhgD3Y
         tL8WAw+zGXep6U1HMeOWvHaLMVB4bnrDTlcpyb3I9nwxlusHFJqSFjh6FRXHMg7heqYj
         hcyg==
X-Gm-Message-State: AOJu0YxEeUCGb3ccH9pTY0Ju+8h7wOmzrCb4aQXx27bClzukC6RDn+4B
        qtR1a/FgYTUA0jZL4DLF+/eIjdxPwY4=
X-Google-Smtp-Source: AGHT+IGhqX4d1zjyzK5FHrlGfPJ/M5kdx4UOHh66YSZV+LHHsYYQhq5JyIXg7kLnfFmAEVreoaGMvA==
X-Received: by 2002:a17:90b:4b52:b0:286:bdb5:d073 with SMTP id mi18-20020a17090b4b5200b00286bdb5d073mr1420677pjb.42.1701803169102;
        Tue, 05 Dec 2023 11:06:09 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id gb2-20020a17090b060200b00286c1a13ed9sm3110511pjb.56.2023.12.05.11.06.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 11:06:08 -0800 (PST)
Message-ID: <ea67da10-0e8d-47d1-992c-484977d152b6@gmail.com>
Date:   Tue, 5 Dec 2023 11:06:07 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] memory: brcmstb_dpfe: introduce best-effort API
 detection
Content-Language: en-US
To:     Markus Mayer <mmayer@broadcom.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20231205184741.3092376-1-mmayer@broadcom.com>
 <20231205184741.3092376-5-mmayer@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231205184741.3092376-5-mmayer@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/23 10:47, Markus Mayer wrote:
> Add a best-effort probe function that tries all known DPFE versions to
> see if one might actually work. This helps in cases where device tree
> doesn't provide the proper version information for whatever reason. In
> that case, the driver may still be able to register if one of the known
> API versions ends up working.
> 
> Caveat: we have to skip "v1" during our best effort attempts. This is
> due to the fact that attempting a firmware download as required by v1
> will result in a memory access violation on anything but v1 hardware.
> This would crash the kernel. Since we don't know the HW version, we need
> to play it safe and skip v1.
> 
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

