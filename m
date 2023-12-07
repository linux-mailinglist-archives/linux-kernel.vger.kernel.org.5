Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F16EA808778
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 13:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbjLGMRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 07:17:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbjLGMRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 07:17:49 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A84FAC;
        Thu,  7 Dec 2023 04:17:56 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 7ECAD5C020C;
        Thu,  7 Dec 2023 07:17:55 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 07 Dec 2023 07:17:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1701951475; x=1702037875; bh=Nt
        Da3bmDnBgDJ8cjhBgyb1XZxGUsc6kwF8XIFSHAYps=; b=sR7aLfz/POgf0+KsJ3
        tQls6OMNBbq7suqFMGkdFziuX5Kw9vJbA4xxFZkqVIfELwpYaRJyhHQPf+vwPHe6
        PpuPPiTKxzvsKaLzF2/WVPqOLb9AtSAHBUo1c4XTrvpEYjmw2DMEkzgyyg3YRPMg
        8n/KjV5JBN/Y+a9ye4A2ZjN+cz1tpNkryC7ysV6pwfU8749v3SVJC7uJxuQEjR6I
        k/tkhcO9MyxTJFJbLGiHuA/cAvjqrWdtqiOgoP4pYd7535jFDziY4mBigPO5AY2s
        Hxc+E3cOWAq62mI7D8RMBlnVQz3y485D/JA8jn7W/RIF2DdTqZX4b0JiFvGkqwqs
        HV5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1701951475; x=1702037875; bh=NtDa3bmDnBgDJ
        8cjhBgyb1XZxGUsc6kwF8XIFSHAYps=; b=GvHgfuOpl1+MRVOT0xlNScBj29na7
        qeTPopgVkVPIbjBuRL1wB2qd5xVqUQUAoh2isIBSjLC4xHWh5HSCa+MKvBm47vGg
        r6BpgVXhDR8ZhNd1DpPesk/Vq0UgGFrrzBsBCrP+anPAQzBrUpUYWEiCxBWY2LxC
        cu9n2LSvDlWRwnNT8R39g7Jqe5VVP6wjzLb2BxzfSGYeaehCKoXjYaG5SRLYd6MT
        UImnimiFgc/sxBE+GXAZESuPQhu9Zic6azcZWQl8sZXLqqqyV0+kX8g9HQu/c5BT
        geAYPecwBQduwRVqM//GxUZg3cVwvS/mTyz/WxFlLaEp79nqQpTERev7w==
X-ME-Sender: <xms:8rdxZfeRUypt0szpz-KcZS-PW5Q-YK6wTdbxJCEojN16xaT4y-qwkw>
    <xme:8rdxZVMsYyQYqe2PrXw8FWfp4N7T8KONwX49iBiPp92HMWP6HgwXOMkkdi4nR1xbr
    pcoltxZU_cJSFTW1OU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekvddgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:87dxZYjJ8GXEM8vBYvzj-sJ9olY-Hge6p7aPsyFpaMlGpHxv3EsdyA>
    <xmx:87dxZQ9r2bpfwBkV_KTmGQIQbQJajexQXrxmhrM1uJSjBqYTGsMq2A>
    <xmx:87dxZbvT2dScZhlgOQNtlj8pfQZkUrAK_GQg_WVGIGrNyUmZ-pxHlg>
    <xmx:87dxZRUfeReWgy1oy2AED-Bo5WFu0quofZOnUORtNG6HML_tBCiu6A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C3D73B60089; Thu,  7 Dec 2023 07:17:54 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1178-geeaf0069a7-fm-20231114.001-geeaf0069
MIME-Version: 1.0
Message-Id: <a6232a15-a7e6-47fd-ad4b-07319932a6f8@app.fastmail.com>
In-Reply-To: <CAA8EJpp+ikpFZ1BL4PZJG_kK3n_u3mTTGZjd8A+=20gPm_SOyA@mail.gmail.com>
References: <20231206123828.587065-1-arnd@kernel.org>
 <ZXGySCtdsxW4qCel@kuha.fi.intel.com>
 <CAA8EJprV3O24V0+MnPK1OdQZQ_7F2aMfN1Um13eH9ux4J+ucMw@mail.gmail.com>
 <ZXGzJlv9C3Z9lMeI@kuha.fi.intel.com>
 <c1df6dc4-ad3f-41ba-b024-1b432dac7af1@app.fastmail.com>
 <CAA8EJpp+ikpFZ1BL4PZJG_kK3n_u3mTTGZjd8A+=20gPm_SOyA@mail.gmail.com>
Date:   Thu, 07 Dec 2023 13:17:33 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>
Cc:     "Heikki Krogerus" <heikki.krogerus@linux.intel.com>,
        "Arnd Bergmann" <arnd@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Neil Armstrong" <neil.armstrong@linaro.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: nb7vpq904m: add CONFIG_OF dependency
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 7, 2023, at 13:12, Dmitry Baryshkov wrote:
> On Thu, 7 Dec 2023 at 14:00, Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> On Thu, Dec 7, 2023, at 12:57, Heikki Krogerus wrote:
>> > On Thu, Dec 07, 2023 at 01:55:06PM +0200, Dmitry Baryshkov wrote:
>>
>> > Okay, so this probable should also be
>> >
>> >         select DRM_AUX_BRIDGE if DRM_BRIDGE and OF
>> >
>> > No?
>>
>> I think that fails if CONFIG_OF is disabled and
>> CONFIG_DRM_AUX_BRIDGE, since drm_aux_bridge_register()
>> will still be called from a built-in driver in that
>> case but can't be linked against.
>
> If DRM_AUX_BRIDGE is not enabled, then the stubs from
> include/drm/bridge/aux-bridge will be used instead.

Sorry, I meant to write CONFIG_DRM_AUX_BRIDGE=m here.

     Arnd
