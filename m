Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C4080B0E8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 01:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234083AbjLIAX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 19:23:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjLIAX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 19:23:28 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A605A1705
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 16:23:34 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id D720A32002F9;
        Fri,  8 Dec 2023 19:23:33 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 08 Dec 2023 19:23:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1702081413; x=1702167813; bh=34
        evwBv9XLBNoRw7KrAKdtQiiKWCVShYjoP0zSMsFn8=; b=OOF97ztTd2TfWWSyGX
        XNzAxjiTtpJi3OATRNeyJvTB4cTYK4fqsHlv7BHPIEYmgOFrCUoWrbAZrZ9ILJc8
        94RDHVVGLlodyZR7/eLwBnBqSONWYCHFIW43whmXZM8BLc63DILGWrRPsID/PXpA
        /adhgk7P+MeMk4fSMznWSyjRVeQt/LwQg8nP7l/g1stOg5IbA/9kaaaaPPSue2r5
        3nI2434DIEvZ8zu2utcvY1upFM2TJY7Go1cGNymgSGtSf36Q8T9eP32WGdonwSbL
        Xqvj6yUrzSITEVNt4h777MkMDA5uYBsD9E3DkqdUia12ewsCLD/OOV7SxxyELodt
        HgOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1702081413; x=1702167813; bh=34evwBv9XLBNo
        Rw7KrAKdtQiiKWCVShYjoP0zSMsFn8=; b=CZA0+lNi+Ox6QxK9kbKoF8vJkZ0fJ
        C+6dx4l72jDQ9FOyrLS07a13ZcsTcm3wU0/FrKQ4G/Z4rjhp6buT0nJ+W8gG/Zpz
        xbTGTpRAQ7SNgm+9jLPBo9ur9sa1i29dfPicw/cdoHHM7/mF+YuVq8niuWxHx+Q9
        mgPMefxC6Mqx1OrTIhWrqzbxzBNNPIxjTQTJMDc+rb/966O1j+Vr6MFaJ6JNwnAp
        5r2+O+rpNYvRFMqQ3sKNMGaz+CJefTEinKUZm/BioEjGDJm8hpGYH6upwbrnNeRA
        mXUQmy8sMpV04oDwofKfRsX1CJSySsLakOeiSW7B2G9gvgFkvmQ68sGhw==
X-ME-Sender: <xms:hbNzZY-aSiOUQ0LJJo6AsJJ1e_quPma7_0CEA10GF0001uOElWa-2Q>
    <xme:hbNzZQtlatPmkMC-wLKVcdbvQYZt3JFeShCaF9DNpU1jz_phMGquCJ5FmdgTxDrjq
    ibUGo_c7XgA7jC-S-Q>
X-ME-Received: <xmr:hbNzZeA_mUK27UMoaKdQnUzDyD9H_oZGc-FkFlMtkTw3nXNAGfRSy8abAYKPKu3A8HLX5wWs-y1zEvC-4DUZ_AMy7dUbUhA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekjedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfhgfhffvvefuffgjkfggtgesghdtreertdertdenucfhrhhomhepifgrrhih
    ucftohhokhgrrhguuceoghgrrhihrhhoohhkrghrugesfhgrshhtmhgrihhlrdhorhhgqe
    enucggtffrrghtthgvrhhnpeejhedtueduieehhfefgeeltedtgffhvedvgfdtfeejtdff
    gfehudffjeekhfdtfeenucffohhmrghinhepkhgvrhhnvghlnhgvfigsihgvshdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrghr
    hihrohhokhgrrhgusehfrghsthhmrghilhdrohhrgh
X-ME-Proxy: <xmx:hbNzZYfeBnIcF39qaDsG67sWwmq4AEufEPMbhphboKYranawkXCsYA>
    <xmx:hbNzZdPNkSuoP6NO_0G5ngoQ5B4j1M00rlh6sDFAFJ1zx47Ct8IQqQ>
    <xmx:hbNzZSnRasWNaaieZvUxKtQTAJhNzNI_RFsNTn_c6AMuhilisOilhQ>
    <xmx:hbNzZWai67UuiU9i8ul3WwInrQOAOKg_QfCwYG5JGrglBn1hD8lQUQ>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Dec 2023 19:23:32 -0500 (EST)
References: <20231208015536.21013-1-garyrookard@fastmail.org>
 <493fe783-46b3-4da7-b0d9-01425e6adf2a@gmail.com>
User-agent: mu4e 1.10.6; emacs 29.1
From:   Gary Rookard <garyrookard@fastmail.org>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] staging: rtl8192e: patch series renames (5)
 different variables
