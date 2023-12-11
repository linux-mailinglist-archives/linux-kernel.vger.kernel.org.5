Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F64680D46E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 18:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344523AbjLKRtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 12:49:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjLKRte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 12:49:34 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C67C7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 09:49:40 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5df5d59476cso25095027b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 09:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702316979; x=1702921779; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PD4uUBn0YrczoWxlhIt/RaQw+8ZUjArWaAoFtxYQibs=;
        b=LoVl64DKL/uLggQXwWKmK5BOSOGk1xBpRBZsdQ+6bL5OW1U136GD5QZjuN+N7Dqybr
         n+Gh+IPjUV/6LYaspAEBa70k3BFpM0xLw1KhGdw86LEhLTgKylkm636a0oFEzv81UXu0
         AmIzm5OGmwzEfOIzjWJNbJF4EcNPTmxy2pHVBlmNJ8XxAtmxV7dlNkVGTtpV6z+kqNyh
         vAmk8bGkqiESIjLRvZoUxzQUwR74xBy1g83tecDx/AyrAZsA5IInAyrOO+N/A8cG77KI
         3wUN0OVro4Xsiku9bESV/bVEajIwKV1AOUlnjqGpY4dCyis0oIA7Az4L6RnT3CSm/VaV
         cPPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702316979; x=1702921779;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PD4uUBn0YrczoWxlhIt/RaQw+8ZUjArWaAoFtxYQibs=;
        b=Y6GIlLq+7PZpXt6B7UiFOSnFosBOZV7SXJwJTKEGENO+3yhCkD7718k3q0GjGq9yUj
         YKjVNn/2tBKjpVol/cQapnLioFqS8Rks2K/X7d3aNsOQ9MpYw17JP+ltalcKkJLh9n0t
         1W8LtFX+O92j48b1yE/tlucYDrfl966IaL47UT/OCnpyoSDTMLZ7HQZO+lZMaWhY57bN
         Z5/+46jVJ6LTTHy1ACPWoCd0R1+URy/Xt3DnWLW1SCa5Zlt7UdDoV+VsdjzREAtyz575
         LXGZixQKGmgwEjtPaaGyA0HLNVjGZimb4a9w4G4lmmCC8w83btR7to2eAKOe1wlts17e
         VcIw==
X-Gm-Message-State: AOJu0Yzy4R9/nN9R8bHlJ9VCPcpZ/l8BZdn2+zPnYjOlqs97A5q33lye
        7d0g5NE+jP/UFwIdLEG7YWOmIL3zhCY=
X-Google-Smtp-Source: AGHT+IFKl2rS1vD/lL3s8aIyMZ058IVAAiNTpwfw4dqckX0k3J8fVvuHgdqmRgVwbCkxi+5PiutTudxK29M=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a5b:f08:0:b0:dae:49a3:ae23 with SMTP id
 x8-20020a5b0f08000000b00dae49a3ae23mr36764ybr.7.1702316979721; Mon, 11 Dec
 2023 09:49:39 -0800 (PST)
Date:   Mon, 11 Dec 2023 09:49:38 -0800
In-Reply-To: <20231211085956.25bedfe4@canb.auug.org.au>
Mime-Version: 1.0
References: <20231211085956.25bedfe4@canb.auug.org.au>
Message-ID: <ZXdLsg1tN4DfBBSy@google.com>
Subject: Re: linux-next: duplicate patches in the kvm tree
From:   Sean Christopherson <seanjc@google.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023, Stephen Rothwell wrote:
> Hi all,
> 
> The following commits are also in Linus Torvalds' tree as different
> commits (but the same patches):
> 
>   3b99d46a1170 ("KVM: selftests: Actually print out magic token in NX hugepages skip message")
>   fc6543bb55d4 ("KVM: selftests: add -MP to CFLAGS")
> 
> These are commits
> 
>   4a073e813477 ("KVM: selftests: Actually print out magic token in NX hugepages skip message")
>   96f124015f82 ("KVM: selftests: add -MP to CFLAGS")
> 
> in Linus' tree.

This is my bad, I used the wrong base for a selftests branch.  My understanding
is that we're just going to eat the duplicate commits.
