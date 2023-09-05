Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D69792DCA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 20:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237192AbjIESx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 14:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237265AbjIESx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 14:53:28 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFABE5B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 11:52:58 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-271c700efb2so1536116a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 11:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693939915; x=1694544715; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vou55OuPtbMxRPN71f+bktWCwT2Bx77mocQVrSs8EVI=;
        b=P21RDfmh9Pf8jYQMBsCVCRjpOnHC0UAJmCOlqmKHjwpNubYOildaVaXsL1Vve21gf+
         /UQpexPlcqoepEjR79mNXdSE5TRhCGsqP5D63c0LgW1V6QXu/nXQJhIkoPK5dBJvA/CG
         eZD9zV8YwHpRj7CeHWmlKpX/mdb2nVAr8geWeOV8Ol86CXaU5eZCwVyULdEpHstkQ8Pb
         gPs9vBqHmFuKLBDXaVHK1LYSD8O6iKm4M4QrossAbfARJHggugaAOT2ZO1HNI4BsgYkE
         rWt6AOD4Af32iz2p1mhlU8gEv050JoXj+kqWm9YqAZesxiOa5E5rNaZPieTPiw82/2o9
         Te0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693939915; x=1694544715;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vou55OuPtbMxRPN71f+bktWCwT2Bx77mocQVrSs8EVI=;
        b=ZWO9Z4lRn+NQRSknNAO7X0Auu2H6Y0FIDralZ8fSJ+3ENL3+KQCbUt4kCFNPIqPITp
         c7uksHdrhrw83uwVL1dAEuXzQJIhZ/1nqbMluGhJIYgoAcMcx8TZTguC/KvAkCEeT7E5
         GJrJwl4SX4dg9s+53K+jAgsti50q2WYuiRYSTsHqRNPTEM1l06eBATGZwReo3yQl5ISU
         SdiPhy9Hh/VdXF08c+vgRGp/NTRZ/n4MQmdz9kA+lC+RVQ/z94VglcDWfAoQVAhXgEp4
         TuIquyizX31n2pAOF8n6g8LzWLfLjY/qmXve/Kj0/F8EAntPfTbsPirJAnvsKGuVcfZn
         V9TQ==
X-Gm-Message-State: AOJu0Yw64FQUdWK/AuXeD9icrS8PX9UpYS8vcneYaMNXO0/qu+jotjY8
        elVExuCoR298/MmnSJPVYmg=
X-Google-Smtp-Source: AGHT+IEYIDbZnQUa0I9RSgw7WpothxVl5oHv82fY+/KlZ91D1ZzkXxbJnWfJEMpwyHIGnx+9Yebrjw==
X-Received: by 2002:a17:90b:33c5:b0:26f:4685:5b6b with SMTP id lk5-20020a17090b33c500b0026f46855b6bmr10443612pjb.21.1693939914843;
        Tue, 05 Sep 2023 11:51:54 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:eca7])
        by smtp.gmail.com with ESMTPSA id bo4-20020a17090b090400b0026094c23d0asm9561814pjb.17.2023.09.05.11.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 11:51:53 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 5 Sep 2023 08:51:52 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Zqiang <qiang.zhang1211@gmail.com>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: Fix UAF report by KASAN in
 pwq_release_workfn()
Message-ID: <ZPd4yKqbvBNGV7cL@slm.duckdns.org>
References: <20230902115026.13460-1-qiang.zhang1211@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230902115026.13460-1-qiang.zhang1211@gmail.com>
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

On Sat, Sep 02, 2023 at 07:50:26PM +0800, Zqiang wrote:
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index c85825e17df8..f3f9c9222070 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -4609,6 +4609,10 @@ static int alloc_and_link_pwqs(struct workqueue_struct *wq)
>  		free_percpu(wq->cpu_pwq);
>  		wq->cpu_pwq = NULL;
>  	}
> +	wq_unregister_lockdep(wq);
> +	wq_free_lockdep(wq);
> +	free_workqueue_attrs(wq->unbound_attrs);
> +	kfree(wq);

So, this would fix the bug but it's quite confusing because we end up taking
two separate error handling paths and alloc_and_link_pwqs() ends up freeing
stuff allocated outside the function. Wouldn't it be enough to flush the
pwq_release_worker after apply_workqueue_attrs() failure so that the cleanup
operation ordering is maintained?

Thanks.

-- 
tejun
