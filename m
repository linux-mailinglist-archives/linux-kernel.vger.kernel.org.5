Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C940802744
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 21:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjLCUZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 15:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjLCUZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 15:25:50 -0500
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98EB3B8;
        Sun,  3 Dec 2023 12:25:56 -0800 (PST)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
        t=1701635155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mWJ+aNdDgla6aB8RfWwYvr7B5kGqGCRxqh6xKbSq2wc=;
        b=PVR0CCV1WRc971ftwf+fTnXvVPx9DB7HXgFoRLGzcnfa4K5fnch4TEMseMxptkpcKSEKZN
        wGstlWhvUlT0yKzlPJG/ytbfQIzn+nkyRAmIpRK+Mo7YCMKn3LaVElBpqW01N+iZWreVlo
        U6F0t1DevvvJBTYe7uvafeYl8ebUbFjeJXzBik1Y4gCgqz/dnIpa9RsATQIMWRgV6gpfOr
        e87Fq2YjDXArbOJscUyA6s4lZc9lGsqUlK8V4amOLod0sYbJpE3OYL3uszJpVI9tSqBTux
        yChagRYXgjU2tWdJSaXom91KIuRMtnVDJD1L6KBb8IV1Xi3gcvuEciJ1WM7Z8w==
Date:   Sun, 03 Dec 2023 21:25:54 +0100
From:   Dragan Simic <dsimic@manjaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Andrew Davis <afd@ti.com>,
        Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Chen-Yu Tsai <wens@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Simek <michal.simek@amd.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Nishanth Menon <nm@ti.com>, Olof Johansson <olof@lixom.net>,
        =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        workflows@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4] docs: dt-bindings: add DTS Coding Style document
In-Reply-To: <20231203174622.18402-1-krzysztof.kozlowski@linaro.org>
References: <20231203174622.18402-1-krzysztof.kozlowski@linaro.org>
Message-ID: <2223b302fc43959a61578aae9cc3a15a@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +Order of Properties in Device Node
> +----------------------------------
> +
> +The following order of properties in device nodes is preferred:
> +
> +1. compatible
> +2. reg
> +3. ranges
> +4. Standard/common properties (defined by common bindings, e.g. 
> without
> +   vendor-prefixes)
> +5. Vendor-specific properties
> +6. status (if applicable)
> +7. Child nodes, where each node is preceded with a blank line

Another small suggestion...  It would be good to put the property names 
found in the list items, such as "compatible" and "status", into 
quotation marks, to make it obvious what they are.  That way, the list 
would also be more consistent with the property names mentioned in the 
sentence right below.

> +
> +The "status" property is by default "okay", thus it can be omitted.
> +
> +The above-described ordering follows this approach:
> +
> +1. Most important properties start the node: compatible then bus 
> addressing to
> +   match unit address.
> +2. Each node will have common properties in similar place.
> +3. Status is the last information to annotate that device node is or 
> is not
> +   finished (board resources are needed).
