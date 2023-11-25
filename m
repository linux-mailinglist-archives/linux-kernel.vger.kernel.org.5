Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41FEE7F883A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 05:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbjKYELH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 23:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKYELE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 23:11:04 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAA310D7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 20:11:10 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1cc41aed6a5so28110595ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 20:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700885470; x=1701490270; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NqhlfgxGgx9fuK+3cxhiPykwd/Rof6Ckfp7i+cSoLWU=;
        b=fBlK6B3yI2su9C/li2BL1diWwRzT5cvV3f+b+9hozIfN1VUDz6IBgY8N3Chd13SFTL
         aog1E8tK5xe1mdie9bTr3UVj2WW17MaX8AoIcM66wCDyUM4dGW8YZgOhYzcNBdz5TmFD
         hC7m4E52TKVv3/ucmF6TtbWBTPYQU3gvFlnWuSB8d226g1qsIa8z46LDguwk3x8Gqpp3
         7H7GnJ7vDZStaUWO5f13eWv/8YIsResb9i/PjgKE3d8V1snJ602QBuoV8o86lzJSZmdo
         vl8BVxyfrKT1pfsYxu297sLPCzYZcBx7Yn1us9mAnsgcSlhxYKGybgE0OUArZhM9F709
         T8zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700885470; x=1701490270;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NqhlfgxGgx9fuK+3cxhiPykwd/Rof6Ckfp7i+cSoLWU=;
        b=IMDXkMTJksDVvv8x1YgUW3A39Gb71GJB5dzRfFh9/1RCz3HdgLmo0t24jlqKQAsPnK
         jcVX8UzGqdFkkD0W5wgoW3oH+8CvsqYHacQuuZKmJH5MTjjCpOfl6RLIMvpd37NGxfEy
         Q14HjTd+0m3i8lt4jXRwUYP3WZgXCh3FOCHN1aoC1qbyg/G+lMMdNnMGt/qmY7zMak3j
         NHYAIwm6fF7qJRPMcbX7YXvsibK222RTLGv5zNLPCioIxn9I1dT18UPQzOVX8YII1QFa
         sfj/AYCTgp0iiBFtUoK3hRhDZ/KNoDuorRj2JURSX7mJuC6bhm+JKrOWIBC93WqPCDq/
         QnTw==
X-Gm-Message-State: AOJu0YxfMyTEzxHAhxH3UGIvM8B3iACDJeJPB3XqFQEg7OpDVS66HncQ
        /rK7cyqdT1zg9lL/4gLhOHN1tuYtBI4Htg==
X-Google-Smtp-Source: AGHT+IHq8s6mz+sPLlMJTe9WHXyGt5bseIislyJo3/ZGz2nJmtP8NLMy4Tm9WntMtv7FXyGZAjWnIdQIxSKIng==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a17:902:e88f:b0:1c9:c879:ee82 with SMTP
 id w15-20020a170902e88f00b001c9c879ee82mr1057524plg.11.1700885470150; Fri, 24
 Nov 2023 20:11:10 -0800 (PST)
Date:   Sat, 25 Nov 2023 04:11:07 +0000
In-Reply-To: <20231123193937.11628-2-ddrokosov@salutedevices.com>
Mime-Version: 1.0
References: <20231123193937.11628-1-ddrokosov@salutedevices.com> <20231123193937.11628-2-ddrokosov@salutedevices.com>
Message-ID: <20231125041107.wgpskqegywpt7l2o@google.com>
Subject: Re: [PATCH v3 1/2] mm: memcg: print out cgroup ino in the memcg tracepoints
From:   Shakeel Butt <shakeelb@google.com>
To:     Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev,
        mhocko@suse.com, akpm@linux-foundation.org, kernel@sberdevices.ru,
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

On Thu, Nov 23, 2023 at 10:39:36PM +0300, Dmitry Rokosov wrote:
> Sometimes, it becomes necessary to determine the memcg tracepoint event
> that has occurred. This is particularly relevant in scenarios involving
> a large cgroup hierarchy, where users may wish to trace the process of
> reclamation within a specific cgroup(s) by applying a filter.
> 
> The function cgroup_ino() is a useful tool for this purpose.
> To integrate cgroup_ino() into the existing memcg tracepoints, this
> patch introduces a new tracepoint template for the begin() and end()
> events.
> 
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>

Acked-by: Shakeel Butt <shakeelb@google.com>
