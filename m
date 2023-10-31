Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC4607DCCF6
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 13:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344261AbjJaMcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 08:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344246AbjJaMcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 08:32:15 -0400
Received: from 13.mo561.mail-out.ovh.net (13.mo561.mail-out.ovh.net [188.165.33.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59365A1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 05:32:07 -0700 (PDT)
Received: from director6.ghost.mail-out.ovh.net (unknown [10.109.156.142])
        by mo561.mail-out.ovh.net (Postfix) with ESMTP id 428A427CF8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 12:32:05 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-wdl7v (unknown [10.110.103.4])
        by director6.ghost.mail-out.ovh.net (Postfix) with ESMTPS id C15581FE98;
        Tue, 31 Oct 2023 12:32:04 +0000 (UTC)
Received: from RCM-web9.webmail.mail.ovh.net ([151.80.29.21])
        by ghost-submission-6684bf9d7b-wdl7v with ESMTPSA
        id WQlLKsTzQGWB1AAAnh/Cbw
        (envelope-from <jose.pekkarinen@foxhound.fi>); Tue, 31 Oct 2023 12:32:04 +0000
MIME-Version: 1.0
Date:   Tue, 31 Oct 2023 14:32:02 +0200
From:   =?UTF-8?Q?Jos=C3=A9_Pekkarinen?= <jose.pekkarinen@foxhound.fi>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, skhan@linuxfoundation.org,
        dillon.varone@amd.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        dri-devel@lists.freedesktop.org, Xinhui.Pan@amd.com,
        linux-kernel@vger.kernel.org, samson.tam@amd.com,
        SyedSaaem.Rizvi@amd.com, aurabindo.pillai@amd.com,
        stable@vger.kernel.org, daniel@ffwll.ch, george.shen@amd.com,
        alexander.deucher@amd.com, Jun.Lei@amd.com, airlied@gmail.com,
        christian.koenig@amd.com
Subject: Re: [PATCH] drm/amd/display: remove redundant check
In-Reply-To: <2023103141-clear-scale-897a@gregkh>
References: <20231030171748.35482-1-jose.pekkarinen@foxhound.fi>
 <2023103115-obstruct-smudgy-6cc6@gregkh>
 <3ab58c1e48447798d7525e7d2f42f1a2@foxhound.fi>
 <2023103141-clear-scale-897a@gregkh>
User-Agent: Roundcube Webmail/1.4.15
Message-ID: <1175edcbdf0d0a55d39a87f220259528@foxhound.fi>
X-Sender: jose.pekkarinen@foxhound.fi
Organization: Foxhound Ltd.
X-Originating-IP: 213.216.208.215
X-Webmail-UserID: jose.pekkarinen@foxhound.fi
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 17565445922061264391
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedruddtvddggedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggffhffvvefujghffgfkgihoihgtgfesthekjhdttderjeenucfhrhhomheplfhoshorucfrvghkkhgrrhhinhgvnhcuoehjohhsvgdrphgvkhhkrghrihhnvghnsehfohighhhouhhnugdrfhhiqeenucggtffrrghtthgvrhhnpeeihfevgfduveejjefgffehkeduhfejteegieejheetgedvleetlefguddukeefleenucffohhmrghinhepfhhrvggvuggvshhkthhophdrohhrghdpkhgvrhhnvghlrdhorhhgnecukfhppeduvdejrddtrddtrddupddvudefrddvudeirddvtdekrddvudehpdduhedurdektddrvdelrddvudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehjohhsvgdrphgvkhhkrghrihhnvghnsehfohighhhouhhnugdrfhhiqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheeiuddpmhhouggvpehsmhhtphhouhht
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-31 14:20, Greg KH wrote:
> On Tue, Oct 31, 2023 at 01:42:17PM +0200, José Pekkarinen wrote:
>> On 2023-10-31 07:48, Greg KH wrote:
>> > On Mon, Oct 30, 2023 at 07:17:48PM +0200, José Pekkarinen wrote:
>> > > This patch addresses the following warning spotted by
>> > > using coccinelle where the case checked does the same
>> > > than the else case.
>> > >
>> > > drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c:4664:8-10:
>> > > WARNING: possible condition with no effect (if == else)
>> > >
>> > > Fixes: 974ce181 ("drm/amd/display: Add check for PState change in
>> > > DCN32")
>> > >
>> > > Cc: stable@vger.kernel.org
>> >
>> > Why is this relevant for stable?
>> 
>>     Hi,
>> 
>>     I was asked to send it for stable because this code
>> looks different in amd-staging-drm-next, see here.
>> 
>> https://gitlab.freedesktop.org/agd5f/linux/-/blob/amd-staging-drm-next/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c#L4661
> 
> I don't know what I am looking at, sorry.
> 
>>     Feel free to let me know if this is wrong, or if I
>> need to review some other guidelines I may have missed.
> 
> Please see the list of rules for stable patches:
>     
> https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> 
> Does "remove code that does nothing" fit here?

     Yep, it is a trivial fix which compilers should be able
to optimize, so no real benefit to the user. Sorry Greg!

     José.
