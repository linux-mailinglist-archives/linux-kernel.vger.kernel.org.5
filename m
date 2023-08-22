Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900E07837BF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 04:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbjHVCHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 22:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbjHVCHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 22:07:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E401CD1;
        Mon, 21 Aug 2023 19:07:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6674C632B3;
        Tue, 22 Aug 2023 02:07:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B89C433C8;
        Tue, 22 Aug 2023 02:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692670054;
        bh=BXif2ZDawun47IOKfLhj4S7BpMJpIaoTJhgi8oGmLek=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jV6fqwsp148gdiGN8tYn7z8S9oY70wEjuHPgKS2Cw5CBCy1doN13UZBv9hPBJKLBH
         3cIq3CO3772DJZp766/VTIoKwvFjFWlGntWjVNyItRGgfdWrWAf3yVZXHKnmeDMuFz
         bl0FMla3d6UCxJLCPu1JpYEHdwRUMkcpwFCUf5Oj5xvabz2NYP6cypU4w8P5/C+sNK
         Eviz8uU3d3zfqGsAjDYV6dMCm3O4mM6izFfSswPj8S5+9F30v+WfclK5rUPtCi0hKf
         ETDN1BmgYW7hLflr7ZTR8D0A4j3Hgp6KjeMHT4ggfmAQjXJkCmXJZ3YQSWS/FBnOwN
         LgycsJPgIwxxQ==
Date:   Mon, 21 Aug 2023 19:07:32 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Richard Cochran <richardcochran@gmail.com>
Cc:     MD Danish Anwar <danishanwar@ti.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Roger Quadros <rogerq@kernel.org>,
        Simon Horman <simon.horman@corigine.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>, <nm@ti.com>, <srk@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v5 0/5] Introduce IEP driver and packet timestamping
 support
Message-ID: <20230821190732.62710f21@kernel.org>
In-Reply-To: <20230817114527.1585631-1-danishanwar@ti.com>
References: <20230817114527.1585631-1-danishanwar@ti.com>
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

On Thu, 17 Aug 2023 17:15:22 +0530 MD Danish Anwar wrote:
> This series introduces Industrial Ethernet Peripheral (IEP) driver to
> support timestamping of ethernet packets and thus support PTP and PPS
> for PRU ICSSG ethernet ports.

Richard, let us know if you'd like to TAL or we're good to apply.
