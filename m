Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13F877E50B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 17:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344160AbjHPPXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 11:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344153AbjHPPW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 11:22:57 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2695010C7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 08:22:54 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id B2C8624002B
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 17:22:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1692199365; bh=NREnd7UbRKli9nwhAUt6QP6b7ggS9yX8hW3zlVDQ2Xs=;
        h=Mime-Version:Subject:From:Date:Cc:Message-Id:To:From;
        b=mRNYZP1gjC/ARPAbbf9gh36vWi2mvcXcHZMV1KZ7CXJyhPIG4rqIClnW2krhr9c/J
         3OD+4p3FdzqwN3WJliBIMl1IG8P4e3NqmEnO/I3QUJObompB9qP7G5Li6LMnFKi6/s
         yXPnIJqWEtGIXWHj2C/Tfdc0xAPbdlewX9Km8OuBtN3xQOGvpiG1hDoGSQLbDi4wcj
         FGFyEnisgTEnPk6IBLn/KJ1hUsBzwyW/Mjt52arDIUMGJkROpPoMsQAUOd9Pj7OW0e
         b4+TU14TSxlpCrr1a+qh+oIPw8PWBP/7JzkXZcq60B8ORoSVAFG4WxOOuOtTyhxFa5
         +oV0W2SiN4N6A==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4RQsMS0tN7z9rxL;
        Wed, 16 Aug 2023 17:22:43 +0200 (CEST)
Content-Type: multipart/signed;
        boundary="Apple-Mail=_DA91F584-71C9-442C-B454-2CF84A9985CC";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [PATCH] auxdisplay: hd44780: move cursor home after clear display
 command
From:   Christian Meusel <christian.meusel@posteo.de>
In-Reply-To: <20230722140743.fe710f4f12c344f07d879c88@hugovil.com>
Date:   Wed, 16 Aug 2023 15:22:30 +0000
Cc:     me@davidreaver.com,
        =?utf-8?Q?Lars_P=C3=B6schel?= <poeschel@lemonage.de>,
        linux-kernel@vger.kernel.org, geert@linux-m68k.org
Message-Id: <EC4DEACC-70E6-4E98-9A56-780F3E4079BA@posteo.de>
References: <20230706185100.84322-1-hugo@hugovil.com>
 <CANiq72kZ0cHxCKkm_781G__9tJxYCw3tpJarqvLOFB4Jw6ZONw@mail.gmail.com>
 <20230706154937.1380bdcf9d84e1cff78911fa@hugovil.com>
 <7eb2d50baf269310e51854f700936e94@lemonage.de>
 <86wmysknde.fsf@davidreaver.com>
 <CANiq72nO04+2BcwBe_P0uD8pXJtTMG3djAFAj5Ucez6VvT4g7g@mail.gmail.com>
 <20230722140743.fe710f4f12c344f07d879c88@hugovil.com>
To:     Hugo Villeneuve <hugo@hugovil.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_DA91F584-71C9-442C-B454-2CF84A9985CC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hello everyone,

>> I will wait a while in case Christian or somebody else wants to test
>> it, and send it for 6.6.

I finally managed to test this patch with our hardware and I'm seeing =
the same expected behavior as beforehand.

When executing David's test sequence with a EH002004A [1], I'm getting =
garbled contents when shifting with '\x1b[LR'. But this also happens =
with the version of the driver we're currently using, does not look =
related to this patch and might be an issue with our display model.


Best regards,

Christian


--
[1] =
https://www.winstar.com.tw/pt/products/oled-module/oled-character-display/=
20x4-oled.html

--Apple-Mail=_DA91F584-71C9-442C-B454-2CF84A9985CC
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEIhqZz/J2souq/IKUfmJl21on4+EFAmTc6bYACgkQfmJl21on
4+FDHxAAvhC3E+kzVGyCuQZ943zKODLu4toUnWdaKKFYnMRZcTKOWwE+zEEYlhP+
WIh/oeyZgqSM+HwrfRfh8uD1Qya9gBRS0LhAaKH7lMOmlyz9LE7eKixVDiaI24Gw
m3E0OsQhMofBXD6EArN4mMKADYMp2z8PwTBRjVT5eAJwH/d9bcj2vdj7aXoeMgXZ
y3JEDsb27gJ1K37Nh+b42v6TvZVKAEUxk1K2GpmJQVGF3+fhivTf59idkS/neuBY
9tYMcw3ubkNtDMFaH0vBpawD9qgDe5qMaCl7CJ84kUbf4pPP4TkvLCpt6VvWtSRh
BsE+wX8aQU58U4Todic7Hbp/xegthuPiKq8SglxYfg3TitvwE0TSnocbtVsBO0pB
9V46Pu0zUCC7HyL7gYaWDTx7bFKpeEdkFo3Ck77hh/ciD77MhA8bFU77wCR29Mxm
uDUzmobwXf/E4DiJRa/RmM3yfP4b0PtqQtX2fnDBTTsN3ATcSkL1XvgkQsZbKktr
0dKwXTPCAPc0S+BssCb/T2NdIyuSZnvdInCVA7FaAGV4MMaMyLape0VA3pZ6uO49
8t408xyvocUsTGWoKu6NVRDCOtEUGHjxz44cCd2hBZNpmV7G95rQIqIBVQCptH4+
IWVNzQ6opIJdVTrAIbYKAnT2ddtC6cCvAEJ2tQY29Km4z2CebTI=
=ARi7
-----END PGP SIGNATURE-----

--Apple-Mail=_DA91F584-71C9-442C-B454-2CF84A9985CC--
