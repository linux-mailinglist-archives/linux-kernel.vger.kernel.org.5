Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE477A69D2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 19:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbjISRpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 13:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbjISRoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 13:44:46 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464F8CF0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 10:42:44 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-578d78ffdbcso84101a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 10:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695145361; x=1695750161; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nG4n/YRrpFoD8JTOoLMpes+wmGt65z7c7xLiMMhd0ZI=;
        b=NSsG36Soi4z8roSLSBRcWakbx3vQ9IQi3kfXHXBP2u9MLl++mye2X6XKjmtGfHm+GZ
         j9a/LXFeLgkGVFKRe9PbMFuWH6hwAFUqcshXeKv0znUUvp10+Ky3kYYmHUfbyrwKSWEZ
         kUO8i3w1+y0CYQ1s0MqmscMG85norDJCs1ZagLS/dA9Jj4UUbwIBZQwwkkrlVtpSq7Lb
         hSZcM10CmCKFSB87tyPzfOriUXydn5nfEsmw7g5bEONLpZXDARIkZ0HE23yv/me39vdg
         wZxtyclkS3cXrj1M07w+ql/+PhwAv2omvaUVDbGywt87FJlATaW4IylzxCdsDozcLfBe
         kNpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695145361; x=1695750161;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nG4n/YRrpFoD8JTOoLMpes+wmGt65z7c7xLiMMhd0ZI=;
        b=XSelzvwTEmjbzOVN14cEcvIh4Xri3ymyG1J7n+p+rw0MTdccoijxLwpykn97JUcx3V
         w038NY2vahdoqRBeX3gMJ+bcVbapw/H+QYXwECYkDEsy9Ob+pAZYNg20QtUGASV7kz2w
         JdDoGDdUB30tbgcPjgTaM/u5+/gXDL4mHA2aNAPbE4ApvSvzkejZn28AWRV6v0sLbNMN
         Sll9I3ihAby+ej+rJSaQGxNkMa4GZ1/r6t4/Mz820C102XQb52BltUecbWuf/nCWvcqd
         95hFIi+NYYjqVtQ0Oq9tpa3S4qvEHKuSzpm1A1hlfHnRbFdYFZK87OVEgb4JS0hpm6hD
         qi9w==
X-Gm-Message-State: AOJu0YzqQ1mSvemZNfguPy5G5FGMJdE80l9UtQiwvnzBXyRjPjAAAQ26
        Db304oFz1tc4NpvPpqF/HpZr7pwHRCU0fQ==
X-Google-Smtp-Source: AGHT+IH3Y9U2S4BCrW27vOdyp6OvTiraehislfnkumAPT3yAweIMNvGN7+jlKIuMr1fp4jbTEHK46g==
X-Received: by 2002:a17:90a:e001:b0:263:f435:ef2d with SMTP id u1-20020a17090ae00100b00263f435ef2dmr441813pjy.10.1695145361297;
        Tue, 19 Sep 2023 10:42:41 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id mp15-20020a17090b190f00b00265c742a262sm8860419pjb.4.2023.09.19.10.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 10:42:40 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 19 Sep 2023 07:42:39 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Zqiang <qiang.zhang1211@gmail.com>
Cc:     jiangshanlai@gmail.com, syzkaller-bugs@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] workqueue: Fix UAF report by KASAN in
 pwq_release_workfn()
Message-ID: <ZQndj34e9lOpA8Fm@slm.duckdns.org>
References: <20230919081958.7071-1-qiang.zhang1211@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919081958.7071-1-qiang.zhang1211@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The patch looks fine but

On Tue, Sep 19, 2023 at 04:19:58PM +0800, Zqiang wrote:
> @@ -4743,6 +4743,8 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
>  	wq_free_lockdep(wq);
>  err_free_wq:
>  	free_workqueue_attrs(wq->unbound_attrs);

Can you please add a comment here explaining why the flushing is necessary?

> +	if (wq->flags & WQ_UNBOUND)
> +		kthread_flush_worker(pwq_release_worker);

Thanks.

-- 
tejun
