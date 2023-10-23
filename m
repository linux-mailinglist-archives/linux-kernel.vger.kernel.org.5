Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D64C7D3E28
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 19:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233965AbjJWRou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 13:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233943AbjJWRor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 13:44:47 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50421D78;
        Mon, 23 Oct 2023 10:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=s31663417; t=1698083069; x=1698687869; i=j-p-t@gmx.net;
        bh=CEyDy+p9SKOfEeYAYLxdRe4BciE7SgZjZ+htUm+w320=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
         In-Reply-To;
        b=PpqM3OQLiWMF0eLK5bozu7fxSMJnkl4LzgsdDQXUTe429C94bqCgpSVPuZnF6CPZ
         Zxg5NUdT656JVWwY/omsuRDRgDkb4zZcDa4a5SXwyHPXdeNWGaZPnLBeyK4w0smSn
         Inj2rBJe9W9i5vnKP2t14SxeRYov9vguD+hCZNYLd+08RMpa6rHGfHvtqNBUlPt+6
         ByWOo6ngkDRpv2k3lRM1+Wxmr+fkiHiC8lwYhN5c2ukcnfA30Yc4mU5R35SEP+TF4
         pOQINmVruT5B5XlkbspV+vcRZBMtnk+OhN/KglQgfs+QnF8cdqV/kZbxEs6SrFgg3
         S/Vf0y4u2QMcnCOQhA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.178.58] ([45.14.97.35]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N8ofE-1rWobT1Bv4-015uwl; Mon, 23
 Oct 2023 19:44:29 +0200
Message-ID: <1cfa1365-ca0d-4e33-a149-751277183440@gmx.net>
Date:   Mon, 23 Oct 2023 19:44:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: si2157 not working at all?
Content-Language: de-DE
From:   JPT <j-p-t@gmx.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Media Subsystem <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Gon Solo <gonsolo@gmail.com>
References: <08125fef-3cb4-4f01-975c-d7c409153c4a@gmx.net>
 <ZTT0kZCijyLDN1LG@debian.me> <73357cb7-ba96-461b-a214-cd37b2223204@gmx.net>
In-Reply-To: <73357cb7-ba96-461b-a214-cd37b2223204@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WVkeaQiqMemsi/iRW9vvFnhu9f2y42NLC6/Xe/XhuNPOSM9FwwO
 Ty3rbwQQyfZdJOKjQf6vu3xJoEOyVWQl1DcuC6us+kh+S0RaQPc8Z6zoQ6LVGcys/VeYhKJ
 v1F/Ej+DNpns/WS3JbzS7zykrZcvmN9eb95SJYfee6dWgDN6lhQFSh1hLDiHkaYzPdzj7E5
 Zy+G00LgQx+VZ7wtPw5sg==
UI-OutboundReport: notjunk:1;M01:P0:Z1gKTLU5GsQ=;iARJMz0IQvtG1GrrM4HqkRCG50o
 GaWVhDdp6nYChUuF0DSDXCRHhYySeH9qNDYx63otnDZ+pkAszv8ljLvwTzok5tEYPn3SKJ4HL
 disYdEnMLrUUdpIeABuwXrkzcmHJUhbWTg/kSDd6vGD9tOeA8uj/nKe5afjbyHqC0tedcHbTR
 BoAF8saQoEJR6QJ1CBExTduubPcDioynzZdOyD5byF+WJm8igero+shjPlxITTkhU0BGBdxdU
 UiIbZs76cvX6MX9mcWbb8cmZsbqYwvhyEIpUozsL64xTUlEUsBJc2gJAixrngIzliFMCvf4k5
 0FxWCcBG+Q3gXsvf9RPoISKY9qsDIH014bv5fn3SEZdM8OFbppB2jLsSSqJy0xWCdKrYW3oWL
 bzKZjSRH3ds6K8SizDuOEZe6WwU6jqUn65+XkIPOGZeb9alcAj6cAd3PjrIGFT9xVlINHYIe3
 AP8qL+sscGxDg0bVXT9bI7QkuMMM2+L1NhonKepQnJChWayx3+lac4yTGu3HKwz7XwVazqFbe
 yAwqF50onb817dAv5SvN42l//RxLMRuVwUwNfhhsfXoasD6fDn3JnxcQbNuWo62hUxxamm2zl
 VdvZjNDJZPmf5mlxqAl4h7EAUtjP6CrsDo3u1dwjHAQ/0+z6ImyDN5FLYdv9MBZ+cv1B9HYk0
 nKoNTaJari5CTOn0RABwetPizswR9WM2R3suZFzB5Onl3tUokc9+KPuxjKSr5Id5Nw114hlPj
 aoiPzjZMWuUOIn5c8GhrIhOHjJWJFpMx1ZY9RPmDBAAoFsOMNfs7fVdJa382AUoV+ojnYzVwV
 7Cc1OO60ZZ71cuQKVMTw1xZdj0WtcsqhJ6WJS48+s82z1TRa9GpU41FN20F/WiYxF/4jz5oqh
 X5HxGug4QGn56E9hL1l7q/btd8iMcjlqKTlpqGdr/odiNjnWFXMKdnb5dRZy6kSo6nyXjq3+/
 Ts+vlB8J8c6HzbWYpCQptH9EZCs=
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Well,

I was able to make a fresh ubuntu install and build 6.6-rc7

find the logfile here:
https://pastebin.com/9zsRuYFv

comments inside, at the end.
the last lines are:

si2168 8-0067: downloading firmware from file 'dvb-demod-si2168-b40-01.fw'
si2168 8-0067: firmware version: B 4.0.25
si2157 9-0063: device is buggy, skipping firmware download
si2157 9-0063: firmware version: \xff.\xff.255

so even in the newest kernel, the chip is marked as buggy.

could someone please have a look what is the problem with si2157?

here seems to be a patch for kernel 4.19
https://github.com/brandsimon/debian-kernel-terratec-cinergy-tc2

thank you very much

Jan


Am 23.10.23 um 15:18 schrieb JPT:
> Hi,
>
> Am 22.10.23 um 12:08 schrieb Bagas Sanjaya:
>  > Can you check latest mainline (currently v6.6-rc6) instead?
>
> sorry. My backup laptop broke down while trying, so I wont be able to
> build and test a selfbuilt kernel any time soon.
>
> I was able to make the device partly work on
> LibreElec12@raspberry pi 3B+ kernel 6.1.58
> dmesg see http://ix.io/4JKJ
>
> But I wasn't able to tune into anything yet.
> The Hardware ID is a dublette and pulled a wrong driver on LibreElec.
> After blacklisting em28xx, the correct driver was loaded.
>
> I still get the message regarding firmware not loaded because buggy.
>
>> On Sun, Oct 22, 2023 at 09:57:07AM +0200, JPT wrote:
>>> Hi,
>>>
>>> I've got a
>>> =C2=A0=C2=A0=C2=A0=C2=A0TerraTec Cinergy TC2 Stick / Terratec Cinergy =
H6 rev. 2
>>> DVB-T2/DVB-C USB stick using chips:
>>> =C2=A0=C2=A0=C2=A0=C2=A0IT9306, Si2157, Si2168-B40
>
>> Do you already have latest linux-firmware package?
>
>  From what source? Ubuntu repo?
>
> I manually fetched from openelec github:
> d8da7ff67cd56cd8aa4e101aea45e052=C2=A0 dvb-demod-si2168-02.fw
> c8e089c351e9834060e962356f8697b8=C2=A0 dvb-demod-si2168-b40-01.fw
> d643a75d2ced161bc5fb635aec694d9f=C2=A0 dvb-demod-si2168-b40-01.fw.bak (b=
ad?)
> 0c3f6bc5028bc37cfbf3a16d480bbaa5=C2=A0 dvb-usb-it9303-01.fw
> 9822ca23d24c46569ede9e07b1f13eee=C2=A0 dvb-usb-terratec-htc-stick-drxk.f=
w
>
> thanks
>
> Jan
