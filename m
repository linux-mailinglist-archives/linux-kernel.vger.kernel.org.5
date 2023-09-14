Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA43A7A03ED
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 14:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238202AbjINMcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 08:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjINMcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 08:32:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBEA1FC8;
        Thu, 14 Sep 2023 05:32:11 -0700 (PDT)
Date:   Thu, 14 Sep 2023 14:32:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694694729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NtoeMAYtT1pDA/kdYki5mXdHPQ69SvqgvVV2GpTEBk4=;
        b=HZgWJ5RCvfi+IzCRvnQwWAvWQjCCeZWI9BHg7yzXYLEL2lcE+zmUncRDM6keAAtOowt1I+
        aHlJQJIrhl4+QjBLu4t1kuawa+YbMU+QJT7AtGMDpXo9zwrtg/HBGFNW81zISOptN3SUYV
        hRk6KLJhNP9Ohmib0kagMNEEXnmpiIDfZ8yoC0QbEjUplIw/3YOTYRYSwtTnkIhGqLQMhB
        /wZHQQWJZF69EKsFNVDjmfnvsOSsTTwpo6dAILir6doxP687Pz89mBMR5hsIfTys3MAQ11
        FDFcXNgIIp3SvRaQFsj2UElzDuEX7FUS9XrOoFKUk3ABTNhVext70M3VFjBHig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694694729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NtoeMAYtT1pDA/kdYki5mXdHPQ69SvqgvVV2GpTEBk4=;
        b=KT6sHr5eMYGNvaSarEI728Ifnlk3QDGEBkQ2KnLMToQTR3uxOSKiJcJYS/PDPx+3Y4xvPp
        ucq8N8OJeiMWUtDA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Tristram.Ha@microchip.com, Eric Dumazet <edumazet@google.com>,
        davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Kristian Overskeid <koverskeid@gmail.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Oetken <ennoerlangen@gmail.com>
Subject: Re: [PATCH] net: hsr : Provide fix for HSRv1 supervisor frames
 decoding
Message-ID: <20230914123205.wGh9uvSm@linutronix.de>
References: <20230825153111.228768-1-lukma@denx.de>
 <20230905080614.ImjTS6iw@linutronix.de>
 <20230905115512.3ac6649c@wsk>
 <20230911165708.0bc32e3c@wsk>
 <20230911150144.cG1ZHTCC@linutronix.de>
 <20230912101828.06cb403d@wsk>
 <20230913163227.ysmJocR0@linutronix.de>
 <20230914142650.6ea1a52f@wsk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230914142650.6ea1a52f@wsk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-14 14:26:50 [+0200], Lukasz Majewski wrote:
> Hi Sebastian Andrzej,
Hi,

>=20
> Yes, this fixes this issue (caused by: SHA1: eafaa88b3eb7f).
> Such solution has also been pointed out earlier by Tristram.

Right, now that I looked at it=E2=80=A6

> I will prepare v2 of this patch.

don't worry, I take care of this.

> Best regards,
>=20
> Lukasz Majewski

Sebastian
