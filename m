Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6754980B176
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 02:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbjLIBfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 20:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjLIBfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 20:35:09 -0500
X-Greylist: delayed 496 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 08 Dec 2023 17:35:12 PST
Received: from mail-m102.netease.com (mail-m102.netease.com [154.81.10.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5888610F1;
        Fri,  8 Dec 2023 17:35:12 -0800 (PST)
DKIM-Signature: a=rsa-sha256;
        b=BwufFL80XCbds4b0EwhNO3JkhrzAg11DySk5t/d0z26Lz8b/7R1KMxF3bj8BT+vJDKHTsgAgOehypOhLxtqlQheaA/4ZjRICQ+ZPWZBmJN1cp0YMYWqo2aqLDJ6o+rJ661UMdqq951sRFc9+ln+5nuKNRUeVki9SfQZ2x6JNpe4=;
        s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
        bh=1bTFE0EmmEHjiY9PXtz3uWCZdBxCozfW+7tytPfM1i0=;
        h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.141] (unknown [58.22.7.114])
        by mail-m12779.qiye.163.com (Hmail) with ESMTPA id 817C3780197;
        Sat,  9 Dec 2023 09:26:25 +0800 (CST)
Message-ID: <bbf4d7a5-a6f5-447a-9f3e-1cd6f2acc7c9@rock-chips.com>
Date:   Sat, 9 Dec 2023 09:26:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/17] dt-bindings: iommu: rockchip: Add Rockchip
 RK3588
Content-Language: en-US
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Andy Yan <andyshrk@163.com>
Cc:     hjc@rock-chips.com, dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, sebastian.reichel@collabora.com,
        kever.yang@rock-chips.com, chris.obbard@collabora.com
References: <20231207075906.651771-1-andyshrk@163.com>
 <20231207080235.652719-1-andyshrk@163.com> <4012684.R56niFO833@diego>
From:   Andy Yan <andy.yan@rock-chips.com>
In-Reply-To: <4012684.R56niFO833@diego>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkxOHlZIHkIdQh0dTk9MSx1VEwETFh
        oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5JVUpLS1VKQl
        kG
X-HM-Tid: 0a8c4c2ed0f4b24fkuuu817c3780197
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ky46Sww*HDw9S04JFhg2Sygp
        Fg0KChFVSlVKTEtJS0NOSkNNSEtLVTMWGhIXVRoVHwJVAhoVOwkUGBBWGBMSCwhVGBQWRVlXWRIL
        WUFZTkNVSUlVTFVKSk9ZV1kIAVlBSU9DSDcG
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko:

On 12/9/23 00:29, Heiko Stübner wrote:
> Am Donnerstag, 7. Dezember 2023, 09:02:35 CET schrieb Andy Yan:
>> From: Andy Yan <andy.yan@rock-chips.com>
>>
>> Add a Rockchip RK3588 compatible
>>
>> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> 
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> 
> In the next iteration, please split this out into a separate patch and send
> it to the iommu+dt maintainers.
> 
> Supporting the iommus on rk3588 can be realized separately and the
> patch needs to go through a separate tree anyway.

Okay, I will split this patch out of this vop2 series, does this mean that
I also need to split out the iommu dt node as a separate patch from current
PATCH16 ?
> 
> 
> Thanks
> Heiko
> 
> 
> 
