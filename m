Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFAF813385
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 15:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573549AbjLNOsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 09:48:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573547AbjLNOsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 09:48:10 -0500
Received: from mail.helmholz.de (mail.helmholz.de [217.6.86.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BC212B
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 06:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=helmholz.de
        ; s=dkim1; h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date
        :Subject:CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=JOrkzxGekcw7VHo53kYxfb41EEzQLNXXXNM04Cve1jE=; b=WpdW/17kBvvf0FVKA68/EvHW+p
        XDWIEfP9wcJ6Ypj1NIZF/4VKl7k4aQeeubhKcuYGmVU5Ws6QDsQILesh3NWKwN/oLO6VezzDqDZv3
        ztYn7KvZMdvW8SMC4dw09Xbx0DXV5XxnNLiizFmaaQQrRuU/PmW9QFTBX7av75rO1Oe5kKOXtiXbH
        Lp1RdJR1k2VZoc4TVL5ltIdI3zb1BHuIbTYet0CcFqZQ4LlFUfuWlTsMt5rqI4Zb1NOzskSgoMTE5
        262hTKAmaNye0nw+5TvZUi25cqx39ercWw1gq2UsevixFXaZWsma5zGy3FzrzMKc0fXPIF9WCUjDG
        Z/HoSvKQ==;
Received: from [192.168.1.4] (port=36326 helo=SH-EX2013.helmholz.local)
        by mail.helmholz.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
        (Exim 4.96)
        (envelope-from <Ante.Knezic@helmholz.de>)
        id 1rDn0E-0000XH-2U;
        Thu, 14 Dec 2023 15:47:54 +0100
Received: from linuxdev.helmholz.local (192.168.6.7) by
 SH-EX2013.helmholz.local (192.168.1.4) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Thu, 14 Dec 2023 15:47:54 +0100
From:   Ante Knezic <ante.knezic@helmholz.de>
To:     <olteanv@gmail.com>
CC:     <andrew@lunn.ch>, <ante.knezic@helmholz.de>, <davem@davemloft.net>,
        <edumazet@google.com>, <f.fainelli@gmail.com>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: dsa: dont use generic selftest strings for custom selftests
Date:   Thu, 14 Dec 2023 15:47:51 +0100
Message-ID: <20231214144751.1507-1-ante.knezic@helmholz.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20231214142511.rjbr2a726vlr57v4@skbuf>
References: <20231214142511.rjbr2a726vlr57v4@skbuf>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.6.7]
X-ClientProxiedBy: SH-EX2013.helmholz.local (192.168.1.4) To
 SH-EX2013.helmholz.local (192.168.1.4)
X-EXCLAIMER-MD-CONFIG: 2ae5875c-d7e5-4d7e-baa3-654d37918933
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Indeed I do have a custom implementation for the mv88e6xxx chip, but its not
come to state to be posted because of test/chip specifics.

> I didn't notice when the selftest support was added that there is no
> implementation in DSA drivers of custom ds->ops->self_test(). Adding
> interfaces with no users is frowned upon, precisely because it doesn't
> show the big picture.

I was not aware of this, I apologize. If this is the case, perhaps this patch
should wait for the first custom self test implementation and be reposted as
a part of bigger series.

Thanks,
Ante

