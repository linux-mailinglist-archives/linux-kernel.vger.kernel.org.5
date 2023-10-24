Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B247D4527
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 03:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbjJXBxt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 23 Oct 2023 21:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbjJXBxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 21:53:47 -0400
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461AD9F
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 18:53:46 -0700 (PDT)
Received: from imladris.home.surriel.com ([10.0.13.28] helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96.1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1qv6c4-0002m7-2J;
        Mon, 23 Oct 2023 21:53:45 -0400
Message-ID: <5dc611e89faf7bc444e50ffb7c02702ec3bb0456.camel@surriel.com>
Subject: Re: [PATCH v3 4/5] mm/khugepaged: Convert alloc_charge_hpage() to
 use folios
From:   Rik van Riel <riel@surriel.com>
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Date:   Mon, 23 Oct 2023 21:53:44 -0400
In-Reply-To: <20231020183331.10770-5-vishal.moola@gmail.com>
References: <20231020183331.10770-1-vishal.moola@gmail.com>
         <20231020183331.10770-5-vishal.moola@gmail.com>
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

On Fri, 2023-10-20 at 11:33 -0700, Vishal Moola (Oracle) wrote:
> Also remove count_memcg_page_event now that its last caller no longer
> uses
> it and reword hpage_collapse_alloc_page() to
> hpage_collapse_alloc_folio().
> 
> This removes 1 call to compound_head() and helps convert khugepaged
> to
> use folios throughout.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> 
Reviewed-by: Rik van Riel <riel@surriel.com>

-- 
All Rights Reversed.
