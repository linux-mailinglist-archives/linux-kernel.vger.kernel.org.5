Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491817CAE65
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 17:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbjJPP5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 11:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233095AbjJPP5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 11:57:04 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A421D9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 08:57:02 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id C13515C03F8;
        Mon, 16 Oct 2023 11:57:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 16 Oct 2023 11:57:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1697471821; x=
        1697558221; bh=qheSn8cgMB/1M0FBPznZ4O51I2I1/tMbOJ326r+h01A=; b=D
        NreN3o7CerlQN1tv46JlR5wxt/LWjL2+hIELlJ2ALavX60yT3WCPvyAb00uRv5oJ
        Pnst5FFoUZivWJKuHfG0XjN79DF8PCzZIbtJS0Uy8lXiSdCSyaG67eXkptNvRKWc
        cRTDVxCb0QpU374T3N3vxXTk7Y0Y3vP+a3700nMcc9zfwA0DfmdbQ8Rk6ULHPFUQ
        NZ7amfYazFdPg9xM+ejYtS3tFel41pLU1Of4ISl1YLItS38SK1tBNWIpaCJrTDAB
        /bg/ypHsp4LZPDPwoqbtEgRK6xFki4dsHlMObhi3WXrPStqDea7uFxpjAVAJDUr/
        hf/y9PRiR4b1i8J9xw66Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1697471821; x=1697558221; bh=qheSn8cgMB/1M
        0FBPznZ4O51I2I1/tMbOJ326r+h01A=; b=L0FzRjTehIMMYA+I+SwLosGYzdL9Y
        PM8mtG/rJjqq/mTOMWHdwy+yTZtXJcnw5j27Cd3t7t7gVKNvnUygxwxe8BdEeGgg
        MAJmeesAxB7wq1iwD8yE3SWR6hj64TIy4PnHksWVi7Msbhdj1EQyYM9wL/6uKYpd
        Sg6WvCqrPavdwXjWgusjs2Lf46AtYT5WDJfvPVgYsGuVznQS8QjjFGts0FCqqmk4
        vMuzO34+hD+12uJotTVebZ6vsvRPTnv3y4FLg6hmg0TEJCcYVPyuDABTZx5JxDvc
        4n4hOVsC4ZsB8GaKKqEVsVF8unIzWugHyz0QFHuETF4pUln2a87FQa0ZA==
X-ME-Sender: <xms:TV0tZeaCR6atWcKZm0AiYcXFEV3ZkIqkfiZkeN2iGKmnssyrXYLlLQ>
    <xme:TV0tZRZ8C3S_4Xx-l4ZUPpy5aBpY7aOQh_u_lpMwoKIPNQsB3-C9zZfGhfeHlOs9h
    C9zLFXYP2NjUsawTPE>
X-ME-Received: <xmr:TV0tZY_xByqMdDRwgDyBhpcukKs6HopD_i_QmfQo8WaR45kM0eRj7mB3xNz8xJfVgzvtgF_ya8-uv5PQos88n52xPCz8NLtjKRg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjedtgdelvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvrghkrghs
    hhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjh
    hpqeenucggtffrrghtthgvrhhnpeefiedtkeelueekuddufefhheejgfevleekhffhffdt
    ffehtdelfeefvdevjeeuudenucffohhmrghinhepshhushgvrdgtohhmpdhrvgguhhgrth
    drtghomhdpghhighgrsgihthgvrdgtohhmpdhinhhtvghlrdgtohhmnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:TV0tZQrAH_-4rNZEN4BT41WnysZHiWx9XpHNQjx59lG_5DwHB65dVg>
    <xmx:TV0tZZqEiRjpEc-1ttNDRUjcXAtJHlSusakSCIM3cS4JXcBVELmvUA>
    <xmx:TV0tZeRtjkpIEi3PdsOSOXl45ab03acJoPMml33puInQrxeNTVEO8g>
    <xmx:TV0tZYQRBj3stuDZ5G8fgHHF5aBkjIZlbanAN_y8yNZFuuHoNqSpVw>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Oct 2023 11:57:00 -0400 (EDT)
Date:   Tue, 17 Oct 2023 00:56:57 +0900
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] firewire updates for 6.5-rc1
Message-ID: <20231016155657.GA7904@workstation.local>
Mail-Followup-To: Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
References: <20230704121847.GA26576@workstation.local>
 <f3d8c72b-cd30-490c-833f-5807bd74511f@kernel.org>
 <20230926140922.GA6538@workstation.local>
 <a12593c9-9ced-4bb8-b7a5-8247b08d0e0f@kernel.org>
 <0ed4012a-83a7-4849-92c4-87a86e1bbb84@app.fastmail.com>
 <9e335ce7-a4ac-45a0-afdf-9afca8a300d5@kernel.org>
 <20231004002407.GA48535@workstation.local>
 <13363c8e-22ec-48de-a471-91535ad1249f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13363c8e-22ec-48de-a471-91535ad1249f@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

I purchased 1394 OHCI hardware quite similar to the issued hardware
(VIA VT6307 + Asmedia ASM1083), then experienced that it causes the
issue in AMD chipset, but it does not in Intel chipset.

I use below machines:

* AMD Ryzen 5 2400G in Gigabyte AX370-Gaming 5 rev.1.0 (Bios version F51h) [1]
* Intel Core i3-2120T in Intel DH77DF (Bios version 0112) [2]

As long as seeing filed issues, the reporters use AMD chipset.

AMD Ryzen 5 3400G, MSI B450-A Pro: https://bugzilla.suse.com/show_bug.cgi?id=1215436
AMD Ryzen 7 3700X, MSI X570-A Pro: https://bugzilla.redhat.com/show_bug.cgi?id=2240973

Furthermore, I experienced that:

* guest machine can cause host reboot in Ryzen machine even if the 1394
  OHCI hardware is passed-through to the guest by vfio-pci (and
  firewire-ohci is loaded in the guest machine side)
* execution of lspci(8) in the host can cause the reboot when the hardware
  is associated to vfio-pci  (thus firewire-ohci is not loaded in the case).
  This issue is in Ubuntu 23.04 (v6.2 kernel).

At present, I suspect either or both iommu function and kernel
implementation.

For further investigation, I would like you to give some instructions
about the way to use OpenSUSE distribution. I want to boot the distribution
in 'low graphics mode' which debian/ubuntu distribution has. In the mode,
I expect to boot it without loading amdgpu module which depends on iommuv2
module.

Anyway, I would like you to check reporters' chipset when the similar
issues are reported. If they encounter the issue still in Intel chipset,
please inform it to me, since it could deny my current presumption.


[1] https://www.gigabyte.com/Motherboard/GA-AX370-Gaming-5-rev-10#kf
[2] https://www.intel.com/content/www/us/en/products/sku/59503/intel-desktop-board-dh77df/specifications.html

Thanks

Takashi Sakamoto
