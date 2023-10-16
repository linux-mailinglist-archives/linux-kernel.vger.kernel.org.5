Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01FFD7CAA65
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 15:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbjJPNt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 09:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234196AbjJPNsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 09:48:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB03128;
        Mon, 16 Oct 2023 06:48:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1EB8C433C7;
        Mon, 16 Oct 2023 13:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697464104;
        bh=mp6Ing2YjlDv1+wriMn3sVvWUPfFi63z7zsEQ3CoIrw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dweae+LnGibLZesbVnqLLBumRbUyfz206BCR1yQZqc8RdVV21FzYK8n7v+ymThCF2
         I/klQuyMWVsm4BRTvm4rwgXbI3/7Cbly2L/gz2MURSY0akDWuDgNIQbykAsa1wigZZ
         LHJOYY5xOdwK2OKSzpTVT1x9nOMwiUHTdGa5qY9tRPgj3HWxx4Hiu/tXFCJJCU17pG
         r9wbcDpAm4VKxKlxT5WQmM3N3JwnMcrmmxFW7yYSatTSHJx+8sHSfgCdsKTPzp+P2z
         d5zmoSHwBpItr1h3emi6v6s+5B2h6e+Q+5PSP8i4FGD2fyYnpRlWSHerskiVQ5MyHE
         QMGNBy2Z6kYjA==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qsNsp-0004Di-2T;
        Mon, 16 Oct 2023 15:43:48 +0200
Date:   Mon, 16 Oct 2023 15:43:47 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: gnss: u-blox: add "reset-gpios"
 binding
Message-ID: <ZS0-E_h4I_g7zVIm@hovoldconsulting.com>
References: <20230921133202.5828-1-wsa+renesas@sang-engineering.com>
 <20230921133202.5828-3-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921133202.5828-3-wsa+renesas@sang-engineering.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 03:32:00PM +0200, Wolfram Sang wrote:
> Needed to enable this chip on a Renesas KingFisher board.

What is needed? Please make the commit message self-contained.

And what GNSS chip/module is this? This should also be included in the
commit message.

Do you have a link to a datasheet?

None of the u-blox modules I've seen have a reset line so I'd like to
where this came from and how it is intended to be used.

> Description
> copied over from the Mediatek driver which already supports it.

The mediatek driver does not support managing a reset line, but the
binding includes a description of this pin for completeness. Also you
don't seem include any description of the property below (which is fine)
so perhaps you can just drop this sentence.

Johan
