Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0EA77D94C2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 12:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345708AbjJ0KIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 06:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345688AbjJ0KIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 06:08:31 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B871B3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 03:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1698401304;
        bh=c28pYpxArbyuEZ2myHRe2r61OyOEVKqZGscrreOAgrw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=pVDSTwk+eBFUGccmdM4XYl8JcWr3yHuoEMxytyDIaujDI0NTCs4SyAYnTcFLSe3BM
         VTqiMb9qhDEWx3OQDKwBxDUyMEnPcuWW0Z9VUjvAKg1sL74cZtJLycA4fAKjXlQeBm
         du8YetvS0+5ODVNIyDrVw85pH8K3J4s/IqRqCNtgaD3izgRGTUt86hFY23Kb5uZ4u2
         fWVgTkEWXcWKVU719YvfMBfOjcT6RlMzNPdlt8OivhMmZeqWOOqNwMqr2y2y0MGlPZ
         jWbmWFL9dNbtGgv6B/OjjoTnb0r1lorK7tmTFEvMI+owBZyZXDLnW5pQI2eEKJ1rWe
         oyNu9KrqhgJkg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SGyzX65MGz4xWs;
        Fri, 27 Oct 2023 21:08:24 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rob Herring <robh@kernel.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231006214516.340589-1-robh@kernel.org>
References: <20231006214516.340589-1-robh@kernel.org>
Subject: Re: [PATCH] powerpc: fsl_msi: Use device_get_match_data()
Message-Id: <169840079684.2701453.6831560645739429965.b4-ty@ellerman.id.au>
Date:   Fri, 27 Oct 2023 20:59:56 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Oct 2023 16:45:16 -0500, Rob Herring wrote:
> Use preferred device_get_match_data() instead of of_match_device() to
> get the driver match data. With this, adjust the includes to explicitly
> include the correct headers.
> 
> 

Applied to powerpc/next.

[1/1] powerpc: fsl_msi: Use device_get_match_data()
      https://git.kernel.org/powerpc/c/89f17016a85280e1b36a6c0305e0191594cbe6ea

cheers
