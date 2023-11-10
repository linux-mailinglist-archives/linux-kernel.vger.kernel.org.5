Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0387E80E3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345843AbjKJSTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345221AbjKJSPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:15:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD5742C01
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 08:59:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A06C433C7;
        Fri, 10 Nov 2023 16:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1699635594;
        bh=7D6/INxqAd6tY02KzravmcTFgNVCOfRcWs5MmM/Ltik=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VXkBAdOehvoe8FAy/Xt3FOOzWJjXQZEXOYdDNzsLqkxmE4fPgVtFOVR/MwCaDnCYb
         KOUjl/sqV9u7StKud1Z3TY8Mv6Sca4un1iRWVfEwqx3eZ01EOJssJW9zWBYVoId+8e
         V0zWalk2Jsh9fuh9WfAPksNw7v90rbalkmJEW8+A=
Date:   Fri, 10 Nov 2023 08:59:52 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <roman.gushchin@linux.dev>, <shakeelb@google.com>,
        <muchun.song@linux.dev>, <kernel@sberdevices.ru>,
        <rockosov@gmail.com>, <cgroups@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <bpf@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] samples: introduce cgroup events listeners
Message-Id: <20231110085952.b55345df8dd18019f0581fc1@linux-foundation.org>
In-Reply-To: <20231110082045.19407-1-ddrokosov@salutedevices.com>
References: <20231110082045.19407-1-ddrokosov@salutedevices.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Nov 2023 11:20:42 +0300 Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:

> To begin with, this patch series relocates the cgroup example code to
> the samples/cgroup directory, which is the appropriate location for such
> code snippets.
> 
> Furthermore, a new cgroup v2 events listener is introduced. This
> listener is a simple yet effective tool for monitoring memory events and
> managing counter changes during runtime.

Is this correctly named?  It's a memcg event listener. 
"cgroup_v2_event_listener" implies that it will display events for
other/all cgroup v2 controllers.
