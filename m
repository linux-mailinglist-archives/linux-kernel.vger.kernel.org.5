Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60CA77EECB0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 08:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjKQHdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 02:33:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjKQHdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 02:33:42 -0500
X-Greylist: delayed 885 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 16 Nov 2023 23:33:37 PST
Received: from mail-m17244.xmail.ntesmail.com (mail-m17244.xmail.ntesmail.com [45.195.17.244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B026A109
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 23:33:37 -0800 (PST)
DKIM-Signature: a=rsa-sha256;
        b=Nu292DN2E6gfuHIj233Rh8Mdr+z5CJlMWHO8NWBfbI4ao9MCcWWM5VLf2BnX2BVH9c92Fx09CxiX4W8gRKqXwKDxiAREUGNt1I7x/DpyeAWDV6rYxLJjP9k4eRtbglzyPG0EIa1YuA5UhPKtrAj8LITcaYyVn1FdDw0padxAVRs=;
        c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
        bh=at1ne/rWq7oflyNTr5NsoIEOTljtkrgIcuWxm4pqXDc=;
        h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.141] (unknown [58.22.7.114])
        by mail-m12779.qiye.163.com (Hmail) with ESMTPA id 6C5477804C6;
        Fri, 17 Nov 2023 15:06:35 +0800 (CST)
Message-ID: <3e011d52-017e-4360-86b4-781535ef61ad@rock-chips.com>
Date:   Fri, 17 Nov 2023 15:06:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11] drm/rockchip: vop2: Add support for rk3588
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>, Andy Yan <andyshrk@163.com>,
        heiko@sntech.de, hjc@rock-chips.com,
        dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, kever.yang@rock-chips.com,
        chris.obbard@collabora.com
References: <20231114112534.1770731-1-andyshrk@163.com>
 <20231114112855.1771372-1-andyshrk@163.com>
 <20231115090823.GY3359458@pengutronix.de>
 <8f2ebc81-51c5-44d5-b27b-633a6cc85d0d@rock-chips.com>
 <20231116134757.zu7axb6cvriqjm6y@mercury.elektranox.org>
From:   Andy Yan <andy.yan@rock-chips.com>
In-Reply-To: <20231116134757.zu7axb6cvriqjm6y@mercury.elektranox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR5DGFYZTU8fSEIfSk5LHh1VEwETFh
        oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
        kG
X-HM-Tid: 0a8bdc1a5771b24fkuuu6c5477804c6
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NxA6Dgw6KDw5MDhKPzJKLA0o
        DyIwFCFVSlVKTEtLSUtPTEJNSU5PVTMWGhIXVRoVHwJVAhoVOwkUGBBWGBMSCwhVGBQWRVlXWRIL
        WUFZTkNVSUlVTFVKSk9ZV1kIAVlBSE5ISzcG
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian:

On 11/16/23 21:47, Sebastian Reichel wrote:
> Hi,
>
> On Thu, Nov 16, 2023 at 06:39:40PM +0800, Andy Yan wrote:
>>>>    	vop2->sys_grf = syscon_regmap_lookup_by_phandle(dev->of_node, "rockchip,grf");
>>> This already lacks an error check, shame on me...
>>>
>>>> +	vop2->vop_grf = syscon_regmap_lookup_by_phandle(dev->of_node, "rockchip,vop-grf");
>>>> +	vop2->vo1_grf = syscon_regmap_lookup_by_phandle(dev->of_node, "rockchip,vo1-grf");
>>>> +	vop2->sys_pmu = syscon_regmap_lookup_by_phandle(dev->of_node, "rockchip,pmu");
>>> ... but please don't duplicate that.
>> It a little difficult to find a proper way to do the check, as not every soc need all these phandles.
>>
>> Do i need check it per soc?
> I suggest adding a u32 flags to struct vop2_data and then have
> something like this:
>
> if (vop2_data->flags & VOP2_HAS_VOP_GRF) {
>      vop2->vop_grf = syscon_regmap_lookup_by_phandle(dev->of_node, "rockchip,vop-grf");
>      if (IS_ERR(vop2->vop_grf))
>          return dev_err_probe(dev, PTR_ERR(vop2->vop_grf) "cannot get vop-grf");
> }
>
> if (vop2_data->flags & VOP2_HAS_VO1_GRF) {
>      vop2->vo1_grf = syscon_regmap_lookup_by_phandle(dev->of_node, "rockchip,vo1-grf");
>      if (IS_ERR(vop2->vo1_grf))
>          return dev_err_probe(dev, PTR_ERR(vop2->vo1_grf) "cannot get vo1-grf");
> }
>
> ...


I can do it like this if Sascha is also happy with it.

>
> Greetings,
>
> -- Sebastian
