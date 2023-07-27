Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE9B765FEC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 00:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbjG0Wua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 18:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232955AbjG0Wu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 18:50:28 -0400
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8971FCD
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 15:50:23 -0700 (PDT)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1b9c5e07c1bso12144435ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 15:50:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690498223; x=1691103023;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Ck3lyZGLf+F2YFdZHPFliqXqnqZBVSPAOZfVe+yCL0=;
        b=CEjw6VdDK77ZMNdqzGirYUNfbYCStqQ0HgD7r2vWjxj+fLkNCssVP61eGrmqFywo77
         TCwi921IZ6Q62eYXf2+RsE3o9rEM7eXzUjpnwc4gFAOadUQEEG/cisgk3TxOz3ymNsZo
         iaYlwcagbMXxR+2xllzWZBUfo71E0FbUkT+ch25kF0vIK932nb0/pi8+bF2Z6r4mtjEz
         gb5P6WLqkJK8CxT9QC4GmTYIkTeeOa7mzANLg10MeOdB1evGPRDrk5ZXL+0gCaSK3Lpo
         f56OSYilVPVK/D/9YD3r1adI3VlffRjUqSBm68Ay7SBbwYltDU9wacEVHkODvn46XzUJ
         LTdQ==
X-Gm-Message-State: ABy/qLYfw1Idoz9CI4fKftE0n9IOjDBp42TO+EhWFTRm4pP9NZs1QFtF
        YBLH41elyFj2O5MItpICrd8=
X-Google-Smtp-Source: APBJJlEIPFubxJ7JROG/8yCHhxVJJ/qEZLipx8hx9MDkty48geWZ98Wod7ei126CzzI9nVgluQMsJg==
X-Received: by 2002:a17:902:d3c6:b0:1bb:c69b:6f6b with SMTP id w6-20020a170902d3c600b001bbc69b6f6bmr634913plb.6.1690498223158;
        Thu, 27 Jul 2023 15:50:23 -0700 (PDT)
Received: from snowbird ([199.73.127.3])
        by smtp.gmail.com with ESMTPSA id a7-20020a170902ecc700b001bb20380bf2sm2160120plh.13.2023.07.27.15.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 15:50:22 -0700 (PDT)
Date:   Thu, 27 Jul 2023 15:50:19 -0700
From:   Dennis Zhou <dennis@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, tj@kernel.org, cl@linux.com,
        mawupeng1@huawei.com
Subject: Re: [PATCH 0/3] percpu: some trivial cleanup patches
Message-ID: <ZML0qwKTG5zB4VwL@snowbird>
References: <20230721131800.20003-1-bhe@redhat.com>
 <ZLry5gupx9mp1659@snowbird>
 <ZLtNRsDuN4xEMSMB@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLtNRsDuN4xEMSMB@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Jul 22, 2023 at 11:30:14AM +0800, Baoquan He wrote:
> On 07/21/23 at 02:04pm, Dennis Zhou wrote:
> > Hello,
> > 
> > On Fri, Jul 21, 2023 at 09:17:57PM +0800, Baoquan He wrote:
> > > There's a left issue in my mailbox about percpu code at below. When
> > > I rechecked it and considered Dennis's comment, I made an attmept
> > > to fix it with patch 3.
> > > 
> > > https://lore.kernel.org/all/Y407wDMKq5ibE9sc@fedora/T/#u
> > > 
> > > Patch 1 and 2 are trivial clean up patches when reading percpu code.
> > > 
> > > Baoquan He (3):
> > >   mm/percpu.c: remove redundant check
> > >   mm/percpu.c: optimize the code in pcpu_setup_first_chunk() a little
> > >     bit
> > >   mm/percpu.c: print error message too if atomic alloc failed
> > > 
> > >  mm/percpu.c | 39 +++++++++++++++++----------------------
> > >  1 file changed, 17 insertions(+), 22 deletions(-)
> > > 
> > > -- 
> > > 2.34.1
> > > 
> > 
> > Thanks for these. I left a few comments. I think I might have some stuff
> > for v6.6, I'll figure that out in a couple days. If that's so, I can
> > pull 1, probably massage 2 and send that out again, and then I think
> > you'll need to resend 3.
> 
> Sure, thanks for careful reviewing and great suggestion. So I only need
> to send v2 of patch 3, right? Or I should change and send v2 of the
> whold series? I may not get it clear.
> 

Sorry for the delay. I've pulled 1 and 2 (reworded the comment). Can you
please resend patch 3.

Thanks,
Dennis
