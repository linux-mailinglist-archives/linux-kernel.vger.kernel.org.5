Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5977F451C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 12:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343781AbjKVLuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 06:50:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbjKVLuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 06:50:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14681197
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 03:50:03 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8798CC433C7;
        Wed, 22 Nov 2023 11:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700653802;
        bh=w3kG8h1VvYc97hgX3wwWf94uIjyQmpKJij2r7xobzXY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Oe7OloYoY6sfPuiQkjbrcOgApJs1ZDbJur8aDY1z/AW72mN5HB6EsdzkmOIfFv7zQ
         SuzmSVjhkU6bz58zDeWPVIgBzQsCAusaFrxB14pdzy+hMzenMr6Vewc7hxhn4lJVvE
         kgI32ynUoz3AEObKOCmkdkspDROCpXEdfan1f2+rhQNvFUFz1tyGZ2bq/k2bZd1fAo
         OONhbWz2z7E7+wvNMv1lVWUTvPFJITmcEZGVgu2LFcVqkp0NqjMIo9ruYmBJYBEDlL
         eVSevIxSzaWn0EAOJ2GtvCsFNDZEiMfr3/3gEA9DjH3KInqi4FwiA6tHfTke3YA+1v
         GzGDBTn8jBUEQ==
Date:   Wed, 22 Nov 2023 11:49:58 +0000
From:   Lee Jones <lee@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [RESEND PATCH v3] leds: max5970: Add support for max5970
Message-ID: <20231122114958.GJ173820@google.com>
References: <20230914114521.1491390-1-naresh.solanki@9elements.com>
 <20230920130528.GG13143@google.com>
 <CABqG17j_gCr8xw65qjn4Kh7ChdraZbLsyGOsCmFEEWG3txjE4A@mail.gmail.com>
 <20230921103156.GB3449785@google.com>
 <CABqG17ibzHiYmzCZ6ZpAa8BZhj5N+0dQ0aa1yebtCk0YYVdsFQ@mail.gmail.com>
 <CABqG17h8hxgmMA=G5hitzgjNSX_BZ2utFsMZni9evn0Nogu0GA@mail.gmail.com>
 <20231117121531.GC137434@google.com>
 <CABqG17hPnx465dRKdMdSd2s38_T6DQFn5hsx1SL0RtA+r4JFZQ@mail.gmail.com>
 <20231121153302.GD173820@google.com>
 <CABqG17hufcNS5-wLEEpZniSE2MAfEeN9Ljhs5MPGeu-2xZP+HQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABqG17hufcNS5-wLEEpZniSE2MAfEeN9Ljhs5MPGeu-2xZP+HQ@mail.gmail.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please read this:

  https://subspace.kernel.org/etiquette.html#do-not-top-post-when-replying

On Tue, 21 Nov 2023, Naresh Solanki wrote:

> Hi Lee,
> 
> Thank you for your insights. I appreciate your guidance on the matter.
> Yes will rewrite the change as below:
> 
>         regmap = dev_get_regmap(pdev->dev.parent, NULL);
>         if (!regmap)
>                 return -ENODEV;
> 
> I believe this modification aligns with your suggestion. Please let me
> know if this meets the requirements or if you have any further
> suggestions or adjustments

Please submit the next revision.

> On Tue, 21 Nov 2023 at 21:03, Lee Jones <lee@kernel.org> wrote:
> >
> > On Mon, 20 Nov 2023, Naresh Solanki wrote:
> >
> > > Hi
> > >
> > > On Fri, 17 Nov 2023 at 17:45, Lee Jones <lee@kernel.org> wrote:
> > > >
> > > > On Thu, 09 Nov 2023, Naresh Solanki wrote:
> > > >
> > > > > Hey Lee,
> > > > >
> > > > > Is there anything specific you'd suggest changing in the current
> > > > > patchset, or are we good to proceed?
> > > >
> > > > What do you mean by proceed?
> > > >
> > > > You are good to make changes and submit a subsequent version.
> > > >
> > > > Not entirely sure what you're asking.
> > >
> > > As a follow up on previous discussion regarding use of DEFER on probe
> > > if regmap isn't initialized, the implementation was based on other similar
> > > drivers & hence it was retained although its not needed due to dependencies.
> > >
> > > I'm not entirely sure to keep the regmap check or make another
> > > patch revision with regmap check removed ?
> >
> > You tell me.
> >
> > You should understand the device you're attempting to support along with
> > the code you're authoring and its subsequent implications.  If you don't
> > know what a section of code does or whether/why it's required, why did
> > you write it?
> >
> > --
> > Lee Jones [李琼斯]

-- 
Lee Jones [李琼斯]
