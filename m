Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB497A618A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 13:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjISLnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 07:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjISLnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 07:43:06 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4297FE3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 04:43:00 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id 4fb4d7f45d1cf-51d8823eb01so4216271a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 04:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695123778; x=1695728578; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VORsIBA6ERRbmXg4ay2hLf4pQdtqXphfyyZQk55vs4k=;
        b=rfDfqe4PSe/mOmjg4Caf2BppgxFb/tZMc/w1J1lqV/8s3H+cA9asu8YydNCKJ4Zdw6
         gmLKcVqrJ9h96JopiIV15u8I/HmS5KCD0GMIzrZXkDiCInrN7B39IjIKOrTEkmX9D5os
         YwliKF3vbohJrRU4JnytcL6UAuqqXCtbg29Dw2XOXxOmydWDjg8vT8b/grF1/R8cir70
         j0biUsZt4pgQs9Q9lnwsJN5GXFwD9e5YZgg/huMp9fTJ8Nsqm9vfigeEeywDCdtiOfUx
         pf4ZIFaEUYerMtjHh/8mURxFUUiCBlsAmX7ZC7/+Dyhru5mEIiq7V3g4OmcYuezRF4/p
         6LsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695123778; x=1695728578;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VORsIBA6ERRbmXg4ay2hLf4pQdtqXphfyyZQk55vs4k=;
        b=I2SyyA65nWrMKJXhuKJVQyMka8WsbhHfrSeS/QJUQU7dTC3LKTPkDGUJrRdc1cXwHD
         qsTy+kpf5Q+AGUdl4RSPF6iZVoBX9+Q8uGn4jGzkOOgZ1mkE6tO0la6wujerELwDBkXP
         cI1ziQIaO+BUuiGvvuN0IkEVNUeoEBMnTHIdDgycrvt1ORcmocsm7xTA/9bcqEJdAogW
         yCIRtSeHmlrDFtbAktybbs67T1DpaSnXQaMV22I9WRB8fVz/8vaMtP8Lbg39sTWRP9hB
         VRQwWU3XP5bHcyiKtO2qzxtipPCTlxq3vBlxYZtSh61YSqwa3T5GoEyTWtC5QLnGftK5
         GGJg==
X-Gm-Message-State: AOJu0YxIlGDVTlIkOch9W5Oq6aA2W0yRrfmXbPwAJ0A9rixwi0+Okd7V
        juxjBahxMoQ9uuxb4TUPAjc1qUFbSwgg3oc=
X-Google-Smtp-Source: AGHT+IEm+YxUcPeYB6Kt0dFMWqeKuHXC1RLS5dyaoZp1XOTdcVigyiCFLfUEyWumENUYPxJA5D9W21fVdaOc8/c=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a17:907:1595:b0:9a6:6c56:c3df with SMTP
 id cf21-20020a170907159500b009a66c56c3dfmr77664ejc.6.1695123778692; Tue, 19
 Sep 2023 04:42:58 -0700 (PDT)
Date:   Tue, 19 Sep 2023 11:42:56 +0000
In-Reply-To: <20230906204857.85619-1-manmshuk@gmail.com>
Mime-Version: 1.0
References: <20230906204857.85619-1-manmshuk@gmail.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230919114256.333055-1-aliceryhl@google.com>
Subject: Re: [PATCH] rust: error: Markdown style nit
From:   Alice Ryhl <aliceryhl@google.com>
To:     manmshuk@gmail.com
Cc:     linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch fixes a trivial markdown style nit in the `SAFETY` comment.
> 
> Signed-off-by: Manmohan Shukla <manmshuk@gmail.com>
> ---
>  rust/kernel/error.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> index 05fcab6abfe6..6233021daa8a 100644
> --- a/rust/kernel/error.rs
> +++ b/rust/kernel/error.rs
> @@ -133,7 +133,7 @@ pub fn to_errno(self) -> core::ffi::c_int {
>      /// Returns the error encoded as a pointer.
>      #[allow(dead_code)]
>      pub(crate) fn to_ptr<T>(self) -> *mut T {
> -        // SAFETY: self.0 is a valid error due to its invariant.
> +        // SAFETY: `self.0` is a valid error due to its invariant.
>          unsafe { bindings::ERR_PTR(self.0.into()) as *mut _ }
>      }
>  
> -- 
> 2.34.1
 
Reviewed-by: Alice Ryhl <aliceryhl@google.com>

