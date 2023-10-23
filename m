Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6AE7D2BDC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 09:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbjJWHtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 03:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbjJWHtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 03:49:49 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87CA10C4;
        Mon, 23 Oct 2023 00:49:46 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 0BB445C0153;
        Mon, 23 Oct 2023 03:49:46 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 23 Oct 2023 03:49:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1698047386; x=1698133786; bh=jv
        F0H7xnWwZRAAwUUNkTqyJaJ9N7e+TAfKEFJXYj+zU=; b=WX3/i+NCqFRTMyQZ5B
        QgUjUsWZzl5aM92AEQ9Z6Ftqr2puAjy+x2saptV4hk80zjVpVZC+NqylZV/oVaxt
        XT5muHlpMt+tRJcSBNTmC0tAfbMlyRSgnuafn7N/anTB4nOfjspswtfUKxzMYosD
        1so6NArwwGAPlSY/X8BoovP53fW554H6cOCIWer5/XB6XIW9DMifyLYMK4MBCGLk
        HV3fKESLcfBkxgr7+aeB5FlT6cmTbRPkxx3BwKzwvzDmaPvzmf0DoLfTrJXddMjv
        bgH82+sMT10IqYIG2cEFU/Lf1d5H6RQdpnOFSi9N9XQKp6K452oVYAWtGrfLySac
        IfRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1698047386; x=1698133786; bh=jvF0H7xnWwZRA
        AwUUNkTqyJaJ9N7e+TAfKEFJXYj+zU=; b=XS5yDnyOjtP2eXWrtE3ntIV31Hm9o
        TrQXGNqQLwWPK4TCeLMgVz9TcOD/Rpt54ky3YiOy29sLgINQka2acGFTWj70LXoG
        Mc+A5GwXCrx7GIAhBNcQ2AhBveRAlF90FimlZqo3X04NhdKhGMTAeXD2CtT9oNQE
        t0vSyr/05e7Gya4WCnhzcWiIw5k66GYtnV7sjikJ4BPs7inRzYhto9SaXPs7lRDm
        9s5JjualAoPsYHxpDMd7Bj78KPnMtz7O7AMFrMxb0xpJFrXdOUYDcoMEHyR5eAfl
        isxUu6BzEjF196IYIRkwM+DtkOdHsghSMTyi7blA/Iru69U9u8Z1GDJiA==
X-ME-Sender: <xms:mSU2ZXFa9OMxEB38OecXK5w2mElxF5iDiZzY7XRg50oOtow6YIJWqg>
    <xme:mSU2ZUUkbj6nQrgICAlpO7STqapHV_4uSzpDoxN4WPC8aLCbhIZHPKPmjINW5h6a9
    ogDLK7nIPTBoDsaWvI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeehgdduudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:mSU2ZZLHd8ZPpkL7sWJTNIIpg-QszcyiaJ1MXcdvEtNZhqS-4bCdTw>
    <xmx:mSU2ZVGRyPmjYk0ugDeiZwfL5VUz4xQoQWHWxAZBaiWSLixcHQabIQ>
    <xmx:mSU2ZdVp5P0M9iG8WblAXT7lBt2MARgySrPszko0xZTaWoY6yTkxdw>
    <xmx:miU2Zaj8wOtMeuYh49lsZPopkks88DFf4emljJoxJKhWl3R1La-P4g>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8CD9DB60089; Mon, 23 Oct 2023 03:49:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1048-g9229b632c5-fm-20231019.001-g9229b632
MIME-Version: 1.0
Message-Id: <784903c2-cae8-497b-9d67-48428c203c83@app.fastmail.com>
In-Reply-To: <2023102350-gumminess-crease-db03@gregkh>
References: <20231023144327.7d18a847@canb.auug.org.au>
 <2023102350-gumminess-crease-db03@gregkh>
Date:   Mon, 23 Oct 2023 09:49:25 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Greg KH" <greg@kroah.com>,
        "Stephen Rothwell" <sfr@canb.auug.org.au>
Cc:     "Ard Biesheuvel" <ardb@kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the tty tree with the asm-generic tree
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023, at 09:28, Greg KH wrote:
> On Mon, Oct 23, 2023 at 02:43:27PM +1100, Stephen Rothwell wrote:
>> Hi all,
>> 
>> Today's linux-next merge of the tty tree got conflicts in:
>> 
>>   arch/ia64/kernel/setup.c
>>   drivers/firmware/pcdp.c
>> 
>> between commit:
>> 
>>   cf8e8658100d ("arch: Remove Itanium (IA-64) architecture")
>> 
>> from the asm-generic tree and commits:
>> 
>>   8a736ddfc861 ("vgacon: rework screen_info #ifdef checks")
>>   acfc78823326 ("vgacon: remove screen_info dependency")
>>   555624c0d10b ("vgacon: clean up global screen_info instances")
>> 
>> from the tty tree.
>> 
>> I fixed it up (I deleted the files) and can carry the fix as
>> necessary. This is now fixed as far as linux-next is concerned, but any
>> non trivial conflicts should be mentioned to your upstream maintainer
>> when your tree is submitted for merging.  You may also want to consider
>> cooperating with the maintainer of the conflicting tree to minimise any
>> particularly complex conflicts.
>
> Deleting the files are fine, thanks!

Agreed, I was aware of the conflict and considered dropping the
ia64 portion from the vgacon series, but it seemed cleaner to still
leave it in there with the trivial conflict after I had structured
it in a way that would not regress ia64 in the middle.

    Arnd
