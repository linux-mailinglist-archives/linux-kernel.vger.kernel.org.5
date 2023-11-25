Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525F47F9054
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 00:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjKYXda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 18:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjKYXd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 18:33:27 -0500
Received: from domac.alu.hr (unknown [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3E0A6
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 15:33:31 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id C930E60197;
        Sun, 26 Nov 2023 00:33:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1700955207; bh=GEVDOrFB6DUV4hWsyFKOA6T6PhBDDwgYp9Fndc6rWDM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=sszf3XjLywjt1YAukyxXE7IQ4wvj6JAO0LUS78kK+K1hzI1CYdzgTBMzx8MuOSEnx
         llNFlaJPBR2283IYyNAlMtPr3UIUum9CHkmu8WmiupWghKxZ0365WXuPkzoQd3uz4k
         HRXKcaNahcafO2Gkbkzh/Quuu9lK4HvhvOBCN+2Ik1bwAAhK4wlk6AOJ8VSqbSNJxc
         yk4zjAJ2te4Colrvs8IMybp1wm1E9O29q83sdBEtYLw3kDGEVF6wWgRaApgdUCKaoz
         pP+jYYNDyc35vfMlfn4f1WegH5yRvCC/haVeHKrPQAjZ93An0HrDMKN7wed6pBguv8
         3pmsQkYNjxAMQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RJ0PvvF6_fOJ; Sun, 26 Nov 2023 00:33:25 +0100 (CET)
Received: from [192.168.1.6] (78-0-136-201.adsl.net.t-com.hr [78.0.136.201])
        by domac.alu.hr (Postfix) with ESMTPSA id 0647160186;
        Sun, 26 Nov 2023 00:33:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1700955205; bh=GEVDOrFB6DUV4hWsyFKOA6T6PhBDDwgYp9Fndc6rWDM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=USEdzcoC0LxwyKmIyXixSEYQGnQC3lntvXjy++zMTYkJb12nZev0QdM9tZ47jqERK
         9QHDIu3knvEtaia/sQy352Og8AczH65qigHc6ZcH2PMtp0ti8btvUYy5cVHkPmULst
         Q08ewqdBe9sMYEUK6jn70MtsDbRbz+F51VOC/37XcXkPxcpMzbO3oAyzIh1amahwzw
         OdxQhGkPV5TJiVEUyuWrjTDLvr61DV615HNWJjWMgU1394yzODzfOHb9nrDWwdEul8
         W/oiz7a3qfI/u4FkJ8AJF8BA+OP95nwhuOt0on5jEejKTlHjMFdA+a223jAUbm4t21
         gUcBTzGOx8yWg==
Message-ID: <2bec82df-f2ed-48cc-abed-240237b4fd53@alu.unizg.hr>
Date:   Sun, 26 Nov 2023 00:33:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/1] kernfs: replace deprecated strlcpy() with
 strscpy()
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Aditya Kali <adityakali@google.com>
References: <20231122212008.11790-1-mirsad.todorovac@alu.unizg.hr>
 <ZV5zQ0gRxzGwweYN@slm.duckdns.org>
 <4a01cd1d-c9c9-4946-add4-1acf6998a24a@alu.unizg.hr>
 <ZWJMhox_E0aBkYE6@mtj.duckdns.org>
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <ZWJMhox_E0aBkYE6@mtj.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Mr. Tejun Heo,

On 11/25/23 20:35, Tejun Heo wrote:
> Hello,
> 
> On Thu, Nov 23, 2023 at 12:37:03AM +0100, Mirsad Todorovac wrote:
> ...
>>   141 static int kernfs_path_from_node_locked(struct kernfs_node *kn_to,
>>   142                                         struct kernfs_node *kn_from,
>>   143                                         char *buf, size_t buflen)
> ...
>>   172         /* Calculate how many bytes we need for the rest */
>>   173         for (i = depth_to - 1; i >= 0; i--) {
>>   174                 for (kn = kn_to, j = 0; j < i; j++)
>>   175                         kn = kn->parent;
>>   176                 len += strscpy(buf + len, "/",
>>   177                                len < buflen ? buflen - len : 0);
>>   178                 len += strscpy(buf + len, kn->name,
>>   179                                len < buflen ? buflen - len : 0);
>>   180         }
>>   181
>>   182         return len;
>>   183 }
> ...
>> This is safe, for we see that in case of count == 0 strscpy() just like
>> strlcpy() turns to a virtual NOP.
> 
> The conversion itself isn't dangerous but it changes the return value of the
> function. The comment is not updated and the callers are still assuming that
> the function returns full length when the buffer is too short. e.g. Take a
> look at cgroup_show_path(). All those paths seem safe but the code is more
> more confusing because the conversions are half-way. I'm not necessarily
> against the conversion but the benefit to risk / churn ratio doesn't seem
> too attractive. If you wanna push this through, please make the conversion
> complete including the comments and the callers and include a short summary
> of the changes and why they're safe in the commit message.
> 
> Thanks.

