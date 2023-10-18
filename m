Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88D37CEC25
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 01:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbjJRXfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 19:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjJRXfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 19:35:11 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CC3FA
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 16:35:09 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c0ecb9a075so51624895ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 16:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697672109; x=1698276909; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xxRMOhkHfqF2Yz4cAD/a2m3hMjCZwz0gsRF0WfVLtiE=;
        b=BjWFbYahC8O7XRC6DzvorCb+dM3pvf7X0L08LcR0xDolDfiK+MlYyXrpliWGl4qid2
         nNKBAQyiJJAliwcHEe5cgl4FtTbPJrMvw4rzQoe7/Ohb/vPADzsD5nLIpum6K99Sg9vD
         Ilzd+FOC3Hjt/K6UapFQSsb5QbX15vszM+P3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697672109; x=1698276909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xxRMOhkHfqF2Yz4cAD/a2m3hMjCZwz0gsRF0WfVLtiE=;
        b=u0f8XXAIyT7jXa9VJvKw6/v6znIb3ywSWFqy/fPy2yc3oUHSWjGoXODF1lWmIcMjU3
         fgP8Zktb67fVJd4iYLmJlPMTeFUxZwFVVZ7UewsgRtZnSnObjG9p6TnBqsXRqxyK5lvn
         JHUiRT0311qOcR8SN9HrddBPocacimVijOqD4e30czvpqXSq/0tyop6LmKzWrrOuxyco
         M/biDTWNsZ/5srBWELdj6BfuPM+9e7RP+Z3qSoBRIum8V+zTQYsEJg8rLo4UEzPTiXaS
         vLISYEzI6YNPBBlRVh5R8278Lzd+qx3DnxEKWN8TEyYSnWCF0Mn9O34cSUXuMFN8GfBQ
         pGNg==
X-Gm-Message-State: AOJu0Yz4kSm6iieVDV2ntbyKDBVM2OPnjMcxRcWXD3SH+nlXbAkjbtks
        VkaNUgf9REs6N6dWnj0waCnVZQll1Wtmb12dhZw=
X-Google-Smtp-Source: AGHT+IFLUHDsJM96lu+Gr9hzdtzNvixg1+XlD/7STZUI8C4D6K92Q/4/Tg+mC7mHeCFcak1NFFEC+Q==
X-Received: by 2002:a17:902:ec87:b0:1c5:d063:b70e with SMTP id x7-20020a170902ec8700b001c5d063b70emr1020318plg.53.1697672108702;
        Wed, 18 Oct 2023 16:35:08 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f18-20020a170902ce9200b001bc18e579aesm480575plg.101.2023.10.18.16.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 16:35:08 -0700 (PDT)
Date:   Wed, 18 Oct 2023 16:35:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Justin Stitt <justinstitt@google.com>,
        Kalle Valo <kvalo@kernel.org>, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ath10k: replace deprecated strncpy with strtomem_pad
Message-ID: <202310181626.C5BE0C21F@keescook>
References: <20231013-strncpy-drivers-net-wireless-ath-ath10k-mac-c-v1-1-24e40201afa3@google.com>
 <1cfc7c64-439c-437e-af82-7fce1202242d@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cfc7c64-439c-437e-af82-7fce1202242d@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 05:58:03PM -0700, Jeff Johnson wrote:
> On 10/13/2023 1:33 PM, Justin Stitt wrote:
> > strncpy() is deprecated [1] and we should prefer less ambiguous
> > interfaces.
> > 
> > In this case, arvif->u.ap.ssid has its length maintained by
> > arvif->u.ap.ssid_len which indicates it may not need to be
> > NUL-terminated, although by virtue of using strtomem_pad (with NUL-byte
> > pad character) and having a destination size larger than the source,
> > ssid will, incidentally, be NUL-terminated here.
> > 
> > As strtomem_pad() docs say:
> >   * @dest: Pointer of destination character array (marked as __nonstring)
> >   * @src: Pointer to NUL-terminated string
> >   * @pad: Padding character to fill any remaining bytes of @dest after copy
> >   *
> >   * This is a replacement for strncpy() uses where the destination is not
> >   * a NUL-terminated string, but with bounds checking on the source size, and
> >   * an explicit padding character. If padding is not required, use strtomem().
> > 
> > Let's also mark ath10k_vif.u.ap.ssid as __nonstring.
> 
> what criteria is used to determine whether or not to use __nonstring?
> doesn't the use of u8 vs char already communicate that distinction?
> just want to know what other u8 arrays might require this.
> FWIW the documentation referenced by the __nonstring macro explicitly refers
> to "type array of char, signed char, or unsigned char"

The use of __nonstring is for byte arrays that are _not_ expected to be
%NUL terminated. Unfortunately "char" vs "u8" isn't distinguished by the
compiler. All byte arrays are treated as C strings unless __nonstring is
used.

> > It is unclear to me whether padding is strictly necessary. Perhaps we
> > should opt for just strtomem() -- padding certainly doesn't hurt,
> > though.
> 
> concur that padding probably isn't necessary but doesn't hurt, and will
> prevent confusion if looking at this member in a crashdump
> 
> > 
> > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> > Link: https://github.com/KSPP/linux/issues/90
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> 
> Either with or without the __nonstring...
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Yup, it looks like the ssid member is passed around with memcpy()
everywhere else.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
