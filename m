Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50BAC7BB41F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 11:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbjJFJVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 05:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbjJFJVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 05:21:30 -0400
Received: from mx.exactcode.de (mx.exactcode.de [144.76.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4DB93
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 02:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de; s=x;
        h=To:References:Message-Id:Content-Transfer-Encoding:Cc:Date:In-Reply-To:From:Subject:Mime-Version:Content-Type; bh=gg4F1C7Bsnu8VL38dBFamcZXf6mHSEPhxMJxJeziYtc=;
        b=eyMJ9Yd+IKSVAouTHCd188prtAeyCSj0j3As3xau7nYPE7vjK/u065XSpsnBqfQzGLX+5UsjvQFzRAZfluQVewIAdAZPmoBGdtsHW4RcX18cm9m5otHGMKFoOp+sjR9nJHAY8YIrFg0FCiaNmazHn767apxv1ln30Hm8ENEdVAE=;
Received: from exactco.de ([90.187.5.221])
        by mx.exactcode.de with esmtp (Exim 4.82)
        (envelope-from <rene@exactcode.com>)
        id 1qoh24-0000nQ-DB; Fri, 06 Oct 2023 09:22:04 +0000
Received: from [192.168.2.109] (helo=smtpclient.apple)
        by exactco.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.86_2)
        (envelope-from <rene@exactcode.com>)
        id 1qoh34-0001JV-Sg; Fri, 06 Oct 2023 09:23:07 +0000
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: [RFC] AMD Zen4 CPU bug? Spurious SMT Sibling Invalid Opcode
 Speculation
From:   =?utf-8?Q?Ren=C3=A9_Rebe?= <rene@exactcode.com>
In-Reply-To: <20231004222511.GHZR3mR/oNFZuJGB9P@fat_crate.local>
Date:   Fri, 6 Oct 2023 11:21:13 +0200
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <797F7A00-541E-4333-B653-1120DF5C56B1@exactcode.com>
References: <D99589F4-BC5D-430B-87B2-72C20370CF57@exactcode.com>
 <20231004222511.GHZR3mR/oNFZuJGB9P@fat_crate.local>
To:     Borislav Petkov <bp@alien8.de>
X-Mailer: Apple Mail (2.3731.400.51.1.1)
X-Spam-Score: -1.6 (-)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> On 5. Oct 2023, at 00:25, Borislav Petkov <bp@alien8.de> wrote:
>=20
> On Wed, Oct 04, 2023 at 05:29:32PM +0200, Ren=C3=A9 Rebe wrote:
>> during cross compiling our =E2=80=9CEmbedded=E2=80=9D Linux =
Distribution T2 (https://t2sde.org) I observers some random illegal =
instruction build errors since we got ourselves a Ryzen 7950x on launch =
day a year ago:
>=20
> Thanks for reporting. I'm looking into it.

Thank you Borislav, were you able to reproduce this on Zen 4 you have =
access to?

Thanks,
	Ren=C3=A9

--
ExactCODE GmbH, Lietzenburger Str. 42, DE-10789 Berlin
http://exactcode.com | http://exactscan.com | http://ocrkit.com

