Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEDBC7709E0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 22:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjHDUlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 16:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHDUlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 16:41:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B47E48;
        Fri,  4 Aug 2023 13:41:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E494620A7;
        Fri,  4 Aug 2023 20:41:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A17BC433C8;
        Fri,  4 Aug 2023 20:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691181677;
        bh=LbRMeJd1Y/h/HbikMxpBiOVXW7SKMN2sCPKnVjV0j68=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=K+X8KbPfkqubWWb+C/tz4HaBorGHtpr8xeT/DMoq+etQNRJ6Z4OXZUHpnj0vELFmv
         lisJFr4yYOntv5TrH01aaRzWM6GcEqAg9CoNPDcFIA5OSpMWPqq9kcl1o9Kd/jsIoU
         jAFeD1qqt3KHV6xNGSPRFyMA/xiSlphsJu5c/Z3p4kPMw2XT6XtYyFCBjT0NHmmc2/
         X6rVG1Gmt9Ry/G6FNdeyKHppKhoOfGqbE22G5hdZRzX17pOhZPqO/lT2ar/LDdl5v6
         s8EwJ2dL6E0yV2Wx2KGYDi/vhsEHueG+iNBUiI15EEaKnO534265bVryuLpbNAk9S4
         GffVOW0JwIfIA==
Date:   Fri, 4 Aug 2023 13:41:16 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Gerd Bayer <gbayer@linux.ibm.com>
Cc:     Wenjia Zhang <wenjia@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>,
        Tony Lu <tonylu@linux.alibaba.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        "D . Wythe" <alibuda@linux.alibaba.com>,
        Wen Gu <guwen@linux.alibaba.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/2] net/smc: Fix effective buffer size
Message-ID: <20230804134116.6a1c7f40@kernel.org>
In-Reply-To: <c493ef8fa5b735fe32be0c720be77db18e660dfb.camel@linux.ibm.com>
References: <20230804163049.937185-1-gbayer@linux.ibm.com>
        <c493ef8fa5b735fe32be0c720be77db18e660dfb.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Aug 2023 18:55:26 +0200 Gerd Bayer wrote:
> this should have gone as v3 against "net" instead of "net-next".
> Resending ASAP.
> 
> Sorry for the noise,

Less apologizing more reading of the rules, please.

https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
