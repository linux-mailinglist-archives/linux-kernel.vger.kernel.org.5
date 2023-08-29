Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C302178CDB9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 22:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240387AbjH2Umu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 16:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234272AbjH2Umb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 16:42:31 -0400
Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20401BC
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 13:42:27 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id b5XZqcc2VQ296b5Xaq5xos; Tue, 29 Aug 2023 22:42:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1693341744;
        bh=NSFtOWiCqFXMHVz2Ts71ekjvauIWND+mQAvXMrYTxRo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=JiJGg1XhYATzHEw6lkCs+v8JzG7gkLoK6B2h9GWjgYXoHcLSsWYKWpyXNH9E3NO+X
         OqG0pgqugAg+DP3GM/hGNuyeGdmd3td054G7PxovknxnSfxzmnx4KCCQ0tniL7ff0q
         ke+h+AevJ3PVZ9ZICdFkdFptUaOb2KV7OilfTIx8G4wF+9dbIL04DTxN+OsO8d06Hd
         N3Nz/p5StB2zqeLSCbCkEMMmdy7bCer5unzlFdQtw/0uRASZgiaPKiIkADTlDLlYHV
         KcxoJpTOMErIlNVHi10adQssTia9qP8BEvUQN+Xqwc8OcNizUoU4ZZqDnNZ3+frfGP
         UH6mWOgtv5UVA==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 29 Aug 2023 22:42:24 +0200
X-ME-IP: 86.243.2.178
Message-ID: <6875e4e7-085e-fa0c-c0f7-404fb82a872c@wanadoo.fr>
Date:   Tue, 29 Aug 2023 22:42:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] media: i2c: rdacm2: Remove an incorrect
 fwnode_handle_put() call
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-media@vger.kernel.org
References: <d9230082aefcb7bab6363c51c08598eb5ab62cfc.1693037086.git.christophe.jaillet@wanadoo.fr>
 <zijwh5kcrfsg4q4pmxtkzia7tdpg4wnau53npe2y2xe4j7n7wy@zqwigtmyftu3>
 <20230828105723.GF14596@pendragon.ideasonboard.com>
 <20230828111630.GH14596@pendragon.ideasonboard.com>
Content-Language: fr, en-US
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230828111630.GH14596@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 28/08/2023 à 13:16, Laurent Pinchart a écrit :
> On Mon, Aug 28, 2023 at 01:57:24PM +0300, Laurent Pinchart wrote:
>> On Mon, Aug 28, 2023 at 09:48:10AM +0200, Jacopo Mondi wrote:
>>> Hi Christophe
>>>
>>> On Sat, Aug 26, 2023 at 10:05:06AM +0200, Christophe JAILLET wrote:
>>>> The commit in Fixes has removed an fwnode_handle_put() call in the error
>>>> handling path of the probe.
>>>>
>>>> Remove the same call from the remove function.
>>>>
>>>> Fixes: 1029939b3782 ("media: v4l: async: Simplify async sub-device fwnode matching")
>>>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>>>
>>> Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
>>
>> The subject line should read "rdacm21", not "rdacm2". with that fixed,
>>
>> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>>
>>>> ---
>>>> /!\   This patch is highly speculative. Review with care.   /!\
>>>>
>>>> If it is correct, it is likely that other similar issue lurk in commit
>>>> 1029939b3782. I've not looked in detail and my cocci script did not
>>>> trigger on them but drivers/media/i2c/max9286.c also looks like a
>>>> similar candidate.
>>>
>>> I think the call to  fwnode_handle_put(priv->sd.fwnode) in
>>> max9286_v4l2_unregister() can indeed be removed, yes!
>>
>> I agree.
> 
> drivers/media/platform/nxp/imx-mipi-csis.c also needs a fix.
> 
> Christophe, do you plan to send patches for those ? If not, I can handle
> it.

I'll propose patches for both in the coming days.

CJ


