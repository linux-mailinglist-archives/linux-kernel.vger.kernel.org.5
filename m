Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57337898C8
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 21:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjHZTSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 15:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjHZTSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 15:18:00 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29CDE66
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 12:17:55 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fef56f7248so18017565e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 12:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1693077474; x=1693682274;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BB/Qrlh4uE7QKBKp3Vg1DlTdu+0RqqMvMBySv+hyH5g=;
        b=Xbk1WqEoohVwYzHjVp3K5OML1bLdmr6oVxRZOLlWMpl8PuO2fzfQyze8lomKI0NYio
         1Yyz5rh6Xz4w4bfDXFvNbHDvv++xPSN9lkSh884/c+1ufAm7nI4x99WWGeyrOZENpyC7
         1wANlI8ptgHexqmIyTG6HvpNXW6g0+fZo90Wvta49zD2KETle9nchxrubVcDpjA7AB7c
         wQlEFELi3j7eV4F4Um0Ib+XJ7iynxQp7JNoAvKc6YgpUNDyFvjdHNu+75D7q4ln1HAox
         b4eeLfyjdCF/YK02ITV+wT0qClamYq0veWR5vnzmLXWgClBq0jNZ2RFHySDR4mWZ44K4
         le1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693077474; x=1693682274;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BB/Qrlh4uE7QKBKp3Vg1DlTdu+0RqqMvMBySv+hyH5g=;
        b=ROls3QU/oGkNOWL9ee8pjB8nVURiJiHVXQ5hIZv2XvYoos58ZjEcZY/SXiix5Y9j3S
         Rmbi81Ld83tfsBSP1HRywsSjXeuOalAdJA3lg+NKklkksThFnd4S/AuZdncvf7K2d5to
         cJTN84Jp9VdyrFGZwff6ji4XeAZg16mlLsD6Fyh0gcjhW9SCEE8L2yfB98CxO1b3ue3H
         hHl54APKbpjzrtgaecCcFYW2MjXqaTyNQBaUHqvhS8UuCEuLtf6dhL96XYUrXM5xaUjv
         pKu+4Y88FY5sizDL1unwwuYJy8eLvvKRTmd4GmvZLuvyfP01tOGKjpO/8yBSafU2oB0Y
         nY4w==
X-Gm-Message-State: AOJu0YyLxgyBDc0xM9yMIRHtWtg1rkODl/PkQWU92ZEkJ5baaJg1wpt/
        U6VyZ9yxulOGnBzXMg6sD1Fhww==
X-Google-Smtp-Source: AGHT+IGFtsXkNGkIpL/vELEpU6KhQSL9Y+5+/WSzqlOrM+r+2Ec5NbNfB3iY9R6NUMMz0ZOxoS61Lw==
X-Received: by 2002:a5d:45c6:0:b0:319:854a:9ea1 with SMTP id b6-20020a5d45c6000000b00319854a9ea1mr15521767wrs.15.1693077474061;
        Sat, 26 Aug 2023 12:17:54 -0700 (PDT)
Received: from airbuntu (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id g13-20020a5d64ed000000b003177f57e79esm5638305wri.88.2023.08.26.12.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 12:17:53 -0700 (PDT)
Date:   Sat, 26 Aug 2023 20:17:52 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH 0/4] Fix dvfs_headroom escaping uclamp constraints
Message-ID: <20230826191752.xus6c7ssuuc2rssu@airbuntu>
References: <20230820210640.585311-1-qyousef@layalina.io>
 <CAJZ5v0jjwKr0py8H34-8ZRS8xS455YUuew8GxBex13uRq7LBPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jjwKr0py8H34-8ZRS8xS455YUuew8GxBex13uRq7LBPQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/21/23 12:34, Rafael J. Wysocki wrote:
> On Sun, Aug 20, 2023 at 11:08 PM Qais Yousef <qyousef@layalina.io> wrote:
> >
> > DVFS headroom, or map_util_perf(), is applied after uclamp restrictions are
> > applied in effective_cpu_util(). This will lead to two problems for uclamp:
> >
> >         1. If util < uclamp_min, we'll run faster than uclamp_min. For example
> >            util = 50, uclamp_min = 100. map_util_perf() = 125 instead of 100.
> >
> >         2. If util > uclamp_max, we'll run faster than uclamp_max. For example
> >            util = 900, uclamp_max = 800, map_util_perf() = 1000.
> >
> > First patch rename the function to apply_dvfs_headroom() to reflect what it
> > really does. It is not really mapping util, but provides some headroom for the
> > util to grow. Provide a documentation for the function too.
> >
> > Second patch is the actual fix.
> >
> > Third patch moves apply_dvfs_headroom() to sched.h as there are no longer
> > users outside the scheduler.
> >
> > Fourth patch is an RFC to redefine what the headroom means for RT, DL and IRQ
> > pressures.
> >
> > Thanks!
> 
> For the first 3 patches in the series
> 
> Acked-by: Rafael J. Wysocki <rafael@kernel.org>

Thanks for having a look!


Cheers

--
Qais Yousef
