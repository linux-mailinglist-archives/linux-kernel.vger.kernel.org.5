Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B98B797AE6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243679AbjIGR4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234789AbjIGR4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:56:10 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516421BF1
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 10:55:42 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-502934c88b7so1596494e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 10:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694109338; x=1694714138; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b5XsRTS9R8edlNpMcsHxpycUNz+mKKsm7ARjPuS+W8Q=;
        b=UlRMrhcPFmg2NObENRl5kPvMiTr7M3JoL9kEUOLLchpOa89XiC99BP5zFLfIxoKmrN
         9WbuDtwTCmmFUzuo+25DTVSDKyKqJabpUqipJB5MLyFpDuHi+7TqLDxQYVhYBXPSwJS/
         D9YP0URcGVlvLSMDIasrqX9keXvcBgeO1ewfBYP8pu/ImUmi3C3d1xo7Q6SOkJ8/AYWt
         Gl+GDN0mB1iLrlWKQKN53n44OuSN3A4UBvdWPqxw3Rq8d48QPDCRYt9n2LFJtg4029HH
         w7mqJUbZ2z1WW3WVanZshgY8DuD2ByYy9sDpemcndOHu2w1jqLyroM5EpXkXQCBE6Xof
         fdGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694109338; x=1694714138;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b5XsRTS9R8edlNpMcsHxpycUNz+mKKsm7ARjPuS+W8Q=;
        b=ZUBGW3zZwtd4xiLn3mv+NtZDYDc8GDQLkVq6cdgqPxTLwBtz62QJh5dKaDUH6lli6H
         +Ibqmh5yWTvq7heYqUPjOcEF0W6MmIJIbyXdDG73uaJodscuOfULPtHHY8BhxWJ/9ow5
         2tkqjB0hwEG/+PsIqH04uhOrsFYYODUe9r09U6wU5CmMGYOtxe2EkDVXCFQdoBUYsxre
         MRt6dsWnzoU2Szq+M4VoFwaR+xlWEhbL/3CUnTqrmKNxxD+DyuXaiMx2pQYVK628RkSJ
         wraVhPX7agKuSRl+2hbQ6q8wnJWb9SsHGbFDzRslCJb65Uwm1JW2YnRTusVj0gWTB8G0
         JZiA==
X-Gm-Message-State: AOJu0YzM5JDQxBimHFtfqhDevNokNYoCd4i2hIqEGyfBHqYEmpU1f+M9
        vTWabzsp6R7EIeGYKKpk6nmF4dSk8dg=
X-Google-Smtp-Source: AGHT+IG2bPShHOZyX+Psos3/nJZfvqlpB2353GAVU93aP4a2Yn6FF7iaV8JuHiDzgHAIvg5xVUXCVQ==
X-Received: by 2002:a19:ca14:0:b0:4f7:6685:2c5f with SMTP id a20-20020a19ca14000000b004f766852c5fmr3462484lfg.61.1694078133482;
        Thu, 07 Sep 2023 02:15:33 -0700 (PDT)
Received: from pc636 (host-90-235-20-237.mobileonline.telia.com. [90.235.20.237])
        by smtp.gmail.com with ESMTPSA id w28-20020ac2443c000000b005009d4a5e6fsm3101160lfl.22.2023.09.07.02.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 02:15:33 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 7 Sep 2023 11:15:30 +0200
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v2 0/9] Mitigate a vmap lock contention v2
Message-ID: <ZPmUsqdBj+RfvcU1@pc636>
References: <20230829081142.3619-1-urezki@gmail.com>
 <a21df9dc-ded7-4882-b0e7-688fce4d20b6@lucifer.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a21df9dc-ded7-4882-b0e7-688fce4d20b6@lucifer.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 09:04:26PM +0100, Lorenzo Stoakes wrote:
> On Tue, Aug 29, 2023 at 10:11:33AM +0200, Uladzislau Rezki (Sony) wrote:
> > Hello, folk!
> >
> > This is the v2, the series which tends to minimize the vmap
> > lock contention. It is based on the tag: v6.5-rc6. Here you
> > can find a documentation about it:
> 
> Will take a look when I get a chance at v3 as I gather you're spinning
> another version :)
> 
Correct. I will do that :)

--
Uladzislau Rezki
