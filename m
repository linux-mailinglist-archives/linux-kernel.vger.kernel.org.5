Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB4F792931
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351060AbjIEQZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353615AbjIEGx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 02:53:28 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FF61B4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 23:53:24 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2bcde83ce9fso35032411fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 23:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693896803; x=1694501603; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+7q6noLayBRGFjtDqf1Mp8InGIGX9qawW6xGz5sWt8w=;
        b=VX2x7I04ZrVIGY27gGM8lH/tls/e3yuQGKMTv7Whfg2e8uimcAGvsgIkZedqOu+yQ1
         StdBjj0znGTwAtTvhf7Njz/OYJHIEPF3NkoeraXCnP7eE7k+fRlWdeFTwrKLk5WBkj9b
         W03L471MxSAUlPj7fweK2Ch6O0tF97Dh7uk/6f09sAfoNrpR71Hv9p7bz/6JteABHOXl
         leoDUS/zD4H8xWRv3Xg1kSZFBsfWFAEQwilsYmHtdONq6OC4BpmgLbRs1GIfaJrAGdWv
         kmbnIQt9u27Nyn7kNB2G/Ly/6knExPHB39bTb02N64VyfmONI0vPhqddffno+Cafs5Pl
         I0aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693896803; x=1694501603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+7q6noLayBRGFjtDqf1Mp8InGIGX9qawW6xGz5sWt8w=;
        b=HclRrQbhJHNNA0VAZ/96t/7T7AoRGUjHdVh7hRS1SqH7g3LGK2T5c4d9WOdt+F7nNc
         iF8D7gxX+B5YZ6SGOXUD2JTFg7r80I/XR0O2whoUAjiiGqa05BryvVMibXUmOdPWgAGs
         AWChhuy2sBRQeCT0YMT/S9tpRqgAD47ideN3itIuQAv5a8WE2lKascr8eOjz4J40PvuF
         p8pVn7NkmXaybu70Nsd7++SHmnhZoMmNKxDuibBhLCMf/7SQuyxOQNvWkPEb9b18V2ZH
         By46715SiGGZ7/EEwUTsViK2qSwxI3ArSuudV3TsRVWkgr7Py3htg8s63PdXI1CADjn4
         Hr7Q==
X-Gm-Message-State: AOJu0YxhiNr1dHbr0MkmthbWH3HYI3SGdPgBAqWj/ZMY7XpVnS2dGbFA
        3TRIobHQt7SWzPcYnk83hEQ=
X-Google-Smtp-Source: AGHT+IHteeM/jhvr0oU4JpMjn3nkwpQsCBKx2PhPYbyrmBcKaVXURGCntNDbubJnFJ3mtTz7VGMtMA==
X-Received: by 2002:a2e:2c1a:0:b0:2bc:c4af:36b7 with SMTP id s26-20020a2e2c1a000000b002bcc4af36b7mr8455176ljs.39.1693896802809;
        Mon, 04 Sep 2023 23:53:22 -0700 (PDT)
Received: from pc636 ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id w21-20020a2e9bd5000000b002b702dfb510sm2677797ljj.39.2023.09.04.23.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 23:53:22 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 5 Sep 2023 08:53:19 +0200
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v2 0/9] Mitigate a vmap lock contention v2
Message-ID: <ZPbQX3hmKR9aWsCd@pc636>
References: <20230829081142.3619-1-urezki@gmail.com>
 <ZPXv6o3a43xisdmc@pc636>
 <20230904125321.f827471daaf0997bf935cccd@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230904125321.f827471daaf0997bf935cccd@linux-foundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2023 at 12:53:21PM -0700, Andrew Morton wrote:
> On Mon, 4 Sep 2023 16:55:38 +0200 Uladzislau Rezki <urezki@gmail.com> wrote:
> 
> > It would be good if this series somehow could be tested having some runtime
> > from the people.
> 
> I grabbed it.  We're supposed to avoid adding new material to -next until
> after -rc1 is released, but I've cheated before ;)
> 
> That (inaccessible) pdf file is awkward.  Could you please send out
> a suitable [0/N] cover letter for this series, which can be incorporated
> into the git record?
>
There will be a v3 anyway where i update the cover latter. The v2 is not
adapted to recently introduced Joel's patch, which is not in linux-next
but will land soon:

<snip>
From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: mm/vmalloc: add a safer version of find_vm_area() for debug
Date: Mon, 4 Sep 2023 18:08:04 +0000

It is unsafe to dump vmalloc area information when trying to do so from
some contexts.  Add a safer trylock version of the same function to do a
best-effort VMA finding and use it from vmalloc_dump_obj().
<snip>

Also it might come some extra reviews and comments for v2.

Thanks!

--
Uladzislau Rezki
