Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D7D806300
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 00:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346625AbjLEXbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 18:31:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjLEXbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 18:31:49 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE0AAC
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 15:31:54 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1d072f50a44so10517155ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 15:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1701819114; x=1702423914; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GAuNND0g/9eq4B5EDzN4ZKY35dKDuv5qUOIhXWsNyF0=;
        b=nEf2EWYDT6mQpmOLTe14rEntc37xK6hammx3cI0I5a3h9/ob7d8jR3QJciZ4nb0Cad
         xldNImqKvjqgdtnF5PrHWH/c8M98FHy42lss5ZO7V5vrjKnZHPknHOZ8x0yCjbOmU9gR
         Gon/aB3zQ3HigMdp6Nhw7EYUEP2rjFj98QxP+iFCrqj1jW9HDiwJEy1IA3MA6maIeVvo
         eiper6wkWh2FHU3pih3YogWC01yL6oP55oRGsetWn4AW5Sf+U+YOjGuJ69iQQ/nWbYhy
         Oe9+ofQC70c1YsESqBkMR6Ux7wLTChG1VGJQ+CkaJckIGqryLgH5gWJO9rhLn9+gbBEI
         jE1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701819114; x=1702423914;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GAuNND0g/9eq4B5EDzN4ZKY35dKDuv5qUOIhXWsNyF0=;
        b=QG75Ts5Fvq4F3f7NN4kmyN+ARpiWNnRhl3bRBvDGLh+bmYsoidi8HCg0rqoK45vHLM
         HQlWw8cDk5bvEtKWF3kvks7iwXQ/q9eE6UKES+WilnXkek9O4oR/4ilQlJisEq0x9NuG
         sawcjsEH0ijQgSmlZr6ypZKmxvN5bPkzYy50D9KQSrv3Np1CTx8huZ6VjMC38FnHOali
         REh4+f0dx2DYIq2P1IOTkP4MotNhtt6v+H5sxv0b6Rw6TzEu5UHsPCyDV9KccuYaLx7G
         NtgyO1/05KJiuN3UZ8g6eHF28JkvcPhaMktiXXU2sW3S4cs+Q4GLDW67VexicoCXL+b6
         N8ig==
X-Gm-Message-State: AOJu0YxlcUx6IiZxTOK7F+5ZFiObCV7TyhKm/ikSGrUW99AllYgC0W9b
        fYlwkxOtd1aN2MFEHfp19ZmZ7w==
X-Google-Smtp-Source: AGHT+IFnH2qObtnOxp3WY56L+gwQDMSkV/gvBUkD7kpUbHNjnORjn82Z2Q+vt61fO5zs7but4wrUoQ==
X-Received: by 2002:a17:903:234a:b0:1d0:b693:ae30 with SMTP id c10-20020a170903234a00b001d0b693ae30mr5886229plh.6.1701819114055;
        Tue, 05 Dec 2023 15:31:54 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id 20-20020a170902c25400b001cfc170c0cfsm6950144plg.119.2023.12.05.15.31.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 15:31:53 -0800 (PST)
Message-ID: <c24af958-b933-42dd-9806-9d288463547b@kernel.dk>
Date:   Tue, 5 Dec 2023 16:31:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Allow a kthread to declare that it calls
 task_work_run()
Content-Language: en-US
To:     NeilBrown <neilb@suse.de>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Oleg Nesterov <oleg@redhat.com>,
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
 <fb713388-661a-46e0-8925-6d169b46ff9c@kernel.dk>
 <3609267c-3fcd-43d6-9b43-9f84bef029a2@kernel.dk>
 <170181458198.7109.790647899711986334@noble.neil.brown.name>
 <170181861776.7109.6396373836638614121@noble.neil.brown.name>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <170181861776.7109.6396373836638614121@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/23 4:23 PM, NeilBrown wrote:
