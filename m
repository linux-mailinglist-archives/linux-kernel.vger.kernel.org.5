Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03DEA80913E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 20:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443303AbjLGTZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 14:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233127AbjLGTZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 14:25:32 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48901706
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 11:25:38 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c9eca5bbaeso14709471fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 11:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701977137; x=1702581937; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RUDn/j69FGh+Nko+qtqx4etAJxz91ofxqPcpkro2SJw=;
        b=X1BBzRfmwFLt6jQtwOvMSrfl03DJDDkT3cVsJ+2HDahjYn6npzFj7uq114WuRbLCWm
         7gBH/Va1dRFOP7S+XbW1SyfwBq02x1Uwsw/k21Dap3UpAF3E4AQeCfBGexabIXUE5zDf
         /T/5sSfvXuz8kZ79gkrngl1qZdMWsJwK7YAH0E6ddzAOJaHVzPvBNpfht48BMgbD14c2
         K6FeXg4zKGFeMW6PAZqg2V+EeySzav3LaVJaS19DozY6V3WDlvgzZ+cQEFkU1UAqz5b8
         vDlA1ItHvvcW85ez9cSxRYuWIRc3qSWTCz67NG3YqB3fqKH7c1eIpB//uVH5j9m4LzE/
         R2Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701977137; x=1702581937;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RUDn/j69FGh+Nko+qtqx4etAJxz91ofxqPcpkro2SJw=;
        b=cZseL9lKpu4GEPStSXYPYODqW8L4S7QizQAmr9vG7OOy5p/JfsiqOFlAKFhFqlWxzz
         iruw6PeFFmBWr8IpGUj4OufoQIWw0gwVrYGsEJBTYN9NcTlSfvb4d4iynuvGUo0ak8pG
         D6fr0R+Db5KOZ2dUCMbMJJ/WRF/peLc2W5OfIifpKMiV3pFOyP4L2LQUriLGktRbTfs3
         lmLBYnEkC/4meDpPbx5q5VoT6d1LJcMLqYRS0nOtAnGL/BJtuDhJz3N7fJTQLqhsFxrV
         bhIuv8aMFBu6S9Up8lYa0dfxclpLfblhFxkKul0x8L5LS31xkp4i6NfGorwJOA9gTpjx
         laqA==
X-Gm-Message-State: AOJu0YzE2YWFDlAiTq8d8W9y+OeUn17raJ3E6E8NZ3/ArmUr265+iW9y
        a4UqgmRlxTd4k9LQO3CA+1oceQ==
X-Google-Smtp-Source: AGHT+IEp6nkb7rKd6lVkK3sBTYQmEK9KmGCayssO0/HB+is7lA3ZTjG8bz5353dtDuDlplr1n1Xggw==
X-Received: by 2002:a05:651c:1030:b0:2ca:bcb:e798 with SMTP id w16-20020a05651c103000b002ca0bcbe798mr928338ljm.157.1701977136856;
        Thu, 07 Dec 2023 11:25:36 -0800 (PST)
Received: from [172.30.205.181] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id a11-20020a05651c010b00b002ca0a5dc73csm24380ljb.9.2023.12.07.11.25.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 11:25:36 -0800 (PST)
Message-ID: <c7b5677b-9f76-435c-bc79-00012be295e9@linaro.org>
Date:   Thu, 7 Dec 2023 20:25:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: acer-aspire1: Add embedded
 controller
Content-Language: en-US
To:     Nikita Travkin <nikita@trvn.ru>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20231207-aspire1-ec-v1-0-ba9e1c227007@trvn.ru>
 <20231207-aspire1-ec-v1-3-ba9e1c227007@trvn.ru>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231207-aspire1-ec-v1-3-ba9e1c227007@trvn.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/7/23 12:20, Nikita Travkin wrote:
> The laptop contains an embedded controller that provides a set of
> features:
> 
> - Battery and charger monitoring
> - USB Type-C DP alt mode HPD monitoring
> - Lid status detection
> - Small amount of keyboard configuration*
> 
> [*] The keyboard is handled by the same EC but it has a dedicated i2c
> bus and is already enabled. This port only provides fn key behavior
> configuration.
> 
> Add the EC to the device tree and describe the relationship between the
> EC-managed type-c port and the SoC DisplayPort.
> 
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> ---
lgtm but I'll wait for bindings to settle so that the computer can
say it's happy as well

Konrad
