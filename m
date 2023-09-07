Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C7C7977E9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241610AbjIGQgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241373AbjIGQgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:36:40 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7D086B6
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 09:30:22 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2bd0d135ca3so20922781fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 09:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694104157; x=1694708957; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gSn/skXMWf/xa0+iNC5/Gw93hjM5QOQeyldszIVaJcM=;
        b=LtSDPBpN6Q6YbmBs0RGn6p9B5WO5hdhTPWRkY5baic3SeHw7Q3MPL08XIEVjMH0zus
         L6W+wRbjwX0avGSK8MEJeUaxIkl7UQqHbSy2j6L8VoBrOnii643zdjPVoJp94l8JEqjQ
         WuUPoMdULbDzyr0p7dpIbitHRulKBiWhB/NoNRbvXRIoygKEbu3LiX2EQh7jB51uH3C7
         qmSV4G/ANHuHlCMgLKohd7OgrrN93PR7AiihyMeY8GC1cwuue7XTDrGldLSnwempFz8L
         5S4IYwm3qXzIeqi6Mf9/BgTR29XcK2jQ4aOQcNK0p837VKYCv7NNaKNhAEx6yOn3BJwg
         cAmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694104157; x=1694708957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gSn/skXMWf/xa0+iNC5/Gw93hjM5QOQeyldszIVaJcM=;
        b=hg99mXmPBPc1UUMn1YoQ9gU8yH6dTdKPKgqfEuqdBmpXj3Xd7xiwgcgNtiCb/WxdD3
         Z0JmnxUCvgUeDCi4H9t8CTHglSStMPGeyX+9+Ol5LqO8XHig2lPKnQIBAO6UIF+ToWxp
         JbMsDD8yh8+FVqnDtBjqT61f8PgldziUWVHhnnLCOiYstnkWrAOJwdqmOQS2oh3e022s
         DK2GNBTN4qIYFYz6XOxpX8cnqVv8bK38VnQZvjCzQguwhqy4+EESMThMylgAYr/Aj9gv
         nCLI8aiZuzDAw8ObMZNmHCGaaCP03J8EthbxEB8f7e83+5GnrqqfqB6SJVAN76BdOMz6
         9uLQ==
X-Gm-Message-State: AOJu0YylGwKJ0MrPsYjZGIIHQzXUMHV/5eOKaA/LXet2x86ILG515YR3
        YERzGePhr9yQm2I9IInUFPfAxF2KKeV/5Q==
X-Google-Smtp-Source: AGHT+IG1t55SSsZ9IU41gZXp4fEBDaVSYmlggSt5r5GETk7wcr+KmFaGuKy5GVo7hA7HKyZxxIJlPQ==
X-Received: by 2002:ac2:4db5:0:b0:500:b7dc:6c90 with SMTP id h21-20020ac24db5000000b00500b7dc6c90mr4108472lfe.36.1694079590034;
        Thu, 07 Sep 2023 02:39:50 -0700 (PDT)
Received: from pc636 (host-90-235-20-237.mobileonline.telia.com. [90.235.20.237])
        by smtp.gmail.com with ESMTPSA id w14-20020a05651204ce00b004fe2de20d88sm3082119lfq.232.2023.09.07.02.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 02:39:49 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 7 Sep 2023 11:39:46 +0200
To:     Baoquan He <bhe@redhat.com>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>, k-hagio-ab@nec.com,
        lijiang@redhat.com, linux-mm@kvack.org,
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
        kexec@lists.infradead.org
Subject: Re: [PATCH v2 4/9] mm: vmalloc: Remove global vmap_area_root rb-tree
Message-ID: <ZPmaYgsT5EdLVUyO@pc636>
References: <20230829081142.3619-1-urezki@gmail.com>
 <20230829081142.3619-5-urezki@gmail.com>
 <ZPkyw0nAQSQWj5H1@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPkyw0nAQSQWj5H1@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 10:17:39AM +0800, Baoquan He wrote:
> Add Kazu and Lianbo to CC, and kexec mailing list
> 
> On 08/29/23 at 10:11am, Uladzislau Rezki (Sony) wrote:
> > Store allocated objects in a separate nodes. A va->va_start
> > address is converted into a correct node where it should
> > be placed and resided. An addr_to_node() function is used
> > to do a proper address conversion to determine a node that
> > contains a VA.
> > 
> > Such approach balances VAs across nodes as a result an access
> > becomes scalable. Number of nodes in a system depends on number
> > of CPUs divided by two. The density factor in this case is 1/2.
> > 
> > Please note:
> > 
> > 1. As of now allocated VAs are bound to a node-0. It means the
> >    patch does not give any difference comparing with a current
> >    behavior;
> > 
> > 2. The global vmap_area_lock, vmap_area_root are removed as there
> >    is no need in it anymore. The vmap_area_list is still kept and
> >    is _empty_. It is exported for a kexec only;
> 
> I haven't taken a test, while accessing all nodes' busy tree to get
> va of the lowest address could severely impact kcore reading efficiency
> on system with many vmap nodes. People doing live debugging via
> /proc/kcore will get a little surprise.
> 
>
> Empty vmap_area_list will break makedumpfile utility, Crash utility
> could be impactd too. I checked makedumpfile code, it relys on
> vmap_area_list to deduce the vmalloc_start value. 
>
It is left part and i hope i fix it in v3. The problem here is
we can not give an opportunity to access to vmap internals from
outside. This is just not correct, i.e. you are not allowed to
access the list directly.

--
Uladzislau Rezki