Thank you kindly for your review of my lengthy analysis of the return value.

I apologise for another long email, but most of it is the code you already
understand or wrote, so it should be easy for you to read.

Apparently, what troubles you is:

1. Lack of comment that the return value of kernfs_name_locked() changed for
strlen(kn->node) >= buflen. This is noted and it is a legitimate concern.

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

Returning strlen(kn->name) that is greater than buflen really does not make any
sense IMHO, as by the first character after buflen we already know we are in
overrun.

Maybe the comment should be like this:

/*
  * The function kernfs_name_locked() returns the name of kernfs_node *kn truncated
  * to buflen - 1 or a "/" if it is the root node.
  *
  * The resulting buffer buf is in any case zero-terminated, and the value returned
  * is the number of actual characters copied (excluding the termination NUL byte).
  */

Would this be clear enough in your opinion?

2. The example with cgroup_show_path() that is of your concern. I have carefully
examined it and there is nothing to worry about.

So, the stacktrace goes like this:

kernel/cgroup/cgroup.c:1879: cgroup_show_path(sf, kf_node, kf_root)
	1893: len = kernfs_path_from_node(kf_node, ns_cgroup->kn, buf, PATH_MAX);

fs/kernfs/dir.c:228: kernfs_path_from_node(to, from, buf, buflen)
	235:  ret = kernfs_path_from_node_locked(to, from, buf, buflen);

fs/kernfs/dir.c:141: kernfs_path_from_node_locked(kn_to, kn_from, buf, buflen)

Let us analyse the stacktrace:

kernel/cgroup/cgroup.c:
=======================
   1879 int cgroup_show_path(struct seq_file *sf, struct kernfs_node *kf_node,
   1880                      struct kernfs_root *kf_root)
   1881 {
   1882         int len = 0;
   1883         char *buf = NULL;
   1884         struct cgroup_root *kf_cgroot = cgroup_root_from_kf(kf_root);
   1885         struct cgroup *ns_cgroup;
   1886
   1887         buf = kmalloc(PATH_MAX, GFP_KERNEL);
   1888         if (!buf)
   1889                 return -ENOMEM;
   1890
   1891         spin_lock_irq(&css_set_lock);
   1892         ns_cgroup = current_cgns_cgroup_from_root(kf_cgroot);
→ 1893         len = kernfs_path_from_node(kf_node, ns_cgroup->kn, buf, PATH_MAX);
   1894         spin_unlock_irq(&css_set_lock);
   1895
   1896         if (len >= PATH_MAX)
   1897                 len = -ERANGE;
   1898         else if (len > 0) {
   1899                 seq_escape(sf, buf, " \t\n\\");
   1900                 len = 0;
   1901         }
   1902         kfree(buf);
   1903         return len;
   1904 }

fs/kernfs/dir.c:
================
    228 int kernfs_path_from_node(struct kernfs_node *to, struct kernfs_node *from,
    229                           char *buf, size_t buflen)
    230 {
    231         unsigned long flags;
    232         int ret;
    233
    234         read_lock_irqsave(&kernfs_rename_lock, flags);
→  235         ret = kernfs_path_from_node_locked(to, from, buf, buflen);
    236         read_unlock_irqrestore(&kernfs_rename_lock, flags);
    237         return ret;
    238 }
    239 EXPORT_SYMBOL_GPL(kernfs_path_from_node);

The problem seems to be this function:
======================================

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
  → 151                 return strscpy(buf, "(null)", buflen);
    152
    153         if (!kn_from)
    154                 kn_from = kernfs_root(kn_to)->kn;
    155
    156         if (kn_from == kn_to)
  → 157                 return strscpy(buf, "/", buflen);
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
  → 169                 len += strscpy(buf + len, parent_str,
    170                                len < buflen ? buflen - len : 0);
    171
    172         /* Calculate how many bytes we need for the rest */
    173         for (i = depth_to - 1; i >= 0; i--) {
    174                 for (kn = kn_to, j = 0; j < i; j++)
    175                         kn = kn->parent;
  → 176                 len += strscpy(buf + len, "/",
    177                                len < buflen ? buflen - len : 0);
  → 178                 len += strscpy(buf + len, kn->name,
    179                                len < buflen ? buflen - len : 0);
    180         }
    181
    182         return len;
    183 }

We have five (5) uses of strlcpy() -> strscpy() conversion.

Line 151: strscpy(buf, "(null)", buflen);
		cannot overrun and immediately returns - return value just as if strlcpy() was used.

Line 157: strscpy(buf, "/", buflen);
		cannot overrun and immediately returns - return value just as if strlcpy() was used.

Line 169: len += strscpy(buf + len, parent_str, len < buflen ? buflen - len : 0);

Line 176: len += strscpy(buf + len, "/",        len < buflen ? buflen - len : 0);

