Return-Path: <linux-kernel+bounces-4517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 636B2817EC0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 01:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 890001C21689
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 00:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FE963A;
	Tue, 19 Dec 2023 00:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iV0JC9bz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2FC7F
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 00:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-35fb5b53331so4322165ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 16:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702945401; x=1703550201; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8C7HyWggdnjMqK0doF7ZJThvN5452wHJPFUkP81TS8w=;
        b=iV0JC9bz1ctyb80BjvV+ExKbbbIHg3i3Mv9In6uu3Ebml6PV/XOpvlFT77oXgGwaSl
         E3sr9C/qXrVPabsPIT4SfXWY/2q+h7X6Vh5U813WxQdtp6R8/p+R0pRu9OrNyZgERR0s
         sUCv9HJrCfwM7/tUqTX7Tp473/1qg0dvkwCpKauhPcCZhB+PR9SG5TAPgxtichzyt9P3
         cZqaEFA6gNpXELi8OE71C32FLfmc06cQ+UwFrKnclejQkk7YYt1L6GQaeAd51eeQ4Vs8
         dbrwtPOtg1eRi0isj8HNrZGH0CccMW4nHeEGammVfAVFaKAN9gDNencGewoyQ7Lp5oJx
         JmBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702945401; x=1703550201;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8C7HyWggdnjMqK0doF7ZJThvN5452wHJPFUkP81TS8w=;
        b=g7s+Q6JFWwWa1aME7eThZhTx1dz1nykJkB4ZMdBnw+5ateoHj/2QpGTJhNGN5IGFvj
         mu83rKg0B0Ob6Nho5kjNQABiVTqWqzBGlKkr/ty0A0nqu6mShWLP7zGEDcKQWDyAtkgL
         HcX4y6tmYm7Qw5P+U+zCN37yYojTdkc1bKSA0CjF7lFuPyXuuLJowsKGGbZWqKB+Tgeq
         BnMWvnm3M+McttM0JSMPHFKzeqU3MBPrcrAMYksHZftBImmsGq4gAFjhe1uf8vFu1cWe
         uMmBd2zU+9CAsKVgrwjTpTXtt+MhEMz17QoDaUg2zepgHdTzKeqAb5kEaufiy1uMOyDw
         wC2g==
X-Gm-Message-State: AOJu0Yw/YQPLxn+ivEnhAor40VZB2tJXAw0DCeWMDC4PmBvJzqUpnMPc
	zHZ9EK+JKWcnXyoIFHO16Qy64g==
X-Google-Smtp-Source: AGHT+IEuANm3Ac4shQAn0luVFxq8hvjbe83aDjVszcCZu9+3UbZ10wvrv/4pRHQJh1DilvAsjQ5vHg==
X-Received: by 2002:a05:6e02:16ca:b0:35d:59a2:6455 with SMTP id 10-20020a056e0216ca00b0035d59a26455mr21670577ilx.40.1702945401314;
        Mon, 18 Dec 2023 16:23:21 -0800 (PST)
Received: from google.com (20.10.132.34.bc.googleusercontent.com. [34.132.10.20])
        by smtp.gmail.com with ESMTPSA id ba44-20020a0566383aac00b00468e797b71fsm669111jab.84.2023.12.18.16.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 16:23:20 -0800 (PST)
Date: Tue, 19 Dec 2023 00:23:18 +0000
From: Justin Stitt <justinstitt@google.com>
To: Carlos Llamas <cmllamas@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
	kernel-team@android.com, Will Deacon <will@kernel.org>,
	John Stultz <jstultz@google.com>,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH] scripts/decode_stacktrace.sh: optionally use LLVM
 utilities
Message-ID: <20231219002318.p7yciyr4ld62l4ad@google.com>
References: <20230929034836.403735-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929034836.403735-1-cmllamas@google.com>

Hi,

