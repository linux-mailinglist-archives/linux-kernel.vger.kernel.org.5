Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA538806DE1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377516AbjLFL2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 06:28:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377437AbjLFL2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:28:00 -0500
Received: from mail-m49204.qiye.163.com (mail-m49204.qiye.163.com [45.254.49.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F5ED3;
        Wed,  6 Dec 2023 03:28:04 -0800 (PST)
DKIM-Signature: a=rsa-sha256;
        b=CGNhd4sjVn5tsHiRRxZ+t3cUlpsvFLcZiVcSSq+FAgX0kIHfaDkoFGroR1A9sALxte2BSIjPb01MqW/ghoKP/q2t2kg5dVxhU4wvHT3dsdr/j0//cydNaZzdKQEgrgL3zl7HqGgdjUL8YLlSZAUurhwuceBCx0aVcGSIw1MTPO4=;
        c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
        bh=mIp43tx+cz3waI2qLXLmWvwYJEbJny5dp/W8y+Cp4Dk=;
        h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.141] (unknown [58.22.7.114])
        by mail-m12779.qiye.163.com (Hmail) with ESMTPA id B6404780300;
        Wed,  6 Dec 2023 19:27:31 +0800 (CST)
Message-ID: <8140e2f4-2081-4492-af17-ce742eef4404@rock-chips.com>
Date:   Wed, 6 Dec 2023 19:27:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/14] drm/rockchip: vop2: Add debugfs support
Content-Language: en-US
To:     Sascha Hauer <sha@pengutronix.de>
Cc:     Andy Yan <andyshrk@163.com>, heiko@sntech.de, hjc@rock-chips.com,
        dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, sebastian.reichel@collabora.com,
        kever.yang@rock-chips.com, chris.obbard@collabora.com
References: <20231130122001.12474-1-andyshrk@163.com>
 <20231130122449.13432-1-andyshrk@163.com>
 <20231205091541.GV1057032@pengutronix.de>
 <593f1092-3f5b-42ab-bc6e-dbd0fc8fb8ba@rock-chips.com>
 <20231206112053.GA1318922@pengutronix.de>
From:   Andy Yan <andy.yan@rock-chips.com>
In-Reply-To: <20231206112053.GA1318922@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0hOSVZPGEgdHUNMQkkfHxhVEwETFh
        oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5JVUpLS1VKQl
        kG
X-HM-Tid: 0a8c3ee210d1b24fkuuub6404780300
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MTY6Cxw5ODwrElEyPQ8yPBES
        KiMwCjVVSlVKTEtKQ01JS05JTk9OVTMWGhIXVRoVHwJVAhoVOwkUGBBWGBMSCwhVGBQWRVlXWRIL
        WUFZTkNVSUlVTFVKSk9ZV1kIAVlBSEpMTjcG
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sascha:

On 12/6/23 19:20, Sascha Hauer wrote:
> On Wed, Dec 06, 2023 at 06:20:58PM +0800, Andy Yan wrote:
>> Hi Sascha:
>>
>>>> +	unsigned int n = vop2->data->regs_dump_size;
>>>
>>> 'n' is used only once, it might be clearer just to use the value where
>>> needed and drop the extra variable.
>>
>> Okay, will do.
>>>
>>>> +	unsigned int i;
>>>> +
>>>> +	drm_modeset_lock_all(drm_dev);
>>>> +
>>>> +	if (vop2->enable_count) {
>>>> +		for (i = 0; i < n; i++) {
>>>> +			dump = &vop2->data->regs_dump[i];
>>>> +			vop2_regs_print(vop2, s, dump, false);
>>>> +		}
>>>> +	} else {
>>>> +		seq_printf(s, "VOP disabled:\n");
>>>
>>> There's nothing following after the ':', right? Then this should be
>>> "VOP: disabled\n" or without the colon at all.
>>
>> the colon will be droped in next versin.
>>
>>>
>>>> +	}
>>>> +	drm_modeset_unlock_all(drm_dev);
>>>
>>> This code is repeated in vop2_active_regs_show() below. Maybe factor
>>> this out to a common function?
>>>
>>
>>
>> Do you mean all the code between drm_modeset_lock_all and drm_modeset_unlock_all ?
> 
> Including drm_modeset_lock_all() and drm_modeset_unlock_all(), yes.
> 

Okay, will try in v4.


> Sascha
> 
