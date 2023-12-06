Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156D18079DA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 21:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442923AbjLFUy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 15:54:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442838AbjLFUy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 15:54:56 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C72A9
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 12:55:02 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1d06d4d685aso1448645ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 12:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701896102; x=1702500902; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rNhyFZvgFU5pptzAoScDKDcqRFNRihHR3+C5yAvq3i8=;
        b=dpdQQ+fmm01yl31ISyJHQGHrbxrvNM8dLD2TJp9+8FcVryQ9r3QrrMZns4koWWr4UV
         qBWkgzupTEp+3a5ZzvxsmwrwRlkfh2fq6fEx4JyiNcZCCqrqS4KmXEmYiOAcmkEsya45
         LMsGsJPaOftS54Sfooe+Jf4U2Of2/b1YurXbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701896102; x=1702500902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rNhyFZvgFU5pptzAoScDKDcqRFNRihHR3+C5yAvq3i8=;
        b=OqdWFuphjD1lf89ZOFA2QZUCQp3QOVpTsqzvY7QWk3yzf3oao5u3J7D4YyqLKZTe9H
         1mbLCg2yjx5tgcJ5S4rHmnxfiqD2ECutuqC2EacZsewGKaIGbzA+7Pb0Rdjeei6Lny9+
         lmxNe2qC1kjuQOVVg+4YXA1VFdj7jR05tuD42at6YG38TbZgcLRx0XqMEiJlGHSqjWad
         iJqS3xUA1LpE8Viu4cHq3IelW2zRgOHwKePYElQz+r6qJgnz6/z6MsjyF7ugs93YPLJt
         1bqwKHha47OlVvcS/yHxbhqxtBeTrB94DdUbDGwlUFrg4y7QVRVHyFfu48xTXBKyTAEY
         fltA==
X-Gm-Message-State: AOJu0YzBDd7yVBwwuiQIc0HsfCP/W8/QH60O0r33h2HY2QwXwxAvb9qB
        m4gVpxg4ZtMoiPeAnJ0fnfQ48w==
X-Google-Smtp-Source: AGHT+IESvAmw3QtseZWIPzrCzbkkkb/Z+GYXQ98I6b/gn42T97kIpEWeyyjO6ixFA/04YDmDNFb3lw==
X-Received: by 2002:a17:903:110c:b0:1cf:b4ac:633e with SMTP id n12-20020a170903110c00b001cfb4ac633emr1371958plh.51.1701896102054;
        Wed, 06 Dec 2023 12:55:02 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id v6-20020a1709029a0600b001cfc618d76csm248569plp.70.2023.12.06.12.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 12:55:01 -0800 (PST)
Date:   Wed, 6 Dec 2023 12:55:01 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Kalle Valo <kvalo@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] wifi: ath11k: Fix ath11k_htc_record flexible record
Message-ID: <202312061254.085B4755@keescook>
References: <20231205-flexarray-htc_record-v2-1-fbb56d436951@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205-flexarray-htc_record-v2-1-fbb56d436951@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 01:00:17PM -0800, Jeff Johnson wrote:
> Transform the zero-length ath11k_htc_record::credit_report array into
> a proper flexible array. Since this is the only array in
> ath11k_htc_record, remove the unnecessary union.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Heh, looks good. I wonder why this was a union to begin with?

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
