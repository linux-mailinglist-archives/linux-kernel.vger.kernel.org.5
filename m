Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B7E812226
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 23:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbjLMW4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 17:56:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjLMW4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 17:56:05 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DC2D0;
        Wed, 13 Dec 2023 14:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1702508133; x=1703112933; i=linosanfilippo@gmx.de;
        bh=/y0wEErfQaUWPQ8zqwwuu6OFCzGo6/tXPuv3/jpuNy8=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
         In-Reply-To;
        b=bCCAkK0lf9fSZsImv9lKbhuShujBCQcLLR1Jb70gV1zYFcoM5v6/ICL8qlXbVbRN
         dvdIvIC9R85PhTXE5n8s/SMVal/g2NhXsFrrLk9a4fW69wfUunhWhD2wiS/Jk8Xdw
         2S2QOgmApAH2YhG5HVETl4u9XGHgOWPFxUjqffeh13hb6NxZ2mgh4MSd4tV6DTmEY
         An2fnVcUpO+uq122g1GtxKSKcMWF2tFTSyRtjdMQ+hGGFbXbFrS+N4WdJP/xkBVcf
         DmvW26doF/yDFgxclctVck2hlouTwk02ua874Q7C8/F6S56Dd0gNvSZJ1n39c8TYs
         kORuqBL6dSwnpEyQHw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.42] ([84.180.3.177]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MKbg4-1quvKD12Hk-00KyCf; Wed, 13
 Dec 2023 23:55:33 +0100
Message-ID: <e59cf6e9-1f1d-4252-aee2-818fef9c9936@gmx.de>
Date:   Wed, 13 Dec 2023 23:55:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] serial: omap: do not override settings for RS485
 support
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        u.kleine-koenig@pengutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, cniedermaier@dh-electronics.com,
        hugo@hugovil.com, LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>, p.rosenberger@kunbus.com,
        stable@vger.kernel.org
References: <20231209125836.16294-1-l.sanfilippo@kunbus.com>
 <20231209125836.16294-7-l.sanfilippo@kunbus.com>
 <e1e8d86e-2cb-db8d-77a5-dcb5cd3fbb22@linux.intel.com>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
In-Reply-To: <e1e8d86e-2cb-db8d-77a5-dcb5cd3fbb22@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SIgpHmzRjggQCx8l60M5/USwq0CPJwr19UwqrlNnMnZ1m3b83Na
 HKl5Zl2OI6jeOdSZbucZoVGUMhR9Pk7j4jXtKRpSWj4H3CxSbYwfCtRfURB1PpXRyGgjJ4L
 aPg9S99Ipg7JliKoiDJGHYbvwJGJsOXxNuPd3Wvmj9kflxalMxED5K3V8OD5zkGJMSSqqjE
 qQDuBfk6KHNbthMlDRbfw==
UI-OutboundReport: notjunk:1;M01:P0:lTOLppwMnGU=;j8xm1OPssHUyNtBsIBw//ew0224
 zudRD/Rjbppd68nYKUmBLkZvTdD4DIeTiSFjjHCcj1lpLc1dKWGRKTwnjsvVfi70lYeq4R76S
 sa8ExvDX1+XWnxmvVVtFKLH634FV5GsByTDZBD5LrTVY1+4TIEh7joUKTBR5ZqEfvHHg02nZx
 ZVCUfWwoGpAAM1szFxgd/8gTfSCe3ow/WzqPkP536f47gjUGcoPUubFv9cBaI/uqHxGdsBtJ6
 KzV90wXaJkGP2kKbD2IdE2BX5QIAtncLsE11y0DztZGvTMrFTsukDavKA19IaFkVcnrZ7tIh7
 Q/cCB+tV8u5D4Qyzs3Er9RotKpQqYFwIhbWtkyw3m5oh3VQqBLUmxssa7TwL1UpLZaqGUrLfh
 bo1vAPdeE3/hMnW20i6u4gw5+PvYg55HWO4cu8rh7pvPtWD1P0Kce8bw5oyuSatymwMTg9tbv
 VsJLbboiwo2MyV74nSbYHC2ka9W8llCGd45r9DVbHqe0+jIJsV++z08bSASsZR7sqk+Ai+71a
 LP6E6E0+SgFgHDq9Gb1hHm29RqrtMpuR8N70I/s9Ei6bLug8XWKSPeFbtnFVCJV+XuT+iB2R0
 fg2FTk4FbYneqLwwK6ynpNyzIzwIbxPJxlL5AgXfm2sjSI349NheCf0zwuTIIa/muD6iVXC82
 5CCQEAe1ejkg1Iz6mPginHJ2c9nWZF8RrFCdGT9sjtMC318cd2o51p57eO/f34WTJm0JUZYzK
 Uxczlp7sQkht8eor6fsCZ5GDN+Ic3OJk3ph6xiSBkat+MYY4ugN/nluiiROa+WWZHSiURj4+3
 jWQR3wv8lNNaK/L2QOV6wGCLc5Y3aZQIAYRgfzA0/dIcOvSGJBZv72UQbzoN6d0E8Hy+muGom
 jErW9v1rQTu3mwDsF05MXEnRrDYXS+1gXIOitwF/jtMjytRtvVgFdxNkblrVDUIL2xZNJ8wjw
 ndEj7w==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13.12.23 11:26, Ilpo J=C3=A4rvinen wrote:
> On Sat, 9 Dec 2023, Lino Sanfilippo wrote:
>
>> In serial_omap_rs485() RS485 support may be deactivated due to a missin=
g
>
> There's no serial_omap_rs485() function. I assume/know you meant
> serial_omap_probe_rs485() but please correct.
>

Right, I meant serial_omap_probe_rs485(). Will fix the misnaming as well a=
s
the typos below.

>> RTS GPIO. This is done by nullifying the ports rs485_supported struct.
>> After that however the serial_omap_rs485_supported struct is assigned t=
o
>> the same structure unconditionally, which results in an unintended
>> reactivation of RS485 support.
>>
>> Fix this by callling serial_omap_rs485() after the assignment of
>
> callling -> calling.
>
> Again, the function name is incorrect.
>

>> rs485_supported.
>
> Wouldn't it be better if all rs485 init/setups would occur in the same
> place rather than being spread around? That is, move the rs485_config an=
d
> rs485_supported setup into serial_omap_probe_rs485()?
>

No problem, I can do that. Thanks for the review(s)!

Regards,
Lino
