Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28BA77D70AE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 17:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344415AbjJYPUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 11:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234999AbjJYPUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 11:20:07 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310EA129
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 08:20:04 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-692c02adeefso4732260b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 08:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698247203; x=1698852003; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y3lv5Qm5KZ1wBNQrJphcoB2ScgP49VyKoXNn5pKg2JQ=;
        b=YDMEaIIk8pVpzw3S4+Ydtt2PxmoFjfCRnEa0fHU8KDFDrYiQPQ8rgdbg/R4hhq10JZ
         HYXWj7G0WgUqIUapJwqNAjrLkZh8l3VbbAOjKgG0cOlaKS85U3QLeQI/A477r49JBAVi
         jbMRvavqSDBXF8EfVXvBQW31orlcPnOzB7gkIgHi7pT7SmRe116w5Gfw61v9DYMnV2nZ
         rhz6oanQ2cPCvEsgQQBjY1CjDoLvwgCiI9Ked03ZKIDKfxLq4ZodjYyOg9llSvNfZROl
         HUbPgUKUgjUrAwmVuyo+p/Oq1fI0KgYsgfhmExUcxByS/rxL7obXlPhAm/ByJvQhB+fT
         UuKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698247203; x=1698852003;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y3lv5Qm5KZ1wBNQrJphcoB2ScgP49VyKoXNn5pKg2JQ=;
        b=ckOANLrLaXEvNztwRu30kDjLuKY9mghKpayIRmHoJMvvF98OMf4DWYcu45zS+5R3vT
         ortd/2Kno/au6n+DTe6vneOu7LDJ2zM51DCGEpAYVIqNN6ikoGtw4AMyKws/J/+cBNg+
         ealFx98b2aAVu0w/qVKbtXHXajBtmBCVd40dOigkkz1/qXGKr7qHOsAHcn9WPNjrdJsO
         ykYGS5HIHAyMhb6TbS13TMizsGya7nOV58jjBvqTHS0mvBGMz/xcrkviRD9L/ztJG2R2
         B+5wxzYnc9vvxkfy2h+MiREdcNr6ZLfDaZJBmS51i3tTPdda+94weVpHP3AcvC6tcz3E
         II0A==
X-Gm-Message-State: AOJu0YyHGOZyBRAXvdG1Q+qgMnwVENoauMQZXwS8hRzUfH65b9VtGkWf
        4fTuEehxEJorRcYHLUC8+9NKO04VrjrK8X9kAq8=
X-Google-Smtp-Source: AGHT+IHuPJHjdoBIwDwcqCz4PeKbTfg6uUqoUwmTS9o/HT5n2myKx3q7PaKsTU/fu9BhHPDvFXqDLw==
X-Received: by 2002:a05:6a00:158a:b0:6bd:2c0a:e82 with SMTP id u10-20020a056a00158a00b006bd2c0a0e82mr15248100pfk.7.1698247203587;
        Wed, 25 Oct 2023 08:20:03 -0700 (PDT)
Received: from localhost ([122.172.80.14])
        by smtp.gmail.com with ESMTPSA id m188-20020a6258c5000000b006bdd1ce6915sm9919976pfb.193.2023.10.25.08.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 08:20:03 -0700 (PDT)
Date:   Wed, 25 Oct 2023 20:50:00 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] OPP: Call dev_pm_opp_set_opp() for required OPPs
Message-ID: <20231025152000.vt42gvti2e4rewwc@vireshk-i7>
References: <cover.1697710527.git.viresh.kumar@linaro.org>
 <6de4fcb5bb943a131d0cdf0a858bd35af02a2f88.1697710527.git.viresh.kumar@linaro.org>
 <ZTeoGiMQZ-OoYJBG@kernkonzept.com>
 <20231025073634.4et5epfog25o2pxf@vireshk-i7>
 <ZTkHVVq61lrpRUOv@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTkHVVq61lrpRUOv@gerhold.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-10-23, 14:17, Stephan Gerhold wrote:
> Thanks, this seems to work fine.

Thanks a lot.

> I found another small problem: In my OPP setup for MSM8916, some of the
> required-opps point to an OPP with "opp-level = <0>" (see [1], the
> <&rpmpd_opp_none> in the cpu-opp-table). This is because the vote for
> the "CX" domain is for the CPU PLL clock source, which is only used for
> the higher CPU frequencies (>= 998.4 MHz). With the previous code you
> made it possible for me to vote for opp-level = <0> in commit
> a5663c9b1e31 ("opp: Allow opp-level to be set to 0", discussion in [2]).
> I think now it's broken because the _set_opp_level() added by Uffe
> checks for if (!opp->level) as a sign that there is no opp-level defined
> at all.

Yes, we broke that. I think a simple fix is to initialize the level
with an impossible value, like -1 and then 0 becomes valid.

> Based on my longer discussion with Uffe recently [3] it's not entirely
> clear yet if I will still have the reference to &rpmpd_opp_none in the
> future. Alternatively, we discussed describing this differently, e.g. as
> a parent power domain (which would bypass most of the OPP code), or
> moving it directly to an OPP table of CPU PLL device node (which would
> only describe the actual "active" required-opps).
> 
> I'm not sure if anyone else has a reasonable use case for pointing to a
> required-opp with opp-level = <0>, so we could potentially also postpone
> solving this to later.

I would like to fix this respectively. Thanks for bringing this up.

-- 
viresh
