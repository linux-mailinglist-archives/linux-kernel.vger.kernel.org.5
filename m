Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31EF77B2BA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 09:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234220AbjHNHlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 03:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234198AbjHNHke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 03:40:34 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD815E73;
        Mon, 14 Aug 2023 00:40:30 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 8CB125C0125;
        Mon, 14 Aug 2023 03:40:27 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 14 Aug 2023 03:40:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1691998827; x=1692085227; bh=zhIr+YFny3Ax+nBYjcGNtxMTlKdI2p4qsam
        OFHm/fmU=; b=lQyzt8ZLnsC5Y4UD4rcO9dWLQemDrz7il2Mxuh11MQmaHw+tEBa
        WZDt4/Dez0EgliHQKAHWxE4olKashOAKJ6eUkT6FdeyTLJECyYPyhtI7i4Gqe5nF
        hXE6HrnSoZ6cNhxVj0CHKKmbmxhXFP2ByD0RE+1S1kRlkWJJZqH9l30gc508ss8m
        Fg1u3TpiwcMJJTDRRJr0uQBmB0QKwNWirPjXPTrv+Z3XSDNBykO6ibnWw6zyMfz4
        7h0n5DQtmxjoUKRmRBuZcbHmWJz/yrIUe0B38slYIg2GDnRq3r3t1G+84c91JRXI
        1sLrN+lAiojvZUzO0Ry+J6LnON2gDb4OI4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1691998827; x=1692085227; bh=zhIr+YFny3Ax+nBYjcGNtxMTlKdI2p4qsam
        OFHm/fmU=; b=ocFr0qDmiS9E5/sOvsP5cpWIFi/jWAZeosdutO/nXN7USaZsaWk
        y58ZvbAPa3S7o+UGyrYhowIRb1sAuz/9U+GsjxUJQAyE/XayHiVEvwJwgnVvEmQe
        k4FTPfXsOXc+nz+Xe2sNy0jtI2dz40sA7SfVHT84lGO/8bNHR9L4vZ/9gyp21Xsp
        2ZKzxntQsMuRqJ1s6VUUbASKVBdXE42/CG5RiftQajbPvvPg5q5ofhTYxqlTmL/s
        WTIoamvXGGQwqbbhr6ON10dpRo291lnWNwmp8/tZ5NaKykQGuzYb+KZlwNxg3uOA
        929mGr7RtvjAA9TdObEckQhGXE38FFv5J9w==
X-ME-Sender: <xms:a9rZZJxVYOZsaqZENcyzopD3CtKe5tFkIQUZg3rPO6d2SA7gluVCeg>
    <xme:a9rZZJS3tB-x7dcIKYmjO4rPBmWW5L3Ywr495ocjCW0xbx-Wy2KzdFX7nHBuTyuD1
    jsnc75lyCZWQgQrbGE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddtfedguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    tehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrf
    grthhtvghrnhepfffhvdejieelteeljeekgeegieevheelueehieehkeehgeekhfdtleek
    teevtefgnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:a9rZZDV6sWgYeiJIG9l0H429IJUdAOX6rpdnSlDQnxUlYBUaqOP3jg>
    <xmx:a9rZZLgSHOuGLrTQOY2l4NjhImeSCbZbevftVnV5RGOhsPFjsxBNDg>
    <xmx:a9rZZLAMqWGDYsiYycxVcCVfogs40BAJLvSqK8N1YcTw9K_df-yVRw>
    <xmx:a9rZZLzDpj7cOzLpPrQRj3-TU_ZNHS5nYbeyG41sbHaf5PlCLw4-tg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E93C5B60089; Mon, 14 Aug 2023 03:40:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-624-g7714e4406d-fm-20230801.001-g7714e440
Mime-Version: 1.0
Message-Id: <075ff937-645e-41fe-87cd-0fa878dd6408@app.fastmail.com>
In-Reply-To: <7aa516e1.1dfc.189f22149f6.Coremail.xingtong_wu@163.com>
References: <20230811130948.2211800-1-arnd@kernel.org>
 <97764bad-7091-e9ed-6f49-d31861fc622f@linux.intel.com>
 <ef7d94a4-9f65-47fb-906a-4fed4480d020@app.fastmail.com>
 <69fbdb7bb4d048bc9c5eb756bbf87f56@siemens.com>
 <7aa516e1.1dfc.189f22149f6.Coremail.xingtong_wu@163.com>
Date:   Mon, 14 Aug 2023 09:40:04 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "xingtong.wu" <xingtong_wu@163.com>
Cc:     "xingtong.wu" <xingtong.wu@siemens.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "Arnd Bergmann" <arnd@kernel.org>,
        "Hans de Goede" <hdegoede@redhat.com>,
        "Mark Gross" <markgross@kernel.org>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Tom Rix" <trix@redhat.com>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        "Lee Jones" <lee@kernel.org>, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        gerd.haeussler.ext@siemens.com, tobias.schaffner@siemens.com
Subject: Re: FW: [PATCH] platform/x86/siemens: simatic-ipc: fix nonsensical condition
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023, at 05:40, xingtong.wu wrote:
>>From: Arnd Bergmann <arnd@arndb.de>=20
>
>>Sent: Friday, August 11, 2023 11:02 PM
>>
>>Ok, I see. I missed those as there is hasn't been a new linux-next in =
a few days.
>>
>>I suppose this one is also fixed then?
>>
>>WARNING: unmet direct dependencies detected for P2SB
>>  Depends on [n]: PCI [=3Dn] && X86 [=3Dy]
>>  Selected by [m]:
>>  - SIEMENS_SIMATIC_IPC_WDT [=3Dm] && WATCHDOG [=3Dy] && SIEMENS_SIMAT=
IC_IPC [=3Dy]
>>drivers/platform/x86/p2sb.c:68:9: error: call to undeclared function '=
pci_scan_single_device'; ISO C99 and later do not support implicit funct=
ion declarations [-Wimplicit-function-declaration]
>
> I=E2=80=99m pretty sure your .config file is error to compile the kern=
el,
> you must have changed the .config file manually, and there will be no
> possibility that option SIEMENS_SIMATIC_IPC is [y] while PCI is [n].
> reason:
> https://elixir.bootlin.com/linux/v6.5-rc6/source/drivers/platform/x86/=
Kconfig#L1079
>
> if the PCI option is [n], the "p2sb.c" should never compile pass.
>
> I suggest you make menuconfig to build kernel and check your .config
> carefully.

It was broken in linux-next by commit b72da71ce24b0 ("platform/x86:
simatic-ipc: drop PCI runtime depends and header"), I sent a fix now.

    Arnd
