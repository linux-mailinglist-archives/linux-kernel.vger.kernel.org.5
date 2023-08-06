Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD99077168E
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 21:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjHFTfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 15:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjHFTfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 15:35:10 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4EE1720
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 12:35:08 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-522ab301692so5353534a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 06 Aug 2023 12:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691350507; x=1691955307;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3bqbe2tDZsZm0END83UpLyo6EdqTZMUT086jdCCRrYw=;
        b=g0jyzXc60snOi9Q61ciF87VgVXpMoKnvYizbfZgb2HjPkUaMyTBZig89TnI7J6YQ1s
         K/EowG8j8K+l6ZuxtPoNMk568mXiq3LsDY1LWJevmEh+kA17IkB/ExBG5CbCNwYveV85
         KiP8DOjX6xCwsW0l0W4CGt2RceYmAOFGEPC4d25smdzCgQUd+Bu5LPSJH7pdcQoQ/7Y0
         uny9KeKT67FTZ4fflMOOI4Q8B29TKmVZzoAsx6Jb3p0GRyaY+V8q6dznj70w8fGRtRuM
         aa4eJ24jFHCxakE+2duVWIx9By8XJKslLsOb4zYfHySZmq8AnxARrRSGbZUbKyV+c4+Q
         bMTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691350507; x=1691955307;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3bqbe2tDZsZm0END83UpLyo6EdqTZMUT086jdCCRrYw=;
        b=VYqDdR+isvd1XHVndbrb+AsoqH+BQAddQTZd0QgrQsEkR4oFna6kKWnYNK27cYsb5W
         U+G6kzGgnzpbLABlWvB5iUy1GwjEGfjEluKCsGz3B6xK8B/AYP0zCUs9VSIj3rBLBTaN
         NSzPGoYKafgkO81x1WkUfC7H8y2i8VEUVEv/m8sr8plzxrmuzGeq0WzV6Hpt5nZseDPh
         OyWwEjMdU+zE933J14NehwDitiH8j1AzKtwDpGYKPuv5KY5+IrlNmKXRzpJ7FktZq2kb
         Lt70ZPQJA+vedLLu4lXi9Oh5UyqV5ngaU3VblZZDP8wUWbHwkDQLu2ajW2O3SVAUq4YT
         /pzQ==
X-Gm-Message-State: AOJu0YyqsfSEY2aLkI8H7ainmTf0B5tHKRUwvi581wAcDG5b6+Rxo8O1
        9JdrzxFOGSFnsX3hzN7QVbQJNQ==
X-Google-Smtp-Source: AGHT+IG/79s2xg9v9Za0JIriROoPvnlkRv0Jug22nma7i4hEv1WIE4RafrrohEpmmoAaMt55gaOUXA==
X-Received: by 2002:aa7:d148:0:b0:523:2873:8323 with SMTP id r8-20020aa7d148000000b0052328738323mr4168789edo.35.1691350506747;
        Sun, 06 Aug 2023 12:35:06 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id o4-20020aa7c504000000b00522828d438csm4212648edq.7.2023.08.06.12.35.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Aug 2023 12:35:06 -0700 (PDT)
Message-ID: <6fcd8e51-7e97-1261-7cd5-5e18840aaf8e@linaro.org>
Date:   Sun, 6 Aug 2023 21:35:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 3/5] dt-bindings: clock: add Intel Agilex5 clock
 manager
Content-Language: en-US
To:     niravkumar.l.rabara@intel.com
Cc:     adrian.ho.yin.ng@intel.com, andrew@lunn.ch, conor+dt@kernel.org,
        devicetree@vger.kernel.org, dinguyen@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        netdev@vger.kernel.org, p.zabel@pengutronix.de,
        richardcochran@gmail.com, robh+dt@kernel.org, sboyd@kernel.org,
        wen.ping.teh@intel.com
References: <20230618132235.728641-1-niravkumar.l.rabara@intel.com>
 <20230801010234.792557-1-niravkumar.l.rabara@intel.com>
 <20230801010234.792557-4-niravkumar.l.rabara@intel.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230801010234.792557-4-niravkumar.l.rabara@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08/2023 03:02, niravkumar.l.rabara@intel.com wrote:
> From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> 
> Add clock ID definitions for Intel Agilex5 SoCFPGA.
> The registers in Agilex5 handling the clock is named as clock manager.
> 
> Signed-off-by: Teh Wen Ping <wen.ping.teh@intel.com>
> Reviewed-by: Dinh Nguyen <dinguyen@kernel.org>
> Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> ---

Do not attach (thread) your patchsets to some other threads (unrelated
or older versions). This buries them deep in the mailbox and might
interfere with applying entire sets.

Best regards,
Krzysztof

