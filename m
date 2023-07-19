Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B261F7599D2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 17:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbjGSPel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 11:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjGSPej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 11:34:39 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33750BE
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 08:34:39 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-668709767b1so5251905b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 08:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689780878; x=1690385678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MPV1Re/rd+Z6hMWojzSFE+4Xhg9XuKRfthuNZEOiK90=;
        b=TGbv0QD5+whT+mL5B2Nq0B4wjifL4ohScRMftR/EWRiiSJgbBwxiti7XaE9aaTnRQh
         VFvPNZejyBYo/tl0a9HSpS8mriI4Qyv1IJCWhqcUbDqwp3EDTYmk6BS3Xxc1UrZ9tb7n
         tyYAMeU5jH5PtX99eGTpSddN8cOnzFd6K5M1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689780878; x=1690385678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MPV1Re/rd+Z6hMWojzSFE+4Xhg9XuKRfthuNZEOiK90=;
        b=NTKN7Xq43ndEx3JTZnFWJ7xBle8WJVtevlalWVdgy+AVulGnNkKP7teYz+Jl8E96Jh
         jhuc5yFzX+540gS3/zL+LRtF7d4eRCwRlHjI6iUStAGFIgN8dj+KYXgCVmCmINyG6646
         G1PlCxicDWa+p9OMPuDlt32NO97ZYl0hLmOEpZ3kWOqLHVpWanMYqdsJHzJrROWXewuC
         NIgmrB0K/vOvF/CNtOORbo3m0pjMnNq1eRa8YHXDLnrMQ8bzfyZ0JWRgLEpLkzA18SB0
         C9Wkj1dXDuLJ7PxO4A1VoIJqR81QrNpPbGVB9q2mS8wTSYPzmquZGS/f5RX5Yyr4+DNI
         UDVg==
X-Gm-Message-State: ABy/qLYuFGu8Etptfg0YaiktpeaGI8dDnID00ApUAvqK3hivSEVjY4fy
        UYEu5doje5PT9RH61hMj3Sc9Dg==
X-Google-Smtp-Source: APBJJlFicfLDTRxX6ghLisFBMbLwtjTFYkuzm3r762d83vl48bjh0KRW/3bGg7458XSr7TcQHvyzaA==
X-Received: by 2002:a17:90a:fa85:b0:267:a31b:d9dc with SMTP id cu5-20020a17090afa8500b00267a31bd9dcmr3865315pjb.35.1689780878535;
        Wed, 19 Jul 2023 08:34:38 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x1-20020a17090aa38100b00263f5ac814esm1289522pjp.38.2023.07.19.08.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 08:34:38 -0700 (PDT)
Date:   Wed, 19 Jul 2023 08:34:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: Crash in VirtualBox virtual machines running kernel 6.5
Message-ID: <202307190834.A7189ED0@keescook>
References: <ab3a70e9-60ed-0f13-e3d4-8866eaccc8c1@lwfinger.net>
 <202307190823.086EFD42D9@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202307190823.086EFD42D9@keescook>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 08:31:08AM -0700, Kees Cook wrote:
> diff --git a/fs/vboxsf/shfl_hostintf.h b/fs/vboxsf/shfl_hostintf.h
> index aca829062c12..243d1b91bb45 100644
> --- a/fs/vboxsf/shfl_hostintf.h
> +++ b/fs/vboxsf/shfl_hostintf.h
> @@ -68,9 +68,8 @@ struct shfl_string {
>  
>  	/** UTF-8 or UTF-16 string. Nul terminated. */
>  	union {
> -		u8 utf8[2];
> -		u16 utf16[1];
> -		u16 ucs2[1]; /* misnomer, use utf16. */
> +		DECLARE_FLEX_ARRAY(u8, utf8);
> +		DECLARE_FLEX_ARRAY(u16, utf16);
>  	} string;
>  };
>  VMMDEV_ASSERT_SIZE(shfl_string, 6);

Oops, this doesn't even compile. Let me get that fixed...

-- 
Kees Cook
