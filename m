Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A38779253
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 17:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234199AbjHKPC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 11:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjHKPC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:02:27 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B1910FE;
        Fri, 11 Aug 2023 08:02:26 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 285815C00FE;
        Fri, 11 Aug 2023 11:02:23 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 11 Aug 2023 11:02:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1691766143; x=1691852543; bh=F9D7PZ0hU2tHmahvQKpgIwdFWy4Ot1Q9fLn
        ltmunggE=; b=s0NGs1DvL7dPmIgXuhCKQhK5nHT3QdoltzGiw7QiM0/OZ21PmjD
        gwAs7BIh5m7DxcmxPUWYoq1ND4bmewxrlf0VnW3rta4Idkm8MOCPiWRUWZQfIx5Q
        mYr4U4qoJdZVXQ/Mj+77MgE9Uj64sufSF7OunS76msNY7YtEMr0oypl2cBLX/C/7
        K1UfcWK7wHYQGesYeYUCasECJYehXWVF2byszqg+uWB5EnKwEmgpCWC2mmHwAnah
        0OQQ7EWH5n0rbOavVYEGXaN1/QWuhnrvEuwRsWHoZDPRmBZ9lv98cvasB2tIdWCL
        ZvpG9HDkcNBI2M3vsi50i9WhtIWScEfl4hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1691766143; x=1691852543; bh=F9D7PZ0hU2tHmahvQKpgIwdFWy4Ot1Q9fLn
        ltmunggE=; b=TaZws5a9pgfjZmfmfaS0f3x7J/gNZQmj6t64N/fwVxwdLpMp8rN
        G3lBUxnBzvZncOxlnchOScifpjcjXXRlYYPN2F8oyCkD/YeB/dtYHbRlmT+Er3sQ
        4eqv6nfzBjpD9YSF5Oco6CKzZtBZriR9qJYGZHBIuRoPbrs1INbdTJvRRicz7u50
        1aJ8lRHU6xs///e/ggo7R8uI3SNtYDnNYQ4eY62Stx67SwxByRR3njJZILs7BMOd
        AG6d5EtOs4GhGli+OJQ9qLZToaOX73h65s4L1bUF5JHqu8Hb1I1MxoenpAGLI216
        YVASgcF6hOMNaMYRhoKBjt50ePXbynyz9pw==
X-ME-Sender: <xms:fk3WZM40Q1ZUwX5YJK6MF-G73WnEi7VgxNMtfpZVpMiPODcSSx4CoQ>
    <xme:fk3WZN6r7LXuob6Nz-n0Pkj_b_e4vbydqsIX7jmidnm-tg8BuWHxJDzPv3sDSlRZ2
    szwskF2CUK7Ufk7Htc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrleekgdekvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudektdfg
    jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:fk3WZLf5NgT4cxwFwQIrZ4nsIHr0yVTcAOMOA23VL_5wd-gcG5OQ8w>
    <xmx:fk3WZBIpWlsLcE_bJmQ2HMv7lYxP6OY7UPzsGkZQMT53CvNW5a5P5A>
    <xmx:fk3WZAJtJZtVNbcaDL0Uhj8dhv3J-_tPb6IRYLM29FkWga3Vt9ljcw>
    <xmx:f03WZOzHPAdA6e9FuYvlOJSNdCNp-Na29yAEJ8OYoLrwJ8gCYm1Law>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3F16CB60089; Fri, 11 Aug 2023 11:02:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-624-g7714e4406d-fm-20230801.001-g7714e440
Mime-Version: 1.0
Message-Id: <ef7d94a4-9f65-47fb-906a-4fed4480d020@app.fastmail.com>
In-Reply-To: <97764bad-7091-e9ed-6f49-d31861fc622f@linux.intel.com>
References: <20230811130948.2211800-1-arnd@kernel.org>
 <97764bad-7091-e9ed-6f49-d31861fc622f@linux.intel.com>
Date:   Fri, 11 Aug 2023 17:02:01 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     "Hans de Goede" <hdegoede@redhat.com>,
        "Mark Gross" <markgross@kernel.org>,
        "xingtong.wu" <xingtong.wu@siemens.com>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Tom Rix" <trix@redhat.com>,
        "Henning Schild" <henning.schild@siemens.com>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        "Lee Jones" <lee@kernel.org>, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] platform/x86/siemens: simatic-ipc: fix nonsensical condition
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023, at 15:17, Ilpo J=C3=A4rvinen wrote:
> On Fri, 11 Aug 2023, Arnd Bergmann wrote:
>
>> From: Arnd Bergmann <arnd@arndb.de>
>>=20
>> The condition checking for a constant SIMATIC_IPC_DEVICE_BX_59A value
>> clearly makes no sense, as clang warns:
>>=20
>> drivers/platform/x86/siemens/simatic-ipc.c:132:42: error: use of logi=
cal '||' with constant operand [-Werror,-Wconstant-logical-operand]
>>                 if (ledmode =3D=3D SIMATIC_IPC_DEVICE_227G || SIMATIC=
_IPC_DEVICE_BX_59A)
>>                                                        ^  ~~~~~~~~~~~=
~~~~~~~~~~~~~~
>> drivers/platform/x86/siemens/simatic-ipc-batt.c:197:49: error: use of=
 logical '||' with constant operand [-Werror,-Wconstant-logical-operand]
>>                 if (priv.devmode =3D=3D SIMATIC_IPC_DEVICE_BX_21A || =
SIMATIC_IPC_DEVICE_BX_59A)
>>                                                               ^  ~~~~=
~~~~~~~~~~~~~~~~~~~~~
>>=20
>> Most likely, this was meant to check ledmode to be one of the two val=
ues,
>> so change it to that.
>>=20
>> Fixes: b8af77951941e ("platform/x86/siemens: simatic-ipc: add new mod=
els BX-56A/BX-59A")
>> Fixes: c56beff203754 ("platform/x86/siemens: simatic-ipc-batt: add su=
pport for module BX-59A")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Ok, I see. I missed those as there is hasn't been a new linux-next in
a few days.

I suppose this one is also fixed then?

WARNING: unmet direct dependencies detected for P2SB
  Depends on [n]: PCI [=3Dn] && X86 [=3Dy]
  Selected by [m]:
  - SIEMENS_SIMATIC_IPC_WDT [=3Dm] && WATCHDOG [=3Dy] && SIEMENS_SIMATIC=
_IPC [=3Dy]
drivers/platform/x86/p2sb.c:68:9: error: call to undeclared function 'pc=
i_scan_single_device'; ISO C99 and later do not support implicit functio=
n declarations [-Wimplicit-function-declaration]

     Arnd
