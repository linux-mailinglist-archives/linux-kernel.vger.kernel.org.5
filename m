Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194FC76051C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 04:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjGYCN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 22:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGYCN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 22:13:56 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1F8C1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 19:13:55 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R90qW3D6yzNmZF;
        Tue, 25 Jul 2023 10:10:31 +0800 (CST)
Received: from [10.174.179.215] (10.174.179.215) by
 canpemm500007.china.huawei.com (7.192.104.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 25 Jul 2023 10:13:53 +0800
Subject: Re: [PATCH -next] drm/fb-helper: Remove unused inline function
 drm_fb_helper_defio_init()
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <airlied@gmail.com>, <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20230721120902.32920-1-yuehaibing@huawei.com>
 <fb90dd22-b908-d65a-5272-c2f94aa0113d@suse.de>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <38537dfb-34eb-eed9-2f96-37479dbc8ea6@huawei.com>
Date:   Tue, 25 Jul 2023 10:13:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <fb90dd22-b908-d65a-5272-c2f94aa0113d@suse.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/24 22:27, Thomas Zimmermann wrote:
> Hi
> 
> Am 21.07.23 um 14:09 schrieb YueHaibing:
>> Since commit 8e86dee02253 ("drm/fb-helper: Remove drm_fb_helper_defio_init() and update docs")
>> this inline helper not used anymore.
>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> 
> You need to add a Fixes: tag here with the commit you mentioned in the description.
Ok, will send v2.
> 
> With this fixed, you can also add
> 
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> 
> Best regards
> Thomas
> 
>> ---
>>   include/drm/drm_fb_helper.h | 5 -----
>>   1 file changed, 5 deletions(-)
>>
>> diff --git a/include/drm/drm_fb_helper.h b/include/drm/drm_fb_helper.h
>> index 4863b0f8299e..375737fd6c36 100644
>> --- a/include/drm/drm_fb_helper.h
>> +++ b/include/drm/drm_fb_helper.h
>> @@ -368,11 +368,6 @@ static inline void drm_fb_helper_deferred_io(struct fb_info *info,
>>   {
>>   }
>>   -static inline int drm_fb_helper_defio_init(struct drm_fb_helper *fb_helper)
>> -{
>> -    return -ENODEV;
>> -}
>> -
>>   static inline void drm_fb_helper_set_suspend(struct drm_fb_helper *fb_helper,
>>                            bool suspend)
>>   {
> 
