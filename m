Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD99E806126
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 22:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346285AbjLEV6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 16:58:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjLEV6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 16:58:43 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6D411F
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 13:58:49 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6ce6f4d3dafso196090b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 13:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1701813529; x=1702418329; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LGvf0v3WO1jMmuVd3YQ6/5GaYR43CazhfwAsFHfc+Ck=;
        b=f4S4a9eZ4yRnQE+c/EYEZft+z5LwGHOMtwil4SftE9bKXVjoxszmqe0DyV3iZm1vjo
         tMIyEL5XRODyVrQ5kYoA6+Q2ygLf1i0UmwwNae/gUywStyqlJAmB7mwKsDVdkAwNGBD9
         p0NUkvkrOj8aPkfQDXZ4eTusE987yRTOkZGDRysZAmWGP2FxbnZue0DVX/5Ey62c08Y1
         dAO3AsO8Fk4FfE+nJKLLSol/XwAJr+4RIVck0p08z2QkNlF/a5SpJ1BVt5Q18JFqBZcl
         dchpBAwLWHqLEGn9XuI4ILb88hEANmvkNXgNg31I6eVMl6IrvruWLziC2GyL2NawVc7Z
         ajeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701813529; x=1702418329;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LGvf0v3WO1jMmuVd3YQ6/5GaYR43CazhfwAsFHfc+Ck=;
        b=mGhLam+zkn8u26So+AoS39DjPni5rx3DXiToPieH/o5KxODfK9qBB3C6HrjVSAqzRV
         5Fd6nscJzPhnekMiXjhF5N9V2qz+/K3JppECczTSkFoMJMsk+mGPED/Q3rd6jpvMdM5X
         9QqREtRVoqGyiHGwdz5cAjo2TOY4gVO6mfgrWwOFxw1Ub3/BtCtSXIt+bUbvWxpqvqKP
         Hszmr464ln+7Nr2F2SZIfFWHtskXCcGyRoUJFveDrNfcBWWeF+TSl7NnZ0PauFeMBWXy
         /KaUNrVSESKqRlD1umgdNQ60l8n8RjdZpuXJC+IO10/SK2l4yT7Vzg2kLtYReA7q6COx
         CRrw==
X-Gm-Message-State: AOJu0YyOZoscHuB4YmH8ukN2fBOT+AwBZ2ebT6c47Htu3PeR4154QOZB
        WpOKJ5BmLMp+uRNTtxENByb3Yg==
X-Google-Smtp-Source: AGHT+IGzPTTW74AHvrXhGeY2ZDF1XGD7k+iKI5ldfYRplCp96c8z1TYYf/Vu3DKKXnbWDhDWGuE0MA==
X-Received: by 2002:aa7:88c6:0:b0:6ce:4c49:58e4 with SMTP id k6-20020aa788c6000000b006ce4c4958e4mr8822580pff.0.1701813529029;
        Tue, 05 Dec 2023 13:58:49 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id v14-20020aa7850e000000b006cde2889213sm1323983pfn.14.2023.12.05.13.58.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 13:58:48 -0800 (PST)
Message-ID: <fb713388-661a-46e0-8925-6d169b46ff9c@kernel.dk>
Date:   Tue, 5 Dec 2023 14:58:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Allow a kthread to declare that it calls
 task_work_run()
Content-Language: en-US
To:     NeilBrown <neilb@suse.de>, Christian Brauner <brauner@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org
References: <20231204014042.6754-1-neilb@suse.de>
 <20231204014042.6754-2-neilb@suse.de>
 <e9a1cfed-42e9-4174-bbb3-1a3680cf6a5c@kernel.dk>
 <170172377302.7109.11739406555273171485@noble.neil.brown.name>
 <a070b6bd-0092-405e-99d2-00002596c0bc@kernel.dk>
 <20231205-altbacken-umbesetzen-e5c0c021ab98@brauner>
 <170181169515.7109.11121482729257102758@noble.neil.brown.name>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <170181169515.7109.11121482729257102758@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/23 2:28 PM, NeilBrown wrote:
> On Tue, 05 Dec 2023, Christian Brauner wrote:
>> On Mon, Dec 04, 2023 at 03:09:44PM -0700, Jens Axboe wrote:
>>> On 12/4/23 2:02 PM, NeilBrown wrote:
>>>> It isn't clear to me what _GPL is appropriate, but maybe the rules
>>>> changed since last I looked..... are there rules?
>>>>
>>>> My reasoning was that the call is effectively part of the user-space
>>>> ABI.  A user-space process can call this trivially by invoking any
>>>> system call.  The user-space ABI is explicitly a boundary which the GPL
>>>> does not cross.  So it doesn't seem appropriate to prevent non-GPL
>>>> kernel code from doing something that non-GPL user-space code can
>>>> trivially do.
>>>
>>> By that reasoning, basically everything in the kernel should be non-GPL
>>> marked. And while task_work can get used by the application, it happens
>>> only indirectly or implicitly. So I don't think this reasoning is sound
>>> at all, it's not an exported ABI or API by itself.
>>>
>>> For me, the more core of an export it is, the stronger the reason it
>>> should be GPL. FWIW, I don't think exporting task_work functionality is

>>
>> Yeah, I'm not too fond of that part as well. I don't think we want to
>> give modules the ability to mess with task work. This is just asking for
>> trouble.
>>
> 
> Ok, maybe we need to reframe the problem then.
> 
> Currently fput(), and hence filp_close(), take control away from kernel
> threads in that they cannot be sure that a "close" has actually
> completed.
> 
> This is already a problem for nfsd.  When renaming a file, nfsd needs to
> ensure any cached "open" that it has on the file is closed (else when
> re-exporting an NFS filesystem it can result in a silly-rename).
> 
> nfsd currently handles this case by calling flush_delayed_fput().  I
> suspect you are no more happy about exporting that than you are about
> exporting task_work_run(), but this solution isn't actually 100%
> reliable.  If some other thread calls flush_delayed_fput() between nfsd
> calling filp_close() and that same nfsd calling flush_delayed_fput(),
> then the second flush can return before the first flush (in the other
> thread) completes all the work it took on.
> 
> What we really need - both for handling renames and for avoiding
> possible memory exhaustion - is for nfsd to be able to reliably wait for
> any fput() that it initiated to complete.
> 
> How would you like the VFS to provide that service?

Since task_work happens in the context of your task already, why not
just have a way to get it stashed into a list when final fput is done?
This avoids all of this "let's expose task_work" and using the task list
for that, which seems kind of pointless as you're just going to run it
later on manually anyway.

In semi pseudo code:

bool fput_put_ref(struct file *file)
{
	return atomic_dec_and_test(&file->f_count);
}

void fput(struct file *file)
{
	if (fput_put_ref(file)) {
		...
	}
}

and then your nfsd_file_free() could do:

ret = filp_flush(file, id);
if (fput_put_ref(file))
	llist_add(&file->f_llist, &l->to_free_llist);

or something like that, where l->to_free_llist is where ever you'd
otherwise punt the actual freeing to.

-- 
Jens Axboe

