Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24057DB6C2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 10:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbjJ3Jy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 05:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbjJ3Jye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 05:54:34 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5367B10FF;
        Mon, 30 Oct 2023 02:51:45 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1cc37fb1310so7408765ad.1;
        Mon, 30 Oct 2023 02:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698659505; x=1699264305; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xgxgpsaVyH1lVEz0VhsPPbc3s7klX5OAAe3i55j/B/o=;
        b=m2+C9/bagjbDQRr1Kiw7cc1DYYM2Q4lvrbVvlJIU3RNuqG27mAdKhJayy6nShYGwtg
         sGanCSmLYz7PYjRF4iprTLN2OwnZm0Ij/D+K15sZrz1tRpRCzkj9awDstU5u0WS0d40j
         B/SZ9dA2o0ZHc/V5x14yzZzMbEpmUvPef8+Xass7bC2YblH0sEQcJl8HVDYcnYAs+XsG
         emmdzBEv+ynnb6w4OFjIa/SXgos7e14aBccgl+3AL4EYAzarPbNQkSDtjfBFsK1WtaHG
         IH1Y/2YyuLrDUbcFhK6oKtQvACsH6VuzJa9mPSXYpGm2dBxnihDOtQ3FzuCdPjM9wNdh
         16RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698659505; x=1699264305;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xgxgpsaVyH1lVEz0VhsPPbc3s7klX5OAAe3i55j/B/o=;
        b=GDeSoiWdJEWraHmVa5xTlGYmqh1N/77jCGq1xUpqvC5/wda/2TNG/3TVIH9YHTc8f5
         y+FG8RRs8A3382SWD8Q6I3D7by1OuWz0MyOGXucGq1benO+NF6B8OHHOAO9dk4AZHmUa
         teinrvXC+vMIC2AvQKig6NZS8VvLuw4H9apurxVNhHxZ/5me1ehoIBHjlMPG8OYQYDXE
         BekFSSsUSvD5mKjQyxxstk091DxZqDwIP4CRWqmYGOhuD6k0oxnG2hr2H75k+ddcXuz6
         lqbdBKJFl+6bY/E1nRzEhYS4c7fXUs3XkZtYVjMrJkClUxk9/QqQG4kWbgrWchy4XFcr
         jXAQ==
X-Gm-Message-State: AOJu0Yx7P76YaKi3KhkbYlwdmfDu7XD7lmKZqQ/qKiQbD3jZ/2yUZnZ9
        LTdGIrxAWlp75R0swgdVdK8=
X-Google-Smtp-Source: AGHT+IHfLmfWp8BpjK450zlBNqPf10/4CQX8jLTfRQgNlqIqpDLwAjZdlKmbVyrY9kQJL8NmDUmcNw==
X-Received: by 2002:a17:902:d2c7:b0:1cc:3fa8:25fc with SMTP id n7-20020a170902d2c700b001cc3fa825fcmr2780581plc.53.1698659504706;
        Mon, 30 Oct 2023 02:51:44 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id jk5-20020a170903330500b001c9c879ee4asm5930842plb.17.2023.10.30.02.51.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 02:51:44 -0700 (PDT)
Message-ID: <27286396-645d-4f16-8b66-f437e16f5bc4@gmail.com>
Date:   Mon, 30 Oct 2023 18:51:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts/kernel-doc: Fix the regex for matching -Werror
 flag
To:     Yujie Liu <yujie.liu@intel.com>, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org,
        Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>,
        Akira Yokosawa <akiyks@gmail.com>
References: <20231030085404.3343403-1-yujie.liu@intel.com>
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20231030085404.3343403-1-yujie.liu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023/10/30 17:54, Yujie Liu wrote:
> Swarup reported a "make htmldocs" warning:
> 
>   Variable length lookbehind is experimental in regex;
>   marked by <-- HERE in m/(?<=^|\s)-Werror(?=$|\s)
>   <-- HERE / at ./scripts/kernel-doc line 188.
> 
> Akira managed to reproduce it by perl v5.34.0.
> 
> On second thought, it is not necessary to have the complicated
> "lookahead and lookbehind" things, and the regex can be simplified.

Nice!

As a matter of fact, that experimental "Variable length lookbehind"
support was new to perl v5.30.  So your previous change didn't work on
systems such as Debian buster, RHEL 8, and the like.

Thank you for the quick fix.

Let me add a couple of tags.

> 
> Generally, the kernel-doc warnings should be considered as errors only
> when "-Werror" flag is set in KCFLAGS, but not when
> "-Werror=<diagnostic-type>" is set, which means there needs to be a
> space or start of string before "-Werror", and a space or end of string
> after "-Werror".
> 
> The following cases have been tested to work as expected:
> 
> * kernel-doc warnings are considered as errors:
> 
>   $ KCFLAGS="-Werror" make W=1
>   $ KCFLAGS="-Wcomment -Werror" make W=1
>   $ KCFLAGS="-Werror -Wundef" make W=1
>   $ KCFLAGS="-Wcomment -Werror -Wundef" make W=1
> 
> * kernel-doc warnings remain as warnings:
> 
>   $ KCFLAGS="-Werror=return-type" make W=1
>   $ KCFLAGS="-Wcomment -Werror=return-type" make W=1
>   $ KCFLAGS="-Werror=return-type -Wundef" make W=1
>   $ KCFLAGS="-Wcomment -Werror=return-type -Wundef" make W=1
> 
> The "Variable length lookbehind is experimental in regex" warning is
> also resolved by this patch.
> 
> Fixes: 91f950e8b9d8 ("scripts/kernel-doc: match -Werror flag strictly")
> Reported-by: Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
Closes: https://lore.kernel.org/r/20231028182231.123996-1-swarupkotikalapudi@gmail.com/

> Cc: Akira Yokosawa <akiyks@gmail.com>
Reviewed-by: Akira Yokosawa <akiyks@gmail.com>

> Signed-off-by: Yujie Liu <yujie.liu@intel.com>
> ---
>  scripts/kernel-doc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
> index d660e1f4b483..08a3e603db19 100755
> --- a/scripts/kernel-doc
> +++ b/scripts/kernel-doc
> @@ -185,7 +185,7 @@ if (defined($ENV{'KBUILD_VERBOSE'}) && $ENV{'KBUILD_VERBOSE'} =~ '1') {
>  if (defined($ENV{'KCFLAGS'})) {
>  	my $kcflags = "$ENV{'KCFLAGS'}";
>  
> -	if ($kcflags =~ /(?<=^|\s)-Werror(?=$|\s)/) {
> +	if ($kcflags =~ /(\s|^)-Werror(\s|$)/) {

Simpler is better.  I can read this ;-)

        Thanks, Akira

>  		$Werror = 1;
>  	}
>  }
