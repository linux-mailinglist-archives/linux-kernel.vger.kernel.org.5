Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9BB37B583E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238498AbjJBQvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 12:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237797AbjJBQu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 12:50:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8602A7
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 09:50:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62B9CC433C8;
        Mon,  2 Oct 2023 16:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696265455;
        bh=f355bukHKLu1rhR9na0ATb96tUNkqek2Wx4BQTlRLEE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TvhQY/lPTGKePjWnU3TJXXZbvZcyE9R4GVQNjw2UhR1CGilrwJflkZpSCRx68mWX9
         aglUTzcQd57shU8ZaQjV4Ir5l5bU7wGp7N8tJtUwEQ0Ix+MGMON27iCuEipKyDXxr6
         dJhSpUKrHjvchK3ArrSixlPpkW+/3M5PrIhA+PL9oBHP5zfjGTzOZt2GcmkXAKF4lH
         Uth6eLZhyVqoJ9Z+o2yT8q+A6ims3hajfeoQ+CPSbHYnHWSR7VPoFmWZWt18Q6SrHn
         vVjTax/Xrw+fgZz4gVd8yUZIM03a1AIcqsYAGgQAtj3sMbyfF4HDpgOb2ZVcTtvXRq
         dGYG6HWBiHP9w==
Received: (nullmailer pid 1924037 invoked by uid 1000);
        Mon, 02 Oct 2023 16:50:52 -0000
Date:   Mon, 2 Oct 2023 11:50:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: dt: writing-schema: add example for multiple
 DT_SCHEMA_FILES
Message-ID: <20231002165052.GA1915589-robh@kernel.org>
References: <20230928190259.3497563-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928190259.3497563-1-hugo@hugovil.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 03:02:59PM -0400, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Variable DT_SCHEMA_FILES can specify multiple files, but the
> documentation does not indicate how to do it. Each entry needs to be
> separated by a column symbol ':'.
> 
> Add an example to make it more obvious how to specify multiple
> DT_SCHEMA_FILES.
> 
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
>  Documentation/devicetree/bindings/writing-schema.rst | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/writing-schema.rst b/Documentation/devicetree/bindings/writing-schema.rst
> index 4a381d20f2b4..a500d3c2e12e 100644
> --- a/Documentation/devicetree/bindings/writing-schema.rst
> +++ b/Documentation/devicetree/bindings/writing-schema.rst
> @@ -159,11 +159,13 @@ It is possible to run both in a single command::
>      make dt_binding_check dtbs_check
>  
>  It is also possible to run checks with a subset of matching schema files by
> -setting the ``DT_SCHEMA_FILES`` variable to a specific schema file or pattern.
> +setting the ``DT_SCHEMA_FILES`` variable to a specific schema file, multiple
> +schema files or pattern.

And multiple patterns. I would say: ... to 1 or more specific schema 
files or patterns (partial match of a fixed string). Each file or 
pattern should be separated by ':'.


>  
>  ::
>  
>      make dt_binding_check DT_SCHEMA_FILES=trivial-devices.yaml
> +    make dt_binding_check DT_SCHEMA_FILES=trivial-devices.yaml:rtc.yaml
>      make dt_binding_check DT_SCHEMA_FILES=/gpio/
>      make dtbs_check DT_SCHEMA_FILES=trivial-devices.yaml
>  
> 
> base-commit: 633b47cb009d09dc8f4ba9cdb3a0ca138809c7c7
> -- 
> 2.30.2
> 
