Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDB17ED533
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 22:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344847AbjKOVCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 16:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235730AbjKOVBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 16:01:48 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9E11B8;
        Wed, 15 Nov 2023 13:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=s31663417; t=1700082045; x=1700686845; i=wahrenst@gmx.net;
        bh=rNldis1p5YzojdhDCj6DbU417aqwBP/yDtSPkIspBbc=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
         In-Reply-To;
        b=fXkHTN75FcRZtVBiywx3P4JHLkbBbRKhh4I/yrExOLokjRHgazDkg0zD125CpSbv
         akA0Ja44935tnpAiaxWkpDnK+h2/5QBFcHvHQzoBPy1SFqlndbHTFdHuiV2UZp5nK
         6bTI0OrzjL6McYSDQ7tJ2hSgVrWtO4oF3aoXJ1fpPHPXCtjDmeBh20vQNxz3x7Ygr
         RJfkdpLuycgeD4mSU0QgyoZ+hIvYFMy52alvI5F6YE9VyIr9TpPEKSVUAycB+ompm
         iBr6A3I1kRh4ZCu1jV4xZZo1Ti2j4vwLj2F5qQWVJAeg72zc04PZm+1qFIW4nS5ZP
         YKzZ7GUZo1VXKIgZyA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.129] ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvK4f-1rKtoq16Vl-00rJIA; Wed, 15
 Nov 2023 22:00:45 +0100
Message-ID: <f4e17d1f-0e93-4e5a-9a23-aa5e704161ec@gmx.net>
Date:   Wed, 15 Nov 2023 22:00:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/15] media: videobuf2: Allow exporting of a struct
 dmabuf
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Umang Jain <umang.jain@ideasonboard.com>,
        linux-media@vger.kernel.org, kernel-list@raspberrypi.com,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        "Ricardo B . Marliere" <ricardo@marliere.net>,
        Dan Carpenter <error27@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.org>
References: <20231109210309.638594-1-umang.jain@ideasonboard.com>
 <20231109210309.638594-4-umang.jain@ideasonboard.com>
 <72f83177-cd34-480a-afcc-a79f85219751@gmx.net>
 <20231115193107.GB29486@pendragon.ideasonboard.com>
From:   Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20231115193107.GB29486@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:UWGy7py8UJCyH9p7MwNMAqWaExabfledFsS9bYQ+Wcm7PdM+Lhk
 SGgRxwglD9RZ4ma/gw/rxFCDeuEMTd/HB8VzNzNuM4rDWnBDPV1QCoYlF6dsYoGXapCmwP6
 QCD2D2HziofbOCAavL8rESDzxALmrzYHDz4MB+3pgYAUATcdJRW9Dw6yrudwN06tBChk5BW
 ibPbYKSLSfGFNE1UlR7Lg==
UI-OutboundReport: notjunk:1;M01:P0:PDL5jnpKONE=;DyIsb0RLet2GXJxWKOX4t38yqwi
 QmdqylkFt+pkhpOPLRLPR5U97ibxn193Ywz7rCCwx40HbO1l4fw0yP2lbm0ZSMtxV2+TRHqDs
 zEpue0VqM5MN/EleTZEN/4qByaQBMJk5Uc5k3f19MKUcH1I0/3UBHPk6ADwac4W6r8b7x0hGA
 g9uEKfX0ROZ6q+WM3J9VfusVYejN6YTzg0yHx5tFTdLBvuVM9JOjW+0F5/lAvqYjy9q96blLp
 Hdu1ak5JsbCld9mlBIK2z8fab6LA8LuEZJD0HOCRk3V5wJ2++UGIxYp4s9gt+o1TMLSLncivQ
 nbe5Fe3xYzlgL0ZlvU9uz4cqMUPmSsGuFS9M1PgdW0hcu0yoNS2e6yA2/BY1x/o3G/ymcEnBb
 glktj9fcEd4DaeDkY4dzRm1XDbJnlC5sHCa96YoZ7ft9x85iaOj33XHldCNv1vS6qnYWliQXG
 3wCa72yVOGu4CrvJZ8lwQ+Nk5G7sIn94T86hFbLfe1+uKIEITvFfq/7khbGbpU3bNPgfCMHEq
 e3qYqqM3cDattpBaXvZ0J7Ypl5MLCLnss7Qx5Q7SCT9eSDN70SKbch1m78TdJ23vOO3ejFpFf
 b4tSZeT4GQz3HG81lylvksYBr4etYb9rLWiyegsscyQCskqAPDqRD/4UJ1loCrTwDWpBQUUgo
 un4RwMt29E7CuZPt9nn9HAZiHsLbht601tP6Z0ondkJP6YzZZKANfWWDKwzIiB4Nly4yPycyD
 hESPabmo6R8MDjspuocmdiwnMwz6syTP0+YiLdApdaDlvfTMlci0RBKDtX6fsXKuRrb20gGnm
 HPQ/zf0B26tDRtpYL38D6aRUPBq0Ppls5FFVBS1/1v+cVVG4ys8QTmbhts5aF3LcN3WzdvN19
 V2Fgi+nmNYnfTb5mDiZ9aOI0qWEWCr7dr1VGpjyij/Lgfrz3ieSsIDLyRI64DhsK5T5XtmoHo
 DGTRPbJhSC7Nqs8ID0riE4Xm3zQ=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 15.11.23 um 20:31 schrieb Laurent Pinchart:
> On Tue, Nov 14, 2023 at 08:41:11PM +0100, Stefan Wahren wrote:
>> Am 09.11.23 um 22:02 schrieb Umang Jain:
>>> From: Dave Stevenson <dave.stevenson@raspberrypi.org>
>>>
>>> videobuf2 only allowed exporting a dmabuf as a file descriptor,
>>> but there are instances where having the struct dma_buf is
>>> useful within the kernel.
>>>
>>> Split the current implementation into two, one step which
>>> exports a struct dma_buf, and the second which converts that
>>> into an fd.
>>>
>>> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.org>
>>> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
>>> ---
>> ...
>>
>>> diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
>>> index 4b6a9d2ea372..cba4e495f6a2 100644
>>> --- a/include/media/videobuf2-core.h
>>> +++ b/include/media/videobuf2-core.h
>>> @@ -925,6 +925,21 @@ int vb2_core_streamon(struct vb2_queue *q, unsigned int type);
>>>     */
>>>    int vb2_core_streamoff(struct vb2_queue *q, unsigned int type);
>>>
>>> +/**
>>> + * vb2_core_expbuf_dmabuf() - Export a buffer as a dma_buf structure
>>> + * @q:         videobuf2 queue
>>> + * @type:      buffer type
>>> + * @index:     id number of the buffer
>>> + * @plane:     index of the plane to be exported, 0 for single plane queues
>>> + * @flags:     flags for newly created file, currently only O_CLOEXEC is
>>> + *             supported, refer to manual of open syscall for more details
>> i think "newly created file" could be confusing here
> Would "newly created dmabuf file handle" be clearer and work for
> everybody ?
i'm fine with it
>
>>> + *
>>> + * Return: Returns the dmabuf pointer
>>> + */
>>> +struct dma_buf *vb2_core_expbuf_dmabuf(struct vb2_queue *q, unsigned int type,
>>> +				       unsigned int index, unsigned int plane,
>>> +				       unsigned int flags);
>>> +
>>>    /**
>>>     * vb2_core_expbuf() - Export a buffer as a file descriptor.
>>>     * @q:		pointer to &struct vb2_queue with videobuf2 queue.

