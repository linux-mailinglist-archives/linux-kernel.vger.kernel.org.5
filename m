Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A8F7A63D2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 14:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbjISMwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 08:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232207AbjISMw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 08:52:28 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7477F7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 05:52:21 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50325ce89e9so2283707e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 05:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695127940; x=1695732740; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fmzWRuCT+m+LWqYYQplgffz18WcPmF/Ig8ywf8K1oZ8=;
        b=m/GNHnG/LSGEG41yV75HIXcS08ci77rAkgzPV5Rm3ik5Je4gTdrtIs7o15o40hWa6n
         5WYfFR1CO6TejIUqV3RRzIoyji6dXpJQHSg2usiDpwkg3WfWLd4RoxWLYQLtIEpV2Tb4
         BpajzYkV4HA4yVxqJlLLMkQJQ1INvYKcXnDxaq6ZaD4K+EWdSuvTvqpo+HBq3aMrbk/o
         fxsqERq1qM2TwLa1Jhu92POiHR5hu8dTaNXTOdETAen/qYd5JuNAZnxrO1Gzsia1EuQm
         HmIAMzAuOr1ZD0NrvsP15dktVGHvDILjhxOGvPTaItYRIohe8fHndeVdOG0ESZiItwb1
         8PPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695127940; x=1695732740;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fmzWRuCT+m+LWqYYQplgffz18WcPmF/Ig8ywf8K1oZ8=;
        b=nSpkC7rhECdJbxqSnZ0xljLDront893dlyrDOXqpIZ6WQtyvr+fDnwugomFi510FKG
         Ce34qG6B9NGzRXLa0it892lMi3m3NXAqmT0TY7GW+dMsWqObO7E+RFTz9AY8XbrilMlq
         KWo/AA8sa8Gs3N5sOrCfZqxGZ7LOCC5311ISP8LH67IpHFb8yfoxZgl+tA8cH2rs/7sU
         WNYIOG3+iqPOZ2zJ/pDa/thfrV++5o2qIxyoWp9zUjNJh71Im63bCFDRIPKtRrfKC+9L
         EHoyFLD2JxSu5cPlZ1MjC/GLuGDUu/KTnd+v9XGRDei/L82/D5zLqTbOGftwReuSaCnz
         yy8g==
X-Gm-Message-State: AOJu0YyaEsZZBlmlY+je6UdjHbP5i+OUYWwjWWN9tv8cugXAfhZNjAYG
        Hi8bOxnqcMJIr/ITIeFI37Z+pw==
X-Google-Smtp-Source: AGHT+IHCRGOlyWuymcJNQu7Zu1nUSlAHabhsw1d18xf4FV8RNbegwav5clmTZ2Th6UQOHT6Avo4YRA==
X-Received: by 2002:a05:6512:54b:b0:500:a2d3:3e65 with SMTP id h11-20020a056512054b00b00500a2d33e65mr10779762lfl.23.1695127939940;
        Tue, 19 Sep 2023 05:52:19 -0700 (PDT)
Received: from [172.20.24.238] (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.gmail.com with ESMTPSA id dn22-20020a05640222f600b00532c1dfe8ecsm642597edb.66.2023.09.19.05.52.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 05:52:19 -0700 (PDT)
Message-ID: <80f9a0df-bef0-e827-9323-4eb12db956c6@linaro.org>
Date:   Tue, 19 Sep 2023 14:52:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 3/7] arm64: dts: qcom: pm7250b: make SID configurable
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>,
        cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20230919-fp5-initial-v2-0-14bb7cedadf5@fairphone.com>
 <20230919-fp5-initial-v2-3-14bb7cedadf5@fairphone.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230919-fp5-initial-v2-3-14bb7cedadf5@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/2023 14:45, Luca Weiss wrote:
> Like other Qualcomm PMICs the PM7250B can be used on different addresses
> on the SPMI bus. Use similar defines like the PMK8350 to make this
> possible but skip the ifndef based on maintainer feedback.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---

Matches our discussion offline today. Looks good, thank you!

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

