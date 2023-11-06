Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC057E303A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 23:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbjKFW6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 17:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbjKFW6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 17:58:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8AC110D
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 14:58:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7D48C433C8;
        Mon,  6 Nov 2023 22:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699311488;
        bh=H4Iv+P8YcX9rpNXz0/hou29NDLB8x17itHwPVgURl84=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=o3YfLs/FFCiDmnxlSt62WZUBU7k8dKh09DuUoSLUbbuS6E8Z3ow0CQCg4BC1Uo3Bw
         iyB82LSNEezfoCzBFhlJRZw/GPKO9FQWhn7e66Fk1BfajOx8bbgjlHNSDtFdwgYP86
         zOAbt9sDeUDtKyPNasHarCKON2Qmo+x9yLaaLdM3sD1EqZlU7A+3xm4ugeaF2NdkVn
         o+Iq1BPCjY3C6x1uakcGt4QX1WSqxAwycxnIHVBbpXl+7xb6Zxz9W83QeVgDa3V6pJ
         z2qm2diAZix3G2K/7oVJ9GcUov95FqXrLraEZt7Fo3mISMhxqw8ydckhqyClKREnAL
         34O8WAJS8Kp0g==
Date:   Mon, 6 Nov 2023 14:58:06 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Julia Lawall <Julia.Lawall@inria.fr>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Justin Chen <justin.chen@broadcom.com>,
        Paolo Abeni <pabeni@redhat.com>,
        bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, cocci@inria.fr,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: bcmasp: Use common error handling code in
 bcmasp_probe()
Message-ID: <20231106145806.669875f4@kernel.org>
In-Reply-To: <0b2972cb-03b2-40c7-a728-6ebe2512637f@web.de>
References: <0b2972cb-03b2-40c7-a728-6ebe2512637f@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Nov 2023 17:33:46 +0100 Markus Elfring wrote:
> Add a jump target so that a bit of exception handling can be better
> reused at the end of this function.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/net/ethernet/broadcom/asp2/bcmasp.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

The diffstat proves otherwise. 
Please don't send such patches to networking.
