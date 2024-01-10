Return-Path: <linux-kernel+bounces-22499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DA0829EA5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 17:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AF851F22EED
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4FF405D9;
	Wed, 10 Jan 2024 16:31:00 +0000 (UTC)
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3394A9A9
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 16:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:46712)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1rNbB6-00B1sd-Da; Wed, 10 Jan 2024 09:11:40 -0700
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:45244 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1rNbB5-00AifK-3O; Wed, 10 Jan 2024 09:11:40 -0700
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: syzbot <syzbot+c6d438f2d77f96cae7c2@syzkaller.appspotmail.com>,  Oleg
 Nesterov <oleg@redhat.com>,  linux-kernel@vger.kernel.org,
  luto@kernel.org,  michael.christie@oracle.com,  mst@redhat.com,
  peterz@infradead.org,  syzkaller-bugs@googlegroups.com,
  tglx@linutronix.de
References: <000000000000a41b82060e875721@google.com>
	<CAHk-=wgM=MmqrQC-qgXoSehW=itHaqOUiBfN8jRBGAHn1=D0tg@mail.gmail.com>
Date: Wed, 10 Jan 2024 10:11:01 -0600
In-Reply-To: <CAHk-=wgM=MmqrQC-qgXoSehW=itHaqOUiBfN8jRBGAHn1=D0tg@mail.gmail.com>
	(Linus Torvalds's message of "Tue, 9 Jan 2024 11:05:45 -0800")
Message-ID: <87frz5184q.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-XM-SPF: eid=1rNbB5-00AifK-3O;;;mid=<87frz5184q.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/bo6umY1wkDowtM1WLxbtDV0aWW3HwnrM=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: *****
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	*  0.5 XMGappySubj_01 Very gappy subject
	*  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	*  1.2 XM_Multi_Part_URI URI: Long-Multi-Part URIs
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.2 XMLngstWrd_01 words over 55 charachters don't exist
	*  0.2 XMLngstWrd_04 words over 85 charachters don't exist
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
	*  0.2 XMLngstWrd_02 words over 65 charachters don't exist
	*  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
	*  0.2 XMLngstWrd_00 words over 45 charachters don't exist
	*  0.2 XMLngstWrd_03 words over 75 charachters don't exist
	*  1.1 GB_FAKE_RF_SHORT Fake reply or forward with url shortener
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *****;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 723 ms - load_scoreonly_sql: 0.04 (0.0%),
	signal_user_changed: 9 (1.3%), b_tie_ro: 8 (1.1%), parse: 1.12 (0.2%),
	extract_message_metadata: 26 (3.5%), get_uri_detail_list: 4.5 (0.6%),
	tests_pri_-2000: 32 (4.4%), tests_pri_-1000: 2.6 (0.4%),
	tests_pri_-950: 1.26 (0.2%), tests_pri_-900: 1.01 (0.1%),
	tests_pri_-90: 163 (22.5%), check_bayes: 161 (22.3%), b_tokenize: 16
	(2.2%), b_tok_get_all: 47 (6.5%), b_comp_prob: 7 (0.9%),
	b_tok_touch_all: 87 (12.0%), b_finish: 0.94 (0.1%), tests_pri_0: 472
	(65.2%), check_dkim_signature: 0.61 (0.1%), check_dkim_adsp: 2.4
	(0.3%), poll_dns_idle: 0.57 (0.1%), tests_pri_10: 2.2 (0.3%),
	tests_pri_500: 11 (1.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [syzbot] [kernel?] WARNING in signal_wake_up_state
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Oleg/Eric, can you make any sense of this?
>
> On Tue, 9 Jan 2024 at 10:18, syzbot
> <syzbot+c6d438f2d77f96cae7c2@syzkaller.appspotmail.com> wrote:
>>
>> The issue was bisected to:
>>
>> commit f9010dbdce911ee1f1af1398a24b1f9f992e0080
>
> Hmm. This smells more like a "that triggers the problem" than a cause.
>
> Because the warning itself is
>
>> WARNING: CPU: 1 PID: 5069 at kernel/signal.c:771 signal_wake_up_state+0x=
fa/0x120 kernel/signal.c:771
>
> That's
>
>         lockdep_assert_held(&t->sighand->siglock);
>
> at the top of the function, with the call trace being
>
>>  signal_wake_up include/linux/sched/signal.h:448 [inline]
>
> just a wrapper setting 'state'.
>
>>  zap_process fs/coredump.c:373 [inline]
>
> That's zap_process() that does a
>
>         for_each_thread(start, t) {
>
> and then does a
>
>                         signal_wake_up(t, 1);
>
> on each thread.
>
>>  zap_threads fs/coredump.c:392 [inline]
>
> And this is zap_threads(), which does
>
>         spin_lock_irq(&tsk->sighand->siglock);
>         ...
>                 nr =3D zap_process(tsk, exit_code);
>
> Strange. The sighand->siglock is definitely taken.
>
> The for_each_thread() must be hitting a thread with a different
> sighand, but it's basically a
>
>         list_for_each_entry_rcu(..)
>
> walking over the tsk->signal->thread_head list.
>
> But if CLONE_THREAD is set (so that we share that 'tsk->signal', then
> we always require that CLONE_SIGHAND is also set:
>
>         if ((clone_flags & CLONE_THREAD) && !(clone_flags & CLONE_SIGHAND=
))
>                 return ERR_PTR(-EINVAL);
>
> so we most definitely should have the same ->sighand if we have the
> same ->signal. And that's true very much for that vhost_task_create()
> case too.
>
> So as far as I can see, that bisected commit does add a new case of
> threaded signal handling, but in no way explains the problem.
>
> Is there some odd exit race? The thread is removed with
>
>         list_del_rcu(&p->thread_node);
>
> in __exit_signal -> __unhash_process(), and despite the RCU
> annotations, all these parts seem to hold the right locks too (ie
> sighand->siglock is held by __exit_signal too), so I don't even see
> any delayed de-allocation issue or anything like that.
>
> Thus bringing in Eric/Oleg to see if they see something I miss.

I expect this would take going through the rest of the reproducer
to see what is going on.
Hmm.  The reproducer is in something other than C:

> # https://syzkaller.appspot.com/bug?id=3Db7640dae2467568f05425b289a1f004f=
aa2dc292
> # See https://goo.gl/kgGztJ for information about syzkaller reproducers.
> #{"repeat":true,"procs":1,"slowdown":1,"sandbox":"","sandbox_arg":0,"clos=
e_fds":false}
> r0 =3D openat$vnet(0xffffffffffffff9c, &(0x7f0000000040), 0x2, 0x0)
> ioctl$int_in(r0, 0x40000000af01, 0x0)
> r1 =3D memfd_create(&(0x7f0000000400)=3D'\xa3\x9fn\xb4dR\x04i5\x02\xac\xc=
e\xe1\x88\x9d[@8\xd7\xce\x1f 9I\x7f\x15\x1d\x93=3D\xb5\xe7\\\'L\xe6\xd2\x8e=
\xbc)JtTDq\x81\xcf\x81\xba\xe51\xf5 \xc8\x10>\xc9\\\x85\x17L\xbf\xcf\x91\xd=
fM\xf3\x02^T*\x00\x02\xb9~B\x9f\xacl\x1d3\x06o\xf8\x16H\xaa*\x02\xf7\xfb\x0=
6\xf1\x83\x92\xa8\xc2\xcb\xae\xb0\xb4\x93\xb8\x04\xf1\x99\xc2yY+\xd9y\x8a\x=
d5b\xe8\"q\x1b0)\xccm\xacz\xc1\xadd\x9b6a\xf3\xdds\xbb\x88\xff\b\x85\xb3s\x=
00\x0e\xbcfvi\x85\xfc.|\xd4h\xec\x82o\x8e\x93\x11\xc1\xd4\xae\x05\x17=3D\xd=
9R\xd0\xd4\x90\xcf\x9b\xdc\xaeV\x88\x94\x9f\xe3\xefqi\xed\xa8w\xbe\xd0\xd0-=
tBl\x9e+\xd3\xed\xce\x9f\x83\x86\xf9\x12\x16Ts\x80\x13]C\xfb`\xc2`\xf7\x1a\=
x00\x00\x00\x00\x00\x00\x00k\xae\xcb\x1a.\xc2\x8f\xd1x4]PZ\x9e\xd5Y\xf0L\xa=
4\xbc\x84\xf6\x04L\xff0\x8b\\*\xf9,\xb6\r\x97\xedy\xe0\x8a\xe2\x8ck\xc6S\xc=
3g\xb9\x1a\xf8\x8f \x9d\x00u7\xd8\'\xf1E\xa4(Q\x80Fy\xb5\xe4q\xc9\xff \xd8\=
x9d\xad\x11\xf8m\xd3\xbc\x9e\x10D\x7f!\xca\x0ev\x15h$\x01\xdd\xe5\xce\xf8*\=
xb3\x01\x85\a\xe4qv&\x9c\xac\x9aN~o\xe5\x89\xd5\a\x9f\f\x1f\xc2e/\x8d\x1e\n=
\xd0_\xbd!^\xa46\xb8j\xc0x\n\xdb\xe1\xa3\xd6\xae;\r\x92@\xa5I\x88Z1F\xf0\x1=
at\t\xd0\x8a\x04m\x06\xf3BL\xffS\x9eY\xf4\xb0U \xf8\xd00\x88y\xebX\x92\xd5\=
xbb\xa1h7\xf3\xe0\x0f\xbd\x02\xe4%\xf9\xb1\x87\x8aM\xfeG\xb2L\xbd\x92-\xcd\=
x1f\xf4\xe1,\xb7G|\xec\"\xa2\xab\xf6\x84\xe0\xcf1\x9a', 0x0)
> write$binfmt_elf32(r1, &(0x7f0000000140)=3DANY=3D[@ANYBLOB=3D"7f454c46600=
0002ed8e4f97765ce27b90300060000000000000000b738000000000035f4c38422a3bc8220=
000500000004020300b300000000002a002400b3d7c52ebf31a8d5c8c3c6cb00000009e500d=
5ffffff05ffffff03004f9ef4"], 0xd8)
> execveat(r1, &(0x7f0000000000)=3D'\x00', 0x0, 0x0, 0x1000)

If I read that correctly it is intending to put an elf32 executable into
a memfd and then execute it.

Exec will possibly unshare SIGHAND struct if there is still a reference
to it from somewhere else to ensure the new process has a clean one.

But all of the other threads should get shutdown by de_thread before any
of that happens.  And de_thread should take care of the weird non-leader
execve case as well.  So after that point the process really should
be single threaded.  Which is why de_thread is the point of no return.

That whole interrupt comes in, and a fatal signal is processed
scenario is confusing.

Hmm.  That weird vnet ioctl at the beginning must be what is starting
the vhost logic.  So I guess it makes sense if the signal is received
by the magic vhost thread.

Perhaps there is some weird vhost logic where the thread lingers.

Ugh.  I seem to remember a whole conversation about the vhost logic
(immediately after it was merged) and how it had a bug where it exited
differently from everything else.  I remember people figuring it was
immediately ok, after the code was merged, and because everything had to
be performed as root, and no one actually uses the vhost logic like
that.  It has been long enough I thought that would have been sorted
out by now.

Looking back to refresh my memory at the original conversation:
https://lore.kernel.org/all/20230601183232.8384-1-michael.christie@oracle.c=
om/

The bisect is 100% correct, and this was a known issue with that code at
the time it was merged.

I will let someone else take it from here.

Eric

