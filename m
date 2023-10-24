Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14AA97D5B81
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 21:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344178AbjJXTdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 15:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234736AbjJXTdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 15:33:44 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FF310CF;
        Tue, 24 Oct 2023 12:33:43 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6c4cbab83aaso3204801a34.1;
        Tue, 24 Oct 2023 12:33:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698176022; x=1698780822;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i6EGD2hnIl5nJ7jHbhHkDFGMf4JT3GmrlWO/gNgXFm4=;
        b=dpBhEVsErF/oPa2MM9Fx0Dii+lvnhlcnboZacDnCMRpP5mBMzLqeGjfx9loOiuE2dB
         yfnOJS6wwl5Yx2UP5wFu3HUl3h3KPKaS55VKZEcJbIABqzYvrCCR7bvPHFT5F2Wm6Dgc
         7AAxIBpy2Upit+qhq1RBFDXZjzRWzeiHb23hwpTq8N3VORjvHc+Vk29Q0uxN4cfBjvBn
         ADRx33HX+9202q0bSn/kT80DvcxErVW7AhCgJ4Sso0/K1GuYJLnD+82IKY/mflYBvNEs
         lwubtLUhRogCJDT0ro8dYrHGObESI5ZOkpH0VXVK6OGh8ellcoSBrVoiOoNfoXVcTZ5z
         NfVA==
X-Gm-Message-State: AOJu0Ywben8M9TUNfqCspz9yGoI+Zmh0+vfun97cpTVHZwsC3ZgvciQe
        eqrZGmTyeGx6oYMBo5UmDw==
X-Google-Smtp-Source: AGHT+IG/DnkHUUOZYFCdzFFTsrG7seFDZnhT/cLwyWjOZwqYmjSjpPehEOcMAqlsYZ3B6i2VOy4xRQ==
X-Received: by 2002:a9d:7e84:0:b0:6cc:cc02:6ea4 with SMTP id m4-20020a9d7e84000000b006cccc026ea4mr13324831otp.38.1698176022379;
        Tue, 24 Oct 2023 12:33:42 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s5-20020a056830148500b006b9443ce478sm1946874otq.27.2023.10.24.12.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 12:33:41 -0700 (PDT)
Received: (nullmailer pid 430587 invoked by uid 1000);
        Tue, 24 Oct 2023 19:33:39 -0000
Date:   Tue, 24 Oct 2023 14:33:39 -0500
From:   Rob Herring <robh@kernel.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        linux-usb@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: usb: fsa4480: Add data-lanes
 property to endpoint
Message-ID: <169817601855.430514.5700076619485106727.robh@kernel.org>
References: <20231020-fsa4480-swap-v2-0-9a7f9bb59873@fairphone.com>
 <20231020-fsa4480-swap-v2-1-9a7f9bb59873@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020-fsa4480-swap-v2-1-9a7f9bb59873@fairphone.com>
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


On Fri, 20 Oct 2023 11:33:18 +0200, Luca Weiss wrote:
> Allow specifying data-lanes to reverse the muxing orientation between
> AUX+/- and SBU1/2 where necessary by the hardware design.
> 
> In the mux there's a switch that needs to be controlled from the OS, and
> it either connects AUX+ -> SBU1 and AUX- -> SBU2, or the reverse: AUX+
> -> SBU2 and AUX- -> SBU1, depending on the orientation of how the USB-C
> connector is plugged in.
> 
> With this data-lanes property we can now specify that AUX+ and AUX-
> connections are swapped between the SoC and the mux, therefore the OS
> needs to consider this and reverse the direction of this switch in the
> mux.
> 
> _______          _______
>       |          |     |
>       |-- HP   --|     |
>       |-- MIC  --|     |or
> SoC   |          | MUX |-- SBU1 --->  To the USB-C
> Codec |-- AUX+ --|     |-- SBU2 --->  connected
>       |-- AUX- --|     |
> ______|          |_____|
> 
> (thanks to Neil Armstrong for this ASCII art)
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  .../devicetree/bindings/usb/fcs,fsa4480.yaml       | 29 +++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

