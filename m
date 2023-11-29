Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109AA7FCC5C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 02:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjK2BbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 20:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjK2BbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 20:31:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E88AF5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 17:31:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7F8AC433C8;
        Wed, 29 Nov 2023 01:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701221472;
        bh=3caMJWJeVZjBQlyKic+6DCHNZavxkUt0zeNOwgUSrSE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TR7LDDkVbXOW8SzNakJv84D/UX1XWnaooE31BQPE49tzM71ucT4w0ovTmNEtsLUZg
         OlTtZSj1dXT9W9ytswDB5k6LSeblH50zZ3GpnLBWXRXayh/Ae/LWaAgT+oMYv2+kmB
         M/SG7UW9pMOaPLs2rKdxLDSSOE9xZulN2mm4FmOfVkm97FY38kHRbCAc0IGl7OkRni
         gfLJM33vVsLzJSsgDYPptivlQzizJgVEUv/+DWbfbFUK6pNBiJuctfYWzyGZgRkRLv
         ftlSjLr/r25wae6EY0swOzXjnbiCarR7NYKcRweo+AKhVDAeR9GzSGshX1Lr7Ux+XK
         4dPmgIhbiPHbw==
Date:   Tue, 28 Nov 2023 17:31:10 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Herve Codina <herve.codina@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 0/5] Add support for framer infrastructure and PEF2256
 framer
Message-ID: <20231128173110.0ccb8f53@kernel.org>
In-Reply-To: <CACRpkdYmN4318b1wXwUOeFjPN0S2w8M9FpXHOs3LtFa+XoTxVw@mail.gmail.com>
References: <20231128132534.258459-1-herve.codina@bootlin.com>
        <17b2f126-f6a4-431c-9e72-56a9c2932a88@sirena.org.uk>
        <CACRpkda5VMuXccwSBd-DBkM4W7A1E+UfZwBxWqtqxZzKjrqY4A@mail.gmail.com>
        <511c83d1-d77f-4ac0-927e-91070787bc34@sirena.org.uk>
        <CACRpkdYmN4318b1wXwUOeFjPN0S2w8M9FpXHOs3LtFa+XoTxVw@mail.gmail.com>
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

On Tue, 28 Nov 2023 15:51:01 +0100 Linus Walleij wrote:
> > > I thought this thing would be merged primarily into the networking
> > > tree, and I don't know if they do signed tags, I usually create an
> > > immutable branch but that should work just as fine I guess.  
> >
> > Right, I'd expect a signed tag on the immutable branch - it's generally
> > helpful to avoid confusion about the branch actually being immutable.  
> 
> Makes sense, best to create that in the netdev tree if possible
> I guess.

I think you offered creating the branch / tag in an earlier reply,
that's less work for me so yes please! :)

FWIW I usually put the branches / tags in my personal k.org tree.
I don't wanna pollute the trees for the $many people who fetch
netdev with random tags.
