Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3AC17EB6B7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 20:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjKNTGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 14:06:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKNTGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 14:06:33 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FD0F4;
        Tue, 14 Nov 2023 11:06:29 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1cc2f17ab26so44705665ad.0;
        Tue, 14 Nov 2023 11:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699988789; x=1700593589; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=urqBj0zb7kZFEkUMQGR6pNJyF02lpf86g7TXhAR7sLM=;
        b=DfGKLZlAOIGGsWyBQ+E6t4yIvFUxxp7NAhsHSEAuvuE1wWX701K9xc8t1+K/ALIIkg
         Byjpz9uUnkgDel4NgMydJ7lz7nPBvqtVNIjYV4lYtVN8f+wEOaLK6bGnLi4G6LM0AnCO
         F3HuwuX/WKtGOBXz2UqqK0qQb3vZbH0y5XmkiOoMvUleMQ11pqRVSD75r3/QhO8jWIZX
         /UzZePKJQoPjFVFKNam8oWbK1G1zRV8T32yCJPSOutNlxYPbRhP9TGlebu01PPD1usFz
         rm/NvkGlZQnLaUc4maE97ZQIoQH4lRJ/t2Bj+kQkvVLx1hEANbqCfFhG9Angj3nwoou/
         Hh9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699988789; x=1700593589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=urqBj0zb7kZFEkUMQGR6pNJyF02lpf86g7TXhAR7sLM=;
        b=TgPVhiRmVvodbyFXLaI2EV9oYH4EalfbK0mtPTVb3yx+zk2676qukNAM6SGPPQIQuE
         izplHLf349ncrGmKur9dBU/nq+dX/E15RrEBL84epi2+FF+V6RfLAzbPh9hhjUr/2JXY
         UvdYpp1JLVlUFyny13CtDgYrNYDC+OqDy549klNcG1FpKjmGadbL7jwU0vtExYPH3/A5
         7qbIG8X32WUSHDsj8CZdo3nD9kBC+7vEYC3ipSeWnvqp2K0FH2ZFZ++CqcusXJchNc0m
         +VrbX43dDT+pmxXwJEJt/UxAW39K1LHDVj6tr6FBqc7FDSatWbTJYD0xO/i3evh1X1md
         JE7Q==
X-Gm-Message-State: AOJu0YwSuyWCkyxjRNietspxu2nlW5thHQMszrWNTzv5+XNaUrMsAm2A
        t2zNd9cnci7WU+yVwagyNeo=
X-Google-Smtp-Source: AGHT+IEdvbr2Rim6nqvBxEn2Ur1gOT9Y/HexN6l0iBrgQ/84BO9sAaVucvHKwhjnwDdsGZmxSlr0yQ==
X-Received: by 2002:a17:902:ce0f:b0:1cc:7a8e:606b with SMTP id k15-20020a170902ce0f00b001cc7a8e606bmr4244608plg.43.1699988789102;
        Tue, 14 Nov 2023 11:06:29 -0800 (PST)
Received: from localhost (dhcp-72-253-202-210.hawaiiantel.net. [72.253.202.210])
        by smtp.gmail.com with ESMTPSA id c5-20020a170902d90500b001bc5dc0cd75sm5961929plz.180.2023.11.14.11.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 11:06:28 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 14 Nov 2023 09:06:27 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Junxiao Bi <junxiao.bi@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH] kernfs: support kernfs notify in memory recliam context
Message-ID: <ZVPFMzHAx9JVz2ak@slm.duckdns.org>
References: <20231114185947.42829-1-junxiao.bi@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114185947.42829-1-junxiao.bi@oracle.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Nov 14, 2023 at 10:59:47AM -0800, Junxiao Bi wrote:
> kernfs notify is used in write path of md (md_write_start) to wake up
> userspace daemon, like "mdmon" for updating md superblock of imsm raid,
> md write will wait for that update done before issuing the write, if this

How is forward progress guarnateed for that userspace daemon? This sounds
like a really fragile setup.

> write is used for memory reclaim, the system may hung due to kernel notify
> can't be executed, that's because kernel notify is executed by "system_wq"
> which doesn't have a rescuer thread and kworker thread may not be created
> due to memory pressure, then userspace daemon can't be woke up and md write
> will hung.
> 
> According Tejun, this can't be fixed by add RECLAIM to "system_wq" because
> that workqueue is shared and someone else might occupy that rescuer thread,
> to fix this from md side, have to replace kernfs notify with other way to
> communite with userspace daemon, that will break userspace interface,
> so use a separated workqueue for kernefs notify to allow it be used in
> memory reclaim context.

I'm not necessarily against the change but please go into a bit more details
on how and why it's structured this way and add a comment explaining
explaining who's depending on kernfs notify for reclaim forward progress.

Thanks.

-- 
tejun
