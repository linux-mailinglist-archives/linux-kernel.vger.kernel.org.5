Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1E480FA7C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 23:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377901AbjLLWke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 17:40:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377830AbjLLWkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 17:40:31 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFAB8AD;
        Tue, 12 Dec 2023 14:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702420838; x=1733956838;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d26NH9arjdhzXdHnhZX1oap+1X0EpGr92P6WHZRm74c=;
  b=GU1u2vFgM8uCurIdWGKQX7jV8iJPQ3+KIQoQo1MnIKCZrQ8m7BMbjMfh
   /rrA1YZVbP4E2Vx9q0XNHjwvuPrtoKXRpi861oWGDabJuiTkKT5lb8Lrs
   Q6/JrJem/pzT/wWgEoiiga4NKn/sd5kBrJP7Gylbl0W+ImDnWvUZVl/bd
   lw3Gg22BsWNoUmrJdyLSag3ljS/qkxA3HmnuVDXa1MUIY5bP+P7fYEsv/
   po9SthCoiVj3d9qP/AA2c167UUWznBARBBtf8dP8eaubGPhOv2NZdPUVK
   Zos6t185NRCF9nSOM5XMcMUkjKDl4MJpubf9WD69zbLjJ7OVi1iL9K3td
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="2051275"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="2051275"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 14:40:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="897094424"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="897094424"
Received: from adamjame-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.48.205])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 14:40:35 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 89D0210A4DA; Wed, 13 Dec 2023 01:40:32 +0300 (+03)
Date:   Wed, 13 Dec 2023 01:40:32 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] Documentation, mm/unaccepted: document accept_memory
 kernel parameter
Message-ID: <20231212224032.4dt6nttlqyru4w7d@box>
References: <20231212-accept_memory_param-v1-1-a9012402b887@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212-accept_memory_param-v1-1-a9012402b887@suse.cz>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 06:21:43PM +0100, Vlastimil Babka wrote:
> The accept_memory kernel parameter was added in commit dcdfdd40fa82
> ("mm: Add support for unaccepted memory") but not listed in the
> kernel-parameters doc. Add it there.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
