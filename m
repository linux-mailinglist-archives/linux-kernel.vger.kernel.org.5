Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9736E7A25D1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 20:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236463AbjIOSc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 14:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236684AbjIOScY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 14:32:24 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975FA2701
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 11:32:08 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-502f302b68dso1762605e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 11:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694802727; x=1695407527; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r4qOgQZGUPDtGepU+rJ+7Y5iLwmLrxU6Hce3v8t4Ygg=;
        b=eHKaFqVtPOx1MdxbHcGwK80UDy3HNcb/wJ5nz53T9X7wiEJEFMuY0V9ZVETpTolBm4
         HWm6Qy/kyP+mltqrUPv859zf8NdSHMqzgP/JjHVz+YWVs0C+wOppYK20alEY5Vom+5ba
         2SjB2VYYqZB9o6nz+j8zFGdTQCeNlawAR7JUZeGD5bOqZc0G794nzDSzHR/uMfmocgfN
         ue2p3TbcckPWAAE1Oo4S81sS5W0j0oFERh77t8ffxmJNK2vheuliUCVodEK0nyhg1VuL
         5MNoYTMTMuojGZLpHDtcQU1uJzfZ/WpIF7Um9lM6hKVLOhDFSwpgF7Nrdgi/3A3cKeDN
         E8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694802727; x=1695407527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r4qOgQZGUPDtGepU+rJ+7Y5iLwmLrxU6Hce3v8t4Ygg=;
        b=O8pFb/B5P0nobDdYLP4wDDBHOfHWYQyMajrV/VfBt0dXC3fPVPI8lgHK1c7EWVJKhj
         4nSWHiOqVCfBeHZNkMZigAs7nMbBzyGls+F5m+zAS83owZBFJj4/qPJYKqXVKfcgLU3v
         l5/owJRYq/mtwJO3i6DoYqjO/qfeSq/Bed+HDtLUvCJBhg3P06wgAAz/w3CCQdpu5k7u
         DVliVAC105ggqDL1qLXV51ii7EpzrDK3xuw5u5fRN4ZmvHQxEMKp8z4PKMW7xmGFevJd
         gLfCndcPB5ppKYPnpsPJnKjREuCKe3i+BdZpyUpEjac1L+hMvsP5d2Wco0cKKZ8RB7np
         EIag==
X-Gm-Message-State: AOJu0Yz/oWeH+Wk9AT9niSZL/79Q79XaaQpatkea2kHh17fAJW6oa/6y
        f1ld29vXznUzlUa4OQ0LGPc=
X-Google-Smtp-Source: AGHT+IHOZ4bJMSAvULJjPNfeLQNDgri2siIlVglMIx3VUQB/Lm2KI3XbkZVyFpXzSpY8/Z17CC/7qw==
X-Received: by 2002:a19:5054:0:b0:500:bb99:69a6 with SMTP id z20-20020a195054000000b00500bb9969a6mr2331302lfj.39.1694802726534;
        Fri, 15 Sep 2023 11:32:06 -0700 (PDT)
Received: from pc636 ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id m25-20020a195219000000b004ff91a94156sm718963lfb.121.2023.09.15.11.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 11:32:06 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Fri, 15 Sep 2023 20:32:04 +0200
To:     Baoquan He <bhe@redhat.com>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v2 8/9] mm: vmalloc: Support multiple nodes in vmallocinfo
Message-ID: <ZQSjJOqEEqBlKiwE@pc636>
References: <20230829081142.3619-1-urezki@gmail.com>
 <20230829081142.3619-9-urezki@gmail.com>
 <ZQRV7fAXEZNFWAx4@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQRV7fAXEZNFWAx4@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 09:02:37PM +0800, Baoquan He wrote:
> On 08/29/23 at 10:11am, Uladzislau Rezki (Sony) wrote:
> > Allocated areas are spread among nodes, it implies that
> > the scanning has to be performed individually of each node
> > in order to dump all existing VAs.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> >  mm/vmalloc.c | 120 ++++++++++++++++++++-------------------------------
> >  1 file changed, 47 insertions(+), 73 deletions(-)
> 
> LGTM,
> 
> Reviewed-by: Baoquan He <bhe@redhat.com>
> 
Thank you for review, applied for v3.

--
Uladzislau Rezki
