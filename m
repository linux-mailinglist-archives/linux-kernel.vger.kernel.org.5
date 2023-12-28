Return-Path: <linux-kernel+bounces-12393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E768C81F421
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 03:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5603AB2184B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 02:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE56110B;
	Thu, 28 Dec 2023 02:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="EVG2idgk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5884310E4
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 02:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d430bac207so21805885ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 18:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1703730538; x=1704335338; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L9b6zoFhTsQdqlwbUa5zffkYVuCCwTirUAw7XRk7ZME=;
        b=EVG2idgkQ/dH0EQN3xaCwwcLL7uvgiFGWigC1BEE19SHZYBNDOG2AAKFC3JpjUM6ph
         Fm8NssbKa8Ng12qBcx+L//a79E0o5sy0IQyczrRwkPR+NDusVeOFfc+3SqBGCXzoexAq
         mkV0Bf/3GhsSKeU5d23egwYn56yrqPewR304018yRiVNHxsbAUnXtUdlJ1fo4aijn/63
         gnsvvGfSGvNUVdIKfOnchEVwC/MuAG9oMhMdpD/h6AI5BGpaSrlZkVL2pvyYbtTcNxXR
         45adEEXCB5/YGDRLerUsFEhSFlVRELD2aL0W+5w8X+kyK+DWYgbXiztIoVUez3pft/6m
         Ut1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703730538; x=1704335338;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L9b6zoFhTsQdqlwbUa5zffkYVuCCwTirUAw7XRk7ZME=;
        b=iOpegC+uRJyXyKstqoiujy+6r5NbwGfbryzQxNMzSGKo0CGOohzSn8z9bNGv9zBke9
         Xexr05yWX/9Red3+PGiqzpVspCJ8/cJnVdJvUr6pfijVbN6FY+TK14HIEYgPbfMIo6N5
         uh48WX3H+iKQc14bQB9h4RrKr6ToZ63QZl7QPEWN7v3nRrJo8XZ/Mdw5o/+rwQgSKsN8
         KKVddP7Zvu5y8gqUUiL3qKZkv8korp+JRBVe6OZWM1uNmMndPFi8VHnNXdD8RKNrJhN+
         Jz7kUBLUJdDgStjbGUWwEz5bvbVbMlcnJLdBz5Y8d4mfla2ZigrZ0VcySdReYoI0wpPt
         DY0w==
X-Gm-Message-State: AOJu0Yzb+AegwrZspT9I7h1uaShe5k22titSR669v9zhFb1J1tXs56Fc
	WVg/l/biUXiQXsrv9Rv2JAV+ymSFEMgYKg==
X-Google-Smtp-Source: AGHT+IHQP6848dz6WO2/MRcWA0EKWw6u4tZgtShfJWCF7j5g2cz9p431rCkqyxXJt+yAd9Czf79IMQ==
X-Received: by 2002:a17:902:c412:b0:1d4:3dfa:6060 with SMTP id k18-20020a170902c41200b001d43dfa6060mr9704231plk.52.1703730538535;
        Wed, 27 Dec 2023 18:28:58 -0800 (PST)
Received: from [10.5.81.224] ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id n10-20020a1709026a8a00b001ab39cd875csm12695873plk.133.2023.12.27.18.28.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Dec 2023 18:28:58 -0800 (PST)
Message-ID: <59815d0e-2f44-408e-a81d-989df3323f72@bytedance.com>
Date: Thu, 28 Dec 2023 10:28:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [crypto?] general protection fault in
 scatterwalk_copychunks (5)
Content-Language: en-US
To: syzbot <syzbot+3eff5e51bf1db122a16e@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, chrisl@kernel.org, davem@davemloft.net,
 herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org, nphamcs@gmail.com,
 syzkaller-bugs@googlegroups.com, yosryahmed@google.com
References: <0000000000000b05cd060d6b5511@google.com>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <0000000000000b05cd060d6b5511@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2023/12/26 23:28, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    39676dfe5233 Add linux-next specific files for 20231222
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=172080a1e80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f3761490b734dc96
> dashboard link: https://syzkaller.appspot.com/bug?extid=3eff5e51bf1db122a16e
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=178f6e26e80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15c399e9e80000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/360542c2ca67/disk-39676dfe.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/900dfb21ca8a/vmlinux-39676dfe.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/c94a2a3ea0e0/bzImage-39676dfe.xz
> 
> The issue was bisected to:
> 
> commit 7bc134496bbbaacb0d4423b819da4eca850a839d
> Author: Chengming Zhou <zhouchengming@bytedance.com>
> Date:   Mon Dec 18 11:50:31 2023 +0000
> 
>     mm/zswap: change dstmem size to one page
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15f60c36e80000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=17f60c36e80000
> console output: https://syzkaller.appspot.com/x/log.txt?x=13f60c36e80000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+3eff5e51bf1db122a16e@syzkaller.appspotmail.com
> Fixes: 7bc134496bbb ("mm/zswap: change dstmem size to one page")
> 

#syz test

diff --git a/crypto/scompress.c b/crypto/scompress.c
index 442a82c9de7d..b108a30a7600 100644
--- a/crypto/scompress.c
+++ b/crypto/scompress.c
@@ -117,6 +117,7 @@ static int scomp_acomp_comp_decomp(struct acomp_req *req, int dir)
 	struct crypto_scomp *scomp = *tfm_ctx;
 	void **ctx = acomp_request_ctx(req);
 	struct scomp_scratch *scratch;
+	unsigned int dlen;
 	int ret;
 
 	if (!req->src || !req->slen || req->slen > SCOMP_SCRATCH_SIZE)
@@ -128,6 +129,8 @@ static int scomp_acomp_comp_decomp(struct acomp_req *req, int dir)
 	if (!req->dlen || req->dlen > SCOMP_SCRATCH_SIZE)
 		req->dlen = SCOMP_SCRATCH_SIZE;
 
+	dlen = req->dlen;
+
 	scratch = raw_cpu_ptr(&scomp_scratch);
 	spin_lock(&scratch->lock);
 
@@ -145,6 +148,9 @@ static int scomp_acomp_comp_decomp(struct acomp_req *req, int dir)
 				ret = -ENOMEM;
 				goto out;
 			}
+		} else if (req->dlen > dlen) {
+			ret = -ENOSPC;
+			goto out;
 		}
 		scatterwalk_map_and_copy(scratch->dst, req->dst, 0, req->dlen,
 					 1);

