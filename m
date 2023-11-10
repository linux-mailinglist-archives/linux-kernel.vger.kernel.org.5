Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872517E7EA3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234756AbjKJRqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:46:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235113AbjKJRpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:45:36 -0500
Received: from mail-m127102.qiye.163.com (mail-m127102.qiye.163.com [115.236.127.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168CB9EDD;
        Fri, 10 Nov 2023 00:30:20 -0800 (PST)
DKIM-Signature: a=rsa-sha256;
        b=XiqeolchP3njZmt+f79epZWTdAxsmqLbScSw8AQO4RUgwBBXf+74Ueu0wP02Efa2A9iHxM/ISi7pO+dSUve2pewsyyCdKSJDudwTjzFYJ8OQzxeDftCU/zmSx3PalWGuNWg09g70Sjg54LORI0RikiCZLPhc6PlfQoA+UzZSkys=;
        c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
        bh=c8gwyP0bjpv+fHqfLFg4bZJyzgVrMfpkxHsJ3EbC6LY=;
        h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.49] (unknown [58.22.7.114])
        by mail-m11877.qiye.163.com (Hmail) with ESMTPA id E1F2F400389;
        Fri, 10 Nov 2023 16:29:35 +0800 (CST)
Message-ID: <01d2844e-8a9f-d529-c523-c846760bc31b@rock-chips.com>
Date:   Fri, 10 Nov 2023 16:29:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v6 3/3] clk: rockchip: rk3588: Adjust the GATE_LINK
 parameter
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        mturquette@baylibre.com, sboyd@kernel.org,
        kever.yang@rock-chips.com, heiko@sntech.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, huangtao@rock-chips.com,
        andy.yan@rock-chips.com
References: <20231110020358.12840-1-zhangqing@rock-chips.com>
 <20231110020358.12840-4-zhangqing@rock-chips.com>
 <d36d4f7e-03be-4018-be5d-0898f2ae6a15@linaro.org>
From:   zhangqing <zhangqing@rock-chips.com>
In-Reply-To: <d36d4f7e-03be-4018-be5d-0898f2ae6a15@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkhNH1ZOS0MeTx9ISh9NHR9VEwETFh
        oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5JVUpLS1VKQl
        kG
X-HM-Tid: 0a8bb859d2e72eb3kusne1f2f400389
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OlE6PDo*ODw4MQweIR1MTgJP
        CVEKCS5VSlVKTUJCTUtPQkxMSUhCVTMWGhIXVQETGhUcChIVHDsJFBgQVhgTEgsIVRgUFkVZV1kS
        C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUhDQ0M3Bg++
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/11/10 15:46, Krzysztof Kozlowski 写道:
> On 10/11/2023 03:03, Elaine Zhang wrote:
>> Export PCLK_VO1GRF clk id.
> If the clock is exported, how do you get its reference?
The export of the clock has been abandoned, and mark the pclk_vo1grf as 
CLK_IS_CRITICAL.
Fix The commit message later.
>
> Best regards,
> Krzysztof
>
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

