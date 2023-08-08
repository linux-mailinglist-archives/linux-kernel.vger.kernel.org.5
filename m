Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 909AC7735B6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 03:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbjHHBJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 21:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjHHBJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 21:09:00 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10D31729
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 18:08:59 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6873a30d02eso3386873b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 18:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691456939; x=1692061739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dyshSg7AKHTIU6w+4NIbmOwk1tb6Opza1AxWMA8nNCQ=;
        b=kdPPkXr0qCLNXvUR8gIg9cmxg8u8IIxqzN40Qa1uY2o3uCJ+7qanx2VwsR5g2Rv37d
         vNSJjuH8L/wG3EDcxPbNTesv8OvIfdvvaqyvvWpOFTQFb7HjMDTPInNn8jtNgavDO74S
         xDMJ65GmRDC2J5dewsXkDTcXEcgSyf/xiVCbZymeoPcQd7cBjHD7JkO93CNiJji/RH3V
         Z7R1rBFPi7kHJ37RmSQ83pf1VKRMjFhcVs8jLAxLisnLzgAEuOO4TAYPUlYMVe3zuB7f
         SS6fL6/4tv9XwvUio7KCgyjKt2XodqzRZraQ5Iji3NqxnqFuDKwQ3tHQLBPDDb+K6KNZ
         QC6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691456939; x=1692061739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dyshSg7AKHTIU6w+4NIbmOwk1tb6Opza1AxWMA8nNCQ=;
        b=dqX7jBBcmyiDVreIodThzE8/ganDPVuaa0fof1OsL2fll48QhXJknYCq6NtXij0bSp
         NjqWjGfYK5vSOS0b7pDWyTCMbn0lnjV1Zltl2YyrO5QnZdRAs7kj353MpA9TAmwZbRIQ
         1rGi39ns7+p7tssLZPwC7mU1HMaqQzflbjYTPAvkyFPcJQ4G/qvHefT9wJELK2GEvKHH
         GjyB7tLi861FTiZseXb5yJqu2MmXI0VKhDPywta6Y4vSts1ElHFJ35yNnFuZjYGVGdSk
         oXoZGVfWtQ7VjqbkTqI46hvOErr6U9QOKXXF3ROjgx512YQqZa+j8GAxw+/dwCrOcJsb
         Fbpg==
X-Gm-Message-State: AOJu0YyQD+IYKWAAuzQy1JY2fBM6vdWWd8Csj4rVooCEozkGAfFYqaVB
        vNuH755aNTQ8ljK7pZ7DJpI=
X-Google-Smtp-Source: AGHT+IEgOfcMwV/N3q22x92ZRZV4EuAGhQX6BhVUzzSo13FOspDkhubaadvdGgKfIIbJ+3821l3ncA==
X-Received: by 2002:a05:6a20:8f02:b0:13f:8855:d5a0 with SMTP id b2-20020a056a208f0200b0013f8855d5a0mr11163469pzk.50.1691456939060;
        Mon, 07 Aug 2023 18:08:59 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:9d5d])
        by smtp.gmail.com with ESMTPSA id u22-20020aa78396000000b0068746ac9fb0sm6764752pfm.135.2023.08.07.18.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 18:08:58 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 7 Aug 2023 15:08:56 -1000
From:   Tejun Heo <tj@kernel.org>
To:     K Prateek Nayak <kprateek.nayak@amd.com>
Cc:     Sandeep Dhavale <dhavale@google.com>, jiangshanlai@gmail.com,
        torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        joshdon@google.com, brho@google.com, briannorris@chromium.org,
        nhuck@google.com, agk@redhat.com, snitzer@kernel.org,
        void@manifault.com, kernel-team@android.com
Subject: Re: [PATCH 14/24] workqueue: Generalize unbound CPU pods
Message-ID: <ZNGVqL8nXOO1rXlk@slm.duckdns.org>
References: <20230519001709.2563-15-tj@kernel.org>
 <CAB=BE-S=cxewXu7nqJY1DC5w9Bapar_C0cTjpZOQ-Qd5GGwYyw@mail.gmail.com>
 <c307ba94-0d8c-3cbf-19da-44ee31751428@amd.com>
 <ZIEBB-A1arYKSK2P@slm.duckdns.org>
 <fb3461cd-3fc2-189a-a86b-c638816a2440@amd.com>
 <ZIJbMQOu_k07jkFf@slm.duckdns.org>
 <d686347e-f76c-7f9c-3f1a-f4326f5167ca@amd.com>
 <ZKW4374Xc6YrRrEW@slm.duckdns.org>
 <4bb4c12b-4f8d-1069-6fe8-fe256292a763@amd.com>
 <ZMhJNZLWQHInDf4e@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMhJNZLWQHInDf4e@slm.duckdns.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Jul 31, 2023 at 01:52:21PM -1000, Tejun Heo wrote:
> On Tue, Jul 11, 2023 at 08:32:27AM +0530, K Prateek Nayak wrote:
> > > Yeah, that's a bit surprising given that in terms of affinity behavior
> > > "numa" should be identical to base. The only meaningful differences that I
> > > can think of is when the work item is assigned to its worker and maybe how
> > > pwq max_active limit is applied. Hmm... can you monitor the number of
> > > kworker kthreads while running the benchmark? No need to do the whole
> > > matrix, just comparing base against numa should be enough.
> > 
> > Sure. I'll get back to you with the data soon.
> 
> Any updates? I'd like to proceed with the patchset as it helps resolving
> problems others are reporting. I can try to reproduce the results too if you
> can share more details on how they're run.

Prateek sent me how he tested along with workqueue traces. I tried to
reproduce on an AMD zen2 machine and here are the findings:

* The test has a high run-to-run variance. Even with cpufreq boost turned
  off, the numbers reported every second within each run is relatively
  stable but adjacent runs can report signficantly variable numbers. Maybe
  initial thread placement has lingering effects?

  On ryzen 3900x, 15 runs of `./tbench -c ./client.txt -t 60 32 127.0.0.1`:

    Before: AVG=9066.43 STDEV=42.65
    After : AVG=9076.11 STDEV=60.50

  Given the stdev, I don't think this is indicating any meaningful
  difference.

* I looked at what were consuming CPUs during the benchmark runs and also
  Prateek's workqueue traces. None of the operations that tbench is doing
  directly involves workqueue. I couldn't find a mechanism how workqueue
  differences would cause any meaningful performance differences.

At least for tbench results, I couldn't find any signal.

Thanks.

-- 
tejun
