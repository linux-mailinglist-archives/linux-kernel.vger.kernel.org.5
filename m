Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F7E79D275
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 15:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235752AbjILNeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 09:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235742AbjILNed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 09:34:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 39C4930C4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 06:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694525573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZNHumZd5zXOwCsIWPALVYT9MT5ty2nfO31Xn+e5T4gM=;
        b=LZSLxUOnJuA66NB7Vh5gzFBAkR3RJi6TF4RRv0vZyh/KCckaCUucXdaT3q2vVjINfldB4T
        DE5OmNnolBA9IBYSYX/2LO5hfCbw3riprcTU2MlYnS4J8WjAlks/2kGFN8lEwK5yEzBdgl
        3du5Z/bVkg03MM+7f+wAjzghyZTV9yo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-527-h9aswumsM_a7GLnJtSiEaQ-1; Tue, 12 Sep 2023 09:32:48 -0400
X-MC-Unique: h9aswumsM_a7GLnJtSiEaQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 91B6A3C0EAA8;
        Tue, 12 Sep 2023 13:32:47 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.195])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6ADBF2026D4B;
        Tue, 12 Sep 2023 13:32:46 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 12 Sep 2023 15:31:55 +0200 (CEST)
Date:   Tue, 12 Sep 2023 15:31:53 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] task_work: add kerneldoc annotation for 'data' argument
Message-ID: <20230912133152.GA6695@redhat.com>
References: <93938bff-baa3-4091-85f5-784aae297a07@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93938bff-baa3-4091-85f5-784aae297a07@kernel.dk>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11, Jens Axboe wrote:
>
> --- a/kernel/task_work.c
> +++ b/kernel/task_work.c
> @@ -78,6 +78,7 @@ int task_work_add(struct task_struct *task, struct callback_head *work,
>   * task_work_cancel_match - cancel a pending work added by task_work_add()
>   * @task: the task which should execute the work
>   * @match: match function to call
> + * @data: data to be passed in to match function

Acked-by: Oleg Nesterov <oleg@redhat.com>

