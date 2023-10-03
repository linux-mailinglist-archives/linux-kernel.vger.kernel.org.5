Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE22A7B63ED
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 10:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239213AbjJCIVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 04:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbjJCIVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 04:21:39 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A90FA1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 01:21:36 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6910ea9cca1so446718b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 01:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696321296; x=1696926096; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+aaNV5nSy/KAd8iihL3GhD9w/b0Q3KbrKmVSuy4p2tc=;
        b=PWPgaXr8X0cPCJMc2asGO8sO+NCgXKi+h49M9bQ+PgCIppYB5MBiUo22hwnyNXbtg4
         YmAv09shQ/WH1veiKJ8Tm3zhA6+9/bwydQjo3oFR9VPVVvJ9lk7WOOd95rr1t9wzjXlK
         IfowtaVmDMkEamA+AtLWeJrMGEx6dyR2exqw/X0nps1cRX+JjwHOonypSGDpI4UmaOzY
         rXtnAi9oxDjjxv2aauvJAe3y41xo1ccPqvfmcgWPLoSALShsCiqryXB2UNpP41mgC1hA
         ffirKKGhsh+Z6VPahYhKKTh1WusNIStlKJ54TRy79ZAi4VLTbcs723AX1G38kcogVdH9
         BmDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696321296; x=1696926096;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+aaNV5nSy/KAd8iihL3GhD9w/b0Q3KbrKmVSuy4p2tc=;
        b=nkhUifvKIoCEn4+3D/e/LZ1pG2JlpPPuXG/le45j9owrFxKSfaj8AOvUbuFZPWX9tr
         R5+zNcwCRkz20SibEGAcfallC6/pB0UJdb4S0WnNb2uQrEbihj8Duec+FJZeZIn1m9Fh
         Pf0juPIhdcf4o7TZ0kHi+rq2lZ4bC0+otOJKmzALyHkCk0e2DLtywQFiXvHqkmS84VWM
         ZQTqEIFLRmRzcTwgZjlv1cB879NDNkbn9334/g06vYAdqz3f8nyJ/XsikSsYQjMw/RB+
         cTHxXwzT/fIzroJg5p47N5xFSUZMBhvf44UlJK+ErHsMBKPmI1Npw63hseMQQdp2WWnc
         w1fQ==
X-Gm-Message-State: AOJu0Yxg5KOnFDh2Zn+gXFeaO6k3CV0cP7L6L4BYKScBNSMx3uEzg9QT
        irDKKzXFP8gAvv7acvtScpPOvg==
X-Google-Smtp-Source: AGHT+IEATzV7abUZFF6xFfy/+Rr7GpXpiBqELT+NPng/a9aV8AItxjSjSR/Hxv3zjFlurKxuA19ewg==
X-Received: by 2002:a05:6a00:80e:b0:666:e1f4:5153 with SMTP id m14-20020a056a00080e00b00666e1f45153mr14118407pfk.0.1696321295977;
        Tue, 03 Oct 2023 01:21:35 -0700 (PDT)
Received: from localhost ([122.172.81.92])
        by smtp.gmail.com with ESMTPSA id gu17-20020a056a004e5100b0068fe9f23bf4sm773809pfb.103.2023.10.03.01.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 01:21:35 -0700 (PDT)
Date:   Tue, 3 Oct 2023 13:51:33 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 9/9] firmware: arm_scmi: Add generic OPP support to the
 SCMI performance domain
Message-ID: <20231003082133.xyu46szs3jfm6fks@vireshk-i7>
References: <20230925131715.138411-1-ulf.hansson@linaro.org>
 <20230925131715.138411-10-ulf.hansson@linaro.org>
 <20230929162522.zjoh5d2tqspzm3nc@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929162522.zjoh5d2tqspzm3nc@bogus>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-09-23, 17:25, Sudeep Holla wrote:
> On Mon, Sep 25, 2023 at 03:17:15PM +0200, Ulf Hansson wrote:
> > To allow a consumer driver to use the OPP library to scale the performance
> > for its device, let's dynamically add the OPP table when the device gets
> > attached to its SCMI performance domain.
> >
> 
> The SCMI changes(patches 7-9) look fine to me. Rafael was fine with genpd
> changes, Viresh if you are OK with OPP changes I can take it via SCMI as
> there are some dependent patches as Ulf has pointed out in the cover letter.

I would like to take OPP patches via my tree as there are some changes in my
tree and I plan to add some more changes on top of this. I can give an immutable
branch though.

-- 
viresh
