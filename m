Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1397C7BB1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 04:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjJMCpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 22:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjJMCpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 22:45:21 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B1E83
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 19:44:57 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-406609df1a6so17515985e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 19:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697165096; x=1697769896; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z1lyC0nih0TRN64tEVRuATNQ7XUg5wsUqTB5uQ4du+Y=;
        b=VN78W/Xxgg1DdlKlgRlTw4P40Vdjc4r5RXUOk0b3D/ic8R1dGKBBRQJvtvUZYqgp8X
         yWqShtqeb5JViMRPnHJhmWYpIA1bDYsMqbJtMZls+4cus2Bvi+vKZzlVQ7hQ69iCu6Tf
         wbTKEbxOF4UsaO5/WQG5I8iO4ajH1LmS4XhlrVPauvIuzLJ30+g/y4PDeOQWme7Xc2VA
         Ha8rk9nmVVhYhcLPcEgq1+0f7WzxRxHe6uDkPv/yPgySc00bbBlwsHpopRMqI/RDzp4Z
         pgH0x1wBuUUOMzqyjboVAUuxhAHs4uBT30fKp/2WjjyNAz4h0dE5JnAkD3B5Z5eiHJ4/
         cpPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697165096; x=1697769896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z1lyC0nih0TRN64tEVRuATNQ7XUg5wsUqTB5uQ4du+Y=;
        b=gtPillNxeAlIsGNkQs+3f1xqX55reW5Iyg6HClORA8Wv5YGFZIO3H/X9Dztp9wetqO
         ROkIN5BzHm5vwfTOceNM9bM7z+6zpNJqtXNrq+vIfHJSTBqoXtIjwAbWS/lGrFZBWq2v
         vHejkf81r21g6Aqy2w9LtasIsVdra1vq6A9wOYuGILNIvdU/j9YElJhDIbMNsriMq4uZ
         ftV0n9Z95HwfqdkRoQMzzQRBwnYJbF422vdGn6McyZrkul9tJsnWbUILYss3APjP+4ma
         fDjkgkck5KuOp/CiYaQZULx+QYVEyaGOnn2XgVOAbE5ElG8mDdIjfdwvz3o0M91BAcwp
         CagA==
X-Gm-Message-State: AOJu0Yz3/rhxKKyJPbX6tPQIkzoFtt9fDnAp820+dfhBaeHSSdMEkWyw
        qX6oIxvfnR5ZyuhIeNwr9DIMIURs2vglOvD0UzwDug==
X-Google-Smtp-Source: AGHT+IFPdinKLbIrsWSAo59uFs4LydzQ3vnVtniSmEYxu/qI1CgqO7VuK62PuQ1KxWSv5gdv5NHcLG3lVIvaQ2VfIqo=
X-Received: by 2002:adf:eb0e:0:b0:31f:afeb:4e7e with SMTP id
 s14-20020adfeb0e000000b0031fafeb4e7emr19069138wrn.37.1697165096139; Thu, 12
 Oct 2023 19:44:56 -0700 (PDT)
MIME-Version: 1.0
References: <20231011065446.53034-1-cuiyunhui@bytedance.com> <87sf6gcyb3.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87sf6gcyb3.fsf@email.froward.int.ebiederm.org>
From:   yunhui cui <cuiyunhui@bytedance.com>
Date:   Fri, 13 Oct 2023 10:44:45 +0800
Message-ID: <CAEEQ3wm8oE1dXo7AuU3gY90oF_G21OqNZwnkqhhd1-_j4wWbYQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] pid_ns: support pidns switching between sibling
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     akpm@linux-foundation.org, keescook@chromium.org,
        brauner@kernel.org, jeffxu@google.com, frederic@kernel.org,
        mcgrof@kernel.org, cyphar@cyphar.com, rongtao@cestc.cn,
        linux-kernel@vger.kernel.org,
        Linux Containers <containers@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On Thu, Oct 12, 2023 at 11:31=E2=80=AFAM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> Yunhui Cui <cuiyunhui@bytedance.com> writes:
