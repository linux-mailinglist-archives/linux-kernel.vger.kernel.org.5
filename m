Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A59A7E1771
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 23:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjKEWwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 17:52:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKEWwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 17:52:49 -0500
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00108CF
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 14:52:46 -0800 (PST)
Received: from [192.168.68.112] (ppp14-2-79-67.adl-apt-pir-bras31.tpg.internode.on.net [14.2.79.67])
        by mail.codeconstruct.com.au (Postfix) with ESMTPSA id E6AAB20075;
        Mon,  6 Nov 2023 06:52:44 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeconstruct.com.au; s=2022a; t=1699224765;
        bh=X05iy3X3/MBZ1pThUNQEQBQO2psGBo+DnUHTVaKJcec=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=gkzrZaNisOb0fd1fDQJJgx8CudoOm1Mz4EzfImG/H0PXTQ7ecpNsdTl0s+sBrX39i
         5mUH1tzgt5Ch3PfDJsIm+YbxkQebRU/Ixf/jxsEjgx+9MmAlO3ryrdWNpGkWpG0e5b
         iEToo9YSuME7qRoL9G5hU9dnh4wIEJgkH1DRabR5BNpT+RVIfOmL3agkj+WE4Lm1F8
         oBhIjfPzDXeHnunbdWqNMa6G/oGAFPqRTGy6Lh+hk9xbNV9sAr0+ntIJup2R2wnHvM
         E9SLKNuXzT9e0b6+SDnr7GQEWEVLqQhzO48lhM7g5CNsFTZKrvjJ78RzWcRLVT4V0N
         Pt8BkK6T2E+pw==
Message-ID: <0b0bc38c2c76917e9a29e216d6ae7d265a919d07.camel@codeconstruct.com.au>
Subject: Re: [PATCH 03/10] ipmi: kcs_bmc: Make kcs_bmc_update_event_mask()
 static
From:   Andrew Jeffery <andrew@codeconstruct.com.au>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     minyard@acm.org, openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, aladyshev22@gmail.com,
        jk@codeconstruct.com.au
Date:   Mon, 06 Nov 2023 09:22:44 +1030
In-Reply-To: <20231103144026.00001fbc@Huawei.com>
References: <20231103061522.1268637-1-andrew@codeconstruct.com.au>
         <20231103061522.1268637-4-andrew@codeconstruct.com.au>
         <20231103144026.00001fbc@Huawei.com>
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

On Fri, 2023-11-03 at 14:40 +0000, Jonathan Cameron wrote:
> On Fri,  3 Nov 2023 16:45:15 +1030
> Andrew Jeffery <andrew@codeconstruct.com.au> wrote:
>=20
> > There were no users outside the subsystem core, so let's not expose it.
> >=20
> > Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> Is it worth having the wrapper?

Perhaps not, though aesthetically I prefer it. Also the diff is at
least slightly smaller by not removing it entirely :)

>=20
> I guess all the other cases do have wrappers (even if that's because
> they continue to be exported) so fair enough.
>=20
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks,

Andrew
