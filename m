Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8477747BC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236018AbjHHTSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234001AbjHHTRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:17:34 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C1A15B82;
        Tue,  8 Aug 2023 09:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=JSalPYVPpeoReg4Iq8lqHGY2AJen49d+C6G8RlQwG5A=;
        t=1691512854; x=1692722454; b=VOxZ3420PwK/Byd8F2qASEK1fuw+x9mHdjY9fOKH7nP56Sa
        SaBPOHPWVugVZL2xHwOfNRtLa/3DS2ky7Hl27vj7k+FokR2I1y1Z4WHxLcCEB8+Q3z61OmDT5N6/x
        O8RqsHOBa/Tn3L9T7fqdhB7ZSLGc0yZFcH0jdSArcKN7/16KGTwAfmGpbQBSQ3TxFg0FgTb1V7Kee
        Bn3ag5vWtpUlhqy53z+R4ngcsnwezXafdRGdM7E/0tlGP2gZThPmrYhFNZryScVgrSe5vXNxB8nle
        AYG5R2ArbK6EQ+v0wnu9jSS/tMGNfj6mFPa07L8F5T/S4hTrLJw2m2eluyDBlvTw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qTIAH-00CRWn-0B;
        Tue, 08 Aug 2023 10:34:05 +0200
Message-ID: <36e36d94e81da4342283aac471fb5a7bd3eb9f65.camel@sipsolutions.net>
Subject: Re: [PATCH] net: wireless: ralink: rt2x00: "foo* bar" should be
 "foo *bar"
From:   Johannes Berg <johannes@sipsolutions.net>
To:     hanyu001@208suo.com, stf_xl@wp.pl, helmut.schaa@googlemail.com,
        kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 08 Aug 2023 10:34:03 +0200
In-Reply-To: <18520fa625b8a901314c65bb8e557091@208suo.com>
References: <tencent_316424AFC531C5F050C0203FDBA08E84F907@qq.com>
         <18520fa625b8a901314c65bb8e557091@208suo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-07-21 at 14:34 +0800, hanyu001@208suo.com wrote:
> Fix checkpatch warnings:
>=20
> ./drivers/net/wireless/ralink/rt2x00/rt2x00.h:386: ERROR: "foo* bar"=20
> should be "foo *bar"
> ./drivers/net/wireless/ralink/rt2x00/rt2x00.h:513: ERROR: "foo* bar"=20
> should be "foo *bar"
>=20
> Signed-off-by: Yu Han <hanyu001@208suo.com>

This patch is broken. I'll just point you to what I wrote before:

https://lore.kernel.org/all/058dd31ef48495f8641f5b66839aaea039af0f08.camel@=
sipsolutions.net/

What _are_ you trying to achieve?!

Currently all you're achieving is annoying everyone with broken (and
pointless submissions).

johannes

