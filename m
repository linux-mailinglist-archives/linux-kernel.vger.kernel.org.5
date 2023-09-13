Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F66E79F09B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 19:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbjIMRrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 13:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbjIMRrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 13:47:01 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23C11BCD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 10:46:55 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-770819c1db6so6342985a.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 10:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1694627215; x=1695232015; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RwMj9CV1ar3+oq7/cp83rZlUQWbuMO2u1KsPFYY/2HQ=;
        b=PbNa2acykmtwpK5qmr4v2YqVvvNwLkNJrr3+xc5Ex8esRRbENvEpF8a/BAjsrPvLmb
         LV+tsbQIOci2Z5+X36lf8w/zbL6MkwePhNjq5+cuFFahi19C8M0Y7miN2KAX8ki0sqqk
         ADwlTgbdvgbuAGrUK5u2BUEwdcb1mKXvjgmoJfBWWf+j+810JZMrzza+G755cLerdjpv
         LQwp5RbsiWkUxK/Bqw1Ebrd36h0rVDrOCcWR6e951VZX/U+f3v761A4ElL7FirooJXwo
         63XEoXnQ8cuE03xZubIr3Ouz/bj5+5NQbQt6OhJ4tKqho7qb0cSMXflw1tkuv6TpqKCK
         hP+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694627215; x=1695232015;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RwMj9CV1ar3+oq7/cp83rZlUQWbuMO2u1KsPFYY/2HQ=;
        b=YGJdWPI2ULZB4ntoCxGNaHt4egMrPXj5mjY4WQiM/+99o+Iz3rjeEp9os08gja4mxb
         NY53fBOOfMrU2jmvBMjFUq5GsvJ2ZdvyT1xhYlLX3Q+OeGupO6OB/Db7Hzz9B3syQmTT
         e5Ke40kDPISeFeMlvCVk2zv5/h2+GtjtbiZSrBcme31+bc/7Vx4f60n6VIHhuOA8SeO7
         07hs32BsykoCtj52cg45L7ngQGK2nremrJdSoYDnnmliTG18F+mok2S6FgHF2QF6ceyT
         Mz0oYzFmQflYdZ1oQOoTVC6n40x3PFghSER/sC9lcdZ7fOiX3GseVCsxcMX6xKccec4T
         sldQ==
X-Gm-Message-State: AOJu0Yz+mcGAAQwEBo0sTBkY+DaOqh/8960FvsMRG+yb1fMW97vI/auj
        1QcWoPqLJlGrf7uwaHBoXoWBJJssmrUMqBm1rQ==
X-Google-Smtp-Source: AGHT+IE43H1tKTPpK87upOxx8lwGF3DbnW12hEwme+ovZDMYkHiprYxqc3Q2LTetzSVAHOV7qJ/vLQ==
X-Received: by 2002:a05:620a:2486:b0:76f:2f7b:cf41 with SMTP id i6-20020a05620a248600b0076f2f7bcf41mr3925219qkn.48.1694627214979;
        Wed, 13 Sep 2023 10:46:54 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id s26-20020a05620a031a00b00767d8e12ce3sm4039697qkm.49.2023.09.13.10.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 10:46:54 -0700 (PDT)
Date:   Wed, 13 Sep 2023 13:46:54 -0400
Message-ID: <98b6b64781e87c822ded50fe81e5d793.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] selinux: improve debug configuration
References: <20230818151220.166215-2-cgzones@googlemail.com>
In-Reply-To: <20230818151220.166215-2-cgzones@googlemail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 18, 2023 Stephen Smalley <stephen.smalley.work@gmail.com> wrote:
> 
> If the SELinux debug configuration is enabled define the macro DEBUG
> such that pr_debug() calls are always enabled, regardless of
> CONFIG_DYNAMIC_DEBUG, since those message are the main reason for this
> configuration in the first place.
> 
> Mention example usage in case CONFIG_DYNAMIC_DEBUG is enabled in the
> help section of the configuration.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/Kconfig  | 10 ++++++++++
>  security/selinux/Makefile |  2 ++
>  2 files changed, 12 insertions(+)

Merged into selinux/next, thanks!

--
paul-moore.com
