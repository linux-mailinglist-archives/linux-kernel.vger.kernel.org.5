Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0C77DA5BF
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 10:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233251AbjJ1IGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 04:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbjJ1IGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 04:06:33 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F4F128;
        Sat, 28 Oct 2023 01:06:30 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9be1ee3dc86so392667466b.1;
        Sat, 28 Oct 2023 01:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698480388; x=1699085188; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dSAFbD2zXqeXCz/qQ3/GP/6mFeOJu9TLTBJ5xkKSIes=;
        b=bJNxDmzasQsZzjeydC4z0HAHqfNiP1CLFmLPIQwDMd0xM2O/OaQd89ovt5o3QLmrdB
         5mwPSF8iqaRuP/HNgYMLJjKpjs0/Xxc+e54esyif2xoFYEfRRPEzq5A4r5JosOfakYIK
         GyVDvdn2qbXa8QiRC9jGvHB6BXFrXepLJpCx97RvajoYE1Kxwd494lF8w5MML4Jb8ax/
         Hy7rFmklcq6lFfM3Q94BgyO+OTE1D2JL5rVO4iqtpd/tIU459sdqBlZRTKGk5GWfJN8t
         kBMTN+U3bk1DEBl0qYMDbPwXxTHiDWMplERoNILJljkgaN2Oc8m04vPxdj0mqH0R8B/r
         pkyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698480388; x=1699085188;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dSAFbD2zXqeXCz/qQ3/GP/6mFeOJu9TLTBJ5xkKSIes=;
        b=pXPGiz8jIS/+ZEQoVIRJ+d3rv+fTmOMRNCGSRq8yqFNd7o8gqbQ8ncYazbeBYtLv2O
         haq3T8ScQ8hGZDSQ6HY2RtWtvHjSlgEPawY/uI7fykXH4hde7yhQ/p61anthCRR09YV8
         OdudggrwyISO9uwZQpWcYAcF1nNcl+wH3szvv5VeNU6MXZcKGmI+fQwL/1woD79YRB8t
         WQZaqTm9+uOnMqTaO9MZn07j/DgeraXyixiEs2AeZQojglxuqHZwhQcpHe8WS6paYQaV
         BZQrmsw/ArhVuCof/sCPs+O6w1tYa40YCzAhX44Epo/u73toCmuhrwhnrO+7nmTfKjIY
         GpFg==
X-Gm-Message-State: AOJu0Ywtx9Gx/Huf4FSDpShtmaLVS+DNK0mkmKSTLHMk8yejF1EP2+Nd
        4st8hyL58e7Qm9bXoTPA4M+ArBhRYg8=
X-Google-Smtp-Source: AGHT+IHJgeVWMRHX7vuGRYML70hVSHsN/yOOAMM11wB+4IYCHjjRXA1XBH8Y9DKQszzsJUxHgssoJg==
X-Received: by 2002:a17:906:fd8b:b0:9c6:4dec:b1f0 with SMTP id xa11-20020a170906fd8b00b009c64decb1f0mr3916751ejb.74.1698480388282;
        Sat, 28 Oct 2023 01:06:28 -0700 (PDT)
Received: from ?IPV6:2a01:c23:c119:9c00:b47c:4f5f:820f:2966? (dynamic-2a01-0c23-c119-9c00-b47c-4f5f-820f-2966.c23.pool.telefonica.de. [2a01:c23:c119:9c00:b47c:4f5f:820f:2966])
        by smtp.googlemail.com with ESMTPSA id i22-20020a1709064ed600b0099ce025f8ccsm2412363ejv.186.2023.10.28.01.06.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Oct 2023 01:06:27 -0700 (PDT)
Message-ID: <c5cfc90d-c184-4b04-bea0-bac375cfa85c@gmail.com>
Date:   Sat, 28 Oct 2023 10:06:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: r8169: Disable multicast filter for
 RTL_GIGA_MAC_VER_46
