Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B037CB473
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 22:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234118AbjJPURD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 16:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbjJPURB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 16:17:01 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A46AD9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 13:16:58 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d9a518d66a1so5863944276.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 13:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1697487418; x=1698092218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pRkuXD5R9s8GqVXIff9E+DcOiCuJck3NIMNloThI9eU=;
        b=VepErQtqSJUpTI4Bo7v/zDu0GpxSE2dH0yvlDfG3UWqD1k1t1JtnoiB63c1rZHBfr7
         awmrqmXtgKShfGUC9DYBmk/yqbOZHqPRYeS4VEAGEPCQmblLIAydp1JIdLrY2OqOUx1y
         nEpB0HDmNA7yhhfB0H92WxyXg3TOl3oIn7GQ5aKWBUqDLC58h6Do1Pu75VuEKa+0GhG5
         +gYGfEc2NlZYz6dqnWMeH+r3X0JaGuhNBnUaQVi/riuhdHBAW0Kv+GlL6xowks88BD0d
         23dlUyMkBD1TLiUdNRkCb/XIv+LaAmQquEnN/rUZAxwnhH7B20gbwEr4bsoL02nZIr7a
         1YpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697487418; x=1698092218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pRkuXD5R9s8GqVXIff9E+DcOiCuJck3NIMNloThI9eU=;
        b=eI/awGiVEojy05jwYqzhRt+LYBqZ35hydM8u1WMSolp3t4S37kEKgRaS9lymXGCuy0
         cHoGILxyoDOCS19m2kznYy0V/9toH9vSa3Q+7+h288nRnonESb3vdOlILJBzUnoCLBYy
         BKFbXwEdZy2XtkPyO1LDx1QAkGd8Pt8HMJlb8DvKAlahG0xAUun3QnAl1InDxCTMgLsb
         qfoGIVv/Rf392sTvz5tf1e6bJWfCgr5kzS4b4J+46yPfPaNcx5JP/fz8EcLvTkycHBX7
         c8HL9UZR+chUgVfR8pzdIa+H5LNevTIEUoTbDgkEEIwgOYvlLbbeRzFi+jFisggbk0pm
         rg5Q==
X-Gm-Message-State: AOJu0Yz112wacax3PKPXLRz8IaNtl4rKZWYE/U1vhMekFmkmZ0pEm2Jc
        Q+9kOujdvGOdRBHD1umoAwn9HMjb59G3q6SBs4Wv
X-Google-Smtp-Source: AGHT+IF7JWSRslIBMvEAYeTbSVc7zaoKCJJopAV1HSYdXjgciJjvn8gbxAZ+GxW1kgtTp2RK24/dHOtHKomjJ4UpX10=
X-Received: by 2002:a25:2393:0:b0:d9b:ff50:b100 with SMTP id
 j141-20020a252393000000b00d9bff50b100mr103956ybj.28.1697487417608; Mon, 16
 Oct 2023 13:16:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230922152749.244197-1-chris.riches@nutanix.com>
 <CAHC9VhTEUybqU3Bv51oLgCWLOjsFQBwzXONwXERPuM1U+vhmFQ@mail.gmail.com> <33830e43-00e6-4be1-855e-339d3e74a8bc@nutanix.com>
In-Reply-To: <33830e43-00e6-4be1-855e-339d3e74a8bc@nutanix.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 16 Oct 2023 16:16:46 -0400
Message-ID: <CAHC9VhSbfCKxJM=+mKGCQJNjtL8JuwZ5-mSCLCSvkkUEJywOkQ@mail.gmail.com>
Subject: Re: [RFC PATCH] audit: Send netlink ACK before setting connection in auditd_set
To:     Chris Riches <chris.riches@nutanix.com>
Cc:     audit@vger.kernel.org, Eric Paris <eparis@redhat.com>,
        jonathan.davies@nutanix.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 1:12=E2=80=AFPM Chris Riches <chris.riches@nutanix.=
com> wrote:
>

Thanks for trimming the email in your reply, however, it is helpful to
preserve those "On Mon, Oct ..." headers for those emails which you
include in your reply, it helps keep things straight when reading the
email.  Not a big deal, just something to keep in mind for next time.

>  > I think the basic approach is good, but I think we can simply things
>  > slightly by using a resettable boolean as opposed to an integer flag
>  > for the ACK.  I've pasted in a quick, untested patch (below) to better
>  > demonstrate the idea, let me know what you think.
>
> The simplified patch doesn't look quite right. I had some trouble
> getting it to apply (seems tabs were changed into spaces, even when I
> downloaded the raw email).

I should have been more clear, that's what just a quick hack that I
cut-n-pasted into the email body, whitespace damage was a given.
Typically if I include a patch with the qualification that it is
untested, you can expect problems :) but I'll try to make the pitfalls
more explicit in the future.

I usually include these hacky patches simply as a way to help clear up
any misunderstandings that might happen when trying to explain an
approach using English descriptions.  Much in the same way we say that
a picture is worth a thousand words, I believe a patch, even a
relatively crude one, is worth at least as many words as a picture :)

> While typing it out manually, I noticed that
> the condition for sending the ACK isn't correct - if NLM_F_ACK is 0 to
> begin with, then ack will be false to begin with, and so no ACK will be
> sent even if there is an error.

