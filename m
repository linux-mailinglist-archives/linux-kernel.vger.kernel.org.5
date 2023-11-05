Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7F67E1775
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 23:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjKEWyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 17:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKEWyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 17:54:20 -0500
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BC083
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 14:54:18 -0800 (PST)
Received: from [192.168.68.112] (ppp14-2-79-67.adl-apt-pir-bras31.tpg.internode.on.net [14.2.79.67])
        by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 35BAC20075;
        Mon,  6 Nov 2023 06:54:10 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeconstruct.com.au; s=2022a; t=1699224856;
        bh=uvcG7XUq7kcchLFjTcoSzVGDORe43gAmB+aXl1uvM7c=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=C0JxkAnoN6Bx7JDe8KHAqObKbg+REKWdBJdEDZp2b1kOz4KcE8y0xl1pDZOe8keP2
         NX4UuhhYpiKrv+WuMk+9YiXTn9UJ/yzNjiO8rDBubJyLymOmen14lWu7Vbr9kbkPbr
         x+4cpFEzX1d9Y+JvfKHQDHWTpxPEZYnPvYZ6Oj7aG3Lrrk1JWsKCJkP8EnKYOBsoLP
         BqeA08DGq+0vJugUfjqHUsVVGyDCWBLDBqt3D/bqe6Wue2WAGg6gXlxkWGwns3OL4k
         mLPs3qDBmdJNnT3qxuRjzzRZEypBF1lpQIr36MRvU0JIWPPSy8NEK3QGwZUZdUiNtJ
         1tG8Vb9SBhOyA==
Message-ID: <61daa1c69836caffd63e3c2d9bb2e62298f1a04a.camel@codeconstruct.com.au>
Subject: Re: [PATCH 04/10] ipmi: kcs_bmc: Make remove_device() callback
 return void
From:   Andrew Jeffery <andrew@codeconstruct.com.au>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     minyard@acm.org, openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, aladyshev22@gmail.com,
        jk@codeconstruct.com.au
Date:   Mon, 06 Nov 2023 09:24:10 +1030
In-Reply-To: <20231103144311.000008f1@Huawei.com>
References: <20231103061522.1268637-1-andrew@codeconstruct.com.au>
         <20231103061522.1268637-5-andrew@codeconstruct.com.au>
         <20231103144311.000008f1@Huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-11-03 at 14:43 +0000, Jonathan Cameron wrote:
> On Fri,  3 Nov 2023 16:45:16 +1030
> Andrew Jeffery <andrew@codeconstruct.com.au> wrote:
>=20
> > Don't pretend there's a valid failure path when there's not.
> >=20
> > Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
>=20
> Whilst I agree returning an error code is pointless, it is perhaps
> useful to make sure there is a dev_err() or similar in the paths
> now that you've remove the one at the call site.
>=20
> Minor point and up to you if you want to or not.

No, that's reasonable. I'll address this in v2.

Andrew
