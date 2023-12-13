Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E57811E4E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjLMTKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:10:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235548AbjLMTKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:10:19 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CD2D5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:10:24 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1d0c4d84bf6so43703475ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702494623; x=1703099423; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QqkTY1D+Z0smSuBPziSXpfoIkBBzL9zSOCOQ3/VwzV8=;
        b=CE1E8N2YrSlCa3ZagkQjHUXjZES8FXi9nuCnC6w3mP3ssI2+vrg6eCxwymrV/dwewd
         rIAEGlhIZyy9lZM5i3djaktv6e/Nr48ex/cEQdVS21w2XS/ukfPcDqjwbxVbDFx1JkZa
         Q2+ppRDpUisA3M3MywHl3dsIcyoamA2e9fxhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702494623; x=1703099423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QqkTY1D+Z0smSuBPziSXpfoIkBBzL9zSOCOQ3/VwzV8=;
        b=kDG4qRf5UKSvshYhe8g+KGHm6elKb+knAsxpCYjX2gMBOWJaDQuHsP9+3VhGOIs/8r
         yDiAvj9ioTcSdSvxvFEu8hfkqziuS9NhYcYrAN7lWceCEcIHXPYH22EI5XF3MmweL3qc
         vtPuXzh9JJ/ZtSYI9X6FUKAmv2+impR+jQzMezJLD+AMmOo3zGoZ1WnLsSLLOSz3nHAu
         6EzsNRY8art8Dq14L7tDrLkuq1M0nG8IfKpGugYSqtjedDbAIGXCfaEBM8mOB2479REY
         o5wO6jj+iOjA2w8mewShAms4cIUt1A5TJgFvZhhnaI7x+jsmPiqGIXVJcv9FrLVkjenG
         QMlg==
X-Gm-Message-State: AOJu0Yx2AF5m4Czc+LKK1sF5cPw040JsmJoSQWTwe+2PqX1pAxtzR4ne
        hfr3fL7HyPyxnUAiBUciPq7Dfg==
X-Google-Smtp-Source: AGHT+IGgfljpT76KBPui5MmTR6g8xbaYQw4KFDi5WWuN30o04xnbXoheBZ2WDSfB+ilvt/xURB8IDw==
X-Received: by 2002:a17:903:98c:b0:1d3:4316:68d3 with SMTP id mb12-20020a170903098c00b001d3431668d3mr2259140plb.76.1702494623547;
        Wed, 13 Dec 2023 11:10:23 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f11-20020a170902ce8b00b001cc307bcdbdsm10950629plg.211.2023.12.13.11.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 11:10:23 -0800 (PST)
Date:   Wed, 13 Dec 2023 11:10:22 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Kalle Valo <kvalo@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] wifi: ath10k: use flexible array in struct
 wmi_host_mem_chunks
Message-ID: <202312131110.F94BC3427@keescook>
References: <20231213-wmi_host_mem_chunks_flexarray-v1-0-92922d92fa2c@quicinc.com>
 <20231213-wmi_host_mem_chunks_flexarray-v1-1-92922d92fa2c@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213-wmi_host_mem_chunks_flexarray-v1-1-92922d92fa2c@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 09:06:39AM -0800, Jeff Johnson wrote:
> Currently struct wmi_host_mem_chunks defines:
> 	struct host_memory_chunk items[1];
> 
> Per the guidance in [1] this should be a flexible array. However there
> is a documented requirement:
> 	some fw revisions require at least 1 chunk regardless of count
> 
> To satisfy this requirement, follow the guidance from [2] and wrap the
> array in a union which contains both the flexible array and a single
> instance of the underlying struct. Since the footprint of the struct
> is unchanged, no additional driver changes are required.
> 
> No functional changes, compile tested only.
> 
> [1] https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays
> [2] https://lore.kernel.org/linux-wireless/202308301529.AC90A9EF98@keescook/
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

This looks like the right approach here.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
