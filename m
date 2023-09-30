Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E44CD7B4397
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 22:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbjI3Ufm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 16:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbjI3Ufl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 16:35:41 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9D4DD
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 13:35:39 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id 006d021491bc7-57bab8676f9so5842483eaf.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 13:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696106138; x=1696710938; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q9xYfZBQImKsyGrauSkx40CmvbMShT//GSfSxiyP5zE=;
        b=Ye1YXWGhPBAEgxH8F7NwQJfHX5pchAHb9kgSKo+qBWuvEkdXpVJPqa7RpnmHnCef0w
         6ApazzzAQJ29LS1KLjHDUU1Yoozz8lvzbwj+VdNf8TkWvjh0B6z/3NMZeSaaFCRDH9im
         ts+YC8WjjISa8Rg46ZbZJWa277QGHiZdrUX+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696106138; x=1696710938;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q9xYfZBQImKsyGrauSkx40CmvbMShT//GSfSxiyP5zE=;
        b=eAG/yJwSVyYqj0hKVLLSXxVVnoHaDkbFe+DDUz6yscQ8cZgV51iv8CAycNYMp0iugz
         nAbeAJ+9YyHBrzV58uuMFnBCs6CP0155YYlZZv4J4wKxRBeU0nmkRG8SfruTn+T0bulj
         z3qKiXeC/2sV9sTzJ2eEapp98JRG/4hiLZu8y4LZHRacFbRnw/VYecmhaT4yqO6bWKW5
         4Zi2sCK32H5uPkjzigp1FKcE7aok7iorovYRaQsu0cdhj+CwbqvVVKJLfbG2ShotlrH1
         cn8krYARORlRlnwK733nE+w4fhB6ahnpQOp8iu18Qf6f7a8ESbM6B2tYJZFfg7vKDJkK
         9FIA==
X-Gm-Message-State: AOJu0YwhKLgoSmsLlhXzt/NVaAXZLsEv/mBjBUUutALSC27IBMCv3dW6
        ajFfUb/1fVaOmTzDEcH0HlH6cQ==
X-Google-Smtp-Source: AGHT+IES6FCR6Oc6pFQSlN7yRWa0cm//27qrbGfY1PvU67WmpoTEAmenT310bfviix1NiTa1MWHqJQ==
X-Received: by 2002:a05:6358:718b:b0:143:7a89:a8e8 with SMTP id t11-20020a056358718b00b001437a89a8e8mr8441521rwt.10.1696106138275;
        Sat, 30 Sep 2023 13:35:38 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t14-20020a056a0021ce00b0068bc461b68fsm16653273pfj.204.2023.09.30.13.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 13:35:37 -0700 (PDT)
Date:   Sat, 30 Sep 2023 13:35:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     syzbot <syzbot+510dcbdc6befa1e6b2f6@syzkaller.appspotmail.com>
Cc:     chandan.babu@oracle.com, david@fromorbit.com, djwong@kernel.org,
        ebiggers@kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        mukattreyee@gmail.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [xfs?] UBSAN: array-index-out-of-bounds in
 xfs_attr3_leaf_add_work
Message-ID: <202309301334.FA4D7752@keescook>
References: <0000000000001c8edb05fe518644@google.com>
 <0000000000003c16100606974653@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000003c16100606974653@google.com>
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 30, 2023 at 10:57:28AM -0700, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit a49bbce58ea90b14d4cb1d00681023a8606955f2
> Author: Darrick J. Wong <djwong@kernel.org>
> Date:   Mon Jul 10 16:12:20 2023 +0000
> 
>     xfs: convert flex-array declarations in xfs attr leaf blocks
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12eef28a680000
> start commit:   f8566aa4f176 Merge tag 'x86-urgent-2023-07-01' of git://gi..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3f27fb02fc20d955
> dashboard link: https://syzkaller.appspot.com/bug?extid=510dcbdc6befa1e6b2f6
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1652938f280000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14c10c40a80000
> 
> If the result looks correct, please mark the issue as fixed by replying with:

Yup, that tracks. :)

#syz fix: xfs: convert flex-array declarations in xfs attr leaf blocks

-Kees

> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

-- 
Kees Cook
