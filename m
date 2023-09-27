Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A17617B0D92
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 22:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjI0Uro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 16:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjI0Urn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 16:47:43 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8373E11D
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 13:47:42 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-690d2441b95so9212873b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 13:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695847662; x=1696452462; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=umu6zI7KqlBnvz7R71VlvP7jPJvXGwT3mz/S+vCmheA=;
        b=dAMCk8PpZ3SZb6Zu14VV1KosID7iAbMjGmCg9/QxdFUTPlmakTV0fYQSLd4xH/tYJK
         AQOd3Fzp/q4C6QPWJll4O7QuO8rrzgU0zxewyAyCUt4UTy2lp7H1WAaXi9IidthniLEB
         +kh8GWYN+74BY4Ch8mouqfNcxB8ts1UZjp34Jxf7ouNEVd7/EYeMgsvYTOBnr2c5rp3o
         prS7TqJkfeHc8nIKVp/8CeJ+CsaN1usfEdhTHxiKLDzhdFJU+NmNMggEfsSyTWNVLGHt
         6GrayjK+ZrDoBJl3VtApelM+VUrAL4orsH4PTk4BKkKMTagNNL08fFOSpV8FDQieIHhX
         aNzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695847662; x=1696452462;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=umu6zI7KqlBnvz7R71VlvP7jPJvXGwT3mz/S+vCmheA=;
        b=fFIu4ZbTCYDfxPGbFiHTseI2+fVuiSECqndwv84dLCHbsGxmxwJ/1TiISa/7rMnLeO
         aBUXAky6KEs2RHE7d3fQIF4x8j0+FdMOHmcSTwwuoimB37A6Akc5jR2gZ7U0wNVf53HL
         02uo/bianx6dwawESllySxr06U+5qTw68vUMBVVd7mxk4AL8EVTu5ha1yLdoC1z0Rjpf
         1x+dlNyYbS8xe0PEDoUX2/19LjKQGJGjKkTltcEBZ0UK9Gm8cigWjNwP6Pe+FsDigp/N
         YC5w1bLubqJgLvTIOfygvTBSMZEeozJNpFhxrt/NNil1QU5Wg+HZ7Fkqn8eOlzEfD37e
         BnQQ==
X-Gm-Message-State: AOJu0Yx/lLz/tlIuuVhudUt/ui3mCzUy7xsbrqXcGqWTtsP5zTy3TLzS
        Yf/c5PAMk8jVJDM1fPyJkZdt5Q==
X-Google-Smtp-Source: AGHT+IGhDl6LmtgdDp6QDyBGz7JuZ/E9XNiM7InTw9ExyO7ynisKQ602gRRhQSfm96xvhyra/dtDbQ==
X-Received: by 2002:a05:6a00:14d2:b0:68b:a137:373d with SMTP id w18-20020a056a0014d200b0068ba137373dmr5818458pfu.17.1695847661735;
        Wed, 27 Sep 2023 13:47:41 -0700 (PDT)
Received: from [192.168.60.239] (124.190.199.35.bc.googleusercontent.com. [35.199.190.124])
        by smtp.gmail.com with ESMTPSA id c16-20020aa78e10000000b0068c61848785sm12149737pfr.208.2023.09.27.13.47.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 13:47:41 -0700 (PDT)
Message-ID: <1b8bb18d-460e-48cd-ab7d-80af8910423b@google.com>
Date:   Wed, 27 Sep 2023 13:47:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] usb: gadget: uvc: stability fixes when stopping
 streams
Content-Language: en-US
From:   Avichal Rakesh <arakesh@google.com>
To:     Michael Grzeschik <mgr@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Scally <dan.scally@ideasonboard.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230912041910.726442-1-arakesh@google.com>
 <CAMHf4WLeSC9m05XOU54yL=2xUcSqbWP0f7evM0rZRsJ=J-btWw@mail.gmail.com>
 <ZQTlz9Koe2CQIsrC@pengutronix.de>
 <af3c1637-ff43-4346-8cfb-db836d6de3f0@google.com>
 <bb962593-9665-4bb1-be14-c56ce17b9073@google.com>
In-Reply-To: <bb962593-9665-4bb1-be14-c56ce17b9073@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/19/23 11:24, Avichal Rakesh wrote:
> 
> 
> On 9/15/23 18:35, Avichal Rakesh wrote:
>>
>>
>> On 9/15/23 16:16, Michael Grzeschik wrote:
>>> Hi Avichal
>>>
>>> On Thu, Sep 14, 2023 at 04:05:36PM -0700, Avichal Rakesh wrote:
>>>> On Mon, Sep 11, 2023 at 9:19 PM Avichal Rakesh <arakesh@google.com> wrote:
>>>>>
>>>>> We have been seeing two main bugs when stopping stream:
>>>>> 1. attempting to queue usb_requests on a disabled usb endpoint, and
>>>>> 2. use-after-free problems for inflight requests
>>>>>

>>>
>>> The error path triggering these list errors are usually in the
>>> dwc3 driver handling the cancelled or completed list.
>>
>> It looks like we're still freeing un-returned requests :(. If you still have
>> the setup can you pull the uvc logs to see if waiting for requests to be returned timed 
>> out? I wonder if dwc3's interrupt handler is being scheduled too late. 500ms seemed
>> like a reasonable time out to me, but this seems to prove otherwise.
>>
> 
> 
> Hey Michael, were you able to look into the comments from the previous
> email? 
> 

Bumping the thread up. Laurent, Dan, and Michael: the patches are ready to
review/test. Please take a look when possible. 

Thank you!
Avi.
