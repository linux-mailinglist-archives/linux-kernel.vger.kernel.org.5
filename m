Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9CD97AEEA6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 16:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbjIZOHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 10:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbjIZOHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 10:07:48 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422ACEB;
        Tue, 26 Sep 2023 07:07:35 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 11A7E3200980;
        Tue, 26 Sep 2023 10:07:30 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 26 Sep 2023 10:07:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1695737250; x=1695823650; bh=F/
        el3HyWUlbGah808ZbQaxaaK+TKMHmfOvrHvJVJ96k=; b=TNuLG8yU7QU2twvhRi
        +VVK4UIg2ST4KynOnrA/EZCbWGcDZYYC2xp7FgYBhP99s5P/XzZ/hyh5Cbo1S4lD
        MPrnRSmyLUuaopOB7MUVF9QxYRz+1xpR2vdRWCxsU7mEdbSSA9Qi6W4GRWCHbHPm
        +DIxZHqiPJc+asio3uQZYc1D/3Gu1TGcybSpMgCFIhKSl6BEFI5DcoEjzUfjHMxh
        bO1RSwKZvIF/jbreA8/NaaXy+Z1x1gA23q3uPUkEFnrjckWaFNY+NnS+UXxJwTwP
        jUHVRmHnxWswBnWFE7sYR7pGWMZpHVwZaYaYW7Oe9L1fQnJqqZME5xn0Cbbux4Ds
        6sig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695737250; x=1695823650; bh=F/el3HyWUlbGa
        h808ZbQaxaaK+TKMHmfOvrHvJVJ96k=; b=CL/3p5AmBvEMHEhnYaV37hLk7JnyP
        NY1JxUM1LcXhf+uU3Uw0jjeMhGiFSg7xojyNBmZykkBK+4K7zxKnaCNI/USroa90
        ysTJ10cM4i7HNV2o6Mrf9Tz9RxA8sX+XzWiUxxo8p2FepHpiEeDMNZXWzi2MrSFo
        9wcxMo9zaJnBzvmxxoPmingLY+jlfAuufVE5eGr8p4u+U2LyxJwt7B5oyhQrVhOm
        K1okN4mZIZ3GsLELFG0gNhI6AwPVoA1Hlq6ajZSP7Oa5L/0XG/DjM+Wa+Bq5rrqU
        QiqvvPL1DRZmaBHud+lAMFyLnhOdCngMzlmLBghv638qS8dTLL6gJRXgw==
X-ME-Sender: <xms:n-USZRrrBeapjhxxe677XeQhLP7K91LrVK2ggiXYkUvDCQsdKivpyQ>
    <xme:n-USZTqSrNHahiFQR-AcsquIX0lkO18asLHruCK7qHdEYWgxks0psSSdeHwoRKVZL
    t1qSL7LhwqPE5NGaMI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvjedrtddtgdegfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:n-USZeO2smIjCiIXWETPe1OKitQMaGt577YIK1Abbx5EqFIZF1bbzQ>
    <xmx:n-USZc48j06tj3g3f4ARmFz6oxXWasQ_bdsRafuo-N8MMRLVGLV5sQ>
    <xmx:n-USZQ68yRH4n82alkc8sbxbcdP0WWonTQcSzM5fC7bbWAsWrxwHTw>
    <xmx:ouUSZQh3c1WclCk6-AyNMbo4Jwqhp8Nm8My893pmxpqs0A4-mue9Hg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 608FDB60089; Tue, 26 Sep 2023 10:07:27 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-957-ga1ccdb4cff-fm-20230919.001-ga1ccdb4c
MIME-Version: 1.0
Message-Id: <aa886004-d2fe-4e20-b73e-a622931dae9a@app.fastmail.com>
In-Reply-To: <a08e1cee-05e0-447a-b25b-6c2ebb116e8d@app.fastmail.com>
References: <cover.1695679700.git.falcon@tinylab.org>
 <fbb6f526-0db9-4bbe-9635-8cb55b4335ee@app.fastmail.com>
 <a08e1cee-05e0-447a-b25b-6c2ebb116e8d@app.fastmail.com>
Date:   Tue, 26 Sep 2023 16:07:07 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Zhangjin Wu" <falcon@tinylab.org>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     "Palmer Dabbelt" <palmer@rivosinc.com>,
        "Paul Walmsley" <paul.walmsley@sifive.com>, paulburton@kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "Willy Tarreau" <w@1wt.eu>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        "Tim Bird" <tim.bird@sony.com>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Nicolas Pitre" <nico@fluxnic.net>
