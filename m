Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5FA7E1069
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 18:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjKDQ3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 12:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjKDQ3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 12:29:48 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16722184;
        Sat,  4 Nov 2023 09:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=yCYL0GASPtG8T7qQideTBE8ESvDodasXDb+JBu/q0so=;
        t=1699115385; x=1700324985; b=ilBijxMSoBO2YJLkJPpyQq7B9cVsYU7TQhVCyVyWwT2RK27
        W722PAesDjzbDZgYYoVA7jwzXrgWwobs/iccEgoQY+4B/si5IpWLLehLtRfYnYAwunqZRFNjnrLfa
        hsBfNUfU9zwXiPk6hCeffy8qBj7LWbR6bzM8LCgBSqh5UAY+kvuv8t87uU1v7pDesPL0qCSzjNVSs
        Jp62sL+xGOBkJZnux1nJ5kWmFNGaLPg/xpSYrDfaF0I4Qw68a4n/nhgIgon/RD/nf89AbZFB7croQ
        6uvJ5xsrYn1dLVQrxX9pJmQDrrsh06INPeMyBgaPWyIwj1aSFcyBkNWLlwysrBfQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97-RC1)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qzJWd-0000000DYVU-3kxG;
        Sat, 04 Nov 2023 17:29:32 +0100
Message-ID: <e30db424aeeaf3f8594f7ff023a52fbdd5bc4ae5.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: cfg80211: Fix use-after-free bug in
 brcmf_cfg80211_detach
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Zheng Wang <zyytlz.wz@163.com>, aspriel@gmail.com
Cc:     franky.lin@broadcom.com, hante.meuleman@broadcom.com,
        kvalo@kernel.org, marcan@marcan.st, linus.walleij@linaro.org,
        jisoo.jang@yonsei.ac.kr, linuxlovemin@yonsei.ac.kr,
        wataru.gohda@cypress.com, linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, linux-kernel@vger.kernel.org,
        security@kernel.org, stable@vger.kernel.org
Date:   Sat, 04 Nov 2023 17:29:30 +0100
In-Reply-To: <20231104054709.716585-1-zyytlz.wz@163.com>
References: <20231104054709.716585-1-zyytlz.wz@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2023-11-04 at 13:47 +0800, Zheng Wang wrote:
>=20
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 3 +++
>=20

Nothing to do with cfg80211, please fix the subject.

johannes
