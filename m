Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32BA761001
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 11:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbjGYJ7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 05:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233534AbjGYJ7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 05:59:35 -0400
Received: from mail.helmholz.de (mail.helmholz.de [217.6.86.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEAA19B0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 02:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=helmholz.de
        ; s=dkim1; h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date
        :Subject:CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=PimzidlpgVVhnYRjK6c7cWmgfe1QJE0ZbWUIM7tRxic=; b=uFtA+5T+aDNXiKrLjNf+s7IXYs
        MZraosNLvDIjvZqyxSuMpJF5iXcMyQsuxbWxwwzbWaoD4OOJ1mq8SBtP3uxUA0et3vXO0LrMv9piq
        +Z3F/w27GpUnfIUD2sigx08XWPX5UJzhaoG9J+P8NpN5H6eY2ctkOLur5BlfCxPU3Jx6oDsM4Ka11
        9B963IwlxbaHZmttu7POHuV7bZSTozKtIiv9I3EV2GGlL+jfIl8nGfUQe1kKc+OZjlweIkJ0c48WZ
        N/ipy2+lFuop+R4lwSSKU9c4+LFC9iAdFBJ+lE0UzilihTvJMZNnkH+7u/fZntWbH8H50qVUhnWsD
        FMkb2ARQ==;
Received: from [192.168.1.4] (port=54975 helo=SH-EX2013.helmholz.local)
        by mail.helmholz.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
        (Exim 4.96)
        (envelope-from <Ante.Knezic@helmholz.de>)
        id 1qOEpC-0000oB-10;
        Tue, 25 Jul 2023 11:59:26 +0200
Received: from linuxdev.helmholz.local (192.168.6.7) by
 SH-EX2013.helmholz.local (192.168.1.4) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Tue, 25 Jul 2023 11:59:25 +0200
From:   Ante Knezic <ante.knezic@helmholz.de>
To:     <pabeni@redhat.com>
CC:     <andrew@lunn.ch>, <ante.knezic@helmholz.de>, <davem@davemloft.net>,
        <edumazet@google.com>, <f.fainelli@gmail.com>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <olteanv@gmail.com>
Subject: Re: [PATCH net-next v3] net: dsa: mv88e6xxx: Add erratum 3.14 for 88E6390X and 88E6190X
Date:   Tue, 25 Jul 2023 11:59:25 +0200
Message-ID: <20230725095925.25121-1-ante.knezic@helmholz.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <30e262679bfdfd975c2880b990fe8375b9860aab.camel@redhat.com>
References: <30e262679bfdfd975c2880b990fe8375b9860aab.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.6.7]
X-ClientProxiedBy: SH-EX2013.helmholz.local (192.168.1.4) To
 SH-EX2013.helmholz.local (192.168.1.4)
X-EXCLAIMER-MD-CONFIG: 2ae5875c-d7e5-4d7e-baa3-654d37918933
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2023 10:56:25 +0200 Paolo Abeni wrote
> It looks like you are ignoring the errors reported by
> mv88e6390_erratum_3_14(). Should the above be:
> 
> 		return mv88e6390_erratum_3_14(mpcs);
> 
> instead?
> 

I guess you are right. Would it make sense to do the evaluation for the 
	mv88e639x_sgmii_pcs_control_pwr(mpcs, true);
above as well?
