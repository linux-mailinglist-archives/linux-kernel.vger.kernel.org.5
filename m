Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386397874AE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 17:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242030AbjHXPzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 11:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242333AbjHXPzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 11:55:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361AE198D
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 08:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692892483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ouJ24GL9C8kNb/9sjPKrIqbN3b2VNNcZO5Kx9xYLChM=;
        b=cNEsmB1Yp9uRdAWl+BO6d3fGoABthWvftVvQgFHhNzjfmHMEIgf1+0C9LoauvfJxlJl2Lf
        /kZuzvXrbhwUys6+LoFXT7xZZ22545/tflRtl/ZpLjg7QpWH99PuoqdB3t81OWmXa4yDR7
        r5HFncoNO/aO7I/yqjHhNRei8YPnyNA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-113-pxmtIshKMCac0Fc8ad-7tg-1; Thu, 24 Aug 2023 11:54:39 -0400
X-MC-Unique: pxmtIshKMCac0Fc8ad-7tg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0D87485CBE8;
        Thu, 24 Aug 2023 15:54:39 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.43])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9639040C6F4C;
        Thu, 24 Aug 2023 15:54:37 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 24 Aug 2023 17:53:52 +0200 (CEST)
Date:   Thu, 24 Aug 2023 17:53:50 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] introduce __next_thread(), change next_thread()
Message-ID: <20230824155349.GB11832@redhat.com>
References: <20230824143112.GA31208@redhat.com>
 <CAHk-=whB2Cnmr2u8g5h57i8JfUoS3Qe=Pz7Bd8or3=ndJnQaWw@mail.gmail.com>
 <20230824154702.GA11832@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824154702.GA11832@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Argh...

sorry for noise,

On 08/24, Oleg Nesterov wrote:
>
> No. Please note that, say,
>
> 	do {
> 		do_something(t);
> 	} while_each_thread(current, t);
>
> differs from for_each_thread() in that it loops starting from current,
> not current->parent.
               ^^^^^^
just in case, of course I meant current->group_leader

Oleg.

