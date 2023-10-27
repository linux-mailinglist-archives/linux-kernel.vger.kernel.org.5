Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9DBD7D9E14
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 18:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbjJ0Qgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 12:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbjJ0Qgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 12:36:46 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007261B8;
        Fri, 27 Oct 2023 09:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1698424571; x=1699029371; i=linosanfilippo@gmx.de;
        bh=kNVdYZ2EFg6vPMD/14ZIDqR7eDilLs0wpKwk3at+TcI=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
         In-Reply-To;
        b=r1cDzx3ZFCtSPeWldV/MU5jKLg2ytkgEpBn9oVXlnhaPG8xNdqKiT6s0GHdbhcsX
         xi+LYim+h4cw5/iovOw1DOWHGyzQS2ayZn4PRzZoV4VSl7ntgdeicfG16+RUDLkk9
         5miIvX7i0uON31rFe/NDWjk4l846WgCf6ckWAA3QIlakoz/8l/HrBwKJ6WXCGYCRd
         PN2qbuC35UCNPVp0PCgR2M6kvGk8r9YFfxxHjHUz8iN/UZkr8fnm1wXKQQR2xoQ96
         +Cyo3phA0jFAXZsYBNRspU+G8ARWdX76w62qz9wfEaUlNu8pJAre6B84jdvxjaGaq
         XvjxfB7iukpobTMsew==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.42] ([84.162.21.41]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MSt8Q-1r3Snl2Vna-00UKWa; Fri, 27
 Oct 2023 18:36:11 +0200
Message-ID: <419580ec-1f0d-43c9-ab94-fdd5dee361c3@gmx.de>
Date:   Fri, 27 Oct 2023 18:36:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] Fixes and improvements for RS485
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Cc:     jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com,
        u.kleine-koenig@pengutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, cniedermaier@dh-electronics.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        lukas@wunner.de, p.rosenberger@kunbus.com
References: <20231018174840.28977-1-l.sanfilippo@kunbus.com>
 <2023102707-customer-nastiness-9c80@gregkh>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
In-Reply-To: <2023102707-customer-nastiness-9c80@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:K1CllYVjeScIFMGk286f+sV62fTPhsGVrRlbqdHvEdunyo+taPY
 +Nvc2o+ikbB0z1ITSeZTS5jT0hSvFYvGt3xHWB7CzRGNnFigi/GKme1N9FbNLquFY59sMMP
 PeaWeW7sXl3FR9nUsQDVi+8jM7mP6JD3qvJObYhL6Ot2Sdus/VubMsyxNimH7h1DWV9TC1f
 gilD8Wo03mP20cb7u/2Bw==
UI-OutboundReport: notjunk:1;M01:P0:ApHgyRWuDhg=;P56l4QqN0wNflEAlpyS1iogJMS5
 Ek0I02XXOCYUbPQBA2GD9RBBi/bPjp6UgP9k8m14f0i2iaOFKmEk7omRxlyWZ9s7o6kUiDj7l
 Uvi458gWGvdqv8310Xy6xDde9Aqoa7oDP5zrymhfhMIS0aRar7A6yZnX52Z/ywkD1Efjy3pbQ
 Ln5xd4VY8xsKGQ5ijRsOcFz8jmQGV3VCIIPHXjLo5FySJ9HZJHt+frzt6PDvJRvp/I2VdfvOe
 g+ejUicx4zqup7H+J+KGSIv3DpkK/HWxV6ntEtI1f1fkn3shShJrarBNAiybO+OB+Sc9yU0Zw
 vDDSXFpiFbji8uQTA7RIZFTtqxCjCoVKkpQkcAIJJBNosYodZGl5p/GqaJoOcV1R5/v+hZfZx
 vZjdJ8iQQ3pcRcwXikz+87zoEa8sPnXLGDxoHTAY8AITPrepxoUXBWVh9LwALGHYM1eXcxEUx
 /if46S5k2A5zT2iF1H5r6LYC3LiS8Wtt+IPS8oxERmJRE/bchrD7O/vsXSUDokgGeIDw9jfT3
 0f/3jKTvH3mesmkZeGGV6IbH4XnseuSv8rMvhobxVelwePaM/ae5YLBpDvtzPSaKusqx0qKFA
 eze9Kj9FKLLJjmUzfJ6J2mcxcjDoHzcgbPhbb2lwLbQm4rOpbCafQJrS5tBO4QbZ0pKW19D7l
 ZuFFLPU1IpsXRM3Wy0827gMmDwNJjhh6UxuNQF6gq9UqIUZcD9YwJr5f3fO4dRpJRmW+2nI+C
 YVmXGi/mV2zeTAoxVvMH73qxbY74bfAdNGuOOCLdXNQCjmrw72IVOe9f9fXt4NHW2wquVbRLK
 XHgty5B1TmbI0M+RRsSujWc59yKpjnhL5O8dLu02aEfZLdwXTJU4oj/hbAdxNYQo46Ki7lVg4
 e2P8w+6pEcrZOXLsbfNN42iz0MH4+L04MKtfP+XgscLb1fsA0kzrd/zNEEO8QdUE8XHcbUEE0
 TRKmbg==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 27.10.23 13:03, Greg KH wrote:
> On Wed, Oct 18, 2023 at 07:48:33PM +0200, Lino Sanfilippo wrote:
>> The following series includes some fixes and improvements around RS485 =
in
>> the serial core and UART drivers:
>>
>> Patch 1: Do not hold the port lock when setting rx-during-tx GPIO
>> Patch 2: set missing supported flag for RX during TX GPIO
>> Patch 3: fix sanitizing check for RTS settings
>> Patch 4: make sure RS485 is cannot be enabled when it is not supported
>> Patch 5: imx: do not set RS485 enabled if it is not supported
>> Patch 6: omap: do not override settings for rs485 support
>> Patch 7: exar: set missing RS485 supported flag
>>
>> Changes in v4:
>> - add comment for function uart_set_rs485_gpios after hint from Hugo
>> - correct commit message as pointed out by Hugo
>> - rephrase commit messages
>> - add patch 7 after discussion with Ilpo
>
> There's a lot of fuzz for this series against my current tree, so much
> so I don't feel comfortable taking it right now.  Can you resend it
> after 6.7-rc1 is out and you have rebased it against that?  If these
> really are all bugfixes, we can still get them into 6.7-final then.
Yes, no problem, will do so.

BR,
Lino
