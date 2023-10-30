Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 025DC7DBDC5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 17:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbjJ3Q0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 12:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjJ3Q0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 12:26:41 -0400
Received: from 3.mo576.mail-out.ovh.net (3.mo576.mail-out.ovh.net [188.165.52.203])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD71B9E
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 09:26:37 -0700 (PDT)
Received: from director7.ghost.mail-out.ovh.net (unknown [10.108.20.172])
        by mo576.mail-out.ovh.net (Postfix) with ESMTP id AFB4223A57
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 16:26:35 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-7hln7 (unknown [10.110.208.67])
        by director7.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 16CAE1FE61;
        Mon, 30 Oct 2023 16:26:35 +0000 (UTC)
Received: from RCM-web3.webmail.mail.ovh.net ([178.33.236.78])
        by ghost-submission-6684bf9d7b-7hln7 with ESMTPSA
        id zBVnAzvZP2VUTQEAW38/SQ
        (envelope-from <jose.pekkarinen@foxhound.fi>); Mon, 30 Oct 2023 16:26:35 +0000
MIME-Version: 1.0
Date:   Mon, 30 Oct 2023 18:26:34 +0200
From:   =?UTF-8?Q?Jos=C3=A9_Pekkarinen?= <jose.pekkarinen@foxhound.fi>
To:     Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, skhan@linuxfoundation.org,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        dillon.varone@amd.com, Jun.Lei@amd.com, george.shen@amd.com,
        samson.tam@amd.com, SyedSaaem.Rizvi@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] drm/amd/display: remove redundant check
In-Reply-To: <ce1b69e1-fa38-2e12-1ad5-375ac244af42@amd.com>
References: <20231029124404.16159-1-jose.pekkarinen@foxhound.fi>
 <ce1b69e1-fa38-2e12-1ad5-375ac244af42@amd.com>
User-Agent: Roundcube Webmail/1.4.15
Message-ID: <3c228e4f69c01dddd4743bdb68845566@foxhound.fi>
X-Sender: jose.pekkarinen@foxhound.fi
Organization: Foxhound Ltd.
X-Originating-IP: 162.247.74.74
X-Webmail-UserID: jose.pekkarinen@foxhound.fi
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 15653104930003855014
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedruddttddgkeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggffhffvvefujghffgfkgihoihgtgfesthekjhdttderjeenucfhrhhomheplfhoshorucfrvghkkhgrrhhinhgvnhcuoehjohhsvgdrphgvkhhkrghrihhnvghnsehfohighhhouhhnugdrfhhiqeenucggtffrrghtthgvrhhnpeekhfeguddufeegvdelgedtvdffgeehvddtkeevkeejvedvgeeitdefleehtdeitdenucfkphepuddvjedrtddrtddruddpudeivddrvdegjedrjeegrdejgedpudejkedrfeefrddvfeeirdejkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehjohhsvgdrphgvkhhkrghrihhnvghnsehfohighhhouhhnugdrfhhiqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheejiedpmhhouggvpehsmhhtphhouhht
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-30 15:52, Aurabindo Pillai wrote:
> On 10/29/2023 8:44 AM, José Pekkarinen wrote:
>> This patch addresses the following warning spotted by
>> using coccinelle where the case checked does the same
>> than the else case.
>> 
>> drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c:4664:8-10: 
>> WARNING: possible condition with no effect (if == else)
>> 
>> Signed-off-by: José Pekkarinen <jose.pekkarinen@foxhound.fi>
>> ---
>>   .../drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c   | 4 
>> ----
>>   1 file changed, 4 deletions(-)
>> 
>> diff --git 
>> a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c 
>> b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
>> index ecea008f19d3..d940dfa5ae43 100644
>> --- 
>> a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
>> +++ 
>> b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
>> @@ -4661,10 +4661,6 @@ void dml32_CalculateMinAndMaxPrefetchMode(
>>   	} else if (AllowForPStateChangeOrStutterInVBlankFinal == 
>> dm_prefetch_support_uclk_fclk_and_stutter) {
>>   		*MinPrefetchMode = 0;
>>   		*MaxPrefetchMode = 0;
>> -	} else if (AllowForPStateChangeOrStutterInVBlankFinal ==
>> -			dm_prefetch_support_uclk_fclk_and_stutter_if_possible) {
>> -		*MinPrefetchMode = 0;
>> -		*MaxPrefetchMode = 3;
>>   	} else {
>>   		*MinPrefetchMode = 0;
>>   		*MaxPrefetchMode = 3;
> 
> What tree did you use to generate the patch? On amd-staging-drm-next,
> MaxPrefetchMode is 0 for the second last branch, which is the correct
> one, so this patch isnt needed.

     I'm using the stable tree, sorry, if it is out of
date just ignore it then.

     Thanks!

     José.