Subject: Re: [PATCH v1 0/7] DCE/DSE: Add Dead Syscalls Elimination support, part1
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,T_SPF_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023, at 13:24, Arnd Bergmann wrote:
> $ size build/tmp/vmlinux-*
>    text	   data	    bss	     dec    hex	filename
>   754772  220016  71841	 1046629  ff865	vmlinux-tinyconfig
>   717500  223368  71841	 1012709  f73e5	vmlinux-tiny+nosyscalls
>   567310  176200  71473	  814983  c6f87	vmlinux-tiny+gc-sections
>   493278  170752  71433	  735463  b38e7	vmlinux-tiny+gc-sections+nosyscalls
> 10120058 3572756 493701	14186515 d87813	vmlinux-defconfig
>  9953934 3529004 491525	13974463 d53bbf	vmlinux-defconfig+gc
>  9709856 3500600 489221	13699677 d10a5d	vmlinux-defconfig+gc+nosyscalls
>
> This would put us at an upper bound of 10% size savings (80kb) for
> tinyconfig, which is clearly significant. For defconfig, it's
> still 2.0% or 275kb size reduction when all syscalls are dropped.

I did one more test to see which syscalls actually cause bloat in
when CONFIG_LD_DEAD_CODE_DATA_ELIMINATION is set in order to drop them
all. I build the above riscv tinyconfig with
CONFIG_LD_DEAD_CODE_DATA_ELIMINATION and truncated the syscall
table before and after each syscall to see the size difference.

A lot of syscalls are already conditional, so those show up as
0, 4 or 8 bytes (not sure why they are not always 0). Others
could probably be made to fit within some category that can
be made optional (e.g. xattr or adjtimex). Having a Kconfig
option for those would also let users remove even more code that
is not useful without the syscalls but might be called from
somewhere else in the kernel.

      Arnd

