Return-Path: <linux-kernel+bounces-125969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11590892EBE
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 08:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F27828230C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 06:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92FDF79F6;
	Sun, 31 Mar 2024 06:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9aRYem+"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCBD2566;
	Sun, 31 Mar 2024 06:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711866505; cv=none; b=g0CGOqneIQkHiZNriucZUwLO9kbe0E8Foit49rHI2YSSaocL76WYfsNWizyg11TIjznk9vVAAT02n8ZbhSQ4u7jDZsceImwWh+tLDoRdxxBP2jFJT2hqDJwYJoPD0+tHMBxdKq5xJC/XD1/28I+gbS0HwBi04aztp7usA8WyH/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711866505; c=relaxed/simple;
	bh=LB7ptdrMAx4sQEPDxaAk1zH0ITGjlAtPtX65MPIVCxM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EmXu1eNPBhKmhHFIKea/YOCOJrIoUpQ5a5Yr7qaVMNyPUruJFiFKyh7W1tO+L9svcrj5RqV2ZNBxxxyXgzpGEDqapE81T/nKoQy/ZU5cXVobGPtL+/SDUMY+ylXFJmW5Ly/Xn9FdQ+PoKP71Y2Keq0BY0HenBZdxC+crruNOles=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H9aRYem+; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d71765d3e1so23225081fa.0;
        Sat, 30 Mar 2024 23:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711866502; x=1712471302; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eXZub2IF99KKZPMeups9tz7lKQOPAJZQrkefZgGZ1ro=;
        b=H9aRYem+NZupbIGLCDi9FvqbHayDmaLTQChVQ/BSB5SUgyVVa0wp3cofW0MWrajPqZ
         2a/y8ldcZ33qRlt01hI5CpqCjNhRaM0p8w2xTZodrQOqPiXVk0R44eBC8l0nPeX8PJ5s
         1d1mgeNCOaQ/PfQCPV1AcLJGjViVTpfxdQ+vRh+HRrikT5NMux1tqAW63lxMeexrg4tK
         sytSWVGjuX+DiQKOEqdECplvlBr/5VRjpuu4Ru0KdaYuytA/SjY3bF0H2y4qT6NPiNf2
         3GZccS/JuJXSg2uzL+d0H9ivFw9TAkidgOT3xeYFR1Bfl3JyJkG/aB1F97TdHsuJeAO2
         E2zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711866502; x=1712471302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eXZub2IF99KKZPMeups9tz7lKQOPAJZQrkefZgGZ1ro=;
        b=cJ6RauIAC7XVyRj9gHM91u7fMbmusU8hHCFZT3+qV2Qm2PWQGXt/gjeJ6L/s44TsFD
         tiEBZG9Ov6JRbrGfeta5uWvQ50tKFKLPW5CpEuwIYStWfQItuf/pBOd+HYgZnunz8YFk
         MAT29rd0sSReqrGLXpbcem6psli8F0m6vsdVFbrAi/1+bsuiisP3Nc26EzEbswOAVXKh
         lHlv8R2XyvIqZJe8RIkYY0y1rZvkly7oR5mySU7ge2GsUwJzto8R9mMdWLSyn2rmn66Z
         Kw9bNq931GFSzHqfYeG72zAlhW/VCcgz7BiDyfVObaLG45xgTX5joSEdWk1vemYkp/mE
         uFsA==
X-Forwarded-Encrypted: i=1; AJvYcCWl3iSsd+G4CnUVIU/hQs0DjzNb44bvjtjK66KAVHJsUYcHpqgblYAY+UMx0mmSy9tj6Arbu4HaASSRamLBxTWETur2H29OcjRYR8ZEqnfFFBgwKZ+/wXM+fGQGAon5LAyJ
X-Gm-Message-State: AOJu0YyiU0hTWV3MLDxK47aAlEtFBFlA9lFWFMhcOEzdSOY/UnGZfcRc
	IlBh0avamKv7eFjX2ciOLQ48RQokSwOoHooGYLls20PA/x2trtbv+NRXaIRxHWg=
X-Google-Smtp-Source: AGHT+IGE2LIyj2XWJyWDBwu7miLmUr2/jA7O2yb78z1FABDZheZT500Xxu9K+xW9UNx8z/LsZrxt5Q==
X-Received: by 2002:a05:6512:2214:b0:516:57c:269 with SMTP id h20-20020a056512221400b00516057c0269mr3159875lfu.51.1711866502140;
        Sat, 30 Mar 2024 23:28:22 -0700 (PDT)
Received: from pc636 (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id h20-20020a0565123c9400b005132bdbcbc5sm1081147lfv.135.2024.03.30.23.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 23:28:21 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Sun, 31 Mar 2024 08:28:20 +0200
To: syzbot <syzbot+1fa663a2100308ab6eab@syzkaller.appspotmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@google.com,
	song@kernel.org, syzkaller-bugs@googlegroups.com,
	yonghong.song@linux.dev
Subject: Re: [syzbot] [bpf?] possible deadlock in kvfree_call_rcu
Message-ID: <ZgkChGTru7cc3Nsv@pc636>
References: <000000000000f2f0c0061494e610@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000f2f0c0061494e610@google.com>

On Tue, Mar 26, 2024 at 12:00:22PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11547a65180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4d90a36f0cab495a
> dashboard link: https://syzkaller.appspot.com/bug?extid=1fa663a2100308ab6eab
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 7033999ecd7b

--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3467,19 +3467,19 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
         */
        kmemleak_ignore(ptr);

-       // Set timer to drain after KFREE_DRAIN_JIFFIES.
-       if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING)
-               schedule_delayed_monitor_work(krcp);
-
 unlock_return:
        krc_this_cpu_unlock(krcp, flags);

-       /*
-        * Inline kvfree() after synchronize_rcu(). We can do
-        * it from might_sleep() context only, so the current
-        * CPU can pass the QS state.
-        */
-       if (!success) {
+       if (success) {
+               // Set timer to drain after KFREE_DRAIN_JIFFIES.
+               if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING)
+                       schedule_delayed_monitor_work(krcp);
+       } else {
+               /*
+                * Inline kvfree() after synchronize_rcu(). We can do
+                * it from might_sleep() context only, so the current
+                * CPU can pass the QS state.
+                */
                debug_rcu_head_unqueue((struct rcu_head *) ptr);
                synchronize_rcu();
                kvfree(ptr);

