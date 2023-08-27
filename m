Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0189C789D13
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 12:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjH0Kws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 06:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjH0Kwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 06:52:45 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D043FA
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 03:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1693133536; x=1693738336; i=toralf.foerster@gmx.de;
 bh=MP0UyC+swQgDPBXcvb9zZQPczB+B76aXS0J4FlyILOQ=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=JYkv1goR5WYYr6efaOVUrUaT/9RUtb4XBmUNz8F8dVqUTOUfB+gl+vHNqQ5cVYe7MisNeF6
 13N/bOhGevG3gTe6srL25lMjGhFY0NdrSyYKIEjZAtGHe/wVsJ7T98kwj3kw+MvJ2+1Fw5Ub7
 mR4B3P6ELMobCDEuGWiTUfkKXnXVxJj/5IOb2KB9wZ7C93OAO1XIr5dt4OWFrwQmwbx9Tas+y
 VjlpBDWZP2fxzgUBHwaRYjtzDv88NJy5fZtlsFT69zlpbBAqG2OYOeOe5whwVCgBdwYHVK68P
 xjWMddTB2D1XQ24Gi8yjr3xpuEYtgrBpqWm0XLfXZh8Aao241Jdg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.178.33] ([95.116.221.218]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MuUnK-1pj4Uc21z8-00rY9S; Sun, 27
 Aug 2023 12:52:16 +0200
Message-ID: <875888ab-9934-b29c-b69f-189b195ba68d@gmx.de>
Date:   Sun, 27 Aug 2023 12:52:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: 6.1.48 regression at boot : WARNING: CPU: 0 PID: 0 at
 arch/x86/kernel/alternative.c:572 apply_returns+0x1e4/0x210
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Borislav Petkov <bp@alien8.de>
References: <3d6fbd04-2861-91a8-938c-45195f307eed@gmx.de>
 <ZOqeRpAHzqLDrlno@debian.me>
Content-Language: en-US
From:   =?UTF-8?Q?Toralf_F=c3=b6rster?= <toralf.foerster@gmx.de>
In-Reply-To: <ZOqeRpAHzqLDrlno@debian.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2Rbvbik8HwynLcY5mVojMNAUzYhpzQ96qXlVAWJVEZ/MEaazdln
 6inHVfKvl3KtQ7tz7t3kwXz/4sgDLMiHbAGneEt/jBWHha9fQ1XJXRCMohQk6x51wB0zPMR
 p87jTPU+3XWVX6POgSIBpVxqT4nuY0UkjZPaANV2yMq/ilfoY6UJEE209baKTTDUuTpUUj2
 HOD7vQ45r8WaesFMFIW1Q==
UI-OutboundReport: notjunk:1;M01:P0:g1CHJ2T27kk=;YnfNN95uW2OxHJvrfQ038vUl1eN
 oriLJf1t+Q+9BjOHBrruDMjkxzASZcmyCRrEuhpzPn1KAHBeIHJukKmTXmStNOFrH2s6ZDCnr
 UAp6rt8qSyKJdJv8o/i3R2WnatNtkzKpPCvAE0RAFryQSUrv28luw8VFrPWHMfOf4fWb2cMOg
 1ys7MtUcyLzupy3gAzEG83WPu+78DFxT9nQni9ohyc55GCBtbH9issws4nrpS4oDqYg01ZkOf
 6d5QXYLGHaJ8x+lo0D6O4qFDjgH409pXW6hXSDNGJexdRMdbBf5TJkwn6KSt9Sjib/gqn98/q
 Ll2A0WaaDzcU/5QCUtOp7JogErDu9SGtE7ohv/+lCQ35wifJ7EAKnJ1f0nvsGEssdcf+mca3m
 rn/qzIVDnHkTYuL0kotEjl58+tBzhJfCRbdAMYbpY1gDnYoQ85FUz8UVIRgJoU0roitrKHCDo
 w6358WvBVk3XbHkCjfTwfffC5YbPpLXZoB2ZZfg9r0IiVjfaaFfYHfKAQoJiPrOE/52lN0Aiq
 tka5sdtfMe279+JnDn/r//lXMn13qcA9WTbB7QWpM2s+vrXEUp0d/2+3Wuk/LBk3K2rIaKwiB
 C73/frskF9TB5NaeP/JTY+JHq84Xj0yeofocNMjpVIRjqAo4uPUcDyAj+Kwc96rqy8qZ8kHx+
 79HXvehpCFD/dBMU8kBuaiDvI5CDRFbIxyBn5j5z/5Y9KvrTnLopxvOJ2iSAcKp2J0qOANPuT
 NFm8VNpYR8F1wiPvD+kc8vdpkR4VY50gLQ6+H4m1tv3mzVIvPD6E8N+KaqsedB/QzZoxz3pn8
 lwwwg40QFMV0KR+VxPABGeWQTohsOCDoKqI4fDIceKe15Witcm5BCtaqt8wbVLCXM6x9qk0cB
 1L1YOda2JlNwHrpuyVeFvm4Ud3s+hqP6QYf1d8HocF4ql0Ms+p2rJfMY3uRAIVAntGBDslujd
 Dw5t4I4l62W/+8VoVCVX5Hcuy20=
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/23 02:52, Bagas Sanjaya wrote:
> Do you have any external modules?

No.
And I can confirm, it is a regression.
Latest mainline I'd like to avoid at this system.

=2D-
Toralf

