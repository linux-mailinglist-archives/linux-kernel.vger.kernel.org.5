Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44167D5B85
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 21:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344248AbjJXTeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 15:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344224AbjJXTeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 15:34:10 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C53D10DA;
        Tue, 24 Oct 2023 12:34:08 -0700 (PDT)
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6ce2c71c61fso2903003a34.1;
        Tue, 24 Oct 2023 12:34:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698176047; x=1698780847;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eEvk4THNhAVnYNssVruy5oIOt2OcyG6oUAQ19IBkZyk=;
        b=Vj4gLCxRMG5YYYtk6xXJ/+0UicdbrItqMMrYnxrhQ5JAQg8BlpaBabB8W7RXkTkgUR
         UPfDXd+MP6FuAYVi3+S9efIO5pXdK82YQvKU/hW6AnOrN+fcWDjN0tTEkezp+Ta7MM8P
         +ZU+1xSGa15a8bDWI+p/B3rlr1+FM09/4nY52ss7+EhMUA3Fdfxfd59UoRUlJz/OO5sT
         adcsCNzweDdS9d7dy5/kecL9OxFp1OM2qRZoxzZsQdsSlobHv8i3MahNkscA2D2NiALr
         3FbJmLNm2PVv5xgBbD+9oktNeRUMRU6OQRDuOa8GER17xC9DVzt1pPgPDNhsz5PRjNxx
         ObCA==
X-Gm-Message-State: AOJu0Yw9+YktdasYVkc5Bi5QSOQiOEaEVm0ipX1hkNgZ89KyU3tCMWgh
        7Prifz/RImtZRZ3DYkjj2A==
X-Google-Smtp-Source: AGHT+IE/D4pFNKTrDIzKXf08TJS0pbhvTukMC0upbfWG2caKaiSl0A3HnpKNq3MT/iuTQ5vyPB4u8Q==
X-Received: by 2002:a05:6830:2058:b0:6b9:d224:1a1d with SMTP id f24-20020a056830205800b006b9d2241a1dmr11080588otp.19.1698176047284;
        Tue, 24 Oct 2023 12:34:07 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s15-20020a056830124f00b006c4727812fdsm1964537otp.15.2023.10.24.12.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 12:34:06 -0700 (PDT)
Received: (nullmailer pid 431352 invoked by uid 1000);
        Tue, 24 Oct 2023 19:34:05 -0000
Date:   Tue, 24 Oct 2023 14:34:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 3/3] dt-bindings: usb: fsa4480: Add compatible for
 OCP96011
Message-ID: <169817604506.431304.9280516039903751308.robh@kernel.org>
References: <20231020-fsa4480-swap-v2-0-9a7f9bb59873@fairphone.com>
 <20231020-fsa4480-swap-v2-3-9a7f9bb59873@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020-fsa4480-swap-v2-3-9a7f9bb59873@fairphone.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 20 Oct 2023 11:33:20 +0200, Luca Weiss wrote:
> The Orient-Chip OCP96011 is generally compatible with the FSA4480, add a
> compatible for it with the fallback on fsa4480.
> 
> However the AUX/SBU connections are expected to be swapped compared to
> FSA4480, so document this in the data-lanes description.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  Documentation/devicetree/bindings/usb/fcs,fsa4480.yaml | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

