Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7567D765990
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 19:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjG0RJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 13:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbjG0RJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 13:09:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01444273C;
        Thu, 27 Jul 2023 10:09:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6054461E9F;
        Thu, 27 Jul 2023 17:09:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88213C433C7;
        Thu, 27 Jul 2023 17:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690477793;
        bh=Ky/oluIzHCEeuhuElQC9U6jY75TgLuPVRTngDIASvjE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tV37aRq3EnmJ9lKNBvRBBvsJcANZbaisFqMyrl2Pi3tWcwWt18y03vrvM9t5FKEk1
         Rl2/hqSCp3MrBcDSdvTjpGkYTdPmzmXE1L5NwlutDlmd9t4OfapibIqrZitsxA/HH/
         /LG4PLGudZsTrq0m5vXi1bZ3nGWoSvAXkxCBC2o11jKkYuSQE1xiQjpMFLDO+bByk3
         GoIz9nFIM43fkkTCYGgbdNWbDUp/AbK8mgEyboS+emJNvBbvKmjCxukQ22Pwd+5+2J
         +RNRSUTAAYm6mwokdZvQGBU3TQBa/uZqp80HzgudzpTStjB0DxSYsDWkPLybPYap7a
         1zS3Q+X2UWTPA==
Received: (nullmailer pid 1835903 invoked by uid 1000);
        Thu, 27 Jul 2023 17:09:51 -0000
Date:   Thu, 27 Jul 2023 11:09:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Wayne Chang <waynec@nvidia.com>,
        Benson Leung <bleung@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        chrome-platform@lists.linux.dev
Subject: Re: [PATCH v2] dt-bindings: usb: connector: disallow additional
 properties
Message-ID: <169047762815.1817455.10294109902961650429.robh@kernel.org>
References: <20230725102325.76336-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725102325.76336-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 25 Jul 2023 12:23:25 +0200, Krzysztof Kozlowski wrote:
> USB connector bindings is complete, thus no additional properties should
> be allowed.  Add missing 'reg' property and change additionalProperties
> to false, so the schema will check for anything not unexpected.  This
> also allows to drop the 'reg' from other bindings referencing the
> usb-connector.yaml and make it required.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes in v2:
> 1. Make usb-connector.yaml additionalProperties:false (Rob)
> 
> v1:
> https://lore.kernel.org/all/20230723071105.40157-1-krzysztof.kozlowski@linaro.org/
> ---
>  .../devicetree/bindings/chrome/google,cros-ec-typec.yaml    | 6 ++----
>  .../devicetree/bindings/connector/usb-connector.yaml        | 5 ++++-
>  .../devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml       | 6 ------
>  Documentation/devicetree/bindings/usb/cypress,cypd4226.yaml | 6 ++----
>  4 files changed, 8 insertions(+), 15 deletions(-)
> 

I didn't not fix the double negative and applied, thanks! ;)

