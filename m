Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33B67F3262
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 16:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234613AbjKUPdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 10:33:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234564AbjKUPdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 10:33:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B98810C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 07:33:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C23E7C433C8;
        Tue, 21 Nov 2023 15:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700580787;
        bh=XGyoaHeSQMXUdK/oz16TGCV+JeLwZhhXo+pE++5TlmU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sd5xMDKXxYhjEWideaWWRGi9f7ZQbdnzpH+ctwSw1NEOw9YDnWCeqAOHbnBCkAhWQ
         wsmzPhVLwfI29xgyO4usvTjySzF3XAt4uuTeJ51lCccwxZ6Ea/ec9VeA0jJoUdJ5Dq
         FDB5dXp28cKPIz/YiWcksEjHe/yoN+UETo0oDnBQjE9NVuZW7i7yrJjoKgEbChM8qn
         ZOriZ3sTUDjX/fMDyd6/E8m2W4P4cKj4hE8lCxHGaq0x5zLdmG6vTVc3GraMCwA9Lo
         4pWkhU5VtycrWX7avJ9ZXN3+xpFz2EnuVkd5zLAMJBgk+YpRlwiML6B2JkUkYBOpkD
         +YP3y1J6MyMaQ==
Date:   Tue, 21 Nov 2023 15:33:02 +0000
From:   Lee Jones <lee@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [RESEND PATCH v3] leds: max5970: Add support for max5970
Message-ID: <20231121153302.GD173820@google.com>
References: <20230914114521.1491390-1-naresh.solanki@9elements.com>
 <20230920130528.GG13143@google.com>
 <CABqG17j_gCr8xw65qjn4Kh7ChdraZbLsyGOsCmFEEWG3txjE4A@mail.gmail.com>
 <20230921103156.GB3449785@google.com>
 <CABqG17ibzHiYmzCZ6ZpAa8BZhj5N+0dQ0aa1yebtCk0YYVdsFQ@mail.gmail.com>
 <CABqG17h8hxgmMA=G5hitzgjNSX_BZ2utFsMZni9evn0Nogu0GA@mail.gmail.com>
 <20231117121531.GC137434@google.com>
 <CABqG17hPnx465dRKdMdSd2s38_T6DQFn5hsx1SL0RtA+r4JFZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABqG17hPnx465dRKdMdSd2s38_T6DQFn5hsx1SL0RtA+r4JFZQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2023, Naresh Solanki wrote:

> Hi
> 
> On Fri, 17 Nov 2023 at 17:45, Lee Jones <lee@kernel.org> wrote:
> >
> > On Thu, 09 Nov 2023, Naresh Solanki wrote:
> >
> > > Hey Lee,
> > >
> > > Is there anything specific you'd suggest changing in the current
> > > patchset, or are we good to proceed?
> >
> > What do you mean by proceed?
> >
> > You are good to make changes and submit a subsequent version.
> >
> > Not entirely sure what you're asking.
> 
> As a follow up on previous discussion regarding use of DEFER on probe
> if regmap isn't initialized, the implementation was based on other similar
> drivers & hence it was retained although its not needed due to dependencies.
> 
> I'm not entirely sure to keep the regmap check or make another
> patch revision with regmap check removed ?

You tell me.

You should understand the device you're attempting to support along with
the code you're authoring and its subsequent implications.  If you don't
know what a section of code does or whether/why it's required, why did
you write it?

-- 
Lee Jones [李琼斯]
