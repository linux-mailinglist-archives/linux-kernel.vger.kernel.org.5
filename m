Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F54A78E004
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240347AbjH3UId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 16:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239850AbjH3UIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 16:08:21 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011FA6194
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 12:56:37 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-68c576d35feso33222b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 12:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693425329; x=1694030129; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zizE0DsSac2//A2LFc2ofyEiL2FC+zRym04PXoZ7yO4=;
        b=Nwq28adhEI3SBMabCMw6Rjxy0VzdDmCltwttz8iQBNXDpx8+FDkMlwr3GbV6YCJOIP
         jOGjvNLlTE5xMebwE/6m+lfzr/ynKP5+UqwM89tS+mi4PeP1TJPclr6sKrATHK4+xt6C
         PBnUEEBWrybJlHZWUGQqa5CPvCxnUaclbRdqBBke5KxQzlfWLIkU3VEzGcgaMqe3FkFk
         MXnkrMTPcCx2mPuZWwrQvwn9BOkdV6dU+b87hndpvAjkFmOfZlNkdwXoRQyJftfoeSZc
         9/udTqNceZsj8u4fGLtqbSn7MJ3TMXsQ4iISfYsQuQ4INp1HMF3Ou0WjK/iOim7/uSI1
         B7sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693425329; x=1694030129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zizE0DsSac2//A2LFc2ofyEiL2FC+zRym04PXoZ7yO4=;
        b=WiSM+f57lfk43/8r1GnPFwFIY6ozUT0gKpJt4eg8X/sogYyP48AITg8pJUDgvQjg1e
         Jl+rSbzfI4W3cTcTY+JwYN78FXt9NDsfWdpCFPOe1Sw/ngVec+blepOo0GF7ycj7PxXy
         c3ySIQ+RghJm18k/q6Vo0zy8K9CArnMOpzocHiYMeOU6I5EzAd7X/fxDPx9aXlskD85j
         8B1BB43pBNG1VeVUu+IzlSlPU19Zcqbsi/bp9j6WcyC39ZxvOcu9vAHlTMb+RXRTR3Kk
         NDwC9MwJnRmeZxxO1qd6QtcAEzTem+BN+szfrstzWV2IZq9HqPfXGk4/JfohrwccPOhf
         tc+Q==
X-Gm-Message-State: AOJu0YwYRfWyGIN/kAvgzwbzkSPYEmQs1gbGGVvhV4hyCXwby84Tnlkf
        3tTvFLv84nghQJWhM1kw3Saup6PA4Wk=
X-Google-Smtp-Source: AGHT+IGinyjODbtnyJ7zshYiV5beE4g63fxvnKTntkBt2OeDzh73rZ/XzOMb50Ri/geej4RKG63mfw==
X-Received: by 2002:a05:6a20:8428:b0:134:30a8:9df5 with SMTP id c40-20020a056a20842800b0013430a89df5mr3953231pzd.43.1693425329068;
        Wed, 30 Aug 2023 12:55:29 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:9222])
        by smtp.gmail.com with ESMTPSA id l2-20020a170902d34200b001bb9f104328sm11465888plk.146.2023.08.30.12.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 12:55:28 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 30 Aug 2023 09:55:27 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH v2 1/1] workqueue: fix data race with the pwq->stats[]
 increment
Message-ID: <ZO-er9rbuXiqwfU6@slm.duckdns.org>
References: <20230826145102.5962-1-mirsad.todorovac@alu.unizg.hr>
 <ZO5Mk4a_LylG2AdM@slm.duckdns.org>
 <e5120df6-19f7-da11-1c53-e16fb92d9098@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5120df6-19f7-da11-1c53-e16fb92d9098@alu.unizg.hr>
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

On Wed, Aug 30, 2023 at 09:48:53PM +0200, Mirsad Todorovac wrote:
> These might just not have been triggered yet, but logically they seem suspicious for a data race.
> I still have to verify if they are called from a locked context ...
> 
> Of course, as the original developer, you will have a clearer picture. I have been led by KCSAN
> to this particular detail.

These are just stats and pwq's are already per-cpu (most of the time). If
they trip kcsan and there's no easy way to work around like here, we should
add a wrapper to inc the stat and annotate it so that kcsan ignores it.

Thanks.

-- 
tejun
