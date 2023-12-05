Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA13806145
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 23:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346343AbjLEWDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 17:03:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjLEWDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 17:03:43 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3971C137
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 14:03:49 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-55b5a37acb6so1152061a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 14:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1701813828; x=1702418628; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wzBUASs8pPfv/I/aupn6RulJurEpXssH14Jo91yxznE=;
        b=Y49si3Z7ejmZaeBTbG9/v3b/cPyXwdYt0UiG8aX94+NPqpxaT8VoVErfm+PrgRSZsH
         w2cu97G/plmUiFCzm4/kdnUSKoaad8kXZ5CyqHebLabGVO/XWyyP6/79O+KyocVlvDXH
         W0q9EomiP9Wnx/EpqJVonxzI2Cz2JdJQGGJ8Viou42ryz1BokkpMBnxxPGzaePyIoUEv
         ST9ayZp/M/0lgBj31VPSa1Fco+cGkVXxOVBrWWYOTRuoKjdCwajPbh8Ltl727IjBceiU
         u14xvr0qMZO+UPwL6uS4sVHPlBMjk7FRlgurcZv4CpmS3l2Pffxtyd1IQM8qibn4YIsG
         dsiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701813829; x=1702418629;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wzBUASs8pPfv/I/aupn6RulJurEpXssH14Jo91yxznE=;
        b=PJuf+Zf+EeitHx7XGWdGHMATjWi2SoIBw7vgprXtEb5yu9XZVgQHFqD4aTws1EuPY9
         GGsslenKdrx8gpkjnSkErd3U/WStSQxqyYlMBwkXgy+v0v4Jb3uLP2/HljRPrFWdcR9m
         rzOv/1Z2PQ9YIW/qG4WVUmL3YFCBhfX4jbyKMTeCVoHY17H60saq6HD+u74lMIFsOq3A
         fFU7CD8k0NCM2eo6Ooj4Fch3LpLd0KAEf2aBUlxk/xJbM9BfraNKhiqvNJGZptvcIMor
         IwC55xd9TY/6CYRxT01suAsI5QHgTrrCFlSNdAXxEorngdzW6S/Uwv4j5/uIdklBHivJ
         KdIA==
X-Gm-Message-State: AOJu0YyOc1ibWxdPOYOC2c7xxPh53ynIm/78uvRQ0dr4x7xDIB5fXAuD
        EZrz0byVzyXRHG7seRd0Xyddkw==
X-Google-Smtp-Source: AGHT+IHn86HDzSMhpNhyY9U2scelISrYU4K7J8FgUXKRUsQlnxlxtNMDac6hoQbyov1I7LtoEVcEgQ==
X-Received: by 2002:a17:90a:4bc7:b0:286:f169:79f1 with SMTP id u7-20020a17090a4bc700b00286f16979f1mr1945090pjl.2.1701813828561;
        Tue, 05 Dec 2023 14:03:48 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id q24-20020a170902bd9800b001d1c96a0c63sm190278pls.274.2023.12.05.14.03.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 14:03:48 -0800 (PST)
Message-ID: <3609267c-3fcd-43d6-9b43-9f84bef029a2@kernel.dk>
Date:   Tue, 5 Dec 2023 15:03:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Allow a kthread to declare that it calls
 task_work_run()
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
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
 <fb713388-661a-46e0-8925-6d169b46ff9c@kernel.dk>
In-Reply-To: <fb713388-661a-46e0-8925-6d169b46ff9c@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/23 2:58 PM, Jens Axboe wrote:
> On 12/5/23 2:28 PM, NeilBrown wrote:
>> On Tue, 05 Dec 2023, Christian Brauner wrote:
>>> On Mon, Dec 04, 2023 at 03:09:44PM -0700, Jens Axboe wrote:
>>>> On 12/4/23 2:02 PM, NeilBrown wrote:
>>>>> It isn't clear to me what _GPL is appropriate, but maybe the rules
>>>>> changed since last I looked..... are there rules?
>>>>>
>>>>> My reasoning was that the call is effectively part of the user-space
>>>>> ABI.  A user-space process can call this trivially by invoking any
>>>>> system call.  The user-space ABI is explicitly a boundary which the GPL
>>>>> does not cross.  So it doesn't seem appropriate to prevent non-GPL
>>>>> kernel code from doing something that non-GPL user-space code can
>>>>> trivially do.
>>>>
>>>> By that reasoning, basically everything in the kernel should be non-GPL
>>>> marked. And while task_work can get used by the application, it happens
>>>> only indirectly or implicitly. So I don't think this reasoning is sound
>>>> at all, it's not an exported ABI or API by itself.
>>>>
>>>> For me, the more core of an export it is, the stronger the reason it
>>>> should be GPL. FWIW, I don't think exporting task_work functionality is
> 
>>>
>>> Yeah, I'm not too fond of that part as well. I don't think we want to
>>> give modules the ability to mess with task work. This is just asking for
>>> trouble.
>>>
>>
>> Ok, maybe we need to reframe the problem then.
>>
>> Currently fput(), and hence filp_close(), take control away from kernel
>> threads in that they cannot be sure that a "close" has actually
>> completed.
>>
>> This is already a problem for nfsd.  When renaming a file, nfsd needs to
>> ensure any cached "open" that it has on the file is closed (else when
>> re-exporting an NFS filesystem it can result in a silly-rename).
>>
>> nfsd currently handles this case by calling flush_delayed_fput().  I
>> suspect you are no more happy about exporting that than you are about
>> exporting task_work_run(), but this solution isn't actually 100%
>> reliable.  If some other thread calls flush_delayed_fput() between nfsd
>> calling filp_close() and that same nfsd calling flush_delayed_fput(),
>> then the second flush can return before the first flush (in the other
>> thread) completes all the work it took on.
>>
>> What we really need - both for handling renames and for avoiding
>> possible memory exhaustion - is for nfsd to be able to reliably wait for
>> any fput() that it initiated to complete.
>>
>> How would you like the VFS to provide that service?
> 
> Since task_work happens in the context of your task already, why not
> just have a way to get it stashed into a list when final fput is done?
> This avoids all of this "let's expose task_work" and using the task list
> for that, which seems kind of pointless as you're just going to run it
> later on manually anyway.
> 
> In semi pseudo code:
> 
> bool fput_put_ref(struct file *file)
> {
> 	return atomic_dec_and_test(&file->f_count);
> }
> 
> void fput(struct file *file)
> {
> 	if (fput_put_ref(file)) {
> 		...
> 	}
> }
> 
> and then your nfsd_file_free() could do:
> 
> ret = filp_flush(file, id);
> if (fput_put_ref(file))
> 	llist_add(&file->f_llist, &l->to_free_llist);
> 
> or something like that, where l->to_free_llist is where ever you'd
> otherwise punt the actual freeing to.

Should probably have the put_ref or whatever helper also init the
task_work, and then reuse the list in the callback_head there. Then
whoever flushes it has to call ->func() and avoid exposing ____fput() to
random users. But you get the idea.

-- 
Jens Axboe

