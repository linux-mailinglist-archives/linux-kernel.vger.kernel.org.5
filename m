Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E645C7987BC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 15:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242990AbjIHNXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 09:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbjIHNXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 09:23:14 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321DB19BC
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 06:23:10 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2bcb89b476bso35040161fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 06:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694179388; x=1694784188; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F3bwfYcCfax2W/6G6e8Bu9Rry/CZk0T2gflxVUWD1AA=;
        b=kYRRCcukdp75EJPUEL8lsIXCgH9qkSrSJiOxL2YsF9tUPiMm6458QUSsmatf9KgeqW
         j6qiDXqzuU2lFXLcjqxrY+YnlDcIUJGAL6Dk/X80kOAN7QI7t8uoz+fuBvoaHiaKvF/c
         E9xfx0Ll+p+FAK/Ae9+jOe+JeD3GqlKMu7fjuGjZyJWKFZ6Ws8wIiE0JD8oyMbqDdwFH
         Ru+AOe7u3WDINPF5bX/ByrMLtxVwVqX5fWNCrqttyCvWP0BYCsMkltCS1sQ+cvx19iFn
         jMWmv/TEUUYAf2qgS0VdDFFJClNAFRRStp4gYJVWUxU+xvQzfb1SsPEOxcMSDPU78q/U
         QYxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694179388; x=1694784188;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F3bwfYcCfax2W/6G6e8Bu9Rry/CZk0T2gflxVUWD1AA=;
        b=oA66v2m+gvM3M4pOAfVL4Fn0vO6mZtimen8h/zpF8JLB71FG/IKmGbgLfUDWy1hAZy
         vpg6Pv4luocS8D9vA+EfTgAw74YBg3uv1KdAFvoBOri62PNoOSBy7ckhtuUOcXEvoyJu
         8BNZLKViUQeVXGSVaT1XaaDIOhHubKOPO9VhZgOHMc51qonGFY66zEQxF30EFOmvYlm3
         x1wIgZYQ9JRqkSWgTzu9Fc5gp7dh/tJ+8DvMbOpLuDXGpRzhOk8VCYoN0sgA8r3hrTdG
         f3gOm4PiGLoPw2pkzC7ENBg1QGQiy0NzbL6s1nOrOXUEjWM9jAtgLIF3sXtnla/OGx3h
         Y79A==
X-Gm-Message-State: AOJu0YyR7Bbfs5SPURXuENRkpwsYF83M6kYusMlienFE6xEVUzueSXjB
        7Hyeia1vwAMwMr/lalONErs=
X-Google-Smtp-Source: AGHT+IHsbWj/tbUu0fBjassxuH/Te7MYFp5lDznI8mcQY9BpFsJcl2xzr+rfSlfIUUsXacLbIOB/oQ==
X-Received: by 2002:a05:6512:3d1c:b0:4ff:8c9e:eb0d with SMTP id d28-20020a0565123d1c00b004ff8c9eeb0dmr2349101lfv.0.1694179388078;
        Fri, 08 Sep 2023 06:23:08 -0700 (PDT)
Received: from pc636 (host-90-235-20-237.mobileonline.telia.com. [90.235.20.237])
        by smtp.gmail.com with ESMTPSA id eq7-20020a056512488700b00500a2091e2bsm287247lfb.99.2023.09.08.06.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 06:23:07 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Fri, 8 Sep 2023 15:23:04 +0200
To:     Baoquan He <bhe@redhat.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>, k-hagio-ab@nec.com,
        "lijiang@redhat.com" <lijiang@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: [PATCH v2 4/9] mm: vmalloc: Remove global vmap_area_root rb-tree
Message-ID: <ZPsgOHZS4Iacxvbv@pc636>
References: <20230829081142.3619-5-urezki@gmail.com>
 <ZPkyw0nAQSQWj5H1@MiWiFi-R3L-srv>
 <ZPmaYgsT5EdLVUyO@pc636>
 <ZPmesS66PTl+1Mdz@MiWiFi-R3L-srv>
 <8939ea67-ca27-1aa5-dfff-37d78ad59bb8@nec.com>
 <ZPqmZq29U4hrJPaG@MiWiFi-R3L-srv>
 <1d613b25-58d8-375b-6ef4-b27bc9b735e3@nec.com>
 <ZPrC6F76sBLtDgjJ@MiWiFi-R3L-srv>
 <ZPsEqcREYksx9Ot8@pc636>
 <ZPsHwrjG+/6r7ln9@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPsHwrjG+/6r7ln9@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > 
> > Appreciate for your great input. This patch can go as standalone
> > with slight commit message updating or i can take it and send it
> > out as part of v3.
> > 
> > Either way i am totally fine. What do you prefer?
> 
> Maybe take it together with this patchset in v3. Thanks.
> 
OK, i will deliver it with v3. Again, thank you very much.

--
Uladzislau Rezki
