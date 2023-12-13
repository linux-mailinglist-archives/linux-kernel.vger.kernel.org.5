Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9E5811E54
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442208AbjLMTLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:11:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235571AbjLMTLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:11:40 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41EB1A7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:11:38 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6cef5220d07so2784381b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702494698; x=1703099498; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gpG+EEGCB6qn4cMUhkO53jShDEsB2LuwXJ0kT5xqd8k=;
        b=ipv1pPbe+UpX5iGCBRETIUcZl6Cdk/6odX+DLXqrbaqn66KAZ8vP2k77YeakrpKL7t
         gO/Ie7JrkC3ROdi3Eo/5A5zNQOfpgIBpUWAsDxBOPon5XrXoPeWbFoh2767D933TRvYs
         e/toES0K+gXxyKKvNDhL7MVrivjyGxv3ARELs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702494698; x=1703099498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gpG+EEGCB6qn4cMUhkO53jShDEsB2LuwXJ0kT5xqd8k=;
        b=FZeWjm/dJnEHVFcd/Hv393bZmDEGK4x8EFlC51sxOnsU2Z2jQv3qOmH5eEuPBuYKKK
         CLfWvJJKAhUN7QiCOlIZBp1+b1VowjAA973Ao1SKN3X/Jx6uOapnXtFhCvdBiqkv1bEq
         eM5akbSAbDKNLhVHRv/hmv2uRrml4IokqiF+YKLgjKh+qXB+7IWgJ+993YJ/dSX9jFnl
         Wegjoq4bXyU09iO+on1qZR3NpH3fnrzdTW2AIXAeVYCTt3Za+ne+iLdD1ee1gJGZ0d7v
         bTZ6CQXEF51KIhWahj9J9KfxVxmdPZi51K2ppy5nzBLx9D4JwSPNvAorzOZYrMjvugSp
         fY+g==
X-Gm-Message-State: AOJu0YyvysvvBY0L27Oant24bhLMUinCGE0b0X0+yJYjX64YFMBdDtQ4
        JG5kHB4FxcPMIZ5NrVqLEJ68VcCKegGvA0M6/gc=
X-Google-Smtp-Source: AGHT+IE65DZud1cxhlQnjhKFYRVoxzWYts7ImiaFpC108iXuhbQIThqPXHzKV6YtNeM3dkGKKHJTsQ==
X-Received: by 2002:a05:6a00:460c:b0:6ce:2732:1df6 with SMTP id ko12-20020a056a00460c00b006ce27321df6mr5670114pfb.48.1702494698162;
        Wed, 13 Dec 2023 11:11:38 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q5-20020a056a0002a500b006ce19a67840sm10227618pfs.199.2023.12.13.11.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 11:11:37 -0800 (PST)
Date:   Wed, 13 Dec 2023 11:11:37 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Kalle Valo <kvalo@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] wifi: ath10k: use flexible arrays for WMI start scan
 TLVs
Message-ID: <202312131111.256FE1A@keescook>
References: <20231213-wmi_host_mem_chunks_flexarray-v1-0-92922d92fa2c@quicinc.com>
 <20231213-wmi_host_mem_chunks_flexarray-v1-2-92922d92fa2c@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213-wmi_host_mem_chunks_flexarray-v1-2-92922d92fa2c@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 09:06:40AM -0800, Jeff Johnson wrote:
> Currently ath10k defines the following struct:
> 	struct wmi_start_scan_tlvs {
> 		u8 tlvs[0];
> 	} __packed;
> 
> Per the guidance in [1] this should be a flexible array. However, a
> direct replace to u8 tlvs[] results in the compilation error:
>        flexible array member in a struct with no named members
> 
> This is because C99 6.7.2.1 (16) requires that a structure containing
> a flexible array member must have more than one named member.
> 
> So rather than defining a separate struct wmi_start_scan_tlvs which
> contains the flexible tlvs[] array, just define the tlvs[] array where
> struct wmi_start_scan_tlvs is being used.
> 
> No functional changes, compile tested only.
> 
> [1] https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Yeah, this too looks like the right approach: keeping the flex array
close instead of externalized into a no-op struct.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
