Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3CA7E81F5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235170AbjKJSty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:49:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235637AbjKJStm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:49:42 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25004B70B4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 10:09:40 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-4084e49a5e5so18038945e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 10:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1699639777; x=1700244577; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=ng8cN8zDe0R53w/cTJkEAYIlBVh/fEa75Si1UCaSOlg=;
        b=D/J8BKdILAV8wMXwLXL8xLtXgoix0sdkX2dL7xB/bEZjOAHu1okNtGz8vcyNowD+4W
         tTV8k0qAqPKZ7U8Fd0GQVUB9UuDxUbF8LYga3Tcs+tglz69b5xU2psN/+C1SBCuj8P0t
         4qg7icGHCgxKiA+lIGE3xfMOluE8mj+FOo2nXDnTUmjeSx+VPqYocL38Ygz7ZZDuDoZW
         FcsDz6p1ehW/UvTW1PAaDQH+DsFGpFbKhEziDLfrX28ylQzNPy9Mg4Angs/5cxRKDvuR
         IPhagJ84Qex72XiXHyMw0dueNIr3ayW48GHESKa6Fol1TFrusf+2z3iIdRC97QDNvUQE
         fqNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699639777; x=1700244577;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ng8cN8zDe0R53w/cTJkEAYIlBVh/fEa75Si1UCaSOlg=;
        b=PnUNW44mSJleaN+ipBBs8JddmvJeDwe54Ers85HhRkkw/2rZQuM99LUWbdfsOXkhj1
         Ph0VqYb13zKFfdXVRx5H6vsHd6ld7jpNsgmVZG27PeySRz8GEgBH+bYCvrdBp6/zra53
         unG3QERzhxgUs1I6ZTuBTtCvtlNOVlaKL4lG48DPVQsdRZdVuqGn7Sp0sy2jirqH9i20
         iNlPO9XMxkbIoaDD59VKbKg1HZtMbr6lBN6aq3M/ck8nG7RYMFolXeRW4UE9sX3v5BHr
         sOdL3n5ARpcwIQo0uNa0RrCppHjJywdC6Va6qYkG7y1mhhSoo1TrgBcpgaLqEaYPC/wg
         /2pg==
X-Gm-Message-State: AOJu0YzvA3XeOOJECYJvDLw+5JSS1Esoj7myrwuFj8JlCcA9Dg0RjUVj
        CfhuUdgBlBlWW7BxVRCOMeKMbA==
X-Google-Smtp-Source: AGHT+IHFi71LzP56sECK9cPzRrAXiprWtaEqlntnc4nZaUr/6hWWb4qHltt8nbj1kZsiALkEip55Kg==
X-Received: by 2002:a05:600c:4703:b0:405:3cc5:1105 with SMTP id v3-20020a05600c470300b004053cc51105mr116766wmo.8.1699639777205;
        Fri, 10 Nov 2023 10:09:37 -0800 (PST)
Received: from localhost ([2a01:e0a:3c5:5fb1:2169:e902:f0d0:1845])
        by smtp.gmail.com with ESMTPSA id k4-20020a5d66c4000000b00327b5ca093dsm2359847wrw.117.2023.11.10.10.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 10:09:36 -0800 (PST)
References: <20231106085554.3237511-1-xianwei.zhao@amlogic.com>
 <eab3869c-7529-484d-983f-dd85ecfbeb0b@linaro.org>
User-agent: mu4e 1.8.13; emacs 29.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Xianwei Zhao <xianwei.zhao@amlogic.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Chuan Liu <chuan.liu@amlogic.com>
Subject: Re: [PATCH V6 0/4] Add C3 SoC PLLs and Peripheral clock
Date:   Fri, 10 Nov 2023 18:50:25 +0100
In-reply-to: <eab3869c-7529-484d-983f-dd85ecfbeb0b@linaro.org>
Message-ID: <1j34xdcwf4.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri 10 Nov 2023 at 14:20, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 06/11/2023 09:55, Xianwei Zhao wrote:
>> The patchset adds support for the peripheral and PLL clock controller
>> found on the Amlogic C3 SoC family, such as C302X or C308L.
>> 
>> Changes since V5 [3]:
>>  - Fix some typo and modify formart for MARCO. Suggested by Jerome.
>>  - Add pad clock for peripheral input clock in bindings.
>>  - Add some description for explaining why ddr_dpll_pt_clk and cts_msr_clk are out of tree.
>> Changes since V4 [10]:
>>  - Change some fw_name of clocks. Suggested by Jerome.
>>  - Delete minItem of clocks.
>>  - Add CLk_GET_RATE_NOCACHE flags for gp1_pll
>>  - Fix some format. and fix width as 8 for mclk_pll_dco.
>>  - exchange gate and divder for fclk_50m clock.
>>  - add CLK_SET_RATE_PARENT for axi_a_divder & axi_b_divder.
>>  - add CLK_IS_CRITICAL for axi_clk
>>  - Optimized macro define for pwm clk.
>>  - add cts_oscin_clk mux between 24M and 32k
>>  - add some missing gate clock, such as ddr_pll.
>
> Where are all these versions? Please provide links.

I have provided some guidance offline at the request of Amlogic.

This should have been v4 and the cover-letter should have summarized the
change from v3 to this. Unfortunately it was sent as v6 :/

>
> Best regards,
> Krzysztof

