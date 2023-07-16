Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43CE275529D
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 22:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbjGPUJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 16:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbjGPUJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 16:09:53 -0400
X-Greylist: delayed 1312 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 16 Jul 2023 13:09:51 PDT
Received: from hall.aurel32.net (hall.aurel32.net [IPv6:2001:bc8:30d7:100::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CD89B;
        Sun, 16 Jul 2023 13:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
        ; s=202004.hall; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Reply-To:
        Subject:Content-ID:Content-Description:X-Debbugs-Cc;
        bh=bFvTW3Yd75y+NV7uvVkN7aJtnUibmYPb1BvWy4H8H44=; b=MzxXa9UDH9iTVZHrPCYBXP29gr
        3DFhgIGuBisHzO6iic7qwrsy3fQ3DIHWhv9q6KRW0y10iAcI6SamH/wg7VOG4dRAzkw1JqiBO5uA4
        ihGNLGx9iNMV4Vwq2/Y6iApxg1k/gfbnfMnH/s4oAzp5SjIkirRFsAgtNysUBwXTIZVFQZqdSeoqS
        wz+PVhyBJFpybKVHy1VLLW7TJN7gBY1ywyy6PZcyODWFWJA8wReDbs31rfH5xOQkBy6LI/4Mj6TUP
        K/CLVPc5iDlzgkKZIMGYVa0ve29YbbcJuselLKSsUwZz4USnDgmVv1vTLk8MbE0c0X8L/IKfwE0cn
        d4Xg3g3A==;
Received: from [2a01:e34:ec5d:a741:8a4c:7c4e:dc4c:1787] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <aurelien@aurel32.net>)
        id 1qL7ik-009yRM-Pd; Sun, 16 Jul 2023 21:47:54 +0200
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.96)
        (envelope-from <aurelien@aurel32.net>)
        id 1qL7ik-008uSg-0U;
        Sun, 16 Jul 2023 21:47:54 +0200
Date:   Sun, 16 Jul 2023 21:47:54 +0200
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Backporting commits for generating rpi dtb symbols to stable
Message-ID: <ZLRJaiIfPtqEB9Vb@aurel32.net>
Mail-Followup-To: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230716162444.zzvkm4rh7s7lu37x@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230716162444.zzvkm4rh7s7lu37x@pali>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023-07-16 18:24, Pali Roh=C3=A1r wrote:
> Hello,
>=20
> I see that raspberry pi bootloader throws ton of warnings when supplied
> DTB file does not contain /__symbols__/ node.
>=20
> On RPI 1B rev1 it looks like this:
>=20
> dterror: no symbols found
> dterror: no symbols found
> dterror: no symbols found
> dterror: no symbols found
> dterror: no symbols found
> dterror: no symbols found
> dterror: no symbols found
> dterror: no symbols found
> dterror: no symbols found
> dterror: no symbols found

Do you have those errors with the default configuration? On a RPI 4,
this only happens when setting uart_2ndstage to 1 in config.txt.
According to the documentation, this option enables diagnostic
information from the main firmware.

Unless this is different on RPI 1B, this means we are talking about a
warning that happens when enabling diagnostic information, so I am not
sure it warrants a change to stable kernels.

Regards
Aurelien

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net
