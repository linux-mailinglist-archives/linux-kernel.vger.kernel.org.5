Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC137E7FEC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjKJSBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234815AbjKJSAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:00:12 -0500
X-Greylist: delayed 978 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 10 Nov 2023 03:43:45 PST
Received: from 1.mo575.mail-out.ovh.net (1.mo575.mail-out.ovh.net [46.105.41.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B5531198
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 03:43:45 -0800 (PST)
Received: from director3.ghost.mail-out.ovh.net (unknown [10.108.20.216])
        by mo575.mail-out.ovh.net (Postfix) with ESMTP id F3C092CA6E
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 11:27:24 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-2pfnd (unknown [10.110.103.155])
        by director3.ghost.mail-out.ovh.net (Postfix) with ESMTPS id F29D91FE99;
        Fri, 10 Nov 2023 11:27:23 +0000 (UTC)
Received: from RCM-web4.webmail.mail.ovh.net ([176.31.235.81])
        by ghost-submission-6684bf9d7b-2pfnd with ESMTPSA
        id SggZOpsTTmU0owAAFXiS3w
        (envelope-from <jose.pekkarinen@foxhound.fi>); Fri, 10 Nov 2023 11:27:23 +0000
MIME-Version: 1.0
Date:   Fri, 10 Nov 2023 13:27:23 +0200
From:   =?UTF-8?Q?Jos=C3=A9_Pekkarinen?= <jose.pekkarinen@foxhound.fi>
To:     "Lazar, Lijo" <lijo.lazar@amd.com>
Cc:     evan.quan@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com,
        skhan@linuxfoundation.org, jdelvare@suse.com,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, daniel@ffwll.ch,
        airlied@gmail.com, linux@roeck-us.net,
        linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] drm/amd/pm: make power values signed
In-Reply-To: <6e26746d-5e4a-cc9e-fe5f-20187313fbfe@amd.com>
References: <20231109084110.4056-1-jose.pekkarinen@foxhound.fi>
 <6e26746d-5e4a-cc9e-fe5f-20187313fbfe@amd.com>
User-Agent: Roundcube Webmail/1.4.15
Message-ID: <334c8e5e3fcc99752d28ecf0937c53dd@foxhound.fi>
X-Sender: jose.pekkarinen@foxhound.fi
Organization: Foxhound Ltd.
X-Originating-IP: 185.220.102.4
X-Webmail-UserID: jose.pekkarinen@foxhound.fi
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 1413004385302324929
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedruddvfedgvdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggffhffvvefujghffgfkgihoihgtgfesthekjhdttderjeenucfhrhhomheplfhoshorucfrvghkkhgrrhhinhgvnhcuoehjohhsvgdrphgvkhhkrghrihhnvghnsehfohighhhouhhnugdrfhhiqeenucggtffrrghtthgvrhhnpeetveejleefudduueehfedvjeekteevhefhtdffkedvffegieejgeettdeuueeiteenucffohhmrghinhepfhhrvggvuggvshhkthhophdrohhrghenucfkphepuddvjedrtddrtddruddpudekhedrvddvtddruddtvddrgedpudejiedrfedurddvfeehrdekudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehjohhsvgdrphgvkhhkrghrihhnvghnsehfohighhhouhhnugdrfhhiqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheejhedpmhhouggvpehsmhhtphhouhht
X-Spam-Status: No, score=2.8 required=5.0 tests=BAYES_00,
        RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-10 10:25, Lazar, Lijo wrote:
> On 11/9/2023 2:11 PM, José Pekkarinen wrote:
>> The following patch will convert the power values returned by
>> amdgpu_hwmon_get_power to signed, fixing the following warnings 
>> reported
>> by coccinelle:
>> 
>> drivers/gpu/drm/amd/pm/amdgpu_pm.c:2801:5-8: WARNING: Unsigned 
>> expression compared with zero: val < 0
>> drivers/gpu/drm/amd/pm/amdgpu_pm.c:2814:5-8: WARNING: Unsigned 
>> expression compared with zero: val < 0
>> 
>> Signed-off-by: José Pekkarinen <jose.pekkarinen@foxhound.fi>
>> ---
>>   drivers/gpu/drm/amd/pm/amdgpu_pm.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c 
>> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> index e7bb1d324084..913ff62d5d5e 100644
>> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> @@ -2795,7 +2795,7 @@ static ssize_t 
>> amdgpu_hwmon_show_power_avg(struct device *dev,
>>   					   struct device_attribute *attr,
>>   					   char *buf)
>>   {
>> -	unsigned int val;
>> +	int val;
> 
> Hi Alex,
> 
> It's a different code in drm-next.
> 
> https://gitlab.freedesktop.org/agd5f/linux/-/blob/amd-staging-drm-next/drivers/gpu/drm/amd/pm/amdgpu_pm.c#L2936

     I checked it, and ssize_t also removes the warning,
so you can stay with whatever is in the amd-staging-drm-next
tree and ignore this.

     Thanks!

     José.
