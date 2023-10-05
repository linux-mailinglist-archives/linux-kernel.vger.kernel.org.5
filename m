Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099067BA2C4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234296AbjJEPqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233960AbjJEPpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:45:06 -0400
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47FAC658E;
        Thu,  5 Oct 2023 08:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1696518098;
        bh=j7v78EfYr5kWBGVx9Q0yeHqQ9MIDixPPetJ6nvLJ2nc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Q1EOr3sPF+C02Z9y8KIbwTZOG7fwnZjX9n5Dq2v2HiP7FvMH2e6y01F4d46nYbBRq
         RmU0WuCxgaFsugA6hmrUewisTEQf2E5scs+XGcRQNzDwS3CEXc1Wu6EUIthmO6Vgro
         QkhRSqA5VFY/hwCYxKtZG5om5LSSrC89JfBLhGpc=
Received: from [10.255.87.57] ([122.14.229.252])
        by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
        id 6299CF5; Thu, 05 Oct 2023 23:01:34 +0800
X-QQ-mid: xmsmtpt1696518094tyxh55cxd
Message-ID: <tencent_21B5235BC260E91E030A10A8E112D037EC08@qq.com>
X-QQ-XMAILINFO: N8kVz9D657mRghfTFuheWxMrr0xSlkTJvrM9oKOp5NOWHliJN+ctqLKGt97tFL
         m3fz4DS2pnsYA+PNV3STpG+lWIHV6mz2eVcyPT+9ZVSohw4YhsVGOVorP60vX9itD6HRWouswlkP
         uqd+5yAcNqjUdBVs78KFqerqFLjQ2FSNBa10zhueGXzVJL8/OQlfUUg7au0y2QybffnXu0hPhM2D
         AseFv1dzmfBf/XLrmLBTHB93y02qKt2rBCKfDLJMiPJ8VrO456vwkvyjscNVB3rhk/6UC/44sf/K
         aVmpVa+Kgi1UUDCTKHTbLoodV5599fXSes7B4vCu30JrrOzugSlXUBcOu89RnvTTAUNzO3TNtslQ
         tN/JFsRxV7QvmWGXbtWo0lzkNx0xHgq2ydXIeyM/O/Y0v00gG+PtT+VxAIL3xXCeFzOr+KCKsl1r
         uit6OEIuteYr1LjFseTW2i6q8ih+Enz5kQlZGf6iflGNi4Jwtd6p2doE+5C8FKpfcnLkCdqVLg/8
         6vjGeuHWSab2VU4uREAq66UhZRHPt8TJqUsPyLkOKDOYXwTdlUji0x+gmfhj/0c0IV/5jkblu5Hl
         XpcZnjxZw0MUKCgP0DG/DvinadUuCF3AV50GW7so5uCiIAh6BWu61b5NzjfCDwO/CgxPN/xm2haq
         LBTHzesSnCb6/CwKy4CouVSmftE6Ht59ZGHzXvOHcp3dM+UiQzFutnVNnR2ChydntH2GrtyW5IZQ
         ZHmU6XkE6zLIJZDCytV0P8OpeA951BDqxY2ZycevqV9bjPRhcWFfrVPjB3x9nWLklFwNmBvjstYS
         20xYf0e76yFi/knHIwg2fC/7r6W6M+/Bm3MnlSLnzleMX2m25ukWoxqkVcfGLf7fm5MIprDEDiwn
         DKRAPamy2c6D7bHAKgIAl3XNqPoJFyxzOzc9z5iRB4TBVCLJxe/lPTT7JAbJU2mtql+YnNlA9AZw
         jNRFrcHZiIeIrrGHVCquNHflmyBM6um1vycxdgyW7+c/3i9WMzKZgDIvlE514MlzI0S/XH/lWq0e
         NVJX5tdjj9BltgNfA18GRmQAjW2fYhdc98wvQRSH0vEI+i1gMDiRFXqkncaMy104LkRpk45Q==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-OQ-MSGID: <3e289937-f216-4ead-abac-28d35d644f9c@foxmail.com>
Date:   Thu, 5 Oct 2023 23:01:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3: fix possible object reference leak
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Thinh.Nguyen@synopsys.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <tencent_6BA8EA125537CBB5D65B05605E1E960AA708@qq.com>
 <2023100512-crayon-prowess-0f27@gregkh>
From:   Zhang Shurong <zhang_shurong@foxmail.com>
In-Reply-To: <2023100512-crayon-prowess-0f27@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I apologize for the poorly formatted patch.
I will make the necessary revisions and send it to you again.
Additionally, I thought that it may not be straightforward
to test but I will try.

Kind regards,
Shurong

在 2023/10/5 21:59, Greg KH 写道:
> On Thu, Oct 05, 2023 at 09:49:46PM +0800, Zhang Shurong wrote:
>> The of_find_device_by_node takes a reference to the struct device
>> when find the match device,we should release it when fail.
>>
>> Fix it by calling by calling platform_device_put when error returns.
>>
>> Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
>> ---
> What commit id does this fix?
>
> And how did you find this?  How was it tested?
>
> thanks,
>
> greg k-h


