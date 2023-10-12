Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F897C7385
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 18:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378739AbjJLQyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 12:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233290AbjJLQyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 12:54:53 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0435CA
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 09:54:50 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-52bd9ddb741so2200640a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 09:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697129689; x=1697734489; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bBUBWcfqd6h2FYCx6HxLCGICG3O8Ap6wf3BtHDsyNkw=;
        b=XYDux2c1jm61KTl0piNXwt+k6rvxPnpV3yItyhaASGTP2US5lB3J520yPNlXP1bEN7
         P/VPJ802FDEHGUtTsu6BO3QVLzh0sGIB1HsEepeVVBX5AZLH4Pgz0dJuiQXVOdQaMzlZ
         vwKnBK5hlpq5+MreMPp5VzAfpHnQr+UWQbtrxDP+AlOyW6KUvUi8GVc+i+rBdVzuG+Og
         ywQsuVByCGWvanFIkNQLS7rxlmF9J31tusfPQy7cw6gcPquZeg5jSBLq9hbjnNVQF7zv
         K20+TeD3pllofe4IXandv7/f9Q5LOsUZeggzhHVdPunJqjcjGb1VZK+HSSWx3V10+h7F
         1iRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697129689; x=1697734489;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bBUBWcfqd6h2FYCx6HxLCGICG3O8Ap6wf3BtHDsyNkw=;
        b=YnehWAWISpeuWKm/2msgBUeXUnOce1whhFlppfrOyGBgsGqNWqWiU14UXssKDgi9+T
         nJzvr1N+KEQxN6vV62l1zMCBv1m5CqCcxM/0ou5TJ/4sPdbu3fkpiV5KV8xpCqaThpLm
         1E0EbHcid5kT7QNV8xSFtyjSRFkJT5rE1AfiIXMW07bnD5Nq1JGHLy4EFFle9lMq2wrs
         eMwyuaMWBfBrzgIOR63aCTs9eve2W2Kcyv7mqYPfBA9CQ/LJ3Ef27/03fFMHX0ST3Pb6
         6tL4Ft5Vw3qCu1mHGw/BaFNa6WKEfSEFVKklQFKjGr93/uFyuoavjpR2dMC5WE07qWrE
         KE+Q==
X-Gm-Message-State: AOJu0Ywpkpu5VWEdojjrrpO2ZdJjPyD59WyOtyu6CfH1dCYMOM2eEKoF
        yc+7SmQ7xn69/z6kemRBKhjhaBzOOH/7KWynBH+/QA==
X-Google-Smtp-Source: AGHT+IERlaWWwiML/RFT3cp2GcW0IWarhx9gkibx1TlIHF9bhAGNQd9/QPTUhc2WeHSsLpPbF34UNy9rAMlj9u2bDOA=
X-Received: by 2002:aa7:d88e:0:b0:532:e24d:34f4 with SMTP id
 u14-20020aa7d88e000000b00532e24d34f4mr21115676edq.39.1697129689228; Thu, 12
 Oct 2023 09:54:49 -0700 (PDT)
MIME-Version: 1.0
References: <267abf02-4b60-4a2e-92cd-709e3da6f7d3@gmail.com>
In-Reply-To: <267abf02-4b60-4a2e-92cd-709e3da6f7d3@gmail.com>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Thu, 12 Oct 2023 18:54:11 +0200
Message-ID: <CAMZdPi9RDSAsA8bCwN1f-4v3Ahqh8+eFLTArdyE5qZeocAMhtQ@mail.gmail.com>
Subject: Re: Intel 7560 LTE Modem stops working after resuming from standby
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        M Chetan Kumar <m.chetan.kumar@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux Intel Wireless WAN <linuxwwan@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chetan,

On Thu, 12 Oct 2023 at 11:52, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> I notice a regression report on Bugzilla [1]. Quoting from it:
>
> > I noticed a few days ago, after Fedora moved to Kernel 6.5, that my Intel LTE Modem was not working anymore after resuming from standby.
> >
> > The journal listed this error message multiple times:
> > kernel: iosm 0000:01:00.0: msg timeout
> >
> > It took me a while to determine the root cause of the problem, since the modem did not work either in the following warm reboots.
> > Only a shutdown revived the modem.
> >
> > I did a bisection of the error and I was able to find the culprit:
> >
> > [e4f5073d53be6cec0c654fac98372047efb66947] net: wwan: iosm: enable runtime pm support for 7560

Any quick fix for this issue? alternatively we will probably revert e4f5073d53.

Regards,
Loic
