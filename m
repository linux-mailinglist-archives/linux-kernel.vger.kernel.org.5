Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95CF8810DFF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 11:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235205AbjLMJ4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 04:56:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235115AbjLMJ4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 04:56:11 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8202B83;
        Wed, 13 Dec 2023 01:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=J53kTNMBvWEkAO/bSUp7Ho2Y3MLseFzQQVNG/4UK0Uw=; b=xs16dtutLZRses+U1JMjvO+WNv
        9tdmBTTHg4/FSnoPksh8/UxwCbPph883G8hNNDJ5/p4VCYMYozo3idi/h2t/ZfaVrfc8MmhHFElho
        j2Pp8N64uiWn4OXnMHEufJz/v/VVmUiBq+R4SjgDq9XuYafO1Py6J4JZZxaq4RwkprH0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1rDLyM-002ntF-1O; Wed, 13 Dec 2023 10:56:10 +0100
Date:   Wed, 13 Dec 2023 10:56:10 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Jakub Kicinski <kuba@kernel.org>, Lee Jones <lee@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Li Zetao <lizetao1@huawei.com>, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH v3 1/2] leds: trigger: netdev: extend speeds up to 10G
Message-ID: <d72e5e51-b5e4-4527-bd13-7176b2e21fb7@lunn.ch>
References: <99e7d3304c6bba7f4863a4a80764a869855f2085.1701143925.git.daniel@makrotopia.org>
 <170142826116.3357002.9561246405642038358.b4-ty@kernel.org>
 <6577315e.050a0220.50f30.0122@mx.google.com>
 <20231211084656.26578d89@kernel.org>
 <657784f6.5d0a0220.617b5.20ee@mx.google.com>
 <20231211140546.5c39b819@kernel.org>
 <65778a83.050a0220.b2844.2af7@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65778a83.050a0220.b2844.2af7@mx.google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Thanks for the explaination... Sad... guess I have to wait, hoped I
> could have the qca808x series before proposing the at803x driver split
> but I guess it's not possible... Maybe I can try pushing the change for
> link_1000 for now and later add link_2500 ?

Yes, that is O.K. It should do link_2500 in software, and since it is
a static on/off, should cost nothing.

  Andrew
