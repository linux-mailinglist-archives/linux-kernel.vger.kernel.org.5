Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE68758DF0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 08:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjGSGhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 02:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjGSGg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 02:36:59 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014FA1FFC
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 23:36:48 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51de9c2bc77so8893421a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 23:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689748607; x=1692340607;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v11wysb3P45axVNtMG0xHppUAmtgp/rKBxmWNbBV8AY=;
        b=kTSmOtYjORgEOXTl1p7nhh95TdIYgJCXQNQeaEkDsNTAwNcHMkZIKcvaNrnHcXSWRv
         GwI4w7Hg6bVzEOMv0T6RxEh6ae44FYbKz194vmRN4v8FR9gI4lFNB3WTwUt9U2fOQQzU
         NtA1ldkMkoywwrVSJo5kLHRbi5IeBesbGiRMMzQSAmnGxiis+INeUp410wy0t7F8mA1g
         NX9j1aZ35aJ6wFdP/OW+AdyAfZqkghIA73mrvZY8w0q1p9eBiEUGmAz8O0i5CD56KBmK
         om4F6l6/LZ38GuHtFd+M1+PydJ6XFyFqhaxmlO1HnMklMYjSzFnASUbpzEVASGRnGHp8
         aKOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689748607; x=1692340607;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v11wysb3P45axVNtMG0xHppUAmtgp/rKBxmWNbBV8AY=;
        b=lF+Mo/IUpOzehyz5phRb/RoxAHXC0JrBxZ9FSnhiewfPUWivEhC71L3AMfZ+F+2sSB
         Aduhz5WOfajdbssa8KU3ISxjcYc70r/atv343aW5bUMZOJYC6mfu/x2u8gc3reubruax
         X5lvR5nlOfjWgxQ/CIPOlS1kv+Emujat3jaiwFhvQe9GSalWEt9Fb/H6lZlqjC9atJzF
         nYC18bSns/m7mmf9biD/jr3hRbQLM7BAMcb+i0CgXgrpeS6UWb2pYg/tIl+YHObd/AB1
         Yg0fDXrDNJEXxPHTH2VzgpN2FwRF13KFMbQ+YIAEqjSAJN+wWC05I3r9SY/5S6B6Yrbp
         Tw8A==
X-Gm-Message-State: ABy/qLb466kzU2koC4EvMzwuojjQ5zzmFKK9vYNIOrwgfaKpkkv1Q1Di
        F544UxI5VTuXmCweDp1Z+MjlNQ==
X-Google-Smtp-Source: APBJJlFNijc5whQNi4UO9OZTJAlLHQRUDn6Y4O7gSXBMNaW0f6la/NFqlDxi2uPvNlz+tAg0qrwZ8A==
X-Received: by 2002:a05:6402:184a:b0:51d:f74c:1d44 with SMTP id v10-20020a056402184a00b0051df74c1d44mr1803282edy.31.1689748607036;
        Tue, 18 Jul 2023 23:36:47 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id b17-20020a05640202d100b005217412e18dsm2252780edx.48.2023.07.18.23.36.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 23:36:46 -0700 (PDT)
Message-ID: <5353872c-56a3-98f9-7f22-ec1f6c2ccdc8@linaro.org>
Date:   Wed, 19 Jul 2023 08:36:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] dt-bindings: reset: Updated binding for Versal-NET
 reset driver
Content-Language: en-US
To:     Michal Simek <michal.simek@amd.com>,
        Conor Dooley <conor@kernel.org>,
        Piyush Mehta <piyush.mehta@amd.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        git@amd.com
References: <20230717112348.1381367-1-piyush.mehta@amd.com>
 <20230717112348.1381367-2-piyush.mehta@amd.com>
 <20230717-explode-caucus-82c12e340e39@spud>
 <ee81e955-32be-66ea-377b-263ee60a2632@linaro.org>
 <e8f48a30-9aff-bc2f-d03f-793840a192c9@amd.com>
 <694a1314-0b25-ff5e-b19f-5a0efe07bf64@linaro.org>
 <cae162d0-843d-ca1f-80d3-5a0dfe1e3d0f@amd.com>
 <22e7dc73-2411-5cb1-6cef-daa5f2af8297@linaro.org>
 <5df3e976-9fc2-19af-e6b4-e2bea0d64623@amd.com>
 <4c932cbf-19db-2c88-2558-aa42c5338598@linaro.org>
 <ab0fb666-e370-cb07-367b-f3b88e18fba9@amd.com>
 <a12286d2-f929-ed6d-c0f2-4dad5ce6b388@linaro.org>
 <3f76ff03-963d-fff8-b512-abce447da7d0@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <3f76ff03-963d-fff8-b512-abce447da7d0@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2023 08:23, Michal Simek wrote:
>> Yes. If you want to store some constants (register values, firmware
>> magic numbers) and use in DTS, this is the way to go. Most (or all) of
>> examples above are for register values.
> 
> I did small grepping over Linux (reset only) and I found that all of these files 
> are not used by any driver/code. They are included in binding document or dt files.
> Based on your description above they all are candidates for removing from 
> include/dt-bindings/reset/.
> On the other hand that files could be used in different projects out of Linux 
> where that values could be used by a driver/code.

Yes, therefore this should be case-by-case decision.

> 
> What to do with it? Should we remove it, deprecate it or just keep it and not to 
> add new one? I just want to know how to properly handle it.

They cannot be removed. They could be copied to DTS and deprecated in
the bindings. But it is not that important that we clean it up... or it
is rather to the platform maintainer. I did it some time ago for Samsung
and recently TI is doing for serdes mux bindings.

Best regards,
Krzysztof

