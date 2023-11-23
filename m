Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61FFE7F5BB6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 10:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343905AbjKWJxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 04:53:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233087AbjKWJxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 04:53:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC63CC1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 01:53:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D63AC433C8;
        Thu, 23 Nov 2023 09:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700733199;
        bh=vpNmPLyRtojWpj1u7BZ0pUMeZOaVneyGtaclUwQtGhM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kI/ltCMXyxvzOM/NbQhlwrVBdCBGUlmL/N+aVb5kqz5WPlU1V1adn8tG/VvssuJyz
         +pWMA4sWZVtJc/Db7AdoLSkpJb7ZXrfsBNoQYLWv3xd/U75grqwwoLRO31cFE5Q6ZR
         TQETi0f9ubSu8PMMwpec0zokFtqW6nzKRvyJQx4HCKknPxD1Ou0gYBwxtEW11KEa4l
         lLqgHW1pMrIZoOW9rgMptbVcoidM57w86a5BWMteqF8NH2Bx6PXaBvU0ql0ijcOG8s
         dAOhicpX5TK29HlC5aTow2U5C2/R1aZk1QBS3kBEZ3uj/0EDfYQArg5Q9ZpLxu1/jK
         +JYYW2fe+3mXQ==
Date:   Thu, 23 Nov 2023 11:53:04 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Mike Kravetz <mike.kravetz@oracle.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Hugh Dickins <hughd@google.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        James Houghton <jthoughton@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH RFC 03/12] mm: Export HPAGE_PXD_* macros even if !THP
Message-ID: <20231123095304.GD636165@kernel.org>
References: <20231116012908.392077-1-peterx@redhat.com>
 <20231116012908.392077-4-peterx@redhat.com>
 <ZV7+Dc1EeVNyV1lL@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZV7+Dc1EeVNyV1lL@infradead.org>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 11:23:57PM -0800, Christoph Hellwig wrote:
> No way to export macros :)
> 
> I'd say define, but other might have better ideas.

Make HPAGE_PXD_* macros visible even if !THP
 
> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 

-- 
Sincerely yours,
Mike.
