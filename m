Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D5E7A5CDA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 10:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjISIqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 04:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjISIqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 04:46:44 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A516115;
        Tue, 19 Sep 2023 01:46:38 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-31f7c87353eso1056416f8f.0;
        Tue, 19 Sep 2023 01:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695113197; x=1695717997; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zzteqkqa4qRFqipdP6HdXUn0HQqodaqc3bF5fGulmPA=;
        b=VAqaKJxHFVY7A/sppiTvDv5BC3uonMpdyuu7LTxFbEb/e+uw21tkFbf9enHjB8kmrA
         1MNCyU7ioMAXE02I/DSjYyAHxmVXgcqkrt/N+nqDoRjcQLLJyiwOCndNnog81Q3/qKuk
         4YLGbX6zCJMxYKJe3rvxF/aNAl0YgMC0uF7wx6gjj4ueDQ2XPgzNklXDH5h6GzcP1V1B
         SojEmZ1Ls8LaryCAUB3sLE/GYgXN7KzbXlSk1mVPdhTG2Tpsc89tqhOT51d7qJvKU+yz
         nnxAkJzTETgIm6QLfTg6eJR34WSFFmhBaKsHsKcQr4tcRLUGTycK8FOG8lm1yK01XilC
         xghw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695113197; x=1695717997;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zzteqkqa4qRFqipdP6HdXUn0HQqodaqc3bF5fGulmPA=;
        b=t3ZLfnNtSr81qu7t83ebgQdlit+4I2UuDdLK3vrA8Oyk+EAfym8DBhFmmEViWIShu/
         CRBJyEsBqkh1cG6Tqsq7MVIO/NLO3D966JGog2JVI2zQ3I9RI9PeWkMzuY2JlBo6X4Bu
         fOTnqASkepnmNhq7ipgfRsnCmlTxsvDQ/1NjU79t9jkmB2T0NQzt+lrUEC8amnDIK9B7
         ikQdIYPej4BEwkh9oB0Po22VBwEOLs/gijynighOa2BM1SIwcxRs+uTeTHr4gD9QjHA9
         4hzph/LuNmLh8Nd15kf9xfpXDIF3/TPncTndalOv4pS+dQrvI+ZsaUQNdzYr9NahAzoR
         lyXA==
X-Gm-Message-State: AOJu0YwxQjlYDXK0SqJvzP0ymV+EZWgqy/lZJhNF5KM+U/sa8SYah9LR
        K7BMsA35vbdUBIjGlHgNzCkwriZTzY0=
X-Google-Smtp-Source: AGHT+IFIKDOYPocedZf6pvscWOVgRgUAwxIGcvYDGsECE+EevzoLqm4VZTuqzIU+9u+tx2uHYwN1Yg==
X-Received: by 2002:adf:ec4f:0:b0:31f:a717:f1cc with SMTP id w15-20020adfec4f000000b0031fa717f1ccmr8868755wrn.5.1695113196885;
        Tue, 19 Sep 2023 01:46:36 -0700 (PDT)
Received: from [10.0.0.26] ([178.160.241.68])
        by smtp.gmail.com with ESMTPSA id o12-20020adfeacc000000b003176c6e87b1sm6083775wrn.81.2023.09.19.01.46.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 01:46:36 -0700 (PDT)
Message-ID: <56a4a085-6b1d-19c6-4160-4513c8c41e57@gmail.com>
Date:   Tue, 19 Sep 2023 12:46:34 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 2/2] ALSA: Add new driver for Marian M2 sound card
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     perex@perex.cz, tiwai@suse.com, corbet@lwn.net,
        alsa-devel@alsa-project.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230918181044.7257-1-ivan.orlov0322@gmail.com>
 <20230918181044.7257-2-ivan.orlov0322@gmail.com>
 <2023091955-dried-popsicle-f3d8@gregkh>
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <2023091955-dried-popsicle-f3d8@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/19/23 12:04, Greg KH wrote:
> On Mon, Sep 18, 2023 at 10:10:44PM +0400, Ivan Orlov wrote:
>> +
>> +#define DEBUG
> 
> Do you mean to have DEBUG enabled at all times?  Shouldn't this be a
> runtime issue with the normal dynamic debug infrastructure?
> 
> thanks,
> 
> greg k-h

Hi Greg,

Yeah, I was experimenting with dynamic debugging and I've just forgotten 
to remove it... I'll be more attentive next time :(

By the way, is there any way to detect such issues automatically? I've 
seen that the kernel test robot detects a lot of similar stuff, perhaps 
there is any tools/linters which can be set up locally?

--
Kind regards,
Ivan Orlov
