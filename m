Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC44792A8D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242797AbjIEQjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354397AbjIELTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 07:19:25 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF5F1AB
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 04:19:22 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-31aeef88a55so2108816f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 04:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693912761; x=1694517561; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rR3NgRgKFQN5S7H9Sc+cx2W9dxOwqbakDNo3XALZ8qE=;
        b=sI95S5sc9qqXzeBo93ayf4vb69OJXUCXteVuI7/N9mdhSjjGqsJdSK+yHl6Lp6rTw6
         gGF8yOsLnXaZyg232EaZ0E9YM5S2F+OyCINIP99X2nw61N5aOHrL6LD3tAWYxmiDZnGj
         ACztqkifK6GAGD/yTvPFn/XrGYf7Mgo3UiTYIt2l5Ah4Ua4Lk69Jnjy8KVaJ0lAAXHpN
         gjEPaP9iBiLcJaUORjqlTk7dDYg2c6WyJ1lQ8yk+oFeXsEYLm7E4hyRtjkPjM2IcIyEi
         EPQgf/YnSNtZAN1OAkKm9VXbJHN6D1HgyNGvfvaUqQhICJfPz/pjjQn1MrLFWmdrhopt
         dTFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693912761; x=1694517561;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rR3NgRgKFQN5S7H9Sc+cx2W9dxOwqbakDNo3XALZ8qE=;
        b=D+vv7aqzpAbJrUekVx1wMEuulrxAeEmcBgtgttmMjwgcj7tehlCavJO0I7rRXLeK+3
         kwV5fGkk/8qzvHdb156VDGi2yGPk9Lr5rzBVglErnsTNjvqZjko5rEoBKxtHgNcuVkC9
         8qUKXPurL4ST5rfbUpC6JHT568NaK9sryhu6MjqlZ1FHp5I9UXCNAht9nAWYLH/bOwhH
         HjqCyAlGV86BHmVqzGC2mXcTxKMXbxQZx5j8AkV7LqCG+xv1i4/bJXW/TbGfZ1ErF3kD
         gl4xxRLkq/ASlZKGFjLXSOinhgkX3umZb/8hMcvfhfu6LmKZznAsoh+k8KS5ceQEXhda
         jsEw==
X-Gm-Message-State: AOJu0YxcvvtM4WGctIqQJUfRK6Pa9WzZwnx9nayOB0JvfKa1CPrdPbMK
        U3/qjHnAszZ7/d2LsYAmsdhWCA==
X-Google-Smtp-Source: AGHT+IGQ8xcMSsnRXRMhSLpPSaE++12jHPWZM0Qlp9r1kXdO7dxxboeIvPemqwcEnaMj7dw3v6IEMw==
X-Received: by 2002:a5d:460f:0:b0:314:4237:8832 with SMTP id t15-20020a5d460f000000b0031442378832mr9505572wrq.48.1693912760836;
        Tue, 05 Sep 2023 04:19:20 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id b4-20020adfde04000000b0031aef72a021sm17056235wrm.86.2023.09.05.04.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 04:19:20 -0700 (PDT)
Date:   Tue, 5 Sep 2023 14:19:17 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Dongliang Mu <dzm91@hust.edu.cn>
Cc:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>,
        Kalle Valo <kvalo@kernel.org>,
        hust-os-kernel-patches@googlegroups.com,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ath9k: clean up function ath9k_hif_usb_resume
Message-ID: <7fd16cae-483c-4145-ae59-ee1775005fa8@kadam.mountain>
References: <20230905013556.2595854-1-dzm91@hust.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905013556.2595854-1-dzm91@hust.edu.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 09:35:56AM +0800, Dongliang Mu wrote:
> In ath9k_hif_usb_resume, the error handling code calls
> ath9k_hif_usb_dealloc_urbs twice in different paths.
> 
> To unify the error handling code, we move the else branch before
> the if branch and drop one level of indentation of the if branch.
> 
> In addition, move the ret variable at the end of variable declarations
> to be reverse x-mas tree order.
> 
> Note that this patch does not incur any functionability change.
> 
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
>  drivers/net/wireless/ath/ath9k/hif_usb.c | 34 ++++++++++++------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
> 
> v1->v2: move the else branch on top of if branch;
>         move ret variable at the end of variable declarations;

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter

