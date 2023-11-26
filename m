Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5187F9258
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 11:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjKZKom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 05:44:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKZKok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 05:44:40 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB083BB
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 02:44:46 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 32FAA5C01D2;
        Sun, 26 Nov 2023 05:44:43 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 26 Nov 2023 05:44:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1700995483; x=1701081883; bh=bB
        D1JTLq5QkkoEDq3dObPg/Nlt3q3LXqmrxMYgIF6Z0=; b=mcWDHIW2Ad3sOAlSnl
        0LONXywf+rsEsPSiG6Zc5s9UW1iTTASGr/Yve7rLxh8vQRpXSFGB/IeDl1l1rXPz
        6oYe3lM6KGBZIpGsvqjXqyYiA8uIE2rVL6Xy7V5z8hlOmH9lvX+fKjyPOJrjqx3h
        feTBln0b+I9dwxlPbKBUrxn5BMgT1xVu1z1rKBMBuPmWGtBKAMBnjfW9XvCgrZes
        6PS0S3D8z9f8etQsMY+GABlQFH78kF3sz+cE0lhuziwFySDtP6aYnS5jpikqUaJh
        i8asoV283pJNudiZBTlX/PoTanOQGdIMiuGa+TQBw3aKC+qIDlpLPgZgiCwS6Mr5
        +VXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1700995483; x=1701081883; bh=bBD1JTLq5Qkko
        EDq3dObPg/Nlt3q3LXqmrxMYgIF6Z0=; b=z6IYFjiDykVasnglL5QDf145beZ2a
        jHJKIalMIYussGOvrV8aVBUQtR6j3RsMiIId1FJ3rMnV4c9gWQg/iZ73PyLGEXUs
        8/b5TCws7KXy9H+2DfBe9tccew1+Avyel3ul2Hkg/S+Li68NstuAn639ttspiNyh
        fTPkNG5WcUq+VjPtTAg6Fa8d01w3EZ2W++MS8BfXh5Z9T8VIWOiHdLcomMqIyOUD
        DoEZVBQjdchPV9PexbTn8j7TRikwpJISJ9ubUcHdmjAt9MScKurgueHioxjDvvkq
        +PeYnlp2Ccejb3N+57Bwv5EiP/KG1SLz+U9vC9MG9MUWd26XduohZAPrw==
X-ME-Sender: <xms:miFjZaI0WKTBX6HGXcroScTb5ucfwLX9__Vh4yFSukcLb1Ywic0fzg>
    <xme:miFjZSIRJoJPhpcCZzDlWaSFFd6u99YOBTP-zwyHPax-UrP0eQszy6T6pXKcTi2mH
    IdJLbj8EAy_rTh4lBg>
X-ME-Received: <xmr:miFjZasvUtzHvCUewDmk0wy88tZU8G4Wvo9lc8vuFwqKLOod7AjC3mH9_CaX7_BbqG7Wr3_EtyYqyARXoak4O9i2Nr8SSaIj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudehledgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfhgfhffvvefuffgjkfggtgesthdtredttdertdenucfhrhhomhepifgrrhih
    ucftohhokhgrrhguuceoghgrrhihrhhoohhkrghrugesfhgrshhtmhgrihhlrdhorhhgqe
    enucggtffrrghtthgvrhhnpeefleffhfegtefffefgfedugeehhfdvueefffegkeejvdeg
    leeiueelkeeiuddvheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehgrghrhihrohhokhgrrhgusehfrghsthhmrghilhdrohhrgh
X-ME-Proxy: <xmx:myFjZfZZWSa2jcwH_95dwBbDZevyf6gffIgwUmYsly75MO_VUOfA1Q>
    <xmx:myFjZRYW6hmuQBfPsVF8HHixxtHZrAQSZd-PdL8-NnOVyqiSR6zVpg>
    <xmx:myFjZbDHsUk_ZDdb_Dlt-m6Bw-owaFnlY3YgoosBCHleGLHe11tXxg>
    <xmx:myFjZQmQ3VJRzpT9ZIeHeu5Ci4vr8bwn58sh2HnDiS7RV7iCSetwxw>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Nov 2023 05:44:42 -0500 (EST)
References: <20231125223432.13780-1-garyrookard@fastmail.org>
 <20231125223432.13780-2-garyrookard@fastmail.org>
 <2023112616-scallop-drier-ab16@gregkh>
User-agent: mu4e 1.10.6; emacs 29.1
From:   Gary Rookard <garyrookard@fastmail.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     philipp.g.hortmann@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] staging: rtl8192e: renamed 2 variables nMcsRate,
 mcsRate
Date:   Sun, 26 Nov 2023 05:42:57 -0500
In-reply-to: <2023112616-scallop-drier-ab16@gregkh>
Message-ID: <87v89ox08b.fsf@fastmail.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Greg KH <gregkh@linuxfoundation.org> writes:

> On Sat, Nov 25, 2023 at 05:34:28PM -0500, Gary Rookard wrote:
>> Renamed 2 variables from CamelCase to Snake case nMcsRate
>> and mcsRate.
>> nMcsRate -> n_mcs_rate
>
> Please drop the "n".
>
> thanks,
>
> greg k-h

Okay, will redo.

Regards,
Gary
