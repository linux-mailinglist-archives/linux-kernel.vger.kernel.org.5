Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C430E7B75C9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 02:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239027AbjJDAYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 20:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238939AbjJDAYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 20:24:17 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18939BB
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 17:24:14 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 1EC3B3200AD0;
        Tue,  3 Oct 2023 20:24:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 03 Oct 2023 20:24:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1696379052; x=
        1696465452; bh=/UKkwVdBP1d7KWrH9FNcFecJY+sp4ujY+2GNflD9W9U=; b=x
        f1B/Iw5pggcld/6+mjJwTdix6yjdDJPprwAYhBiW3je2715EsbDpMc+e4U0fIHsB
        n9QPImPet++hoGtaaLPq7lE7hDCyUZiQI4u+ly2TCVq+5Wmvm6MwpLq0grIW2o16
        FFE23ZmJewtEjELG3hLSVKubtDx0pFdtzM0YJTooH9AtJ3pG9ikedZ8TVVitj7mo
        5Ks6A39JLdwsPUIhZoNoAdQrReqTcZeNZlR6cpCLepp4AexeHIpmNRv9lghvlY3V
        FfJIqqTfuWBxnyIy7vUV9NKw+tjrPODJoxqmG9yAKWAhLOUA0yho39Jvk9vU6SqE
        MQDi9+vLJyCvAs1DaBl8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696379052; x=1696465452; bh=/UKkwVdBP1d7K
        WrH9FNcFecJY+sp4ujY+2GNflD9W9U=; b=Muhmf6pewMUY4qh4PHLfhDck0JGaI
        Xv5zROIpxY60VdysQA5ImdO7K5bZfmbSEeX2UNTY4scjBZlQ+IXuwvO7RmqCk9l1
        uT+63qT3wz1KD4S01NnIcj7+uDT0ISq9RktRoyFsR4950URevIb1ZQO1tPfqx7qM
        zxsrv/1uFjUcVgN6SXc6i8wBzemZXIQ2GlFpPx5nQq02OC6kOoqrNDQJ8g+SuCks
        kGNhi5jSSWhKdiqVCIMQJ4lOySAtF1+Qg1ZrXZdumP6sSL3KNS+aeuYJR+iMzUO2
        We26k8SUCpzMobIsWKXf+MqsauAcy38OlpIwLuyS27GgQoi1DsxUrizKg==
X-ME-Sender: <xms:rLAcZQ1mLpcqAIqlg4ur5svb4uodiU-WifxcQd6hYooqMj0EDGO-Mg>
    <xme:rLAcZbE9Y7BXXsXfbDMN3wpLFIpWbioN7B6_29nhw6VlPYXHVgC0cEyKkA3HwRkTm
    NxXkFs0IKEKNtBKra0>
X-ME-Received: <xmr:rLAcZY6iOph1M5Tojkxp_QNb_nIJFgEuWiuXu1jHimY9DYh-bi_8-79U4jCLW7TXhKU_YMBh7cKVRSoqX6_JUiJQ8lV78yrLnA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeekgdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvrghkrghs
    hhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjh
    hpqeenucggtffrrghtthgvrhhnpeehhffhteetgfekvdeiueffveevueeftdelhfejieei
    tedvleeftdfgfeeuudekueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:rLAcZZ02zsJfxewQlQKe6sdt-eCFXEicFlZkKAXBwRqSpdUnftFDQw>
    <xmx:rLAcZTET3vEzw7VJ7JjCPpIwgB99ZVk8VFJ4SGkxlGfn0oJT7JFzng>
    <xmx:rLAcZS_O3jASfCWrmAQ-o4ta7YWFREi-gqV1yf1yi3FBocfRMh43cQ>
    <xmx:rLAcZWNDWOPU98iMARA2clOo7zon0j3dEC_HqxOWYQJdHKzxaPuQQA>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Oct 2023 20:24:11 -0400 (EDT)
Date:   Wed, 4 Oct 2023 09:24:07 +0900
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] firewire updates for 6.5-rc1
Message-ID: <20231004002407.GA48535@workstation.local>
Mail-Followup-To: Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
References: <20230704121847.GA26576@workstation.local>
 <f3d8c72b-cd30-490c-833f-5807bd74511f@kernel.org>
 <20230926140922.GA6538@workstation.local>
 <a12593c9-9ced-4bb8-b7a5-8247b08d0e0f@kernel.org>
 <0ed4012a-83a7-4849-92c4-87a86e1bbb84@app.fastmail.com>
 <9e335ce7-a4ac-45a0-afdf-9afca8a300d5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e335ce7-a4ac-45a0-afdf-9afca8a300d5@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

As long as seeing your recent conversation with your reporter, it looks
to be an issue specific to the reporter's 1394 OHCI hardware. I suspect
a quirk specific to it related to accessing to CYCLE_TIME register in
early time after powering on. It is the reason that I can regenerate the
issue in my set of hardware.

Would I ask you to request the reporter to inform the detail of
hardware? If possible, let the reporter open PC box and take some picture
of the hardware so that we can identify the ICs on the hardware?

Via pci.ids, we can see both 'ASM1083/1085' and 'VT6306/7/8' are used,
while I need to identify the IC to purchase an alternative so that I can
regenerate the issue.


Thanks

Takashi Sakamoto
