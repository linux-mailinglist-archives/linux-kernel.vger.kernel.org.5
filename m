Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC1778B214
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 15:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjH1NhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 09:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbjH1NhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 09:37:04 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCA912D;
        Mon, 28 Aug 2023 06:36:30 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-56c2e840e70so1902997a12.3;
        Mon, 28 Aug 2023 06:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693229755; x=1693834555;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=auACfXGCbbFOjB74ybEF5PVfXFncMm7FKTVCup4nmSo=;
        b=pkRtKdz88GxIDbRaMkj5fW3vKxh/MAV7cl5mx7RZiLDySt3g7Yb6VnnFbv28BKybqh
         r+79lVauJuvdY1+lqzPPzfiqWCVOlNgr0+LciOjJzvRGiwAste4+er+0J96hKdpAz1f7
         Yio3aKqzQezji6rhTpQilqhJoBZNHjaZbrwv48Kepy397tcfropdqNMlBH7GsKq2LcbT
         Jw6CGEFS8HA5nB7+knscdH1ieuHGFa/wSG6KG2DyQD09MEFAdkTvDwzF1Yrrq1yH4SQ5
         kfHlZ4Q91aq3jOZ5iKO86uGBUo3lM/HpQ7J92m6eOmlQ2HCvu0xwjk9TQVm5uvk7NiqN
         7+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693229755; x=1693834555;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=auACfXGCbbFOjB74ybEF5PVfXFncMm7FKTVCup4nmSo=;
        b=BemgNB2Q1mt2ZfbQDCduIAAAxIxyKR1fx1mRHmABYH+LujCxiLaXMSfywSb52PiPR1
         YL7rIuTdWAaQJnVraAEKYRv3p74ku3TVAchMhl1nSHxxe06EOWDwTM470p/K6dZ+cg5c
         Yt6F73vkATf3hoxz2ALEoSa3a3SivTPSHXV+Byum2pXT+PoyASOEeVNWNOZx1Y59WSIJ
         DXxx2QTFWPOICmn5h6mFellkpG+PQUt/KER0PGUuhqMTXbX6Yt01DLcjcMYofntNaZJs
         79j0zp7nV6JChTTBBdKeC2mF/QMAxG0rwuntW562YP9L3arHf5yl8U8m5qdyJrICo4wo
         My7A==
X-Gm-Message-State: AOJu0YzjpJBnrEkwK5J/UUvSUA93PrABQkd6mznbCcmYC+W1mF8JO7iu
        LmBS0bIrzZNdtspKnOWuQj0=
X-Google-Smtp-Source: AGHT+IGIKxvNNfzWtwnnWnDF807M3LgxxR/+xOoa0ANvJEePdvoDZBASveP8tGfSRLviYuVgBl1ICA==
X-Received: by 2002:a17:90b:14d:b0:26d:17d6:399d with SMTP id em13-20020a17090b014d00b0026d17d6399dmr24900491pjb.38.1693229755484;
        Mon, 28 Aug 2023 06:35:55 -0700 (PDT)
Received: from atom0118 ([2405:201:6815:d8ef:d0d4:95e1:652c:465b])
        by smtp.gmail.com with ESMTPSA id o7-20020a17090a4b4700b0025be7b69d73sm7099991pjl.12.2023.08.28.06.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 06:35:54 -0700 (PDT)
Date:   Mon, 28 Aug 2023 19:05:47 +0530
From:   Atul Kumar Pant <atulpant.linux@gmail.com>
To:     Michal Simek <michal.simek@amd.com>
Cc:     shubhrajyoti.datta@amd.com, sai.krishna.potthuri@amd.com,
        bp@alien8.de, tony.luck@intel.com, james.morse@arm.com,
        mchehab@kernel.org, rric@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        shuah@kernel.org
Subject: Re: [PATCH v1] drivers: edac: Drop unnecessary error check for
 debugfs_create_dir
Message-ID: <20230828133547.GA58271@atom0118>
References: <20230815203826.51792-1-atulpant.linux@gmail.com>
 <723e803b-6f8b-ceb3-e987-4a6f83d89222@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <723e803b-6f8b-ceb3-e987-4a6f83d89222@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 09:31:54AM +0200, Michal Simek wrote:
> 
> 
> On 8/15/23 22:38, Atul Kumar Pant wrote:
> > This patch removes the error checking for debugfs_create_dir.
> 
> Avoid using "This patch".

	Thanks for pointing this out. I'll remember this.

> 
> > Even if we get an error from this function, other debugfs APIs will
> > handle the error value and doesn't crash in that case. Hence caller can
> > safely ignore the errors that occur during the creation of debugfs nodes.
> 
> First of all which issue do you have? Did you see that folder is not created?

	I have not seen any issue as such. But going by the comments before
	the debugfs_create_dir API (https://elixir.bootlin.com/linux/latest/source/fs/debugfs/inode.c#L583),
	we can ignore safely ignore the return value from this API.

> 
> I am not quite sure if this is the right behavior.
> In the code there is
> 135         if (!parent)
> 136                 parent = edac_debugfs;
> 
> It means you are right that if creating ocm folder can fail and properties
> will be still created under edac_debugfs but is this the right behavior?
> 
> altera_edac/armada_xp_edac/i10nm/i5100/igen6/others are checking return
> value that's why I can't see any reason to remove this checking from one
> driver.
> 
> If you want to fix all please send patch for all but I don't think it will
> improve situation and it will just hide different issue if creating folder
> fails.

	Understood your point. Are you suggesting that we should keep these
	checks as it is, or should I fix for all the drivers and upload the
	patch ?

> And debugfs will be disabled in production system anyway.
> 
> Thanks,
> Michal
> 
> 
> 
> 
