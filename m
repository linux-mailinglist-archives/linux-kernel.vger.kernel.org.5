Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D94771091
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 18:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjHEQaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 12:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHEQaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 12:30:24 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A33CD
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 09:30:22 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fe2bc27029so30217115e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 05 Aug 2023 09:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691253021; x=1691857821;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wo3w1ApZWKuGrSbea348OXXQyWwZNwJbQdm22ZLzFNw=;
        b=psXjkU5aini3wj8lH8+MxUkfwJV8N46+ihZJooo6e5bIxjYd75ezU5aK5g4jRax7X4
         Qh0fPAtqmBIf0Nc3L7rRgFylqa8Ja46C5Al7FArOTX45Iz+3V728cZWrllsduCsNSstJ
         36E6bNPWXoliaMLizKfRSyV234cA3vU9dfeaZ4ErbI+dge4DDmz464eMhT0uKERdce1N
         Zq3cBRKBDNDYUeaa3LRgi7XryIR78jxnf1BKoePFbUSrKBfpQBbvEtIxf7IgaO9FjMhY
         3PLfjNi3tadNIWzlAl9IZbl3YKEdojRjWOL0IxSpJGR8Ppedlv8ODodi4PCEkhpGxQt+
         USDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691253021; x=1691857821;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wo3w1ApZWKuGrSbea348OXXQyWwZNwJbQdm22ZLzFNw=;
        b=ep1ys5bPXcHW8OGKq6+lE50agP0eWI9QF+RGFNPLTaIItU5aNsRQxISvSbenwvyjFi
         mi8TIfaYarejQpbPXNGNAC6TzeirQ4bARTbPyCNEI+CUVtibqzbPsCTxWh5NeBZ902O7
         4YI/PhGiNQWBq4gOsFbEmZVfuKn7f8FA/CvZWrk+sTkxJk7yVtToNQLEkJ7Z7AExGhVO
         dWfyG8mv4OriPTXhuYDVZ4aUOcUJkMa0Vig+nqmBSxMMWdORiGHjnhmgNVxADwMGu3kW
         hu1d2leUxqV9ozBfR10kxHTjV//jPkQNo+5wkwkh2Tkz74xl8oDtz5HuwV0955q24NfF
         bgQw==
X-Gm-Message-State: AOJu0Yx2VWJL0t3uq2WVBxH0++vzBOHIaygKuPH/CI4Hyjruwp8tg+O2
        lkWvCXbqfyWkbcBmx6nzmbOQWg==
X-Google-Smtp-Source: AGHT+IHrWXCvWbLCzmTGkjlQNcKl+Sj87RrTsEekUpleiD6eEbMOGwg9ato0FbdfU04+tuslEQMg/w==
X-Received: by 2002:a1c:6a16:0:b0:3fe:2606:84a4 with SMTP id f22-20020a1c6a16000000b003fe260684a4mr3943676wmc.34.1691253021116;
        Sat, 05 Aug 2023 09:30:21 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id a5-20020a5d4565000000b0030647449730sm5486104wrc.74.2023.08.05.09.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Aug 2023 09:30:20 -0700 (PDT)
Date:   Sat, 5 Aug 2023 19:30:18 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Pavan Bobba <opensource206@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Michael Straube <straube.linux@gmail.com>,
        Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: vt6655: replace camel case by snake case
Message-ID: <247b9239-bd87-40ab-a0c7-18883cad2268@kadam.mountain>
References: <ZM4PWL55pMQiYIX6@ubuntu.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZM4PWL55pMQiYIX6@ubuntu.myguest.virtualbox.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 05, 2023 at 02:29:04PM +0530, Pavan Bobba wrote:
> Replace array name of camel case by snake case. Issue found
> by checkpatch
> 
> Signed-off-by: Pavan Bobba <opensource206@gmail.com>
> ---
>  v1 -> v2: 1.character '_' added in the array name "byvt3253b0_rfmde"

You never actually added a _ character.  It should be by_vt3253b0_rfmde.

regards,
dan carpenter

