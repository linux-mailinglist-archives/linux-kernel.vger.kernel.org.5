Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54DB280325D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbjLDMTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 07:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjLDMT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:19:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3292FF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 04:19:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B936EC433C8;
        Mon,  4 Dec 2023 12:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701692375;
        bh=Fvcrfz9e4NQGCemkWVBM1zRgk03wa65KH83JIwn21Cc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fQeA7YLo3GrSe21mG092HE9psRQ3BjNWbQ/RBvssCnApYD1i/z7YRLidA3pCnBEHA
         OLENZS+FOy5GgvG8L+nKBKft+i9yGFMwqNdQsMJoJWhrTSEGT+DmT3ayr+0reTTu0k
         9nMjrEa8nx8q3bJDkZJkfwiiY2DLQg7RyqbYz5QNFgUyhief8czFy2+UlMfRS+GctM
         O97IrnKtf6uzMMeSjBz6BiUbTqRSIDWi4oSieTlRP6dcHlp/K9qYZIzb9qdXTkIMa8
         pNqcugB+s4EF5cR6Gwd4JVRRKHgoHMQ5Moi+q/JILnzSMtJ8nwKO5TKE8Ix3nQiAKu
         nmm+BgsFNlJ9A==
Date:   Mon, 4 Dec 2023 12:19:26 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andreas Klinger <ak@it-klinger.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: honeywell,mprls0025pa: drop ref from
 pressure properties
Message-ID: <20231204121926.762cc0a5@jic23-huawei>
In-Reply-To: <20231201223547.GA2615359-robh@kernel.org>
References: <20231129111041.26782-1-krzysztof.kozlowski@linaro.org>
        <20231201223547.GA2615359-robh@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Dec 2023 16:35:47 -0600
Rob Herring <robh@kernel.org> wrote:

> On Wed, Nov 29, 2023 at 12:10:41PM +0100, Krzysztof Kozlowski wrote:
> > The dtschema treats now properties with '-pascal' suffix as standard one
> > and already defines $ref for them, thus the $ref should be dropped from
> > the bindings.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > 
> > ---
> > 
> > dtschema change was merged:
> > https://github.com/devicetree-org/dt-schema/commit/2a1708dcf4ff0b25c4ec46304d6d6cc655c3e635
> > but not yet released as new dtschema version.
> > 
> > This change should be applied once new dtschema version is released or
> > Rob says otherwise.  
> 
> I've made a release, so go ahead and apply this.
> 
> Acked-by: Rob Herring <robh@kernel.org>

Applied to the togreg branch of iio.git and initially pushed out as testing for 0-day
etc to poke at it

Thanks,

Jonathan
