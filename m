Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392317B97DE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 00:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbjJDWWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 18:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232183AbjJDWWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 18:22:17 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84EB0F5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 15:22:12 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59f8134eb83so3931047b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 15:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696458131; x=1697062931; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R08SF2RO3rNTWYRv9a92dKc/I3NYQqIaV0o1mrm6R9k=;
        b=gykyqtWvqdv0O8pu6srkaIbelFGIgFotaYNQj92tFlFadwReU04AttkBCW/zYC9TTF
         46UN5mzzZ80jQ1rezy9BS4nRypBVhjO+TwYgVvqvTjWZwa6735X+uT4tHIqX0DCrmYo5
         DVZlVARHmnfd6FGj1Ck/r9YYBb2C46ln+Y/5UrLdFsC2xs9Mivy3oDPJ7XdvgPSbePWF
         Gu1XnUusRha1HqQqu+N2PQ0BfeE2EcXSzvjRmEwAWS8esNGsb8/JILRcYFsEHPM6Vvc0
         wsQ1gXqQ4FNOKLEV6Z459dNvhyzqBATN2D+LVLtsiFz7Uryk5zNaUrxa/+JKHCAhxxpN
         6BOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696458131; x=1697062931;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R08SF2RO3rNTWYRv9a92dKc/I3NYQqIaV0o1mrm6R9k=;
        b=iYchzbPgl3ezqlkuwQjoEIQh/xYXLQ1cL5TtgVkEAyo/1cC24z94lDMNKXrjCLHRwY
         o3ZX9Sqw8XFd0iXSgxuZAx7Wab4HfQ+GPu7igpgJKLSn8caLtK7CXP39JY5Yw+s8EupA
         gkMQvDyPluUl9l1nlrM8tNWn/vJYdnfjkDAjbY0NrWaaR74GeoG6BNw9US4Unk17IPR1
         kHSvylsmrZN1GwAw+ifXjcPoyaRCVqeKEfYTtUgHYJz5Oy0JakGbegFIpzaHn6sNlfbH
         WWjB7ZOanNEJT2EKIppitES5hI4ksHqHZmcGuhmYNmNCU1qqjfnYKjTl5Y9kwvteNxNY
         ugAw==
X-Gm-Message-State: AOJu0YxXF57OvA6alb0wjfbqnWYcXT9owfRayl5DYwvf9JQ68+q9ZONL
        sMrSfBOUyLo7NtIB2+Cqlz3XDh2zqgQ=
X-Google-Smtp-Source: AGHT+IHGCerst7w645uv/tqOd9oAFXpupAandqJ94FBVwiVup2vQixOLt5zCWO0kyCS4Xdw5MsMiUvemaiw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:bd0d:0:b0:595:5cf0:a9b0 with SMTP id
 b13-20020a81bd0d000000b005955cf0a9b0mr68443ywi.9.1696458131783; Wed, 04 Oct
 2023 15:22:11 -0700 (PDT)
Date:   Wed, 4 Oct 2023 15:22:10 -0700
In-Reply-To: <CAPm50aK-aODN8gbaxazqsNXwEciU1WdRom33h3zOnQLTBEKu1Q@mail.gmail.com>
Mime-Version: 1.0
References: <CAPm50aK-aODN8gbaxazqsNXwEciU1WdRom33h3zOnQLTBEKu1Q@mail.gmail.com>
Message-ID: <ZR3lkt9dNgsnieuH@google.com>
Subject: Re: [PATCH v2] KVM: x86: Use octal for file permission
From:   Sean Christopherson <seanjc@google.com>
To:     Hao Peng <flyingpenghao@gmail.com>
Cc:     pbonzini@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023, Hao Peng wrote:
> From: Peng Hao <flyingpeng@tencent.com>
> 
> Improve code readability and checkpatch warnings:
>   WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider
> using octal permissions '0444'.

This is whitespace damaged.  Please fix and resend.
