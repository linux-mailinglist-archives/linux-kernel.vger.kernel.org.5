Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A2D7A678F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 17:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbjISPGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 11:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232649AbjISPGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 11:06:15 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70C1BE
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 08:06:05 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1c3d8bd4aa5so43416175ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 08:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695135965; x=1695740765; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OY4gwD8K8C7sjWTf2a9MwqVDFc4JR9EZBcKVWZ3nYk8=;
        b=g7KYOo0tttgTEdRcWr2WDzud0GDtSjQ6rm/jizJ4A6CF36jDq77rDodijDy752/jrf
         /PJy1v17t1ci4KlrKzDqNv4V46WNlqLINgac+dMqz3kCg168DLguR7lFpKA7XxRO4+wg
         CxYjqfkfAMg2rkt/mc6+mwyyr/yx7jpBthm1Lu91FN/9ZT4uAZ7MrjL8PMuZ3tnRtU4Y
         nMhrGJr4IcQYQcWVjFLVLDMhbLPBS2wsOzBPjEwDEKnap3t/ubhMJ240woXPoOZeeEGe
         cwytS9+7TWLRaaeHnp/+3IcUohWJo4vyDuQY2kaERq1e9NHal7jTdpnsPcoIsZgXWqYX
         g2uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695135965; x=1695740765;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OY4gwD8K8C7sjWTf2a9MwqVDFc4JR9EZBcKVWZ3nYk8=;
        b=psz9VZt8NtmJF8rxR53K2pcDTQz6Q5HQMrCng1ABjGFXrwqVbCu0bSqHDfvY07+3jM
         oOi8L62k4jp4vJc/Wi3gkhTP2otiI11V0StTN18OX+Ea+yyzMwNyXOVV0QHG6rdxyjYr
         PQN8XHFggUpwjATS/XWCzNKBBVuhzYc6hmyHxa5IEPLLnl9WgUu6YwXnLTT9GbeFPqlf
         Ff1smbdTODMqgkjs3AKgVmNROlNQ/KfipXmzQtLtEXosAHJn9Mh741jSofjbtaEpqM7a
         +dk6BTcTRlX0Wg+l4YFZmcqvOFPB6nZUoDM6NWn+MXkDiPrJu7ylReVBAXYLIxKZicfq
         5n3Q==
X-Gm-Message-State: AOJu0Yxe2fDF2GSt9ANkdJKx3qnWxs1J4Q/xmaMU0hhzgHUFUrKnouMM
        o3Nnu+YFB/ndNel/XlU0WybXIycuH80=
X-Google-Smtp-Source: AGHT+IEELizuG/1J1rCQpMyfr99oNZFw4XTRLkR/Kqn0kP3fpjSk5TekLXW/TEJ7kUiSTlpJHb5M/jz6oQ4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:23c4:b0:1c3:d556:4f9e with SMTP id
 o4-20020a17090323c400b001c3d5564f9emr63017plh.0.1695135965373; Tue, 19 Sep
 2023 08:06:05 -0700 (PDT)
Date:   Tue, 19 Sep 2023 08:06:03 -0700
In-Reply-To: <CAPm50aKVDLhZo_3kkKyC9AUN0BGrYnPTo9hGqRg1M3TsUQQMSw@mail.gmail.com>
Mime-Version: 1.0
References: <CAPm50aKVDLhZo_3kkKyC9AUN0BGrYnPTo9hGqRg1M3TsUQQMSw@mail.gmail.com>
Message-ID: <ZQm425xPc/8wHXup@google.com>
Subject: Re: [PATCH] KVM: X86: Use octal for file permission
From:   Sean Christopherson <seanjc@google.com>
To:     Hao Peng <flyingpenghao@gmail.com>
Cc:     pbonzini@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KVM: x86: (don't capitalize the 'x')

On Tue, Sep 19, 2023, Hao Peng wrote:
> From: Peng Hao <flyingpeng@tencent.com>
> 
> Improve code readability and checkpatch warnings:
>   WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider
> using octal permissions '0444'.
> 
> Signed-off-by: Peng Hao <flyingpeng@tencent.com>
> ---
>  arch/x86/kvm/x86.c | 18 +++++++++---------

If we're going to do this, let's do all of x86/kvm in one patch, i.e. clean up
VMX and SVM too.

I generally don't like checkpatch-initiated cleanups, but I vote to go ahead with
this one.  I look at the params just often enough that not having to parse the
#defines would add real value for me.

Any objections?
