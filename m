Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454BA7E63EE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 07:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbjKIGfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 01:35:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjKIGfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 01:35:46 -0500
X-Greylist: delayed 436 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 08 Nov 2023 22:35:43 PST
Received: from mail-m12810.netease.com (mail-m12810.netease.com [103.209.128.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8A125AC;
        Wed,  8 Nov 2023 22:35:42 -0800 (PST)
DKIM-Signature: a=rsa-sha256;
        b=AxRQSJZZFXK672SFkbVflogru0527w2+vt0KE1t5uOP5ctl5FD7nB9ydw+KvQQXN8QPE/SlzmKL0hWE8nsXOmZhwqdm7seJuZ4oMnWmNAjMp0z6mtLMCNHfUxurIphGWgbdH77WgeT2pp3D13SvKJlhmoGZDWysIPcVAo1KzPXc=;
        c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
        bh=deohqXdOgJExhg0RUCs+1qaAr3+jnJycAP22GqRuu7M=;
        h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.49] (unknown [58.22.7.114])
        by mail-m11877.qiye.163.com (Hmail) with ESMTPA id AB04F400396;
        Thu,  9 Nov 2023 14:27:38 +0800 (CST)
Message-ID: <2e520a06-0ff1-76ef-2a72-ab6663738b45@rock-chips.com>
Date:   Thu, 9 Nov 2023 14:27:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v5 3/4] dt-bindings: clock: rk3588: export PCLK_VO1GRF clk
 id
To:     Conor Dooley <conor@kernel.org>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        kever.yang@rock-chips.com, heiko@sntech.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, huangtao@rock-chips.com,
        andy.yan@rock-chips.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20231108061822.4871-1-zhangqing@rock-chips.com>
 <20231108061822.4871-4-zhangqing@rock-chips.com>
 <20231108-donation-uncertain-c4d0f560c420@spud>
From:   zhangqing <zhangqing@rock-chips.com>
In-Reply-To: <20231108-donation-uncertain-c4d0f560c420@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0JMS1YaQ00aTUJNHUhCSxhVEwETFh
        oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5DTUtIVUpLS1VKQl
        kG
X-HM-Tid: 0a8bb2c3d02d2eb3kusnab04f400396
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OVE6NSo*AjwyVg8cPkMyGTAK
        GA0aC0pVSlVKTUJCTkpKSU5CTENIVTMWGhIXVQETGhUcChIVHDsJFBgQVhgTEgsIVRgUFkVZV1kS
        C1lBWU5DVUlJVUxVSkpPWVdZCAFZQU9CSkk3Bg++
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

在 2023/11/8 20:01, Conor Dooley 写道:
> On Wed, Nov 08, 2023 at 02:18:21PM +0800, Elaine Zhang wrote:
>> export PCLK_VO1GRF for DT.
>>
>> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
>> ---
>>   include/dt-bindings/clock/rockchip,rk3588-cru.h | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/dt-bindings/clock/rockchip,rk3588-cru.h b/include/dt-bindings/clock/rockchip,rk3588-cru.h
>> index 5790b1391201..50ba72980190 100644
>> --- a/include/dt-bindings/clock/rockchip,rk3588-cru.h
>> +++ b/include/dt-bindings/clock/rockchip,rk3588-cru.h
>> @@ -733,8 +733,9 @@
>>   #define ACLK_AV1_PRE			718
>>   #define PCLK_AV1_PRE			719
>>   #define HCLK_SDIO_PRE			720
>> +#define PCLK_VO1GRF			721
>>   
>> -#define CLK_NR_CLKS			(HCLK_SDIO_PRE + 1)
>> +#define CLK_NR_CLKS			(PCLK_VO1GRF + 1)
> This definition is part of the ABI, if it is safe to change it, then it
> is safe to delete it.
The new ID is to solve the niu clock dependency problem(Used in PATCH V5 
4/4).This new ID will also be used in DTS in the future.

CLK_NR_CLKS represents the number of clocks used by the 
drivers/clk/rockchip/clk-rkxxx.c. It is safe to modify it, but cannot 
delete it.

>
>>   
>>   /* scmi-clocks indices */
>>   
>> -- 
>> 2.17.1
>>
>>
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

