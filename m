Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE3A7FD847
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 14:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbjK2NNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 08:13:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbjK2NNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 08:13:15 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F38B2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 05:13:21 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1cfae5ca719so38989515ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 05:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701263601; x=1701868401; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1YT23JDUOStR2+efKckGHd7K0OmUB2BTaDMNtRq3C4=;
        b=noIFt1XuihCqMvzlia4Du1WijnMNoagvKL+9spJ+7paz8Mp1QhBZozw24iTOnNR2R0
         lYjeis4DDeeHLf5bNe5XNDaOaCBrH6NwuEMFitrd/+M/UZYLFCBK5jbmVkfJUe9hZmk2
         4Nx7f5St4MUxB3gQP5Vp7MXt9c0XYOXyZbm8Xj2vltdQVOol3yGrtpCIk48vnzaz9f44
         /YBMRdqInxxGqdfstAFI96DrWDmEM221NAF8UzfL91Mb/sf2VqVaKUT/u3nBI0wzxZj6
         WEeAX9Pqlzm576Vs3HjF3RrTnGeo+ccz4Xmi6jDQ+fr4HlNxJ695oGWb5SN+TufAq27Q
         shvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701263601; x=1701868401;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y1YT23JDUOStR2+efKckGHd7K0OmUB2BTaDMNtRq3C4=;
        b=n6N1odPTyQhYKpo+tDCCBX73V6SERHBe8BMxVW3JfsVNDZMhPKSHvkj0Qi8orerKL1
         CMUQR7ddCC1VUPp9H5h1VGCBkVw4i7516VklGNLahXoV+HcnwpgU2igGlD/zx7Nw+hDQ
         jdzg4qlgA50M1D8Sm4s1udlhTTxuOptCLtcUWeNxVbOIsK8khzwNC1xlZOctl14V//DX
         KH4WdAHymFPeghhp//BqYn4jiFXzeQUOz5qQHT9vZsDnTE6hBkwmDCiDjxpfp0f9MGfv
         hOgvtZPBJkPsr7VFCjzLyjVmepmz5j5yTikJoAttZyEaG0he87pK/GPcHw7hzwvtRi7V
         Vwfg==
X-Gm-Message-State: AOJu0YxT69b10Ab6QpXaaO5jdksIH+tWFP3wrGpyGi5SYik5HyZRk5ay
        AFkdAiizxFQfBzlOc7kP1oI=
X-Google-Smtp-Source: AGHT+IFXMxElkHGt+LImGYb5PKuu4f0cgQnpCZoBKnnVa9EEfjK0Xu8vKDp4M5bqcmmcons7LMjGXw==
X-Received: by 2002:a17:902:b194:b0:1cf:f359:ce37 with SMTP id s20-20020a170902b19400b001cff359ce37mr5474542plr.2.1701263600844;
        Wed, 29 Nov 2023 05:13:20 -0800 (PST)
Received: from cuiyangpei ([43.224.245.227])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902e9cd00b001cfca7b8ec4sm6314215plk.101.2023.11.29.05.13.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Nov 2023 05:13:20 -0800 (PST)
Date:   Wed, 29 Nov 2023 21:13:15 +0800
From:   cuiyangpei <cuiyangpei@gmail.com>
To:     SeongJae Park <sj@kernel.org>, akpm@linux-foundation.org,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     xiongping1@xiaomi.com
Subject: Re: [PATCH 1/2] mm/damon/sysfs: Implement recording feature
Message-ID: <20231129131315.GB12957@cuiyangpei>
References: <20231128073440.11894-1-cuiyangpei@xiaomi.com>
 <20231128185739.47916-1-sj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128185739.47916-1-sj@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi SeongJae,

We are using damon on the Android operating system. It starts monitoring
when app comes to the foreground, stops monitoring and save the
monitoring results when app goes to the background.

The two methods that you mentioned,

1.tracepoint events
This method requires opening the tracepoint event and using the
'perf-record' tool to generate the perf.data file. Then parsing the
perf.data file. However, the user's phone is not enabled tracepoint
events. Additionally, the generated file is quite complex, and we only
need memory addresses and access frequency informations.

2. damos
There is no direct Python runtime environment on android phones.

Both of these methods provide results that are not very intuitive and
require complex parsing. We save the results in the format of starting
address, region size, and access frequency. When the available memory
reaches a threshold, the user space reclaim memory with low access
frequency by calling 'process_madvise' function.

Thanks.

On Tue, Nov 28, 2023 at 06:57:39PM +0000, SeongJae Park wrote:
> Hi Cuiyanpei,
> 
> 
> Thank you for this nice patchset.
> 
> On Tue, 28 Nov 2023 15:34:39 +0800 cuiyangpei <cuiyangpei@gmail.com> wrote:
> 
> > The user space users can control DAMON and get the monitoring results
> > via implements 'recording' feature in 'damon-sysfs'.  The feature
> > can be used via 'record' and 'state' file in the '<sysfs>/kernel/mm/
> > damon/admin/kdamonds/N/' directory.
> > 
> > The file allows users to record monitored access patterns in a text
> > file. Firstly, users set the size of the buffer and the path of the
> > result file by writing to the ``record`` file. Then the recorded
> > results are first written in an in-memory buffer and flushed the
> > recorded results to a file in batch by writing 'record' to the
> > ``state`` file.
> > 
> > For example, below commands set the buffer to be 4 KiB and the result
> > to be saved in ``/damon.txt``. ::
> > 
> >     # cd <sysfs>/kernel/mm/damon/admin/kdamonds/N
> >     # echo "4096 /damon.txt" > record
> >     # echo "record" > state
> 
> This reminds me the record feature of DAMON debugfs interface[1], which still
> not merged in the mainline.  I deprioritized the patchset to have a better
> answer to Andrew's questions on the discussion (nice definition of the binary
> format and quatization of the benefit), and later I realized I don't have real
> use case that this makes real benefit, so I'm no more aiming to make this
> merged into the mainline.
> 
> More specifically, I'm now thinking the feature is not really needed since
> trace event based recording works, and we found no problem so far.  The DAMON
> user-space tool (damo)[2] also dropped support of the in-kernel record feature,
> but we received no problem report.
> 
> Also, I believe DAMOS tried regions like feature could provide some level of
> information, since it provides snapshot of the monitoring result, which
> contains a time data, namely 'age'.
> 
> Could you please further elaborate your aimed use case of this feature and the
> advantage compared to other alternatives (tracepoint-based recording or DAMOS
> tried regions based snapshot collecting) I mentioned above?
> 
> [1] https://lore.kernel.org/linux-mm/20211011093057.30790-1-sj@kernel.org/
> [2] https://github.com/awslabs/damo
> 
> 
> Thanks,
> SJ
> 
> > 
> > Signed-off-by: cuiyangpei <cuiyangpei@xiaomi.com>
