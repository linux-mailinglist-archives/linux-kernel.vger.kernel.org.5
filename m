Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32767C9DD3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 05:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbjJPDYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 23:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbjJPDYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 23:24:11 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B458B106
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 20:24:04 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-777252c397cso299859285a.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 20:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697426644; x=1698031444; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mdYzk4cHVPhgvHjEMYfaKUA+ZiI9hKzw2EziBndWpjs=;
        b=gLqKKkKu1jsxaQ01UOHi2MjSWVqqGA7edGheSydMnn8x65o5kxbeOYqhkxw+caYzNU
         CfjetWzIsTWM4hXXPlPk4hOjX+NCkIronE0u+aLsp6692XUKteTUlcmmWRX0mWCflNgC
         RXC8nvQf7vyvJMrG+9J/sJ7ypaj2VpT30/FsVL7H8MKtNmL3CPVpwPEZ3e7BqRW6F/MQ
         S8GHMr6tNnua/2axykGdJJnC8hjejigr9a6d9bUJxENvckgeC892YToEVjQ879GnI42M
         m3Vrw4R5a8rDn2hcQsJvcI8PloERkOIQZKlRKec2l0Xp589mf35W8kRCb7c2Kc4W0+Wj
         pV5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697426644; x=1698031444;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mdYzk4cHVPhgvHjEMYfaKUA+ZiI9hKzw2EziBndWpjs=;
        b=We/xikx3KexRLvrd2G99ohX8FM+SqSDkZGbW/TvdUjV/98Vpx640FM6aaILC2qOE73
         L3fziAxSTB2NJ3B2ocasj94CfggpbQmgYomhRUMUrS/bxs4BpsxhQqAS/tDfwzGcXOd+
         hILhUR+2sA1BiA5dx+QQpGHgOr5PqDxkTrXrNT6SknbYOb3ETkDnXV59sqPXl1qWJGPL
         IEmuJPnyFpaEOca68SJwtSkLtt6Vl1eChjSULlXYUgif/ttlw9CIqhwBME8BOssqAdxq
         aOzRCVYgA7pgT9AuWhR4R1nHPyI/XdR8szPH62B9gB3X4JukRp0rm4oOSSDltKXkhENo
         67Nw==
X-Gm-Message-State: AOJu0YzZ2dbF/pFCwq8Qll/aoSj36p6X5Vk9uOcg03lVNEU9+1TtrhS2
        C1BjAA6x0lJbW9rvgKqVSgeWHQ==
X-Google-Smtp-Source: AGHT+IEVT6R0ff/QzrGmRuoqEkDyEFviIVFFlPkoZDcaqNh1ru4cf9F2XqB95qlV3aRKJzdSY9n5Nw==
X-Received: by 2002:a05:620a:953:b0:76f:ad1:3afb with SMTP id w19-20020a05620a095300b0076f0ad13afbmr32325866qkw.69.1697426643785;
        Sun, 15 Oct 2023 20:24:03 -0700 (PDT)
Received: from localhost ([122.172.80.14])
        by smtp.gmail.com with ESMTPSA id z8-20020a6553c8000000b005b1bf3a200fsm2562933pgr.1.2023.10.15.20.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 20:24:03 -0700 (PDT)
Date:   Mon, 16 Oct 2023 08:53:53 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] of: export of_find_next_cache_node() for modules
Message-ID: <20231016032353.xv3fm7dyuz52txy5@vireshk-i7>
References: <20231011112726.166052-1-dmitry.baryshkov@linaro.org>
 <CAL_Jsq+HdceLczej4_q-wjg2870v3y-e_E+jEq0xbetDguaXAw@mail.gmail.com>
 <CAA8EJppCO-q=swYOH+O2fOdUDbNzd1yz9ZoTEBswV7RmvFJifA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA8EJppCO-q=swYOH+O2fOdUDbNzd1yz9ZoTEBswV7RmvFJifA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-10-23, 15:59, Dmitry Baryshkov wrote:
> On Wed, 11 Oct 2023 at 15:52, Rob Herring <robh+dt@kernel.org> wrote:
> >
> > On Wed, Oct 11, 2023 at 6:27 AM Dmitry Baryshkov
> > <dmitry.baryshkov@linaro.org> wrote:
> > >
> > > The qcom-cpufreq-nvmem module uses of_find_next_cache_node() function,
> > > so export it to be available to the modules.
> >
> > You really should be using the cacheinfo API which has already parsed
> > the cache nodes.
> >
> > Also, why do you need a platform_device? I don't see a driver.
> > cacheinfo already creates a struct device, so kind of weird to have 2
> > devices.
> 
> The driver is pending as a part of the series at [1]. We need to scale
> the L2 supplies and clock frequency following the core frequency
> changes.

Guys, can we please resolve this soon ? I had to revert the patches
for the time being to avoid these failures.

-- 
viresh
