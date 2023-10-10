Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5827BF08F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 04:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378945AbjJJCBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 22:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233869AbjJJCBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 22:01:17 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D0A8F
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 19:01:16 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-3512740906dso20719375ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 19:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1696903275; x=1697508075; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n8W5jicDuFfCto5Rz0a13pdOEWWZtFkes7WHBt5JLjo=;
        b=PPck21GWL+u2Kz2+xAqPoG+3Njc9DnYMxHPMLqb/wap5zMDkndfy6+58OybjVB5mf9
         8mg3lhE9YO95n96UZzWFsbwqYH78K/kMiMhSo39XRrDbfq3fd+sGK+8rUhrl31hUl8FS
         f/KhV6r6je0ihv234UHGQs9Vzs8s0/0isOjog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696903275; x=1697508075;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n8W5jicDuFfCto5Rz0a13pdOEWWZtFkes7WHBt5JLjo=;
        b=KwdkNdaBgms8nTaJfV8kBXHcUKfJEo7iWCZlIWEnPLeAFk2ucJjiMgDoU7b+cvddDu
         yN3DVgG9RXr+MahGaypegQTBetAAgd609ORreGLjXDwWMh3NnWim0i6Pjln81Pe7nshG
         GqkDJu5fjIGggSAqSQFwFSMzGQw6ngm9NgLmTvZ+NHb1u02XphdrDxK/xcE6Vev4oe/q
         HQ4043IOuMd0PNa9tmIQ+t9l6gPIQ9R82mNMt6Yffbxm088/7gt1QoClGGYg/oWrk2Gs
         zuTVqUiyI5DZX742oUf2TmInki8uUvztdeGkvaSL1Y7a/5pRsaoU7LKHQU/XfFCfLiRH
         N4JA==
X-Gm-Message-State: AOJu0YyMdS5MbQpR5He5B8BPseHrc6exme1Q3ngaPelqZt6zI9KISaVE
        wH04jTTp0Hj4PxbSBeCfeNAwkg==
X-Google-Smtp-Source: AGHT+IFxEbsxiAkqgad1NR+N5qEc+xJnzBRXuoUOorumGMCjl3dh8xe9qk/x6WqhsQZNVSqcE/TbYw==
X-Received: by 2002:a05:6e02:1d1a:b0:351:b22:af5c with SMTP id i26-20020a056e021d1a00b003510b22af5cmr19923893ila.32.1696903275665;
        Mon, 09 Oct 2023 19:01:15 -0700 (PDT)
Received: from [10.211.55.3] (c-98-61-227-136.hsd1.mn.comcast.net. [98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id l17-20020a922811000000b003513b7613f3sm3247512ilf.3.2023.10.09.19.01.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 19:01:15 -0700 (PDT)
Message-ID: <42a24a62-8dba-452c-b460-61ee06171d74@ieee.org>
Date:   Mon, 9 Oct 2023 21:01:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] staging: greybus: Add __counted_by for struct
 apr_rx_buf and use struct_size()
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <ZSR2O6zGyT/VX6ve@work>
Content-Language: en-US
From:   Alex Elder <elder@ieee.org>
In-Reply-To: <ZSR2O6zGyT/VX6ve@work>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/23 4:52 PM, Gustavo A. R. Silva wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> While there, use struct_size() helper, instead of the open-coded
> version, to calculate the size for the allocation of the whole
> flexible structure, including of course, the flexible-array member.
> 
> This code was found with the help of Coccinelle, and audited and
> fixed manually.

Looks good to me, and I like the use of struct_size().

Reviewed-by: Alex Elder <elder@linaro.org>

> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>   drivers/staging/greybus/raw.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/greybus/raw.c b/drivers/staging/greybus/raw.c
> index a00978c8e1d2..b9c6eff7cdc1 100644
> --- a/drivers/staging/greybus/raw.c
> +++ b/drivers/staging/greybus/raw.c
> @@ -29,7 +29,7 @@ struct gb_raw {
>   struct raw_data {
>   	struct list_head entry;
>   	u32 len;
> -	u8 data[];
> +	u8 data[] __counted_by(len);
>   };
>   
>   static const struct class raw_class = {
> @@ -73,7 +73,7 @@ static int receive_data(struct gb_raw *raw, u32 len, u8 *data)
>   		goto exit;
>   	}
>   
> -	raw_data = kmalloc(sizeof(*raw_data) + len, GFP_KERNEL);
> +	raw_data = kmalloc(struct_size(raw_data, data, len), GFP_KERNEL);
>   	if (!raw_data) {
>   		retval = -ENOMEM;
>   		goto exit;

