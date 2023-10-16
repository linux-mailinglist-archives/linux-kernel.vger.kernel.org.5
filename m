Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFC57CA5F6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 12:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjJPKqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 06:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjJPKqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 06:46:10 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A1BE3;
        Mon, 16 Oct 2023 03:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1697453142; x=1698057942; i=linosanfilippo@gmx.de;
 bh=bW0faYX3QFZggYABRVO+bJd6LjbT8ErxZBv0s39WbyE=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=P/Ecl0YZnT5i/1gZ6YSGxbJLVYrwdSMOgLYH9JnVvWdS0XcMExcp93y60mIVj3uXwRkRZAV25ba
 pcef1/+8z2ao2ZHjp81tvuwhtUaVR8kBKedfHST39UA1OyyRsRKT42D3a5SGcJKrrEHPFLg6OE7pC
 3E7DTMMJznQXZF/kCbl8CUI/ejhbirSi/+m6I/N21xRPwxpdoSqIDUyx5ezO2JK+FRPsC5QZTLstk
 hvYaEdf0PJkPStxJqdGlygJm4rIM6cpayy+ne1wJtvi7tVEROcHhjAwpXOjAsBcnXGS9j/O/gl3Zk
 Kukd9fFN18iagibrHCnt4HQes1xfptgdpOxw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.212.134.121] ([80.237.181.220]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1ML9uK-1rAYi402sc-00IG5V; Mon, 16
 Oct 2023 12:45:42 +0200
Message-ID: <6f91245d-931a-401d-a4d4-f089bb13aa36@gmx.de>
Date:   Mon, 16 Oct 2023 12:45:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] Fixes and improvements for RS485
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, cniedermaier@dh-electronics.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        lukas@wunner.de, p.rosenberger@kunbus.com
References: <20231011181544.7893-1-l.sanfilippo@kunbus.com>
 <0ca84efc-c999-4077-85aa-e13fd0984182@kunbus.com>
 <20231016103856.d2i2nk5ubaeqpd6a@pengutronix.de>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
In-Reply-To: <20231016103856.d2i2nk5ubaeqpd6a@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Pq4tWZ+0oj2jUTKx3+Ah/wV23KOHP/1+W9fUa9WTWpeYeRdAkcN
 hhkxw5Neq9TlJc5+Ndf6b1jorgJEr2VfCfPQ/JehqAyuVj2rYJ1h0cIXX1ZU5+iwjFGq6V+
 pJ5amQHnd6kbmZgJBdRgccQYJj0Pvc7yH7vbjG7QtpODBdRSKsIqMaJXI05/1iMv/kEuwf/
 2Ayh2uHW6xyMRtYJaOGPg==
UI-OutboundReport: notjunk:1;M01:P0:e3qdEQztT/w=;WtQTk5K55gFq1GBfeujkYQ3Voue
 LE40GiexmkzGEmkIkv2iKq4+GhGKqL9Xn8lm3KAzf/oblnTmyNgRC2TE4m8cz1hovyOqUIhpj
 jJBIdfUznwGC7FqFi31MBMKjggKF1PIoSYyjGpR7WIfToI1elaC/yh6F+XA8ragtuZYwEJbb+
 pQoPbv6atnosFYJ5qtktuFIaiC0SufCinm5IAl+D292GO80bRLf0NQBeEW3y3DIVgI9+84lOk
 mDAgXcoQPCuTWhILqkVSEyO8NsIsP2BW5eKWSKS3Vs51lQTBrNkrLr0bGsvwEIaW8gF6c2HvN
 Vb2V/rVyIC9EsTPK03DzFCvbusAL5KVCLzcF+aWsexmTrUr6+kNRQG8Tx0JSOqxnGWgwBQpBE
 f2xGIL45hYghUUmjQKF60OBQNUBFap7q0xvqdg/LtUEXKqioVPGU2wR/S+F+OhOqSeGjReT4a
 w7QBxyXUZRVvhjP5yPl3VV4AwiPnnYNU9txvO2E69mzZLb4GugvlgGteV7qxYdRc2JeDVlz2H
 DvraywSdn17OOHWF1qZ9DnlLGa3hd3gzDlzBUoemNtSGQZRTpsqT+wo5TN8An772VY7zshkt3
 xlmQP93Wdo/Hc4hbN4CepECpNZo8DiUcaECjygdZxxNquKkqyJc2+EwabcWtfoaCeKzkFWxOf
 hb7lMior0v/IAXtrRdoTPOHVfNFDeEP19GFdwdMYBXsU8kqAZwSKrDIo4nKn9sckaAYUhSasc
 X8nu+uI6h2Tn+8iKU+Sr+gvWmr6vH1fO8vL6biV16GHl0f6E8Hfsozw1XlYogABnbTjcyoQlk
 WYp8uUSShHbI9HEG3Ia7n0KrPEVBnM42mneWAKtBMT1VuMmkZUy/r80YXlwhZLeWpeSCY12Xn
 3FeSNaYn+hBPKspardw1QQdnVeH1NB3X5FZnVGA8DQ8v8cn0f5P9YC1LFAGa/GjQJLP4eufDh
 ZFCUOg==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 16.10.23 12:38, Uwe Kleine-K=C3=B6nig wrote:
> Hello Lino,
>
> On Sun, Oct 15, 2023 at 03:03:20PM +0200, Lino Sanfilippo wrote:
>> Sorry Uwe, you gave valuable input for the former version of this serie=
s and I
>> just noticed now that I forgot to Cc you for this version.
>
> My mail setup works good enough that this series already landed in my
> inbox without the explict Cc, but I'm currently doing too much other
> stuff to find the time for an appropriate look here, sorry.
>

No problem, I can fully understand that.

BR,
Lino


