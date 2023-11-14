Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0AB7EB7BA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 21:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233965AbjKNUYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 15:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjKNUY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 15:24:29 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6087F5;
        Tue, 14 Nov 2023 12:24:25 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1ce1603f5cdso24985015ad.3;
        Tue, 14 Nov 2023 12:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699993465; x=1700598265; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dAdihVEVUM5rdqvzQTqRetcngziF8bFBmTLsXzcP854=;
        b=VnHxykGLl2+HFc9oPv+7Wj+sq14f+7TppucbXCPnetxM5HLq5She0CW3XS4l2gZDhm
         +rECNjbE2iZkzoI3RQFT2VpI0yI/ycZyzX3TX283k2dIY8Wb7cSFPuFZknrCv+lpWpn5
         9iwPI4C7Z2Kq2DaPDtvdPbNrJP42+n/JhBiDiu+AIJOVqh45+ytCKwK46MqI/pP/KOlx
         di0lAAiiT+IS4XS/GIcZqslMfFKiX523qKER5hqgVooLngMyvGZT2slcAni/liM6hPm0
         7KNQ+m9ZR4sLcSe2dxIMN0yH4cqvS5iffmog0VcIFGa9DSg4VlaMlxaWrdpdYUhewbu9
         Nxzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699993465; x=1700598265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dAdihVEVUM5rdqvzQTqRetcngziF8bFBmTLsXzcP854=;
        b=uRcoMZVyiafPHcFjijyRDU2DdEQEJXEaPtgtS8+fca7yZuG3AYczc22WLd+kzEyo8s
         KS3Ywn/VK9wKrHFIYVX47fux686BcIZCEv2RdpRKy2be7TPCmyPnUtI6KFMM1aZ1MjaX
         4Gy85Uss1VDcb5LFEUGKgbI8N3emZCkaMdLB284qwtCibfmdv2ClD1aKUZmHBybpFTB3
         Wx3M7/rmmGVDko00aHifxl/FGHcRXVo1iBjfq/oxFfds6BwsDIzoILw+lHlMnBkCoH7R
         iPOdWKywULW9cyWumREbYYQcMOfltctZi+DdxyY6cB8edVLqgEOwCtO1LIYZJqjQ4O9o
         cK4w==
X-Gm-Message-State: AOJu0YxIrNuMoJtvxrs4fYYL8aXubuOYz6Hd3xsflpcSori2t5Ovu6od
        3tKCyG+bQ8YW8cpXOC7a3nwS2w4p7oFt6A==
X-Google-Smtp-Source: AGHT+IH/E/PUkZbmZhQEB+hxvASoGlfQuwkNXtWtHVdvuc7Jx/8BFYcGzEKl75WKa8ZP0VhDHPUaNg==
X-Received: by 2002:a17:902:cec1:b0:1cc:3357:2ee8 with SMTP id d1-20020a170902cec100b001cc33572ee8mr4094389plg.25.1699993465171;
        Tue, 14 Nov 2023 12:24:25 -0800 (PST)
Received: from localhost (dhcp-72-253-202-210.hawaiiantel.net. [72.253.202.210])
        by smtp.gmail.com with ESMTPSA id l14-20020a170902f68e00b001ca4ad86357sm6049866plg.227.2023.11.14.12.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 12:24:24 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 14 Nov 2023 10:24:23 -1000
From:   Tejun Heo <tj@kernel.org>
To:     junxiao.bi@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH] kernfs: support kernfs notify in memory recliam context
Message-ID: <ZVPXd-3TshjeScek@slm.duckdns.org>
References: <20231114185947.42829-1-junxiao.bi@oracle.com>
 <ZVPFMzHAx9JVz2ak@slm.duckdns.org>
 <c71f1cb7-14d6-45e4-9df1-dc9bc82deda8@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c71f1cb7-14d6-45e4-9df1-dc9bc82deda8@oracle.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Nov 14, 2023 at 12:09:19PM -0800, junxiao.bi@oracle.com wrote:
> On 11/14/23 11:06 AM, Tejun Heo wrote:
> > On Tue, Nov 14, 2023 at 10:59:47AM -0800, Junxiao Bi wrote:
> > > kernfs notify is used in write path of md (md_write_start) to wake up
> > > userspace daemon, like "mdmon" for updating md superblock of imsm raid,
> > > md write will wait for that update done before issuing the write, if this
> > How is forward progress guarnateed for that userspace daemon? This sounds
> > like a really fragile setup.
> 
> For imsm raid, userspace daemon "mdmon" is responsible for updating raid
> metadata, kernel will use kernfs_notify to wake up the daemon anywhere
> metadata update is required. If the daemon can't move forward, write may
> hung, but that will be a bug in the daemon?

I see. That sounds very fragile and I'm not quite sure that can ever be made
to work reliably. While memlocking everything needed and being really
judicious about which syscalls to make will probably get you pretty far,
there are things like task_work which gets scheduled and executed when a
task is about to return to userspace. Those things are allowed to grab e.g.
mutexes in the kernel and allocate memory and so on, and can deadlock under
memory pressure.

Even just looking at kernfs_notify, it down_reads()
root->kernfs_supers_rwsem which might already be write-locked by somebody
who's waiting on memory allocation.

The patch you're proposing removes one link in the dependency chain but
there are many on there. I'm not sure this is fixable. Nobody writes kernel
code thinking that userspace code can be on the memory reclaim dependency
chain.

Thanks.

-- 
tejun
