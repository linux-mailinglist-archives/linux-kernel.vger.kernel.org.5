Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C15811E5A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235440AbjLMTMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:12:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235469AbjLMTM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:12:29 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58185E4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:12:35 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-286f22c52c7so5179190a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702494755; x=1703099555; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V74jI7dOUcDVvYykBcDKtAteY2dp8oIdyGSlYSnP1uU=;
        b=AZ2+DJn7sgIAoSCkFpEvapHmYH04IaPL1KewtAdrBd0MPLLCVWEINOAcDKTZTNQdlM
         gd3exLiZnIiZzFiSOj9Uf416tAMwEso5l4hbB9IbKLYD2mYRW/lpgFrTYn4Vo50u8sbW
         tuTXYEHMv2UPlRJ+gTwJT//ZNq6/9V+ChgoLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702494755; x=1703099555;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V74jI7dOUcDVvYykBcDKtAteY2dp8oIdyGSlYSnP1uU=;
        b=jotJtPlXZ7fLkNIflzJyuEZCYI4TJUzf5B07XgB/ReHsMy/RET35SuAEWwFOivEgLi
         juUfSe34DxZPCvc67een7XOQE9orUUk+JG7mqQbgTfUtvnvwjnb05BHhjLK4D5jOlQuL
         EBo58OC/XvYFgaRSlHkSl4P7cdAuE31z0WaVvIhcb9gBqdKBOg0vTxADR2e/qZTfOEa1
         OTaTAIsuUFC37s0Tma9PGAwrEhacJ8mzT4ZvPB8Joec/nhTkM3WbUUeSGqoU4gKP+6xG
         wDXIVmQudiZTVONlJ93DIjTEvTpsbhSiYW6bqRg6LHAg/s5wK/tiAPrvE2XvG29K/CAl
         ZeeA==
X-Gm-Message-State: AOJu0YzjA8TH1verr8VFb5mvsR6n1kYcpzhTzsSmDvkuDmDCWYAVhDK9
        v4TuDG+wawkAgRqKE4LBTRjYmA==
X-Google-Smtp-Source: AGHT+IFpUDQBDy51uN88O/QlSvlZf2zSMRpN7Czjjq82c+ckbqm3K2i2HUnGehJ1UEqg9grnoEyN+w==
X-Received: by 2002:a17:90a:6fc5:b0:28a:f2cc:e008 with SMTP id e63-20020a17090a6fc500b0028af2cce008mr635500pjk.54.1702494754801;
        Wed, 13 Dec 2023 11:12:34 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ik2-20020a170902ab0200b001c74df14e6fsm11170761plb.284.2023.12.13.11.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 11:12:34 -0800 (PST)
Date:   Wed, 13 Dec 2023 11:12:33 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Kalle Valo <kvalo@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] wifi: ath10k: remove unused template structs
Message-ID: <202312131112.F29944F613@keescook>
References: <20231213-wmi_host_mem_chunks_flexarray-v1-0-92922d92fa2c@quicinc.com>
 <20231213-wmi_host_mem_chunks_flexarray-v1-4-92922d92fa2c@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213-wmi_host_mem_chunks_flexarray-v1-4-92922d92fa2c@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 09:06:42AM -0800, Jeff Johnson wrote:
> Currently both the wmi_bcn_tmpl_cmd and wmi_prb_tmpl_cmd structs
> define:
> 	  u8 data[1];
> 
> Per the guidance in [1] both instances of this should be flexible
> arrays. However during conversion it was discovered that neither of
> these structs are actually used, so just remove them.
> 
> No functional changes, compile tested only.
> 
> [1] https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Unused! :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