Content-Language: en-US
To:     Patrick Thompson <ptf@google.com>, netdev@vger.kernel.org
Cc:     Chun-Hao Lin <hau@realtek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        nic_swsd@realtek.com, Jeffery Miller <jefferymiller@google.com>
References: <20231027213059.3550747-1-ptf@google.com>
 <CAJs+hrEXfk82+WyYSsPvs=qk-_JOsBHdWzgnFuy692eJsP=whQ@mail.gmail.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 xsFNBF/0ZFUBEAC0eZyktSE7ZNO1SFXL6cQ4i4g6Ah3mOUIXSB4pCY5kQ6OLKHh0FlOD5/5/
 sY7IoIouzOjyFdFPnz4Bl3927ClT567hUJJ+SNaFEiJ9vadI6vZm2gcY4ExdIevYHWe1msJF
 MVE4yNwdS+UsPeCF/6CQQTzHc+n7DomE7fjJD5J1hOJjqz2XWe71fTvYXzxCFLwXXbBiqDC9
 dNqOe5odPsa4TsWZ09T33g5n2nzTJs4Zw8fCy8rLqix/raVsqr8fw5qM66MVtdmEljFaJ9N8
 /W56qGCp+H8Igk/F7CjlbWXiOlKHA25mPTmbVp7VlFsvsmMokr/imQr+0nXtmvYVaKEUwY2g
 86IU6RAOuA8E0J5bD/BeyZdMyVEtX1kT404UJZekFytJZrDZetwxM/cAH+1fMx4z751WJmxQ
 J7mIXSPuDfeJhRDt9sGM6aRVfXbZt+wBogxyXepmnlv9K4A13z9DVLdKLrYUiu9/5QEl6fgI
 kPaXlAZmJsQfoKbmPqCHVRYj1lpQtDM/2/BO6gHASflWUHzwmBVZbS/XRs64uJO8CB3+V3fa
 cIivllReueGCMsHh6/8wgPAyopXOWOxbLsZ291fmZqIR0L5Y6b2HvdFN1Xhc+YrQ8TKK+Z4R
 mJRDh0wNQ8Gm89g92/YkHji4jIWlp2fwzCcx5+lZCQ1XdqAiHQARAQABzSZIZWluZXIgS2Fs
 bHdlaXQgPGhrYWxsd2VpdDFAZ21haWwuY29tPsLBjgQTAQgAOBYhBGxfqY/yOyXjyjJehXLe
 ig9U8DoMBQJf9GRVAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEHLeig9U8DoMSycQ
 AJbfg8HZEK0ljV4M8nvdaiNixWAufrcZ+SD8zhbxl8GispK4F3Yo+20Y3UoZ7FcIidJWUUJL
 axAOkpI/70YNhlqAPMsuudlAieeYZKjIv1WV5ucNZ3VJ7dC+dlVqQdAr1iD869FZXvy91KhJ
 wYulyCf+s4T9YgmLC6jLMBZghKIf1uhSd0NzjyCqYWbk2ZxByZHgunEShOhHPHswu3Am0ftt
 ePaYIHgZs+Vzwfjs8I7EuW/5/f5G9w1vibXxtGY/GXwgGGHRDjFM7RSprGOv4F5eMGh+NFUJ
 TU9N96PQYMwXVxnQfRXl8O6ffSVmFx4H9rovxWPKobLmqQL0WKLLVvA/aOHCcMKgfyKRcLah
 57vGC50Ga8oT2K1g0AhKGkyJo7lGXkMu5yEs0m9O+btqAB261/E3DRxfI1P/tvDZpLJKtq35
 dXsj6sjvhgX7VxXhY1wE54uqLLHY3UZQlmH3QF5t80MS7/KhxB1pO1Cpcmkt9hgyzH8+5org
 +9wWxGUtJWNP7CppY+qvv3SZtKJMKsxqk5coBGwNkMms56z4qfJm2PUtJQGjA65XWdzQACib
 2iaDQoBqGZfXRdPT0tC1H5kUJuOX4ll1hI/HBMEFCcO8++Bl2wcrUsAxLzGvhINVJX2DAQaF
 aNetToazkCnzubKfBOyiTqFJ0b63c5dqziAgzsFNBF/0ZFUBEADF8UEZmKDl1w/UxvjeyAeX
 kghYkY3bkK6gcIYXdLRfJw12GbvMioSguvVzASVHG8h7NbNjk1yur6AONfbUpXKSNZ0skV8V
 fG+ppbaY+zQofsSMoj5gP0amwbwvPzVqZCYJai81VobefTX2MZM2Mg/ThBVtGyzV3NeCpnBa
 8AX3s9rrX2XUoCibYotbbxx9afZYUFyflOc7kEpc9uJXIdaxS2Z6MnYLHsyVjiU6tzKCiVOU
 KJevqvzPXJmy0xaOVf7mhFSNQyJTrZpLa+tvB1DQRS08CqYtIMxRrVtC0t0LFeQGly6bOngr
 ircurWJiJKbSXVstLHgWYiq3/GmCSx/82ObeLO3PftklpRj8d+kFbrvrqBgjWtMH4WtK5uN5
 1WJ71hWJfNchKRlaJ3GWy8KolCAoGsQMovn/ZEXxrGs1ndafu47yXOpuDAozoHTBGvuSXSZo
 ythk/0EAuz5IkwkhYBT1MGIAvNSn9ivE5aRnBazugy0rTRkVggHvt3/7flFHlGVGpBHxFUwb
 /a4UjJBPtIwa4tWR8B1Ma36S8Jk456k2n1id7M0LQ+eqstmp6Y+UB+pt9NX6t0Slw1NCdYTW
 gJezWTVKF7pmTdXszXGxlc9kTrVUz04PqPjnYbv5UWuDd2eyzGjrrFOsJEi8OK2d2j4FfF++
 AzOMdW09JVqejQARAQABwsF2BBgBCAAgFiEEbF+pj/I7JePKMl6Fct6KD1TwOgwFAl/0ZFUC
 GwwACgkQct6KD1TwOgxUfg//eAoYc0Vm4NrxymfcY30UjHVD0LgSvU8kUmXxil3qhFPS7KA+
 y7tgcKLHOkZkXMX5MLFcS9+SmrAjSBBV8omKoHNo+kfFx/dUAtz0lot8wNGmWb+NcHeKM1eb
 nwUMOEa1uDdfZeKef/U/2uHBceY7Gc6zPZPWgXghEyQMTH2UhLgeam8yglyO+A6RXCh+s6ak
 Wje7Vo1wGK4eYxp6pwMPJXLMsI0ii/2k3YPEJPv+yJf90MbYyQSbkTwZhrsokjQEaIfjrIk3
 rQRjTve/J62WIO28IbY/mENuGgWehRlTAbhC4BLTZ5uYS0YMQCR7v9UGMWdNWXFyrOB6PjSu
 Trn9MsPoUc8qI72mVpxEXQDLlrd2ijEWm7Nrf52YMD7hL6rXXuis7R6zY8WnnBhW0uCfhajx
 q+KuARXC0sDLztcjaS3ayXonpoCPZep2Bd5xqE4Ln8/COCslP7E92W1uf1EcdXXIrx1acg21
 H/0Z53okMykVs3a8tECPHIxnre2UxKdTbCEkjkR4V6JyplTS47oWMw3zyI7zkaadfzVFBxk2
 lo/Tny+FX1Azea3Ce7oOnRUEZtWSsUidtIjmL8YUQFZYm+JUIgfRmSpMFq8JP4VH43GXpB/S
 OCrl+/xujzvoUBFV/cHKjEQYBxo+MaiQa1U54ykM2W4DnHb1UiEf5xDkFd4=
