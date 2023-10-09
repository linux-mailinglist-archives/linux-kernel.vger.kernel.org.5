Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768347BEB0D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 21:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378506AbjJIT5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 15:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378507AbjJIT5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 15:57:53 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5962EA6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 12:57:51 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bf55a81eeaso32598275ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 12:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696881471; x=1697486271; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AAXof7FSKNUwACX7I0wsnPLfS1CDeCy30JndA2SE6NU=;
        b=czmv9n1GLsaQ19PlZ+qFzaAbhFT+G+txoq/6w5hydn8JinbUxvlIY5uj9WRoKk3Uft
         Jpzm2TQXJiTolWb3h8bJeizL6EEcTwepkWYp3PNMM9xpKesLz/I4K/wob5NJ4bVvu/Y4
         YTMj+4Qo7+jlnBfBNbhCsKCmuZGDzYbzyEn9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696881471; x=1697486271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AAXof7FSKNUwACX7I0wsnPLfS1CDeCy30JndA2SE6NU=;
        b=CNGB+PaBDIDPFECcyNyrpv4+ah8vkaxz09JisBr/nrp0I3OxpjE696+GgoPWJjsH5O
         aLpEIWcgGmw1kzydGhJQSFxhevPWM5W7gtFH6rscgi/usK6OvUDiY/xGWjB+c7TwBlUe
         qiRwU+Yzb40gCY59zVrCoRq8VCAuB33hqDXp7QSyC3ORilyS0YuKdUrVfiqeBXCFlauR
         MvZQBITw0jeS0wIAe7mmbPiPfesi6Lb/adFYZUqy9Ygw8VjwzaEFRuiWwiZfFmK62y7F
         M7qGnJ5Pugnyt44O5dzHrazcMy5BVgfU1AxC/7585DGltZmodqwVu5L57GvNyYf9ol6u
         9rzA==
X-Gm-Message-State: AOJu0YwbVPzpi3naq9SxdDGg6e3ERL5n+apc+7TB8ClYIrqMpDIxO8YT
        5x/UqF59r1lWD3lDW/t3tKv10u9EW9fWAlB3oEk=
X-Google-Smtp-Source: AGHT+IHBxbNlFq//FMZhXa79FOEGkTypYLniPMeh5CBJUalrZdiallsp7s6tfFYhROrYjIiTGBaenQ==
X-Received: by 2002:a17:902:e5cf:b0:1c6:349e:fa43 with SMTP id u15-20020a170902e5cf00b001c6349efa43mr17313830plf.67.1696881470833;
        Mon, 09 Oct 2023 12:57:50 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m10-20020a170902768a00b001c631236505sm10002666pll.228.2023.10.09.12.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 12:57:50 -0700 (PDT)
Date:   Mon, 9 Oct 2023 12:57:49 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] wifi: mac80211: Add __counted_by for struct
 ieee802_11_elems and use struct_size()
Message-ID: <202310091257.6613605D5@keescook>
References: <ZSQ/jcmTAf/PKHg/@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSQ/jcmTAf/PKHg/@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 11:59:41AM -0600, Gustavo A. R. Silva wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> While there, use struct_size() helper, instead of the open-coded
> version, to calculate the size for the allocation of the whole
> flexible structure including, of course, the flexible-array member.
> 
> This code was found with the help of Coccinelle, and audited and
> fixed manually.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Looks correct: "scratch" isn't accessed before setting "scratch_len".

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
