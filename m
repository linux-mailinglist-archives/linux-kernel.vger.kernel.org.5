Return-Path: <linux-kernel+bounces-38885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 602D883C7C5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA7101F27B8A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A80129A96;
	Thu, 25 Jan 2024 16:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8ZlJM99"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8D7745FC
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 16:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706199695; cv=none; b=m7gkTlbOMvgpSUmCoeDLquDOj946Jzvg6YJz91ufPtmqV6wORauwiwKqA2SE9gj7a+GjB85Dsvry3oNZVQ7ukdBo4kQ5v34RCQhnXEiP8wPu+DqBF6zN6nEPQ8RkxZ4eUG75/2tk7xgQ0wmctccqPuBOGcgMd0Ku/c1wzNsED7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706199695; c=relaxed/simple;
	bh=JvLVFnISqE73WkRD/N7UfmvUefbJvc30TLYDv1/a2Pk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mIZthFCpn/aH+4oPAmyykmxFls891Sk8MwiCmEO56VHquOwRI1q2MlirWyL1t7z40A8hlf//jXRXmYeM6ZNXYYyrFkrQYF6vXwH3QVmzfbIAShbCFBrrYXal5iaeGOOgfZucQ9Vt1PbOVUgutH0Z98wZnOO/JwEYq25ZvkQlyvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H8ZlJM99; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7ba903342c2so384397339f.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 08:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706199693; x=1706804493; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=LWVj8hVRfJc4tVhdUu/VBqkc8LQiqbjn+xQOE8V4Uzw=;
        b=H8ZlJM99ho9D3HeA1ElhzfbTct/AnaHR+enDsWS9kgq1rN3gfDXi7XRXIfqg6y6YpR
         SNnO0MqNA1yocXnvv+i66F5aMngtbFOq4df/Zwj9U+D3ASt8BoPr/02Jy2NpJs+ezrie
         6jsW7Ix4qdwDvZUTdSv/T6dUeOZ0W+6hu8hLfiLes/Q3K1QjtXlncPIg/cTXMnJqqZ3D
         mFEiP/ZTyR1ZNOm8ehy3xBuiV3jNUd9tnsWaEieUiR5Ph7K2uU+rKV31w9fRqwICHAuR
         nrZBTECTd5ZIOSvG/KwCOfEiwafC7c1lf1TfJ8gtg4ErZCeteVWYEtKLrtcfl2mCmLvr
         oLpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706199693; x=1706804493;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LWVj8hVRfJc4tVhdUu/VBqkc8LQiqbjn+xQOE8V4Uzw=;
        b=VNXyI0RV3HZhF5b1lJW9SE7Gd0HV2nRbIZ13WFZFyijgrmRiD7EckGCGPzmGbNljkP
         qYVypSJYrXFFHDP5+VZakLrg2cyvRHO7jGE5/f8ti3xdQftpn2yg6s6MjDMUHp2zkPyu
         Ehu17JMnW8Sx2q61seH9gNpcbbplz6S7OOimU7tbHgrVYeRs6OU09OSoXwQksspDMpzN
         Ce4c6WuPpiodazKTrsoEEBjpDkIGslygmbg10AI3CE5vWA5l25CuHUEyRxOvOWYPobmm
         Ad5ew4pepe2n+sipSQvwq+uBqLLNMI8ZxYwUN0zmWgZbI58F9KHjl3vr630D+edCdVPu
         HVyw==
X-Gm-Message-State: AOJu0YxlpUJz7AxcLuTm5oh5UYEMUL1eNI0KV3TCrw/P5a8iXZALG1IY
	3HAiilN9QhRk+kxiIu+XuG/K7I7rk7fmYBLWp/Tq4XzVle/3M6guwxYIcFzs
X-Google-Smtp-Source: AGHT+IEtqr0pRrHRDTG7pTzaB0UgsK4mD1AFaPlaHTMKctVtEocduPhPMUg9aFddoqlpSdrp7fDBLA==
X-Received: by 2002:a6b:7f42:0:b0:7be:427c:37da with SMTP id m2-20020a6b7f42000000b007be427c37damr1601168ioq.27.1706199692786;
        Thu, 25 Jan 2024 08:21:32 -0800 (PST)
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id b22-20020a63cf56000000b005cd86cd9055sm13763301pgj.1.2024.01.25.08.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 08:21:32 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 25 Jan 2024 06:21:31 -1000
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH wq/for-6.9] tools/workqueue/wq_dump.py: Clean up code and
 drop duplicate information
Message-ID: <ZbKKi2cnczB0MuV_@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

- Factor out wq_type_str()

- Improve formatting so that it adapts to actual field widths.

- Drop duplicate information from "Workqueue -> rescuer" section. If
  anything, we should add more rescuer-specific info - e.g. the number of
  work items rescued.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
---
I'm applying this to wq/for-6.9.

Thanks.

 tools/workqueue/wq_dump.py |   69 ++++++++++++++++++++++-----------------------
 1 file changed, 35 insertions(+), 34 deletions(-)

