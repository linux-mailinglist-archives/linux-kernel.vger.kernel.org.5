Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D912778264
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 22:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjHJUxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 16:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHJUxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 16:53:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB54F26B5;
        Thu, 10 Aug 2023 13:53:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 218DA668E3;
        Thu, 10 Aug 2023 20:53:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FADDC433C7;
        Thu, 10 Aug 2023 20:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691700810;
        bh=hjFZI1bWZhkQJAvPWDBQTHKlfTzg8WuwI3ke6THo4kM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r1OyGTtOTv44QirxiDCmkjPQyqlT0YUT7FARB5tvjc4qk7XCZRbqavV+XZZis6jSn
         xIhBdZq2c1jN8PM8FK+otIZ6+O5+t43fqpzMJMyhK5qovg1aMukWUnhA59weBxc390
         oEoyZL9YyimSiaeFuLjnqdNb+7DU+rs9r/tDuKvHLCONJSIF+j/KdSZK1WK5+cGBGG
         NUsrPz2/9M/fbM5Uo9rxuLqf7SdYYqBkOwT9lk7PYJBl6UXCdd5Ls44QQETGUmKagV
         mWESAdTsLFuDoSGtFYsytYxNWywHH3lDwjHTOh97y2h8uD3xm9RnjDMMfQ4Rx5fG9u
         VecrGMg5nre5g==
Received: (nullmailer pid 1158727 invoked by uid 1000);
        Thu, 10 Aug 2023 20:53:28 -0000
Date:   Thu, 10 Aug 2023 14:53:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     luka.perkov@sartura.hr, netdev@vger.kernel.org,
        conor+dt@kernel.org, pabeni@redhat.com, davem@davemloft.net,
        andrew@lunn.ch, krzysztof.kozlowski+dt@linaro.org,
        linux@armlinux.org.uk, hkallweit1@gmail.com, edumazet@google.com,
        linux-kernel@vger.kernel.org, kuba@kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: ethernet-controller: add
 PSGMII mode
Message-ID: <169170077839.1157642.6802176058827678901.robh@kernel.org>
References: <20230810102309.223183-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810102309.223183-1-robert.marko@sartura.hr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 10 Aug 2023 12:22:54 +0200, Robert Marko wrote:
> Add a new PSGMII mode which is similar to QSGMII with the difference being
> that it combines 5 SGMII lines into a single link compared to 4 on QSGMII.
> 
> It is commonly used by Qualcomm on their QCA807x PHY series.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
>  Documentation/devicetree/bindings/net/ethernet-controller.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

