Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 873987D80F1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 12:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbjJZKlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 06:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjJZKlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 06:41:19 -0400
X-Greylist: delayed 21256 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 26 Oct 2023 03:41:15 PDT
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F0418D
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 03:41:14 -0700 (PDT)
Message-ID: <df22c0f4-671f-4108-85a0-d1667ec1da77@monoid.al>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monoid.al; s=key1;
        t=1698316872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rd3eoaiF/+tbh5L7T/uyc81E4f5T3FXS86ruMLdkn04=;
        b=iEG+loyV0OVdROto6FwhYBLSvgpMxCFBSsDjAOLWEx2pQa/812stSjx6zR/W44ppOD1z5/
        63/1bOQRsXpW0emDYWCgI7BgWJ5cSsJLMQfsW2q7szxIQEPPxzUU0Y9v4ypAlURe6s4cPk
        ZSWRo1IFj/V+5gsJjEN5Vu5a6dqLY/l2vhCc/a/WCVvM+PUZfQ7s9cG3zwHvXKk216yQjq
        EQ2WnVdNXn17TC0X5rkFglWQ3AZptuBZ0tjutsYNaEkY3V8MuBgmI66KM/fUM4fY9+87dw
        06XSSKCmX3hXz/h3H4yfgcsNvfAKp+llnSZW4qqm2HpkZAc6vIJAlWohhEhAcg==
Date:   Thu, 26 Oct 2023 18:41:05 +0800
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Ellie Hermaszewska <kernel@monoid.al>
Subject: Re: [PATCH v2] hwmon: (asus-ec-sensors) add ROG Crosshair X670E Gene.
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     eugene.shalygin@gmail.com, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CAB95QAR-UbfVULOCaZMO4H1AgvzbiHEoSYk-DiYPY6Pg-i7Vag@mail.gmail.com>
 <20231019135640.434752-1-kernel@monoid.al>
 <d013e9a3-df0a-4b8f-a1f3-db3cbd32812f@roeck-us.net>
 <b81ae275-d3ac-4565-a09a-4a5ce38fadf1@monoid.al>
 <3a8fd5d6-9b79-76de-80fe-b39e24510dec@roeck-us.net>
In-Reply-To: <3a8fd5d6-9b79-76de-80fe-b39e24510dec@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/23 13:01, Guenter Roeck wrote:
> On 10/25/23 21:46, Ellie Hermaszewska wrote:
>> On 10/26/23 03:35, Guenter Roeck wrote:
>>  > This is not an acceptable commit description.
>>
>> This is not acceptable feedback.
>>
>> I am unable to accept it because it is not clear to me what you think
>> should be changed.
>>
>> Is it because I misplaced the message to Eugene? Is it because of the
>> Greek characters? Is is not descriptive enough of the change, or in the
>> wrong tense, or has incorrect punctuation? Do I need to include my
>> testing methodology?
>>
>> If it's only something minor, then please also feel free to correct it
>> yourself before applying. If you can't or it's not something minor,
>> then please let me know what ought to change and I can try to correct it.
>>
>> If you don't let me know, then I will have to guess and possibly waste 
>> everyone's time further.
>>
> 
> Please consider reading and following the directions in
> Documentation/process/submitting-patches.rst.

I will guess that it was my misplaced reply, and submit again without 
that part.

Thank you for your time.