Date:   Fri, 08 Dec 2023 16:56:46 -0500
In-reply-to: <493fe783-46b3-4da7-b0d9-01425e6adf2a@gmail.com>
Message-ID: <87y1e4dy2g.fsf@fastmail.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Philipp Hortmann <philipp.g.hortmann@gmail.com> writes:

> On 12/8/23 02:55, Gary Rookard wrote:
>> Hi,
>> This patch series renames 5 different variables with the checkpatch
>> coding style issue, Avoid CamelCase.
>> Patch 1/5) renamed variable bCurShortGI40MHz
>> Patch 2/5) renamed variable bcurShortGI20MHz
>> Patch 3/5) renamed variable CCKOFDMRate
>> Patch 4/5) renamed variable HTIOTActIsCCDFsync
>> Patch 5/5) renamed variable IOTPeer
>> Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
>> Gary Rookard (5):
>>    staging: rtl8192e: renamed variable bCurShortGI40MHz
>>    staging: rtl8192e: renamed variable bCurShortGI20MHz
>>    staging: rtl8192e: renamed variable CCKOFDMRate
>>    staging: rtl8192e: renamed variable HTIOTActIsCCDFsync
>>    staging: rtl8192e: renamed variable IOTPeer
>>   .../staging/rtl8192e/rtl8192e/r8192E_dev.c    |  4 +-
>>   drivers/staging/rtl8192e/rtl8192e/rtl_dm.c    | 22 +++----
>>   drivers/staging/rtl8192e/rtl819x_HT.h         |  6 +-
>>   drivers/staging/rtl8192e/rtl819x_HTProc.c     | 58 +++++++++----------
>>   drivers/staging/rtl8192e/rtllib_tx.c          |  4 +-
>>   5 files changed, 47 insertions(+), 47 deletions(-)
>>=20
>
>
> Please use present-tense as outlined here:
> https://kernelnewbies.org/PatchPhilosophy
> So rename instead of renamed
>
> Please use a more unique Subject for your coverletter.
> It often cannot cover everything. But more unique is better.
>
>
>
> Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>

Okay, "rename" it be, instead of me thinking in the past simple tense,
of "renamed".=20

As for the coverletter(s)...repetition a big problem.

There's not much in the way of uniqueness that can be added...regretfully=20
Tagging the Subject line with a numeric value is possible and
should deviate the coverletter(s) enough so they don't "appear the same".
e.g. staging: rtl8192e: this patch series (1) blah blah blah...
e.g. staging: rtl8192e: this patch series (2) blah blah blah...
e.g. staging: rtl8192e: this patch series (3)  "    "    "

Regards,
Gary

=2D-=20
Sent with my mu4e on Gentoo GNU/linux.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJNBAEBCAA3FiEEjsrWb+cZk1AuzV9C2li+Bks2LgAFAmVzs3IZHGdhcnlyb29r
YXJkQGZhc3RtYWlsLm9yZwAKCRDaWL4GSzYuAEdTEACKrPt8/XKR7oOYNGjcUpJm
Mqy+vQB7rSjg6KkHrcxHzM2Pe9RICZOEe2aU0BFhTcpeRvl6PEV1UzW4sd+vz3lL
R1hG2IGStotwSJz/HTI7vs2UR3feMKo3Zwz8Oj9RnhXxCn1TzdMUnGr2drLXnZyo
VUvuD3lUNFm4EDcA6T1ZjALbzO7OrhFyUMWRanND+18DqflQBn2X1AeGvIk9ZVlc
RPk4yl1Or5akTiCcjJXncMiKwtH8BzfxgVy6dHYkZV98NZ+XImZjinaI4gsu2BVP
kXTmeJAQMJi1ez+ecJhV0kNUHw/1Fi8vZEU6EKQuFtoWm7uLZIacCtzRW9HkNdrZ
ZSi0tuiz6+9/jmJUlR0cSVZGl1Ns14QbOJBsTk8nvvHSOp8z/Z3USAH2b/dxh+ft
dScyEaja271DVe+6u1QQHJFKrrGcao62KljnfQMojOwcWYgsXoQ/+0WhdNtDgWsS
Z5a2VrAgh+QWe83An9Vqba2OYGETtfozpbs2Lf96v0imt6gVzwiHHjM2bWlTNcGR
InTDKR8mckF1EXAEolodcBny5zd83OMOU3GVzw2ZQWtIuhpxaGrd6tkdC1zSzJCq
uY/siBkFVD/Sd7gElESOORmQW2+yr/Ovm9SaTFJa/F728I3EUdgcr/oNRsyiFgDT
1ybK4Cc1aklX/Oz6ZvwLVQ==
=fjT6
-----END PGP SIGNATURE-----
--=-=-=--
