Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA847E6F8F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 17:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344303AbjKIQon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 11:44:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345172AbjKIQoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 11:44:30 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E49A83CF
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 08:41:51 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3b2f507c03cso570624b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 08:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20230601.gappssmtp.com; s=20230601; t=1699548111; x=1700152911; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yR/z6UUllx8SgrqxPj7THOOWOLeH/9APRXnUSFnsEo0=;
        b=peLW/zHVFbXfn0Ti7JcIphG7v7WepA0pyH9+WT3UMeAolHA03l/lLsdVFLTlddqxyo
         PUZ+BPWFVNWTOZei8Al+nWi35hCW2WA5lfM8/7MoF23Wyaw1bhm0PITPdhroTM9BFzoU
         N6ILNf1d9tvkSPTjpbzG/sSWyA4o0fbcOp0lcVA4ULR/T2HiyJP+r0pJUxpWFYmv+pE/
         H7R5nTWhYn2dvMmWATwCmzUk7jDiH+R1QyQKgDCTnvx/OK+vyAyKJpNlDeOYVH+w4XND
         19w/RTxBzEZTdeFFRqU/YC4+yapk1YHW1pT7TkYtZ73qgsfbJqsVa2/h4e7zETwdDXHR
         xDXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699548111; x=1700152911;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yR/z6UUllx8SgrqxPj7THOOWOLeH/9APRXnUSFnsEo0=;
        b=OkGVqsdE+xqVXfdlLT6t/pW39zZaeFl30ZvJuAw2Ob4tboSO2hB0aYiGIYaWujLKV+
         QMsYKS7rW1kqYRIcYacT3BYAqI6BIGaN7Oz0xJDDGbN+5mwISh39alHJKDeZMtizj1Py
         TQVybei84eaZ8ARrzmNwwRdCuCCdd4GvfA+lTdRMumom+2NT3s3A08iGOHX7nwjRgh9/
         yT3BO6Ov43TkblxngkQXwH9LYUUXVvoKE47Ff2HoXXiBAK+KAAk2VWuPg13+pXq0WygD
         /3vhejm/mqHJ13hN9XIERWMXC40ZEjI3a4oTOloJIGSnIFcauGN1dcEM9BbrAMN9t9dL
         byGg==
X-Gm-Message-State: AOJu0YyZOpCB97Q8VC8ncWe0QYMADRdZgctqh/fTLdbJSVDUV3lCMjgc
        rcWyZtEHYBU1zbLe3iYJvYXq+GNibl27/XcKtBM=
X-Google-Smtp-Source: AGHT+IEPEq9efvP7oREzzSG4Uxs9Arxz7c1xh/nYDXJ9BAzxvEzuNX7/3BjzkW+UzH8b61eMMjXcNw==
X-Received: by 2002:a05:6358:7e50:b0:168:ec90:95dd with SMTP id p16-20020a0563587e5000b00168ec9095ddmr5606260rwm.26.1699548110880;
        Thu, 09 Nov 2023 08:41:50 -0800 (PST)
Received: from [172.16.32.83] ([198.232.126.202])
        by smtp.gmail.com with ESMTPSA id pz10-20020a05620a640a00b007671678e325sm11313qkn.88.2023.11.09.08.41.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 08:41:50 -0800 (PST)
Message-ID: <c70e31a5-35fa-a6f8-923a-61909e6a1b6b@landley.net>
Date:   Thu, 9 Nov 2023 10:46:40 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 5/5] fix rootfstype=tmpfs
Content-Language: en-US
From:   Rob Landley <rob@landley.net>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
References: <b455394f-9faa-1f1a-f171-0b9d5e9ada35@landley.net>
 <8244c75f-445e-b15b-9dbf-266e7ca666e2@landley.net>
 <f9d57ae7-6dd6-4854-b9cf-1eec4cfa2a92@linux.ibm.com>
 <b74ea810-5b6c-404d-8cee-7d3d3922205e@linux.ibm.com>
 <8f027b47-e778-15fc-0306-a5ae094f1070@landley.net>
In-Reply-To: <8f027b47-e778-15fc-0306-a5ae094f1070@landley.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/23 10:42, Rob Landley wrote:
> On 11/8/23 16:05, Stefan Berger wrote:
>> Can you repost this patch or should I do it?
> 
> They're more likely to listen to you.

P.S. I have a pile of local kernel patches (accidentally attached to the
_previous_ message, but decided this part was not good to post to lkml) that
I've despaired of upstream ever being interested in, and have "rebase/test them
all on 6.6 kernel for the ~dozen architectures I track"
(https://landley.net/bin/mkroot/latest/) as a local todo item I haven't gotten
to yet. It's on the "list of things I feel guilty about not having done yet".
Speaking of which:

Hi Andrew! I'm sorry I didn't reply to your last email on the list (and instead
just blogged about it, https://landley.net/notes-2023.html#24-02-2023 and
blogged about feeling guilty about still having not replied on April 11 and June
25), but is I cc'd the people scripts/get_maintainer.pl said to, and if that's
no longer enough I don't even _pretend_ to understand the process here anymore,
but don't know how to say that without being political.

Take this reposting thing: clearly you HAVE the patch. That's not the issue. And
it's not a The-SCO-Lawsuit-scared-us-by: permission-to-use issue either, because
I posted it to the list with all the paperwork filled out as best I know how,
which I _think_ was recently acknowledged by the person multiple steps up the
chain of the approval process.

I'm _guessing_ the issue here is the need to refile the paperwork to officially
restart a multi-step bureaucratic process, with nothing actually having changed
since last time that I can tell. Possibly just put the expired form back in the
inbox and let literally the same one go through again like a janky dollar bill
scanner.

I'm very bad at sticking the form in the slot and hoping someone will eventually
see it, with the form getting lost vs being denied looking exactly the same for
an indeterminate period of time. I travel to places in person and wait in long
lines and show ID to get to talk to a human where possible. Linux-kernel hasn't
really provided that option for quite a while.

And I didn't want to say _that_ either. It seems impolite. You are full-time
kernel developers, and I am not. I'm not here to criticize your process, I've
just been unable to meaningfully participate in the impersonal bureaucracy it's
become since... I think I gave up in 2017? https://lkml.org/lkml/2017/9/17/1 is
still in my patch list. I'd happily drop it if upstream had fixed it a different
way, but it's been 8 years. That "all bugs are shallow" open source code review
stuff demonstrably stopped working for this project quite some time ago.

Rob
