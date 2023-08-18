Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C867781359
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 21:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379610AbjHRTZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 15:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379606AbjHRTYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 15:24:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9FF4212
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 12:24:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06F7262B80
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 19:24:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 271FAC433C7;
        Fri, 18 Aug 2023 19:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1692386682;
        bh=8ToUXkvhL/wbhnnT9iejKXHYhgs5FzE+x2IoT6wrvUA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=e+DlQi+fIQMqgYZNjLIPlJCjl/fM0554s0PCAM/zbRsaSPbfbROPlgQXJtRgNrjpT
         1EkGKgdwksXLUclhy5cEaMnP88nOz+lwnEnCtuu7zGIR4inBV8FaA5WOl46IGS7euY
         gK3gdE0kfaQTvNp1mrLngNxELj3vU94TX2EhwK2s=
Date:   Fri, 18 Aug 2023 12:24:40 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        songmuchun@bytedance.com
Subject: Re: [PATCH v6] mm/filemap: remove hugetlb special casing in
 filemap.c
Message-Id: <20230818122440.e48c3ec75a594e67df13292c@linux-foundation.org>
In-Reply-To: <71864148-6493-30fc-ada4-6bc242b6176f@oracle.com>
References: <20230817181836.103744-1-sidhartha.kumar@oracle.com>
        <20230818110309.e9debd8b988cb8ca4a1019be@linux-foundation.org>
        <ZN+z3Q3hAn/GG+d3@casper.infradead.org>
        <20230818183407.GA5850@monkey>
        <71864148-6493-30fc-ada4-6bc242b6176f@oracle.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Aug 2023 11:54:24 -0700 Sidhartha Kumar <sidhartha.kumar@oracle.com> wrote:

> yes, the motivation for this patch came from the discussion about the 
> various places in mm where hugetlb is special cased and how there should 
> be an effort to unify these cases. As Matthew mentions, this series gets 
> rid of branches that would occur on every page cache lookup. 

Thanks.  Could we please get all this spelled out in the changelog?

Probably in a few days, give people time to review the patch itself.
