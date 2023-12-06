Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0A78075B2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 17:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378535AbjLFQtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 11:49:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379718AbjLFQtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 11:49:06 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B24BFA;
        Wed,  6 Dec 2023 08:49:12 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 06AB05C02A6;
        Wed,  6 Dec 2023 11:49:09 -0500 (EST)
Received: from imap52 ([10.202.2.102])
  by compute3.internal (MEProxy); Wed, 06 Dec 2023 11:49:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1701881349; x=1701967749; bh=7aSOj3X2VbHYlfk00jEHrfDd+wxD+4TJMdm
        EbRvMRgI=; b=vbvt0mvFqhAdQ50sUdsgJxlqEus0ZX9rvJkQEVzN5690fPeDo6v
        wZ7maIKIbTvI+Pu7N2qcayfrQjG415Rudv71DXP8eZwXdDY9ea+O7CL5vGhdReef
        xd4sIaG48U0PvP9SYM1XH49B/ixAkpN1MxzSrR512gsy3PHJNc/9XuXRzGeWx/wj
        RDW/giPGaEKkcjkvN+xZU8Hi1+Y5Y5mxi1zUSKlWqAH0C/5wcLpbO4zvty043P8R
        qBKVc1JsoXwMXaiznhlo/pJm0IRZf4qpQ0LOXSSyWQc5UxNPP+kVkxJqwg1P4XvU
        hIF0yi+/KRpfqU95+RmnFUC5CPtieX+FPPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1701881349; x=1701967749; bh=7aSOj3X2VbHYlfk00jEHrfDd+wxD+4TJMdm
        EbRvMRgI=; b=YkoQOY4rhF2/BK5kUSvkkjgZ3ul3mb1TNJUwCTQKbHkS+QvFDkx
        eJ8vkxQ6EQHTtpg+Z5ho29jKdtjcsgH6FuE5DOen7wn+80CYiJ/3NQTm/DGSMTfn
        8Ehe+d3lCWz61O032jZkwHj8pyYDTkkpoa7hmK2/IMg2BpDlz7Zc6q/wk2TaWUxr
        2HW9ts7hIGNFExRb1XKE93YKvlZpTxMDuaw9jRLej1PNpXnszX6IRlajop0sKCwD
        zXI215F72ybQ9mT5Ym1pGYkSScja69ONag/0gOtJqjG5+wwZlkTy6MhAhLn/wbvA
        ciLx2LznH+BfyRVLFYCo9TEHDVwTRSe44Fw==
X-ME-Sender: <xms:BKZwZdOSsXDkstPIaORKi3OgtO5NbDkq1p8fr2bA3PgF9mBeGOm9qQ>
    <xme:BKZwZf8x_yHHCEJTvnaL8n_9zxTu1EEAjnlySDHIhJyeDB58cM6XxggNdjQDtgQMZ
    1k6UTwov8vqKzZI99g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudektddgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goufhushhpvggtthffohhmrghinhculdegledmnecujfgurhepofgfggfkjghffffhvfev
    ufgtgfesthhqredtreerjeenucfhrhhomhepfdforghrkhcurfgvrghrshhonhdfuceomh
    hpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrgeqnecuggftrfgrthhtvghr
    nhepieeltdeihefgfeeihedvgedtueeuieefvddtteetffejvefgieeghfeiheeilefgne
    cuffhomhgrihhnpehsohhurhgtvghfohhrghgvrdhnvghtnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhhpvggrrhhsohhnqdhlvghnohhvoh
    esshhquhgvsggsrdgtrg
X-ME-Proxy: <xmx:BKZwZcS7B_E__hQjN-8mSSwnmot6snBRG2vjYiduzLAaw6WisbUcow>
    <xmx:BKZwZZt2kOh--nBpMpK_At6E3gyj0dgbjBJ7lcE74EplFTqeAvGKnw>
    <xmx:BKZwZVeGOc2uu8F0yb9Do5ENDr6xoA1ZoqDWwW7JEeA-jz7NwJioeQ>
    <xmx:BaZwZc6f7DXnpyCnrqzALhetbtSZ_87cJPyk1vT8F_tCdBvP21-19g>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7AC07C6008B; Wed,  6 Dec 2023 11:49:08 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1178-geeaf0069a7-fm-20231114.001-geeaf0069
