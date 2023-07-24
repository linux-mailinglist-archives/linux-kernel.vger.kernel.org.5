Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7940275EC8C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 09:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbjGXHb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 03:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjGXHb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 03:31:56 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6362F180
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 00:31:51 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b9ecf0cb4cso21855815ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 00:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690183911; x=1690788711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hzb9R8lCU0AMrRnJNl8Sap3uv+cEIqbaHFcd9LXeQuY=;
        b=af8d+656EfuW1izH08jTFZGpa1xT7Acz/ZGK5yvTSZ83ZfvOHOl1rUs/OorIUCcPhn
         V15EIJHl59wDoHczKz+UOoG1KIN+/nCqC6mE4aDU5r12ms5KJtzqUHX515I1i68DlOGb
         cB5IAChcfxaz/8Aeakbur/2ejqYO7CCSmZ3IC3qBuwqYFR3Khq3n/cLz9IRXgy5YKdDX
         TZc5vOKhR/Syj9xkwWO9nmEkwT5gwfzXkvsCoDEHXQVTsm+JLMmlGuui9/Rbryr5WFpQ
         cEqS67ONoT+0IEQ0T/+iY1PICPDiXKtCifnVFk64y9+2aQhUJdkOF6NxIdMMvOfyrFta
         Dtow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690183911; x=1690788711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hzb9R8lCU0AMrRnJNl8Sap3uv+cEIqbaHFcd9LXeQuY=;
        b=HbI2zJvION0HEvRXtwKrrhtNd3zEiNUFeu8fPjgAcnkfKBF1AfYiFQIe0FgXJ97Ljo
         BDtjtRLDzgiKA5wt65oSeoTvThuSHag8DhlSko+71LJLCd8Y8uUfkdwKlUj0cXxNmL0K
         wN9stSfnKsqhtwucqqgAjRaCU7zawn6Qm/bXeHoLM8+x7q5rejM7pSiMN81E5DMTNJ2j
         0jtj+DEjoGIA0pE1jL5oa78Yrh2r1vf77NIUnW4yqp+Q8JTUlDWQH7acpW9FGs8mDHue
         SN07bEuw4wif/mvtHMttxYtlP4cfDzJJpym/Jm1cpVSDZ5yOsl5DRNxhlggyY/6cs2Ag
         YIrA==
X-Gm-Message-State: ABy/qLZnKISCxM21WaX6Lb9HMjvdML7j7/5Sq+kss02b/6MCQ/Qgx/IQ
        j7so3Ni3oIZOcI2qmbSyCUYvuQ==
X-Google-Smtp-Source: APBJJlFCRl2GEyTwOCqo1TnJTpEbjheY6LyaUz5t6tx2VEpuopNGwYsI7RzVxeF1LbI06X75CVTGlw==
X-Received: by 2002:a17:902:e843:b0:1b8:a569:f980 with SMTP id t3-20020a170902e84300b001b8a569f980mr7320059plg.65.1690183910886;
        Mon, 24 Jul 2023 00:31:50 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id n5-20020a170902d2c500b001b89466a5f4sm8080711plc.105.2023.07.24.00.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 00:31:50 -0700 (PDT)
Date:   Mon, 24 Jul 2023 13:01:48 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] OPP: Add dev_pm_opp_find_freq_exact_indexed()
Message-ID: <20230724073148.c4pmnqc5h42wsma6@vireshk-i7>
References: <cover.1689932341.git.viresh.kumar@linaro.org>
 <852a47c0e7a795bdf6424519ab7fadfdeb5b4a3c.1689932341.git.viresh.kumar@linaro.org>
 <20230724062405.GJ2370@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724062405.GJ2370@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-07-23, 11:54, Manivannan Sadhasivam wrote:
> On Fri, Jul 21, 2023 at 03:10:57PM +0530, Viresh Kumar wrote:
> > The indexed version of the API is added for other floor and ceil, add
> > the same for exact as well for completeness.
> > 
> 
> Well, "completeness" makes sense to me but I always heard that you should add
> an API when there is a user. That was the reason I didn't add it in my patch.

Yes that is true for any new API I guess. But since we support multiple clocks,
it made sense to support all three variants here.

-- 
viresh
