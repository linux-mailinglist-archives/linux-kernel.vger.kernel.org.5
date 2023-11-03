Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4281C7E005C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347054AbjKCJ1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 05:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346918AbjKCJ1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 05:27:52 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824B4D42
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 02:27:45 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3b3f6dd612cso1050723b6e.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 02:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699003664; x=1699608464; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/JFSE2qOGNazjKUVydqtbauL0uEuW82gwvRIGwH8lt4=;
        b=KL0LOoXdRacWnDVcxm8tqQ2RiGs72LHHn/+yvh/rsFFR4eG3OeLHRRXZizstRTosFC
         eAkbS5CcXFwScohKy3y0bBJj3WlaM4/3zOAsdSZmtfmu3V6O/x+zffYdr/bRVdmJZSY4
         ApdD2AQwoQbTPa7NV6aBEXRokHesM7103dhzjHhN1wK3rdV0fFaRC02CTRhGieViUYxN
         m6ySluT6MsH7c+2epygnICRWIOcRBP4BiCNLJPuUJqg6Lc3Yv3YI5nl4MztcEdfgCADd
         326XIzXeCL5M9iiaP5ySx63uxbSAmqRObCes9VpaTce6MVyXv/1GhbR/onNOyPjYMmqp
         EmFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699003664; x=1699608464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/JFSE2qOGNazjKUVydqtbauL0uEuW82gwvRIGwH8lt4=;
        b=NiHhjLB5rvzqGX7dihYy5r3jHVRGtPMYdd2Yz92uZqV2zsIHtHVlHfi2UEVjOSY533
         1PUamHKTRpd1Ra+iLJjW4ifCjs5V3Y0C3vw8lQOhV1zfpxTQhzvJKGXwU3RooDW1NI5h
         jaVa+cO0BGEXqNdhgWY1d5x4CElI0R0LLws01SROnhsI5UVy+jKZbHyVqFxlEwpDZYUj
         uNVGF+9GuKJdW4/y9T2RTTGROX4MzVzGAd2p4UCbgmc1Kqbevn+AT14NdogJ9LwWZ3ZQ
         oMYwo2pDIqxZgmQ7pCA5l/R9pXQm4dQ3+28ExuDaIfS6etVXyRaP52N0ST0qhb9dtgXK
         PXZQ==
X-Gm-Message-State: AOJu0YzUI2dODDGaIa54mCKf4IhT3zcYnR9vPbW2GDMwhX5DolpKkS2W
        mA7uiJP5lMiW/N7vbmy5Giu8hA==
X-Google-Smtp-Source: AGHT+IFe5Oima4S4vQnh5wSsel9Yhm8kcUYCH+fUgMXAJHF5XzbdSuO424GkYZfFF2vK9hc6VxG6ow==
X-Received: by 2002:a05:6358:898:b0:168:d169:44 with SMTP id m24-20020a056358089800b00168d1690044mr22235879rwj.1.1699003664571;
        Fri, 03 Nov 2023 02:27:44 -0700 (PDT)
Received: from localhost ([122.172.80.14])
        by smtp.gmail.com with ESMTPSA id i190-20020a6387c7000000b005b96b42f7ccsm978426pge.82.2023.11.03.02.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 02:27:43 -0700 (PDT)
Date:   Fri, 3 Nov 2023 14:57:41 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 0/3] OPP: Simplify required-opp handling
Message-ID: <20231103092741.mk2suut7f7vlhneo@vireshk-i7>
References: <cover.1698661048.git.viresh.kumar@linaro.org>
 <20231103052854.bc7jqaubc5uj6ncj@vireshk-i7>
 <ZUS8OC6tY4sxS5RA@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUS8OC6tY4sxS5RA@gerhold.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-11-23, 10:24, Stephan Gerhold wrote:
> Sorry for the delay. I tested this successfully on the MSM8909 board on
> Wednesday (with the single genpd, and without opp-level 0 there), but
> until now didn't find time to test it on the MSM8916 board with the
> multiple genpds and the opp-level 0.

Thanks.

> The opp-level 0 works fine now, thanks for fixing that!
> 
> The warning in _link_required_opps() when using the parent genpd setup
> [1] is still present though. Given that this setup is an existing
> feature in the genpd core I would appreciate if we try to find a
> solution before merging this patch set. It's kind of a regression
> otherwise since the warning isn't present without this patch set.
> Maybe someone else is already actively using such a setup.

I did mention the solution that I seem fit for this case [1]. That's what I have
in mind.

-- 
viresh

[1] https://lore.kernel.org/all/20231030102944.nrw4bta467zxes5c@vireshk-i7/
