Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8AFF774AB4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbjHHUdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233410AbjHHUdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:33:25 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E761114657B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:02:25 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bc83a96067so5512445ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 10:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691514145; x=1692118945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vnozp/b9dnXWXae8GvLhMYgmjuVN/9hoLY0HzJZOWms=;
        b=Q3YJz+hOUdw7M4oLMBhLOVOlDxOthiuWjowF0DNj3XFW31kGzeevAzX7ZJSr3kJDBu
         F5hSo+7LAqaWMaf07iapF8x85yGCKclR10gj8GDJfp2cNt0V6IuCitlXocLvuYECQ+ec
         PVfFD5xZ5P4U+H6KZvHOiVEdcUd1rPkn1x5B+VbSsnZbLTwDZoXMQKLOm6QZ9xNFEKrg
         yxCQ1vPX4DGhKZmbkeEIBj85sPKDt3n+/J267rgTHAxYoM7Fkm6Vah98ItB2Gzzvm+SQ
         srD4pbmkJQdGzxJd1/mDPUFXoVMrkyslmr8hZ4qaiUM8eWooO5wKSIBNPMiEapFEF6hf
         K0bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691514145; x=1692118945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vnozp/b9dnXWXae8GvLhMYgmjuVN/9hoLY0HzJZOWms=;
        b=jC/LMJuDREPbIUnFa3ZSGjB8Dkrs9Zry22E9ZPqXBPRbiQ3UbVGnl5j02fepdue8D+
         efGOwZd20VJXFygPEKLSTJzTVxFraIZJOlSev8IEscPXe0JIEOfI4QDvqR7O7gHsAHAj
         0RvGUcKRxxa/mFrm63JCPssLVIEeoDzE3BmknAkD4jARXZf6UGsB0nzyaAFYTu3oYLUE
         cMBsQtVRvUU+X8fCht5f9Zxbua4TIFFTGd4HqBMPM9lXXmw1kEryhwOohtFH5piYBdE6
         6LxkLKDexp19XCVKS4UlCEh6Y6pW9ZGJPFsY22q6Aen9IEaYwScx0b4sK/NAMwAOjnvr
         gfhA==
X-Gm-Message-State: AOJu0Yzm1Vr6HEFBfvk0YOxexxj2Vn8eG/yIag2glLgS1q88dvdzcpfs
        KNMFPny9tFZ2F3i7Al+GbdjWBXWS3wU=
X-Google-Smtp-Source: AGHT+IGC9dvtTvH0viAnExLQ4tFE1Kw1WIZZ+19UH5J+6ELlo5ikIVHoJgGzCtO9RyJBCLLVfg7QRw==
X-Received: by 2002:a05:6808:1284:b0:3a3:1424:7258 with SMTP id a4-20020a056808128400b003a314247258mr17258338oiw.3.1691481544616;
        Tue, 08 Aug 2023 00:59:04 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:9d5d])
        by smtp.gmail.com with ESMTPSA id em5-20020a17090b014500b002680b2d2ab6sm9890488pjb.19.2023.08.08.00.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 00:59:03 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 7 Aug 2023 21:59:01 -1000
From:   Tejun Heo <tj@kernel.org>
To:     K Prateek Nayak <kprateek.nayak@amd.com>
Cc:     jiangshanlai@gmail.com, torvalds@linux-foundation.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, joshdon@google.com, brho@google.com,
        briannorris@chromium.org, nhuck@google.com, agk@redhat.com,
        snitzer@kernel.org, void@manifault.com
Subject: Re: [PATCHSET v1 wq/for-6.5] workqueue: Improve unbound workqueue
 execution locality
Message-ID: <ZNH1xQBWIBNvHGZB@slm.duckdns.org>
References: <20230519001709.2563-1-tj@kernel.org>
 <ZNGYxBCtaMclAl8x@slm.duckdns.org>
 <94da0dc0-a30d-33d5-b3d5-784bbd59c549@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94da0dc0-a30d-33d5-b3d5-784bbd59c549@amd.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Aug 08, 2023 at 08:28:53AM +0530, K Prateek Nayak wrote:
> > Assuming that the tbench difference was a testing artifact, I'm applying the
> > patchset to wq/for-6.6 so that it can receive wider testing. Prateek, I'd
> > really appreciate if you could repeat the test and see whether the
> > difference persists.
> 
> Sure. I'll retest with for-6.6 branch. Will post the results here once the
> tests are done. I'll repeat the same - test with the defaults and the ones
> that show any difference in results, I'll rerun them with various affinity
> scopes.

I think it'd be helpful to pick one benchmark setup which shows clear
difference and repeat it multiple times while taking measures to avoid
systemic biases (e.g. instead of running all of control followed by all of
test, separate them into several segments and interleave them).

Thanks.

-- 
tejun
