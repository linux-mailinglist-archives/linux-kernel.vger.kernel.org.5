Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42EE7EB6F5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 20:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjKNTj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 14:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbjKNTjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 14:39:53 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA64116
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 11:39:49 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5c1bfd086f0so1164451a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 11:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699990789; x=1700595589; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YOy2Jb1yR8H+KDVAUkMuOWbnw7u2AlKs0q0OU4Ox4dg=;
        b=1eyvjaKPkOM9/syod/APwe8rlxIwK30ARa9MZJGVqFCG3NVtEyevw7exzedQVttEAN
         BnNFs/Q6XJq2nkVllvikQhlKGoB/QMhhHX75HK2C8ZIa+MruMRGDhO1w4qd0UnYw/Xjm
         Zp95YT/dVeRGFTqwGAmzB387ymv6D5mbilZ7y9Ceu1vPGS8dFL0dk96F+uiygTeHT1bC
         EyNtv10r9ZyuuIHntlvmCjPX3oQ3np+W6HobxuBxtTxcUGI6Qnli1XFHljubG6UM5WfO
         drqO+rEHXqAwizZpUua7CbMKE7fE9mqt0OQP1zzjpkgVsTimXjo+KGkj+UZvjDXi7Ve9
         qHXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699990789; x=1700595589;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YOy2Jb1yR8H+KDVAUkMuOWbnw7u2AlKs0q0OU4Ox4dg=;
        b=AgytL5bi5ZjvNn/uT6D8bWYbECzYnl76IW142KXrkZ+/ty3UiZCNEchtOKa2sgYQmU
         c+qUpBiXoV2JvZPyDxluhkh555Zlt3pGjwzFg9ppo29+OjwsrNgtqGIBW0UmeXyCqoU3
         lgRBWpNFgggdKIPiQyzIu9A589Q9gW6Q3svDFabpLTRrymC1ocjSneozXbhDbE/z8rwx
         +b5qzpdA5UGvNbr3+ZhANphzvOwnuL5kzAmFh1ootj6eBa+v2Vvnim5VIc1JcxKUALs/
         RUZQME53AE53U4+Z0HWKU6Qur/9I5dtm2YuocIEfURh/59oz/Pup1cHvT3x6XRT0ekjd
         iI1Q==
X-Gm-Message-State: AOJu0YzZ2/Sz8uDVmy1Cq4xpCX0tFTUMKjubVZac0xKxD/3Q5eNdd4bc
        bv5KB+8hU+M6UXvdIu6N2whsilldOqE=
X-Google-Smtp-Source: AGHT+IELdNJfmBdSyGP1UazLrbiVBbECc8jW+oar24BNIoRCoD71ecIN2G1p5PdKbnM8GZXagF+ybaigYRQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:8b82:b0:68e:3c6d:da66 with SMTP id
 ig2-20020a056a008b8200b0068e3c6dda66mr2732255pfb.6.1699990789174; Tue, 14 Nov
 2023 11:39:49 -0800 (PST)
Date:   Tue, 14 Nov 2023 11:39:39 -0800
In-Reply-To: <0e27a686-43f9-5120-5097-3fd99982df62@oracle.com>
Mime-Version: 1.0
References: <20231018195638.1898375-1-seanjc@google.com> <e8002e94-33c5-617c-e951-42cd76666fad@oracle.com>
 <0e27a686-43f9-5120-5097-3fd99982df62@oracle.com>
Message-ID: <ZVPM-8MKW56hHCuw@google.com>
Subject: Re: [PATCH] KVM: x86: Don't unnecessarily force masterclock update on
 vCPU hotplug
From:   Sean Christopherson <seanjc@google.com>
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023, Dongli Zhang wrote:
> Hi Sean,
> 
> Would mind sharing if the patch is waiting for Reviewed-by, and when it will be
> merged into kvm-x86 tree?

I'm at LPC this week, and out next week, so nothing is going to get applied to
kvm-x86 until after -rc3.  I considered trying to squeeze in a few things this
week, but decided to just wait until -rc3 and not rush anything, as the timing
doesn't really matter in the end.

> While I not sure if the same developer can give both Tested-by and Reviewed-by ...
> 
> Reviewed-by: Dongli Zhang <dongli.zhang@oracle.com>

Thanks!  Providing both a Reviewed-by and Tested-by is totally valid.
