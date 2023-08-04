Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763BC76F85D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 05:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjHDD0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 23:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232709AbjHDDZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 23:25:59 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDBA46A3
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 20:25:29 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-68706d67ed9so1225929b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 20:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691119529; x=1691724329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jyfiza8/jaSwlv2PJ16w6xf8krDmPMZlwhEQxHgzJgs=;
        b=eCKANP1mUefA0PHSLAGYq8/9ynLDso/9XcT2RGU64hgL2PEltYzsqliCtIMnB5q3vJ
         2j/DH4mH7/GpjQ0lgGnTl/F9agFM5OMB90xMqyV50I4IDXeg7js8JU3w5SNftaUzWtdy
         OfPHMRXvKR5aE8Eeh5nf8xcry3ghoY8kHaTmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691119529; x=1691724329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jyfiza8/jaSwlv2PJ16w6xf8krDmPMZlwhEQxHgzJgs=;
        b=RZ25FH/2L9LrYfIqP7JFwWfX+QSKmRtygAXf5SXnBuiM5K5Zn1EwlXCLdjZGSdwHV5
         BDR0+WPwzvr2aU676q/E7E9oIBgehaLm083gJb1sSiRvBbjjA5WpJAYYdUbafZzb26um
         XPdYszLbjf3exwsFYefr4QGwABOUpWy6T4bMFt/WoKsFr+7BOxOLJJjvxMqssXxdjZZp
         r1U30oVrweg2CTFw74ZVarM5+fAianjJvyI2B5WlbMI2u/1HNO6xRfnMz/LkWMtx5PBI
         yxYRFQHxui6Y+Lv64hMMtOXKrz9eUB4SlZC+MXS1t2TacolzF2wIMknmKVLLKnDjh5C3
         kBvw==
X-Gm-Message-State: AOJu0YzYq0PCLUNWYy6LH9l8Ct02H/Jx6yh4FVvDL3U9hV7fWd2oJQvI
        exJlyRAT7MCHXhKpsM7ilkL7kAot6OPEHJZl2kM=
X-Google-Smtp-Source: AGHT+IHfJ4qYOu6gLnzDKeOhiUQ76EZMvMDkxzOOb7S5CpaiEiwDFR+NXklJfm8ejXLEkmpbZOZz8g==
X-Received: by 2002:a05:6a21:2704:b0:134:d4d3:f0a8 with SMTP id rm4-20020a056a21270400b00134d4d3f0a8mr366430pzb.3.1691119528822;
        Thu, 03 Aug 2023 20:25:28 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id b1-20020a170903228100b001b7fd27144dsm584487plh.40.2023.08.03.20.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 20:25:28 -0700 (PDT)
Date:   Fri, 4 Aug 2023 12:25:23 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Dusty Mabe <dusty@dustymabe.com>
Cc:     Hannes Reinecke <hare@suse.de>, wq@lst.de,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>, marmijo@redhat.com
Subject: Re: XFS metadata CRC errors on zram block device on ppc64le
 architecture
Message-ID: <20230804032523.GA81493@google.com>
References: <b2d40565-7868-ba15-4bb1-fca6f0df076b@dustymabe.com>
 <20230802094106.GA28187@lst.de>
 <3f36882c-b429-3ece-989b-a6899c001cbd@suse.de>
 <43843fec-f30a-1edc-b428-1d38ddb1050f@dustymabe.com>
 <a0f05188-d142-82f2-74aa-6c9a6ae2bbc9@dustymabe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0f05188-d142-82f2-74aa-6c9a6ae2bbc9@dustymabe.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/08/03 17:32), Dusty Mabe wrote:
> >>>>      zram: simplify bvec iteration in __zram_make_request
> >>>>      
> >>>>      bio_for_each_segment synthetize bvecs that never cross page boundaries, so
> >>>>      don't duplicate that work in an inner loop.
> >>>
> >>>> Any ideas on how to fix the problem?
> >>>
> >>> So the interesting cases are:
> >>>
> >>>    - ppc64 usually uses 64k page sizes
> >>>    - ppc64 is somewhat cache incoherent (compared to say x86)
> >>>
> >>> Let me think of this a bit more.
> >>
> >> Would need to be confirmed first that 64k pages really are in use
> >> (eg we compile ppc64le with 4k page sizes ...).
> >> Dusty?
> >> For which page size did you compile your kernel?
> > 
> > 
> > For Fedora the configuration is to enable 64k pages with CONFIG_PPC_64K_PAGES=y
> > https://src.fedoraproject.org/rpms/kernel/blob/064c1675a16b4d379b42ab6c3397632ca54ad897/f/kernel-ppc64le-fedora.config#_4791
> > 
> > I used the same configuration when running the git bisect.
> 
> Naive question from my side: would this be a candidate for reverting while we investigate the root cause?

That's certainly a possible solution.

But I don't quite understand why af8b04c63708 doesn't work.
