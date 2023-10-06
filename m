Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFF87BC0FA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 23:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbjJFVIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 17:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233587AbjJFVIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 17:08:47 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E8FBF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 14:08:44 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99bdcade7fbso454742366b.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 14:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696626522; x=1697231322; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/eZ+baChX62/XFQYAtL7KxuFGmIsac+98wOC92qP+Vo=;
        b=AVelWM3G8DTl1US9TwU+M/f0KazfVUqFLqm3qI93zxfY4qIasxISJmPzoonMYtx4Zw
         3V+AbPM7zL3MA8QS+JjqQGNmBW4EbKvfm0JGAHlGz2v94YpH8ERwJdfurFWXA0EJBijf
         vCmVLaKEOX4uQ5yUSMp9IsWfjkTcNPUF4DaSklELH5jX0wuR31bXXd9+8BoRQsYVVnCW
         YP3jQmLe7xn5fqL0PQPyjcr/NUtvgZG369vGFbjkdocLhnzugi/0ZE75WG8S8OpZF6nI
         Rdu5p+5QIwLC0aN1i0jAnxSci3/Jm/p61m51Ed5Ck5CDSfOOyt/5joFfmb2rn5No5L1D
         cGoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696626522; x=1697231322;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/eZ+baChX62/XFQYAtL7KxuFGmIsac+98wOC92qP+Vo=;
        b=LBVrHsfHJN/xNFJWCd6VFa9p4GMkZoXBhJ7u0N9cRrh3lqRXL4tIZa57LxVfBJtLMS
         09Zm9zZ6rOeppA51yitpgopGg54lc7V8FlX3EzA1FTKMTunQ4q+6pijuWVHxWlJNKXVQ
         Jle8r/7pFt3rEqBku8dlQK0edYksXcYBVaXHCoE15B4sCdfS94Sbv66oS32nGMoaDMWa
         Sdywd9kG6uxKCvSS5b1tOMf5FFHtWxer2SlTs3SqsmYcwJcrrl8pn3u5/SPxJoJU4RV1
         qldJ6bgu42T4OorCQVBP958936osi9uD5wPhaRDl9dr8gSHCPrNBtQje5h7T+vTPuEkh
         0bQw==
X-Gm-Message-State: AOJu0YwSqGbZ+WjpDWzmzLOfBYN37NC+13lXG7iFCY7DJoULK1diemB3
        EG4qj3+vigLjOZQyoE5TUTyBfw==
X-Google-Smtp-Source: AGHT+IG8Yms6t5wo23tONA1+PCuYA6/OoOa7XwEE5xoFjtOeUUmAYpssGeokoXvEAN23wjKXUB8KHw==
X-Received: by 2002:a17:906:535e:b0:9ae:42da:803c with SMTP id j30-20020a170906535e00b009ae42da803cmr7412194ejo.48.1696626522211;
        Fri, 06 Oct 2023 14:08:42 -0700 (PDT)
Received: from [192.168.200.140] (178235177147.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.147])
        by smtp.gmail.com with ESMTPSA id p11-20020a1709061b4b00b0097404f4a124sm3450228ejg.2.2023.10.06.14.08.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 14:08:41 -0700 (PDT)
Message-ID: <bc8fa799-aa64-4b69-97ce-8f1872c8eb11@linaro.org>
Date:   Fri, 6 Oct 2023 23:08:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] clk: qcom: smd: Disable unused clocks
To:     Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>
References: <20231004-clk-qcom-smd-rpm-unused-v2-1-9a5281f324dc@kernkonzept.com>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20231004-clk-qcom-smd-rpm-unused-v2-1-9a5281f324dc@kernkonzept.com>
Content-Type: text/plain; charset=UTF-8
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

On 4.10.2023 14:10, Stephan Gerhold wrote:
> At the moment, clk-smd-rpm forces all clocks on at probe time (for
> "handoff"). However, it does not make the clk core aware of that.
> 
> This means that the clocks stay enabled forever if they are not used
> by anything. We can easily disable them again after bootup has been
> completed, by making the clk core aware of the state. This is
> implemented by returning the current state of the clock in
> is_prepared().
> 
> Checking the SPMI clock registers reveals that this allows the RPM to
> disable unused BB/RF clocks. This reduces the power consumption quite
> significantly and is also needed to allow entering low-power states.
> 
> As of commit d6edc31f3a68 ("clk: qcom: smd-rpm: Separate out
> interconnect bus clocks") the interconnect-related clocks are no longer
> managed/exposed by clk-smd-rpm. Also the BI_TCXO_AO clock is now
> critical (and never disabled).
> 
> There is still a slight chance that this change will break boot on some
> devices. However, this will be most likely caused by actual mistakes in
> the device tree (where required clocks were not actually specified).
Precisely this, and solely as a consequence of the interconnect driver
not covering all the required clocks (usually named GCC_SOME_NOC_XYZ_CLK,
but there's quite a lot more).

For platforms without an interconnect driver, breaking stuff this **MOST
LIKELY** means that Linux uses some hw that isn't voted for (e.g. missing
crypto clock under scm or something).

For those with an interconnect driver, this will uncover issues that were
previously hidden because of the smd-rpm interconnect being essentially
broken for most of its existence. I can smell 660 breaking from however
many miles you are away from me, but it's "good", as we were relying on
(board specific) magic..

I've been carrying an equivalent patch in my tree for over half a year now
and IIRC 8996 was mostly fine. It's also a good idea to test suspend
(echo mem > /sys/power/state) and wakeup.

For reasons that I don't fully recall, I do have both .is_prepared and
.is_enabled though..

Konrad
