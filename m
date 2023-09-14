Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759107A0EF6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 22:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjINUaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 16:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjINUaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 16:30:24 -0400
X-Greylist: delayed 1206 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Sep 2023 13:30:19 PDT
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1E826B2;
        Thu, 14 Sep 2023 13:30:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1694723417; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=W0g/ZLB0LHM9tx+MqAX/wMSrMPKe2YlW4ErmpsO+RU9+/xuFdONuCpFg6PNd3KPPXW
    gtfhkFoYADd0UTq7yP5419xLg+9aug4CxPQbyUJt6akwVQo6FpKgtKzp/LG5pya0ySY+
    JFTdJtNvTq0wGBHFb5SR/kDtfNbYdcwG0dc46pQ5v1AU7QAm1BFV6y+hYTgQb2wTjUHq
    SGYubJySIA8To0MBrCzTGE5452us+KqPhGwQSoIoEIqnmXqwKcmnpNSB3QAJfiSuJAXx
    AcClkLGFx5qNmhsJoSKB+izHu0UskU2wp6xE32uBNcvG6MBEfoPRyfN8Jqt6ZyH1Ve8Y
    NfrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1694723417;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Qm6cwWzKtshyoFGnpStu0NB/ynnONWUDquxu6ya0YbE=;
    b=eViYGkG569sjAFNSVhu5QwVYCmjiOHioL1WFoyFPXdRrK8Eu8Ck87xEGKLVORfCuu9
    csVFV1BcitWnYriyQS0DnBu9gyeE6oswOg25l6Ad4SvPc9yWoXMGMRBvbv/QuI1T7Ka3
    FuAGuXZUVH59D/BCuHYSDlAm1CmAZiugNFioD9Swuz1mEMg1b/zb3zL4UeTDqhY6MIZz
    hPJ3Sa25ySLqRqKpluRn1jZiFSKU4ygVN0fxo3/9OkG3HObWDzr55VTuhcK7/xL3cKyj
    FawHcFu57Olsghn3QHxWkqYwF9qWt89BnjHPBZATKLsaJjaB7Eb+p8wNu0r8+QGDm4pd
    cfWQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1694723417;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Qm6cwWzKtshyoFGnpStu0NB/ynnONWUDquxu6ya0YbE=;
    b=bjBckR7WgKFXDGMTYAkGocIxWS36sQBPPNHLhTxlyBKlvgS3eThohwLqSwp7PoetDC
    rYceV9I8EXODAuju3MaSL4VcHMOIPMfakAzPDYHNCticvn29rHG5T1/yqIR/wuRaHxk1
    rFivUDRUADJ40sqhlH+PTR7HpX35RIw4KXTI2yyqJRsfLQRhMbkWdPRP46z/KxemXJkk
    w/AJifRjLA7vWsZ0q2iCixeEWJujwDUwWsmnOTzvbEHQKnMMFaAdTw+XaRjqxBa/IKeA
    rdKEqi7H2xM0i0lYAZIFxVpayq+AXzKVNsgrG8sDEmf6d18Iyazb05gs8Dfmun11EwAL
    yaEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1694723417;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Qm6cwWzKtshyoFGnpStu0NB/ynnONWUDquxu6ya0YbE=;
    b=L2UO5p2RTTxOd4T4tbiU+x0mUjpoDt3KgVCODRcBkc0BcTZ5uwzvlAL4PLzB7DOaV5
    xuOJAfim+vdfADJl7PDA==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSeBwhhSxarlUcu05JyMI1zXvWpofGAbhC22VTSyB8cMmLdLpWPYurOsVc7IfjM2CVzE="
Received: from p200300c58703581babbe27afdf2433f1.dip0.t-ipconnect.de
    by smtp.strato.de (RZmta 49.8.2 AUTH)
    with ESMTPSA id V04024z8EKUHDZZ
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 14 Sep 2023 22:30:17 +0200 (CEST)
Message-ID: <03a08d4c9f49287fe2d52862c78b59b6fd02e580.camel@iokpp.de>
Subject: Re: [PATCH v1] mmc: Add quirk MMC_QUIRK_BROKEN_CACHE_FLUSH for
 Micron eMMC Q2J54A
From:   Bean Huo <beanhuo@iokpp.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     adrian.hunter@intel.com, beanhuo@micron.com,
        jakub.kwapisz@toradex.com, rafael.beims@toradex.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Date:   Thu, 14 Sep 2023 22:30:17 +0200
In-Reply-To: <CAPDyKFrt4r88RhCg1XigFtd8xSrLLbHeD31ZAEA0aUDkNzRxGQ@mail.gmail.com>
References: <20230913185735.459661-1-beanhuo@iokpp.de>
         <CAPDyKFrt4r88RhCg1XigFtd8xSrLLbHeD31ZAEA0aUDkNzRxGQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ulf,=20

I just updated v2, please have a check, let me know if you need any
change, and you have the new suggestton, thanks.

Kind regards,
Bean
