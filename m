Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE997C9E4E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 06:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbjJPEmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 00:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjJPEmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 00:42:07 -0400
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762BED9
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 21:42:02 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40572aeb73cso41551765e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 21:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697431261; x=1698036061; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+OOjXanV6ifmADtLDN2bjdEAHMH7dAxhg1yhRTNpb/Q=;
        b=mD/VPJ2iF8ANl0x72C8pPI0inTtyQ6vYnF0059voZw4FjcL2FSwoNF3E/1OTFWQYWP
         jDzhbOhH6rSPVT7vVgJs3kxjaZjQks+zjANvFc9uKOlJ/FA/GviMguO3bVpTmPKp7S9P
         gJwat65bRfm//JwM+qPy+7P0lZ4T8rCkaiX+gT5wC4ZHKK/zb/oU4W0ULRMHOMpVozqP
         tv/O8MqE9A1yQiD3k7pPwO2KcYuJtZ7vSVKMxHjBb1o6Kuzpxgb1GzgEwiucibgQeV2v
         39ZK7OHG0AM+Z5uvF/iSfEsxvl+3NCVmkHtTYwiFOAntQ882yfWiYIJ8aB6DakRFzpV6
         pXkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697431261; x=1698036061;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+OOjXanV6ifmADtLDN2bjdEAHMH7dAxhg1yhRTNpb/Q=;
        b=VeVBts9NgzCGUXlGfp2//Nu7y/Fgxus29nExeKXEwOvtHJeCLW59bAKSwhZw7pRRRG
         85WhydgqzIO71mNta7Kr5Ql9hZHeOB8TWRfENP0mitbX5IVk7pqDGILGBdBPq9MUB/es
         ycCNkaVdYqDDKRfVWj+jeUqQJfSUDDd8U5FDMFvh43NdNupWb3edQhuI8DQ/ujxJHu1e
         LPkGu1arQLJpSNubq/dQpIMNFpcQbRpza4rLce0/wxT7XCfhRciiQukVAzz5Byg+2wGy
         3o4GrqDD05MpFV+IOPHBmPXpZUb/QBe2BG/ZLTjvOHUamLGvLB0kiqQ8pxopJPigqrAY
         AAng==
X-Gm-Message-State: AOJu0YxEa3oXji4NIfL1ReihD7KCpUJtflmsrcAH9Y2V3nYxM0TbROCi
        aH/Q0hYaYL9GiOjFl/YJAfUPew==
X-Google-Smtp-Source: AGHT+IEm5GricQB6syD6gMHQyZ6a2BD8XGv+Epu5n10M8kZHUL3BWaF8I0nx3BvzJLt/93ztsJFwng==
X-Received: by 2002:a7b:c851:0:b0:405:3252:fe2 with SMTP id c17-20020a7bc851000000b0040532520fe2mr28195556wml.14.1697431260924;
        Sun, 15 Oct 2023 21:41:00 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id p18-20020a05600c431200b0040642a1df1csm6020508wme.25.2023.10.15.21.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 21:41:00 -0700 (PDT)
Date:   Mon, 16 Oct 2023 07:40:57 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Calvince Otieno <calvncce@gmail.com>
Cc:     outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Luke Koch <lu.ale.koch@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Simon Horman <horms@kernel.org>, linux-staging@lists.linux.dev
Subject: Re: [PATCH v2] staging: wlan-ng: remove helper function
 prism2sta_inf_handover()
Message-ID: <4c29cb7a-3b24-4682-9211-09aff1e01360@kadam.mountain>
References: <ZSkg7y2Y2T3midXB@lab-ubuntu>
 <67d90726-15b9-4d64-87c6-bfbf662cbe81@kadam.mountain>
 <CADFX3ORVXcEBzovdbPawW2SLxcMoraKBmmLuOFkMpnHj=T48qQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADFX3ORVXcEBzovdbPawW2SLxcMoraKBmmLuOFkMpnHj=T48qQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 07:04:56PM +0300, Calvince Otieno wrote:
> On Fri, Oct 13, 2023 at 3:12 PM Dan Carpenter <dan.carpenter@linaro.org> wrote:
> >
> > On Fri, Oct 13, 2023 at 01:50:23PM +0300, Calvince Otieno wrote:
> > > prism2sta_inf_handover() function basically calls pr_debug() to print
> > > a literal string. This can be done by the parent function directly.
> > >
> > > Signed-off-by: Calvince Otieno <calvncce@gmail.com>
> > > ---
> > > Patch version v2:
> > >       - Replace pr_debug() utility function with the module specific netdev_dbg()
> >
> > This isn't a v2 patch, right?  This patch assumes that we applied the
> > v1 patch...
> >
> > This patch is not white space damaged though so that's good.
> >
> > regards,
> > dan carpenter
> >
> >
> 
> Hello Dan,
> Does this response mean that the patch was accepted?

Ugh...  No, sorry.  I suck at emails.  White space damaged is not good.
I left out the word not...  :/

You need to figure out what's going on there.  Some of your patches are
not white space damaged so sometimes you're doing it right but here the
spaces were replaced with tabs so it doesn't apply.

regards,
dan carpenter