--- a/tools/workqueue/wq_dump.py
+++ b/tools/workqueue/wq_dump.py
@@ -75,6 +75,20 @@ def cpumask_str(cpumask):
         output += f'{v:08x}'
     return output.strip()
 
+wq_type_len = 9
+
+def wq_type_str(wq):
+    if wq.flags & WQ_UNBOUND:
+        if wq.flags & WQ_ORDERED:
+            return f'{"ordered":{wq_type_len}}'
+        else:
+            if wq.unbound_attrs.affn_strict:
+                return f'{"unbound,S":{wq_type_len}}'
+            else:
+                return f'{"unbound":{wq_type_len}}'
+    else:
+        return f'{"percpu":{wq_type_len}}'
+
 worker_pool_idr         = prog['worker_pool_idr']
 workqueues              = prog['workqueues']
 wq_unbound_cpumask      = prog['wq_unbound_cpumask']
@@ -92,6 +106,10 @@ WQ_AFFN_CACHE           = prog['WQ_AFFN_
 WQ_AFFN_NUMA            = prog['WQ_AFFN_NUMA']
 WQ_AFFN_SYSTEM          = prog['WQ_AFFN_SYSTEM']
 
+WQ_NAME_LEN             = prog['WQ_NAME_LEN'].value_()
+
+cpumask_str_len         = len(cpumask_str(wq_unbound_cpumask))
+
 print('Affinity Scopes')
 print('===============')
 
@@ -148,24 +166,13 @@ print('')
 print('Workqueue CPU -> pool')
 print('=====================')
 
-print('[    workqueue     \     type   CPU', end='')
+print(f'[{"workqueue":^{WQ_NAME_LEN-2}}\\ {"type   CPU":{wq_type_len}}', end='')
 for cpu in for_each_possible_cpu(prog):
     print(f' {cpu:{max_pool_id_len}}', end='')
 print(' dfl]')
 
 for wq in list_for_each_entry('struct workqueue_struct', workqueues.address_of_(), 'list'):
-    print(f'{wq.name.string_().decode()[-24:]:24}', end='')
-    if wq.flags & WQ_UNBOUND:
-        if wq.flags & WQ_ORDERED:
-            print(' ordered   ', end='')
-        else:
-            print(' unbound', end='')
-            if wq.unbound_attrs.affn_strict:
-                print(',S ', end='')
-            else:
-                print('   ', end='')
-    else:
-        print(' percpu    ', end='')
+    print(f'{wq.name.string_().decode():{WQ_NAME_LEN}} {wq_type_str(wq):10}', end='')
 
     for cpu in for_each_possible_cpu(prog):
         pool_id = per_cpu_ptr(wq.cpu_pwq, cpu)[0].pool.id.value_()
@@ -178,29 +185,23 @@ for wq in list_for_each_entry('struct wo
 
 print('')
 print('Workqueue -> rescuer')
-print('=====================')
-print(f'wq_unbound_cpumask={cpumask_str(wq_unbound_cpumask)}')
-print('')
-print('[    workqueue     \     type            unbound_cpumask     rescuer                  pid   cpumask]')
+print('====================')
+
+ucpus_len = max(cpumask_str_len, len("unbound_cpus"))
+rcpus_len = max(cpumask_str_len, len("rescuer_cpus"))
+
+print(f'[{"workqueue":^{WQ_NAME_LEN-2}}\\ {"unbound_cpus":{ucpus_len}}    pid {"rescuer_cpus":{rcpus_len}} ]')
 
 for wq in list_for_each_entry('struct workqueue_struct', workqueues.address_of_(), 'list'):
-    print(f'{wq.name.string_().decode()[-24:]:24}', end='')
-    if wq.flags & WQ_UNBOUND:
-        if wq.flags & WQ_ORDERED:
-            print(' ordered   ', end='')
-        else:
-            print(' unbound', end='')
-            if wq.unbound_attrs.affn_strict:
-                print(',S ', end='')
-            else:
-                print('   ', end='')
-        print(f' {cpumask_str(wq.unbound_attrs.cpumask):24}', end='')
+    if not (wq.flags & WQ_MEM_RECLAIM):
+        continue
+
+    print(f'{wq.name.string_().decode():{WQ_NAME_LEN}}', end='')
+    if wq.unbound_attrs.value_() != 0:
+        print(f' {cpumask_str(wq.unbound_attrs.cpumask):{ucpus_len}}', end='')
     else:
-        print(' percpu    ', end='')
-        print('                         ', end='')
+        print(f' {"":{ucpus_len}}', end='')
 
-    if wq.flags & WQ_MEM_RECLAIM:
-        print(f' {wq.rescuer.task.comm.string_().decode()[-24:]:24}', end='')
-        print(f' {wq.rescuer.task.pid.value_():5}', end='')
-        print(f' {cpumask_str(wq.rescuer.task.cpus_ptr)}', end='')
+    print(f' {wq.rescuer.task.pid.value_():6}', end='')
+    print(f' {cpumask_str(wq.rescuer.task.cpus_ptr):{rcpus_len}}', end='')
     print('')

