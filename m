Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A397D57B6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 18:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343599AbjJXQOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 12:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344146AbjJXQN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 12:13:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672A310C2;
        Tue, 24 Oct 2023 09:13:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 136262188C;
        Tue, 24 Oct 2023 16:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1698164031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=65G5ZNQWiDjqZVlLnnNnzZnK3gIH0P1VMKPcZjBriZw=;
        b=TOKvoMevPK9ep1x5Y2CeGPRRLW0DAGWpE6ozaK8R+CC/sxs3PwbkaAoHUQqKadsBI7W5CT
        8medDQxT17HuuX36Ew6x5AEaX+tYoYm9IGay5lKwvgK5sx5/PyJlXgrZ+S25XTGRmaLrxl
        tUF+0blB2NJIJsdSqHNta8nTaylXRN4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C98321391C;
        Tue, 24 Oct 2023 16:13:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qXU6MD7tN2UIZAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 24 Oct 2023 16:13:50 +0000
Date:   Tue, 24 Oct 2023 18:13:49 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christian Brauner <brauner@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>
Subject: Re: [PATCH v8 0/7] cgroup/cpuset: Support remote partitions
Message-ID: <agjgbmdi2yqegjk7p7m52yb3wxmr64ivohbra5wapcd3lwynpw@jjmx6dsboo53>
References: <20230905133243.91107-1-longman@redhat.com>
 <ahevhcy2aa7k3plmfvlepjehs6u3fun3j4oyskdz7axkhftlyi@zr3j473rciwi>
 <f75859e0-04d4-3da2-8df0-eb8841623a7c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f75859e0-04d4-3da2-8df0-eb8841623a7c@redhat.com>
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -6.60
X-Spamd-Result: default: False [-6.60 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_TWELVE(0.00)[12];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 12:03:18PM -0400, Waiman Long <longman@redhat.com> wrote:
> > [chain]
> >    root
> >    |                           \
> >    mid1a                        mid1b
> >     cpuset.cpus=0-1              cpuset.cpus=2-15
> >     cpuset.cpus.partition=root
> >    |
> >    mid2
> >     cpuset.cpus=0-1
> >     cpuset.cpus.partition=root
> >    |
> >    cont
> >     cpuset.cpus=0-1
> >     cpuset.cpus.partition=root
> In this case, the effective CPUs of both mid1a and mid2 will be empty. IOW,
> you can't have any task in these 2 cpusets.

I see, that is relevant to a threaded subtree only where the admin / app
can know how to distribute CPUs and place threads to internal nodes.

> For the remote case, you can have intermediate tasks in both mid1a and mid2
> as long as cpuset.cpus contains more CPUs than cpuset.cpus.exclusive.

It's obvious that cpuset.cpus.exclusive should be exclusive among
siblings.
Should it also be so along the vertical path?

  root
  |                           
  mid1a                       
   cpuset.cpus=0-2
   cpuset.cpus.exclusive=0    
  |
  mid2
   cpuset.cpus=0-2
   cpuset.cpus.exclusive=1
  |
  cont
   cpuset.cpus=0-2
   cpuset.cpus.exclusive=2
   cpuset.cpus.partition=root

IIUC, this should be a valid config regardless of cpuset.cpus.partition
setting on mid1a and mid2.
Whereas

  root
  |                           
  mid1a                       
   cpuset.cpus=0-2
   cpuset.cpus.exclusive=0    
  |
  mid2
   cpuset.cpus=0-2
   cpuset.cpus.exclusive=1-2
   cpuset.cpus.partition=root
  |
  cont
   cpuset.cpus=1-2
   cpuset.cpus.exclusive=1-2
   cpuset.cpus.partition=root

Here, I'm hesitating, will mid2 have any exclusively owned cpus?

(I have flashes of understading cpus.exclusive as being a more
expressive mechanism than partitions. OTOH, it seems non-intuitive when
both are combined, thus I'm asking to internalize it better.
Should partitions be deprecated for simplicty? They're still good to
provide the notification mechanism of invalidation.
cpuset.cpus.exclusive.effective don't have that.)

> They will be ready eventually. This requirement of remote partition actually
> came from our OpenShift team as the use of just local partition did not meet
> their need. They don't need access to exclusive CPUs in the parent cgroup
> layer for their management daemons. They do need to activate isolated
> partition in selected child cgroups to support our Telco customers to run
> workloads like DPDK.
> 
> So they will add the support to upstream Kubernetes.

Is it worth implementing anything touching (ancestral)
cpuset.cpus.partition then?

Thanks,
Michal

