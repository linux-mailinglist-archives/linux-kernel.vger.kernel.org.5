Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64527E1A31
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 07:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjKFGXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 01:23:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjKFGXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 01:23:03 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD25B8;
        Sun,  5 Nov 2023 22:23:00 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 198183200413;
        Mon,  6 Nov 2023 01:22:56 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 06 Nov 2023 01:22:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1699251775; x=1699338175; bh=QEDT7Q9vXOEx9pnfpkF8jfubicEiWpDix/1
        DbJXSEWk=; b=v7KOr+LGBrATsZZo9umSRYiW6sz4gy6YMP2H7yx22A0kel7+oxj
        fGFu18gBj9XDgIZnaGsrVjpLhRz+MvBqqcX80oL8mp9yWT8rXnPtMJNJxpuJLFrV
        mnQ4Vs9h2g4Wz22JXT/OXRELubJAKrfXtUyKtHpANIKTJa9TvItFHlY/OulYpFq+
        oPB5NvfRFISSqRnD7+TQgBPV+faxsFmjoRV7KZ/XN6VSjAUB488UjQ8AkNPx1wEg
        k4WEI+g+F2erO/8TpEY+2bhjDIHzzHShiLpyL11cfIk/j2fk8RZafQqajHJFRdNL
        djmRZD+rstvkC1WYD/igevN9fpgx2AGxVrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1699251775; x=1699338175; bh=QEDT7Q9vXOEx9pnfpkF8jfubicEiWpDix/1
        DbJXSEWk=; b=h5slOrUb0ExWK9taaE9QhkQ5HsOM9bs8wnnoQ3fcf6aincRfg9U
        ZbymaKcfjHBvxS73nNdNx6j5jjOdcX2yhuRkj8FnftxgnHnZLHnDf5hVzSJJyLPR
        IKBwPKdW3BySCGTzbbRVIBmkhQhLt2T09mzGaE1lGu49m06psKQ3G9XGGtosaMjx
        KYRIfImHuh10LsYHheFO4rRvYgPSBPk0ujLwsTxdSei9E8JYaxN4KX1Z2pnWAPxV
        vYQj+FQjbRoI4dDDU0ar9XgTbVBQYtQ/TKUxP/PgT/xCvsf2QKcqscH0JYPcBk0d
        Yb0WH8bzv37/S52IJEI93uZdDOz1v0vc0HA==
X-ME-Sender: <xms:P4ZIZQtHFv96l8GhKR6AGMluXVtYPJNFaIGBtRCEzahBUEaonaiApQ>
    <xme:P4ZIZdc9avBcszsQ697LYN8qcuiJfodQBCV4-R3CCG0O_WAvpWtO2r8_knL0YhmQf
    W6Ci11qdQOs>
X-ME-Received: <xmr:P4ZIZbzWXzzzlU5huimyVe0KKHuVDJkCzLg1nCu38-x0vm-66Gl6TWQv-I66qJ8S2St6unKJ8s-nv3MKocTW2A4q-UR7yXKyvyxUuEcGLVIqm2udFJJWqt_p>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddufedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfhffvvehfufgjtgfgsehtjeertddtfeejnecuhfhrohhmpefkrghn
    ucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnh
    eptdeigfeuuddvleefieekhfevteeivdeuudfgffdvudeljedtfeejteffhefhleeunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnh
    esthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:P4ZIZTPC7hEcJ-6z7OEmzy1kx_iftGs5yLh_MDOjiBtL371RTradcA>
    <xmx:P4ZIZQ9GaqI4KNn1o8AZUbTx7IEKEMI781wIR5I-1ZfHZpXtyUFDPg>
    <xmx:P4ZIZbXq67pEwGcITal--xXCDLFBrEbVKKbPG2_sdVa2tZ0CettA7Q>
    <xmx:P4ZIZfYRAdyEjO4-8L3RxRB7bHbZndP-TmG9RoouHDBReCX4q8-ffA>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Nov 2023 01:22:52 -0500 (EST)
Message-ID: <83a889bd-3f9e-edce-78ff-0afa01990197@themaw.net>
Date:   Mon, 6 Nov 2023 14:22:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
From:   Ian Kent <raven@themaw.net>
To:     Christian Brauner <brauner@kernel.org>,
        David Howells <dhowells@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bill O'Donnell <bodonnel@redhat.com>
References: <20231027-vfs-autofs-018bbf11ed67@brauner>
 <43ea4439-8cb9-8b0d-5e04-3bd5e85530f4@themaw.net>
 <ZT+9kixqhgsRKlav@redhat.com>
 <61f26d16-36e9-9a3c-ad08-9ed2c8baa748@themaw.net>
Content-Language: en-US
Subject: Re: [GIT PULL for v6.7] autofs updates
In-Reply-To: <61f26d16-36e9-9a3c-ad08-9ed2c8baa748@themaw.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/10/23 10:12, Ian Kent wrote:
> On 30/10/23 22:28, Bill O'Donnell wrote:
>> On Sun, Oct 29, 2023 at 03:54:52PM +0800, Ian Kent wrote:
>>> On 27/10/23 22:33, Christian Brauner wrote:
>>>> Hey Linus,
>>>>
>>>> /* Summary */
>>>> This ports autofs to the new mount api. The patchset has existed for
>>>> quite a while but never made it upstream. Ian picked it back up.
>>>>
>>>> This also fixes a bug where fs_param_is_fd() was passed a garbage
>>>> param->dirfd but it expected it to be set to the fd that was used 
>>>> to set
>>>> param->file otherwise result->uint_32 contains nonsense. So make sure
>>>> it's set.
>>>>
>>>> One less filesystem using the old mount api. We're getting there, 
>>>> albeit
>>>> rather slow. The last remaining major filesystem that hasn't converted
>>>> is btrfs. Patches exist - I even wrote them - but so far they haven't
>>>> made it upstream.
>>> Yes, looks like about 39 still to be converted.
>>>
>>>
>>> Just for information, excluding btrfs, what would you like to see as 
>>> the
>>>
>>> priority for conversion (in case me or any of my colleagues get a 
>>> chance
>>>
>>> to spend a bit more time on it)?
>> I'm just starting to have a look at zonefs as a candidate.
>> -Bill
>>
> And devpts looks fairly straight forward and is used a lot ... I'll 
> see if
Christian, David's original conversion patch for devpts looks like it's

still relevant, it also looks fairly small to the point that I'm wondering

if it's worth breaking it down into smaller patches.


Would you be ok with me just doing a straight patch apply, detailed review

and some testing before posting it?


David, are you ok with me resurrecting your conversion patch and posting it

on your behalf?


Ian

