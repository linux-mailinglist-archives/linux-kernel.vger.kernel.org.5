Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554627742AB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234880AbjHHRrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbjHHRqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:46:06 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A472AD14F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:20:52 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fe4ad22e36so39830995e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1691511621; x=1692116421;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=WYDOE0uAfuvMMd7frP4lQPvrrdCPX7CA5G+ozoaawe4=;
        b=MBQKcMQ0kQIIy8s2QWTirT8jVlenV7AcGz9tpmtZWvBdfeLtDMQwZpjdF8/4JFnTda
         f2DVyltlOureqzTDAGd4rCE+ib6blkf0bp3OHyvtwLKc0CIZFPNXRK2G9Qz/yeQhQqqg
         cbz7OPoa4Dd5HL1EfjGvlqqII418kc6f8HOmnR41TAm0QVBhcTEjBaMgDvvkxBMWASAw
         whyAQfCCLRn9TMa5A3hLSxj72yKMZ0UwJZM5UX7NL90BaAPJ3/mNs7eahGXzMOY0413c
         1N2VDjmT3ko1uViA1jtiZKMxgPunUD1LWqeWoSfavBqxfHhydXaHFmmZAuXU6mT9AWHf
         +gFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691511621; x=1692116421;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WYDOE0uAfuvMMd7frP4lQPvrrdCPX7CA5G+ozoaawe4=;
        b=OmO86MhP4KPnX6c7L/yx2ixL9Yi2KUlLvOGwimfo45ufy99PbzASdkS7pfu9IbKRzo
         1ZrOlai8MVLtzg7AERqB2nUdeW2N/m1KHRJcQ+9goqIrIQK8Z9g7waOvzNyxQfSQBmxB
         mxWStCCr3V+VE3QQ8Yh27Jx9MogNp06fSI2S7oUPro8X8/GM9sLJOBLOufJ+8dXqtnxM
         diR587u/TqRXwLqHwimt1vzSlJ1C/P/iqoWedqoB6fBdtUvhtZu0JArqcL1a+HxUcux1
         gYB5KgK2hH0NTV79yJCtwJTERN6YaC3olZz5D8UkLc4oA5EAX7NTqNvncxDJLiX1Hqej
         xRgA==
X-Gm-Message-State: AOJu0Yx8xCUIhXSTGSWZaCLIucVdQQLsGoFB3+a8uTCeFEmEMGppQDYx
        5I9Pvf/B5NGrZYMQ1cihFOJvyYAaGfgfDCKHpDk=
X-Google-Smtp-Source: AGHT+IF/sVg/Jhlijx/RE5QOgQaMgGYHCPyQMz8dSgQ4an0cId67kpg37dk0nwOSpbyiFJyhIGgAng==
X-Received: by 2002:adf:fa4a:0:b0:315:9de4:92f0 with SMTP id y10-20020adffa4a000000b003159de492f0mr8496109wrr.5.1691507150251;
        Tue, 08 Aug 2023 08:05:50 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:efd4:f3df:2c50:1776])
        by smtp.gmail.com with ESMTPSA id y15-20020a5d4acf000000b003144b50034esm13863035wrs.110.2023.08.08.08.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 08:05:42 -0700 (PDT)
References: <20230706-b4-amlogic-bindings-convert-take2-v3-0-f63de6f12dcc@linaro.org>
 <9adbbde6-a12c-2857-3103-1c012eed6f27@linaro.org>
User-agent: mu4e 1.8.13; emacs 28.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 0/3] dt-bindings: second batch of dt-schema
 conversions for Amlogic Meson bindings
Date:   Tue, 08 Aug 2023 17:05:12 +0200
In-reply-to: <9adbbde6-a12c-2857-3103-1c012eed6f27@linaro.org>
Message-ID: <1jleelo9q4.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri 04 Aug 2023 at 15:35, Neil Armstrong <neil.armstrong@linaro.org> wrote:

> Hi Jerome,
>
> On 06/07/2023 16:52, Neil Armstrong wrote:
>> Batch conversion of the following bindings:
>> - amlogic,gxbb-clkc.txt
>> - amlogic,gxbb-aoclkc.txt
>> 
>
> <snip>
>
>> ---
>> Neil Armstrong (3):
>>        dt-bindings: clock: amlogic: convert amlogic,gxbb-clkc.txt to dt-schema
>>        dt-bindings: clock: amlogic: convert amlogic,gxbb-aoclkc.txt to dt-schema
>
> Do you plan to take patches 1 & 2 ?
>
> If you can, it would be simpler if you could take patch 3 in the same batch.
>
> Thanks,
> Neil

Applied all 3 - fixing the checkpatch on patch 2

>
>>        dt-bindings: soc: amlogic: document System Control registers
>>   .../bindings/clock/amlogic,gxbb-aoclkc.txt         |  64 ---------
>>   .../bindings/clock/amlogic,gxbb-aoclkc.yaml        |  85 +++++++++++
>>   .../bindings/clock/amlogic,gxbb-clkc.txt           |  53 -------
>>   .../bindings/clock/amlogic,gxbb-clkc.yaml          |  37 +++++
>>   .../soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml  | 160 +++++++++++++++++++++
>>   5 files changed, 282 insertions(+), 117 deletions(-)
>> ---
>> base-commit: e1f6a8eaf1c271a0158114a03e3605f4fba059ad
>> change-id: 20230209-b4-amlogic-bindings-convert-take2-e2caf8e1c13f
>> Best regards,

