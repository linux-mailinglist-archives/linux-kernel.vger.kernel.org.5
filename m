Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A037FB578
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 10:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234775AbjK1JSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 04:18:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234805AbjK1JS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 04:18:29 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1652B10CB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 01:18:34 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c993089736so32992411fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 01:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ferroamp-se.20230601.gappssmtp.com; s=20230601; t=1701163112; x=1701767912; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BX5EHWclAX+Y7Su5y4Ao52gq2sxmx6CDB37q7Z31L9s=;
        b=0kXp9crkOPIScGIigzjnLD4mzhLulOhEhYtWMRkamlQAviqWkrH6i589kemK3FPZlJ
         Xq8zhG1y8BJ+6mWcV2Lg/fwZZDOtEDBBuyMgznjnsK7f+PmtIw7CMpUejtA0N6k2RIvp
         ux3dUWUWZvQhzubV94K2fSi3hV2DUvSn2NFbdt7z8lX22lAQFodhNqK48B28r5LT/KpL
         4ZAe5LupYOzu3uxapGL0Ssnq96k6MV0gVamARAtCQZcx92ks8AFa1Z5ENsWg31I2oCLy
         NfqimM1IaRzQj065u5OedsguzPM+O1UzrpvLoFhXuoTKpaC7I4aXmTfbJa3aGbVfmQXH
         rjIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701163112; x=1701767912;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BX5EHWclAX+Y7Su5y4Ao52gq2sxmx6CDB37q7Z31L9s=;
        b=OeRdDuMk8LskXzbtDwVzMBpWRMaoxN5nR+eMtr3XBkIWhi1WQYBKYnW7r8oklbUClY
         uqacH2PaH4jZkkVHCPO2PnXjsJ1I+wx7Yrg+NlId/RBqG5RAs2ucvNC46v9Nf9uvTgEm
         au9nt/H5jSBvvMXA9cBPrwFzJUlZrdjVqb//CgkEqg2f0rfgHREJMCbuJ+13XmR18ngi
         ynTGbFGiUYZlhRDSWkv0ZtRF9GhglUeTqvOH+WnaQecg8F5/k5Cm/n3tlaB2D1OhBEZK
         3Y503JSFIXtJze11l6YTzMIXyHg2Au/XW7BoKJJGwbCGGFMY0DnmVw9W+9Wc/uN59Vrt
         PNvw==
X-Gm-Message-State: AOJu0YxRh5vw7c9DNqTWbGuJkaEpEAi9eFotCLBDYPARqMKeRMzrcv6h
        S9Z0HAri5hBSGKAoqGeLFnw8xPdpgtI5eMuqYY0=
X-Google-Smtp-Source: AGHT+IGVraG7YQEubEB8O4W8qya4rCBd8OhBQcjWQd5fWhmYAx3BW5iy9CUnUrNVPApjtASEUaCcwg==
X-Received: by 2002:a2e:2f06:0:b0:2c9:977c:a5be with SMTP id v6-20020a2e2f06000000b002c9977ca5bemr3358646ljv.24.1701163112307;
        Tue, 28 Nov 2023 01:18:32 -0800 (PST)
Received: from debian ([185.117.107.42])
        by smtp.gmail.com with ESMTPSA id u10-20020a2e9f0a000000b002c99eb9c39fsm751701ljk.26.2023.11.28.01.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 01:18:31 -0800 (PST)
Date:   Tue, 28 Nov 2023 10:18:27 +0100
From:   =?iso-8859-1?Q?Ram=F3n?= Nordin Rodriguez 
        <ramon.nordin.rodriguez@ferroamp.se>
To:     Parthiban.Veerasooran@microchip.com
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] net: microchip_t1s: conditional collision detection
Message-ID: <ZWWwYz0w5-ti78QI@debian>
References: <20231127104045.96722-1-ramon.nordin.rodriguez@ferroamp.se>
 <20231127104045.96722-4-ramon.nordin.rodriguez@ferroamp.se>
 <142ce54c-108c-45b4-b886-ce3ca45df9fe@microchip.com>
 <ZWTEqXAwxIK1pSHo@debian>
 <2125cc12-1785-4a49-91c3-6479b0f4044b@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2125cc12-1785-4a49-91c3-6479b0f4044b@microchip.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > 
> > But the change was dropped in that patchset right? It's not present in
> > netdev-next.
> Yes, it was dropped. The reason why I gave this info is, you mentioned 
> in the cover letter that it took some time for you to find this in the 
> datasheet.

Ha, sometimes I have bad luck while thinking. I guess I never understood
that change and subsequently forgot about it.

> > 
> >> As it is recommended to do it in a separate patch and also the
> >> datasheets of LAN867X Rev.B1 and LAN865X Rev.B0 internal PHY have these
> >> register is reserved, we were working for a feasible solution to
> >> describe this for customer and mainline. By the time many other things
> >> messed up and couldn't reach the mainline on time.
> >>
> > 
> > Far as I can tell 'collision detect' is described in the following
> > sections of respective datasheet:
> > 
> > * 11.5.51 - LAN8650
> > * 5.4.48  - LAN8670
> > 
> > The rest of the bits are reserved though. The change I propose only
> > manipulate the documented (bit 15) collision bit.
> > 
> > Is your point that the lan8670 datasheet is only valid for rev.c and not
> > rev.b?
> It is valid for rev.b1 as well but the current datasheet for rev.c1 
> doesn't show that info.

Thank you for clearing that up! So if I get you correctly this change
would in fact be correct for both lan867x rev.b and rev.c.

> > 
> > Andrew suggested on the cover letter that it be interesting to look at
> > completly disabling collision detect, any strings you can pull at
> > Microchip to investigate that?
> Unfortunately I can't commit anything from my side as we are occupied 
> with other activities. But definitely I will try my level best if time 
> permits. Alternatively you can contact our Microchip customer support 
> team if you are interested to do this testing at Microchip.

I get that, might do as you suggest.

> > Also any input on my suggested testing methodology is more than welcome.
> > 
> >> We also implemented LAN867X Rev.C1 support already in the driver and
> >> published in our product site and in the process of preparing mainline
> >> patches. But unfortunately it took little more time to make it.
> >>
> >> https://ww1.microchip.com/downloads/aemDocuments/documents/AIS/ProductDocuments/CodeExamples/EVB-LAN8670-USB_Linux_Driver_1v0.zip
> > 
> > I'm aware, we've been using a derivative of that work at ferroamp for
> > development. But it's been driving me nuts, being the 't1s guy' at work,
> > and maintaining out of tree drivers for weird dev boxes.
> > 
> > It's not my intention to beat you to the punch, I just want a mainlined
> > driver so that I can spend less of my time on plumbing.
> I completely understand. Also it was not my intention too. Just to let 
> you know why it is delayed in reaching mainline and a quick reference 
> for the existing implementation. Enjoy!

I get that, in an ideal world FOSS would be the top prio for all
industry actors. I'm lucky enough to get some time reserved for it.

R
