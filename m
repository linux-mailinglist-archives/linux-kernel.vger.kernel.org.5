Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49CA7B5845
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238464AbjJBQQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 12:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238458AbjJBQQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 12:16:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBF59E
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 09:16:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3341BC433C8;
        Mon,  2 Oct 2023 16:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696263405;
        bh=lDvldFCWk2idedyrSgHG4u7/zWcFe+Xb56KnYgWD1Ok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F4BtuvX3F1ntIptvwM7mKdBk2zeRrUy6L9xiALEOoOG9SOAlFExYYUbjC6Oe0EQQJ
         6i+YmwYxbMaDqlSrMAWo1H6ml5o0DQQaUv8+Qpr1uvqgIOanyWcFiiLzokC7i3lGn1
         qOtUHPkJs2JEeyBXBa2pcNFt+j2Mj++YrOS1E3D06aXrBeq28yIDGtsfjR127+P2A0
         MZa2E0QoQfnQwIWxZcJ6p9w3xZJkJooZS5nNwuFCdUg/T1nesNjbCJdrEhEHBp8Clb
         cNfwHgVaU+vl2VuZ5KjGk+Mk8iJeivmq4WdYCf9vEAoCIi/sPia7KNAdSeiJN7zNjW
         pnpV6rrknMppQ==
Received: (nullmailer pid 1885250 invoked by uid 1000);
        Mon, 02 Oct 2023 16:16:43 -0000
Date:   Mon, 2 Oct 2023 11:16:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Lee Jones <lee@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v4 04/12] regulator: dt-bindings: mt6358: Add regulator
 supplies
Message-ID: <169626340260.1885194.4720375759009776410.robh@kernel.org>
References: <20230928085537.3246669-1-wenst@chromium.org>
 <20230928085537.3246669-5-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928085537.3246669-5-wenst@chromium.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 28 Sep 2023 16:55:27 +0800, Chen-Yu Tsai wrote:
> The MT6358 PMIC has various regulator power supply pins that should be
> supplied from external power sources or routed from one of its outputs.
> 
> Add these regulator supplies to the binding. The names are the actual
> names from the datasheet, with hyphens replacing underscores.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>  .../regulator/mediatek,mt6358-regulator.yaml  | 34 +++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

