Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B143F7CDE4A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344837AbjJROHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbjJROHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:07:07 -0400
Received: from mail.helmholz.de (mail.helmholz.de [217.6.86.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B17510E
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 07:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=helmholz.de
        ; s=dkim1; h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date
        :Subject:CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=vC793F9pwZbiBpRG56Ys5EhHpAk5IB8eRIKOaHXn80o=; b=dwWdKfK1CygWWhMzyc5akjnX08
        Ie7n8wdpW4KEG/I78AQjX6kMFwdluu3jjEDJxj+h8dRGLTyLrXsQskQ+Ed6sH/e4FLIGpgR9DISQO
        O/vRVYoclkGSsP/MrdHlOlncx9XDf1CHydz6Sg3GJNiUNfAeBvlajfDwjRYCFn2lYVQxL2lJ5Cat4
        SdFBGgxmFjvxgx3wwoJcVjTXU9Gt7jYxHg7yefp3CTi0Fe6UmmOS7lULBnUJGoCSX3eZzONYwtfbi
        wEZXos0lI3fPUc1OAWtGrh2n9ROHQZphEl8q5KWmnDGK+9Grb8IATSQtQlsN/g8UBoxzVZdu7FL0S
        SfmsM2gg==;
Received: from [192.168.1.4] (port=25357 helo=SH-EX2013.helmholz.local)
        by mail.helmholz.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
        (Exim 4.96)
        (envelope-from <Ante.Knezic@helmholz.de>)
        id 1qt7C0-00016h-00;
        Wed, 18 Oct 2023 16:06:36 +0200
Received: from linuxdev.helmholz.local (192.168.6.7) by
 SH-EX2013.helmholz.local (192.168.1.4) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Wed, 18 Oct 2023 16:06:35 +0200
From:   Ante Knezic <ante.knezic@helmholz.de>
To:     <andrew@lunn.ch>
CC:     <UNGLinuxDriver@microchip.com>, <ante.knezic@helmholz.de>,
        <conor+dt@kernel.org>, <davem@davemloft.net>,
        <devicetree@vger.kernel.org>, <edumazet@google.com>,
        <f.fainelli@gmail.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <kuba@kernel.org>, <linux-kernel@vger.kernel.org>, <marex@denx.de>,
        <netdev@vger.kernel.org>, <olteanv@gmail.com>, <pabeni@redhat.com>,
        <robh+dt@kernel.org>, <woojung.huh@microchip.com>
Subject: Re: [PATCH net-next v3 2/2] net:dsa:microchip: add property to select
Date:   Wed, 18 Oct 2023 16:06:28 +0200
Message-ID: <20231018140628.4149-1-ante.knezic@helmholz.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <92a18413-fa28-4420-88f8-e7dedaa8c45e@lunn.ch>
References: <92a18413-fa28-4420-88f8-e7dedaa8c45e@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.6.7]
X-ClientProxiedBy: SH-EX2013.helmholz.local (192.168.1.4) To
 SH-EX2013.helmholz.local (192.168.1.4)
X-EXCLAIMER-MD-CONFIG: 2ae5875c-d7e5-4d7e-baa3-654d37918933
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Oct 2023 15:52:27 +0200, Andrew Lunn wrote:

> It looks like this is the only use of dev->rmii_clk_internal? So does
> it actually need to be a member of ksz_device? 

Yes, I guess you are right, sorry about that, it probably won't be used later
on and should be removed from ksz_device.
I will repost if the rest of the patch is ok?
