Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC497563C3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 15:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbjGQNEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 09:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbjGQNEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 09:04:35 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA36A0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 06:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689599070; x=1721135070;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=usKGida2HFYcQL40PyNNyK2Uo5COTZhCxYvKxosq17I=;
  b=Oa75U6UaxcIDl+oCnPLQkgDDhQRsdjIicYCOig7TfhEsRZtyUrcH+3yS
   ySFNqFabHDtc3KmIvBW1sqfslpD61bYkekiRZFaDC4Q1WvFja88fjvi7e
   yIZ9jw6y8pcaCB3t/+thewmaJrqapgpaHiajggoQBFdak+a9M2mQrPb8V
   lgctfXKKDDxdcpCMgkAmAL9/7Ba2oMfrZBpflNELFZXp0FbJn+aEZGMCM
   1LEpSLwo8Iw6UPhmRV2aZesawjWDkQPJxjPfSCKgWu+y6CgL7k8A6zwjN
   Yb3BDQttsdujyfoKUlqlY7h+pzSmWSYZ5cPLPMZ1KYxQuS2j4U3f6R/Dl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="364798042"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="364798042"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 06:04:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="813324196"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="813324196"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Jul 2023 06:04:02 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qLNtQ-00FDdu-2Q;
        Mon, 17 Jul 2023 16:04:00 +0300
Date:   Mon, 17 Jul 2023 16:04:00 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, linux@rasmusvillemoes.dk,
        yury.norov@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org
Subject: Re: [PATCH v3 2/5] lib/test_bitmap: add tests for
 bitmap_{set,get}_value()
Message-ID: <ZLU8QGuFAGxTpbm8@smile.fi.intel.com>
References: <20230717113709.328671-1-glider@google.com>
 <20230717113709.328671-3-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717113709.328671-3-glider@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 01:37:05PM +0200, Alexander Potapenko wrote:
> Add basic tests ensuring that values can be added at arbitrary positions
> of the bitmap, including those spanning into the adjacent unsigned
> longs.

I always in favour of a new test case!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Alexander Potapenko <glider@google.com>
> 
> ---
> This patch was previously called
> "lib/test_bitmap: add tests for bitmap_{set,get}_value_unaligned"

Hint, you may always just link to lore mail archive for easier access and
handling. Also with `b4` at hand the lore link can be used to resurrect
a discussion (in case it's needed).

> v3:
>  - switch to using bitmap_{set,get}_value()
>  - change the expected bit pattern in test_set_get_value(),
>    as the test was incorrectly assuming 0 is the LSB.
> ---
>  lib/test_bitmap.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
> index 187f5b2db4cf1..c2ab54040c249 100644
> --- a/lib/test_bitmap.c
> +++ b/lib/test_bitmap.c
> @@ -71,6 +71,17 @@ __check_eq_uint(const char *srcfile, unsigned int line,
>  	return true;
>  }
>  
> +static bool __init
> +__check_eq_ulong(const char *srcfile, unsigned int line,
> +		 const unsigned long exp_ulong, unsigned long x)
> +{
> +	if (exp_ulong != x) {
> +		pr_err("[%s:%u] expected %lu, got %lu\n",
> +			srcfile, line, exp_ulong, x);
> +		return false;
> +	}
> +	return true;
> +}
>  
>  static bool __init
>  __check_eq_bitmap(const char *srcfile, unsigned int line,
> @@ -186,6 +197,7 @@ __check_eq_str(const char *srcfile, unsigned int line,
>  	})
>  
>  #define expect_eq_uint(...)		__expect_eq(uint, ##__VA_ARGS__)
> +#define expect_eq_ulong(...)		__expect_eq(ulong, ##__VA_ARGS__)
>  #define expect_eq_bitmap(...)		__expect_eq(bitmap, ##__VA_ARGS__)
>  #define expect_eq_pbl(...)		__expect_eq(pbl, ##__VA_ARGS__)
>  #define expect_eq_u32_array(...)	__expect_eq(u32_array, ##__VA_ARGS__)
> @@ -1222,6 +1234,25 @@ static void __init test_bitmap_const_eval(void)
>  	BUILD_BUG_ON(~var != ~BIT(25));
>  }
>  
> +static void __init test_set_get_value(void)
> +{
> +	DECLARE_BITMAP(bitmap, BITS_PER_LONG * 2);
> +	unsigned long val;
> +	int i;
> +
> +	for (i = 0; i < BITS_PER_LONG * 2 - 7; i++) {
> +		bitmap_zero(bitmap, BITS_PER_LONG * 2);
> +		bitmap_set_value(bitmap, 0b10101UL, i, 5);
> +		val = bitmap_get_value(bitmap, i, 5);
> +		expect_eq_ulong(0b10101UL, val);
> +		bitmap_set_value(bitmap, 0b101UL, i + 5, 3);
> +		val = bitmap_get_value(bitmap, i + 5, 3);
> +		expect_eq_ulong(0b101UL, val);
> +		val = bitmap_get_value(bitmap, i, 8);
> +		expect_eq_ulong(0b10110101UL, val);
> +	}
> +}
> +
>  static void __init selftest(void)
>  {
>  	test_zero_clear();
> @@ -1249,6 +1280,8 @@ static void __init selftest(void)
>  	test_for_each_clear_bitrange_from();
>  	test_for_each_set_clump8();
>  	test_for_each_set_bit_wrap();
> +
> +	test_set_get_value();
>  }
>  
>  KSTM_MODULE_LOADERS(test_bitmap);
> -- 
> 2.41.0.255.g8b1d071c50-goog
> 

-- 
With Best Regards,
Andy Shevchenko


