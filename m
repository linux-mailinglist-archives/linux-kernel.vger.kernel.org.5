Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37BD7F54E3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 00:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbjKVXhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 18:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjKVXhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 18:37:20 -0500
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BEE2112
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 15:37:14 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id B9BE0601A5;
        Thu, 23 Nov 2023 00:37:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1700696231; bh=K95+9wi6y3iHhld1rqgbHWl6+xUvw+qaarMsdSofHpA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lMFNVMA18LXPN3yHfNy+JojCBWurypC1GC5KDLKuHh5efkaNW8r2NOqDufu2kb6eR
         jr0Htn7VCUT0k2kVNTGnBsXLaR3B9ZeqDskCFgmnu1jRX7JePc6tAp1S//JzJdsW0z
         zVmbAJWoxYGZolJpcYvHA9ZUW1kh6qwEY+420l890EqzTj4fATzR3GL/sV2kWd+EfA
         9525ANhOEYEtQ15d0Jtq/hR3psV9YDxL8jQaGPMnSMg52dcTpoZ/sj6FawfNylBGrt
         HUNXvTrxeQ4j6Xhwh1SJStR25G4ohFnBNBMiBlXlesnX1mdWmeegKYt1HbOmpepX5y
         ycSAdOnT6GvXg==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yZlERrU8XkVN; Thu, 23 Nov 2023 00:37:08 +0100 (CET)
Received: from [192.168.1.6] (78-2-200-148.adsl.net.t-com.hr [78.2.200.148])
        by domac.alu.hr (Postfix) with ESMTPSA id 36EC160197;
        Thu, 23 Nov 2023 00:37:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1700696228; bh=K95+9wi6y3iHhld1rqgbHWl6+xUvw+qaarMsdSofHpA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XIC25btsHggycI+3otDz2M4nJarNxzIYW+PnCr6MFNii4cLkWc8x4IwRS+DgZIA5h
         gU+CSAJLpV1hutBSohE75vv5H/tIfbHNP2iSVJqyCmySHOJqI/0lKT6eM6g6InlpYy
         9bCTfNIk9rsNsqSkUIb67rCnpjPyOurGEwcXa2Cy1flWizhCONvUPi8S7ZXZGufZ21
         bMrXmeLaM0/yyAaFm1wQ5FMK6sFoz6ehEiwNxTCIyRaIcQD1vnjf+q8MEIs0MnOcjK
         3Aru93H+5rKAvVXP2W4FaWfa6xqVwDZQ2QRf0QncqVJJReCZfTG3ougnDVlfq1TbJT
         x3rtoQ34Mvy7w==
Message-ID: <4a01cd1d-c9c9-4946-add4-1acf6998a24a@alu.unizg.hr>
Date:   Thu, 23 Nov 2023 00:37:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/1] kernfs: replace deprecated strlcpy() with
 strscpy()
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Aditya Kali <adityakali@google.com>
References: <20231122212008.11790-1-mirsad.todorovac@alu.unizg.hr>
 <ZV5zQ0gRxzGwweYN@slm.duckdns.org>
Content-Language: en-US
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <ZV5zQ0gRxzGwweYN@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mr. Tejun Heo,

On 11/22/23 22:31, Tejun Heo wrote:
> Hello,
> 
> On Wed, Nov 22, 2023 at 10:20:10PM +0100, Mirsad Goran Todorovac wrote:
>> From: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
>>
>> According to strlcpy() being officially deprecated and the encouragement
>> to remove the remaining occurrences, this came as the intriguing example.
>>
>> In the kernfs_name_locked() the behaviour of truncating the kn->name is
>> preserved, for it only used in the module for printing in the log and
>> declared static. It is only called from pr_cont_kernfs_name() via kernfs_name()
>> and returned result is ignored.
>>
>> It is avoided to go past the allocated page and cause the internal equivalent
>> of SEGFAULT in the unlikely case kn->name is not null-terminated, which I
>> believe was the idea behind replacing strlcpy() with strscpy().
> 
> I don't follow this line of thinking. Yeah, if the input arguments are
> wrong, it can malfunction. strscpy() is gonna page fault too if the input
> string crosses into an unmapped page before the destination buffer is
> filled, right? But it'd be a stretch to claim that that's a problem with the
> function. Maybe I'm missing something but I'm having a hard time seeing the
> value in these conversions.

