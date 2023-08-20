Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB690781C4F
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 06:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjHTEC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 00:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjHTECX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 00:02:23 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8AD72D5D;
        Sat, 19 Aug 2023 20:55:57 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-64a0176b1easo13992426d6.3;
        Sat, 19 Aug 2023 20:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692503756; x=1693108556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PcHVqBNQ++TbKs5jd3CmYhgiFTgzPJvx7khHb85OxgU=;
        b=AynTBbT0XXVNR5HydLtaRtf85h6tHbZ3yPG9wCIWYBoUi5OBQY9c7uGbIB9H0fPZJA
         TPAD7wZrybioeCBNsu0YicEKeQpBOrdwsUqI3YbCyEL3IRkd2kCNE++1JuFw4gJ9l/V/
         wVBQZMgFJI+GIpPllcYpFqBHe4kmORWLpznqQeaWmkLP4p6z+ANLbODnCk3iZz0jR0bm
         j4NZZS5stysfjGVu1R0RTuZPtMr6ht6R4at+2M/8id4wzND0Nu0CQ0K37iifTKPTz6r+
         627hZvosSg/PgeoJO+I0yXHlhVCUkTJWEDuHKNJ4Z0pfHiTbR7Its0nj2Q5cRXNDF03l
         qBTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692503756; x=1693108556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PcHVqBNQ++TbKs5jd3CmYhgiFTgzPJvx7khHb85OxgU=;
        b=JRXpACshHlWD87QpRDZw1+6mkRPhjws2xiTJObpwkAholntgds1oAFbA3NnStNz2EK
         xeXO8kYwIMpn4jvJf9WG1zEglrTs0Q5W+s7QsDx8nyM8P72nsPMPbmCTOZ6SwWKLhhl0
         +vZrAaah3/OkDQbBWXbU2HASa3KK6aVXcLfpQDHFKSZgx8Gwt9TSWPbEOw04S2Ar9+zs
         JCMAvRayC73x1gruDw9WJJGxDbXMKzZjRpd2Yr3wB8MC47egdWDz975iO0yED8KVJ2aJ
         1Sy407jgEfH9Fle1HwRfzhnRdSgYlS0PU1MrjqG4ypGW0OLO8pj5/CnCCbdr9CuFXtAQ
         eFHg==
X-Gm-Message-State: AOJu0Yy3WrScBUOSLwl8e7QCNG5jYZVqNECv19VwTSIx9DiRJnsPc192
        2NkiJfod91jiFENA/SwZ3qsAGteE0WTuqA==
X-Google-Smtp-Source: AGHT+IFqlBgIY/KR7C7d6rPl9mBtxlEAq9sBhHsroNlxc0RagBgOejWLFJkd5NGs7MIBux8Qo5UcYg==
X-Received: by 2002:a0c:df04:0:b0:647:272b:3afe with SMTP id g4-20020a0cdf04000000b00647272b3afemr3946845qvl.18.1692503756541;
        Sat, 19 Aug 2023 20:55:56 -0700 (PDT)
Received: from abdel ([174.95.13.129])
        by smtp.gmail.com with ESMTPSA id i8-20020a0cf388000000b0063d5d173a51sm1915237qvk.50.2023.08.19.20.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Aug 2023 20:55:55 -0700 (PDT)
Date:   Sat, 19 Aug 2023 23:55:45 -0400
From:   Abdel Alkuor <alkuor@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        conor+dt@kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        abdelalkuor@geotab.com
Subject: Re: [PATCH] dt-bindings: usb: Add binding for ti,tps25750
Message-ID: <ZOGOwUCIld0eSgqf@abdel>
References: <20230817235212.441254-1-alkuor@gmail.com>
 <eba26f0e-40dd-3661-b089-bc34c9426000@linaro.org>
 <ZN+PzWuiLRsSVcmU@abdel>
 <f2be5c54-b98d-d4eb-2107-6364701edca9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2be5c54-b98d-d4eb-2107-6364701edca9@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 19, 2023 at 09:09:03AM +0200, Krzysztof Kozlowski wrote:
> On 18/08/2023 17:35, Abdel Alkuor wrote:
> > On Fri, Aug 18, 2023 at 11:31:35AM +0200, Krzysztof Kozlowski wrote:
> >> Where is any user of it? DTS, driver or 3rd party upstream open-source
> >> project?
> >>
> > Yes, for Geotab. We are working on bringing up a new BSP and we have tps25750
> > which doesn't have a driver in Linux yet. We developed the driver but I thought
> > I needed to get the dt-bindings accepted first before sending the patch for
> > the driver.
> > 
> > Sorry, this is my first time contributing to Linux. Maybe this question
> > was asked before but for some reason I couldn't find it.
> > 
> > What is usually the process? Should I upload the driver too?
> 
> Yes, please upload in one patchset, in following order:
> 1. This bindings patch
> 2. Driver patch
>

Will do. Thanks.

Abdel
