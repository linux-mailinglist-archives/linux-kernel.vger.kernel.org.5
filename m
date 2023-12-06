Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3368073B1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 16:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379187AbjLFPaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 10:30:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379147AbjLFPaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 10:30:19 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCCD08F;
        Wed,  6 Dec 2023 07:30:25 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 3E3B75C02E1;
        Wed,  6 Dec 2023 10:30:25 -0500 (EST)
Received: from imap52 ([10.202.2.102])
  by compute3.internal (MEProxy); Wed, 06 Dec 2023 10:30:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1701876625; x=1701963025; bh=80e+XLcHO99ogy+giG09/e8EEtyWh91qVmx
        7XJKBeOk=; b=DbfQ5TQMeaGQdvdtC9sqCqYix0G8ohyuf7ANxIXcMdNyvbMFJyk
        a/g+1LPluFgmf6zZzQqOhNGUeqcr+OP9/vzu/6GPfR0SK+xgk34k62fNnJLppBJp
        c2JlPx9lB4FmcIKH/5zksu4z32QmwkR2+ix8mpWhoOZA8xyQ+h8XRXy8DqWpkc9f
        cTPXCcrkFf4HsVIs9nw9MIVaTNvL3roZgu41ccUQS+uZ6ur8wAvL40tmoHTU37Fr
        95XMYtVNBk6zyyNAHevubF8NQlslt54hQPJUgSSGmq4NW1lRjuusc+bUxdbas23M
        vr/QTc0DhTi88MKaLCDqTJ0ZST58XOs4rhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1701876625; x=1701963025; bh=80e+XLcHO99ogy+giG09/e8EEtyWh91qVmx
        7XJKBeOk=; b=MguKT8A09cpa9LzwSF5zP2Kag6PENk3WgpBA3J5D+Qbs87ESgdX
        uvJ+TXk0T0FpMqf6sR9htDHnOajGFeJMDpgy3tngNrd12/V0SxkUQ7AQmBN/wL8R
        c/sIuQtqPSp3WniqLXn9K6SVsvB3vufmJdjH23EhYuDtII+bRYHVr9gob9W50o2z
        +yNhxipiYbmg0+6+JBpPGAa9Bh9y7LY7bxfQ6NiNSoos1oH6jXpZYYOpPWxxTX0P
        tsPUQHwEJhSqiFZr7ZcMIUhO1/SAZ6nhHSwfxuQBGPhJPXJGgf8rbw+b2mtJDoT0
        1vuX7DRrrvmC29v0xPUJlMRIYZbcAsIfueg==
X-ME-Sender: <xms:j5NwZWyU7mIxTBfVl9-gF3IxsMI_5MB7RkNQrvbaV_OYta4_p_nHdw>
    <xme:j5NwZSRWdDyh2LWR89sfz8bpA8mee_ZWiNfh8IHVYD_V4V4wtaSp2ayJhbORrxcqF
    i8vVqmnUJhvq1pYlGk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudektddgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goufhushhpvggtthffohhmrghinhculdegledmnecujfgurhepofgfggfkjghffffhvfev
    ufgtgfesthhqredtreerjeenucfhrhhomhepfdforghrkhcurfgvrghrshhonhdfuceomh
    hpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrgeqnecuggftrfgrthhtvghr
    nhepieeltdeihefgfeeihedvgedtueeuieefvddtteetffejvefgieeghfeiheeilefgne
    cuffhomhgrihhnpehsohhurhgtvghfohhrghgvrdhnvghtnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhhpvggrrhhsohhnqdhlvghnohhvoh
    esshhquhgvsggsrdgtrg
X-ME-Proxy: <xmx:j5NwZYVdfdu1Q5I4r9TrPkDQU-Fz-RrEtYDbgpf10pYX_QYkF-Mh9g>
    <xmx:j5NwZci75ef7UctUSpuWYjR4es17FC3zKFX22ODMw4TAwpZN5fpIgQ>
    <xmx:j5NwZYBoKuy9t-R1NOdRlaTO8H3a86HKcUp9Jckrg32umw73d79Cbg>
    <xmx:kZNwZb9lFUQifvYfcu06YX1LsAFQRlAgws9FrsgiKPfBsnil3quhxQ>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B589EC6008B; Wed,  6 Dec 2023 10:30:23 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1178-geeaf0069a7-fm-20231114.001-geeaf0069
MIME-Version: 1.0
Message-Id: <ea94a2d7-a13c-4f08-9979-48a8f33a47fc@app.fastmail.com>
In-Reply-To: <20231206060144.8260-1-rdunlap@infradead.org>
References: <20231206060144.8260-1-rdunlap@infradead.org>
Date:   Wed, 06 Dec 2023 10:30:03 -0500
From:   "Mark Pearson" <mpearson-lenovo@squebb.ca>
To:     "Randy Dunlap" <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     ibm-acpi-devel@lists.sourceforge.net,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "Hans de Goede" <hdegoede@redhat.com>,
        "Henrique de Moraes Holschuh" <hmh@hmh.eng.br>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [ibm-acpi-devel] [PATCH] platform/x86: thinkpad_acpi: fix kernel-doc
 warnings
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy

On Wed, Dec 6, 2023, at 1:01 AM, Randy Dunlap wrote:
> Add a function's return description and don't misuse "/**" for
> non-kernel-doc comments to prevent warnings from scripts/kernel-doc.
>
> thinkpad_acpi.c:523: warning: No description found for return value of=20
> 'tpacpi_check_quirks'
> thinkpad_acpi.c:9307: warning: This comment starts with '/**', but=20
> isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.r=
st
> thinkpad_acpi.c:9307: warning: missing initial short description on=20
> line:
>  * This evaluates a ACPI method call specific to the battery
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: "Ilpo J=C3=A4rvinen" <ilpo.jarvinen@linux.intel.com>
> CC: ibm-acpi-devel@lists.sourceforge.net
> CC: platform-driver-x86@vger.kernel.org
> ---
>  drivers/platform/x86/thinkpad_acpi.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff -- a/drivers/platform/x86/thinkpad_acpi.c=20
> b/drivers/platform/x86/thinkpad_acpi.c
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -512,10 +512,10 @@ struct tpacpi_quirk {
>   * Iterates over a quirks list until one is found that matches the
>   * ThinkPad's vendor, BIOS and EC model.
>   *
> - * Returns 0 if nothing matches, otherwise returns the quirks field of
> + * Returns: %0 if nothing matches, otherwise returns the quirks field=20

Just being nosy - what does %0 do?
I assume it helps with the return value but was intrigued how it is used=
 and where

> of
>   * the matching &struct tpacpi_quirk entry.
>   *
> - * The match criteria is: vendor, ec and bios much match.
> + * The match criteria is: vendor, ec and bios must match.
I can't for the life of me see what is different here. What am I missing=
?=20

>   */
>  static unsigned long __init tpacpi_check_quirks(
>  			const struct tpacpi_quirk *qlist,
> @@ -9303,7 +9303,7 @@ static struct tpacpi_battery_driver_data
>=20
>  /* ACPI helpers/functions/probes */
>=20
> -/**
> +/*
>   * This evaluates a ACPI method call specific to the battery
>   * ACPI extension. The specifics are that an error is marked
>   * in the 32rd bit of the response, so we just check that here.
>
>
> _______________________________________________
> ibm-acpi-devel mailing list
> ibm-acpi-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel

Thanks
Mark
