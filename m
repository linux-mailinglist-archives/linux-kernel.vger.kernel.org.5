Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C18B7E523A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 09:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235478AbjKHI4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 03:56:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235460AbjKHIzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 03:55:55 -0500
Received: from 2.mo583.mail-out.ovh.net (2.mo583.mail-out.ovh.net [178.33.109.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A70D171C
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 00:55:51 -0800 (PST)
Received: from director6.ghost.mail-out.ovh.net (unknown [10.108.16.135])
        by mo583.mail-out.ovh.net (Postfix) with ESMTP id D5BC427AB7
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 07:36:15 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-k8mr2 (unknown [10.110.103.34])
        by director6.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 1CE1B1FE9A;
        Wed,  8 Nov 2023 07:36:15 +0000 (UTC)
Received: from RCM-web9.webmail.mail.ovh.net ([151.80.29.21])
        by ghost-submission-6684bf9d7b-k8mr2 with ESMTPSA
        id t3ULBm86S2VjUxQAdDy9bg
        (envelope-from <jose.pekkarinen@foxhound.fi>); Wed, 08 Nov 2023 07:36:15 +0000
MIME-Version: 1.0
Date:   Wed, 08 Nov 2023 09:36:14 +0200
From:   =?UTF-8?Q?Jos=C3=A9_Pekkarinen?= <jose.pekkarinen@foxhound.fi>
To:     Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com,
        skhan@linuxfoundation.org, airlied@gmail.com, daniel@ffwll.ch,
        qingqing.zhuo@amd.com, Jun.Lei@amd.com, alex.hung@amd.com,
        Zhongwei.Zhang@amd.com, sunran001@208suo.com, Yao.Wang1@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] drm/amd/display: remove duplicated argument
In-Reply-To: <d56cd927-49fc-cb4e-8abd-abc539e4d276@amd.com>
References: <20231029093926.137766-1-jose.pekkarinen@foxhound.fi>
 <d56cd927-49fc-cb4e-8abd-abc539e4d276@amd.com>
User-Agent: Roundcube Webmail/1.4.15
Message-ID: <e095fae915d44ccc186d5e5ee74ec119@foxhound.fi>
X-Sender: jose.pekkarinen@foxhound.fi
Organization: Foxhound Ltd.
X-Originating-IP: 185.220.101.156
X-Webmail-UserID: jose.pekkarinen@foxhound.fi
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 4210584177794590374
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedruddukedguddtjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeggfffhvfevufgjfhgfkfigohhitgfgsehtkehjtddtreejnecuhfhrohhmpeflohhsrocurfgvkhhkrghrihhnvghnuceojhhoshgvrdhpvghkkhgrrhhinhgvnhesfhhogihhohhunhgurdhfiheqnecuggftrfgrthhtvghrnhepkefhgeduudefgedvleegtddvffeghedvtdekveekjeevvdegiedtfeelhedtiedtnecukfhppeduvdejrddtrddtrddupddukeehrddvvddtrddutddurdduheeipdduhedurdektddrvdelrddvudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehjohhsvgdrphgvkhhkrghrihhnvghnsehfohighhhouhhnugdrfhhiqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheekfedpmhhouggvpehsmhhtphhouhht
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-30 15:54, Aurabindo Pillai wrote:
> On 10/29/2023 5:39 AM, José Pekkarinen wrote:
>> Spotted by coccicheck, there is a redundant check for
>> v->SourcePixelFormat[k] != dm_444_16. This patch will
>> remove it. The corresponding output follows.
>> 
>> drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c:5130:86-122: 
>> duplicated argument to && or ||
>> 
>> Signed-off-by: José Pekkarinen <jose.pekkarinen@foxhound.fi>
>> ---
>>   drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c | 2 
>> +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git 
>> a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c 
>> b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
>> index ad741a723c0e..3686f1e7de3a 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
>> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
>> @@ -5128,7 +5128,7 @@ void 
>> dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib 
>> *mode_l
>>   			ViewportExceedsSurface = true;
>>     		if (v->SourcePixelFormat[k] != dm_444_64 && 
>> v->SourcePixelFormat[k] != dm_444_32 && v->SourcePixelFormat[k] != 
>> dm_444_16
>> -				&& v->SourcePixelFormat[k] != dm_444_16 && 
>> v->SourcePixelFormat[k] != dm_444_8 && v->SourcePixelFormat[k] != 
>> dm_rgbe) {
>> +				&& v->SourcePixelFormat[k] != dm_444_8 && v->SourcePixelFormat[k] 
>> != dm_rgbe) {
>>   			if (v->ViewportWidthChroma[k] > v->SurfaceWidthC[k] || 
>> v->ViewportHeightChroma[k] > v->SurfaceHeightC[k]) {
>>   				ViewportExceedsSurface = true;
>>   			}
> 
> Thanks for catching.
> 
> Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>

     Sorry to bring this up, I just wanted to check whether this
has been applied in the following pulls or not.

     Thanks!

     José.