syscall  size   name
-------------------------
0	8	io_setup
1	4	io_destroy
2	8	io_submit
3	4	io_cancel
4	8	io_getevents
5	1496	setxattr
6	28	lsetxattr
7	148	fsetxattr
8	1404	getxattr
9	16	lgetxattr
10	80	fgetxattr
11	276	listxattr
12	16	llistxattr
13	68	flistxattr
14	460	removexattr
15	20	lremovexattr
16	92	fremovexattr
17	240	getcwd
18	4	lookup_dcookie
19	8	eventfd2
20	4	epoll_create1
21	8	epoll_ctl
22	4	epoll_pwait
23	64	dup
24	300	dup3
25	1684	fcntl
26	4	inotify_init1
27	8	inotify_add_watch
29	0	ioctl
28	4	inotify_rm_watch
30	8	ioprio_set
31	4	ioprio_get
32	8	flock
33	456	mknodat
34	192	mkdirat
35	64	unlinkat
36	208	symlinkat
38	0	renameat
37	324	linkat
40	0	mount
39	64	umount2
42	0	nfsservctl
41	708	pivot_root
43	424	statfs
44	132	fstatfs
45	272	truncate
46	216	ftruncate
47	88	fallocate
48	420	faccessat
49	120	chdir
50	112	fchdir
51	120	chroot
52	68	fchmod
53	164	fchmodat
54	184	fchownat
55	136	fchown
56	184	openat
57	204	close
58	4	vhangup
59	648	pipe2
61	0	getdents64
60	4	quotactl
62	148	lseek
63	328	read
64	356	write
65	952	readv
66	252	writev
67	92	pread64
68	92	pwrite64
69	100	preadv
71	0	sendfile
72	0	pselect6
70	100	pwritev
73	132	ppoll
74	4	signalfd4
75	2808	vmsplice
76	1388	splice
77	536	tee
78	424	readlinkat
79	244	fstatat
80	64	fstat
81	296	sync
82	100	fsync
83	20	fdatasync
84	448	sync_file_range
85	8	timerfd_create
86	4	timerfd_settime
87	8	timerfd_gettime
88	300	utimensat
89	4	acct
90	8	capget
91	4	capset
92	24	personality
93	24	exit
94	24	exit_group
95	16	waitid
96	28	set_tid_address
97	608	unshare
98	4	futex
99	8	set_robust_list
100	4	get_robust_list
101	276	nanosleep
103	0	setitimer
102	8	getitimer
104	4	kexec_load
105	8	init_module
107	0	timer_create
108	0	timer_gettime
109	0	timer_getoverrun
110	0	timer_settime
111	0	timer_delete
106	4	delete_module
112	44	clock_settime
113	88	clock_gettime
114	64	clock_getres
115	160	clock_nanosleep
116	8	syslog
117	740	ptrace
118	140	sched_setparam
119	36	sched_setscheduler
120	64	sched_getscheduler
121	88	sched_getparam
122	196	sched_setaffinity
123	180	sched_getaffinity
124	24	sched_yield
125	60	sched_get_priority_max
126	60	sched_get_priority_min
127	164	sched_rr_get_interval
128	12	restart_syscall
129	304	kill
130	212	tkill
131	40	tgkill
132	100	sigaltstack
133	104	rt_sigsuspend
134	396	rt_sigaction
135	180	rt_sigprocmask
136	76	rt_sigpending
137	336	rt_sigtimedwait
139	0	rt_sigreturn
138	120	rt_sigqueueinfo
140	396	setpriority
141	276	getpriority
142	1256	reboot
143	4	setregid
144	8	setgid
145	4	setreuid
146	8	setuid
147	4	setresuid
148	8	getresuid
149	4	setresgid
150	8	getresgid
151	4	setfsuid
152	8	setfsgid
153	152	times
154	252	setpgid
155	48	getpgid
156	48	getsid
157	140	setsid
158	8	getgroups
159	4	setgroups
160	172	uname
161	132	sethostname
162	136	setdomainname
163	156	getrlimit
164	52	setrlimit
165	88	getrusage
167	0	prctl
168	0	getcpu
169	0	gettimeofday
170	0	settimeofday
166	24	umask
171	1514	adjtimex
172	20	getpid
173	20	getppid
174	4	getuid
175	4	geteuid
176	4	getgid
177	4	getegid
178	20	gettid
179	276	sysinfo
180	4	mq_open
181	8	mq_unlink
182	4	mq_timedsend
183	8	mq_timedreceive
184	4	mq_notify
185	8	mq_getsetattr
186	4	msgget
187	8	msgctl
188	4	msgrcv
189	8	msgsnd
190	4	semget
191	8	semctl
192  	4	semtimedop
193	8	semop
194	4	shmget
195	8	shmctl
196	4	shmat
197	8	shmdt
198	4	socket
199	8	socketpair
200	4	bind
201	8	listen
202	4	accept
203	8	connect
204	4	getsockname
205	8	getpeername
206	4	sendto
207	8	recvfrom
208	4	setsockopt
209	8	getsockopt
210	4	shutdown
211	8	sendmsg
212	4	recvmsg
213	460	readahead
214	2872	brk
215	288	munmap
216	4268	mremap
217	4	add_key
218	8	request_key
219	4	keyctl
220	100	clone
221	724	execve
222	2504	mmap
223	8	fadvise64
224	4	swapon
225	8	swapoff
226	2180	mprotect
227	320	msync
228	1140	mlock
229	84	munlock
230	304	mlockall
231	52	munlockall
232	828	mincore
233	4	madvise
234	324	remap_file_pages
235	4	mbind
236	8	get_mempolicy
237	4	set_mempolicy
238	8	migrate_pages
239	4	move_pages
240	132	rt_tgsigqueueinfo
241	8	perf_event_open
242	4	accept4
244	0	arch_specific_syscall
243	8	recvmmsg
260	100	wait4
261	252	prlimit64
262	8	fanotify_init
263	4	fanotify_mark
264	8	name_to_handle_at
266	0	clock_adjtime
265	4	open_by_handle_at
267	120	syncfs
268	624	setns
269	4	sendmmsg
270	8	process_vm_readv
271	4	process_vm_writev
272	8	kcmp
274	0	sched_setattr
273	4	finit_module
275	208	sched_getattr
276	2364	renameat2
277	4	seccomp
278	124	getrandom
279	4	memfd_create
280	8	bpf
281	52	execveat
282	4	userfaultfd
283	8	membarrier
284	40	mlock2
285	708	copy_file_range
286	32	preadv2
287	32	pwritev2
288	8	pkey_mprotect
289	4	pkey_alloc
290	8	pkey_free
291	356	statx
292	4	io_pgetevents
424	244	pidfd_send_signal
425	8	io_uring_setup
426	4	io_uring_enter
427	8	io_uring_register
428	368	open_tree
429	404	move_mount
430	556	fsopen
431	1056	fsconfig
432	484	fsmount
433	220	fspick
434	124	pidfd_open
435	516	clone3
436	240	close_range
437	120	openat2
438	304	pidfd_getfd
439	12	faccessat2
440	8	process_madvise
441	4	epoll_pwait2
442	1088	mount_setattr
443	8	quotactl_fd
444	4	landlock_create_ruleset
445	8	landlock_add_rule
446	4	landlock_restrict_self
447	8	memfd_secret
448	240	process_mrelease
449	4	futex_waitv
450	8	set_mempolicy_home_node
451	4	cachestat
452	28	fchmodat2
454	4	futex_wake