In-Reply-To: <CAJs+hrEXfk82+WyYSsPvs=qk-_JOsBHdWzgnFuy692eJsP=whQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.10.2023 23:50, Patrick Thompson wrote:
> Hello Heiner,
> 
> I haven't heard back from realtek about the possibility that this
> affects other MAC_VERs. Do you think it's acceptable to merge this
> patch for now and if/when we hear back from realtek I can adjust the
> function again?
> 
Fine with me. 
Would be nice if mc filtering could be switched on/off via ethtool,
because now we have to disable mc filtering for all the unaffected
users too.

> Thank you,
> Patrick
> 
Heiner

> On Fri, Oct 27, 2023 at 5:31 PM Patrick Thompson <ptf@google.com> wrote:
>>
>> MAC_VER_46 ethernet adapters fail to detect eapol packets unless
>> allmulti is enabled. Add exception for VER_46 in the same way VER_35
>> has an exception.
>>
>> Fixes: 6e1d0b898818 ("r8169:add support for RTL8168H and RTL8107E")
>> Signed-off-by: Patrick Thompson <ptf@google.com>
>> ---
>>
>> Changes in v2:
>> - add Fixes tag
>> - add net annotation
>> - update description
>>
>>  drivers/net/ethernet/realtek/r8169_main.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
>> index 361b90007148b..a775090650e3a 100644
>> --- a/drivers/net/ethernet/realtek/r8169_main.c
>> +++ b/drivers/net/ethernet/realtek/r8169_main.c
>> @@ -2584,7 +2584,8 @@ static void rtl_set_rx_mode(struct net_device *dev)
>>                 rx_mode |= AcceptAllPhys;
>>         } else if (netdev_mc_count(dev) > MC_FILTER_LIMIT ||
>>                    dev->flags & IFF_ALLMULTI ||
>> -                  tp->mac_version == RTL_GIGA_MAC_VER_35) {
>> +                  tp->mac_version == RTL_GIGA_MAC_VER_35 ||
>> +                  tp->mac_version == RTL_GIGA_MAC_VER_46) {
>>                 /* accept all multicasts */
>>         } else if (netdev_mc_empty(dev)) {
>>                 rx_mode &= ~AcceptMulticast;
>> --
>> 2.42.0.820.g83a721a137-goog
>>