> On Wed, 06 Dec 2023, NeilBrown wrote:
>> On Wed, 06 Dec 2023, Jens Axboe wrote:
>>> On 12/5/23 2:58 PM, Jens Axboe wrote:
>>>> On 12/5/23 2:28 PM, NeilBrown wrote:
>>>>> On Tue, 05 Dec 2023, Christian Brauner wrote:
>>>>>> On Mon, Dec 04, 2023 at 03:09:44PM -0700, Jens Axboe wrote:
>>>>>>> On 12/4/23 2:02 PM, NeilBrown wrote:
>>>>>>>> It isn't clear to me what _GPL is appropriate, but maybe the rules
>>>>>>>> changed since last I looked..... are there rules?
>>>>>>>>
>>>>>>>> My reasoning was that the call is effectively part of the user-space
>>>>>>>> ABI.  A user-space process can call this trivially by invoking any
>>>>>>>> system call.  The user-space ABI is explicitly a boundary which the GPL
>>>>>>>> does not cross.  So it doesn't seem appropriate to prevent non-GPL
>>>>>>>> kernel code from doing something that non-GPL user-space code can
>>>>>>>> trivially do.
>>>>>>>
>>>>>>> By that reasoning, basically everything in the kernel should be non-GPL
>>>>>>> marked. And while task_work can get used by the application, it happens
>>>>>>> only indirectly or implicitly. So I don't think this reasoning is sound
>>>>>>> at all, it's not an exported ABI or API by itself.
>>>>>>>
>>>>>>> For me, the more core of an export it is, the stronger the reason it
>>>>>>> should be GPL. FWIW, I don't think exporting task_work functionality is
>>>>
>>>>>>
>>>>>> Yeah, I'm not too fond of that part as well. I don't think we want to
>>>>>> give modules the ability to mess with task work. This is just asking for
>>>>>> trouble.
>>>>>>
>>>>>
>>>>> Ok, maybe we need to reframe the problem then.
>>>>>
>>>>> Currently fput(), and hence filp_close(), take control away from kernel
>>>>> threads in that they cannot be sure that a "close" has actually
>>>>> completed.
>>>>>
>>>>> This is already a problem for nfsd.  When renaming a file, nfsd needs to
>>>>> ensure any cached "open" that it has on the file is closed (else when
>>>>> re-exporting an NFS filesystem it can result in a silly-rename).
>>>>>
>>>>> nfsd currently handles this case by calling flush_delayed_fput().  I
>>>>> suspect you are no more happy about exporting that than you are about
>>>>> exporting task_work_run(), but this solution isn't actually 100%
>>>>> reliable.  If some other thread calls flush_delayed_fput() between nfsd
>>>>> calling filp_close() and that same nfsd calling flush_delayed_fput(),
>>>>> then the second flush can return before the first flush (in the other
>>>>> thread) completes all the work it took on.
>>>>>
>>>>> What we really need - both for handling renames and for avoiding
>>>>> possible memory exhaustion - is for nfsd to be able to reliably wait for
>>>>> any fput() that it initiated to complete.
>>>>>
>>>>> How would you like the VFS to provide that service?
>>>>
>>>> Since task_work happens in the context of your task already, why not
>>>> just have a way to get it stashed into a list when final fput is done?
>>>> This avoids all of this "let's expose task_work" and using the task list
>>>> for that, which seems kind of pointless as you're just going to run it
>>>> later on manually anyway.
>>>>
>>>> In semi pseudo code:
>>>>
>>>> bool fput_put_ref(struct file *file)
>>>> {
>>>> 	return atomic_dec_and_test(&file->f_count);
>>>> }
>>>>
>>>> void fput(struct file *file)
>>>> {
>>>> 	if (fput_put_ref(file)) {
>>>> 		...
>>>> 	}
>>>> }
>>>>
>>>> and then your nfsd_file_free() could do:
>>>>
>>>> ret = filp_flush(file, id);
>>>> if (fput_put_ref(file))
>>>> 	llist_add(&file->f_llist, &l->to_free_llist);
>>>>
>>>> or something like that, where l->to_free_llist is where ever you'd
>>>> otherwise punt the actual freeing to.
>>>
>>> Should probably have the put_ref or whatever helper also init the
>>> task_work, and then reuse the list in the callback_head there. Then
>>> whoever flushes it has to call ->func() and avoid exposing ____fput() to
>>> random users. But you get the idea.
>>
>> Interesting ideas - thanks.
>>
>> So maybe the new API would be
>>
>>  fput_queued(struct file *f, struct llist_head *q)
>> and
>>  flush_fput_queue(struct llist_head *q)
>>
>> with the meaning being that fput_queued() is just like fput() except
>> that any file needing __fput() is added to the 'q'; and that
>> flush_fput_queue() calls __fput() on any files in 'q'.
>>
>> So to close a file nfsd would:
>>
>>   fget(f);
>>   flip_close(f);
>>   fput_queued(f, &my_queue);
>>
>> though possibly we could have a
>>   filp_close_queued(f, q)
>> as well.
>>
>> I'll try that out - but am happy to hear alternate suggestions for names :-)
>>
> 
> Actually ....  I'm beginning to wonder if we should just use
> __fput_sync() in nfsd.
> It has a big warning about not doing that blindly, but the detail in the
> warning doesn't seem to apply to nfsd...

If you can do it from the context where you do the filp_close() right
now, then yeah there's no reason to over-complicate this at all... FWIW,
the reason task_work exists is just to ensure a clean context to perform
these operations from the task itself. The more I think about it, it
doesn't make a lot of sense to utilize it for this purpose, which is
where my alternate suggestion came from. But if you can just call it
directly, then that makes everything much easier.

-- 
Jens Axboe