Line 178: len += strscpy(buf + len, kn->name,   len < buflen ? buflen - len : 0);

As you will clearly see, all of those cases are already carefully and cleverly protected already against
overrun. This was apparently done by you and Mr. Aditya Kali. Nothing changes here with replacement
one-for-one strlcpy() -> strscpy(), as there is never a buffer overrun.

In case of overrun, the construct (len < buflen ? buflen - len : 0) will simply give a "count" of
zero, and this will cause an early exit from strscpy().

So, my conclusion is that for callers of kernfs_path_from_node_locked() and kernfs_path_from_node()
nothing changes in semantics or the return value.

For the kernfs_name_locked(), we get a truncated value of kn->name in buf as before, only return
value changes for this special case, but I have explained and I think proven that it is used
nowhere in code.

For the function:

fs/kernfs/dir.c
===============
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

Nothing changes. Neither the truncation of buffer and neither the return value (NULL or parent).

The previous check was:

    860         len = strlcpy(kernfs_pr_cont_buf, path, sizeof(kernfs_pr_cont_buf));
    861
    862         if (len >= sizeof(kernfs_pr_cont_buf)) {
    863                 spin_unlock_irq(&kernfs_pr_cont_lock);
    864                 return NULL;
    865         }

The string is truncated on overrun just as with strlcpy(), and the test

	if (len == -E2BIG)

is equivalent to

	if (len >= sizeof(kernfs_pr_cont_buf))

NOTE:

The forementioned situation in cgroup_show_path():

→ 1893         len = kernfs_path_from_node(kf_node, ns_cgroup->kn, buf, PATH_MAX);
   1894         spin_unlock_irq(&css_set_lock);
   1895
   1896         if (len >= PATH_MAX)
   1897                 len = -ERANGE;
   1898         else if (len > 0) {
   1899                 seq_escape(sf, buf, " \t\n\\");
   1900                 len = 0;
   1901         }

len > PATH_MAX can never happen because:

kernfs_path_from_node(kf_node, ns_cgroup->kn, buf, PATH_MAX);

calls

    234         read_lock_irqsave(&kernfs_rename_lock, flags);
→  235         ret = kernfs_path_from_node_locked(to, from, buf, buflen);
    236         read_unlock_irqrestore(&kernfs_rename_lock, flags);
    237         return ret;

which is evaluated to:

    234         read_lock_irqsave(&kernfs_rename_lock, flags);
→  235         ret = kernfs_path_from_node_locked(to, from, buf, PATH_MAX);
    236         read_unlock_irqrestore(&kernfs_rename_lock, flags);
    237         return ret;

and then to:

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
  → 151                 return strscpy(buf, "(null)", PATH_MAX);
    152
    153         if (!kn_from)
    154                 kn_from = kernfs_root(kn_to)->kn;
    155
    156         if (kn_from == kn_to)
  → 157                 return strscpy(buf, "/", PATH_MAX);
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
  → 169                 len += strscpy(buf + len, parent_str,
    170                                len < PATH_MAX ? PATH_MAX - len : 0);
    171
    172         /* Calculate how many bytes we need for the rest */
    173         for (i = depth_to - 1; i >= 0; i--) {
    174                 for (kn = kn_to, j = 0; j < i; j++)
    175                         kn = kn->parent;
  → 176                 len += strscpy(buf + len, "/",
    177                                len < PATH_MAX ? PATH_MAX - len : 0);
  → 178                 len += strscpy(buf + len, kn->name,
    179                                len < PATH_MAX ? PATH_MAX - len : 0);
    180         }
    181
    182         return len;
    183 }

len will never exceed PATH_MAX, because it is increased by (PATH_MAX - len) or 0 (zero),
as strscpy will copy either PATH_MAX - len or 0 (zero) characters.

The second use of kernfs_path_from_node() appears safe:

   2350 int cgroup_path_ns_locked(struct cgroup *cgrp, char *buf, size_t buflen,
   2351                           struct cgroup_namespace *ns)
   2352 {
   2353         struct cgroup *root = cset_cgroup_from_root(ns->root_cset, cgrp->root);
   2354
→ 2355         return kernfs_path_from_node(cgrp->kn, root->kn, buf, buflen);
   2356 }

According to Bootlin, this covers all uses of the function kernfs_path_from_node():

Defined in 1 files as a prototype:

     include/linux/kernfs.h, line 396 (as a prototype)

Defined in 2 files as a function:

     fs/kernfs/dir.c, line 221 (as a function)
     include/linux/kernfs.h, line 476 (as a function)

Documented in 1 files:

     fs/kernfs/dir.c, line 205

Referenced in 3 files:

     fs/kernfs/dir.c
         line 232
         line 265
     include/linux/kernfs.h, line 596
     kernel/cgroup/cgroup.c
         line 1893
         line 2355

Hope this helps.

Best regards,
Mirsad Todorovac
