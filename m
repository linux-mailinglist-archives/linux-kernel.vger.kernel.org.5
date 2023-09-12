Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C75779D8A4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 20:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237241AbjILSZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 14:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232721AbjILSZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 14:25:31 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9472115
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 11:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1694543107; x=1695147907; i=deller@gmx.de;
 bh=orUsKUDqH0pf7gg5vC9/jxZwCFrLkDJNo5RATAaMIeY=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=jTGWBaLENrqIUx+8JXh7iLyg53LgfpS9H9OTxb3pm9LEmYO7nmCOM8uInGpGpBZn8QGpxKd
 zOATco4P/mWogDSwjSit7K9jUbQYVSMAIloEk/0Vo0iTCE8mxhbekOzDM+sHObYzNXqgSSL/J
 6G6cf+ttCdJyDl+qnUmcuBohJQgEkhmrii8X+g7hmwTO/IUvelCpQeb1L0WDb/sRpEe0iRwtM
 seS80yI/g7M0BkLzdbzEvRcg9yv4yXlqfWMtxkCcHQDfcW8tnDKj9u7XVK2NmvyefTUoM+X77
 3pbTjo87M5kClqIucsTlyAhYG+Bs3lAx/1DWMeR0wS4QmeRRaRbQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.148.165]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MsYqp-1rZsK019qN-00u1TF; Tue, 12
 Sep 2023 20:25:07 +0200
Message-ID: <c8529a48-c104-2653-40c5-f2f6396f0dfb@gmx.de>
Date:   Tue, 12 Sep 2023 20:25:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Linux 6.6-rc1
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>
References: <CAHk-=wgfL1rwyvELk2VwJTtiLNpwxTFeFtStLeAQ-2rTRd34eQ@mail.gmail.com>
 <3c85e5f7-c9a4-4c77-b4e9-3b476ac6c1fb@roeck-us.net>
 <CAHk-=wh+rYcuh0zp3b3qFuhwykXK1u1HcpRPCpeZ5EUnUKjJew@mail.gmail.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <CAHk-=wh+rYcuh0zp3b3qFuhwykXK1u1HcpRPCpeZ5EUnUKjJew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:x+P5qRRI/gA0aJvQ9sodeD/ZHfoXhuR6CnLb0F0fAEHcVhtdYAz
 TX/BEbqcMCGrQm3uI3mISM8EweInBeT2y/LxB9xYOWI+XgsAGqD9vEd7pAtbE2AA2xb+cey
 eK/WFbviIXqf5k7DhHWn+gq0fpV4DSbeEvoFHAu0P72V+88H1Y/F2eGilKJtcJSTsQCx9M+
 6iKzHhZS8ucLrge1MGgqA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:w4j9KcnW0ro=;3hWi9MjZ2SyOEGIDjhyxMhgNjGK
 +kSQWWCRQHQWQTckdVDRVQ+T9I0pT/Jbkb66DQUXdszgnz7PccDwN4SjwIsY6BQfA9sgHGFmI
 GoCMzBfGylrOksMKIu/Krw+jWFTNB0rNgYMavUpOLYdVORYGOSZNqhScZOJxi33khqwjZfdLP
 2rdEFfSjm80tH+hdE5X5hifHhCDiA8PsfezrkUaQkjFaYBQjrhUTCbNnj7+OTAAc8wys6nieh
 /rlaHXm/pURavqxzqwuAeIOfM+CEELXLMD03MWkQJEzTQyEd96idAujb9fbS5lADYpU2z40mk
 BiYodenwDp40nyM63VrBtn8XPaPkHkmkbh8ExD7tgYvqn85olMuCO/Zz9rvBqgpQ58Jl0WSX7
 RwnNnx/OAR+r64PIT6I8N1Qs46Y10tXDUZLKMz9sf8Jkv8PO7+0YapVRsdAm12w1dkAygsxc0
 XPTThcwh3rB/cFYpSlh7aWB9VeNvDI7+3Cw1qYtt5ollLMze+GRyBo/pcSMyisBt3HKp+tX4t
 8M3mYJsD5FhYxroDOqIYvJ8xW+7LRr2B6mYUsxI8J601/5eUnJs1p/oxN4t5mkPO3Q69N6pM+
 THOSmfj6EE+1j+FPdCiEmE6nstXoRw29RbqbgDmWzgMPLaqnuvrMWU1TOXFw3W/rhyE8rf/9D
 ejDnZhBCHyTd4izkHYVO/5ste589/zLIG8IVpLwMoEiCRCF6W6lzXyyivxlDFXqNGqHpTbNjG
 sFLhx3hzE/blc9X9hIKBITPKyXld7C0LiPeLJOaBlzIfJllIR+fJ/3U4qL+VouGb4bXI6gDmL
 OoKeiHfQuHfrROHtxcJLHLU5g9hbp67eojvoi3yhgXv9czkNfW17JJEs3Abbr96XnoRLsznTr
 O/JbIWtI6Hdv4VoaSZ97v/vIxdbjXEkHkF4TmAepILXaMNgopPq2hi0Hj6/LDOZnLztmobmz1
 yzyskxVxsq48/URQTXPpBvgSR2U=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/23 20:17, Linus Torvalds wrote:
> On Tue, 12 Sept 2023 at 11:00, Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> loongarch:
>>
>> INFO: trying to register non-static key.
>>
>> Caused by commit 0a6b58c5cd0d ("lockdep: fix static memory detection ev=
en
>> more"). No fix available as far as I know.
>
> Isn't this
>
>     https://lore.kernel.org/lkml/ZPl+Y2vRYUnWtTQc@ls3530/
>
> the fix? You even replied to that saying it's fixed.

Yes, this should be the fix.

> Or are there two different issues here?
>
> Or is it just that it's not queued up anywhere?

It's not queued up yet, AFAIK.
I just returned from vacation and will send a proper patch in a few moment=
s.
Nevertheless, it would be good to get feedback from loongarch people too.

Helge
