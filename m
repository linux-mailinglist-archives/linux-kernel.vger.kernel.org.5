Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF6B7F59D9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 09:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbjKWIPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 03:15:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjKWIPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 03:15:44 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771D2D41
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 00:15:50 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-6bf2b098e43so698444b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 00:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700727350; x=1701332150; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CrEIDOduhti6InSDnRypg+BVJxqG3xXbxgAmhP0hxmM=;
        b=x2rkB6udHXM79Gx1VkF6RrzD0tkl8Be5FgtE3leLVPPPHRlc3EdNlXYMpWS1WCQu15
         jpB9m/m1cj39LXqICa4WRPMBzhRmRC7MdKehkFEZ6SKY+Cr21d0Ohza5FhK8wi1FRGbk
         MwSle3fAAhUf8CUlZE5QA3qedYhd9XPLO7ebvQllVBP670LRNX2qrCXm94laDm3nVw+W
         SFnTAd/1AYN2Jr/Tr5yme7rKS6ARtt3VUC/3sNhFijq/dZomO18mOpRxQ/E+Th0vTpPH
         qJpY7AeLAVPnsYEJNmm3oh49t4jQj1w1hgwL4rT3aKTczffTP84nb03xP331TWGGfk/p
         ITbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700727350; x=1701332150;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CrEIDOduhti6InSDnRypg+BVJxqG3xXbxgAmhP0hxmM=;
        b=M1zthULYdtOnuLYAw9zoD5G3PIWzyUGtY0smKWsvT5tMW0QS9D5AVT107CF6wFdNFm
         jMFsxTioBu2HlxaQm+nI2tLhtVudyU08gxlnvCSgrk8vaUmuKYTnxZJddPs4GxEDSr2L
         GZ3JUZeylwRewWN26LPEzsQ6XGNG7HnEW5nWuvygxzxZi28Y8QWOV5QCLmZ+Jdh01k4X
         GCVLuLrWCka4LT2CGGYaT0N6FnrDJQruQBS6n6UMfp8hbZm/NtfH0eETHGEvY0xJ6u7+
         vQm8JyGWSy5dCj9VmESBLCJ2yU6FBPUR7Jp6tkoQ9POeLKSLACs5ZNfUGt3+U+zZK0a7
         qZxw==
X-Gm-Message-State: AOJu0Yxudgy0wiFzW+ohkPLLt9/BsP7M+vPGF5TEzqoPH02KbreS/Se+
        wz8uS2tf/cfAFzZ1QO/QbGQzHR1ExCq8rw==
X-Google-Smtp-Source: AGHT+IH9adT6B0i1q+P6CsoaxvjLgFLnosKLJplk4qIgLHNWoRCdaiFD4O87oq0Kh4mkVoq1iaj+K6sacIpqzQ==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a05:6a00:1da3:b0:6c4:ec00:2941 with SMTP
 id z35-20020a056a001da300b006c4ec002941mr1201225pfw.4.1700727349918; Thu, 23
 Nov 2023 00:15:49 -0800 (PST)
Date:   Thu, 23 Nov 2023 08:15:47 +0000
In-Reply-To: <20231123080334.5owfpg7zl4nzeh4t@CAB-WSD-L081021>
Mime-Version: 1.0
References: <20231122100156.6568-1-ddrokosov@salutedevices.com>
 <20231122100156.6568-2-ddrokosov@salutedevices.com> <20231123072126.jpukmc6rqmzckdw2@google.com>
 <20231123080334.5owfpg7zl4nzeh4t@CAB-WSD-L081021>
Message-ID: <20231123081547.7fbxd4ts3qohrioq@google.com>
Subject: Re: [PATCH v2 1/2] mm: memcg: print out cgroup name in the memcg tracepoints
From:   Shakeel Butt <shakeelb@google.com>
To:     Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev,
        akpm@linux-foundation.org, kernel@sberdevices.ru,
        rockosov@gmail.com, cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
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

On Thu, Nov 23, 2023 at 11:03:34AM +0300, Dmitry Rokosov wrote:
[...]
> > > +		cgroup_name(memcg->css.cgroup,
> > > +			__entry->name,
> > > +			sizeof(__entry->name));
> > 
> > Any reason not to use cgroup_ino? cgroup_name may conflict and be
> > ambiguous.
> 
> I actually didn't consider it, as the cgroup name serves as a clear tag
> for filtering the appropriate cgroup in the entire trace file. However,
> you are correct that there might be conflicts with cgroup names.
> Therefore, it might be better to display both tags: ino and name. What
> do you think on this?
> 

I can see putting cgroup name can avoid pre or post processing, so
putting both are fine. Though keep in mind that cgroup_name acquires a
lock which may impact the applications running on the system.
