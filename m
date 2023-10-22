Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F0F7D2528
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 20:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbjJVSSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 14:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjJVSSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 14:18:22 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788F0DD;
        Sun, 22 Oct 2023 11:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1697998687; x=1698603487; i=jwollrath@web.de;
        bh=nOMeqIwwdnd4I67+8IJHlKNQuQ13pR/On7VtXvGRxaE=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:
         References;
        b=o6SvibrdxxWasTP38Trwny5A7ZtCYJ93Xe0poHq+EOo25eOQLVhBBSfzp4X4LFtQ
         udPpzVuCyOOz83djMzilaCSwKO78NMvqM9SdUjFTPoPIFMSfCXApwcudkt46C6PEa
         4sAcyFDs15QEaYChIY1AZjY+Aw0+fc9SsvAbjLHI51or25xul0ESVjukIhXJQoemO
         bZt89losOp3mR3Rt9xKKKc8zIFISqqbkKjsOhwHQuuM0/dD44Sekl4b4nOEviTFuX
         JqaGiAZat1T1fXEKle0NA+5GyKNckeehZ+b2j/IN30zJlnvSOOENWaTef3MBBPX5/
         +u06kxDaZ2pXpOn84g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from mayene ([178.196.174.8]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MeUXu-1rSrNb0Tjg-00aQxT; Sun, 22
 Oct 2023 20:18:07 +0200
Date:   Sun, 22 Oct 2023 20:18:03 +0200
From:   Julian Wollrath <jwollrath@web.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Oops with v6.6-rc6+
Message-ID: <20231022201803.41b8df95@mayene>
In-Reply-To: <20231022172240.GBZTVaYH1Ext47Z5o4@fat_crate.local>
References: <20231022172700.48c515cf@mayene>
        <20231022161847.GAZTVLZ74T8B79v87p@fat_crate.local>
        <b4ebea2eeb63aaa7ba0877cee0c9ca966af9eae0.camel@HansenPartnership.com>
        <20231022172240.GBZTVaYH1Ext47Z5o4@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:R0pq8/9ZDSz0SvDWhsKAhNGgmiF5xDKpIb5drQxb37BDbHsPVq2
 hfN/UTleAM2DolHgMjwmY8oMNqQx7f7qky1E/hqfZPfrQSb+tffH02u6BxHmSyu7A5jYv/z
 HgRnHZVR9wfjXoDXrzoUKMDrI2h2dGWwKWAdnqGpmDj9q+J6CD2ZB5VSAFSjPQ8RtxTCku7
 Xuqga5q6XqFPBmqFaty+g==
UI-OutboundReport: notjunk:1;M01:P0:5PJVZJrPwH0=;XbemrkFN/kU7e27TNE5dtYKHc3o
 qzMDDEAP43eyANJrcD8OaxSoCdQ+hPe68XY0lEqdudAIb02D5G+8Afsxbk7P+kmJZRa0F87dw
 IIkJnv3UsB1rK7fpzUifj53lqRapIaTkI/5hUk9AwD8tI+aUvj9Jv+Cuxfvw6l3rMpLCKHWXq
 y60GnA0yLALjKxRzNUAe9vFO1bjMvMw/W6QrJNgEuTChh6dcF7oLpGr3koIPNzP6R/WqS+Q6H
 IlsILdzzX4HRbZxqUC2Knq2mVbmfEskIT5j92DlMLkvnBDF+szD326lJhRfnEH8xNpqwiggHN
 PwIY5SIIP6HQT0fCiEIVYfO2UKxgy+6FGouvuWpmgQsYPNvCPju0D5aa0JisC/upstsKpJDeu
 vlIXWJcBAo30JMmRu0CpLnEjpu4VEZEcZKVAJ4Qf9/nJEBtyOfzxLmT4SvX0k5t4AsrVue+N8
 wecEcq1Tzk/IntCpdWf5UryvvrwXmB33rM5YT8kYZInvg7uabqyCKvj61pvIvkwv+uxzfZgY4
 1Nx3/2NNP9EWTK45M63N83Y1emyAGrR2ENf60ZMgMUHYak9JSydtKwZH9z4ekoVyW4w8wa/CW
 FwlILmZtRje6Zj8vfy7YB4oDV4cFv14Sf2lnZ217UcY/tqoDR8gn3btQTErt5SRbf9BvdW6CU
 7LP5q8ZVH5/iAMIscIFY7+B4kLZi6TSuVaDawQXBuStbcpRsVV73XrKQdMNPBpi4u7JS+CQLq
 zzGO66ipsoJvW/v2g3gyoWZf4r9NKyUYD7Q6qnounwyI/Hf0x4FY0R2u8RTpg2lREabynlQVZ
 WlbswR+MJ7TBO49uNE9uIHmaeP15Fi1Zg6sZFavNVst7Crl7SONF1I7CX7vrzcG0Pp6Va6tXA
 HEDUf3ajEsROPU/SGZEl5rotaI+xlnESqpkh65WXguBQWd8UkaZQfJPs0CCrcZAvPYMHey5MF
 V0JVHmZDZgGjzaHSXXVlVpKpiGg=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Sun, 22 Oct 2023 19:22:40 +0200
schrieb Borislav Petkov <bp@alien8.de>:

> On Sun, Oct 22, 2023 at 01:06:25PM -0400, James Bottomley wrote:
> > How to reproduce would be helpful.  Was this a cat of
> > /proc/scsi/scsi?

% cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: Samsung  Model: Portable SSD T5  Rev: 0
  Type:   Direct-Access                    ANSI  SCSI revision: 06

and as far as I can reconstruct the oops correlated with attaching that
drive via USB. But attaching the drive again, does not reproduce it.

>
> Probably some tool did something weird:
>
> CPU: 2 PID: 13243 Comm: colord-sane Not tainted 6.6.0-rc6+ #9
> 			^^^^^^^^^^^
>
> judging by https://www.freedesktop.org/software/colord/intro.html

Maybe, right after the part of the log in my mail before I see

note: colord-sane[13243] exited with irqs disabled
note: colord-sane[13243] exited with preempt_count
usbcore: registered new interface driver usb-storage
scsi host0: uas
usbcore: registered new interface driver uas
scsi 0:0:0:0: Direct-Access     Samsung Portable SSD T5  0 PQ: 0 ANSI: 6


Cheers,
Julian


=2D-
 ()  ascii ribbon campaign - against html e-mail
 /\                        - against proprietary attachments
