Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471FB80B11B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 01:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234165AbjLIAzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 19:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjLIAzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 19:55:36 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C131716
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 16:55:43 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id AA3283200A39;
        Fri,  8 Dec 2023 19:55:42 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 08 Dec 2023 19:55:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1702083342; x=1702169742; bh=bi
        S4hcEKr/Qfs0H/D8bbsNB0Kk85gc7R72P6aIuJ0GI=; b=F6EKMVjwaq6VTOcOcP
        jLJtIir0yS7wT+wNXEhOsenBzWs83k/MlcfX8sHULLJc+a4R5R5Yc9HXnUR8Og/P
        SQBZjEXelFTD7EU0dwgr6rJxJLQVRYQySN39/cxaOlz7mvD/a9Z42qFD7K4cIvrn
        MefCkMHsefKTuJ65IVAmbomsREJBiUjruUdVG7fTKT6cRRYJQVDJZT75Q37+bDKN
        eSeGaXY65jRfsOyYYJc1mSu/AOhDZQhxsvZKWaEpjfhIHAunCjnMNQXWfrTAVH+C
        riF8MRLh1S99AMcblpaUyI8b1Qvet+80itP4j37Z8pcHGoqLpAmJlLh90YlI/dFC
        Lneg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1702083342; x=1702169742; bh=biS4hcEKr/Qfs
        0H/D8bbsNB0Kk85gc7R72P6aIuJ0GI=; b=h71DMdwNKrN67Q46NcKP8CqZSc/No
        UiiRmPJ1Xq+lcdBuMn9/dyqVzwYZn8i/PsOhVsNUrwc2V7z/5+BOBO2mdX028bgD
        7DhILzXGpOmx/G7w05purft4Uf04dYAbdcC7ogBAyApEkw8Gu8REsnmBzjvRJKTL
        F7jdAyQnZTxWfEwdeblN4zphSHX7ZVJ3/Gw/HedZjuQ1lZOFDo0Myr8eAlHDBwJu
        2N08TkIDRtW+jl7GizF2CR/aSYtl0E1RdbG97Qmup3iX3C+M28+Y/OEF9vid8hk9
        W4IQdAt7uoRq1XAZdStkrJged4pXTf4mbbSI4jrB0ZHSsKDyIuPq3776w==
X-ME-Sender: <xms:DrtzZfoXGLv-dxSJupxSyNYp12kRJvaliVtkvp4eDTXKaGANgZwFdw>
    <xme:DrtzZZrtOn3nXUrCtKNx5LHMJqCIclIgkbgwKTqH9yd8QH4DnenzbgZd_S493Kxaf
    CSoYtWhMRmyNHAiOIk>
X-ME-Received: <xmr:DrtzZcPe59AESITby43baIGj4QDqLGF9QHsMWSDB7CgmCmfHM9-ZT7Jdtygtut0DQ0rc-Ao7-u7XADOaZlhCXUnTxWXJvv0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekjedgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfhgfhffvvefuffgjkfggtgesghdtreertdertdenucfhrhhomhepifgrrhih
    ucftohhokhgrrhguuceoghgrrhihrhhoohhkrghrugesfhgrshhtmhgrihhlrdhorhhgqe
    enucggtffrrghtthgvrhhnpeejhedtueduieehhfefgeeltedtgffhvedvgfdtfeejtdff
    gfehudffjeekhfdtfeenucffohhmrghinhepkhgvrhhnvghlnhgvfigsihgvshdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrghr
    hihrohhokhgrrhgusehfrghsthhmrghilhdrohhrgh
X-ME-Proxy: <xmx:DrtzZS53hP9_c2s8M8ogDNU5MAo-rtLjz_mhE3acVN5l1sNWaf6gSg>
    <xmx:DrtzZe7WJc1OBFe7YnbNZZE2g2lBPfny74Ql1Fr6g_i8rWFxKrlEAw>
    <xmx:DrtzZajzhGAnc3zt1kB7p8B1itnoEqzN9c-PwAcHhmPeFfQInuV-_w>
    <xmx:DrtzZeGTj5Gd7Z2AFuRmi6Fd4u5r5UYcU5WmMLVxBFjEO1Pree4i3w>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Dec 2023 19:55:41 -0500 (EST)
References: <20231208015536.21013-1-garyrookard@fastmail.org>
 <493fe783-46b3-4da7-b0d9-01425e6adf2a@gmail.com>
User-agent: mu4e 1.10.6; emacs 29.1
From:   Gary Rookard <garyrookard@fastmail.org>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] staging: rtl8192e: patch series renames (5)
 different variables
Date:   Fri, 08 Dec 2023 19:41:35 -0500
In-reply-to: <493fe783-46b3-4da7-b0d9-01425e6adf2a@gmail.com>
Message-ID: <87ttosfb3h.fsf@fastmail.org>
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

Okay, will use "rename" instead past simple tense "renamed"

The coverletter(s) are having a repetition problem, I can add an
numeric value to their Subject lines to "unique" them as there is not much
else available to do so with.

Regards,
Gary
=2D-=20
Sent with my mu4e on Gentoo GNU/linux.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJNBAEBCAA3FiEEjsrWb+cZk1AuzV9C2li+Bks2LgAFAmVzuxIZHGdhcnlyb29r
YXJkQGZhc3RtYWlsLm9yZwAKCRDaWL4GSzYuALTTEACvsx5Dl5kmKFF7t/GkhACc
FLOP8uIDRRYwGK4d6twWCqaWPeERd3+O1y+OemThbS/mKZ9UP61hQ8VLPdW/zKX9
wnF2A1Ic/DchYcWzEpeDiMQkjy8PlC0Nnx8fZcpLAUYdJNiQYoZ9gEqiwfFQXysa
aDUDcaVdY3NiRJBLfl0CxzSv8pg8EKK16rlG+ii15IMsTamHG1//S5mn7FRHmk6B
x0e0yvGRbXZFGp52/NYwXc0iOF/2us6NZc2V3CuqSgf9MaVW+/QKsIFcZTTzrvLW
gELdxjjo0VJljo+pmMglqeJbXM86s9YdzyWRWhwSrOmUh7m1lwGfQgV6tPnK8LLX
DOXXxJvrlNQO2ZL2+Zh4TWF4TL/6wHkDD3gzxDXPYvpu2GqEYGCkeEevjQ6xy/60
0ITcJVfVytCU58XeJtUQN3RBLZYqfAplNbYkpvvigY5DdNktDn/EeoXTN+1aU4at
rRTVVnx9wIGvjqOY4KPP4dIb2U+fgf52K10OeK1QJYluFCpRHZnsYOxtauggqQSR
4D3nWnRaEX29Jz1kdWVOEff5jl1ygmlaWkSMG9bQK+j0ne/8yPlmR28E+pGS5vHL
dvmJElQJgY8glo/lje8D7qa5y02L9Nm4LFsWowT1KXPyHWYS5iz+M9ZDH9PRjdVw
mcOnmHsmB+7DopD4gVOvPQ==
=WrgT
-----END PGP SIGNATURE-----
--=-=-=--
