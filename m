Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3372E79B638
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355181AbjIKV5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240947AbjIKO5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 10:57:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A13E40;
        Mon, 11 Sep 2023 07:57:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E88C433C7;
        Mon, 11 Sep 2023 14:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694444260;
        bh=TYHGgYfw4hGPEdlDxDeeSN1DQgJ1JD0PfFtQts0E6TM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QGCCfGcGCLz4apUcZkKTabXRluZzKFz9nhNmweX/JyRGK/BgIhg9YEQ3mJO0b3zKD
         yErHp0+Qp+e0Ol4OoGVvQ3XvG+O6SqwTynPz3lrUVp8GCLAJBWsoQ/ZNThXJC/LY3o
         Mk5VI5zy0R9iHsw0aIpV7wW1qvTrG5H73efJCyNEqLwQ1xDRB+AwrKoxUjEqqvQCrP
         a0e4poeQEZ5fsSSA0YVe9LUxEowrv9eM5m4/ogfD0UlzUnfEuqbi2vHPMZ+89RWgfi
         19xDEDvhB2XGpxHczfm45jrMuWHlpfh5sNzNGKl2arDUe1HB4RT4lY6CXGyhOC/dUS
         S2CJ6Y9alwtfQ==
Received: (nullmailer pid 1245600 invoked by uid 1000);
        Mon, 11 Sep 2023 14:57:38 -0000
Date:   Mon, 11 Sep 2023 09:57:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     richard.yu@hpe.com
Cc:     nick.hawkins@hpe.com, verdun@hpe.com, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH v2 1/3] dt-bindings: usb: Add HPE GXP HUB Controller
Message-ID: <169444425764.1245553.14929888489108939275.robh@kernel.org>
References: <20230907210601.25284-1-richard.yu@hpe.com>
 <20230907210601.25284-2-richard.yu@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907210601.25284-2-richard.yu@hpe.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 07 Sep 2023 16:05:59 -0500, richard.yu@hpe.com wrote:
> From: Richard Yu <richard.yu@hpe.com>
> 
> Provide access to the two register regions for GXP HUB
> controller through the hpe,gxp-hub binding.
> 
> Signed-off-by: Richard Yu <richard.yu@hpe.com>
> 
> ---
> 
> v2:
>  *Removed the term "virtual" as it is still a device.
>  *Removed the downstream port number and generic endpoints
>   number properties from device tree structure.
> ---
>  .../devicetree/bindings/usb/hpe,gxp-hub.yaml  | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/hpe,gxp-hub.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

