Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDAF76309E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbjGZI43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232720AbjGZIzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:55:37 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56054693;
        Wed, 26 Jul 2023 01:49:01 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qOaBR-0003Ck-29; Wed, 26 Jul 2023 10:47:49 +0200
Message-ID: <ab557ae6-7550-189a-81dd-6e3346d84620@leemhuis.info>
Date:   Wed, 26 Jul 2023 10:47:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US, de-DE
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        stable@kernel.org, Zubin Mithra <zsm@chromium.org>,
        =?UTF-8?Q?Kai_Wasserb=c3=a4ch?= <kai@dev.carbon-project.org>
References: <20230717-uvc-oob-v2-1-c7745a8d5847@chromium.org>
 <20230725213451.GU31069@pendragon.ideasonboard.com>
 <CANiDSCttkqows7PZS823Jpk-CqK9Gz2rujF_R4SPDi=wcPJ2LA@mail.gmail.com>
 <20230726080753.GX31069@pendragon.ideasonboard.com>
 <952fb983-d1e0-2c4b-a7e8-81c33473c727@leemhuis.info>
 <CANiDSCvVag+sW5JDTKAPuML_-+6xHWgF+NeKoBKSd5MMr1Yiag@mail.gmail.com>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH v2] media: uvcvideo: Fix OOB read
In-Reply-To: <CANiDSCvVag+sW5JDTKAPuML_-+6xHWgF+NeKoBKSd5MMr1Yiag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1690361341;9e6180f4;
X-HE-SMSGID: 1qOaBR-0003Ck-29
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.07.23 10:38, Ricardo Ribalda wrote:
> On Wed, 26 Jul 2023 at 10:33, Thorsten Leemhuis <linux@leemhuis.info> wrote:
>> On 26.07.23 10:07, Laurent Pinchart wrote:
>>> (CC'ing Kai and Thorsten who have added the check to checkpatch)
>>>
>>> On Wed, Jul 26, 2023 at 08:24:50AM +0200, Ricardo Ribalda wrote:
>>>> On Tue, 25 Jul 2023 at 23:34, Laurent Pinchart wrote:
>>>>> On Thu, Jul 20, 2023 at 05:46:54PM +0000, Ricardo Ribalda wrote:
>>>>>> If the index provided by the user is bigger than the mask size, we might do an
>>>>>> out of bound read.
>>>>>>
>>>>>> CC: stable@kernel.org
>>>>>> Fixes: 40140eda661e ("media: uvcvideo: Implement mask for V4L2_CTRL_TYPE_MENU")
>>>>>> Reported-by: Zubin Mithra <zsm@chromium.org>
>>>>>
>>>>> checkpatch now requests a Reported-by tag to be immediately followed by
>>>>> a Closes
>>
>> Not that it matters, the changes I performed only required a Link: tag,
>> which is how things should have been done for many years already. It
>> later became Closes: due to patches from Matthieu. But whatever. :-D
> 
> I prefer to leave the Reported-by and remove the Closes, that way we
> credit the reporter (assuming they approved to be referred).
> 
> But if that is not possible, just remove the reported-by. A private
> link is pretty much noise on the tree.

Yeah, of course that's the right strategy (Linus made it pretty clear
that he doesn't want any private links) in case the reporter okay with
the Reported-by. Sorry, forgot to cover that case in my reply.

Ciao, Thorsten
