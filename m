Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCCE7D3EA4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 20:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbjJWSJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 14:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbjJWSJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 14:09:26 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DC7D6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 11:09:23 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id a1e0cc1a2514c-7b6043d0b82so1227794241.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 11:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1698084562; x=1698689362; darn=vger.kernel.org;
        h=mime-version:subject:user-agent:references:in-reply-to:message-id
         :date:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rCdqIkdJ8p76kVstVackrlCP2IwhTIQ/bNyZV2gjQEU=;
        b=hAr61JdF3BzHsFkK1m/g0LfXQgHtkHUC7G7sUM7BlRSAZH3+cvAk9/vWMm7ZBqcVlW
         Yph2tECNLyMxvSg18Aa5C4ah/yX3AoApY5pn+DOV361i+oqktgpZ/UGlds8T4CKE8lEl
         O83FZMCj2ZOqX5WyprNv9XDpMI1fsn5uGDq0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698084562; x=1698689362;
        h=mime-version:subject:user-agent:references:in-reply-to:message-id
         :date:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rCdqIkdJ8p76kVstVackrlCP2IwhTIQ/bNyZV2gjQEU=;
        b=LrElU2d2S29cdrzOgG5E1WznYb7Yid/3K1HskVcECluVn2zsbEoO43c6rASRVQzOBY
         aeCqprhlLp7k+F7P5Pcr/MtPjqPBv79ub7MbzcvUnuEs35N5TyctNPu2wWANDtJNwC1t
         03AjvPMwg1jpeYrB6BTETtLrmYfML+1WeY1Xy5hrALh6VapQ7EfdFKXoZ/erz/Nxt3Y0
         Z5Q+XLfi4ajibFG+tgQgiQmnaSvWhsah9JnP5XgNBR1pZppzTNSzi2CoEkWsTShrZ2Zh
         Uljb3VqZ8FIULHyTeJj2i+HOt4L2vuqJy6K3HxLkJGQUZTWmGV1XMmsUvx4JPKhq3ILp
         8vnQ==
X-Gm-Message-State: AOJu0YwekuDFZSLOp/oUcjKwDVwIxkgaP0dyVvSnsWpsGOJRtmIDgkJx
        Q3LlA/sxFj4OvM8lDvPYJcSqpA==
X-Google-Smtp-Source: AGHT+IGQ7a/vPe4wpxooYtsVgW/e28SHR37JQYABIKNsLcOY9EExdoysea13JZdetmR7wdxI4Fg4Qg==
X-Received: by 2002:a67:ae05:0:b0:452:5798:64bd with SMTP id x5-20020a67ae05000000b00452579864bdmr8487600vse.35.1698084562615;
        Mon, 23 Oct 2023 11:09:22 -0700 (PDT)
Received: from [192.168.178.38] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id y13-20020ab07d0d000000b0079b3282b5f5sm946803uaw.2.2023.10.23.11.09.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Oct 2023 11:09:21 -0700 (PDT)
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
To:     Daniel Berlin <dberlin@dberlin.org>
CC:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        <linux-wireless@vger.kernel.org>,
        <brcm80211-dev-list.pdl@broadcom.com>,
        <SHA-cyfmac-dev-list@infineon.com>, <linux-kernel@vger.kernel.org>
Date:   Mon, 23 Oct 2023 20:09:16 +0200
Message-ID: <18b5dba0ce0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <18b5db7cac0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
References: <cover.1697650207.git.dberlin@dberlin.org>
 <52c993fd93e13ac015be935a5284294c9a74ea8e.1697650207.git.dberlin@dberlin.org>
 <cc58057b-bc08-f717-1676-13046fc26c5c@broadcom.com>
 <CAF4BwTUTmUd0c-y_NfSi9WkCnDO9bhtpx03Aai1ByH5auq9YXw@mail.gmail.com>
 <CAF4BwTUJ7NxWomeDEa7TOtjfCjEP+dD68HeT3QyDcNoA1QbXVQ@mail.gmail.com>
 <18b5db7cac0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
User-Agent: AquaMail/1.47.0 (build: 104700356)
Subject: Re: [PATCH 2/5] [brcmfmac] Add support for 6G bands
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000002b5dfa0608661f98"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000002b5dfa0608661f98
Content-Type: text/plain; format=flowed; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On October 23, 2023 8:06:52 PM Arend Van Spriel 
<arend.vanspriel@broadcom.com> wrote:

