Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F33C7FC972
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 23:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376617AbjK1WZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 17:25:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjK1WZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 17:25:33 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0DD137
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 14:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=78f0S0vHlPU3iJRigINlfVS8PMeXCNcj0mcswDGf2Xs=; b=xF3dt4e45RCWxOfF2kcZtb6mPI
        Ha/jm95l4Euq0cT6NEvKY3TLCOXe9YxrhOkCXC0MurbssB9weV7PPB0296bTShHB1dN1cRhMU+Xcj
        0qjnLFQw+v8Zoo1/nuvSo1gZ8yC5OX3spA4uT17z8AFCdEOnXJL4R6E24HA6LyS6QL8pl8xbMXnF3
        G6+0yH72MOW5c27hwckd6iRorDtv0WO7f8cw2zXHbVdzhaSy+98WjchnIr2NPpj5Gx5gW9FZciuTj
        Rcf11l1Oi2zzwlgDbricLW4fETTEAiwFxu0xuGqrOiAqXP+oor4jBEOAhS21WYyfoz0Y1FfdKklaH
        bObnaOJg==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r86WL-006TtC-0L;
        Tue, 28 Nov 2023 22:25:33 +0000
Message-ID: <70bfe20f-952a-4c5b-ae79-4317badfeda2@infradead.org>
Date:   Tue, 28 Nov 2023 14:25:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] units: Add missing header
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Damian Muszynski <damian.muszynski@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20231128174404.393393-1-andriy.shevchenko@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231128174404.393393-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/28/23 09:44, Andy Shevchenko wrote:
> BITS_PER_BYTE is defined in bits.h.
> 
> Fixes: e8eed5f7366f ("units: Add BYTES_PER_*BIT")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  include/linux/units.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/units.h b/include/linux/units.h
> index ff1bd6b5f5b3..45110daaf8d3 100644
> --- a/include/linux/units.h
> +++ b/include/linux/units.h
> @@ -2,6 +2,7 @@
>  #ifndef _LINUX_UNITS_H
>  #define _LINUX_UNITS_H
>  
> +#include <linux/bits.h>
>  #include <linux/math.h>
>  
>  /* Metric prefixes in accordance with Système international (d'unités) */

-- 
~Randy
