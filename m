Return-Path: <linux-kernel+bounces-4927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D697D8183E8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DDA31F227E4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3D812B8C;
	Tue, 19 Dec 2023 08:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HdCpDNWB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D3312B60
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 08:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702976128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TlHCpyM+3wgBwfflqBoKKSfR5AdXhOtawNk0i7Xm0PM=;
	b=HdCpDNWB+zDIBBPGvsqRZnQukCp4CI95wfNkaYcKQocdt5en5BmPVhb+Q4eLTMSQV2Mh8+
	+mTLRdp8hfX3+YQcIYyZ6h5eTV1tDAmtdKuUrr5QIZt2geIENoZyLmJpl3EdaUw802FHMr
	sXE7bE+blpbySSluhNfgkYOPJklwv6U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-Q_O4DdrEPL-jkzOob24u9g-1; Tue, 19 Dec 2023 03:55:26 -0500
X-MC-Unique: Q_O4DdrEPL-jkzOob24u9g-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3364fa774ccso3051778f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 00:55:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702976124; x=1703580924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TlHCpyM+3wgBwfflqBoKKSfR5AdXhOtawNk0i7Xm0PM=;
        b=wfyL3Ha33wTcI3GCFDPhuy44+Qgum+XEjfxGsaIN+w4QllwG+2GWnolWkRrMUG9N4e
         548K20iVDTotkYpgR5EyGSDX6WisNRXPZVTAVpLdEEkzsE/Od9M4QYYKuzME/ANQRtci
         Bw3G097VSyhYtAL/6znSPcl3NrrpDOePGk6kYGfaEUZ9ydqr2Ng2l2Ngj8K0CE+B4j/f
         GSrm0w3THVthwmby4yADMCWWVGQ8FmtVvyv3kHRw+rcpJZM8Kx+49/EhOx1LDTo/ij9O
         WdXVTtHamCWRg67xpR08woL1lulcUIBBi2EvNEkhaU1LuoTXKJWg3FPvYqsAOd8nC3X6
         w2yQ==
X-Gm-Message-State: AOJu0YznqRJQTq29l/hwYJ2SFPiXd3YTSCNzhN4MI+NKzyJ8vfHBs5sX
	00tU255FtJvM2qAvxbewim+trxOsQ7Ak+a1PnOdkGQ9cr2N8/34A3Cx2nh4ZcCB89/VD4z6+wiC
	kW2aDiBiXaFRvUk8GsQpQ70ydFRt4N4Qb
X-Received: by 2002:a05:6000:716:b0:336:669c:9b21 with SMTP id bs22-20020a056000071600b00336669c9b21mr2335224wrb.20.1702976124659;
        Tue, 19 Dec 2023 00:55:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH3lKtQOFDKJmNQl5qXbe6iMB0/O5O40lb25JB76tsBZk3LtALPs25vXsYsNEWHlHX8EGUX/w==
X-Received: by 2002:a05:6000:716:b0:336:669c:9b21 with SMTP id bs22-20020a056000071600b00336669c9b21mr2335216wrb.20.1702976124308;
        Tue, 19 Dec 2023 00:55:24 -0800 (PST)
Received: from localhost.localdomain ([151.29.78.8])
        by smtp.gmail.com with ESMTPSA id n8-20020adfe788000000b003364448ae91sm15476710wrm.10.2023.12.19.00.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 00:55:23 -0800 (PST)
Date: Tue, 19 Dec 2023 09:55:21 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: Aaron Tomlin <atomlin@atomlin.com>, linux-kernel@vger.kernel.org,
	jiangshanlai@gmail.com, peterz@infradead.org
Subject: Re: [RFC PATCH 0/2] workqueue: Introduce PF_WQ_RESCUE_WORKER
Message-ID: <ZYFaeR-83eYNWQIz@localhost.localdomain>
References: <ZXdXdBzvbkI4Y4fL@slm.duckdns.org>
 <ZXguMgcKLCLn16T4@localhost.localdomain>
 <ZXiVCOKk90Fjpmhw@slm.duckdns.org>
 <ZXlyfjDsFGbYcMU6@localhost.localdomain>
 <ZXnPVtISKQ2JFDNn@slm.duckdns.org>
 <ZXn4qiMetd7zY1sb@localhost.localdomain>
 <ZXn6J5bN-dPC1WSk@slm.duckdns.org>
 <ZXrmJYvekzrLSaGo@localhost.localdomain>
 <ZXtb066P-ZnjxfgK@slm.duckdns.org>
 <ZXv3RnYNkpaPGYb_@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXv3RnYNkpaPGYb_@localhost.localdomain>

Hello again,

On 15/12/23 07:50, Juri Lelli wrote:
> On 14/12/23 09:47, Tejun Heo wrote:
> > Hello,
> > 
> > On Thu, Dec 14, 2023 at 12:25:25PM +0100, Juri Lelli wrote:
> > > > So, we have to use set_cpus_allowed_ptr() but we still don't want to change
> > > > the affinity of a rescuer which is already running a task for a pool.
> > > 
> > > But then, even today, a rescuer might keep handling work on a cpu
> > > outside its wq cpumask if the associated wq cpumask change can proceed
> > > w/o waiting for it to finish the iteration?
> > 
> > Yeah, that can happen and pool cpumasks naturally being subsets of the wq's
> > cpumask that they're serving, your original approach likely isn't broken
> > either.
> > 
> > > BTW, apologies for all the questions, but I'd like to make sure I can
> > > get the implications hopefully right. :)
> > 
> > I obviously haven't thought through it very well, so thanks for the
> > questions. So, yeah, I think we actually need to set the rescuer's cpumask
> > when wq's cpumask changes and doing it where you were suggesting should
> > probably work.
> 
> OK. Going to send a proper patch asap.

