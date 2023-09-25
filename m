Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F147AE1A1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 00:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbjIYWYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 18:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjIYWYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 18:24:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E9A107
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 15:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uLxZyjN66pBQO8gMl/pck2R9H8xsWlFrcpfHggZ9L8Y=; b=Ca/9DU+dZPf19xtSjHvzI+i/TS
        ft4LamniaEbFSluWMLkkyI9pjli7J1bXXQlYALvQVw+gVBF0st+c3TSzX/3BW0JS2n3cYSqvjDpxg
        8AVLU3SACP3gyO4z1+EWhbX/jDKLiM+jDn1zlf7Gj+G0PCYBr8Mt60wI9zMPkBq0TZiXa4me+SJs+
        39RzAJv7sbyuaXiAHEh+JRJaOSJxMraU37oqvGHGl7tqWvutNRav0W8HL/Onog7gEtRWUVgQHrcot
        2jBxAXDNRX0+2LxRLHEF+9hSGjd5AHtnQlGy8D1HV4S2qz+bTowZZmkvd5fF/VPLmhubAcujCZ3lo
        ErfDYE2A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qktzf-0040hE-M4; Mon, 25 Sep 2023 22:23:56 +0000
Date:   Mon, 25 Sep 2023 23:23:55 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Christoph Lameter <cl@linux.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 04/12] mempolicy trivia: delete those ancient pr_debug()s
Message-ID: <ZRIIe5yHIHUXL7Oo@casper.infradead.org>
References: <2d872cef-7787-a7ca-10e-9d45a64c80b4@google.com>
 <d16bae78-6731-7c73-ecb4-5099e03f658d@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d16bae78-6731-7c73-ecb4-5099e03f658d@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 01:25:09AM -0700, Hugh Dickins wrote:
> Delete those ancient pr_debug()s - PDprintk()s in Andi Kleen's original
> submission of core NUMA API, and useful when debugging shared mempolicy
> lifetime back then, but not used recently.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
