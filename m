Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F35806B16
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 10:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377295AbjLFJyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 04:54:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377254AbjLFJyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 04:54:49 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67240112
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 01:54:55 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3316d09c645so547659f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 01:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701856494; x=1702461294; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aTCNtdrnCjRUY4nx+WfhitLfkIdEU+u5rOlYMuK6fK8=;
        b=V3zKHxDxRBJacc0rjl/ulUt+FcyMN3s4C7lYEN9YVXwqt9gsCnZafXvMT0lcvlXw9v
         eB5+cXolpEh7PR7btu1ySvVA3rCIOttH2FS1FSRbsSaKMlWfv3mSizoFA5JPpL1s0ISu
         7qcUqZROrHCa6FbVVquKH+tY4hOgk0pz2mL86e6bhBXTvyd+sEukLIu/LRxeV2xXrCJA
         LSO7bKYDc6dtBCxb86oqjFmt01d87fp4HdKtD+v2kYFAag65JQPsht+QZzrZGJdpFdrd
         40RHGd99tdFk6DrijpEnr8d+spXbQXRChnQX2ZmEgNpuIIbZriHVP2L7MhPqwT2X2ZC/
         LFjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701856494; x=1702461294;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aTCNtdrnCjRUY4nx+WfhitLfkIdEU+u5rOlYMuK6fK8=;
        b=YK3p7DlgUlfsulY+y0tdY+sGLK+TVvJkZxTiNYTL/jG+qgjmO+XZIibnF3urXlbfjk
         wJQUjlNGMo8XbP8IyPIDiYVPoFuKL9UZ0ESgRC0HPrFuIhrx/r9m+Z3ZX0vgjZ1Ziy1b
         9/Oj5MsaZ9lSwSfuwp7QHhlzQTFAapZSTqjCjfh8eLP4FWvVt924fjvRjePVYMM1K0ZX
         com3WpsZ0ThAIyA1QsVs3fsLFLdje4SvRalkNJp3lx86Y86DbhhQ4cnln7JBZ9+GE9sx
         2Ui6OjbZVCl7i83qdQbwkXQPXeG8oFEqkH9vlVRSh9VAz/W0r5QTBtXXFY/jIvjDr4Xa
         aTzA==
X-Gm-Message-State: AOJu0YzDkTeL3he6rBTEj+WOCKzXNMo+wABtYc+KpEtSR0qdqZQDUDtc
        DnGIkiFUMUZZaI46GnSnEmaDOA==
X-Google-Smtp-Source: AGHT+IEpDHw+FDWXV5qQDjf1VsIrkntIzlpWxO7g9TKHWOxe/F+ZDIhT8l5H46wJNNjZlIQhmbBNiQ==
X-Received: by 2002:a5d:58f4:0:b0:333:2fd2:4ad4 with SMTP id f20-20020a5d58f4000000b003332fd24ad4mr290215wrd.80.1701856493874;
        Wed, 06 Dec 2023 01:54:53 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id g7-20020a5d4887000000b003335ebde680sm2861777wrq.75.2023.12.06.01.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 01:54:53 -0800 (PST)
Date:   Wed, 6 Dec 2023 12:54:44 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     hverkuil@xs4all.nl, mchehab@kernel.org, tfiga@chromium.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, kernel@collabora.com
Subject: Re: [PATCH v3 1/2] videobuf2: core: Rename min_buffers_needed field
 to vb2_queue
Message-ID: <a2011bd9-8d1d-486d-8a54-794193dc99ec@suswa.mountain>
References: <20231206085608.33246-1-benjamin.gaignard@collabora.com>
 <20231206085608.33246-2-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206085608.33246-2-benjamin.gaignard@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 09:56:07AM +0100, Benjamin Gaignard wrote:
> Rename min_buffers_needed into min_queued_buffers and update
> the documentation about it.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

[ snip ]

> diff --git a/drivers/media/pci/zoran/zoran_driver.c b/drivers/media/pci/zoran/zoran_driver.c
> index fa672cc8bc67..2c91f75e8d79 100644
> --- a/drivers/media/pci/zoran/zoran_driver.c
> +++ b/drivers/media/pci/zoran/zoran_driver.c
> @@ -749,9 +749,6 @@ static int zr_vb2_queue_setup(struct vb2_queue *vq, unsigned int *nbuffers, unsi
>  
>  	zr->buf_in_reserve = 0;
>  
> -	if (*nbuffers < vq->min_buffers_needed)
> -		*nbuffers = vq->min_buffers_needed;
> -
>  	if (*nplanes) {
>  		if (sizes[0] < size)
>  			return -EINVAL;

This was not mentioned in the commit message.  And anyway, please do
that as a separate commit.

regards,
dan carpenter

