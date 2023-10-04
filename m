Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71FE7B775D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 07:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241329AbjJDFIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 01:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241305AbjJDFIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 01:08:12 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B78B8
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 22:08:09 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-277550774e5so1129785a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 22:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696396089; x=1697000889; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l70770mdgEqUwhT+u6LTLNseo5sG7DB+hxhiyDsd/dM=;
        b=lalaXWNN6G/+ussoKHa0tlKqAzdQGMP40YRA6EU4scjzjg5jdWb+eSLhBsfW5rzWKU
         wxd6mv700AIgbn9o8s7NgAj0n/VT1/lnqsUhnr+NRbTON2CRrd0S1M4G+0QP2Lv/lCcM
         9EoYCJ6fowPqRdRzaaDl7UeWO9/3W8SDTW8fMBcXJ4T0rkDPyY33sU0iSZe8l1qMnY5y
         Z4TNu+YaQERN0uzkX3fnUwflbIKBQ6NNWmh1IQQENCIt6GOovxbcjzuiXg8MIS5t7Riv
         4reu5ZEz5Qd+/moN1VaKshbE8+wFl01Hu74z2Naj9gMHhed5ro6hZNe11J+j+ZOLywkI
         +cZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696396089; x=1697000889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l70770mdgEqUwhT+u6LTLNseo5sG7DB+hxhiyDsd/dM=;
        b=wofXYYVF176ECHcBpv6K8DSZt/0PPQpTzAK83PwHcB0Hi9cssZKzsAaMUSnYzrAaPd
         qoyDQr9mpwOa39ZWMTJZWyjLyNH2HiFWNIPW6/CptQbtBO90+J1kwMlXQq7/WDdotu4n
         90NTNr43Q2MBL8dexL0H6yvERAXWhxuQHQUR6Dej1DkEV8pOgAYGOqRANnBvMQUTGDk7
         GjjGux1ZPEOYhnSjiUS8DI0tayJQlDUhPDyuBSj+lAy2CNIOBQZsGGyxcXbCPpfLJuWD
         BAguQz/NwJc3dNqzPs6rSAATOXSuhmXuU3b8suUGJ6ef1JOLWb5xgadMfRkKh+UbWik5
         UTRQ==
X-Gm-Message-State: AOJu0Ywm6E4ge/eiH3DSkM6he3PRh4AIFDDkNStriNNfxLVKm+fIKyWr
        /e0x6x7RYiObIgNEnhaPp1CdnQ==
X-Google-Smtp-Source: AGHT+IFVUCtdnYnN6+YUF/T1crN40uC5L3x/cA+kDoZ1KyDgCWYiDQ10r1/zEGI9NcSWUh0c5LCPfQ==
X-Received: by 2002:a17:90a:348d:b0:273:e8c0:f9b with SMTP id p13-20020a17090a348d00b00273e8c00f9bmr1166418pjb.15.1696396088622;
        Tue, 03 Oct 2023 22:08:08 -0700 (PDT)
Received: from localhost ([122.172.81.92])
        by smtp.gmail.com with ESMTPSA id fs14-20020a17090af28e00b0026b3ed37ddcsm512206pjb.32.2023.10.03.22.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 22:08:08 -0700 (PDT)
Date:   Wed, 4 Oct 2023 10:38:06 +0530
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
Message-ID: <20231004050806.sba3ogq76yiylrro@vireshk-i7>
References: <20230925131715.138411-1-ulf.hansson@linaro.org>
 <20230925131715.138411-10-ulf.hansson@linaro.org>
 <20230929162522.zjoh5d2tqspzm3nc@bogus>
 <20231003082133.xyu46szs3jfm6fks@vireshk-i7>
 <20231003112647.bbqwnre5bzijw5sg@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003112647.bbqwnre5bzijw5sg@bogus>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-10-23, 12:26, Sudeep Holla wrote:
> On Tue, Oct 03, 2023 at 01:51:33PM +0530, Viresh Kumar wrote:
> > On 29-09-23, 17:25, Sudeep Holla wrote:
> > > On Mon, Sep 25, 2023 at 03:17:15PM +0200, Ulf Hansson wrote:
> > > > To allow a consumer driver to use the OPP library to scale the performance
> > > > for its device, let's dynamically add the OPP table when the device gets
> > > > attached to its SCMI performance domain.
> > > >
> > > 
> > > The SCMI changes(patches 7-9) look fine to me. Rafael was fine with genpd
> > > changes, Viresh if you are OK with OPP changes I can take it via SCMI as
> > > there are some dependent patches as Ulf has pointed out in the cover letter.
> > 
> > I would like to take OPP patches via my tree as there are some changes in my
> > tree and I plan to add some more changes on top of this. I can give an immutable
> > branch though.
> >
> 
> Works for me. Please do share it once you have it ready.

git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/pm-domain-scmi

-- 
viresh
