Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA967D45AA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 04:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbjJXCn0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 23 Oct 2023 22:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbjJXCnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 22:43:24 -0400
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD2FD7C
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 19:43:13 -0700 (PDT)
Received: from imladris.home.surriel.com ([10.0.13.28] helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96.1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1qv7Nq-0003DF-1T;
        Mon, 23 Oct 2023 22:43:06 -0400
Message-ID: <450e102421c1c113552071964b88f1b2e14256a7.camel@surriel.com>
Subject: Re: [PATCH v3 5/5] mm/khugepaged: Convert collapse_pte_mapped_thp()
 to use folios
From:   Rik van Riel <riel@surriel.com>
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Date:   Mon, 23 Oct 2023 22:43:06 -0400
In-Reply-To: <20231020183331.10770-6-vishal.moola@gmail.com>
References: <20231020183331.10770-1-vishal.moola@gmail.com>
         <20231020183331.10770-6-vishal.moola@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Sender: riel@surriel.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-10-20 at 11:33 -0700, Vishal Moola (Oracle) wrote:
> This removes 2 calls to compound_head() and helps convert khugepaged
> to
> use folios throughout.
> 
> Previously, if the address passed to collapse_pte_mapped_thp()
> corresponded to a tail page, the scan would fail immediately. Using
> filemap_lock_folio() we get the corresponding folio back and try to
> operate on the folio instead.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Reviewed-by: Rik van Riel <riel@surriel.com>

-- 
All Rights Reversed.
