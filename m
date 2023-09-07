Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD377973EB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245465AbjIGPcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245182AbjIGP3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:29:22 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 575671FD3
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:28:55 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5230a22cfd1so1447064a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 08:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694100482; x=1694705282; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m2fdKFR8q9uEXLNSeU9tuN4gH8iEvFyeK5eSCmXl3rY=;
        b=sl4VtqiTaTL0s2nFmeh3GEqioyG6r16mqYVMjxhUfpUtu3gjrtVRvrVbEKfq2P9+mE
         9/nqgQbI/KfJX2RD/qf7IXLnHW6hL6uUwEPcvPObAaOBxvLAypMQbegt2qY1M559CCOI
         g6aWh4jWlvG5Nz3GHdUsWD8QjqTDBf+Vyety5oD+xpoNWpUQ89gBQQ+TS5DsGreEu1/u
         pzM45BI4aruF3pmV1hffgaG4At2o6NYDoSRWLuiZqPVsaHsvYfhUfsyOsPFl2+623ddX
         bj6PA4BmUTJHuWOjVnXb+6bJGdwWOBAjOXpgXMT0RtO4LgtwWeJOZ6+kKv6k7HzoPmwn
         lFlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694100482; x=1694705282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m2fdKFR8q9uEXLNSeU9tuN4gH8iEvFyeK5eSCmXl3rY=;
        b=LWagjcXVL4zAyOKE5Q7Q44yOWlI3Ez3jHMfuCH2aUOIEjyB4LcoEserFzON4rqZeVo
         2ClKY5sqwQFbXxGArhoe+zIIAMC0xH/5Nrz42zHtk9jy1GKeJIv+ixgOr+4Y8ZIpKggJ
         pQqWfSGdWZ9XglZ8/oM0XWFSl5OgKgEi1Vh1FMrEWLSc5suhV2MaZabHOWDRAjBiMGZD
         FchLMytam+7EfWOPb36UNN1A90mBbO4cpPO5WJU2vDQtDxEn2szOUWYa9PBLocvwASI7
         bXKvLMFIgeWdvTXbBJwoXR1CxfEr2B2W1TH1BIbtm57jJYsYpB9F+04NdbRN7erzK9yt
         sesw==
X-Gm-Message-State: AOJu0YwCwm+v8lYCp8F2LO1YeYrVhFsNDX7LppPDj+R1ewADRDJNogBn
        +FqVUjZyZzH2vDw6r/QUUdqKlulzhrffvw==
X-Google-Smtp-Source: AGHT+IGnVUxgJvZMlPBtKyIiXEz0zQ/L77txjqDYDTh1Sa3UGxaMrwFpLFqcHn1w07E0rmK4dukubA==
X-Received: by 2002:ac2:52ab:0:b0:500:5d5c:ecc9 with SMTP id r11-20020ac252ab000000b005005d5cecc9mr4043445lfm.62.1694079639175;
        Thu, 07 Sep 2023 02:40:39 -0700 (PDT)
Received: from pc636 (host-90-235-20-237.mobileonline.telia.com. [90.235.20.237])
        by smtp.gmail.com with ESMTPSA id t16-20020a192d50000000b00501c6d78f11sm597800lft.298.2023.09.07.02.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 02:40:38 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 7 Sep 2023 11:40:36 +0200
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
Message-ID: <ZPmalB+hfaxAZIcw@pc636>
References: <20230829081142.3619-1-urezki@gmail.com>
 <20230829081142.3619-5-urezki@gmail.com>
 <ZPkyw0nAQSQWj5H1@MiWiFi-R3L-srv>
 <ZPmZ/8CLpKHEZvQY@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPmZ/8CLpKHEZvQY@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 05:38:07PM +0800, Baoquan He wrote:
> On 09/07/23 at 10:17am, Baoquan He wrote:
> > Add Kazu and Lianbo to CC, and kexec mailing list
> > 
> > On 08/29/23 at 10:11am, Uladzislau Rezki (Sony) wrote:
> > > Store allocated objects in a separate nodes. A va->va_start
> > > address is converted into a correct node where it should
> > > be placed and resided. An addr_to_node() function is used
> > > to do a proper address conversion to determine a node that
> > > contains a VA.
> > > 
> > > Such approach balances VAs across nodes as a result an access
> > > becomes scalable. Number of nodes in a system depends on number
> > > of CPUs divided by two. The density factor in this case is 1/2.
> > > 
> > > Please note:
> > > 
> > > 1. As of now allocated VAs are bound to a node-0. It means the
> > >    patch does not give any difference comparing with a current
> > >    behavior;
> > > 
> > > 2. The global vmap_area_lock, vmap_area_root are removed as there
> > >    is no need in it anymore. The vmap_area_list is still kept and
> > >    is _empty_. It is exported for a kexec only;
> > 
> > I haven't taken a test, while accessing all nodes' busy tree to get
> > va of the lowest address could severely impact kcore reading efficiency
> > on system with many vmap nodes. People doing live debugging via
> > /proc/kcore will get a little surprise.
> > 
> > Empty vmap_area_list will break makedumpfile utility, Crash utility
> > could be impactd too. I checked makedumpfile code, it relys on
> > vmap_area_list to deduce the vmalloc_start value. 
> 
> Except of the empty vmap_area_list, this patch looks good to me.
> 
> We may need think of another way to export the vmalloc_start value or
> deduce it in makedumpfile/Crash utility. And then remove the useless
> vmap_area_list. I am not sure if we should remove vmap_area_list in this
> patch because the empty value will cause breakage anyway. Otherwise,
> 
> Reviewed-by: Baoquan He <bhe@redhat.com>
> 
Thanks for the review!

--
Uladzislau Rezki
