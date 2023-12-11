Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5483480C373
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 09:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjLKIlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 03:41:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjLKIlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 03:41:07 -0500
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CE4B6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 00:41:13 -0800 (PST)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6da00040aafso2575536a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 00:41:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702284072; x=1702888872;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HNpK7gVVocd6D97UNc/uU33LSZEMZP8thvqp4QD621w=;
        b=IscxURfgMC8xA4Rjpo3d0BwcGrfOjPjiPZtLsCf5RPI+f2bRw7Qy7EHCbSsDwtIaVs
         5JmHKS2truGomlo5yZN+jNyvOLmT5Xl8gIRAgLm8XtKTlyDegsyhuY4sepSomeuul8Kj
         cpUio6HdhWG5QRZIeXV7YUocwkbkhNU5HW7i3nbzsNRb83AqR2j2xdHtnzHgjZFYIU/Y
         PVNrI+GSYTvy3xnGfnhUaGZSx7uT4G5PDyxbSu+nZQ0DQGR+OY9eg191a1Vnlx9fxWe9
         h7msJsNWmYGAcvJR9yNNLiIlmteham8AFYzTTGbGRmCEVf64oShxACsGsR30Oyzlu66W
         rGyA==
X-Gm-Message-State: AOJu0Yy4U7IS9RO1q/zDLLLPMsfdPXW3Aso0aqdSwzNqvatyG59btjSg
        hPjQJ/PBcexDd/CTy5VEdTQyPyUSQjsblbQgKRI48mpMSHTg
X-Google-Smtp-Source: AGHT+IGfKrROzc73KF0ejaUWsIpnsUmLsLBlTMqcRYfFE/B2YIdyfJZ5i9qn/JPhnNqB+AehJiu4dzQCN/IdUWyYcy93lo6E05KY
MIME-Version: 1.0
X-Received: by 2002:a05:6830:4104:b0:6d9:e33a:e4e7 with SMTP id
 w4-20020a056830410400b006d9e33ae4e7mr4031696ott.1.1702284072435; Mon, 11 Dec
 2023 00:41:12 -0800 (PST)
Date:   Mon, 11 Dec 2023 00:41:12 -0800
In-Reply-To: <000000000000ad704b05f8de7e19@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000071c5ec060c37e5e1@google.com>
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
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
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
