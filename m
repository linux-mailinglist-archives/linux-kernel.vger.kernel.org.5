Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75CA4804157
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 23:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbjLDWJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 17:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjLDWJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 17:09:43 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09FFFF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 14:09:49 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5c6910e93e3so123342a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 14:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1701727789; x=1702332589; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N7YVZRS1Yk2p3iV3hbb4MrgXwpXbi4TeT5VGkU/u+Jk=;
        b=KqMZiWIu6Huk1KRv62/VLR70dCPjpFds0G8v2g0RW8hC/DSworJnr6ZLlYFO2j3c88
         hYt0tr1acI6wUHCWFiu7iY1jpRvkg1u8+yu9FZd5fuC8Zf+jlvjquBCuceBwUmcx8e6C
         tQxq1a6mza04HO9xXTeS620tIojtLyJHI29WYy2ChNCSz01NTw+772Nd0CqqV+eXo5/v
         WPYcaPYgTu3/7VJW0ooRbRSH56JUPEQLJeN/ZqZ2X8+G/ImlxtpTe2tJ/rKD6wGGTPU/
         MqFenhCRgBmedtBNgv8emQ5Tjr/YO+/jCl1UcYKdG7J4J/STnzMJ0jN25nDqFX/C4VI/
         Xz1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701727789; x=1702332589;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N7YVZRS1Yk2p3iV3hbb4MrgXwpXbi4TeT5VGkU/u+Jk=;
        b=izBv6GPcvYq8M0o0YkSEqZGMQly6ejSNHmXizYPS9X41GPJtCLw7T52itAxilpUGmz
         5hgvFY9ETLdiwsI1UaRnZEhviEPor6v+9sLWKzDG2p+wJk4z5OcPxffR5tmmsM9mOWtK
         yD+/cx8GVedZQ7PvW3im+X+E0JNk5uOveeAJQQLsHqR6P2yiS9e3IZAFWUMCFrycSXHy
         ubVk0qxeIib8gGtMSlSMgRaosxKA5n6uttgV1NtW69Jt94KOShuPtgRSeBgKL83XQGu8
         b28W6SctZ20WWYJXeAFd+osWiLpds1hN8FsHNLnvmpqvOWijoPJ1rrfdpKdoOvjHO9At
         xLrg==
X-Gm-Message-State: AOJu0YwhHUQBGDbw7ENNHENRNUM3jYZeDz8ZXH+BGEOo8ri4zAT4Tipz
        zOSRbYpvjcJNbu8EuunAq7mEDg==
X-Google-Smtp-Source: AGHT+IHDv1b42RKXKN4tRifZv0mEX5EckA+D3oEFHeJfjju4L9UJaftPOWecVThY8YBY1KMQIFUJ4A==
X-Received: by 2002:a17:903:234a:b0:1d0:b693:ae30 with SMTP id c10-20020a170903234a00b001d0b693ae30mr2493966plh.6.1701727789078;
        Mon, 04 Dec 2023 14:09:49 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id t4-20020a170902bc4400b001bf11cf2e21sm5844131plz.210.2023.12.04.14.09.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 14:09:46 -0800 (PST)
Message-ID: <a070b6bd-0092-405e-99d2-00002596c0bc@kernel.dk>
Date:   Mon, 4 Dec 2023 15:09:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Allow a kthread to declare that it calls
 task_work_run()
Content-Language: en-US
To:     NeilBrown <neilb@suse.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
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
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <170172377302.7109.11739406555273171485@noble.neil.brown.name>
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

On 12/4/23 2:02 PM, NeilBrown wrote:
> It isn't clear to me what _GPL is appropriate, but maybe the rules
> changed since last I looked..... are there rules?
> 
> My reasoning was that the call is effectively part of the user-space
> ABI.  A user-space process can call this trivially by invoking any
> system call.  The user-space ABI is explicitly a boundary which the GPL
> does not cross.  So it doesn't seem appropriate to prevent non-GPL
> kernel code from doing something that non-GPL user-space code can
> trivially do.

By that reasoning, basically everything in the kernel should be non-GPL
marked. And while task_work can get used by the application, it happens
only indirectly or implicitly. So I don't think this reasoning is sound
at all, it's not an exported ABI or API by itself.

For me, the more core of an export it is, the stronger the reason it
should be GPL. FWIW, I don't think exporting task_work functionality is
a good idea in the first place, but if there's a strong reason to do so,
it should most certainly not be accessible to non-GPL modules. Basically
NO new export should be non-GPL.

-- 
Jens Axboe

