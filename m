Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7513F7F84D7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 20:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346033AbjKXTm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 14:42:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjKXTmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 14:42:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D0898
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 11:42:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4478DC433C8;
        Fri, 24 Nov 2023 19:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1700854951;
        bh=ezc0uKQjJ7QBtbFGAWq/OpSXh4KP6g8aXlUNpY+KlCY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=m7Bo3msMtQf6IcfuqT9j39hHZoT6qqHydL29EWYC3/fa/tzP+zADtWz0v5MaF3sOf
         hfq6lqpRstJmqJMwxMsExSvJevFHdfTSsEWnyQotY5cw8EkObHKyxaKjmq3ifSzutn
         vMdF1RopqRBYl2E2sVbxLC5Pp6QZCG9WG098zNJM=
Date:   Fri, 24 Nov 2023 11:42:30 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <roman.gushchin@linux.dev>, <shakeelb@google.com>,
        <muchun.song@linux.dev>, <kernel@sberdevices.ru>,
        <rockosov@gmail.com>, <cgroups@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <bpf@vger.kernel.org>
Subject: Re: [PATCH v3 0/3] samples: introduce cgroup events listeners
Message-Id: <20231124114230.22ed97e85058dc339947f13f@linux-foundation.org>
In-Reply-To: <20231123071945.25811-1-ddrokosov@salutedevices.com>
References: <20231123071945.25811-1-ddrokosov@salutedevices.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2023 10:19:42 +0300 Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:

> To begin with, this patch series relocates the cgroup example code to
> the samples/cgroup directory, which is the appropriate location for such
> code snippets.

butbut.  Didn't we decide to do s/cgroup/memcg/ throughout?
