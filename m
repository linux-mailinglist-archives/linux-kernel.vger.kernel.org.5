Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3A37D0CA3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 12:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376831AbjJTKCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 06:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376648AbjJTKCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 06:02:48 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0F4D5F
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 03:02:46 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5a7b3d33663so6795847b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 03:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697796165; x=1698400965; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+mL5MxDvI3oBEsamV1IpDNv4PqsfIio+p7+hVRLdZkE=;
        b=UYOoQ476ce/PtnDV75b1LiSRuur+1fpqjQceUCtjSOlMkzFBsjK31/Wm68h1KQX9Vt
         TAyQMJ5CbB7jFqIt3HwaoKGtdSYdMBvMDLENKXYJMnhiCCiCF8BnMFerKesrhgEfXAXL
         jAs7uTrjAka2vz4YSB1NqZOtnNJxVinhZeNax1L+nnuzsHSTnaUaS96q2ZGXlqbY3VnT
         HRFdswTGQBhpqJVAB3ACJKSD+iBYYVh7SFCYzveBTNyaSYj4kVhv7VtcXEjG9bMlAfSv
         54JLpBzA1DePGSffUGUQosx/6ytmOdtd29KJhGBA2GeQgkpTe6pcQbUt52bk7S4GMrSS
         6eFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697796165; x=1698400965;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+mL5MxDvI3oBEsamV1IpDNv4PqsfIio+p7+hVRLdZkE=;
        b=IIHxV/M7AjiN+m9xSpg54T5J4dLDqlIpurTXQZJ6vSOFGInsfEi7uF1usGF0ZnADuQ
         6ov9NthS1cbgngxrEuyNf6hDUp4jopYZ1ryUCFHJuO/AKK+8Te3g4ZTZX7AW9dW3iSMp
         6hScK8SfdI/ShNjQ0NzDswHR4PFTTJ6JkGbGAH0ucPb4LrjOFXikqY5nv6teLQxuk/0k
         K7kmYwpjJTGRGqzZMseJT0xRjiZdM4yosmWnG8ZYB6T/nZmYtJalXkwDmpcSsgqs8UJY
         uVc1nVyYr61CKS8qoWFzEl1OD71UXHK8Z+TK5mJniey/O2udktFXxr3l50KA1vo7/Rtq
         Xxtg==
X-Gm-Message-State: AOJu0YycqLMRJYe37Xn6ZfpV6ZZewVMfcr8V9kZmQt2kv24N7MfNWJwt
        poOdNksxsFcYBOljW7x6J4Ucw21jfjMZEIQdvEYWHg==
X-Google-Smtp-Source: AGHT+IEpfYvqZ6a+6ydGk21xngAVclYvEKHHwgr56y8sAhA5hFI+i7S/41Hi3xZbJii/5ZwTg+MpAq7gxp6nNN+sguw=
X-Received: by 2002:a5b:608:0:b0:d9a:e947:447b with SMTP id
 d8-20020a5b0608000000b00d9ae947447bmr1325314ybq.14.1697796165580; Fri, 20 Oct
 2023 03:02:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697710527.git.viresh.kumar@linaro.org> <f709e9e273004be43efe3a2854a7e7b51a777f99.1697710527.git.viresh.kumar@linaro.org>
 <CAPDyKFqbnsdT0nqKwQhai875CwwpW_vepr816fL+i8yLh=YQhw@mail.gmail.com> <20231020034547.suggwoefx5kauek4@vireshk-i7>
In-Reply-To: <20231020034547.suggwoefx5kauek4@vireshk-i7>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 20 Oct 2023 12:02:08 +0200
Message-ID: <CAPDyKFqMA9=qdz4L3Oqj0zRQmSj0bxrF1RzZu-pBcuj9__GSRw@mail.gmail.com>
Subject: Re: [PATCH 1/2] OPP: Use _set_opp_level() for single genpd case
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2023 at 05:45, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 19-10-23, 13:16, Ulf Hansson wrote:
> > On Thu, 19 Oct 2023 at 12:22, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > +       /*
> > > +        * There are two genpd (as required-opp) cases that we need to handle,
> > > +        * devices with a single genpd and ones with multiple genpds.
> > > +        *
> > > +        * The single genpd case requires special handling as we need to use the
> > > +        * same `dev` structure (instead of a virtual one provided by genpd
> > > +        * core) for setting the performance state. Lets treat this as a case
> > > +        * where the OPP's level is directly available without required genpd
> > > +        * link in the DT.
> > > +        *
> > > +        * Just update the `level` with the right value, which
> > > +        * dev_pm_opp_set_opp() will take care of in the normal path itself.
> > > +        */
> > > +       if (required_table->is_genpd && opp_table->required_opp_count == 1 &&
> > > +           !opp_table->genpd_virt_devs) {
> > > +               if (!WARN_ON(opp->level))
> >
> > Hmm. Doesn't this introduce an unnecessary limitation?
> >
> > An opp node that has a required-opps phande, may have "opp-hz",
> > "opp-microvolt", etc. Why would we not allow the "opp-level" to be
> > used too?
>
> Such platforms need to call dev_pm_opp_set_config() with genpd names
> and it should all work just fine. The point is that we can't use the
> same `dev` pointer with another OPP table, i.e. device's dev pointer
> for the genpd's table here.

For the single PM domain case, consumer drivers are often not able to
use dev_pm_opp_set_config(). That's because the PM domain has already
been attached from some of the generic buses, through
dev_pm_domain_attach().

In this case, as dev_pm_opp_set_config() ends up trying to attach
again, via dev_pm_domain_attach_by_name() it would receive
"ERR_PTR(-EEXIST)".

Or maybe I didn't quite understand your point?

Kind regards
Uffe
