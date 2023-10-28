Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7457DA6E4
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 14:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjJ1MV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 08:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjJ1MVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 08:21:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0528ED
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 05:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698495636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aY/L9HTCAfBjIm3433sSzOmJ5GhpAINzTj4Ry4zadik=;
        b=OqWqjujdumtvjTy4kDGyMM57oyw9Wzi33IXYH4D/W3i6xyx5e53s68Gyl6LbrexbDWi5+6
        GDgmlxi/G3YUVwoyWuXWpR7mworKMvFgqvQZ/StuU3w0ZXlhgGbsJcC4vasTaMnjZ2iinS
        PTHJUdE8nhg/L0wH8mqKvZ/SMlb3R9s=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-1PSffnloOdaobooWtUlnrw-1; Sat, 28 Oct 2023 08:20:35 -0400
X-MC-Unique: 1PSffnloOdaobooWtUlnrw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-313c930ee0eso1480942f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 05:20:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698495634; x=1699100434;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aY/L9HTCAfBjIm3433sSzOmJ5GhpAINzTj4Ry4zadik=;
        b=FazlMduLqs39ySnvsMmx/TjMK47v/rlA50V4OjeNhZr2Nx/SeG0NsptLPtuYTthln1
         CMLao5kiih7ufHqCbxkmLuE0DndFWKstwBYeKp+LPioWN0ly/8SctCTK0QpV188Jp38Y
         WQrjxHx9gLyYu6D8/Xjd1ejWUub9LyKJIpUjdRN2z+uUahkMbpzkt42d9nlIz6dROYp1
         6NBILQgZUb5h0LZLjXcw/TnT+/SAts8eprRujbNbJt69yijA2gmfDLS7+BD04sXFjfnf
         WpjojNAcQGI4Iri/jP+kBp80ncvFZWCIZ4huO9qGDGM18pkh5q0FnscpTeOV9H9wPTK3
         Q7VA==
X-Gm-Message-State: AOJu0Yxdvc3ZMZC79Dc8o4Nn35t+K3x9JBdpLHZZzEv4rRVQ9myFkpzX
        j6uctZwrR9x3FESCUEROfxbQ+T2Z8+cRFMuUBFeizxAqEHGem+fqDmv1FEIax2kafaH1qZ3jkMs
        mwTLUnrmMmL3+zafIUHsof86p
X-Received: by 2002:adf:fd82:0:b0:32d:9a87:b7a with SMTP id d2-20020adffd82000000b0032d9a870b7amr3282947wrr.50.1698495634012;
        Sat, 28 Oct 2023 05:20:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF80KLaWzeWd6XMuxQiL/btLDTUqSjzy0ssxvalh3/0LkuhTt1W/o+9toYfvqCLPckxhP5Ncg==
X-Received: by 2002:adf:fd82:0:b0:32d:9a87:b7a with SMTP id d2-20020adffd82000000b0032d9a870b7amr3282929wrr.50.1698495633646;
        Sat, 28 Oct 2023 05:20:33 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
        by smtp.gmail.com with ESMTPSA id n4-20020a5d4844000000b0032d2f09d991sm3748918wrs.33.2023.10.28.05.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 05:20:32 -0700 (PDT)
Date:   Sat, 28 Oct 2023 08:20:30 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Abhinav Singh <singhabhinav9051571833@gmail.com>
Cc:     akpm@linux-foundation.org, brauner@kernel.org, surenb@google.com,
        michael.christie@oracle.com, mathieu.desnoyers@efficios.com,
        mjguzik@gmail.com, npiggin@gmail.com, shakeelb@google.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v3] Fixing directly deferencing a __rcu pointer warning
Message-ID: <20231028081915-mutt-send-email-mst@kernel.org>
References: <20231027122221.GA24128@redhat.com>
 <20231028102247.404488-1-singhabhinav9051571833@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231028102247.404488-1-singhabhinav9051571833@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 28, 2023 at 03:52:47PM +0530, Abhinav Singh wrote:
> This patch fixes the warning about directly dereferencing a pointer
> tagged with __rcu annotation.
> 
> Dereferencing the pointers tagged with __rcu directly should
> always be avoided according to the docs. There is a rcu helper
> function rcu_dereference(...) to use when dereferencing a __rcu
> pointer. This function returns the non __rcu tagged pointer which
> can be dereferenced just like a normal pointer.
> 
> Signed-off-by: Abhinav Singh <singhabhinav9051571833@gmail.com>
> ---
> v1 -> v2 : added rcu_dereference(...) at line 2694
> v2 -> v3 : added rcu_dereference(...) at line 2695
> 
>  kernel/fork.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 10917c3e1f03..e78649974669 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2369,7 +2369,7 @@ __latent_entropy struct task_struct *copy_process(
>  
>  	retval = -EAGAIN;
>  	if (is_rlimit_overlimit(task_ucounts(p), UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC))) {
> -		if (p->real_cred->user != INIT_USER &&
> +		if (rcu_dereference(p->real_cred)->user != INIT_USER &&
>  		    !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN))
>  			goto bad_fork_cleanup_count;
>  	}
> @@ -2690,9 +2690,9 @@ __latent_entropy struct task_struct *copy_process(
>  			 * tasklist_lock with adding child to the process tree
>  			 * for propagate_has_child_subreaper optimization.
>  			 */
> -			p->signal->has_child_subreaper = p->real_parent->signal->has_child_subreaper ||
> -							 p->real_parent->signal->is_child_subreaper;
> -			list_add_tail(&p->sibling, &p->real_parent->children);
> +			p->signal->has_child_subreaper = rcu_dereference(p->real_parent)->signal->has_child_subreaper ||
> +							rcu_dereference(p->real_parent)->signal->is_child_subreaper;
> +			list_add_tail(&p->sibling, &rcu_dereference(p->real_parent)->children);
>  			list_add_tail_rcu(&p->tasks, &init_task.tasks);
>  			attach_pid(p, PIDTYPE_TGID);
>  			attach_pid(p, PIDTYPE_PGID);
> -- 
> 2.39.2


You seem to just ignore review comments. NAK. I'm not going to review this anymore.


-- 
MST

