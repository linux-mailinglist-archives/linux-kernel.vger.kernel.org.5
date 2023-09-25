Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F037ADF6F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 21:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbjIYTL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 15:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233148AbjIYTLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 15:11:24 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CB895
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 12:11:17 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3216b83c208so875729f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 12:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695669076; x=1696273876; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XhJ34cUYsYlf3XC7vsPt+CX9AqV2ARPhgcXKTo4+p2g=;
        b=RxHVMYMNukqdMDo9r4YL0LZ/zvBdA4haKFlbohjSUaO0Uz3Ny6NEJgbgRKCMAgXxi9
         IWlCOq6U9Li+ZmTGl1RNaLSZQ3Y4Z8JLNfyshr87LXsA5k3F8TOZK39V9vmMpvp7cHPu
         QLP8KxsNh/A2apaSYa/QpNWKAnrCCCVhqafeq1rRS5bkKDBvYPzd++Bl9u4J+6JtH0RN
         /zWD1m26bsi/PtM/d4Vcf93S7U808iLGAEmgb1JwZYiIcoc1qqh9NR8bnw/cyP+9+9BE
         DvBnmLdhOwVDc83Hfsga24fEkLCI7AsMiAw6SeMs53Shi3IDG29xyRgqq6XL+fiSTUZy
         Cn8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695669076; x=1696273876;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XhJ34cUYsYlf3XC7vsPt+CX9AqV2ARPhgcXKTo4+p2g=;
        b=tAmLiBEOEBB/eMlSxWAovu+iIOo8BE1S26cIm0KkZEzfz07tkVqHoOVbYZc9vQhfg1
         HrgnkAB9oo/SaTHv+Z0hQMIjlG4xCldQPA5iboJOiIAOPv10rnVbRsEfHe4u7BQ2ZKoO
         rqrN+znxfStBzEcCElWlYq//ZfyEqQvI92icZsgibAVI1zUhjNn/N+kVOOLk/iLf6kJr
         ZSuNoM+Um1+pWM++9JkY2LYOcn2ZDUJZ7bpPu068k01LoFGDkz2DMjIbWC5t8yxhVSk4
         t8z6b1x3yXjbp9rombVG7smgMVnAYBIP6bmC/IhP5aBTxaHkvQLuan9QP4zspvaKiHoK
         Ieng==
X-Gm-Message-State: AOJu0YxgRxD93KPRRbv6heFvSIaE7j1MoFNSGLvSxzpQZqCRDPMNqb39
        GkBHT11FuOzOPoBhIrwaCa0=
X-Google-Smtp-Source: AGHT+IF0cJgUXjIsYdHE+rY2bl8HxtFhHE4Z0Clq8pxBo0sE2Aj/9MtEkxye0rmKLJhF3oUMmFUc2Q==
X-Received: by 2002:a5d:4210:0:b0:320:8f0:b93d with SMTP id n16-20020a5d4210000000b0032008f0b93dmr6064271wrq.3.1695669075782;
        Mon, 25 Sep 2023 12:11:15 -0700 (PDT)
Received: from [192.168.0.102] (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id r2-20020adfe682000000b0031ff89af0e4sm12562071wrm.99.2023.09.25.12.11.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 12:11:15 -0700 (PDT)
Message-ID: <9d96db4f-0b79-0940-ef95-d9bd70dc9a18@gmail.com>
Date:   Mon, 25 Sep 2023 21:11:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/2] staging: rtl8192e: fix structure alignment
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Tree Davies <tdavies@darkphysics.net>,
        Yogesh Hegde <yogi.kernel@gmail.com>,
        Sumitra Sharma <sumitraartsy@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230925155413.471287-1-arnd@kernel.org>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20230925155413.471287-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/23 17:54, Arnd Bergmann wrote:
> From: Arnd Bergmann<arnd@arndb.de>
> 
> A recent cleanup changed the rtl8192e from using the custom misaligned
> rtllib_hdr_3addr structure to the generic ieee80211_hdr_3addr definition
> that enforces 16-bit structure alignment in memory.
> 
> This causes a gcc warning about conflicting alignment requirements:
> 
> drivers/staging/rtl8192e/rtllib.h:645:1: error: alignment 1 of 'struct rtllib_authentication' is less than 2 [-Werror=packed-not-aligned]
>    645 | } __packed;
>        | ^
> rtllib.h:650:1: error: alignment 1 of 'struct rtllib_disauth' is less than 2 [-Werror=packed-not-aligned]
> rtllib.h:655:1: error: alignment 1 of 'struct rtllib_disassoc' is less than 2 [-Werror=packed-not-aligned]
> rtllib.h:661:1: error: alignment 1 of 'struct rtllib_probe_request' is less than 2 [-Werror=packed-not-aligned]
> rtllib.h:672:1: error: alignment 1 of 'struct rtllib_probe_response' is less than 2 [-Werror=packed-not-aligned]
> rtllib.h:683:1: error: alignment 1 of 'struct rtllib_assoc_request_frame' is less than 2 [-Werror=packed-not-aligned]
> rtllib.h:691:1: error: alignment 1 of 'struct rtllib_assoc_response_frame' is less than 2 [-Werror=packed-not-aligned]
> 
> Change all of the structure definitions that include this one to also
> use 16-bit alignment. This assumes that the objects are actually aligned
> in memory, but that is normally guaranteed by the slab allocator already.
> 
> All members of the structure definitions are already 16-bit aligned,
> so the layouts do not change. As an added benefit, 16-bit accesses are
> generally faster than 8-bit accesses, so architectures without unaligned
> load/store instructions can produce better code now by avoiding byte-wise
> accesses.
> 
> Fixes: 71ddc43ed7c71 ("staging: rtl8192e: Replace struct rtllib_hdr_3addr in structs of rtllib.h")
> Signed-off-by: Arnd Bergmann<arnd@arndb.de>

Hi,

thanks for your support.

your patches cannot be applied on top of the 24 patches which are in the 
queue. But may be Greg will not accept all of the patches send in.

Will see what happens when Greg sorts them out.

I tried your patches on hardware without the 24 patches send in. All OK

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>



I use the following command to compile. Why I am not seeing the issue above?
make "KCFLAGS=-pipe -Wpacked-not-aligned" -C . M=drivers/staging /rtl8192e

Thanks

Bye Philipp


