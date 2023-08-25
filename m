Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668B1789224
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 00:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjHYW5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 18:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbjHYW5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 18:57:45 -0400
Received: from out-253.mta1.migadu.com (out-253.mta1.migadu.com [IPv6:2001:41d0:203:375::fd])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A99B1FC3;
        Fri, 25 Aug 2023 15:57:42 -0700 (PDT)
Message-ID: <50453723-813b-4d2b-2d83-3e2c57355230@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1693004260; h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pNM3SuBZFH5nvdXhOSjFkO0GstPDo1DaGZ2GX7IY/7s=;
        b=VUWmpO7iqHEbNeCModTEKBilPXWZpFRE4jk7GAug/3XZuZNp+4uqmvxxcx+S/udPnXEru+
        AjORqhGJmxt1smumGmBfqI0ftgzoXOqdPR1BmMJCHu4WT/BvucKeSgq6yQ+sofetI7gUS9
        TWnH+2nlVwMP8La98vvEg7yl4W58DZs=
Date:   Fri, 25 Aug 2023 15:57:36 -0700
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH 5/6] bpf: task_group_seq_get_next: simplify the "next tid"
 logic
Content-Language: en-US
To:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yonghong Song <yhs@fb.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kui-Feng Lee <kuifeng@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230825161954.GA16886@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230825161954.GA16886@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/25/23 9:19 AM, Oleg Nesterov wrote:
> Kill saved_tid. It looks ugly to update *tid and then restore the
> previous value if __task_pid_nr_ns() returns 0. Change this code
> to update *tid and common->pid_visiting once before return.
> 
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>
