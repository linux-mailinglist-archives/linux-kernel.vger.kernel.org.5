Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524C2786FF6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 15:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239244AbjHXNLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 09:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240665AbjHXNKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 09:10:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7430219A6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 06:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692882637; x=1724418637;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=LiLsqdoVUja+JERtFU88i6X3byI0dtoPdIn/Ssazjjw=;
  b=cLCCjyaNb4u9FRg8sspfFUPKiABMSJmRk6IK45OxOqDB/2GY9D1wSqPW
   KLTTDoYPmvzXDx53iG/zuv6OafxCyj6Ysl9/pewvpDRE1HNm0OMtZGPLq
   kBAbhQY8uni8AwR1+sk/iUA9rhwLGipK6/pHD6tC1ATxjzQJ6hQ9dcg69
   V6gZPmXuP+qDPzXOlbtKZMJ9thtNHsuz3ShSQcSzUMjaUzSsCu7r7ted+
   oE9OCs4X676Sm9oNsT1BIKj12q2xTIFlSfRwlFa+PRFK6aC77v6GHH2W1
   0NcjONXBjrI9qtT7Js4Wi8TggWguZQu4HK4X25ZhbUIt1fO7WjK0WJl/6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="405438983"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="405438983"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 06:10:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="730594067"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="730594067"
Received: from abedekar-mobl1.ger.corp.intel.com ([10.251.213.29])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 06:10:15 -0700
Date:   Thu, 24 Aug 2023 16:10:12 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        fenghua.yu@intel.com
Subject: Re: [PATCH 3/3] selftests: Add printf attribute to ksefltest
 prints
In-Reply-To: <9adfc58deb5c7df43f6a8701d4e15821f4c42dc7.1692880423.git.maciej.wieczor-retman@intel.com>
Message-ID: <a93a4f17-73c7-cf6a-e44f-78ece1e25e93@linux.intel.com>
References: <cover.1692880423.git.maciej.wieczor-retman@intel.com> <9adfc58deb5c7df43f6a8701d4e15821f4c42dc7.1692880423.git.maciej.wieczor-retman@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-906351982-1692882616=:1766"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-906351982-1692882616=:1766
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Thu, 24 Aug 2023, Wieczor-Retman, Maciej wrote:

> Kselftest header defines multiple variadic function that use printf
> along with other logic
> 
> There is no format checking for the variadic functions that use
> printing inside kselftest.h. Because of this the compiler won't
> be able to catch instances of mismatched print formats and debugging
> tests might be more difficult
> 
> Add the common __printf attribute macro to kselftest.h
> 
> Add __printf attribute to every function using formatted printing with
> variadic arguments

Please add . to terminate the sentences.

The patch looks fine:
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

...However, there are formatting errors it found yet to fix.

-- 
 i.

> Signed-off-by: Wieczor-Retman, Maciej <maciej.wieczor-retman@intel.com>
> ---
>  tools/testing/selftests/kselftest.h | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
> index 829be379545a..ff47ed711879 100644
> --- a/tools/testing/selftests/kselftest.h
> +++ b/tools/testing/selftests/kselftest.h
> @@ -77,6 +77,8 @@
>  #define KSFT_XPASS 3
>  #define KSFT_SKIP  4
>  
> +#define __printf(a, b)   __attribute__((format(printf, a, b)))
> +
>  /* counters */
>  struct ksft_count {
>  	unsigned int ksft_pass;
> @@ -134,7 +136,7 @@ static inline void ksft_print_cnts(void)
>  		ksft_cnt.ksft_xskip, ksft_cnt.ksft_error);
>  }
>  
> -static inline void ksft_print_msg(const char *msg, ...)
> +static inline __printf(1, 2) void ksft_print_msg(const char *msg, ...)
>  {
>  	int saved_errno = errno;
>  	va_list args;
> @@ -146,7 +148,7 @@ static inline void ksft_print_msg(const char *msg, ...)
>  	va_end(args);
>  }
>  
> -static inline void ksft_test_result_pass(const char *msg, ...)
> +static inline __printf(1, 2) void ksft_test_result_pass(const char *msg, ...)
>  {
>  	int saved_errno = errno;
>  	va_list args;
> @@ -160,7 +162,7 @@ static inline void ksft_test_result_pass(const char *msg, ...)
>  	va_end(args);
>  }
>  
> -static inline void ksft_test_result_fail(const char *msg, ...)
> +static inline __printf(1, 2) void ksft_test_result_fail(const char *msg, ...)
>  {
>  	int saved_errno = errno;
>  	va_list args;
> @@ -186,7 +188,7 @@ static inline void ksft_test_result_fail(const char *msg, ...)
>  		ksft_test_result_fail(fmt, ##__VA_ARGS__);\
>  	} while (0)
>  
> -static inline void ksft_test_result_xfail(const char *msg, ...)
> +static inline __printf(1, 2) void ksft_test_result_xfail(const char *msg, ...)
>  {
>  	int saved_errno = errno;
>  	va_list args;
> @@ -200,7 +202,7 @@ static inline void ksft_test_result_xfail(const char *msg, ...)
>  	va_end(args);
>  }
>  
> -static inline void ksft_test_result_skip(const char *msg, ...)
> +static inline __printf(1, 2) void ksft_test_result_skip(const char *msg, ...)
>  {
>  	int saved_errno = errno;
>  	va_list args;
> @@ -215,7 +217,7 @@ static inline void ksft_test_result_skip(const char *msg, ...)
>  }
>  
>  /* TODO: how does "error" differ from "fail" or "skip"? */
> -static inline void ksft_test_result_error(const char *msg, ...)
> +static inline __printf(1, 2) void ksft_test_result_error(const char *msg, ...)
>  {
>  	int saved_errno = errno;
>  	va_list args;
> @@ -262,7 +264,7 @@ static inline int ksft_exit_fail(void)
>  		  ksft_cnt.ksft_xfail +	\
>  		  ksft_cnt.ksft_xskip)
>  
> -static inline int ksft_exit_fail_msg(const char *msg, ...)
> +static inline __printf(1, 2) int ksft_exit_fail_msg(const char *msg, ...)
>  {
>  	int saved_errno = errno;
>  	va_list args;
> @@ -289,7 +291,7 @@ static inline int ksft_exit_xpass(void)
>  	exit(KSFT_XPASS);
>  }
>  
> -static inline int ksft_exit_skip(const char *msg, ...)
> +static inline __printf(1, 2) int ksft_exit_skip(const char *msg, ...)
>  {
>  	int saved_errno = errno;
>  	va_list args;
> 

--8323329-906351982-1692882616=:1766--
