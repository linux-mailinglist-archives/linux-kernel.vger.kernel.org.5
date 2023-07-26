Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286B0763B4D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 17:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234398AbjGZPkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 11:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234333AbjGZPkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 11:40:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445A626BB;
        Wed, 26 Jul 2023 08:40:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE11D61B54;
        Wed, 26 Jul 2023 15:40:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E5C6C433C7;
        Wed, 26 Jul 2023 15:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690386003;
        bh=wpAk9eVRkO3m5yXAXAX/GMvTJFrvAOQChp70gooG/Ek=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CGiz0wSdqSzSeULBwoxHkD2IpHoH2HI4Kc9jKrtFIShwBmu/gus7rZf6vjVQqVUEf
         7+EUM2FVhKtVDvqnz2463f1vK3YXASSyg4JM5v2vFbg2+da6jVP+koG6KWkl/Z7BQ3
         bWKd9sJNSvSPANGWWkxEprhl+N1RX59dFgQ10IkLgPx3Jhwn2Cd6CtQWbZ5e8ScbFo
         PiTOeaZOZqf1CQXeAE4otjL0E5CqkOKvbCW4yrmiq4UJDr3rFzdmhKoV7vp2sKra3M
         DuXJhGdwv4p9uJMtpxDBrZHe1TunDFbdc0SeLZlRfVToM9NHl+MVtObv5JMJ/im5o/
         bBnOAclht3iZQ==
Date:   Wed, 26 Jul 2023 08:40:01 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Md Danish Anwar <a0501179@ti.com>
Cc:     Simon Horman <simon.horman@corigine.com>,
        MD Danish Anwar <danishanwar@ti.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Roger Quadros <rogerq@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Richard Cochran <richardcochran@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>, nm@ti.com, srk@ti.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [EXTERNAL] Re: [EXTERNAL] Re: [PATCH v11 03/10] net: ti:
 icssg-prueth: Add Firmware config and classification APIs.
Message-ID: <20230726084001.0758feaf@kernel.org>
In-Reply-To: <ZMDOWecss/9F+0nb@corigine.com>
References: <20230724112934.2637802-1-danishanwar@ti.com>
        <20230724112934.2637802-4-danishanwar@ti.com>
        <ZL94/L1RMlU5TiAb@corigine.com>
        <b2016718-b8e4-a1f8-92ed-f0d9e3cb9c17@ti.com>
        <ZL99WfF7iuzeMP78@corigine.com>
        <5a4b293f-7729-ee03-2432-cd49ff92d809@ti.com>
        <ZMDOWecss/9F+0nb@corigine.com>
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

On Wed, 26 Jul 2023 09:42:17 +0200 Simon Horman wrote:
> Thanks for splitting things up into multiple patches.
> I know that is a lot of work. But it is very helpful.

+1, definitely much easier to review now!
