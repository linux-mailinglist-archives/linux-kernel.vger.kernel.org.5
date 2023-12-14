Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADCB812E11
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443923AbjLNLFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443928AbjLNLEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:04:49 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B5411D
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:04:55 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5e36848f6c6so6942897b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702551895; x=1703156695; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k4LjNhjVor5/6wirmCLkKeqg2J9GNr9MNYI9kwcT2bQ=;
        b=WIXHXeqNdWjdIrnmUNajxyol2FFxOqMnha/j8SYxxbnJcg1iSl+So08BNI+ghxeMjD
         5RbhGm5r9BI/1K9jvVSvg/xewbzZgbJ7GmRruOXTj1LgzdZU/p4OUdepOD+L7NZy3OvU
         AmUmbXBos5lXlvojfEZvKxs35A+u+WD2VBJcgbbFOFH0mjDdwyNRvjaYRchsWzAl5khn
         EukQuPChIJG3Ho2MwF414KGfzEzd9PzOI50BQqxLIfJrNtB3wIs67zdbSWJ+ANjES8Uw
         V2EYd/dnhR4SWFtAT4G4/kaFjSpLtXr8ugI9XrsfUPOM7RwYK/68PtpmMy70CD2WijWJ
         so4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702551895; x=1703156695;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k4LjNhjVor5/6wirmCLkKeqg2J9GNr9MNYI9kwcT2bQ=;
        b=NOd82Q9S6FV5wayZAtTa1dj4R0vc+vG9yFN5UAHokMQnDU9DELbHJx3hfyhj3kUDLY
         sibQeba6P8mGSAQ4qymx0mDGnWkmsGzcn07Esfv2MmLdHj8/aQB1WLrwbH+c+laRHYi4
         Zu+kdCUfb+kRq60+AUIoY1WMQwjDPakdvLmxMhK1E2FkCG4YGUVQPpKxDOTxHNg4ppon
         WV1wWw17sj33AlpHInCKKlDonUZaKyzBNeb8/erPySenG3y77bxN4/v9BdE6cq9Kf3Jo
         EvNaGuxLbNTPfCSjBinXHLOX4pl7JT64Ywi0C+6MxfupsHXuGgcNq6RA+ESMEhLYp8B5
         59bQ==
X-Gm-Message-State: AOJu0Yx4OWzVUxXgZT/lu05mn3sNTNDImD5Yr2A+0cv9lAD5e0/Cm6/G
        +gLGpRl/3SoYV/7mYbMxhBh73rkA5ujEn/E4mugTqQ==
X-Google-Smtp-Source: AGHT+IG1aVfgGukkmoWFZ26DkxbhMt3gFHTO1lxEdG4EQYpm8eoQSZ2vaSwJ0MuCmhGGwTkFAPs+C/QBMZ6dBUPpQgg=
X-Received: by 2002:a0d:ca0a:0:b0:59d:d85e:795d with SMTP id
 m10-20020a0dca0a000000b0059dd85e795dmr7736662ywd.51.1702551894820; Thu, 14
 Dec 2023 03:04:54 -0800 (PST)
MIME-Version: 1.0
References: <20231213210644.8702-1-robdclark@gmail.com> <ZXqr0RFw9KsP876v@hovoldconsulting.com>
In-Reply-To: <ZXqr0RFw9KsP876v@hovoldconsulting.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 14 Dec 2023 13:04:43 +0200
Message-ID: <CAA8EJpoSvaq9imP-dT4p=4jveZyFmh=OoWOP7jWGo4OYkHQDTA@mail.gmail.com>
Subject: Re: [PATCH] soc: qcom: pmic_glink: Fix boot when QRTR=m
To:     Johan Hovold <johan@kernel.org>
Cc:     Rob Clark <robdclark@gmail.com>, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Dec 2023 at 09:16, Johan Hovold <johan@kernel.org> wrote:
>
> On Wed, Dec 13, 2023 at 01:06:43PM -0800, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > We need to bail out before adding/removing devices, if we are going
> > to -EPROBE_DEFER.  Otherwise boot will get stuck forever at
> > deferred_probe_initcall().
>
> Can please you expand on why this is a problem here in the commit
> message?
>
> The aux devices appear to be tore down correctly in the probe error
> paths so how exactly does that lead to deferred_probe_initcall() being
> stuck? This sounds like we may have a problem elsewhere which this patch
> is papering over.

This is a known problem. Successful probes during the probe deferral
loop causes the whole loop to be reiterated. Creating child devices
usually results in  a successful probe. Aso I thought that just
creating new device also causes a reprobe, but I can not find any
evidence now.

>
> Also where does the probe deferral come from in your case?
> pdr_handle_alloc()?
>
> If this is a correct fix, I'd also expect there to be a Fixes and
> CC-stable tag.
>
> Johan
>


-- 
With best wishes
Dmitry
