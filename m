Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1EE7BBF4C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 20:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbjJFSzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 14:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233408AbjJFSys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 14:54:48 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9FF1A7;
        Fri,  6 Oct 2023 11:53:44 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3ae2ec1a222so1548883b6e.2;
        Fri, 06 Oct 2023 11:53:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696618423; x=1697223223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=feah5QusWcQ8cEA5UJQD4nS/oFg2thDfiS4QD6JMFv8=;
        b=qguJozxMzY6UKaiAhV6C0zHEyKh4+3Ug12JMf8+mAfftRgH/k709WYkRQlx/tLy9HA
         3hdnylYvO1pDKtCgd0YNLJpWBFuP42pOszTvWOePYoAA+Igme4VU3uRSuF7uUDHbfdzP
         xBFujsxrlo+pvxSCRqpAOUnEQl/TVXbhGkIpcTfVtYXrhrm8TKMWAImdtJTH8hLFYkWM
         vKyLuJMELWbPPjvxYCURiJYPaQwkkrf/wwx7zLxHv2qr9WQGSF26eqkplNwMXD5NuoP9
         4AwtFGthKx2B+NjgZFzTFbWbqm/FsysDtbHGrQiZm8dZTl80eRt7MRk0GXXECCxLcfkT
         hSgA==
X-Gm-Message-State: AOJu0YzA5BCYbhTqK7yq+Z7cK8oWHrvr+vYFB/Jr2kQexGRvtrAKgl5A
        V/asDyAuL7nz3VTMaD4szw==
X-Google-Smtp-Source: AGHT+IGELyapSHj1VizNNvS/YwtM5zgb5RsFu/FKqJpifefHTY74QVkVCbVjOlrStVFouHfMyaRZNQ==
X-Received: by 2002:a05:6870:14c1:b0:1b0:89e0:114f with SMTP id l1-20020a05687014c100b001b089e0114fmr9831968oab.31.1696618422888;
        Fri, 06 Oct 2023 11:53:42 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id zt2-20020a056871aec200b001e169e7268csm848838oab.53.2023.10.06.11.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 11:53:42 -0700 (PDT)
Received: (nullmailer pid 137560 invoked by uid 1000);
        Fri, 06 Oct 2023 18:53:41 -0000
Date:   Fri, 6 Oct 2023 13:53:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: trivial-devices: Fix MEMSIC MXC4005
 compatible string
Message-ID: <169661842021.137494.16133513040675510249.robh@kernel.org>
References: <20231004-mxc4005-device-tree-support-v1-0-e7c0faea72e4@bootlin.com>
 <20231004-mxc4005-device-tree-support-v1-1-e7c0faea72e4@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004-mxc4005-device-tree-support-v1-1-e7c0faea72e4@bootlin.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 04 Oct 2023 18:39:27 +0200, Luca Ceresoli wrote:
> The correct name of this chip is MXC4005, not MX4005. This is confirmed
> both by the manufacturer website and by the title of the original commit,
> which added other MXCxxxx devices as well but only this one misses a "c" in
> the compatible string.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Fixes: d9bf5d37fd58 ("dt-bindings:trivial-devices: Add memsic,mxc4005/mxc6255/mxc6655 entries")
> 
> ---
> 
> The original commit date being April 1st is possibly clarifying the origin
> of the issue! :)
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!

