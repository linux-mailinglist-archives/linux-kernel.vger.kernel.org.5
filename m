Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6B979EF25
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 18:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbjIMQph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 12:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbjIMQp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 12:45:26 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E1D30E4;
        Wed, 13 Sep 2023 09:42:46 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 059D63200C12;
        Wed, 13 Sep 2023 12:42:42 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute5.internal (MEProxy); Wed, 13 Sep 2023 12:42:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1694623362; x=1694709762; bh=3R
        cP0+lHz50hfFKyKt8JAwtGK5ems8bjkcAlSKeDZtw=; b=SFdfYurV3LFeF11BlE
        0T1zplDsH8tN8CVuE/kMKr4Q0+E+TELiBcVDyWg72VyGjNpve0xPw0N2//v/kbOb
        t0peAcWyBdfTCtFVPrFXjeVLXDD5wmrc9XqMd8SdFjFv8QusmAu6JzjO2FLLW16L
        r/JgITTK8/upYaeEUMa4Wg5gs3etP2Npr8CK+QYMlI7TAnvDkFaC3oL1a6jNPgDM
        o8KuZJlqpXltq4wK7PfvqPrw2JyLUtJ6iKfl7ANenteBVsEO1S1Po918niSHfSIq
        Wzr9D1K3WUj5qOxx/7RZMG67FCQAafyOsU8U3QoRgkGLs1j4F4CN6s/F5Fa6M1Wi
        m4kA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1694623362; x=1694709762; bh=3RcP0+lHz50hf
        FKyKt8JAwtGK5ems8bjkcAlSKeDZtw=; b=j24EU+fwE1hbp/zQ/LQ+0jcKF6iax
        JxD5X2voC/Cbe2rmbOExAYpOW3P+fMEt5/PjXZIQuCU33MB5+conM6VSV5afTowi
        GAEMT3IXrpD1sRFRHo0XH+gEe99/EMZrYVotG7QoJvwx1p82Yuym8t9qjOBKMtJB
        2rZLUQJ3gF9qrhblOkuC6u7lKayDfjUyB24r18IaOQgj1OU2oRFsPfjFFgmlQDf1
        EHcki53K78pCi7y9uywCzYv9CWi0/LIVGcJw4UfhdJN88/pczx/+6fqHs03pHhsK
        YGuFPf/BS6hiN46HnsRdauphJFAMy/3DAxWpoiMykW8TkQ4gnJqW69+zw==
X-ME-Sender: <xms:geYBZRowaePEQKs7XhclyLFV55ppcambco4l7EwYgPkmTdhxIbPh7A>
    <xme:geYBZTrz7oBkmBmsfLnWy8AEgya_jplFHo2LvcNMyX_eRixdjCakqKI4KjUvXYaE4
    ZnfA0qrX1fkYklWKKc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeikedguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfofgr
    rhhkucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssg
    drtggrqeenucggtffrrghtthgvrhhnpeefudetheeijefhledufeejvdetteeiueefteeu
    jeekieeukeeuheegveehueeftdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhhpvggrrhhs
    ohhnqdhlvghnohhvohesshhquhgvsggsrdgtrg
X-ME-Proxy: <xmx:geYBZeMDHBHhrXMW3x8wCG3a2W_cQ3IvNFpA1dPikjhOHD7PqSt2gw>
    <xmx:geYBZc4FkyiaEVswUuYHjaM10z9opw-LtmNwnilr6pjrrOdi4mhBIA>
    <xmx:geYBZQ5R_JcGpGOJg9anlIWN1p0O_ad7SqW5yMlhiWz0wBTbYIl7Sw>
    <xmx:guYBZb2dL2Noto2A-HRnB0M689zLVHKQGZMh_NGj8JwGOOIMojl6XQ>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 02C51C60091; Wed, 13 Sep 2023 12:42:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-745-g95dd7bea33-fm-20230905.001-g95dd7bea
Mime-Version: 1.0
Message-Id: <c05afb18-bca5-4500-877d-d44ef3abc310@app.fastmail.com>
In-Reply-To: <d26d4b15-765b-a444-b740-97f95f2db58d@redhat.com>
References: <20230906195204.4478-1-fevalle@ipt.br>
 <d26d4b15-765b-a444-b740-97f95f2db58d@redhat.com>
Date:   Wed, 13 Sep 2023 12:41:42 -0400
From:   "Mark Pearson" <mpearson-lenovo@squebb.ca>
To:     "Hans de Goede" <hdegoede@redhat.com>,
        "Fernando Eckhardt Valle" <fevalle@ipt.br>,
        "Henrique de Moraes Holschuh" <hmh@hmh.eng.br>,
        "markgross@kernel.org" <markgross@kernel.org>,
        ibm-acpi-devel@lists.sourceforge.net,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: sysfs interface to auxmac
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, Sep 13, 2023, at 11:58 AM, Hans de Goede wrote:
> Hi Fernando,
>
> On 9/6/23 21:52, Fernando Eckhardt Valle wrote:
>> Newer Thinkpads have a feature called Mac Address Passthrough.
>> This patch provides a sysfs interface that userspace can use
>> to get this auxiliary mac address.
>> 
>> Signed-off-by: Fernando Eckhardt Valle <fevalle@ipt.br>
>
> Thank you for your patch. 
>
> At a minimum for this patch to be accepted you will need
> to document the new sysfs interface in:
>
> Documentation/admin-guide/laptops/thinkpad-acpi.rst
>
> But I wonder if we should export this information to
> userspace in this way ?
>
> The reason why I'm wondering is because mac-address passthrough
> in case of using e.g. Lenovo Thunderbolt docks is already
> supported by the kernel by code for this in drivers/net/usb/r8152.c :
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/usb/r8152.c#n1613
>
> So I'm wondering if we really need this, is there a planned
> userspace API consumer of the new sysfs interface ?
>
> Or is this only intended as a way for a user to query this, iow
> is this purely intended for informational purposes ?
>
Hi Hans,

We've previously had strong pushback from the maintainers in the net tree that the MAC passthru should not be done there and should be done in user-space. I'd have to dig up the threads, but there was a preference for it to not be done in the kernel (and some frustrations at having vendor specific changes in the net driver).

We've also seen various timing issues (some related to ME FW doing it's thing) that makes it tricky to handle in the kernel - with added delays being needed leading to patches that can't be accepted.

This approach is one of the steps towards fixing this. Fernando did discuss and review this with me beforehand (apologies - I meant to add a note saying I'd been involved). If you think there is a better approach please let us know, but we figured as this is a Lenovo specific thing it made sense to have it here in thinkpad_acpi.

There will be a consumer (I think it's a script and udev rule) to update the MAC if a passthru-MAC address is provided via the BIOS. This will be open-source, but we haven't really figured out how to release it yet.

Fernando - please correct anything I've gotten wrong!

Mark
