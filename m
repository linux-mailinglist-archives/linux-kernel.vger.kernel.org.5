Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48D676B4B5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 14:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbjHAM0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 08:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbjHAM0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 08:26:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316BE1FCA;
        Tue,  1 Aug 2023 05:26:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFEAE61589;
        Tue,  1 Aug 2023 12:26:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E09C433C8;
        Tue,  1 Aug 2023 12:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690892778;
        bh=z/nyCG9+MiNrNRu+oLH9pPDpearklCL8X59wA3OOsig=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DvLJYuFJyi9SsFp6dSCCzCzzm8WudEuZYex8cFrrT+MrsngbA/QSrMpZbr1D695v/
         r5dapol6Bij4T7cZB4M1ALVbhlPAFGyiuNpfLyW/qwO7Tq03g518FWHBCpdtMKZFnK
         X7XLjJ/6yFBdud6bBh2k/Q2d4k28SXK8wEUHyqc4B+h6WPLu1xgkXysxKi+cVPVrIa
         w1KIlmTnZ3oFYHjEVj/fmwAmR5sf7VU8g7/l/61TYJmBPJMFMzI3Xx6dG96WgYdUaH
         qqCVP3u6BSvGj7+4qYXGvPT7dz6XCCJ/3Erdf8uI0/JW0tUQVuqcOdcXFmSbMIz96P
         iT0qvGAT2dS5g==
Date:   Tue, 1 Aug 2023 14:26:13 +0200
From:   Simon Horman <horms@kernel.org>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Max Staudt <max@enpas.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 2/2] net: nfc: remove casts from tty->disc_data
Message-ID: <ZMj55RwhJV2ATs66@kernel.org>
References: <20230801062237.2687-1-jirislaby@kernel.org>
 <20230801062237.2687-3-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801062237.2687-3-jirislaby@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 08:22:37AM +0200, Jiri Slaby (SUSE) wrote:
> tty->disc_data is 'void *', so there is no need to cast from that.
> Therefore remove the casts and assign the pointer directly.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>