MIME-Version: 1.0
Message-Id: <90220e8f-12e1-4b76-a438-f333fdedce9e@app.fastmail.com>
In-Reply-To: <f734ff9e-6005-4d47-959d-fab34c71c6e0@infradead.org>
References: <20231206060144.8260-1-rdunlap@infradead.org>
 <ea94a2d7-a13c-4f08-9979-48a8f33a47fc@app.fastmail.com>
 <f734ff9e-6005-4d47-959d-fab34c71c6e0@infradead.org>
Date:   Wed, 06 Dec 2023 11:48:44 -0500
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



On Wed, Dec 6, 2023, at 11:45 AM, Randy Dunlap wrote:
> Hi Mark,
>
> On 12/6/23 07:30, Mark Pearson wrote:
>> Hi Randy
>>=20
>> On Wed, Dec 6, 2023, at 1:01 AM, Randy Dunlap wrote:
>>> Add a function's return description and don't misuse "/**" for
>>> non-kernel-doc comments to prevent warnings from scripts/kernel-doc.
>>>
>>> thinkpad_acpi.c:523: warning: No description found for return value =
of=20
>>> 'tpacpi_check_quirks'
>>> thinkpad_acpi.c:9307: warning: This comment starts with '/**', but=20
>>> isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc=
.rst
>>> thinkpad_acpi.c:9307: warning: missing initial short description on=20
>>> line:
>>>  * This evaluates a ACPI method call specific to the battery
>>>
>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>> Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
>>> Cc: Hans de Goede <hdegoede@redhat.com>
>>> Cc: "Ilpo J=C3=A4rvinen" <ilpo.jarvinen@linux.intel.com>
>>> CC: ibm-acpi-devel@lists.sourceforge.net
>>> CC: platform-driver-x86@vger.kernel.org
>>> ---
>>>  drivers/platform/x86/thinkpad_acpi.c |    6 +++---
>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff -- a/drivers/platform/x86/thinkpad_acpi.c=20
>>> b/drivers/platform/x86/thinkpad_acpi.c
>>> --- a/drivers/platform/x86/thinkpad_acpi.c
>>> +++ b/drivers/platform/x86/thinkpad_acpi.c
>>> @@ -512,10 +512,10 @@ struct tpacpi_quirk {
>>>   * Iterates over a quirks list until one is found that matches the
>>>   * ThinkPad's vendor, BIOS and EC model.
>>>   *
>>> - * Returns 0 if nothing matches, otherwise returns the quirks field=
 of
>>> + * Returns: %0 if nothing matches, otherwise returns the quirks fie=
ld=20
>>=20
>> Just being nosy - what does %0 do?
>> I assume it helps with the return value but was intrigued how it is u=
sed and where
>
> It causes the output to be formatted as a CONSTANT (probably monospace=
d font,
> but no guarantees on that).
Ah - cool. Thanks!
>
>>=20
>>> of
>>>   * the matching &struct tpacpi_quirk entry.
>>>   *
>>> - * The match criteria is: vendor, ec and bios much match.
>>> + * The match criteria is: vendor, ec and bios must match.
>> I can't for the life of me see what is different here. What am I miss=
ing?=20
>
> s/much/must/
Man....I need to go to the opticians :)

>
>>=20
>>>   */
>>>  static unsigned long __init tpacpi_check_quirks(
>>>  			const struct tpacpi_quirk *qlist,
>>> @@ -9303,7 +9303,7 @@ static struct tpacpi_battery_driver_data
>>>
>>>  /* ACPI helpers/functions/probes */
>>>
>>> -/**
>>> +/*
>>>   * This evaluates a ACPI method call specific to the battery
>>>   * ACPI extension. The specifics are that an error is marked
>>>   * in the 32rd bit of the response, so we just check that here.
>>>
>>>
>>> _______________________________________________
>>> ibm-acpi-devel mailing list
>>> ibm-acpi-devel@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel
>>=20
>> Thanks
>> Mark
>
> --=20
> ~Randy

Looks good to me!=20
Reviewed-by: mpearson-lenovo@squebb.ca

Mark
