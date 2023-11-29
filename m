Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66AB87FDEA8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 18:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjK2Rpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 12:45:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbjK2Rpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 12:45:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D926012C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 09:45:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BDB2C433C7;
        Wed, 29 Nov 2023 17:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701279937;
        bh=KIKFPp9BUhkaU/2v9P9pMinmYm10lPKZw6CRfN0EZXc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KeBk4XygSV3H0Is1ff9twMb+Vvnsb+6+M0b40/ajSzkslItd2N+/xFslXdoPIxyPt
         7Hb2LdvV+cUc+utmT8UXA+hFN97KoFCgk5tZvcsbKxbw4f3Ybmd9Fh5857EGaBghHW
         G4T/giZZD88DarE3ZLYNYr3IuZB6XQDObaTajLo9qVz9LwZ88Qcl0b3Pf0+YwW787Q
         qXz67vU/Bfl9lhgbrgnCE0tpKC3+6jrUns53wktIfF0SYRQVkbusQdzqAYjwJap2jH
         2SUnH7BPId3PoDLHiVajSo0tsKYMlNyQoSNIj6zwfkk5bCXQl27axRVNYytWYSlUuZ
         tbw2WyRqN6QHg==
Date:   Wed, 29 Nov 2023 12:45:35 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Pavel Machek <pavel@denx.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com, alexander.deucher@amd.com,
        mario.limonciello@amd.com, zhujun2@cmss.chinamobile.com,
        skhan@linuxfoundation.org, bhelgaas@google.com
Subject: Re: [PATCH 4.14 00/53] 4.14.331-rc2 review
Message-ID: <ZWd4v-7Qnc2gde5L@sashalap>
References: <20231125163059.878143365@linuxfoundation.org>
 <ZWUBaYipygLMkfjz@duo.ucw.cz>
 <f4a7634-3d34-af29-36ca-6f3439b4ce9@linux.intel.com>
 <ZWZQCJtD7kmX9iRO@duo.ucw.cz>
 <2023112818-browse-floss-eb6f@gregkh>
 <ZWZSKgxjSRcA/qUK@duo.ucw.cz>
 <2023112844-sesame-overdrawn-5853@gregkh>
 <ZWb9vGuZck1sGBIN@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZWb9vGuZck1sGBIN@duo.ucw.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 10:00:44AM +0100, Pavel Machek wrote:
>On Tue 2023-11-28 21:10:03, Greg Kroah-Hartman wrote:
>> On Tue, Nov 28, 2023 at 09:48:42PM +0100, Pavel Machek wrote:
>> > Hi!
>> >
>> > > > > > > Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>> > > > > > >     RDMA/hfi1: Use FIELD_GET() to extract Link Width
>> > > > > >
>> > > > > > This is a good cleanup, but not a bugfix.
>> > > > > >
>> > > > > > > Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>> > > > > > >     atm: iphase: Do PCI error checks on own line
>> > > > > >
>> > > > > > Just a cleanup, not sure why it was picked for stable.
>> > > > >
>> > > > > Just an additional bit of information, there have been quite many cleanups
>> > > > > from me which have recently gotten the stable notification for some
>> > > > > mysterious reason. When I had tens of them in my inbox and for various
>> > > > > kernel versions, I immediately stopped caring to stop it from happening.
>> > > > >
>> > > > > AFAIK, I've not marked those for stable inclusion so I've no idea what
>> > > > > got them included.
>> > > >
>> > > > Fixes tag can do it. Plus, "AUTOSEL" robot does it randomly, with no
>> > > > human oversight :-(.
>> > >
>> > > the autosel bot has lots of oversight.
>> >
>> > Can you describe how that oversight works?
>>
>> There have been many papers and presentations about it, no need for me
>> to say it all here again...
>
>Give a pointer.
>
>And explain why AUTOSEL is full of cleanups, as noticed by Ilpo, me
>and others. AFAICT Sasha does not hand-check patches picked by
>AUTOSEL, simply spams the mailing lists, and hopes that maintainers
>will react. And they won't, because they don't understand the

Awesome feedback, thanks.

>implications, and simply ignore the spam. Or they will, and Sasha
>simply ignores the reply.

Incorrect, I just gotten tired of litigating this with *you*.

How about this: instead of complaining about work you get for free, try
doing it yourself and send us a list of patches that should go into the
-stable tree during the next merge window. Deal?

-- 
Thanks,
Sasha
