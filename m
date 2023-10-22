Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68AF7D26C1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 00:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjJVWgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 18:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJVWgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 18:36:37 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EDDEFB;
        Sun, 22 Oct 2023 15:36:35 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3b2f28caab9so1847762b6e.1;
        Sun, 22 Oct 2023 15:36:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698014195; x=1698618995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eUG0zzvE3BdCHGMLnrO+X8u9xWDPrHAeIu9Zvpq4LWU=;
        b=PFdA106reqtfHaL6ja6psNFN3SL58dv4uGVZ+/A+ZqIHnwqIf6StwRurFG5xYUM48H
         bg8T6M7jliHqHHfFCg3ZN2+0LCcRdMAn1+Fqu8IUfXpVsh8qllzixanQekJTKU7QZ7Qr
         sDVGDTHHtnzXvAqzNv+tjeTyactzakFY5uEr8zAIFFNIsfJsfx73i4KilqPND7zH1HGA
         dTiOYGHhl41S3jf//7lELB2q/egp5bvbKYZezAeRZFZmUDTPYhE5JXu9NjT3v4urbSbv
         X/qVdIa1Pms7KQwPW38ABQ6BbGFaYfY8O9uf4D8wR+toRtVRJZA+JYcZFbSMFJxMBX8x
         eKCg==
X-Gm-Message-State: AOJu0YxF0ubWM8Afb/2Hwbt9QALLwLTPXA/y066IA9mPe1F/Z8SPzrPr
        f23gpKGmSm7Dugbgb4m9oCUwUaZkCQ==
X-Google-Smtp-Source: AGHT+IFY+qiVBiPRn9j2kB2XYAMPb0uPYWpULgYWZKqMS2K/szkPxcRRBvszYhPq2IQyYpfU7VVxHA==
X-Received: by 2002:a54:4113:0:b0:3ab:8431:8037 with SMTP id l19-20020a544113000000b003ab84318037mr8967886oic.32.1698014194757;
        Sun, 22 Oct 2023 15:36:34 -0700 (PDT)
Received: from herring.priv ([2607:fb91:e6c1:8e5d:a109:ceb8:bec4:d970])
        by smtp.gmail.com with ESMTPSA id e15-20020a056808148f00b003ae36d664a9sm1231552oiw.39.2023.10.22.15.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 15:36:34 -0700 (PDT)
Received: (nullmailer pid 751471 invoked by uid 1000);
        Sun, 22 Oct 2023 22:36:32 -0000
Date:   Sun, 22 Oct 2023 17:36:32 -0500
From:   Rob Herring <robh@kernel.org>
To:     David Wronek <davidwronek@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Joe Mason <buddyjojo06@outlook.com>
Subject: Re: [PATCH] dt-bindings: arm: cpus: Add Qualcomm Kryo 465
Message-ID: <169801418656.751336.13787960008617871479.robh@kernel.org>
References: <20231021071619.187374-1-davidwronek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231021071619.187374-1-davidwronek@gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 21 Oct 2023 09:16:19 +0200, David Wronek wrote:
> Add a compatible for the Qualcomm Kryo 465 found in SM7125.
> 
> Signed-off-by: David Wronek <davidwronek@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/cpus.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks!

