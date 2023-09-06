Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDDA7937BE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 11:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbjIFJJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 05:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjIFJJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 05:09:35 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2553CFD
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 02:09:31 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-500a398cda5so5885498e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 02:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693991370; x=1694596170; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4X/jYs+/ceK6gWtZlFl/YtSigIH0OiPo792O7Nz2m84=;
        b=JX4cTXQ4GlLrtTxfwB4xtBhNhGxozgHrH1Dpuq+Jz4nIgRnQBSGtjDEvgwNlroBtxe
         pkly8woKuU6HEy6XbCSnT5PFmd62i0w9Y0GmgOzqBtEgj2eSq+ImMC2JqUr2ltbxZ6QY
         vf7GsLVHUpbNf8bwoeXBdJqWCjAIXOHpd7t/fje0qGGFiqgUmmO0zr/Z4e4MvWlv/C6D
         TR0DFfYr8qKjzOv2qPmd7reRPAgn5mqQAIDGdCAgrXa8d6S3OH0ASCh04euftbeN+87z
         eran3NSrAedDgO9UloQ+EqHqLlM2YYsM9q2eFUhd/ej/oUZIXOC82H9qHya31uoEeLqi
         kkAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693991370; x=1694596170;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4X/jYs+/ceK6gWtZlFl/YtSigIH0OiPo792O7Nz2m84=;
        b=LCgbVmlTMcIOGim5K4jVtE9OAcL4DN83NILuMOhewkbnr7BVhK2y9w38wzvjwIsq2w
         wGlH5qrUUSc2dIaeXQzU4YtXf29frQ5hlajUwp5noN9/E+gn8Db/avYv0w8NHF1bCROk
         EWZTQlCyESr2uxOUAMbic1piYyW9D6zH+NH7sjQ5aEGCQOUMCcV6D1CB1I9dO3GJO3Du
         Z/WWDN8yWV7ojIkPaemmdJSZo207+Eq7/pVpjYibO/yilabJivOxBAvw6zfqO1+8qsri
         GFs7c1dvoETVREI0c6nRCNOBofhzQqrbWrC2lXGWnFmb7ErkSTWvsO0G4pezN/BR+12r
         mtEQ==
X-Gm-Message-State: AOJu0YxG7pCx4EgLTJHBY/iW7mEWCjFTwlwvF6GDn/iUcjN4jocD3soy
        binfOWndCMGQEr8udOHzkr68EA==
X-Google-Smtp-Source: AGHT+IFNS8vMe8UQso30/VjQUsvJh4qnhE+E9TRK6jeh1PSIGk7aZr1gUHl7XJYvP0P7idfjMDRGkw==
X-Received: by 2002:ac2:5f49:0:b0:500:b302:3281 with SMTP id 9-20020ac25f49000000b00500b3023281mr1478513lfz.27.1693991369955;
        Wed, 06 Sep 2023 02:09:29 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id dd18-20020a0560001e9200b0031f3ad17b2csm12319036wrb.52.2023.09.06.02.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 02:09:29 -0700 (PDT)
Date:   Wed, 6 Sep 2023 12:09:25 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Greg Kroah-Hartman <gregkh@suse.de>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        speakup@linux-speakup.org
Subject: Re: [PATCH] accessibility: speakup: Fix incorrect string length
 computation in report_char_chartab_status()
Message-ID: <10d321d6-89ab-464e-971d-bb9635a5308f@moroto.mountain>
References: <b388b088485aff5dc223f2723ee61e00e5cd3f7d.1693855874.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b388b088485aff5dc223f2723ee61e00e5cd3f7d.1693855874.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2023 at 09:31:44PM +0200, Christophe JAILLET wrote:
> snprintf() returns the "number of characters which *would* be generated for
> the given input", not the size *really* generated.
> 
> In order to avoid too large values for 'len' (and potential negative
> values for "sizeof(buf) - (len - 1)") use scnprintf() instead of
> snprintf().
> 

A bunch of kernel-janitors mail didn't reach my inbox...  Like this
one.  So weird.

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

The impact of this bug is a WARN() btw.  snprintf() will refuse to
print negative bytes.

regards,
dan carpenter

