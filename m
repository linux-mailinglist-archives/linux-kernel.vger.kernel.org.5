Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9657B7F03BB
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 01:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjKSABk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 19:01:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjKSABh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 19:01:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255B4E6
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 16:01:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2D6AC433C8;
        Sun, 19 Nov 2023 00:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700352093;
        bh=UswlqZPwAXhTVxY1YgDFPc5Vs0O4sCxJ8Ap4WTkwVQQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=S4Yar2rvVJuDvkoohWoSJKHh/LK0FgcdewDPwXy0WE4R9Q6vN4qfhvuiPPNQIDpGo
         B23Kimu4pjHY3pADAmNV9MWxa3blPGP4XbdsU+tVfrdx+LfvA97GsCVN4uOZ/sDaFo
         waSxbqenZaRyqQPibezzgg957pTDQHSYn89yfhbJ7u2DjYASsPjttl/wG14oBWpq9R
         Jvo1LnlPt0mONssTAOfZT4HrL0XSZ7b4SmbEc4tXtQCImrsvADfQ+w9EqKqxgYl/Z2
         e+nEnwM8hpQR74QvBjOqMOhsOmjzhj+RLR0yN9IXW5V++4CpiZkGDf+i5Xht1ODn3e
         Gdilz/nSnwOQQ==
Date:   Sat, 18 Nov 2023 16:01:31 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Kory Maincent <kory.maincent@bootlin.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russ.weight@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 6/9] netlink: specs: Expand the pse netlink
 command with PoE interface
Message-ID: <20231118160131.207b7e57@kernel.org>
In-Reply-To: <20231116-feature_poe-v1-6-be48044bf249@bootlin.com>
References: <20231116-feature_poe-v1-0-be48044bf249@bootlin.com>
        <20231116-feature_poe-v1-6-be48044bf249@bootlin.com>
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

On Thu, 16 Nov 2023 15:01:38 +0100 Kory Maincent wrote:
> +        name: pse-admin-state
> +        type: u32
> +        name-prefix: ethtool-a-
> +      -
> +        name: pse-admin-control
> +        type: u32
> +        name-prefix: ethtool-a-
> +      -
> +        name: pse-pw-d-status
> +        type: u32
> +        name-prefix: ethtool-a-

The default prefix is ethtool-a-pse-
Why don't you leave that be and drop the pse- from the names?