INTRODUCTION

I will try to explain, it is not complicated, but we have to cover all cases
of use of kernfs_name_locked(), kernfs_name() and cgroup_name() which uses it.

We are lucky that there are only a couple of uses throughout kernel
(verified with grep and Bootlin).

But let's start from the beginning.

We have a semantical gap where strlcpy() returned the rather useless
value of strlen(src) on buffer overrun which was tried to be avoided at all
cost, for it can page fault into unmapped region.

When we use that value, we are in trouble when strlen(src) > buflen,
and we return in effect strlen(src). Calculating it is not only useless, but
possibly can cause page fault in the case src is not null-terminated.

(This is not my idea, I've read it on LWN, but I cannot find the reference
right now, I may be able to provide it later.)

It is also inefficient to scan all characters after the "count"
bytes until the end of src just to be able to say that the length overruns
the buffer, when it is obvious after the first character exceeding "count".

But we are happy that no part of kernel uses this value ATM, so
the function kernel_name_locked() could as well be void.

I will try to elaborate this into greater detail, and I tried to do it
in the full but shortest possible.

===

Allegedly, by the article here: [1] https://lwn.net/Articles/659214/

strscpy() now (or since 2015) copies string up to "count" bytes and
truncates it.

And from the source of strscpy():

[2] https://elixir.bootlin.com/linux/latest/source/lib/string.c#L122

	size_t max = count;

	while (max >= sizeof(unsigned long)) {
		unsigned long c, data;

		c = read_word_at_a_time(src+res);
		if (has_zero(c, &data, &constants)) {
			data = prep_zero_mask(c, data, &constants);
			data = create_zero_mask(data);
			*(unsigned long *)(dest+res) = c & zero_bytemask(data);
			return res + find_zero(data);
		}
		*(unsigned long *)(dest+res) = c;
		res += sizeof(unsigned long);
		count -= sizeof(unsigned long);
		max -= sizeof(unsigned long);
	}

	while (count) {
		char c;

		c = src[res];
		dest[res] = c;
		if (!c)
			return res;
		res++;
		count--;
	}

it is visible that strscpy() will not go ahead more than "count" bytes into
a theoretically unterminated string, certainly not more than the sizeof(unsigned long).

This should dramatically decrease chances of hitting a page boundary and page
fault if the string is erroneously or maliciously not null-terminated.

>> kernfs_path_from_node_locked() has "(null)" which certainly cannot overrun,
>> and a carefully calculated len and truncated path elsewhere.
> 
> Some of the functions you're modifying were returning the full length of the
> input string before and it isn't clear from the patch or description whether
> the conversion is safe. It'd help if you can elaborate more on why the
> conversions are safe and how you verified them.

Well, it is not so complicated, once you get into the Source:

The only place where the return value is modified is here:

   54 static int kernfs_name_locked(struct kernfs_node *kn, char *buf, size_t buflen)
   55 {
   56         size_t len;
   57
   58         if (!kn)
   59                 return strscpy(buf, "(null)", buflen);
   60
   61         len = strscpy(buf, kn->parent ? kn->name : "/", buflen);
   62
   63         if (unlikely(len == -E2BIG)) {
   64                 return buflen - 1;
   65         } else
   66                 return len;
   67 }

Just in this mail Linus has declined the possibility of using any variant of
strlen() to establish the length of kn->name:

[3] https://lore.kernel.org/lkml/CAHk-=wg7pwWiF4eWVTfFYkfAk_5YDHkmkgZ04cgXkNUO_9pR3A@mail.gmail.com/

kernfs_name_locked() is called from this function:

  201 int kernfs_name(struct kernfs_node *kn, char *buf, size_t buflen)
  202 {
  203         unsigned long flags;
  204         int ret;
  205
  206         read_lock_irqsave(&kernfs_rename_lock, flags);
  207         ret = kernfs_name_locked(kn, buf, buflen);
  208         read_unlock_irqrestore(&kernfs_rename_lock, flags);
  209         return ret;
  210 }

