Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B437805DBF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 19:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjLESiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 13:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjLESiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 13:38:19 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CBEBA;
        Tue,  5 Dec 2023 10:38:26 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1d05e4a94c3so39958135ad.1;
        Tue, 05 Dec 2023 10:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701801506; x=1702406306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P5TUAzi7j6XeiF4+c49iyLDkQjLI2ZKA3/LaFVYktmw=;
        b=cgdEAZjKd60v1Jbult7PegT+/RxVrV94l8Ub9VfVQxzXZe4O/lcp45QuxcnYtpApDE
         G+bhDNnI+Af6nI/pwL6g+lpOnPFbQa4NUjC+FbdVhztPyJ36ITxkFcaid70akm4UOHVl
         A2wrdXf1Pbh+0tbwVX4t/M0V5AK67EiqKDM+tvnSPY4OQyI7BBvDqqEQlxi+unMwfrQ8
         ODf0DLugx+uzEmxm3t3ztsRKAo3y836AQIK3HMHo2oDOkyPxjuMtTNPCID1w/cN00Gla
         Tow0gUZfEMc7NfkiJtL/N68ECh+hZJdAKjX6eTYmGaaOeQXq+6x+N+s8GqivRq2q96Qz
         snyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701801506; x=1702406306;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P5TUAzi7j6XeiF4+c49iyLDkQjLI2ZKA3/LaFVYktmw=;
        b=soaqjCTfTDvi3VnPRmusKm7llH51TZHLBW/FUPhm11gNNzHyIxD3QtmnmT8QLAjxI4
         qZCcqSG9OdMshf8peyD1rviHaq5BisR0PI4DG6MzJ/LH5Kn3peRXmunVwrMWIVGikCdu
         vwTjDpaRBvDMHEDxRRkjwDl8FiNGruXt9uw9CDENTMqXcV/mcGBtvGOQ89KrXxSuZ8Ub
         HuHjva3a2oPhU4O4TEnv28g5LUJQ06xquqm8zPBLFhl72pcIIcRreIJPtDHSMrIFXYhe
         jyMoQJ61sQCwqcQhlZIxrwIMaNNQ0iD06i2U1pzPNOcZJO5P93XBk2nqB6XKVdsU+Z6T
         sDUA==
X-Gm-Message-State: AOJu0YyCyo5DbycXw2nTZKhrCtO3YqudVSgBcNwkNJk4mRpYK4aT7lHR
        H+jQL4irDhQ/7sq4DUuhaxE=
X-Google-Smtp-Source: AGHT+IHK2rlOIoxSOejGVPqn/6zmQ7Wz5TlFj7g3GnusOfOePMb5aG/wfh8ryyMjsb6DEOLUnGaiCg==
X-Received: by 2002:a17:902:e804:b0:1d0:9e59:35e2 with SMTP id u4-20020a170902e80400b001d09e5935e2mr4843794plg.123.1701801505837;
        Tue, 05 Dec 2023 10:38:25 -0800 (PST)
Received: from localhost ([98.97.116.78])
        by smtp.gmail.com with ESMTPSA id t9-20020a170902e84900b001cc131c65besm10574713plg.168.2023.12.05.10.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 10:38:25 -0800 (PST)
Date:   Tue, 05 Dec 2023 10:38:24 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     syzbot <syzbot+06dbd397158ec0ea4983@syzkaller.appspotmail.com>,
        andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        cong.wang@bytedance.com, daniel@iogearbox.net, davem@davemloft.net,
        dsahern@kernel.org, edumazet@google.com, john.fastabend@gmail.com,
        kafai@fb.com, kpsingh@kernel.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        nathan@kernel.org, ndesaulniers@google.com, netdev@vger.kernel.org,
        pabeni@redhat.com, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com, yhs@fb.com,
        yoshfuji@linux-ipv6.org
Message-ID: <656f6e2050d_2df272086c@john.notmuch>
In-Reply-To: <0000000000004f438d060bc6e988@google.com>
References: <0000000000004f438d060bc6e988@google.com>
Subject: RE: [syzbot] [net?] WARNING in tcp_recvmsg_locked (2)
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    8470e4368b0f Merge branch 'net-cacheline-optimizations'
> git tree:       net-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=12094286e80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f8715b6ede5c4b90
> dashboard link: https://syzkaller.appspot.com/bug?extid=06dbd397158ec0ea4983
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1247bee2e80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1285243ce80000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/90007d08e178/disk-8470e436.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/b55270de1cdc/vmlinux-8470e436.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/2237d34b6fec/bzImage-8470e436.xz
> 
> The issue was bisected to:
> 
> commit 965b57b469a589d64d81b1688b38dcb537011bb0
> Author: Cong Wang <cong.wang@bytedance.com>
> Date:   Wed Jun 15 16:20:12 2022 +0000
> 
>     net: Introduce a new proto_ops ->read_skb()
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1087c0d4e80000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=1287c0d4e80000
> console output: https://syzkaller.appspot.com/x/log.txt?x=1487c0d4e80000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+06dbd397158ec0ea4983@syzkaller.appspotmail.com
> Fixes: 965b57b469a5 ("net: Introduce a new proto_ops ->read_skb()")
> 
> WARNING: CPU: 1 PID: 5130 at net/ipv4/tcp.c:2396 tcp_recvmsg_locked+0xa54/0x2490 net/ipv4/tcp.c:2396

I'll take a look. Thanks.
