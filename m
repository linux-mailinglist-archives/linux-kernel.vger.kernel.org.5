Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B4F770551
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 17:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbjHDPzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 11:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbjHDPzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 11:55:04 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2972DB2
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 08:55:03 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fb4146e8ceso20596185e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 08:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691164501; x=1691769301;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k+kAnvbmstCT1otvJqPfzEvIYiB3WoAn6HzT1+Ufosw=;
        b=VBNk+ZzDISqhAo5iXSyXbZzNOFz7p5vQRvDirLKlPpEs3JPtzNElbtlosw3wSxfMsz
         o+nCrPeEimJLSnVbyAPGuudoM0Z4zxR+LOic3rO+/QebbLl4d9uKmEQKilMfO/I+uEk0
         e/yCerm7jhUoqBfub2WYV+pof10yu7vbS7n0wJGmB6lYmzHGhXiCaenu+LeoPBpOXfAu
         DcAfDJVvEtnlvaelCRZ3+Fj6NlJFvjl5QTyItglCuqnnshuLhrKjSYkVjGmsvmahqMow
         HvbP/F9ngJRx/VVKBizi/+qEIAQL6v2i/Xl1OVfVzQvzmvtHUiSxPQ3vriSoSFZUxxFH
         /2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691164501; x=1691769301;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+kAnvbmstCT1otvJqPfzEvIYiB3WoAn6HzT1+Ufosw=;
        b=ZMHrLAQCksNpQ8SaUWjnN5bU/RFCUdYt6sjlGAu00Uhj5W/Hc2pU4NSyfjWRCoH3I6
         lZ3nXNE1A7gTKbc1J0v+tDKyx8LnyFtCX+aIwKQXNw3rvgd0LfJnUvdSUpJg3UL6fPJ+
         +sJKx+xun7df5J8Ai7XyRAtstPSlKbmERZbFo0esvAAr15D+bm+NYghtEI8qNuhw8cpn
         pIW9a8L/6vXimUAoMI2VI3GPNi92/LUGWrZGEPD3LbSHfWl2/GaeFW9qP4fSkeKwA+LM
         vOo/+yV5c153MwbqE28evdP8fK06zobZTX5P064XBFfqvMNXMaKQnQD/QqUvmBTbpgQr
         9lAg==
X-Gm-Message-State: AOJu0YyrG0TwhCdJb2SPDfMyw8SAVQjq+kKwDZu3/OfAy4Q3S58XVQeo
        7pyzQa1BINMrSNipcuTMbvoQ0w==
X-Google-Smtp-Source: AGHT+IHWK7qRi49IeNlIskLcJux6pIAEoQbpRrVKOoacBoB1NeHje2vU0A8deu7hI2ISASdAVaf6/A==
X-Received: by 2002:a7b:cd94:0:b0:3fe:3521:d9ca with SMTP id y20-20020a7bcd94000000b003fe3521d9camr1774229wmj.3.1691164501478;
        Fri, 04 Aug 2023 08:55:01 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n8-20020a1c7208000000b003fe11148055sm2674064wmc.27.2023.08.04.08.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 08:55:01 -0700 (PDT)
Date:   Fri, 4 Aug 2023 18:54:58 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Alexon Oliveira <alexondunkan@gmail.com>
Cc:     gregkh@linuxfoundation.org, martyn@welchs.me.uk,
        manohar.vanga@gmail.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH v4] staging: vme_user: fix check alignment should match
 open parenthesis
Message-ID: <a440a7c7-cfb8-478f-baca-af7e4d684ca8@kadam.mountain>
References: <ZM0QPaWv4lp93rGF@alolivei-thinkpadt480s.gru.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZM0QPaWv4lp93rGF@alolivei-thinkpadt480s.gru.csb>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 11:50:37AM -0300, Alexon Oliveira wrote:
> Fixed warnings and checks as reported by checkpatch to adhere to the
> Linux kernel coding-style guidelines.
> 
> Signed-off-by: Alexon Oliveira <alexondunkan@gmail.com>
> ---
> 
> Changes in v4:
> - Fixed changelog again
> 
> Changes in v3:
> - Fixed changelog
> 
> Changes in v2:
> - Fixed CHECK: line length exceeds 100 columns, noted by
> Greg KH and Dan Carpenter
> - Fixed CHECK: Alignment should match open parenthesis
> - Fixed CHECK: Lines should not end with a '('

There you go.  You managed in the end.  :)

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter

