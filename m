Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97EF77CC51A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 15:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343926AbjJQNsV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 17 Oct 2023 09:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234143AbjJQNsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 09:48:20 -0400
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DA8EA
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 06:48:18 -0700 (PDT)
Received: from imladris.home.surriel.com ([10.0.13.28] helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96.1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1qskPy-0000VA-2n;
        Tue, 17 Oct 2023 09:47:30 -0400
Message-ID: <f7f7b396f60e2a9d22e5d5ab36f78507138d8650.camel@surriel.com>
Subject: Re: [PATCH 4/4] hugetlbfs: replace hugetlb_vma_lock with
 invalidate_lock
From:   Rik van Riel <riel@surriel.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        muchun.song@linux.dev, leit@meta.com, willy@infradead.org,
        Ray Fucillo <Ray.Fucillo@intersystems.com>,
        Jacklin Kotikian <Jacklin.Kotikian@intersystems.com>
Date:   Tue, 17 Oct 2023 09:47:30 -0400
In-Reply-To: <20231017005236.GA236970@monkey>
References: <20231006040020.3677377-1-riel@surriel.com>
         <20231006040020.3677377-5-riel@surriel.com>
         <20231017005236.GA236970@monkey>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Sender: riel@surriel.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-10-16 at 17:52 -0700, Mike Kravetz wrote:
> 
> The Combined faults number drops by over 50%.  This is not nearly as
> dramatic
> as the changes originally seen.  However, I do expect that there will
> be
> a noticeable performance regression.  Ray may be able to help running
> real
> workloads on real applications and database.
> 
> I suggest we hold off on adding this change until further, more real
> world
> analysis can be performed.  The simplification of the code is nice,
> but I
> would hate to regress any workloads.

Agreed. Thank you for running those tests.

Andrew, would it be possible to drop patch 4/4 from -mm?


-- 
All Rights Reversed.
