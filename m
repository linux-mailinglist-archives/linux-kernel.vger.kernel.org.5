Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A907FE463
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 00:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343693AbjK2X6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 18:58:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjK2X6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 18:58:20 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF1312F;
        Wed, 29 Nov 2023 15:58:26 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso308753a12.3;
        Wed, 29 Nov 2023 15:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701302306; x=1701907106; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iHdPtaafU6Wwj9lczBiTyHEzwKcHpmc5GjndOH0Df1k=;
        b=iJQOf7LJDwPVT992bpVFufNyDxO1w9o0BQ+JULpfrlCNjnXc4hZ0c+XKLEbigMUlZ/
         QQRm/PUUEzvPlIk/0dIvmGzbKv18U3YqrMXYrTwt8sqGQ9n98HiGsvbtxyhydeuuXxOt
         BsDVR0TfdKuG6vOLhk20cU5X2UmIstmy/ffxiB4vYE9AuIAnM3YbDgDKIsygm8/KsEz/
         p40k7lOF6sdZNMV/TR0d75NSWLiozLQfp0GGIkGr0Bmtd2a7GVMxJsKqi6l8cg5g8Q8k
         QHLnMX/AI/3BCnm889eSqBlfpw2SUq/MP4OcUv8TqTuBYgpprkww5d6bv9llGQOsIqHS
         zkag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701302306; x=1701907106;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iHdPtaafU6Wwj9lczBiTyHEzwKcHpmc5GjndOH0Df1k=;
        b=lfhXJ/iyCyInoh04GvwqZ1rUNf06q8aIHauVWNEFpO0stphFYsaO19LU8HlaWchZ1B
         O9ah1GTUQPtyT75KqiMg4xwfeXcU25TSANmVCrxgBcVPa+kBXD5CukhbuQ4K4x0ZxASo
         hGAarxrMl1UHdQzUDyvm8hAMvD0jgMk0R2c8Vy00CyEOlsds+1U1mvWHsBP3Q46NHMTe
         GJpsGdso541vePN9WkE8F9qXD6oLxkRCJTjNPGyix5cxO6GN3XNt/MUxo6l6oKLkWe82
         wnVNHnCw/kT+b3A8kZqYabCBUZgh3Li1z7s6RWtZ//90UansEv7h/ZA9eiq+toTRstX+
         WJzQ==
X-Gm-Message-State: AOJu0YwHvKVnQq71PybXasdBRBXXHgsqDdOzCGUxdVU8zifOhbqp3vRY
        dR1DdK32KbNEO5mezVxvYJI=
X-Google-Smtp-Source: AGHT+IE5iVgJ/0wBhz60uoZ7QxT3BbNNUPQ1+4gd8tEvsTb3f+ujTdZ+GhlDvPSj0M1h3g+4MSpSpg==
X-Received: by 2002:a05:6a20:7351:b0:187:eea9:73c5 with SMTP id v17-20020a056a20735100b00187eea973c5mr26200160pzc.3.1701302306082;
        Wed, 29 Nov 2023 15:58:26 -0800 (PST)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id nt9-20020a17090b248900b002802d264240sm2005370pjb.29.2023.11.29.15.58.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 15:58:24 -0800 (PST)
Message-ID: <a4da77c2-7a23-4988-b65a-a58c105d89a4@gmail.com>
Date:   Thu, 30 Nov 2023 06:58:16 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Minor grammatical fixup for livepatch docs
Content-Language: en-US
To:     Joe Lawrence <joe.lawrence@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Livepatching <live-patching@vger.kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Attreyee Mukherjee <tintinm2017@gmail.com>
References: <20231129132527.8078-1-bagasdotme@gmail.com>
 <ac7a90a7-4d29-059b-fbff-6b67e6f5c2d3@redhat.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <ac7a90a7-4d29-059b-fbff-6b67e6f5c2d3@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/23 20:53, Joe Lawrence wrote:
> On 11/29/23 08:25, Bagas Sanjaya wrote:
>> I was prompted to write this little grammar fix series when reading
>> the fix from Attreyee [1], with review comments requesting changes
>> to that fix. So here's my version of the fix, with reviews from [1]
>> addressed (and distinct grammar fixes splitted).
>>
> 
> Typical kernel workflow would be for Attreyee to incorporate feedback
> and post their v2 after a day or two.  From the format they posted, it
> appears to be a first(ish) kernel contribution post.  Let's be kind and
> patient so they we all may benefit from the practice of iterating on
> their patch.
> 

I do this posting because I thought the OP (Attreyee) didn't respond in
timely manner (just like random Chinese contributors like @cdjrlc.com
and @208suo.com people).

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

