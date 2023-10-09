Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5287BE70D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 18:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377329AbjJIQ4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 12:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377245AbjJIQ4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 12:56:16 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12F39E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 09:56:14 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-692779f583fso3181332b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 09:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696870574; x=1697475374; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BI1wdHvupQf0LaYbc5/G8p3qu/45NR/6x8pz02yh3PE=;
        b=Q4wh+a/oJyOU0GBAbt9uc99A9WiOgV+YcRmeLb4UUfMf4VlgokwcP92m70XoytoW2e
         r2MufKKMFTXq3o64nhVKe72u7EPn7Lr6bIVjrgMzp7pzau4PHAgLKfFXp6jUTMDWA3Vh
         sYQOz50kVGk65u59a0k3ZgJrugAZK/to1QcA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696870574; x=1697475374;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BI1wdHvupQf0LaYbc5/G8p3qu/45NR/6x8pz02yh3PE=;
        b=Z9w9Zyu3Uc5e9Nm6Bg8n5VceTwrj2rYtO/Jq5GHDpGDR0rApGb1Qjlcp2yTKBOp9cC
         Wm6aviD6LEmRGVHDHDdxObu5OlAgrv7hppb7IH1zdJxt4KneN/XGO5PuQIZ+qcnolv/X
         JsJPcqZjuqaf2qSpPjZGwhGQBYa1MSCxPd6u5TaeY68vrcoA9KcEc3cADtO1e8eGLjpn
         v8GzyYGw/tOLQ0nftv4o/s3i7NrgyyZSbxJgQTkBe5VCuOLwtUNQpusVrIzfZYKgIoWK
         WunGJZZuk3Ep3Cchlhv01aR/mW+QUVCarMQpY2pQbDuySReYhkisUW470supwzQLwzzq
         Bijg==
X-Gm-Message-State: AOJu0YwMWSwTIYG0gTVZ4v4pXb771gXXc54Cx3lgpLj4C3lFWE5FrKgb
        SvYfu1LBuntHFwNubo9HRbfXIA==
X-Google-Smtp-Source: AGHT+IExmUks9+I/YiKBGr4BtICx6xzlqORwNadZpHtAORGWPchSbI37a3pFI+AKwfNa/ZHilpgCWw==
X-Received: by 2002:a05:6a00:124a:b0:690:ce30:47e5 with SMTP id u10-20020a056a00124a00b00690ce3047e5mr14761348pfi.6.1696870574128;
        Mon, 09 Oct 2023 09:56:14 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l3-20020a62be03000000b00688c733fe92sm6540299pff.215.2023.10.09.09.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 09:56:13 -0700 (PDT)
Date:   Mon, 9 Oct 2023 09:56:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "gustavoars@kernel.org" <gustavoars@kernel.org>
Subject: Re: [PATCH] wifi: rtw89: coex: Annotate struct
 rtw89_btc_btf_set_slot_table with __counted_by
Message-ID: <202310090953.B7CE5CF4B@keescook>
References: <20231006201715.work.239-kees@kernel.org>
 <4716f3c7bf3d34ea25229edd5250f5f0cff639d8.camel@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4716f3c7bf3d34ea25229edd5250f5f0cff639d8.camel@realtek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 07, 2023 at 01:20:43AM +0000, Ping-Ke Shih wrote:
> On Fri, 2023-10-06 at 13:17 -0700, Kees Cook wrote:
> > 
> > Prepare for the coming implementation by GCC and Clang of the __counted_by
> > attribute. Flexible array members annotated with __counted_by can have
> > their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> > array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> > functions).
> > 
> > As found with Coccinelle[1], add __counted_by for struct
> > rtw89_btc_btf_set_slot_table.
> > 
> > Cc: Ping-Ke Shih <pkshih@realtek.com>
> > Cc: Kalle Valo <kvalo@kernel.org>
> > Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> > Cc: linux-wireless@vger.kernel.org
> > Cc: linux-hardening@vger.kernel.org
> > Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  drivers/net/wireless/realtek/rtw89/coex.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
> > index 4ba8b3df70ae..d66a1152c3f5 100644
> > --- a/drivers/net/wireless/realtek/rtw89/coex.c
> > +++ b/drivers/net/wireless/realtek/rtw89/coex.c
> > @@ -237,7 +237,7 @@ struct rtw89_btc_btf_set_report {
> >  struct rtw89_btc_btf_set_slot_table {
> >         u8 fver;
> >         u8 tbl_num;
> > -       u8 buf[];
> > +       u8 buf[] __counted_by(tbl_num);
> 
> This struct isn't defined properly. It should be 
> 
> struct rtw89_btc_btf_set_slot_table {
> 	u8 fver;
> 	u8 tbl_num;
> 	struct rtw89_btc_fbtc_slot tbl[] __counted_by(tbl_num);
> } __packed;
> 
> And, we should modify rtw89_btc_fw_set_slots() as well. 
> 
> Another struct 'rtw89_btc_btf_set_mon_reg' has similar problem.
> 
> So, NACK this patch. I will prepare one or two patches for them next week. 

Ah-ha; thank you!

> By the way, I have question about __counted_by(). Can I apply it to little/big-
> endian 'num'? Like
> 
> struct foo {
> 	...
> 	__le32 num;
> 	__le32 data[] __counted_by(num);
> }

Unfortunately not yet. I hope to see it extended in the future to allow
for arbitrary expressions. For this first step, it only handles native
sizes.

-- 
Kees Cook
