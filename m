Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A987B2CA2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 08:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbjI2Gtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 02:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232655AbjI2Gtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 02:49:32 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BE51B3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 23:49:30 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2bff776fe0bso223401401fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 23:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695970168; x=1696574968; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IdE47ccEJVgPvSH9BWbF+fIplCXC5Qc2Je9vj/botNc=;
        b=Pr5yvZcp+VjqHWgYEydarW6aRJbG7cJcjTS/gcRyeB27StxQRTRFvXsNbG4eKefuXS
         vintCQ0TkitYH4g/JynVx63syoAkU7cvZL5jKmAUlXV8/GY2NQFRv3n/RpdsEPigrK28
         eYlWxL5sBJVEGEfW/EfPWok55T+6L+ak5gey4NlXwLSHF0emXlB4xdBLgwHicUo6uzr1
         Evjx+J7Eh7UwcOX1VZ25ufqm5KhxLvBNMk9Fr3AwjZK94d5GzcUg5H8Zh8Az5OmIeggH
         L+LUvhWzXN+gU1nwupgOOB0FvL4Ew1pdilMODIMn/bAPD0cqCHZo1pVTn67bp7kkfjb9
         aVXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695970168; x=1696574968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IdE47ccEJVgPvSH9BWbF+fIplCXC5Qc2Je9vj/botNc=;
        b=BHuHHLYHcvlqXs0AAUnXAdd5CdVCyvvYK3C7TCQvN4iAWBFMBUhpauBREVzYQ3WwuN
         G+kXpyDJSjNNcS1DmpLQ8hlB0KjcHKMXcytLWAglpn05ug3RHytcxZauIZXY59rTFZob
         19qZm67Igh0VOmPlj0iPEOxbfF9gw5oZZPaIGdQyD1BQ2VdtQC82pSKdtoEHR6L822Y1
         qVo67PRZMXFde0KwCTNPqFMS0WiCrG23Tw4EYWeCDQLU38Y17LOq6V3m53pWzXLA/ftQ
         Bwyusot77DBNInhoHjBDecHOZL4pklUlKmiCmpKiullvcknUQLYcQ0jjo2gbHNzikx52
         EPnA==
X-Gm-Message-State: AOJu0Yx0h6PSME396AKqvSjOUxamuXoFgzFrGdhWcf5lYG9B7dk9i9Ru
        Ma4XXo1ZyxDYLBjp64XbLPOALA==
X-Google-Smtp-Source: AGHT+IEQRfeGnYjHSeRYcCXQtu0cyPPVk5fpNmgv97WC9LvDlu4SIDZmtlXa76nDC02T9PGxFv2byg==
X-Received: by 2002:a05:6512:4819:b0:505:6ede:20b0 with SMTP id eo25-20020a056512481900b005056ede20b0mr825848lfb.58.1695970168197;
        Thu, 28 Sep 2023 23:49:28 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id o6-20020a05600c378600b00405ee9dc69esm751819wmr.18.2023.09.28.23.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 23:49:27 -0700 (PDT)
Date:   Fri, 29 Sep 2023 09:49:24 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Christian Lamparter <chunkeey@gmail.com>,
        Wu Yunchuan <yunchuan@nfschina.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2 wireless-next 2/9] carl9170: remove unnecessary
 (void*) conversions
Message-ID: <d41d0c98-82ef-40f6-8c5c-68a94b5a4655@kadam.mountain>
References: <20230919044916.523308-1-yunchuan@nfschina.com>
 <e544d992-cddd-4ade-81ef-2eed4f3681e8@gmail.com>
 <87zg16iab3.fsf@kernel.org>
 <0b7623f7-561c-4f3b-91c1-aaf1c44f1158@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b7623f7-561c-4f3b-91c1-aaf1c44f1158@kadam.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 09:43:03AM +0300, Dan Carpenter wrote:
> I don't know anything which would warn about this.  Generally, in the
> kernel we try to avoid casts but perhaps there was a static checker
> which likes casts?
> 
> If removing these sorts of casts were an issue we would have known by
> now.

Thinking about it more, if this caused a static checker warning then
probably every kmalloc() would need a cast.

regards,
dan carpenter

