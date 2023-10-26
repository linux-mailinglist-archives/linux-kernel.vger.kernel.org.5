Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85CB87D7AEB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 04:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjJZCds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 22:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbjJZCdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 22:33:46 -0400
X-Greylist: delayed 444 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 25 Oct 2023 19:33:41 PDT
Received: from mail-m6038.netease.com (mail-m6038.netease.com [210.79.60.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A7512F;
        Wed, 25 Oct 2023 19:33:41 -0700 (PDT)
DKIM-Signature: a=rsa-sha256;
        b=LDFgxL3uu9G/FyUl/0miNPqflqyM0ZlDnNuHW7JJ0KHDYC56vzg6bPuzmZlrzPRdyZGb2FQVAmaXpKstunFzb3+bh2gRjmwubk0huhElTpyhB0WaZYoEnrMrw6M4ujLfmoxlLX9RVnx8YnNdoecscNW+uH2FE6yy2iwBNgexfsk=;
        c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
        bh=IjUvs9coTf3rg5T0PqaL4rQY2t3YG56G7QS6+2h0y0c=;
        h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.49] (unknown [58.22.7.114])
        by mail-m11877.qiye.163.com (Hmail) with ESMTPA id 4EB68400227;
        Thu, 26 Oct 2023 10:25:44 +0800 (CST)
Message-ID: <ac6f04ef-97b1-3dd9-a086-772a10f0a66b@rock-chips.com>
Date:   Thu, 26 Oct 2023 10:25:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 0/4] rockchip: add GATE_LINK
To:     Stephen Boyd <sboyd@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     conor+dt@kernel.org, heiko@sntech.de, kever.yang@rock-chips.com,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        huangtao@rock-chips.com, andy.yan@rock-chips.com
References: <20231018070144.8512-1-zhangqing@rock-chips.com>
 <b0af9e04bafb07e8a73e8f242a4ff556.sboyd@kernel.org>
 <20231025194849.4esjw4w2trgalp55@mercury.elektranox.org>
 <dc96dc36c6df1d3bfa3006298e353f39.sboyd@kernel.org>
From:   zhangqing <zhangqing@rock-chips.com>
In-Reply-To: <dc96dc36c6df1d3bfa3006298e353f39.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUNKQlZDHR1CTkMdQ0sYTk1VEwETFh
        oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
        kG
X-HM-Tid: 0a8b69cd4f412eb3kusn4eb68400227
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NCo6Aww6NDw5AzEpK0IXVk0*
        Kg4aCy9VSlVKTUJDSUNMSk9OSEJIVTMWGhIXVQETGhUcChIVHDsJFBgQVhgTEgsIVRgUFkVZV1kS
        C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUxLTE03Bg++
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/10/26 5:40, Stephen Boyd 写道:
> Quoting Sebastian Reichel (2023-10-25 12:48:49)
>> Hello Stephen,
>>
>> On Mon, Oct 23, 2023 at 06:47:17PM -0700, Stephen Boyd wrote:
>>> Quoting Elaine Zhang (2023-10-18 00:01:40)
>>>> Recent Rockchip SoCs have a new hardware block called Native Interface
>>>> Unit (NIU), which gates clocks to devices behind them. These effectively
>>>> need two parent clocks.
>>>> Use GATE_LINK to handle this.
>>> Why can't pm clks be used here? The qcom clk driver has been doing that
>>> for some time now.
>>>
>>>   $ git grep pm_clk_add -- drivers/clk/qcom/
>> Maybe I'm mistaken, but as far as I can tell this is adding the
>> dependency on controller level and only works because Qualcomm
>> has multiple separate clock controllers. In the Rockchip design
>> there is only one platform device.
>>
>> Note, that the original downstream code from Rockchip actually used
>> pm_clk infrastructure by moving these clocks to separate platform
>> devices. I changed this when upstreaming the code, since that leaks
>> into DT and from DT point of view there should be only one clock
>> controller.
>>
> Why can't the rockchip driver bind to a single device node and make
> sub-devices for each clk domain and register clks for those? Maybe it
> can use the auxiliary driver infrastructure to do that?

Option 1:

Use the current patch to adapt the GATE_LINK type upstream.

The real function of GATE_LINK is implemented。

Just to improve and adapt the existing features on upstream.


Option 2:

What we use on our internal branches are:

drivers/clk/rockchip/clk-link.c

static int rockchip_clk_link_probe(struct platform_device *pdev)
{
     struct rockchip_link_clk *priv;
     struct device_node *node = pdev->dev.of_node;
     const struct of_device_id *match;
     const char *clk_name;
     const struct rockchip_link_info *link_info;
     int ret;

     match = of_match_node(rockchip_clk_link_of_match, node);
     if (!match)
         return -ENXIO;

     priv = devm_kzalloc(&pdev->dev, sizeof(struct rockchip_link_clk),
                 GFP_KERNEL);
     if (!priv)
         return -ENOMEM;

     priv->link = match->data;

     spin_lock_init(&priv->lock);
     platform_set_drvdata(pdev, priv);

     priv->base = of_iomap(node, 0);
     if (IS_ERR(priv->base))
         return PTR_ERR(priv->base);

     if (of_property_read_string(node, "clock-output-names", &clk_name))
         priv->name = node->name;
     else
         priv->name = clk_name;

     link_info = rockchip_get_link_infos(priv->link, priv->name);
     priv->shift = link_info->shift;
     priv->pname = link_info->pname;

     pm_runtime_enable(&pdev->dev);
     ret = pm_clk_create(&pdev->dev);
     if (ret)
         goto disable_pm_runtime;

     ret = pm_clk_add(&pdev->dev, "link");

     if (ret)
         goto destroy_pm_clk;

     ret = register_clocks(priv, &pdev->dev);
     if (ret)
         goto destroy_pm_clk;

     return 0;

destroy_pm_clk:
     pm_clk_destroy(&pdev->dev);
disable_pm_runtime:
     pm_runtime_disable(&pdev->dev);

     return ret;
}


Both of these methods are OK. Whichever one Upstream prefers, I can 
submit it as required.

-- 
张晴
瑞芯微电子股份有限公司
Rockchip Electronics Co.,Ltd
地址：福建省福州市铜盘路软件大道89号软件园A区21号楼
Add:No.21 Building, A District, No.89 Software Boulevard Fuzhou, Fujian 350003, P.R.China
Tel:+86-0591-83991906-8601
邮编：350003
E-mail:elaine.zhang@rock-chips.com
****************************************************************************
保密提示：本邮件及其附件含有机密信息，仅发送给本邮件所指特定收件人。若非该特定收件人，请勿复制、使用或披露本邮件的任何内容。若误收本邮件，请从系统中永久性删除本邮件及所有附件，并以回复邮件或其他方式即刻告知发件人。福州瑞芯微电子有限公司拥有本邮件信息的著作权及解释权，禁止任何未经授权许可的侵权行为。

IMPORTANT NOTICE: This email is from Fuzhou Rockchip Electronics Co., Ltd .The contents of this email and any attachments may contain information that is privileged, confidential and/or exempt from disclosure under applicable law and relevant NDA. If you are not the intended recipient, you are hereby notified that any disclosure, copying, distribution, or use of the information is STRICTLY PROHIBITED. Please immediately contact the sender as soon as possible and destroy the material in its entirety in any format. Thank you.

****************************************************************************

