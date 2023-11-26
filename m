Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325BD7F935E
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 16:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjKZPYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 10:24:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjKZPYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 10:24:07 -0500
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B409BEA
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 07:24:13 -0800 (PST)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5b9344d72bbso5026722a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 07:24:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701012253; x=1701617053;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HNpK7gVVocd6D97UNc/uU33LSZEMZP8thvqp4QD621w=;
        b=cULhWvx9n6nWXD4tv3Dbf/nGVivYg80vlT3rMvzIv8g3XapZ/FLvpCWi2JJR/eFNy5
         pJ855PsKbJagYHyXbASqp51Mp2ThTq2ZhxbtKRO66CvB54CA/CakvFQE1IEU7VG845xg
         5WPLyrkCdMWNKTl1rOy2KMy1jjfK+sxC7U6Lb9mfq/EVmCZf6qoDF3ZVBcHB6dDRDyTP
         FK21cM0bRW4M8JuqcW9ZVWvaGre/OQt9tQmqGbcYGh3qyQ57jfqYkb4KxLFiAx3b7sIW
         d8oBg18SddZJc3/xlDDAQnBSfUvzX+QJxCgLrN3Z2+8HtNZ7C33Bn6uDydLYIWXuQCoP
         W1rA==
X-Gm-Message-State: AOJu0YxTSCBRRu8s0lC1fYW4KbX58DLZy8HYyk98Et13R2+c/pSA8Opt
        uIyrd/YTRk+9I+Zf7rVDyA5DwF1SI679Xste8T7oI4pn4rwP
X-Google-Smtp-Source: AGHT+IHAOAsVy5wek93F9Km67otZrKPfh/qWnTHeq/2VAW8gUxQGL4A7oqrdchvA1bvg38ODschC8brnjEtE8xUekYn4XzvjSKbl
MIME-Version: 1.0
X-Received: by 2002:a63:e310:0:b0:5b9:63f2:e4cc with SMTP id
 f16-20020a63e310000000b005b963f2e4ccmr1497584pgh.2.1701012253177; Sun, 26 Nov
 2023 07:24:13 -0800 (PST)
Date:   Sun, 26 Nov 2023 07:24:13 -0800
In-Reply-To: <000000000000ad704b05f8de7e19@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001bfd01060b0fc7dc@google.com>
Subject: Re: [v5.15] WARNING in kvm_arch_vcpu_ioctl_run
From:   syzbot <syzbot+412c9ae97b4338c5187e@syzkaller.appspotmail.com>
To:     bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        jarkko@kernel.org, jmattson@google.com, joro@8bytes.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sgx@vger.kernel.org, mingo@redhat.com, pbonzini@redhat.com,
        seanjc@google.com, syzkaller-lts-bugs@googlegroups.com,
        tglx@linutronix.de, usama.anjum@collabora.com, vkuznets@redhat.com,
        wanpengli@tencent.com, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
