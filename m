Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8306876A992
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 08:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbjHAG67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 02:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjHAG66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 02:58:58 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFB21BD
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 23:58:53 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B3561E0007;
        Tue,  1 Aug 2023 06:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1690873132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N5FAqOX/33n4uDpymzBUG8KgidPfOT4KtVFrkPH1G2o=;
        b=KJtnGFYKCzwPhpLbN7Q4usbgj03CTiHxHRd2Qa56IhSRffPYRSc+P2xepM3msWRxzkJDAD
        ROckkMbzKw6RQiI+JRfRzBrTNkWRvCYWWJLWxhac8jhfhrnyCuQ1xhzqfHRT1pSDijYp1c
        ctquRptT1Qjvb7lsZQXaqZZP8GMRPY83yKayLf8j/2LDFTcsAaf8TTZeYEbNWa9QifvusK
        JsWHaasNQKnZ+4eQTk/NJaBq/QXgE2SyxsxtjRvVjRNvZdNNwQr6v7qSunXuhy/zkB7yDB
        x87Rwv7KenA9+86WdftoZuurdMCdKziUnauhU9hiAoyQ9YZERqlj+XNcAzJegQ==
Date:   Tue, 1 Aug 2023 08:58:47 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Zheng Zhang <zheng.zhang@email.ucr.edu>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
Subject: Re: kernel BUG in __put_mtd_device
Message-ID: <20230801085847.46c7db12@xps-13>
In-Reply-To: <CAC_GQSp7W=MoiWoWo+UFFcZ48JLwsnfL84QWTJm_DNLO7S9AxQ@mail.gmail.com>
References: <CAC_GQSpE5nbj7Lt=8sXu8GoSQTRd+=fpZb_zpVKQOJ4MxRHzsw@mail.gmail.com>
        <89021294.889167.1690781715755.JavaMail.zimbra@nod.at>
        <CAC_GQSp7W=MoiWoWo+UFFcZ48JLwsnfL84QWTJm_DNLO7S9AxQ@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zheng,

zheng.zhang@email.ucr.edu wrote on Mon, 31 Jul 2023 16:58:49 -0700:

> Could you tell me the base Linux version of this patch? It seems that the
> context is not consistent with 6.2 or newest version v6.5.rc4
> Thanks

mtd/next, where new changes have been brought to these functions

https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git/log/?h=3Dmtd/=
next

Thanks,
Miqu=C3=A8l
