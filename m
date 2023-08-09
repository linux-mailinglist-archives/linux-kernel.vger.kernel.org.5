Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A709D7751CE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 06:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjHIELF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 00:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjHIELD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 00:11:03 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98C01BC3
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 21:11:02 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bc8045e09dso10516225ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 21:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691554262; x=1692159062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5dt4L8Eisj7VPGHsPUbVvR+t+KgnMwIP1KcG33bKmKA=;
        b=WfaNPrDcrU8FlDCiViXO8W8BmLESLDTQ9aXTVaDeC2d34m4rZdw2gvyxFrMstwTe8B
         Jv71ibRQHwFcJDomULkulYIjGVJueuebyH65m2LE1w6Mx3Lq17+24cChBSIs3HLwcz6m
         2UQ3BjcAsXmNNq8DwAIv/7cn6of/sGuOYfn5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691554262; x=1692159062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5dt4L8Eisj7VPGHsPUbVvR+t+KgnMwIP1KcG33bKmKA=;
        b=NsyC1/zqj7jABLqj8diUVIqkVse24CXgus9smedCGQbUNObBgTjTK7v+588ed3aCrG
         4VBBHYyxmBv9XDWsqcy8BVaJ+kNWe56GLUfyZFuEKOOkqAvXRUeImszTETFcBfiCyem7
         NbGCT8Bx6AbpEd6FLEY7c2lToY0d4NytJ1VYN/OPu5jV41SnpvWp+jRNP4deFgM505Vb
         sBu9teOZ46nKTJKGSHvPai3RDrEI8QbhFPI9zbr6/LS+Q7MiltpVGrzbLz4PHKT2pwoK
         U1JWVZrOFWN2wVwTJs2HCASxW19oIO0Iwi7GutpShiPncZXKnL5S/H1lJE4HqxKJ0esx
         RUKw==
X-Gm-Message-State: AOJu0YzjOKPs4QzhUbbh9A1WplYzJB+fWcmhgDGPKKZtJor8U02lYrv3
        Hfg83RWiDaO/Z8jo1gtLnlFIRmhSDzdvKKUANug=
X-Google-Smtp-Source: AGHT+IH5whshNOeWJ/7rgwCTfz0nL6npNr89QNKM+we0MVxaYePX7iD/K1AG2auy9F8LoDGWcvjnWA==
X-Received: by 2002:a17:902:c1c5:b0:1bb:bbda:70d9 with SMTP id c5-20020a170902c1c500b001bbbbda70d9mr1324646plc.63.1691554262272;
        Tue, 08 Aug 2023 21:11:02 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:fdf2:7f85:e85a:4c61])
        by smtp.gmail.com with ESMTPSA id t15-20020a1709027fcf00b001bb9d6b1baasm9999499plb.198.2023.08.08.21.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 21:11:01 -0700 (PDT)
Date:   Wed, 9 Aug 2023 13:10:57 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huaweicloud.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org, Zhen Lei <thunder.leizhen@huawei.com>
Subject: Re: [PATCH 2/2] hexdump: add a new dump prefix
 DUMP_PREFIX_ADDRESS_LOW16
Message-ID: <20230809041057.GB681074@google.com>
References: <20230805072116.1260-1-thunder.leizhen@huaweicloud.com>
 <20230805072116.1260-3-thunder.leizhen@huaweicloud.com>
 <20230807211409.750c17a5@gandalf.local.home>
 <73d10b7f-3cba-6897-0ff8-7759ef39a908@huaweicloud.com>
 <319df959-5be9-66c5-680f-4a5ae59019b9@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <319df959-5be9-66c5-680f-4a5ae59019b9@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/08/08 15:52), Leizhen (ThunderTown) wrote:
> >> I find the "before" much easier to read than the "after".
> 
> I added the boot option no_hash_pointers, so "before" can print the
> address. Otherwise, just print the 32-bit hash value, as shown below:


> [   14.872153] dump memory at sp=ffff800080903aa0:

This line is not guaranteed to be printed. If you get
"** N printk messages dropped **" instead then the
ADDRESS_LOW16 math doesn't work.

> Actually, I added DUMP_PREFIX_ADDRESS_LOW16 because of another scene:
> slab kmalloc-512 start ffff3b3c0094e800 pointer offset 168 size 512
> e888: 00400000 00000000 000f7704 00000000
> e898: 000f7704 00000000 12345678 00000000
> e8a8: 00000000 00000000 00000000 00000000
> e8b8: 9abcdef0 00000000 00507dd0 00000000
> 
> Here, the start address ffff3b3c0094e800 of slab object is printed by %px,
> the address of the error data is at p=ffff3b3c0094e8a8 = ffff3b3c0094e800 + offset 168.
> To locate the problem, dump up to 64 bytes centered on 'p'.
