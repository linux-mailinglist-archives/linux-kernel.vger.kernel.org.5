Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F53B763DCD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 19:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbjGZRiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 13:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjGZRh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 13:37:59 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D561326A8;
        Wed, 26 Jul 2023 10:37:52 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99b9421aaebso535420666b.2;
        Wed, 26 Jul 2023 10:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1690393071; x=1690997871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wv5Dk5Cs2t8vGqW1kWIEUZviczQZaYvIEDL1axAmeMk=;
        b=rk+8tyzvL63OTcoXdtca6aCM4lsbR6XUVa5slqnmI4D1TIrNjqKcs+96ceqau5yhfR
         5orVa/qViux1Re9laiazn0us6rVoirwngrk0WpsLVEGAL1uaJ2lRD3XnyiS17/jaSV7x
         OvUKyh2GO46bzLcvgACDFXoKxVOU+vUZ8iRmEfDuHmWk/xckyI4W0yfAOd5sfNdKfTFk
         mfR3IpEas4UDw7NwTmGA8R3jnrk3A4Rh3yimuqOGfBcXVYWm/IVnbltC/nHZZn4HvhmV
         mPeLcA1APzQRMzH93OBYWZ+f8EtoSM169HmBtRLtsin+qkubYHvioXse2ZNloCE0pLwT
         KyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690393071; x=1690997871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wv5Dk5Cs2t8vGqW1kWIEUZviczQZaYvIEDL1axAmeMk=;
        b=C89JFy4jVQZzH4xa4c0KolGJdPAYnVHmyp+I9CgbUXEZHM35/Jk/OXJRgxYU2F5PgQ
         AwPuSj4szyqcCVvY2SVLPKzZtV72oWe+5pyclc7008jYUynh+poR3CPAhMvvxAGQqcL/
         oeMAkbqRrWWXWb1mfF4AsQBnzCbdqKUQqb5rmi8srQ1snIe7pAQHj5gdAglwFM8Hrwgt
         rc4dyaQFynOaxEIoiqGotoiKunpWz0VDaw1DkOrDUbYYsRHTls08YGtrmvoVvnS4HKya
         plKpfbuL/bIra2T+8Y/hi9jV7zAU1leoj4eHOnqviXVla2dDJTI2sC7TJOyyXTPcpufa
         LzkA==
X-Gm-Message-State: ABy/qLbODYV/8/IY77vWEkurItcGyvOfKLM/W4LOVyVqeDo/ZMNHUDCH
        mJprFDSC5gsQQbEnTMQzX780hDfn139jxUYNudg=
X-Google-Smtp-Source: APBJJlHJ6XtFiwlu/X/4BSNR8GACS8GQh65jLXb5vRy9Qp3zswk6HtU0m7sAWslz1BefbqBOVepHO+5QYHSagjnvtlo=
X-Received: by 2002:a17:906:18b1:b0:99b:65fa:e309 with SMTP id
 c17-20020a17090618b100b0099b65fae309mr2065351ejf.74.1690393070772; Wed, 26
 Jul 2023 10:37:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230709195712.603200-1-martin.blumenstingl@googlemail.com>
 <b55cd3172ea7474ba1a67db2d5b39301@realtek.com> <87pm4w3rjp.fsf@mntre.com> <208ee32354b44205bb76a55c0d4bc93b@realtek.com>
In-Reply-To: <208ee32354b44205bb76a55c0d4bc93b@realtek.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 26 Jul 2023 19:37:39 +0200
Message-ID: <CAFBinCDRWJGr1F0vLj_=k7TYQmGOQRWS=3n1DDQwpxr5AYtt9Q@mail.gmail.com>
Subject: Re: [PATCH] wifi: rtw88: sdio: Honor the host max_req_size in the RX path
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     "Lukas F. Hartmann" <lukas@mntre.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "tony0620emma@gmail.com" <tony0620emma@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ping-Ke,

On Fri, Jul 14, 2023 at 2:34=E2=80=AFAM Ping-Ke Shih <pkshih@realtek.com> w=
rote:
[...]
> > Here are the errors that lead up to this:
> > http://dump.mntmn.com/rtw88-failure-1h-dmesg.txt
>
> Hi Martin,
>
> The dmesg shows that
> "rtw_8822cs mmc2:0001:1: Failed to read 1536 byte(s) from SDIO port 0x000=
000d1"
>
> Shouldn't we return an error code (with proper error handling) instead of
> just break the loop? Because 'buf' content isn't usable.
In my opinion we are properly breaking the loop:
"ret" will be non-zero so the error code is returned from
rtw_sdio_read_port() to the caller.
The (only) caller is rtw_sdio_rxfifo_recv() which sees the non-zero
return code and aborts processing.
What do you think?

> I wonder the approach of this patch is still not enough for Lukas' platfo=
rm.
On IRC Lukas wrote:
  funny, i can reproduce skb_panic when opening this page in chromium
https://embedded.avnet.com/product/msc-sm2s-ryz/
and:
  still getting spurious skb_panics, even after disabling rx aggregation.

I haven't had the time to look into this any further yet.
Unfortunately I also don't have any hardware to reproduce this problem
either, which unfortunately results in this long ping-pong.
Lukas, could you please add two more prints:
- in the rtw_warn with "Failed to read %zu byte(s) from SDIO port":
please also print the ret variable (with %d) - I'm curious what the
reported error is (it could be some CRC error which would mean ret is
-EILSEQ)
- add something like the following at the end of rtw_sdio_read_port()
(right before "return ret"):

if (!ret && count > 1000) {
    printk(KERN_INFO "rtw_sdio_read_port() with %zu bytes:", count);
    print_hex_dump(KERN_INFO, "", DUMP_PREFIX_OFFSET, 16, 1, buf, count, fa=
lse);
}

(note: I only compile-tested this)
The very last output of this (potentially spammy) output will contain
the full buffer that's causing the problem.


Best regards,
Martin
