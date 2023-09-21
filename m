Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8517A9BE1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjIUTEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjIUTEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:04:06 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711EA400EE
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:34:56 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1d6b4735158so713065fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695321295; x=1695926095; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pNpVr3hX07AdKTZ8+Sx0LVisp+9RYkwStP9wMLdYrzw=;
        b=xjAW3Rx1Yp0Hv+2w3r83byyuEfGwkHcCu5KggzzKcnMuX+fiOG7rPrqPBp3ZvDHUIp
         yJGyRVXbQkAh1fTbTxI0GLyqT19m0tsD+fdJTJZacsE9LL4pg18DQvXb4T9tcU0g2KC3
         OVyRLMlsuTN36yo9NgT71PVVn3YfLifEsPoAD+FiNNVsV2tRqxw8NjStJZOvmxWTA12P
         /WCCUWFFXYgJpN2EKXEIzOMfRmnYvl8+axBUBM5q6OHBFAuR4XCENWNTx4AYxmaGT26i
         JvizROix5E8TitMDdbwrk6fptGQ7tyX8HxatzECTEEm+Tm6TZNSxNCM8gN2kFhVy+Wj6
         Gn6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695321295; x=1695926095;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pNpVr3hX07AdKTZ8+Sx0LVisp+9RYkwStP9wMLdYrzw=;
        b=UoG6dvjeyp0Xesvou2juwnsaQ9CN7Q2/doNQRScBlhPG5ynJCRPfl3PFWTNJw6n/tq
         fEyzwxClwCgmwxc8nn70in11IdZNJ1nlNs+DAlO4OU0TbIgn7QuvMdjbIFOoWVYcKv8c
         gdAjhJVxA38w68eu6Tu7mz5SGDx8Hzkbha0FbbnX/FUO6weMoGP6VungmeWNz/xXhgOg
         /Htd12aZe7bI1PZDGWzAAZ7bp21qjdovhGHdJVHqYBAL22i23WGxlfovPS5jT8M+cwXK
         vwEpsqIsD5FL/Tu/nNoY3qa9LJbBrgVOw58y7JOqo4MK2qgjiN70xxLABByoo9YlWPK/
         2Zeg==
X-Gm-Message-State: AOJu0Yzr3oCPACDbLtTurKzXvBrt/YTk0UeEl/vonVeTlvmYgeIFkq0f
        zq6zLGTN1vAkz2lXd8AK28dYd1BaezFfPYXNd8jVTZ/NPJNBk+g7juE=
X-Google-Smtp-Source: AGHT+IFqX3AQtEQOsB1IQQCIx2Q35DO+VOl1a5nyQVZz96a/QlXlu7E2WC2lL+gM1UWaSurybAhPe1nEThyHesRaRIs=
X-Received: by 2002:a25:d301:0:b0:d7b:a78e:6b2d with SMTP id
 e1-20020a25d301000000b00d7ba78e6b2dmr8458738ybf.20.1695301372684; Thu, 21 Sep
 2023 06:02:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230825112633.236607-1-ulf.hansson@linaro.org>
 <20230825112633.236607-8-ulf.hansson@linaro.org> <20230921111426.b2vp5hu7ssdtmz3n@bogus>
In-Reply-To: <20230921111426.b2vp5hu7ssdtmz3n@bogus>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 21 Sep 2023 15:02:16 +0200
Message-ID: <CAPDyKFqHBWtDioepsJuNHEa6ckwtuAOKBLx+LZEZctADTP--3w@mail.gmail.com>
Subject: Re: [PATCH v3 07/13] cpufreq: scmi: Drop redundant ifdef in scmi_cpufreq_probe()
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sept 2023 at 13:14, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Fri, Aug 25, 2023 at 01:26:27PM +0200, Ulf Hansson wrote:
> > We have stubs for devm_of_clk_add_hw_provider(), so there should be no need
> > to protect this with the '#ifdef CONFIG_COMMON_CLK'. Let's drop it to clean
> > up the code a bit.
> >
>
> No exactly. The stub is under !CONFIG_OF but we need it for !CONFIG_COMMON_CLK.
> The original build issue reported for which I add this was CONFIG_OF=y &&
> CONFIG_COMMON_CLK=n.
>
> It looks like it is still valid combo though I don't have a handy randconfig
> to present to you. I prefer to drop this for now if that is OK with you.

Sure, it's perfectly fine to drop it. It's just a thing I stumbled
over that isn't really needed in the $subject series!

Kind regards
Uffe