I actually didn't do that yet as it turns out the proposed approach
doesn't cover !WQ_SYSFS unbounded wqs. Well, I thought those should be
covered as well, since we have (initiated by echo <mask> into
/sys/devices/virtual/workqueue/cpumask)

workqueue_apply_unbound_cpumask ->
  apply_wqattrs_commit

but for some reason the mask change is not reflected into rescuers
affinity.

Trying to dig deeper I went ahead and extended the recent wq_dump.py
addition with the following

---
ls/workqueue/wq_dump.py | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/workqueue/wq_dump.py b/tools/workqueue/wq_dump.py
index d0df5833f2c18..6da621989e210 100644
--- a/tools/workqueue/wq_dump.py
+++ b/tools/workqueue/wq_dump.py
@@ -175,3 +175,32 @@ for wq in list_for_each_entry('struct workqueue_struct', workqueues.address_of_(
     if wq.flags & WQ_UNBOUND:
         print(f' {wq.dfl_pwq.pool.id.value_():{max_pool_id_len}}', end='')
     print('')
+
+print('')
+print('Workqueue -> rescuer')
+print('=====================')
+print(f'wq_unbound_cpumask={cpumask_str(wq_unbound_cpumask)}')
+print('')
+print('[    workqueue     \     type            unbound_cpumask     rescuer                  pid   cpumask]')
+
+for wq in list_for_each_entry('struct workqueue_struct', workqueues.address_of_(), 'list'):
+    print(f'{wq.name.string_().decode()[-24:]:24}', end='')
+    if wq.flags & WQ_UNBOUND:
+        if wq.flags & WQ_ORDERED:
+            print(' ordered   ', end='')
+        else:
+            print(' unbound', end='')
+            if wq.unbound_attrs.affn_strict:
+                print(',S ', end='')
+            else:
+                print('   ', end='')
+        print(f' {cpumask_str(wq.unbound_attrs.cpumask):24}', end='')
+    else:
+        print(' percpu    ', end='')
+        print('                         ', end='')
+
+    if wq.flags & WQ_MEM_RECLAIM:
+        print(f' {wq.rescuer.task.comm.string_().decode()[-24:]:24}', end='')
+        print(f' {wq.rescuer.task.pid.value_():5}', end='')
+        print(f' {cpumask_str(wq.rescuer.task.cpus_ptr)}', end='')
+    print('')
---

which shows the following situation after an

# echo 00,00000003 > /sys/devices/virtual/workqueue/cpumask

on the system I'm testing with:

...
Workqueue -> rescuer
=====================
wq_unbound_cpumask=00000003

[    workqueue     \     type            unbound_cpumask     rescuer                  pid   cpumask]
events                   percpu
events_highpri           percpu
events_long              percpu
events_unbound           unbound    0xffffffff 000000ff
events_freezable         percpu
events_power_efficient   percpu
events_freezable_power_  percpu
rcu_gp                   percpu                              kworker/R-rcu_g              4 0xffffffff 000000ff
rcu_par_gp               percpu                              kworker/R-rcu_p              5 0xffffffff 000000ff
slub_flushwq             percpu                              kworker/R-slub_              6 0xffffffff 000000ff
netns                    ordered    0xffffffff 000000ff      kworker/R-netns              7 0xffffffff 000000ff
mm_percpu_wq             percpu                              kworker/R-mm_pe             13 0xffffffff 000000ff
cpuset_migrate_mm        ordered    0xffffffff 000000ff
inet_frag_wq             percpu                              kworker/R-inet_            300 0xffffffff 000000ff
pm                       percpu
cgroup_destroy           percpu
cgroup_pidlist_destroy   percpu
writeback                unbound    0xffffffff 000000ff      kworker/R-write            308 0xffffffff 000000ff
cgwb_release             percpu
cryptd                   percpu                              kworker/R-crypt            314 0xffffffff 000000ff
kintegrityd              percpu                              kworker/R-kinte            315 0xffffffff 000000ff
kblockd                  percpu                              kworker/R-kbloc            316 0xffffffff 000000ff
kacpid                   percpu
kacpi_notify             percpu
kacpi_hotplug            ordered    0xffffffff 000000ff
kec                      ordered    0xffffffff 000000ff
kec_query                percpu
tpm_dev_wq               percpu                              kworker/R-tpm_d            352 0xffffffff 000000ff
usb_hub_wq               percpu
md                       percpu                              kworker/R-md               353 0xffffffff 000000ff
md_misc                  percpu
md_bitmap                unbound    0xffffffff 000000ff      kworker/R-md_bi            354 0xffffffff 000000ff
edac-poller              ordered    0xffffffff 000000ff      kworker/R-edac-            355 0xffffffff 000000ff
...

I guess I expected wq_unbound_cpumask and unbound_cpumask for each
unbound wq to be kept in sync, so I'm evidently missing details. :)

Can you please help me here understanding what am I missing?

Thanks!
Juri


