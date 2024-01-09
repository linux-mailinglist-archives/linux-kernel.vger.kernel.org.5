Return-Path: <linux-kernel+bounces-21234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 920F9828C5A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4198628AA55
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 18:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786063C087;
	Tue,  9 Jan 2024 18:18:21 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3B03BB3A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 18:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36063568308so27572755ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 10:18:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704824299; x=1705429099;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HNpK7gVVocd6D97UNc/uU33LSZEMZP8thvqp4QD621w=;
        b=vJTCf9ji34mMz35/ttXKNXd+Nos53I2f7qIwo/njptK6dDbMTG6ql5uSo/v1TtLFwO
         gP6pjfp7ytS97kkbuN5MnQWofCpMZ6iiSLHPEtmsXWBgtwEGHjQK6JEZUBf6qpx4SCs9
         arJz4I2pWkpGZiKiHlZyRP/c787bpSvrpTuBrjb2kwC6Z1vV4fVPiiiYNJ4Ui/PVitcq
         AYXOg9YVY3TdGKgeMWzUGCntuUZYLZvM8TPi+EXMblsbNaWxQAz/d4piOtbrYKze0Pq8
         k4R+8p5AZEhUv9EfDWxGkJNK8dFsh39WwEQJ1Av3++0dmz65UTl820SDR3lDtbaOcMqP
         LpPg==
X-Gm-Message-State: AOJu0Yx+qEr8Lyjl7bjkycwvFhRU8jbULdFF1RO+3B/OOL+PMC5LzsXW
	uWIIzBZmsFA8jPHtsz0IIKx/Y+UvO090nDZICntAGh55AydB
X-Google-Smtp-Source: AGHT+IFgdzZhVll0vqDBLPtBr0CdUuR3oPuenR201DKKqtRq5gwIMqq5HsJitrmlvd2DvVekAcF1MZDcpzq97v7Ch3Jr1fu3gxYN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b43:b0:35f:ebc7:6065 with SMTP id
 f3-20020a056e020b4300b0035febc76065mr497173ilu.1.1704824299204; Tue, 09 Jan
 2024 10:18:19 -0800 (PST)
Date: Tue, 09 Jan 2024 10:18:19 -0800
In-Reply-To: <000000000000ad704b05f8de7e19@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c237b7060e875640@google.com>
Subject: Re: [v5.15] WARNING in kvm_arch_vcpu_ioctl_run
From: syzbot <syzbot+412c9ae97b4338c5187e@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	jarkko@kernel.org, jmattson@google.com, joro@8bytes.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org, mingo@redhat.com, 
	pbonzini@redhat.com, seanjc@google.com, syzkaller-lts-bugs@googlegroups.com, 
	tglx@linutronix.de, usama.anjum@collabora.com, vkuznets@redhat.com, 
	wanpengli@tencent.com, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

This bug is marked as fixed by commit:
KVM: x86: Remove WARN sanity check on hypervisor timer vs. UNINITIALIZED vCPU

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux 5.15
Dashboard link: https://syzkaller.appspot.com/bug?extid=412c9ae97b4338c5187e

---
[1] I expect the commit to be present in:

1. linux-5.15.y branch of
git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git

