Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245EE76D76D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 21:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbjHBTID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 15:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232829AbjHBTH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 15:07:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D23B26AB;
        Wed,  2 Aug 2023 12:07:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC5A461A77;
        Wed,  2 Aug 2023 19:07:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB702C433C8;
        Wed,  2 Aug 2023 19:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691003277;
        bh=AtabSoCTmU8/gWEDdjyX6211qOFN6BSOTGhR7bMY0ig=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uG60NkW2sVNNoCgmVljzbKIqaaCndo0+LoUA9LyH+ahPeBLd6j0WsjnQvHZt64tq9
         nl6/tnKgCaV7u1OP+OfMFyR0P+eJybajhDshnI6pqBQg0+Ua20xmg1lGfg4rftWU82
         Ux2ClcMrTJcfraExKcTtAwQg1iW29Yp/GbLfLq04UVuInIdEQ55jHpjDhTtdw96cjB
         cJ8DztYRdOLkd9lk9z348dgmFKdyhJKQFEyxsvPyJ7+ey0UC/5NcAq0SxI+9W6ei08
         xvdB/irCh2tXltdZkqzGwUDDM2/xNwVA60ynt4k1nUAyF7D+05nC2mIoiRYr4HNMUQ
         fP1YDJOYEEHyQ==
Date:   Wed, 2 Aug 2023 12:07:55 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Max Staudt <max@enpas.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 2/2] net: nfc: remove casts from tty->disc_data
Message-ID: <20230802120755.10849c9a@kernel.org>
In-Reply-To: <20230801062237.2687-3-jirislaby@kernel.org>
References: <20230801062237.2687-1-jirislaby@kernel.org>
        <20230801062237.2687-3-jirislaby@kernel.org>
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

On Tue,  1 Aug 2023 08:22:37 +0200 Jiri Slaby (SUSE) wrote:
> tty->disc_data is 'void *', so there is no need to cast from that.
> Therefore remove the casts and assign the pointer directly.

Which tree are these expected to flow thru?
