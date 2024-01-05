Return-Path: <linux-kernel+bounces-18199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FAF8259F1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 19:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87FBC1C23702
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 18:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3333529C;
	Fri,  5 Jan 2024 18:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDo5fh/d"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E709E34571;
	Fri,  5 Jan 2024 18:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-28d0052beb0so843728a91.0;
        Fri, 05 Jan 2024 10:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704478824; x=1705083624; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cA1QJD+pt4QHyUEnOpW94h/8ttdWMX3raPptwGxAX4o=;
        b=UDo5fh/dJaVX7XU2DvauEwpmt2XrD2V7S+2svq0DYCEw4BDe3879BufmTEsPXqFdWA
         IM+/SBGBUvfvnMlNWhId9tYtZiS+4gebemAhRE6QPA/HwfsPiz1u2EjrTs9bdd+d7ydF
         LQRbWePj1nNvG2aHBzwg29jOZvYBMR+4qOYKbePV4A48KjytjNZlXRO/BRmATLOVCi+0
         pqSMMvxjKlfuIdiA1gnkaGapy/1ALff1lAGaVtWxj1AfD/WahTlbHwKgYPpPBrZtnCBU
         lQjMDVRy0qNN/jp6HL0i9DUKznsXd5I1n5mx5SUyKnAfL9u14C4+mZWVjmXavdltw08a
         LAgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704478824; x=1705083624;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cA1QJD+pt4QHyUEnOpW94h/8ttdWMX3raPptwGxAX4o=;
        b=eXrrdVw+WQAMsT6Wv/1yIR8phUwI8r/euRc3k03VmWZLH5HpkGLCeu1PH4UbzeZWgH
         gr31hJGzOP0ud51dcmzbnzALF8fAwGxx5PjWl7eSpSnjQfJ50ECy7JnHmY9pGosTCULM
         0hb0yDtUzmzs/fioxvJI0panOTCtCW/nQV93qWE6VjHIXCzDq4dL9w4ai7/ulinkYvfn
         NfEs5T1jPZHi44xTpW5YGYxlCkA+aKyU9JwGAjCI7oTLlTcEuZjFBHvQI5Tq+w/7SXC4
         hbF/2arKu/uo/XUL1fLClubQ7fLTLByRb7r0G67xVkoUVUzduADZiBGZHVmNRk1ulD4B
         SKng==
X-Gm-Message-State: AOJu0Yw2qCy9TkFk6VMZxkPaa1nL+7b5JijijGY1td1zFDJ+DduVkgr9
	BCJgjtW+gbkv6hJLj6/OoeM=
X-Google-Smtp-Source: AGHT+IHJVqcuL3kBZg8xggCwjnZHnXOJmDM/wpMqStvv4+4ZuLxsEGxru0ywoDH4fT1qEOEcvXu7Pw==
X-Received: by 2002:a17:90a:4008:b0:28c:b704:2d2c with SMTP id u8-20020a17090a400800b0028cb7042d2cmr1953801pjc.27.1704478824109;
        Fri, 05 Jan 2024 10:20:24 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id w1-20020a17090abc0100b0028cad653d05sm1542449pjr.47.2024.01.05.10.20.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jan 2024 10:20:23 -0800 (PST)
Message-ID: <1eb19419-f30e-4d79-bcea-d7025bd1d1c6@gmail.com>
Date: Fri, 5 Jan 2024 10:20:21 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [net?] memory leak in ___neigh_create (2)
Content-Language: en-US
To: syzbot <syzbot+42cfec52b6508887bbe8@syzkaller.appspotmail.com>,
 alexander.mikhalitsyn@virtuozzo.com, davem@davemloft.net, den@openvz.org,
 dsahern@kernel.org, edumazet@google.com, kuba@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 razor@blackwall.org, syzkaller-bugs@googlegroups.com,
 thomas.zeitlhofer+lkml@ze-it.at, wangyuweihx@gmail.com
References: <000000000000a62351060e363bdc@google.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <000000000000a62351060e363bdc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/5/24 09:32, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    2258c2dc850b Merge tag 'for-linus' of git://git.kernel.org..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=16f67b44480000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a4fb7ad9185f1501
> dashboard link: https://syzkaller.appspot.com/bug?extid=42cfec52b6508887bbe8
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14e23d44480000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/0e65a45877eb/disk-2258c2dc.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/7617adf885a8/vmlinux-2258c2dc.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/43fb89ea894a/bzImage-2258c2dc.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+42cfec52b6508887bbe8@syzkaller.appspotmail.com

Is there a way to stop sending multiple such duplicate reports?
-- 
Florian


