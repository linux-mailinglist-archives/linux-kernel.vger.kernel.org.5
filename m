Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222247C7770
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442670AbjJLTyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442867AbjJLTyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:54:00 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18718D7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:53:59 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6b1d1099a84so124707b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697140438; x=1697745238; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E3uPZFNiK+r0yTq1LiRsc3J6XZzg5z+dFiOxbyPUDVU=;
        b=ibHzmHdwkQuul0yXQofDDxCbs/XcpKNcFEgCsXpmxZPOKYhdGJj4zZcU8AgBBdlDZV
         9lVtOVpQK/9eHT8NcYoUQOoX1M5syMwm2J23319VVZxZA/Aq5/PfCQek0MR0XEVfVck6
         MjRkuQDddyaU0rWxSpWaZVCNwK+3jUJWvW43e0xv8LYCf2Q6XiyUNsJpEOn2/OyPhMDi
         5W+BT0xARiLoQxBmm2MDdQUWWnQVq4vtYPcHvs4AZc6nmtAPayJdsK9bAzRYWb/0VIk7
         3g1mIUY0CEtDHEW7h3MmWpnGiVqACi0IEA7K9MKPyexWIQI7TLCgm7T9ZR8eQ2UyRgPX
         H21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697140438; x=1697745238;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E3uPZFNiK+r0yTq1LiRsc3J6XZzg5z+dFiOxbyPUDVU=;
        b=j1W3kh6BAilXMDK6Y+oLRDTK9ml1dRRhECpudYO8YStpo8xIvyyM7Q9Von+XE6XbTU
         8ipQPS7ry59Frmh6QgKhUdGKH3tB2TeqmTU5+bi8uGH7b3RiYkA8qziac5DDrjuxBrpT
         0X3p8ioxZ2kqRjugS844I+GKG6U82nS9nWBW4CpaHppZ/3ci7KFp192Y42cG+MeSCbW4
         14i7gOqRxXizyc7g9UiRNWD5Kwy77h9qWRkTQLSTNEHMgo/VlekqjV0b3emzFLvHkSyk
         KTwUMhp8nImp9BjGYgpdUVkPKDMtYsh9PDcaRDyu9yMkI4QS+arl3coPIzHWPjXvnKOV
         xxUQ==
X-Gm-Message-State: AOJu0YyoeoGfv47RKw6WpqxMrjT0mIDB9GVN5KVaq+liQL/n7tai/yWn
        Oh00aF/cfI4AWSrHFLZZMUA=
X-Google-Smtp-Source: AGHT+IEJfAPns6NW9huFfz8r2ddPKV/d3O+vGqkXEm4kmrggpMUXGtGdlp873SAXlOI1KHu7dtQWDQ==
X-Received: by 2002:a05:6a20:7d85:b0:15c:b7bb:2bb5 with SMTP id v5-20020a056a207d8500b0015cb7bb2bb5mr30815302pzj.7.1697140438399;
        Thu, 12 Oct 2023 12:53:58 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id t2-20020a170902e84200b001b896686c78sm2372464plg.66.2023.10.12.12.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 12:53:57 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 12 Oct 2023 09:53:56 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Lucy Mielke <lucymielke@icloud.com>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: fix -Wformat-truncation in create_worker
Message-ID: <ZShO1HOVI8WkxziA@slm.duckdns.org>
References: <ZSQz2if1dYelUdzE@fedora.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZSQz2if1dYelUdzE@fedora.fritz.box>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 07:09:46PM +0200, Lucy Mielke wrote:
> Compiling with W=1 emitted the following warning
> (Compiler: gcc (x86-64, ver. 13.2.1, .config: result of make allyesconfig,
> "Treat warnings as errors" turned off):
> 
> kernel/workqueue.c:2188:54: warning: ‘%d’ directive output may be
> 	truncated writing between 1 and 10 bytes into a region of size
> 	between 5 and 14 [-Wformat-truncation=]
> kernel/workqueue.c:2188:50: note: directive argument in the range
> 	[0, 2147483647]
> kernel/workqueue.c:2188:17: note: ‘snprintf’ output between 4 and 23 bytes
> 	into a destination of size 16
> 
> setting "id_buf" to size 23 will silence the warning, since GCC
> determines snprintf's output to be max. 23 bytes in line 2188.
> 
> Please let me know if there are any mistakes in my patch!
> 
> Signed-off-by: Lucy Mielke <lucymielke@icloud.com>

Applied to wq/for-6.6-fixes.

Thanks.

-- 
tejun