On Fri, Sep 29, 2023 at 03:48:17AM +0000, Carlos Llamas wrote:
> GNU's addr2line can have problems parsing a vmlinux built with LLVM,
> particularly when LTO was used. In order to decode the traces correctly
> this patch adds the ability to switch to LLVM's utilities readelf and
> addr2line. The same approach is followed by Will in [1].
>
> Before:
>   $ scripts/decode_stacktrace.sh vmlinux < kernel.log
>   [17716.240635] Call trace:
>   [17716.240646] skb_cow_data (??:?)
>   [17716.240654] esp6_input (ld-temp.o:?)
>   [17716.240666] xfrm_input (ld-temp.o:?)
>   [17716.240674] xfrm6_rcv (??:?)
>   [...]

Perhaps it is due to where I am dumping the stack, but I am getting good
stack traces on mainline (with a LLVM-built kernel) without this patch.

With that being said, applying this patch still has good stack traces
and it makes sense if it helps others.

>
> After:
>   $ LLVM=1 scripts/decode_stacktrace.sh vmlinux < kernel.log
>   [17716.240635] Call trace:
>   [17716.240646] skb_cow_data (include/linux/skbuff.h:2172 net/core/skbuff.c:4503)
>   [17716.240654] esp6_input (net/ipv6/esp6.c:977)
>   [17716.240666] xfrm_input (net/xfrm/xfrm_input.c:659)
>   [17716.240674] xfrm6_rcv (net/ipv6/xfrm6_input.c:172)
>   [...]
>
> Note that one could set CROSS_COMPILE=llvm- instead to hack around this
> issue. However, doing so can break the decodecode routine as it will
> force the selection of other LLVM utilities down the line e.g. llvm-as.
>
> [1] https://lore.kernel.org/all/20230914131225.13415-3-will@kernel.org/
>
> Cc: Will Deacon <will@kernel.org>
> Cc: John Stultz <jstultz@google.com>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Tested-by: Justin Stitt <justinstitt@google.com>

Note that this patch is similar: https://lore.kernel.org/all/20231215-llvm-decode-stacktrace-v1-1-201cb86f4879@quicinc.com/

> ---
>  scripts/decode_stacktrace.sh | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
> index 564c5632e1a2..bfe5a4082d8e 100755
> --- a/scripts/decode_stacktrace.sh
> +++ b/scripts/decode_stacktrace.sh
> @@ -16,6 +16,21 @@ elif type c++filt >/dev/null 2>&1 ; then
>  	cppfilt_opts=-i
>  fi
>
> +UTIL_SUFFIX=
> +if [[ -z ${LLVM:-} ]]; then
> +	UTIL_PREFIX=${CROSS_COMPILE:-}
> +else
> +	UTIL_PREFIX=llvm-
> +	if [[ ${LLVM} == */ ]]; then
> +		UTIL_PREFIX=${LLVM}${UTIL_PREFIX}
> +	elif [[ ${LLVM} == -* ]]; then
> +		UTIL_SUFFIX=${LLVM}
> +	fi
> +fi
> +
> +READELF=${UTIL_PREFIX}readelf${UTIL_SUFFIX}
> +ADDR2LINE=${UTIL_PREFIX}addr2line${UTIL_SUFFIX}
> +
>  if [[ $1 == "-r" ]] ; then
>  	vmlinux=""
>  	basepath="auto"
> @@ -75,7 +90,7 @@ find_module() {
>
>  	if [[ "$modpath" != "" ]] ; then
>  		for fn in $(find "$modpath" -name "${module//_/[-_]}.ko*") ; do
> -			if readelf -WS "$fn" | grep -qwF .debug_line ; then
> +			if ${READELF} -WS "$fn" | grep -qwF .debug_line ; then
>  				echo $fn
>  				return
>  			fi
> @@ -169,7 +184,7 @@ parse_symbol() {
>  	if [[ $aarray_support == true && "${cache[$module,$address]+isset}" == "isset" ]]; then
>  		local code=${cache[$module,$address]}
>  	else
> -		local code=$(${CROSS_COMPILE}addr2line -i -e "$objfile" "$address" 2>/dev/null)
> +		local code=$(${ADDR2LINE} -i -e "$objfile" "$address" 2>/dev/null)
>  		if [[ $aarray_support == true ]]; then
>  			cache[$module,$address]=$code
>  		fi
> --
> 2.42.0.582.g8ccd20d70d-goog
>

Thanks
Justin

