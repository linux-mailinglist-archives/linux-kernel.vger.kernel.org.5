Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147437F9BF1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 09:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbjK0IkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 03:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232440AbjK0IkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 03:40:16 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D13E18E;
        Mon, 27 Nov 2023 00:40:20 -0800 (PST)
Received: from [100.98.85.67] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B2ADA66022D0;
        Mon, 27 Nov 2023 08:40:13 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701074418;
        bh=rZXsF737DimmD6akpQH1k64WG7vCDa/yrvr/Hhcm6dQ=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=Snz5MQ2OHBon5UJH+98mdDbgTrFRKjLtGTX5KRDipqlr95JztPXgEMEhEl7fdNZfy
         K1pHJorNBvh8Y7mSbjXC9MIgzJ3jGm7YSs6SxNLTsG+NvGXBSbifiplJZPGt8LaxJx
         qYAtbVmdbZRrvWnJwfFDRH3p8tAtvWeLbf33iGk9PNyWoTo9qJluOSofDzJAQDEycD
         sxtkv3tlLlN6WSfY5LFv3kXoNEALMVKgd8ZqAUirOS4Wptzrl4GblpaqnNj50tTIOn
         l7/eMnPlFHQLOG0Q1zRxQYHNRSV5AHsHvD3srWytZfUhSVAlbaEbVqOjv3G0/AAl1Q
         ks7Y75il3qS/g==
Message-ID: <ce4b8316-1529-48d2-aadf-2ea25670edcf@collabora.com>
Date:   Mon, 27 Nov 2023 13:40:13 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: Re: [v5.15] WARNING in kvm_arch_vcpu_ioctl_run
Content-Language: en-US
To:     syzbot <syzbot+412c9ae97b4338c5187e@syzkaller.appspotmail.com>,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        jarkko@kernel.org, jmattson@google.com, joro@8bytes.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sgx@vger.kernel.org, mingo@redhat.com, pbonzini@redhat.com,
        seanjc@google.com, syzkaller-lts-bugs@googlegroups.com,
        tglx@linutronix.de, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org
References: <0000000000001bfd01060b0fc7dc@google.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <0000000000001bfd01060b0fc7dc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/26/23 8:24 PM, syzbot wrote:
> This bug is marked as fixed by commit:
> KVM: x86: Remove WARN sanity check on hypervisor timer vs. UNINITIALIZED vCPU
> 
> But I can't find it in the tested trees[1] for more than 90 days.
The commit is already in 6.7-rc3:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7b0151caf73a656b75b550e361648430233455a0

> Is it a correct commit? Please update it by replying:
> 
> #syz fix: exact-commit-title
The title is already correct.

> 
> Until then the bug is still considered open and new crashes with
> the same signature are ignored.
> 
> Kernel: Linux 5.15
> Dashboard link: https://syzkaller.appspot.com/bug?extid=412c9ae97b4338c5187e
> 
> ---
> [1] I expect the commit to be present in:
> 
> 1. linux-5.15.y branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git

-- 
BR,
Muhammad Usama Anjum