>
> > In the scenario of container acceleration,
>
> What is container acceleration?
>
> Are you perhaps performing what is essentially checkpoint/restart
> from one set of processes to a new set of processes so you can
> get a container starting faster?
Yeah, you are right .

>
> > when a target pstree is cloned from a temp pstree, we hope that the
> > cloned process is inherently in the target's pid namespace.
>
> I am having a hard time figuring out what you are saying here.

I think I need to describe in detail our needs and problems we face.
What we need to do is fork a container into a new container, which
means that all
processes of the original container need to be forked out and added to
the new container.
Then the forked process needs to be added to the namespace and cgroup
of the new container.

What we are talking about here is the pid namespace.

for example:
Assume that there are three processes A, B, and C in the original container=
.
What we need to do is A fork A_new, B fork B_new, C fork C_new.

However, in the existing pidns implementation, the parent process
first joins pidns, and then
the forked child process will get the new pidns (the pid of the child
process is what we expected),
and the parent process's own pidns has not actually changed (at least
pid is still existing).

To make A_new, B_new, and C_new inherently in the pidns of the new containe=
r,
A, B, and C must first switch to the pidns of the new container, right?
From my understanding there is no better way to implement it.

But the existing implementation (the part to be changed in this patch)
is blocking our progress.

>
> > Examples of what we expected:
> >
> > /* switch to target ns first. */
> > setns(target_ns, CLONE_NEWPID);
>   ^-------- Is this the line that fails for you?
>
> > if(!fork()) {
> > /* Child */
> > ...
> > }
> > /* switch back */
> > setns(temp_ns, CLONE_NEWPID);
>
> Assuming that the "switch back" means returning to your
> task_active_pid_ns that should always work.

In the scenario I described, "switch back" would certainly work.

dst_pidns =3D open("/proc/%d/ns/pid");
src_pidns =3D open("/proc/self/ns/pid");

setns(dst_pidns, CLONE_NEWPID);
if(!fork()) {
/* Child */
/* The child process is born in the pidns of the new container. */
...
}
/* switch back */
setns(src_pidns, CLONE_NEWPID);

>
> If I had to guess I think what you are missing is that entire pid
> namespaces can be inside other pid namespaces.
>
> So there is no reason to believe that any random pid namespace
> that happens to pass the CAP_SYS_ADMIN permission check is also in
> your processes task_active_pid_ns.
>
>
> > However, it is limited by the existing implementation, CAP_SYS_ADMIN
> > has been checked in pidns_install(), so remove the limitation that only
> > by traversing parent can switch pidns.
>
> The check you are deleting is what verifies the pid namespaces you are
> attempting to change pid_ns_for_children to is a member of the tasks
> current pid namespace (aka task_active_pid_ns).
>
>
> There is a perfectly good comment describing why what you are attempting
> to do is unsupportable.
>
>         /*
>          * Only allow entering the current active pid namespace
>          * or a child of the current active pid namespace.
>          *
>          * This is required for fork to return a usable pid value and
>          * this maintains the property that processes and their
>          * children can not escape their current pid namespace.
>          */
>
>
> If you pick a pid namespace that does not meet the restrictions you are
> removing the pid of the new child can not be mapped into the pid
> namespace of the parent that called setns.
>
> AKA the following code can not work.
>
> pid =3D fork();
> if (!pid) {
>         /* child */
>         do_something();
>         _exit(0);
> }
> waitpid(pid);

Sorry, I don't understand what you mean here.

>
>
> So no.  The suggested change to pidns_install makes no sense at all.
>
> The whole not being able to escape your current pid namespace is
> also an important invariant when reasoning about pid namespaces.
>
> It would have to be a strong well thought out case for me to agree
> it makes sense to abandon the invariant that a process can not escape
> it's pid namespace.

I think we'd better have a good understanding of the problems we face first=
,
and then think of a more comprehensive way to solve it.
Although the modification of this patch is not perfect, do we have a better=
 way?


Thanks,
Yunhui
