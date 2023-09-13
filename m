Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE1279F0CA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 20:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbjIMSCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 14:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjIMSCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 14:02:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267F419AF
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 11:02:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1560C433C9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 18:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694628122;
        bh=JN7lHLS1BCA7WmhHqTgRkEkyRayhnajLCQX5GGmGnlY=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=IPmOZRYgD3UzyQ+ByzTorIC+Y021pd0FO+Qkz6Cqcmz4oehCEbaSYHFQV1czN6pfD
         dWnaj4Q7JLl9mIMrXddpgL+wCL/YvQekSMexHx7rnW0Sq/rw1zw6kQHJDKKDljouYL
         lPk0Rmu23VmQO2v33LAQY/RAHiXhTeYtwbmTEtrrAV14UufcWVgyDOnbZ1dSFvxVsK
         pCCIzkIF2zOWHmo2aZG1cD3UTgD05lx6IQUZK1wU20gcbaB5H/Z5PxOaWO61wi+d/2
         XdbY12gN9d8dNdxAj1jaqkOlyEACdA6Ne2ohVKcT6OlOCLZHfzeS3DGeQQdTH/6Ss7
         EMlMTwR89zHkQ==
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 6BAAA27C0054;
        Wed, 13 Sep 2023 14:02:01 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Wed, 13 Sep 2023 14:02:01 -0400
X-ME-Sender: <xms:GfkBZbyOTbl39ER64zsDVtbfWma0UOwtMM4UYwEhNjhbJ15KzdRcmg>
    <xme:GfkBZTMvCJo77WJwp5DNth4VSMXiN98GP9A21Q6Zj1_tF3CpC8v5RTCt5I5Od3U6v
    6ZlXu6hMzO6ODJVauY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeikedguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugeskhgvrhhnvghlrdhorhhgqeenucggtf
    frrghtthgvrhhnpedvveeigfetudegveeiledvgfevuedvgfetgeefieeijeejffeggeeh
    udegtdevheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrrhhnugdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidquddvkeehudej
    tddvgedqvdekjedttddvieegqdgrrhhnugeppehkvghrnhgvlhdrohhrghesrghrnhgusg
    druggv
X-ME-Proxy: <xmx:GfkBZSPgDE6JltUmnwTxUzszCowlzSK6582fZMUW7IwlGiQYK429UQ>
    <xmx:GfkBZdTNyYg82R0pqEeDN3NgNU4UHOA9fPBq856CH4zIohzqIXoX3A>
    <xmx:GfkBZcAkSDM3_4EkODTWa8yJ8N_9FYXtApLAoQQaetEXNahYZ2fkoQ>
    <xmx:GfkBZTDiUaodPudnYGY_kWM0tvFBpMJ8nHQZYZr8G2ZU-DUGodmMrQ>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0C3C6B60089; Wed, 13 Sep 2023 14:02:01 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-745-g95dd7bea33-fm-20230905.001-g95dd7bea
Mime-Version: 1.0
Message-Id: <83c58cdc-b96a-40c3-bed1-767e9e832893@app.fastmail.com>
In-Reply-To: <79be8582-2395-42c7-92ae-29d9e4c4c33b@mev.co.uk>
References: <20230913112032.90618-1-abbotti@mev.co.uk>
 <20230913112032.90618-10-abbotti@mev.co.uk>
 <ca073163-d947-42f4-b45a-3ea75ab2f7fc@app.fastmail.com>
 <79be8582-2395-42c7-92ae-29d9e4c4c33b@mev.co.uk>
Date:   Wed, 13 Sep 2023 20:01:40 +0200
From:   "Arnd Bergmann" <arnd@kernel.org>
To:     "Ian Abbott" <abbotti@mev.co.uk>, linux-kernel@vger.kernel.org
Cc:     "Niklas Schnelle" <schnelle@linux.ibm.com>
Subject: Re: [PATCH 09/13] comedi: ni_mio_common: Conditionally use I/O port or MMIO
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023, at 17:45, Ian Abbott wrote:
> On 13/09/2023 13:17, Arnd Bergmann wrote:
>> On Wed, Sep 13, 2023, at 13:20, Ian Abbott wrote:
>>>
>>> The changes make it possible to build the ni_pcimio module even if the
>>> port I/O functions have not been declared.  (The ni_atmio and ni_mio_cs
>>> modules do still require the port I/O functions to be declared.)
>> 
>> I think this all works, but there is probably a simpler way to
>> achieve the same:
>>   
>>> +#ifdef PCIDMA
>>> +
>>>   static void ni_writel(struct comedi_device *dev, unsigned int data, int reg)
>>>   {
>>> -	if (dev->mmio)
>>> -		writel(data, dev->mmio + reg);
>>> -	else
>>> -		outl(data, dev->iobase + reg);
>>> +	writel(data, dev->mmio + reg);
>>>   }
>>>
>>>
>>> +#else /* PCIDMA */
>>> +
>>> +static void ni_writel(struct comedi_device *dev, unsigned int data, int reg)
>>> +{
>>> +	outl(data, dev->iobase + reg);
>>> +}
>> 
>> We already have an abstraction for this using iowrite32(),
>> which turns into either writel() or outl() depending on the
>> argument, so you could just use pci_iomap() or ioport_map()
>> to turn port numbers into tokens suitable for the common
>> helper.
>
> It would affect three modules, and there are similar changes that could 
> be made to other modules, so I think I'll put that suggestion on hold 
> for now.  I'd also like to get rid of the '#include "ni_mio_common.c"' 
> nonsense at some point, but that's a big job!

Sure, that's fine, I just thought I'd mention it in case you
were looking for a nicer implementation. I wouldn't have done
the current series to start with since there is not a huge amount
of value in running these drivers on obscure architectures
without HAS_IOPORT, but your changes are otherwise completely
sensible.

  Arnd
