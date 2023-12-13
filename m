Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E43811E57
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233853AbjLMTMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:12:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235516AbjLMTMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:12:00 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9A6184
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:12:06 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-28aeacb2dfdso581082a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702494726; x=1703099526; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DCfe0ZWGgKzRVbzzblrUJytzWn+QlPVSI/o4NKBNpNY=;
        b=K3tKl2v5NjRUIbGpRze9LudGxC5nyQ02GOBYGbxPanOi/HgOy6pduBZbkUeWZULBhS
         dD6YVKu/R0h347ZHWHVReuwT2IUYqU/MQJbFfjNl1C3P8yz9FMASBPnlzjyVEhP4nmW8
         frNCI56AY+XSdrFGM8/n/OUUXjnBBK9bzzX90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702494726; x=1703099526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DCfe0ZWGgKzRVbzzblrUJytzWn+QlPVSI/o4NKBNpNY=;
        b=grZ2CFO3lNpLChf4ELVTyItl3gXaCVnFGoP9phWZe3G7xvS/Uk1VAjgf+60/ASRIKo
         1AXyzRt4+8R6OCjJ0xuoNgiUdouBf6w4hwPFBvLE6y1ZxD/ySEvCwy2Hs6VRU9qeQRR+
         qS4gRb9/x/i+LvPhOCtl960RAVwX7b9lolI/Kf4W0fsWCMWPq1qbUtPDwR8NhHh9DR+P
         TbjRDUE8NxEbgPxPUfATbkZP4KjRMOTZVjeSOqMfJraKw8z+8XTEAFgB18+tTtpveWrM
         PDRYNRqGnxjFRKJlVGH5OB3LdpwVxDj0ujTjvrztQK3AgGRSAIe1JuIhh1Yj2CNmUEf7
         5rtA==
X-Gm-Message-State: AOJu0YxkJUApgMLOutvhfeyInju/uo98iCwqlVPh37ZWrxyOHOwoNyLc
        w2pu3gxOTuHhwMy3xjZn5UAmxQ==
X-Google-Smtp-Source: AGHT+IFcFdO4Yi25NiYYgSY1pHflwWXW48z97I9Nc7iqIJzPnx+Qyma6RencgmBrM/Eo3+BnjT73qg==
X-Received: by 2002:a17:90a:72ca:b0:28b:131:ced8 with SMTP id l10-20020a17090a72ca00b0028b0131ced8mr276703pjk.32.1702494726005;
        Wed, 13 Dec 2023 11:12:06 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id pm17-20020a17090b3c5100b002866c96fc71sm11629572pjb.38.2023.12.13.11.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 11:12:05 -0800 (PST)
Date:   Wed, 13 Dec 2023 11:12:04 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Kalle Valo <kvalo@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] wifi: ath10k: remove struct
 wmi_pdev_chanlist_update_event
Message-ID: <202312131111.53F3E2EF51@keescook>
References: <20231213-wmi_host_mem_chunks_flexarray-v1-0-92922d92fa2c@quicinc.com>
 <20231213-wmi_host_mem_chunks_flexarray-v1-3-92922d92fa2c@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213-wmi_host_mem_chunks_flexarray-v1-3-92922d92fa2c@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 09:06:41AM -0800, Jeff Johnson wrote:
> Currently struct wmi_pdev_chanlist_update_event defines:
> 	  struct wmi_channel channel_list[1];
> 
> Per the guidance in [1] this should be a flexible array. However
> during conversion it was discovered that this struct is not used, so
> just remove the entire struct.
> 
> No functional changes, compile tested only.
> 
> [1] https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Removal of unused structs is good. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
