Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F8E7F0215
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 19:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjKRSrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 13:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjKRSrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 13:47:36 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABEFE5;
        Sat, 18 Nov 2023 10:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1700333238; x=1700938038; i=deller@gmx.de;
        bh=qXXytIy5gEGtgg3frHvJjypzDpXdGpZy7WG086Ql6NE=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
         In-Reply-To;
        b=L1XQfo4LYl2C7CEpNgwlY3ZZco5pSZ53+zxVMJXeA45qxz8lO87KtwaDsj6+zyzC
         kweKMnuEkSQFiyVHoa4+BdMnipPWUKHm1ywU6sxy82uUivvF0DbCIiTFZtmr/fZVL
         pk/a1L7aag/nEiEuontKABFVXdxmyElr7cTeqmoBdJD73FYqlS13HbzJudZ4bCGq1
         kL5bdtOcTH790enMQdUx4rW6Fctb6iUJoWIH96oL3yBlNNjD1hJU2xWF24IXNwaiB
         Lkt+N34XNddVxU6cpWS47RYDHRJjr0VTQ5ywQiGBWjFaadE0k/sJT1OqOtzM/9Mww
         0h3si+udddUG/GWk1w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.151.152]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M89L1-1r0Jbp1QNX-005DyT; Sat, 18
 Nov 2023 19:47:18 +0100
Message-ID: <5e8aefce-2c74-4d56-b737-fb9f55205f8a@gmx.de>
Date:   Sat, 18 Nov 2023 19:47:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] parisc architecture fixes for v6.7-rc1
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>,
        Kees Cook <keescook@chromium.org>, Sam James <sam@gentoo.org>
References: <ZVjC9P0h5mw3ZbnD@p100>
 <CAHk-=wgtxsw8hrLNcGz9aJtP17NR3=NSvRdYGfKB52VorhkWzQ@mail.gmail.com>
 <0f492aac-9ba7-4bc6-95b2-6b1104a12244@gmx.de>
 <CAHk-=wgtie=7Z79CssOF10twd1mdQuy1JeiPVgbGFTa9q7JePQ@mail.gmail.com>
From:   Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <CAHk-=wgtie=7Z79CssOF10twd1mdQuy1JeiPVgbGFTa9q7JePQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/MUCT8CWKRlnSy2Yzz2u7sONG+Z83F6WqVTNxzl4OjWrrorJv1d
 TsDYG3Ms5yEatTykhcQhNwZQpspAQ1kez9nIZbAO+hI5SP48vINaCMpwofeA+5KUWh/aCCL
 ViAxQADoT1WL71FKmM8CnmBzHx4GPBoyZAJlKMaIT9w3O6i01+F/uhur4LVn8FPoWMapeAU
 XOVUnYbM92L7y/BV07biQ==
UI-OutboundReport: notjunk:1;M01:P0:NhAVDpE41M4=;TCWM0YxhJf7y4q+WzGRPUMxIZmz
 GmOFEnHfLT2BTzwSBKBbu0NYRgDYiKM59R2t7N1TMvpee8dsk5LQ1xg0ZyyKtmNJ8Mt+awkMP
 /dOYTrarVp96nEcUTwBFLsX8EOumyjeWtTbumAWgsg+4QHzSo23G2o5dXU9qvGMT8Y5I4ztgM
 V1CkOhkTzOSH+8R/ZFw5QDLrQT8+7cUBBByme9KrpKxBi8s+6d1a3AGVspAMNs9D9FfSIlCTS
 kLgks/VA6OtlQoLJnzG6OLSFo4Fy+IGgzk1JCI3PF1bm0noGHwLQ2bGxTbilqNrRGi355v6lt
 rJJ1qpmGSVRp3bVoA4yUP1lNHnPjmsovI5hN8i9fGjosw4ZPSR3o/yvopgNFxd7jqOT+bUtqR
 89TppN3rAmVv/NHeKU0t2cgjmrM9gm77Ub9/p57A8ey/cAWy8fqpiJR0MURGWWCZmZrUL2VeQ
 q3PTsJTdjDeIkxplZo9VIDgeMw7j6kl1LydaJLWoqeOKscRomZIUCKNPSgwgJiglTWf3sYIWW
 SnFoYCJYF6rhrycKzMF/foBFAOQ4/7JHHWQYZfyUNveA7JGDtGrHRwhNNRu5byu2UmlF4SS1c
 hUt8njPiCEGm5Mr9YnoAko1tpFwtuH+4TH1fMPjEiTaUm6npitaM4bI+DuisUttQLfEi20l9H
 kG41yall9R3AK5EazBuoK5CtvXJbiTEsB4z8rrkizzNsFTVPdvY5NQOvkvUkhLd/D9SbffojU
 64Fhy7NUyLArv+CUoQKIwEWFhT295PLlI4JonnF0TEvMC7oKVfp0m/Ofdm0OD2q4jtkKBzUN/
 u0JvA+qTOTLv330AwKzomVmSaLD5uu7etROfx0RkFpGjsL/NlnQe1fgtITId32OGEmvn1SPbT
 eV1bq6pgzeuHzyBYoFJxxpHrBiRf7nTEFr1IDIglXppMC4A/ENXPldj0+byBcQ2u7DhYy+E5k
 Z+EnHw==
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

On 11/18/23 19:42, Linus Torvalds wrote:
> On Sat, 18 Nov 2023 at 10:40, Helge Deller <deller@gmx.de> wrote:
>>
>> Would the patch below be OK? It's basically yours but with EINVAL.
>> (might be whitespace-scrambled!)
>
> I don't particularly like EINVAL, but it's not the kind of
> show-stopper that the other issues were.

Ok, thank you!
I'll send you a new pull request.

Btw, we are in the process to get rid of executable stacks, but
this will take time.
That said, I hope to remove this check then again.

Helge
