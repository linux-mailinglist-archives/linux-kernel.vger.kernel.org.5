Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E427513B1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 00:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjGLWkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 18:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbjGLWkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 18:40:39 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950EC1BF9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 15:40:35 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b852785a65so256325ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 15:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689201635; x=1691793635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W74OVpeHRuNiX8pMSZJwMLioV1gL07KE3H1a2Sb6peY=;
        b=QgNyeryYTTACVv5xzPnNBA4fBv8uhd7VsaVJyHLSkvwtHQ661hFCyV66BZ6tioghkS
         IiSrAN7DKiJZGemA6V8wlUMgmctAMNrRpVUKhk/5Lv33vAAYGSUdGM69pCLaNnlbNOXh
         8XefLt2O2fzoj5+Y6R5Z6VGjlTW+vbMv4QtDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689201635; x=1691793635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W74OVpeHRuNiX8pMSZJwMLioV1gL07KE3H1a2Sb6peY=;
        b=EK+YCt8WTuk7ekbxYVWaHzPGondw6mcVdUz9xhRmgPxR6ukMpRsf4qfiOCGWeg/k2K
         k+oST84Gst/wSXD1qwGweyPOWTJZZyOBBuuFpL/epA5nw+Ncu8Ti673TwTrZbzB66LBD
         XDkiQHqtsld1JimU83Hlg3Dq1lcVMYrNrDaM+gPac2KUAIE4atVoXyu0TP0PcD41S1m9
         5ndRoTuqJmu8zsa4E7Dff516GqoruVUIMnIAD4f/KDSv48GMKmmQtgpbZ/zm2e/9Nvjf
         3Syqs7HQCX1PimxcxGJmSoyoLSSFsau2UI0wi23NcnEpmx/nFNd4SqLROfSu1MY+kRmc
         hIIg==
X-Gm-Message-State: ABy/qLalFX4ovv/YOxJ4tCLtgWHa+I0C3iKVfyfdn5Fu4Q85cgXokv9m
        PpAZkTGtGgdDU0yqnc6lAig0FA==
X-Google-Smtp-Source: APBJJlHjYHPAqP5SmPN3RIOl52xjZOYYkXRgyg60M7GK47U7g8k/67db5mDhdwbCY4s7DI8euJG7fA==
X-Received: by 2002:a17:902:ea03:b0:1b9:d38d:efb1 with SMTP id s3-20020a170902ea0300b001b9d38defb1mr196238plg.8.1689201635138;
        Wed, 12 Jul 2023 15:40:35 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d14-20020a170903230e00b001b864add154sm4475679plh.154.2023.07.12.15.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 15:40:34 -0700 (PDT)
Date:   Wed, 12 Jul 2023 15:40:34 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: smem: Use struct_size()
Message-ID: <202307121540.F8EBBCA1D3@keescook>
References: <f74328551cfab0262ba353f37d047ac74bf616e1.1689194490.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f74328551cfab0262ba353f37d047ac74bf616e1.1689194490.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 10:42:15PM +0200, Christophe JAILLET wrote:
> Use struct_size() instead of hand-writing it, when allocating a structure
> with a flex array.
> 
> This is less verbose.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