The return value is passed to the caller. The kernfs_name() is called only here:

  247 void pr_cont_kernfs_name(struct kernfs_node *kn)
  248 {
  249         unsigned long flags;
  250
  251         spin_lock_irqsave(&kernfs_pr_cont_lock, flags);
  252
  253         kernfs_name(kn, kernfs_pr_cont_buf, sizeof(kernfs_pr_cont_buf));
  254         pr_cont("%s", kernfs_pr_cont_buf);
  255
  256         spin_unlock_irqrestore(&kernfs_pr_cont_lock, flags);
  257 }

and the return value is ignored.

Search shows that kernfs is defined and used here:

Defined in 1 files as a prototype:

     include/linux/kernfs.h, line 394 (as a prototype)

Defined in 2 files as a function:

     fs/kernfs/dir.c, line 194 (as a function)
     include/linux/kernfs.h, line 472 (as a function)

Documented in 1 files:

     fs/kernfs/dir.c, line 178

Referenced in 2 files:

     fs/kernfs/dir.c, line 246
     include/linux/cgroup.h, line 596

Let's go through each case:

A search shows that

user@host:~/linux/kernel/torvalds4 $ grep -n -E 'kernfs_name[(]' --include '*.c' --include '*.h' -r .
./fs/kernfs/dir.c:201:int kernfs_name(struct kernfs_node *kn, char *buf, size_t buflen)
./fs/kernfs/dir.c:247:void pr_cont_kernfs_name(struct kernfs_node *kn)
./fs/kernfs/dir.c:253:	kernfs_name(kn, kernfs_pr_cont_buf, sizeof(kernfs_pr_cont_buf));
./include/linux/cgroup.h:594:	return kernfs_name(cgrp->kn, buf, buflen);
./include/linux/cgroup.h:604:	pr_cont_kernfs_name(cgrp->kn);
./include/linux/kernfs.h:395:int kernfs_name(struct kernfs_node *kn, char *buf, size_t buflen);
./include/linux/kernfs.h:398:void pr_cont_kernfs_name(struct kernfs_node *kn);
./include/linux/kernfs.h:473:static inline int kernfs_name(struct kernfs_node *kn, char *buf, size_t buflen)
./include/linux/kernfs.h:481:static inline void pr_cont_kernfs_name(struct kernfs_node *kn) { }
./debian/linux-headers/usr/src/linux-headers-6.7.0-rc2-rtl-v0.2-nokcsan-00027-g9b71d857b080-dirty/include/linux/cgroup.h:594:	return kernfs_name(cgrp->kn, buf, buflen);
./debian/linux-headers/usr/src/linux-headers-6.7.0-rc2-rtl-v0.2-nokcsan-00027-g9b71d857b080-dirty/include/linux/cgroup.h:604:	pr_cont_kernfs_name(cgrp->kn);
./debian/linux-headers/usr/src/linux-headers-6.7.0-rc2-rtl-v0.2-nokcsan-00027-g9b71d857b080-dirty/include/linux/kernfs.h:395:int kernfs_name(struct kernfs_node *kn, char *buf, size_t buflen);
./debian/linux-headers/usr/src/linux-headers-6.7.0-rc2-rtl-v0.2-nokcsan-00027-g9b71d857b080-dirty/include/linux/kernfs.h:398:void pr_cont_kernfs_name(struct kernfs_node *kn);
./debian/linux-headers/usr/src/linux-headers-6.7.0-rc2-rtl-v0.2-nokcsan-00027-g9b71d857b080-dirty/include/linux/kernfs.h:473:static inline int kernfs_name(struct kernfs_node *kn, char *buf, size_t buflen)
./debian/linux-headers/usr/src/linux-headers-6.7.0-rc2-rtl-v0.2-nokcsan-00027-g9b71d857b080-dirty/include/linux/kernfs.h:481:static inline void pr_cont_kernfs_name(struct kernfs_node *kn) { }

In include/linux/kernfs.h:395: kernfs_name() is defined as:

395 int kernfs_name(struct kernfs_node *kn, char *buf, size_t buflen);

