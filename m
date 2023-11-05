Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDBEF7E17C6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 00:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjKEXCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 18:02:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKEXCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 18:02:05 -0500
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADB5B3
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 15:02:02 -0800 (PST)
Received: from [192.168.68.112] (ppp14-2-79-67.adl-apt-pir-bras31.tpg.internode.on.net [14.2.79.67])
        by mail.codeconstruct.com.au (Postfix) with ESMTPSA id A739120075;
        Mon,  6 Nov 2023 07:02:00 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeconstruct.com.au; s=2022a; t=1699225321;
        bh=04hJQYLWQCJ4CRv9lZP5YG9RTCflGKtfQuIl4H68cJI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=CQY/Yg8tFzkQ/t8U2VI16F8ktZiHrqYp9yZeDdh9PWOedddtBl79Pc7c4BlxqT7v2
         GsFrlEGexwSYOP9ozh8142zA5HL2cTdQcza5TUEPGK1/P8AmU8d7bA7elx40t8zGna
         m/U4svtuVn+5ea/jsEAy9hkO8GTo/u+jRfdwPTGfgBw7LyWUaXRCBe1o/T5MVkUM9I
         j/HHagzuPjOIonpETGlrOU6YY6OxWpZt2q738n6uT2AC9edhGFsxNzRsqG4rqFMW7z
         GJwlq0Yp6YDzH3z4fjIq1j6hFPWLwLiT67TstHhcpQokg7/xo4KG0G+PQ2rYcLOPga
         0pWkZSFo4mKdg==
Message-ID: <e5a67378554d5434124f637189409a3c3bca3915.camel@codeconstruct.com.au>
Subject: Re: [PATCH 07/10] ipmi: kcs_bmc: Disassociate client from device
 lifetimes
From:   Andrew Jeffery <andrew@codeconstruct.com.au>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     minyard@acm.org, openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, aladyshev22@gmail.com,
        jk@codeconstruct.com.au
Date:   Mon, 06 Nov 2023 09:31:59 +1030
In-Reply-To: <20231103145129.000067d8@Huawei.com>
References: <20231103061522.1268637-1-andrew@codeconstruct.com.au>
         <20231103061522.1268637-8-andrew@codeconstruct.com.au>
         <20231103145129.000067d8@Huawei.com>
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

On Fri, 2023-11-03 at 14:51 +0000, Jonathan Cameron wrote:
> On Fri,  3 Nov 2023 16:45:19 +1030
> Andrew Jeffery <andrew@codeconstruct.com.au> wrote:
>=20
> > KCS client modules may be removed by actions unrelated to KCS devices.
> > As usual, removing a KCS client module requires unbinding all client
> > instances from the underlying devices to prevent further use of the cod=
e.
> >=20
> > Previously, KCS client resource lifetimes were tied to the underlying
> > KCS device instance with the use of `devm_k[mz]alloc()` APIs. This
> > requires the use of `devm_free()` as a consequence. It's necessary to
> > scrutinise use of explicit `devm_free()`s because they generally
> > indicate there's a concerning corner-case in play, but that's not reall=
y
> > the case here. Switch to explicit kmalloc()/kfree() to align
> > expectations with the intent of the code.
> >=20
> > Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> Bit more unrelated white space stuff in here that ideally wouldn't be the=
re.

Ack, I'll address that for v2.

> Otherwise makes sense to me.
>=20
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks,

Andrew
