Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B29805C29
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbjLEQQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 11:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbjLEQQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 11:16:33 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73C9194;
        Tue,  5 Dec 2023 08:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=RKrRrfbDzVExGjRFlw/6B2Iit7eMuTg/JB3zmlkq4gs=;
        t=1701792998; x=1703002598; b=C/d+wIBZxB1/OMwYZfOtQUDIpbmr9NxICN01dmaU7kt3dpY
        bglV1QRlV8Z+C7lD1okyaT+REDwdT9CZiwkhgkaF3yTg6I5HudgQuHDxQSY9XnHW7FlCK2KT9lcex
        hmjr9bz6/Gu+NPPYSXIIwdxar048NQoHBNKud1Zb0e4NAmB2kvgf8SjJ8++AohScE0vK1IHeRg+OX
        g7GrTkBTgusm0+v/35wh6wIB9sLM2Lb1j0HuT/zB+RH3ZN+y/ISGA0pUtVtaWGTsrW8EZZFzas29l
        POAapju3lbBcO6U0qEHZtgH2YjDRYR50lm8Hjki81hCqJJRKoxkm3mAwfP4MmuhA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97)
        (envelope-from <johannes@sipsolutions.net>)
        id 1rAY5z-0000000GPJP-0aN0;
        Tue, 05 Dec 2023 17:16:27 +0100
Message-ID: <bf61574349dcb586d70dde237b71206d68142c0c.camel@sipsolutions.net>
Subject: Re: [PATCH 6.6 000/134] 6.6.5-rc1 review
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Arnd Bergmann <arnd@arndb.de>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>, shuah <shuah@kernel.org>,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        Pavel Machek <pavel@denx.de>,
        Jon Hunter <jonathanh@nvidia.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        srw@sladewatkins.net, rwarsow@gmx.de,
        Conor Dooley <conor@kernel.org>, allen.lkml@gmail.com,
        Netdev <netdev@vger.kernel.org>, linux-wireless@vger.kernel.org
Date:   Tue, 05 Dec 2023 17:16:25 +0100
In-Reply-To: <ce99918f-eb6a-4ad7-aa44-9d27c27b6b00@app.fastmail.com>
References: <20231205031535.163661217@linuxfoundation.org>
         <CA+G9fYuL_-Q67t+Y7ST5taYv1XkkoJegH2zBvw_ZUOhF9QRiOg@mail.gmail.com>
         <ce99918f-eb6a-4ad7-aa44-9d27c27b6b00@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 (3.50.1-1.fc39) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-12-05 at 17:13 +0100, Arnd Bergmann wrote:
>=20
> I have not yet figured out what gcc-8 complains about,
> but I assume that gcc-13 would find the same thing with
> the check enabled.
>=20

See this thread:

https://lore.kernel.org/r/202311301016.84D0010@keescook

johannes
