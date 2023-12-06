Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6FA807248
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 15:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378902AbjLFOX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 09:23:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378736AbjLFOX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 09:23:26 -0500
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF435D40;
        Wed,  6 Dec 2023 06:23:32 -0800 (PST)
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-58e30de3933so2606211eaf.3;
        Wed, 06 Dec 2023 06:23:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701872612; x=1702477412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OpCrWaPIxeDssdyEzrjnT1c7IS3T+pTErjTHSzBnvOk=;
        b=fhxCGoQTiUpknwb7pyh4oc+KZU9feFo43Wp2vH9WzI3ifJxo8oDgCWwhSmDbxlOv4b
         bZOHoprGoAaltl9jReXBTntTffC+oYNYHyiW36abfypoMPP/bQDnpo1mMvfz2z0V3cG7
         VO/fqjTG+8kZZzXH3/pbyD1sWM6Oj8s186XW8TAZoRMSWCRY5p+iMQuKBa4JPt8SzWNN
         DSq8JjUeoekwaUQUQc8LAAOzC33LcgSz2dh+b1+3+NENv/MxKZ6R3ygVA958ujQe6Fgw
         VQdCgKHeEVtngxaALrQ2GLRmlvS2zVIz72p4yvBt9VN2wpqtWW5ovwTpOdvAYz8pX9pW
         UYug==
X-Gm-Message-State: AOJu0Yy0SI4xV2f0eBp0a2keaKNA10P+7BneQsVCAUeOMBI0h1IqKQvJ
        OrGcy40aXAwLuOGH/JUG8Q==
X-Google-Smtp-Source: AGHT+IFWQTrlPLxcozyLAD800qlPN2UKoJz8Qh3PpU/NNLkkiyAehsLiKb2jwnIz1GKxJiZrihtguQ==
X-Received: by 2002:a05:6820:812:b0:58d:a202:5bdd with SMTP id bg18-20020a056820081200b0058da2025bddmr1063238oob.9.1701872612191;
        Wed, 06 Dec 2023 06:23:32 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l14-20020a4ad9ce000000b0057b6ac3922esm5126oou.18.2023.12.06.06.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 06:23:31 -0800 (PST)
Received: (nullmailer pid 2093301 invoked by uid 1000);
        Wed, 06 Dec 2023 14:23:29 -0000
Date:   Wed, 6 Dec 2023 08:23:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ante Knezic <ante.knezic@helmholz.de>
Cc:     f.fainelli@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, netdev@vger.kernel.org, marex@denx.de,
        UNGLinuxDriver@microchip.com, edumazet@google.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        woojung.huh@microchip.com, conor+dt@kernel.org, pabeni@redhat.com,
        kuba@kernel.org, olteanv@gmail.com, robh+dt@kernel.org,
        andrew@lunn.ch
Subject: Re: [PATCH net-next v7 1/2] dt-bindings: net: microchip,ksz:
 document microchip,rmii-clk-internal
Message-ID: <170187260197.2093058.12221518156391791381.robh@kernel.org>
References: <cover.1701770394.git.ante.knezic@helmholz.de>
 <721693a7a37d7579d3a29ed5819dbbdf1d4ea3f4.1701770394.git.ante.knezic@helmholz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <721693a7a37d7579d3a29ed5819dbbdf1d4ea3f4.1701770394.git.ante.knezic@helmholz.de>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 05 Dec 2023 11:03:38 +0100, Ante Knezic wrote:
> Add documentation for selecting reference rmii clock on KSZ88X3 devices
> 
> Signed-off-by: Ante Knezic <ante.knezic@helmholz.de>
> ---
>  .../devicetree/bindings/net/dsa/microchip,ksz.yaml | 34 +++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