Good point.  I'll just casually remind you that I did say "untested" ;)

I believe the following should work as intended (untested, cut-n-paste, etc=
.):

@@ -1538,9 +1551,10 @@ static int audit_receive_msg(struct sk_buff *skb, st=
ruct
nlmsghdr *nlh)
 * Parse the provided skb and deal with any messages that may be present,
 * malformed skbs are discarded.
 */
-static void audit_receive(struct sk_buff  *skb)
+static void audit_receive(struct sk_buff *skb)
{
       struct nlmsghdr *nlh;
+       bool ack;
       /*
        * len MUST be signed for nlmsg_next to be able to dec it below 0
        * if the nlmsg_len was not aligned
@@ -1553,9 +1567,13 @@ static void audit_receive(struct sk_buff  *skb)

       audit_ctl_lock();
       while (nlmsg_ok(nlh, len)) {
-               err =3D audit_receive_msg(skb, nlh);
-               /* if err or if this message says it wants a response */
-               if (err || (nlh->nlmsg_flags & NLM_F_ACK))
+               ack =3D true;
+               err =3D audit_receive_msg(skb, nlh, &ack);
+
+               /* if audit_receive_msg() clears @ack then we never want to
+                * send an ack here, otherwise send an ack on error or if
+                * requested */
+               if (ack && (err || (nlh->nlmsg_flags & NLM_F_ACK)))
                       netlink_ack(skb, nlh, err, NULL);

> Handling this case is why I used the
> three-state system to begin with. I think we could still use a boolean
> with a condition of just (err || ack), with the caveat that we wouldn't
> easily be able to send an early ACK on an error (not that the current
> patch needs this - just thinking of reusability).

While there may be three states (never ACK, ACK on error, always ACK),
the audit_receive_msg() function only needs to report back one of two
states: never ACK or ACK if desired.

>  > Regardless of any other issues, I think you brought up a good point
>  > about there being socket buffer contention when the queues are
>  > full(ish) and an audit daemon connects to the kernel and while I'm not
>  > sure that this patch will fully resolve that issue, I do think it
>  > would be good to have (I'm doubtful if it can be fully resolved
>  > without some really awful hacks).
>
> That roughly lines up with what I was seeing - could you elaborate any
> further on what "awful hacks" would be needed to fully resolve this?

I'm not sure I can recall everything from when I was thinking about
this previously (that was about a week ago), but my quick thoughts
right now are that you would need a lot more information and/or
handshakes between the kernel and the daemon.

Unfortunately, both the current audit design and implementation is
seriously flawed in a number of areas.  One of these areas is the fact
that data and control messages are sent using the same data flow.

>  > The ENOBUFS errors are coming from the netlink layer and are likely a
>  > sign of extreme load.  I'm not very familiar with the audit userspace
>  > code, but it might be helpful to see if you can increase the socket
>  > buffer size for the audit daemon.
>
> I believe we tried increasing the buffer size in the toy repro and it
> didn't make much difference - perhaps doing it in the real audit daemon
> might help.

The reproducer is an artificial worst case since you are disconnecting
and reconnecting without a process shutdown and startup in between.
The reproducer just hammers the connection status as fast as the CPU
can generate netlink messages; I'm not certain there is a
netlink/socket buffer size that would fully resolve this for the
reproducer.

>  > I'm also not surprised to hear that as you increase the number of CPUs
>  > the problem goes away.  With more CPUs the system is able to schedule
>  > more threads simultaneously to maintain the kernel's audit queues and
>  > execute the audit daemon to drain both the netlink socket buffer and
>  > audit queues.
>
> My intuition told me the opposite - that more parallel activity would
> increase the chance of the socket buffer being crammed full before the
> one thread could return to the audit daemon and allow it to start
> processing events.

The audit subsystem can handle a full buffer, that has been stressed a
lot over the years, and while it may slow the system down it will
continue to operate.  As a fun exercise, configure the audit subsystem
to audit *every* syscall and then try to shut the system down.  It
will complete, but it's ugly and you'll see the audit subsystem
complain a *lot* about dropped records due to queue/backlog overflows.

The issue isn't so much about the queues overflowing inside the
kernel, it's about being able to schedule the audit daemon and/or
kernel thread to service the flood of connection
disconnects/reconnects coming from the reproducer.

> Does the size/number of audit queues perhaps scale
> with the number of CPUs?

The number of queues is static, and their size is determined at
runtime by the configuration.  Making per-CPU queues would be a bit of
a mess due to our desire to ensure an accurate ordering of events
relative to a wall clock.

>  > I suggest bringing this up with the audit userspace developer if you
>  > haven't already.  While we can, and should, improve things on the
>  > kernel side (e.g. the patch we are discussing), it also sounds like
>  > the userspace side has room for improvement as well.
>
> That sounds like a good idea - can you point me to who that is? I was
> under the impression that this was the mailing list for both the kernel
> and userspace sides.

That used to be the case, but unfortunately the audit userspace
developer who manages the original audit mailing list was unwilling to
make the list configuration changes we needed to play nice with
existing Linux kernel mailing list conventions so we needed to move
the kernel development discussions to a separate list.

The old audit mailing list, where the userspace development is still
discussed, can be found here:

* http://www.redhat.com/mailman/listinfo/linux-audit

--=20
paul-moore.com
