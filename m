Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2107B5869
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjJBQjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 12:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbjJBQj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 12:39:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D8A9D;
        Mon,  2 Oct 2023 09:39:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 748F8C433C8;
        Mon,  2 Oct 2023 16:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696264765;
        bh=1KljVs59GNs3YLWEBOpm0jXM1fwMAHbGPRDbcFPmKSE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XfUo7ls3fLZWe3zMKg77o4avQtuPEoX3dM5jrhpngqo2nZ/PWfZbVq8OZP7xiEjGp
         /Z3oHtLwFIuuUFC84PLZhzZTrEhVHMLzTMdvfNzHQly1RIrXSFLAI0s9CP9G0q5wqk
         Jkh8V7JX6OZeIYxRxSBvLYEa0wjQpDFdTNr5CYGyDMAseWbmrM+W6dxYhNSLlnqb+w
         3iU24Z6NoQ4c9pxzGwa/a3DY8inmS57TwhusZsQYPjeqe+xxIbFBgskvs2f9a8M91T
         CWYX/W5PyPjkQHiDDHXW3D3Gxhsbh49ORC1eCHqb8o34jTzaBercl2JEQRNh+9d5io
         CGRLxrY6/ANWA==
Received: (nullmailer pid 1910965 invoked by uid 1000);
        Mon, 02 Oct 2023 16:39:22 -0000
Date:   Mon, 2 Oct 2023 11:39:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Francesco Dolcini <francesco@dolcini.it>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stefan Eichenberger <stefan.eichenberger@toradex.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v1 3/4] dt-bindings: power: reset: gpio-poweroff: Add
 priority property
Message-ID: <20231002163922.GA1905958-robh@kernel.org>
References: <20230928123204.20345-1-francesco@dolcini.it>
 <20230928123728.21901-1-francesco@dolcini.it>
 <20230928123728.21901-3-francesco@dolcini.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928123728.21901-3-francesco@dolcini.it>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 02:37:27PM +0200, Francesco Dolcini wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> 
> Add the priority property to the gpio-poweroff bindings description.
> 
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
>  .../devicetree/bindings/power/reset/gpio-poweroff.yaml        | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/gpio-poweroff.yaml b/Documentation/devicetree/bindings/power/reset/gpio-poweroff.yaml
> index b54ec003a1e0..c6404841bcd7 100644
> --- a/Documentation/devicetree/bindings/power/reset/gpio-poweroff.yaml
> +++ b/Documentation/devicetree/bindings/power/reset/gpio-poweroff.yaml
> @@ -40,6 +40,10 @@ properties:
>      default: 100
>      description: Delay to wait after driving gpio inactive
>  
> +  priority:
> +    default: 0
> +    description: Priority of the power off handler
> +

You also need a $ref to restart-handler.yaml (at the top level).

>    timeout-ms:
>      default: 3000
>      description: Time to wait before assuming the power off sequence failed.
> -- 
> 2.25.1
> 