> On October 23, 2023 1:41:34 PM Daniel Berlin <dberlin@dberlin.org> wrote:
>
>> On Fri, Oct 20, 2023 at 12:35 PM Daniel Berlin <dberlin@dberlin.org> wrote:
>>>
>>>>
>>>>> -     brcmf_dbg(INFO, "nmode=%d, vhtmode=%d, bw_cap=(%d, %d)\n",
>>>>> +     brcmf_dbg(INFO,
>>>>> +               "nmode=%d, vhtmode=%d, bw_cap=(%d, %d, %d), he_cap=(%d, %d)\n",
>>>>>      nmode, vhtmode, bw_cap[NL80211_BAND_2GHZ],
>>>>> -               bw_cap[NL80211_BAND_5GHZ]);
>>>>> +               bw_cap[NL80211_BAND_5GHZ], bw_cap[NL80211_BAND_6GHZ],
>>>>> +               he_cap[0], he_cap[1]);
>>>>
>>>> So are these he mac and phy capabilities? ...
>>>
>>> No, unfortunately, it's either 1 or 0 on these chips, and all chips i tested.
>>> This is the hardware capability iovar.
>>>
>>> In the debug firmware i have access to (not apple's), i do see a
>>> command that looks like it may give the he cap, but i can't find how
>>> it would ever be triggered.
>>> (The iovar code for the iovar above is either always just return 0 or return 1)
>>> There are no obvious iovars that relate, and  the absolute latest
>>> bcmdhd hardcodes the he caps, as do infineon's latest ifx code.
>>> :(
>>> I'l hack around see if i can get the caps out of it.
>>>
>>> I'll double check other ones.
>>
>>
>> So, I reached a  conclusion on this piece.
>>
>> This is really an xtlv with subcommands that everyone (including me)
>> is wrongly treating as a non-xtlv.
>> The above is really showing you the enable value.
>> There is also hardware cap value (which is 0/1 as well).
>>
>> In the 4398/4390 firmware, a "defcap" subcommand was added to the
>> firmware which can retrieve the default HE capabilities bytes for the
>> mac and phy and be used to fill them in.
>
> So they adopted the same subcommand I added in our firmware. Hopefully it
> is a true copy.
>
>> However, it is unsupported in the firmware for earlier chips,
>> including these chips (or at least, any firmware i've found for it,
>> apple's or not)
>>
>> As such, at least for these, STA/AP caps will have to be hardcoded.
>>
>> I have updated the code to include the subcommands that exist here,
>> and properly use an xtlv command to retrieve this (it's really a uint8
>> value).
>
> I do have patch lying around here that add xtlv support to fwil.c. Or did I
> already submit that.

It's already there indeed :-D
> Gr. AvS




--0000000000002b5dfa0608661f98
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
2Gzj3QNJRLsZu1TLyOyBBIr/BE7UiY3RabgRzknBGAPmzhS+fmyM8OtM5BYBsFBrSUFtZZO2p/tf
Nbc24J2zf2peoZ8MK+7WQqummYlOnz+FyDkA9EybeNMcS5C+xi/PAgMBAAGjggHdMIIB2TAOBgNV
HQ8BAf8EBAMCBaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQwQQYI
KwYBBQUHMAGGNWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24y
Y2EyMDIwME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3
dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8oDqG
OGh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3Js
MCcGA1UdEQQgMB6BHGFyZW5kLnZhbnNwcmllbEBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYB
BQUHAwQwHwYDVR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFIikAXd8CEtv
ZbDflDRnf3tuStPuMA0GCSqGSIb3DQEBCwUAA4IBAQCdS5XCYx6k2GGZui9DlFsFm75khkqAU7rT
zBX04sJU1+B1wtgmWTVIzW7ugdtDZ4gzaV0S9xRhpDErjJaltxPbCylb1DEsLj+AIvBR34caW6ZG
sQk444t0HPb29HnWYj+OllIGMbdJWr0/P95ZrKk2bP24ub3ZP/8SyzrohfIba9WZKMq6g2nTLZE3
BtkeSGJx/8dy0h8YmRn+adOrxKXHxhSL8BNn8wsmIZyYWe6fRcBtO3Ks2DOLyHCdkoFlN8x9VUQF
N2ulEgqCbRKkx+qNirW86eF138lr1gRxzclu/38ko//MmkAYR/+hP3WnBll7zbpIt0jc9wyFkSqH
p8a1MYICbTCCAmkCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1z
YTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMTv1t
bpIzNUky46LXMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDJ1v9w/4XWqApLXOAZ
qsCMt0tLueZzwlfbJprLXfwXBTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yMzEwMjMxODA5MjJaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAl22TNRPesHqoQ9HL0UiomWKfKm8LVpFEaExq
hikQSzADXq8xeuFaBu/4i1vvUQxTRwkpgTYR8MJE+Xp+KkwVw1phw1A3nrxK3+et1UY13x360R7A
G4JTZ/me6btt8QogyuTAJABycTNKeZbMo1boWx+1Ym1JHIRCjaxmvQzkPmOFHsZLzpnrU5r7vKww
IhWeGIQeyo2KbA/smf6DWTDWZuCfLU6GdDF9O1teXxyPk8baW5N+fBvW6+g7uVCs4udyjDxRrYrO
oTyDHk4fXFqsMXCgYZGfiPOQZNH27+qI2tTSFbj1Y/4kL1n0UFHqO8aN91hdYEh6/AQdMRay1TeU
Ww==
--0000000000002b5dfa0608661f98--
