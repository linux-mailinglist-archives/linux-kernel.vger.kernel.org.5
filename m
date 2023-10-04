Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE547B818E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 16:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242737AbjJDOAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 10:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242720AbjJDOAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 10:00:43 -0400
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63ED6AD
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 07:00:38 -0700 (PDT)
X-KPN-MessageId: 647cfbdd-62be-11ee-91e6-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.6])
        by ewsoutbound.so.kpn.org (Halon) with ESMTPS
        id 647cfbdd-62be-11ee-91e6-005056994fde;
        Wed, 04 Oct 2023 16:00:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xs4all.nl; s=xs4all01;
        h=content-type:from:to:subject:mime-version:date:message-id;
        bh=GdFyELLah3D1RPZghY3iN5OCqEqJX5lTi2/eO5f5rOU=;
        b=PBtt1XpLghDCwelkIQMoO1HOiBF6dVn5O/LxIMgQ0tEHGbeJxsBuVMzQhpH8jN1S4umMNM7Q5Flmp
         Z1Akqk8GDnVUASlbb7WI7+32XehtsERKFtzwkpfXI7gG6PQhptY8a4V6GCUFjPaLfng9Ui7piJRLDI
         2+WRsfF250cv+gfmg9X5lhCgQlRZl1ffhH3PUk5uqmCE9o4QDJDpn5Yocb+og4QkeK4NtALOzpkSAe
         H1uFKe0ldn/ksFOW3ww8oqP37Q4VPeMc4zqrLt7RvdSY2HRsbA6FXXZdTWfllIZEwdtrWiLKnTjkNe
         U3Bo70wSS0VaSofcfd6uj0Qck9m6d3Q==
X-KPN-MID: 33|ns7Zm8lWX1D46tpoB+CCpqOBk4X/t2seMZb4pjvehkYdyVaCd9JgRuw4WSG+Y0x
 btqeE66/RE2uGhKk/2q0cW+8MHjxp8V7+BinXVmsSI74=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|oFFIx4i0UzlxieUqwdNi2Yv7VkrTOh3AUUC60/KZWx+TuoiMrmiQ/KtdpQco3FB
 gSrxBdENRxLezN+DJVEpjFA==
X-Originating-IP: 173.38.220.46
Received: from [10.47.77.214] (unknown [173.38.220.46])
        by smtp.xs4all.nl (Halon) with ESMTPSA
        id 63a19e76-62be-11ee-9dc8-00505699772e;
        Wed, 04 Oct 2023 16:00:35 +0200 (CEST)
Message-ID: <691b9545-0caa-4b8f-a745-13ba811c94dc@xs4all.nl>
Date:   Wed, 4 Oct 2023 16:00:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] visl: use canonical ftrace path
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ross Zwisler <zwisler@kernel.org>, linux-kernel@vger.kernel.org,
        Ross Zwisler <zwisler@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Daniel Almeida <daniel.almeida@collabora.com>
References: <20230829204600.3210276-2-zwisler@kernel.org>
 <20231003174129.11c79c18@gandalf.local.home>
 <c7e21ecf-9554-425d-a8c1-90f890de6bb4@xs4all.nl>
 <20231004095720.5727254a@gandalf.local.home>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20231004095720.5727254a@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/23 15:57, Steven Rostedt wrote:
> On Wed, 4 Oct 2023 08:33:12 +0200
> Hans Verkuil <hverkuil-cisco@xs4all.nl> wrote:
> 
>> On 03/10/2023 23:41, Steven Rostedt wrote:
>>>
>>> Could this go through the linux-media tree, or if you give it an Ack, I'll
>>> take it through the tracing tree.  
>>
>> I prefer to take this through the media subsystem. Ross, can you post this
> 
> Thanks!
> 
>> patch again, this time including linux-media@vger.kernel.org?
> 
> The original patch did have linux-media@vger.kernel.org Cc'd. Was it dropped?

You are correct, it was sitting in patchwork, I somehow missed it.

It's now delegated to me, so it is in my pipeline.

Regards,

	Hans

> 
> -- Steve
> 
> 
>>
>> The patch looks fine, so I'll pick it up.
>>
>> Regards,
>>
>> 	Hans