In include/linux/kernfs.h:473: kernfs_name() is defined as:

472
473 static inline int kernfs_name(struct kernfs_node *kn, char *buf, size_t buflen)
474 { return -ENOSYS; }
475

elsewhere it is used in include/linux/cgroup.h:594:

592 static inline int cgroup_name(struct cgroup *cgrp, char *buf, size_t buflen)
593 {
594         return kernfs_name(cgrp->kn, buf, buflen);
595 }

Seek cgroup_name() in the Source:

user@dhost:~/linux/kernel/torvalds4$ grep -n -E 'cgroup_name[(]' --include '*.c' --include '*.h' -r .
./include/linux/cgroup.h:592:static inline int cgroup_name(struct cgroup *cgrp, char *buf, size_t buflen)
./include/linux/cgroup.h:602:static inline void pr_cont_cgroup_name(struct cgroup *cgrp)
./kernel/cgroup/debug.c:103:		cgroup_name(c, name_buf, NAME_MAX + 1);
./kernel/cgroup/cpuset.c:4237:		pr_cont_cgroup_name(cs->css.cgroup);
./kernel/cgroup/cpuset.c:4878:	pr_cont_cgroup_name(cgrp);
./mm/page_owner.c:384:	cgroup_name(memcg->css.cgroup, name, sizeof(name));
./tools/perf/util/cgroup.c:216:static int add_cgroup_name(const char *fpath, const struct stat *sb __maybe_unused,
./tools/perf/util/cgroup.c:235:static int check_and_add_cgroup_name(const char *fpath)
./tools/perf/util/cgroup.c:245:	return add_cgroup_name(fpath, NULL, FTW_D, NULL);
./tools/perf/util/cgroup.c:278:			ret = check_and_add_cgroup_name(s);
./tools/perf/util/cgroup.c:283:			if (check_and_add_cgroup_name("/") < 0)
./debian/linux-headers/usr/src/linux-headers-6.7.0-rc2-rtl-v0.2-nokcsan-00027-g9b71d857b080-dirty/include/linux/cgroup.h:592:static inline int cgroup_name(struct cgroup *cgrp, char *buf, size_t buflen)
./debian/linux-headers/usr/src/linux-headers-6.7.0-rc2-rtl-v0.2-nokcsan-00027-g9b71d857b080-dirty/include/linux/cgroup.h:602:static inline void pr_cont_cgroup_name(struct cgroup *cgrp)
user@host:~/linux/kernel/torvalds4$

Here in the line 103 the return value of cgroup_name() is ignored:

kernel/cgroup/debug.c:
  87 static int current_css_set_cg_links_read(struct seq_file *seq, void *v)
  88 {
  89         struct cgrp_cset_link *link;
  90         struct css_set *cset;
  91         char *name_buf;
  92
  93         name_buf = kmalloc(NAME_MAX + 1, GFP_KERNEL);
  94         if (!name_buf)
  95                 return -ENOMEM;
  96
  97         spin_lock_irq(&css_set_lock);
  98         rcu_read_lock();
  99         cset = task_css_set(current);
100         list_for_each_entry(link, &cset->cgrp_links, cgrp_link) {
101                 struct cgroup *c = link->cgrp;
102
103                 cgroup_name(c, name_buf, NAME_MAX + 1);
104                 seq_printf(seq, "Root %d group %s\n",
105                            c->root->hierarchy_id, name_buf);
106         }
107         rcu_read_unlock();
108         spin_unlock_irq(&css_set_lock);
109         kfree(name_buf);
110         return 0;
111 }

mm/page_owner.c:384:

	cgroup_name(memcg->css.cgroup, name, sizeof(name));

Referenced in 8 files:

     kernel/cgroup/debug.c, line 103
     mm/page_owner.c, line 384

All the other references of cgroup_name are struct or struct members:

     tools/perf/util/cgroup.c
         line 211
         line 229
         line 242
         line 245
         line 255
         line 296
         line 339
         line 415
     tools/tracing/rtla/src/osnoise_hist.c
         line 571
         line 574
         line 866
     tools/tracing/rtla/src/osnoise_top.c
         line 415
         line 418
         line 699
     tools/tracing/rtla/src/timerlat_hist.c
         line 645
         line 648
         line 986
         line 1061
         line 1061
     tools/tracing/rtla/src/timerlat_top.c
         line 479
         line 482
         line 796
         line 880
         line 880
     tools/tracing/rtla/src/timerlat_u.c
         line 66
         line 67

And this is the only place where cgroup_name() is invoked.

Second place where the strlcpy() -> strscpy() is replaced is here:

  141 static int kernfs_path_from_node_locked(struct kernfs_node *kn_to,
  142                                         struct kernfs_node *kn_from,
  143                                         char *buf, size_t buflen)
  144 {
  145         struct kernfs_node *kn, *common;
  146         const char parent_str[] = "/..";
  147         size_t depth_from, depth_to, len = 0;
  148         int i, j;
  149
  150         if (!kn_to)
  151                 return strscpy(buf, "(null)", buflen);
  152
  153         if (!kn_from)
  154                 kn_from = kernfs_root(kn_to)->kn;
  155
  156         if (kn_from == kn_to)
  157                 return strscpy(buf, "/", buflen);
  158
  159         common = kernfs_common_ancestor(kn_from, kn_to);
  160         if (WARN_ON(!common))
  161                 return -EINVAL;
  162
  163         depth_to = kernfs_depth(common, kn_to);
  164         depth_from = kernfs_depth(common, kn_from);
  165
  166         buf[0] = '\0';
  167
  168         for (i = 0; i < depth_from; i++)
  169                 len += strscpy(buf + len, parent_str,
  170                                len < buflen ? buflen - len : 0);
  171
  172         /* Calculate how many bytes we need for the rest */
  173         for (i = depth_to - 1; i >= 0; i--) {
  174                 for (kn = kn_to, j = 0; j < i; j++)
  175                         kn = kn->parent;
  176                 len += strscpy(buf + len, "/",
  177                                len < buflen ? buflen - len : 0);
  178                 len += strscpy(buf + len, kn->name,
  179                                len < buflen ? buflen - len : 0);
  180         }
  181
  182         return len;
  183 }

This is safe, as in line 151 "(null)" cannot overrun buf of buflen which
is sizeof(kernfs_pr_cont_buf) which is PATH_MAX:

   29 static char kernfs_pr_cont_buf[PATH_MAX];

Line 157 cannot possibly overrun buf, and it is equivalent to strlcpy()
in all cases where there is no possibility of overrun.

Lines 169, 176 and 178 carefully check if (len < buflen) and copy buflen - len
or zero bytes.

This is safe, for we see that in case of count == 0 strscpy() just like
strlcpy() turns to a virtual NOP.

Finally here:

  856 static struct kernfs_node *kernfs_walk_ns(struct kernfs_node *parent,
  857                                           const unsigned char *path,
  858                                           const void *ns)
  859 {
  860         size_t len;
  861         char *p, *name;
  862
  863         lockdep_assert_held_read(&kernfs_root(parent)->kernfs_rwsem);
  864
  865         spin_lock_irq(&kernfs_pr_cont_lock);
  866
  867         len = strscpy(kernfs_pr_cont_buf, path, sizeof(kernfs_pr_cont_buf));
  868
  869         if (unlikely(len == -E2BIG)) {
  870                 spin_unlock_irq(&kernfs_pr_cont_lock);
  871                 return NULL;
  872         }
  873
  874         p = kernfs_pr_cont_buf;
  875
  876         while ((name = strsep(&p, "/")) && parent) {
  877                 if (*name == '\0')
  878                         continue;
  879                 parent = kernfs_find_ns(parent, name, ns);
  880         }
  881
  882         spin_unlock_irq(&kernfs_pr_cont_lock);
  883
  884         return parent;
  885 }

the previous test was

	if (len >= sizeof(kernfs_pr_cont_buf))

which is safely replaced by

	if (len == -E2BIG)

For both will happen if and only if the string overruns the buffer.

CONCLUSION

The only place where the src string can overrun the buffer is here:

   54 static int kernfs_name_locked(struct kernfs_node *kn, char *buf, size_t buflen)
   55 {
   56         size_t len;
   57
   58         if (!kn)
   59                 return strscpy(buf, "(null)", buflen);
   60
   61         len = strscpy(buf, kn->parent ? kn->name : "/", buflen);
   62
   63         if (unlikely(len == -E2BIG)) {
   64                 return buflen - 1;
   65         } else
   66                 return len;
   67 }

and this function is only called from

  201 int kernfs_name(struct kernfs_node *kn, char *buf, size_t buflen)
  202 {
  203         unsigned long flags;
  204         int ret;
  205
  206         read_lock_irqsave(&kernfs_rename_lock, flags);
  207         ret = kernfs_name_locked(kn, buf, buflen);
  208         read_unlock_irqrestore(&kernfs_rename_lock, flags);
  209         return ret;
  210 }

and

592 static inline int cgroup_name(struct cgroup *cgrp, char *buf, size_t buflen)
593 {
594         return kernfs_name(cgrp->kn, buf, buflen);
595 }

Both kernfs_name() and cgroup_name() are only called while ignoring their return
value in:

  247 void pr_cont_kernfs_name(struct kernfs_node *kn)
  248 {
  249         unsigned long flags;
  250
  251         spin_lock_irqsave(&kernfs_pr_cont_lock, flags);
  252
  253 →       kernfs_name(kn, kernfs_pr_cont_buf, sizeof(kernfs_pr_cont_buf));
  254         pr_cont("%s", kernfs_pr_cont_buf);
  255
  256         spin_unlock_irqrestore(&kernfs_pr_cont_lock, flags);
  257 }

and

kernel/cgroup/debug.c:
  87 static int current_css_set_cg_links_read(struct seq_file *seq, void *v)
  88 {
  89         struct cgrp_cset_link *link;
  90         struct css_set *cset;
  91         char *name_buf;
  92
  93         name_buf = kmalloc(NAME_MAX + 1, GFP_KERNEL);
  94         if (!name_buf)
  95                 return -ENOMEM;
  96
  97         spin_lock_irq(&css_set_lock);
  98         rcu_read_lock();
  99         cset = task_css_set(current);
100         list_for_each_entry(link, &cset->cgrp_links, cgrp_link) {
101                 struct cgroup *c = link->cgrp;
102
103 →               cgroup_name(c, name_buf, NAME_MAX + 1);
104                 seq_printf(seq, "Root %d group %s\n",
105                            c->root->hierarchy_id, name_buf);
106         }
107         rcu_read_unlock();
108         spin_unlock_irq(&css_set_lock);
109         kfree(name_buf);
110         return 0;
111 }

This indicates that the change of semanthics from returning unfortunate

  59 return strlcpy(buf, kn->parent ? kn->name : "/", buflen);

and in effect unwanted strlen(kn->name) does not affect the rest of kernel.
Which is more luck than expected.

Linus in [3] says [quote]:

	The reason to use strscpy() is to *avoid* doing the strlen() on the
	source, and limit things to the limited size.

	If you need to do the strlen(), then use strlcpy(). It's a broken
	interface, but creating this kind of horror wrapper that does the same
	thing as strlcpy() is worse than just using the regular version.

	So the strscpy() conversion should *only* be done if the caller
	doesn't care about the difference in return values (or done *together*
	with changing the caller to use the nicer strscpy() return value).

We are in this case lucky because none of the final callers in the stack trace
cares about the return value of kernfs_name_locked(), or the value in other
functions isn't changed at all, because buffer overrun is carefully avoided
by calculations ensuring len < buflen.

I am just running the kernel with this patch applied, but I don't know of the
border case selftests for the kernfs_name() and cgroup_name() overrun.

REFERENCES:

[1] https://lwn.net/Articles/659214/

[2] https://elixir.bootlin.com/linux/latest/source/lib/string.c#L122

[3] https://lore.kernel.org/lkml/CAHk-=wg7pwWiF4eWVTfFYkfAk_5YDHkmkgZ04cgXkNUO_9pR3A@mail.gmail.com/

Hope this helps.

Best regards,
Mirsad Todorovac


> Thanks.
> 
