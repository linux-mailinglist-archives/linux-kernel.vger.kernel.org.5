Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414B07FAA7C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 20:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbjK0Tiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 14:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233038AbjK0Ti3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 14:38:29 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AC02702;
        Mon, 27 Nov 2023 11:37:49 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3316d3d11e1so2662452f8f.0;
        Mon, 27 Nov 2023 11:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701113867; x=1701718667; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k+U/Z+hb58WPcFvxk4wIR/Eo39sAQ2kwJEM0JKmBdYw=;
        b=QJnh9F1/EDYsH9CPJEewq5ayW4TsH2D0Na3eZRCG4inZTk4X9MEeJIwRMUdYRhNWm1
         pMp42y1/a4rnDgiuk/4i1y86JOr25V8cIZ3Yg480wGazcmMIgUI8YjIVfUrfMfO+UIIl
         pXlLNyROsutUaCRp85JjN9iIy/l1uT3jIJNc/HkQwRlRsHJfOhNrqXPIvLvo1ocoZrIh
         OERpL0whIOHUJ1xCX2tx3HOlO70nACu1qnIsDwunhsrddzyP/nzuvUHV8mytN8T1movD
         rGNrBl7jjnQAQCKcdJnYRgjKRzNG47FuW01S/FWb0Joj0d9viXW2QwqKTCSG5NYUsjpz
         +zPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701113867; x=1701718667;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k+U/Z+hb58WPcFvxk4wIR/Eo39sAQ2kwJEM0JKmBdYw=;
        b=JbzbRNYRolw31c77t/u36vaL45i09wT2P0fLp7ba8dkorQIxKFR0IeA9I/d6NPWFUi
         B+FjjQHYtvLa3enOVmP6YMaxAV+sk3Nka4av+DyypSemQSvWPilzB4LAW1xoV9uOgZGW
         9KDywuHqdS2bXXtfnTkYX69e3sb+ZWYaxUZQ3yO5y70I5RYVfL+c3mn1s0jcG0Nhd0ZZ
         N42sP1/TnIPmnm9VUuewkaG5cxLvBvVrFRcezQh8Z+tLZ7SWQYb2x+tZapi6WKHXGKEI
         /dEgcW2UgrDd1c2mbNht6rwmH8IP1PYV5jUJPEUAvJBBQdx9OpplLXqitaH9yfRH6pZ1
         E1Mg==
X-Gm-Message-State: AOJu0YwhVcqxH8t1FvrTk68xoZamQYct7ssr40DI7/yoNMU5qO9k34er
        MdbNtKp325UFRBS7X3ryQTk=
X-Google-Smtp-Source: AGHT+IE9GgLSy2VbYegCNBxDylmi2Qn+jQz8fC3yjk1z2UoKIRu8VzUpxmYrecZHqAVRyrDpKSqgKQ==
X-Received: by 2002:a05:6000:10d2:b0:332:c6cf:320d with SMTP id b18-20020a05600010d200b00332c6cf320dmr10156757wrx.15.1701113866667;
        Mon, 27 Nov 2023 11:37:46 -0800 (PST)
Received: from ?IPV6:2a01:c23:b815:5700:a463:59a7:865f:2563? (dynamic-2a01-0c23-b815-5700-a463-59a7-865f-2563.c23.pool.telefonica.de. [2a01:c23:b815:5700:a463:59a7:865f:2563])
        by smtp.googlemail.com with ESMTPSA id v6-20020a5d4a46000000b003330b55b941sm1971wrs.77.2023.11.27.11.37.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 11:37:45 -0800 (PST)
Message-ID: <980d651a-af69-49de-bc53-a2e325bd4bb0@gmail.com>
Date:   Mon, 27 Nov 2023 20:37:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] r8169: fix deadlock in "r8169_phylink_handler"
Content-Language: en-US
To:     ChunHao Lin <hau@realtek.com>
Cc:     nic_swsd@realtek.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, grundler@chromium.org,
        stable@vger.kernel.org
References: <20231127175736.5738-1-hau@realtek.com>
 <20231127175736.5738-3-hau@realtek.com>
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
In-Reply-To: <20231127175736.5738-3-hau@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.11.2023 18:57, ChunHao Lin wrote:
> In "r8169_phylink_handler", for rtl8125, it will call "rtl_reset_work"->
> "rtl_hw_start"->"rtl_jumbo_config"->"phy_start_aneg". When call
> "r8169_phylink_handler", PHY lock is acquired. But "phy_start_aneg"
> will also try to acquire PHY lock. That will cause deadlock.
> 
> In this path, use "_phy_start_aneg", unlocked version "phy_start_aneg",
> to prevent deadlock in "r8169_phylink_handler".
> 
> Fixes: 453a77894efa ("r8169: don't advertise pause in jumbo mode")
> Cc: stable@vger.kernel.org
> Signed-off-by: ChunHao Lin <hau@realtek.com>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 473b3245754f..2e3e42a98edd 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -2415,11 +2415,22 @@ static void rtl_jumbo_config(struct rtl8169_private *tp)
>  
>  	/* Chip doesn't support pause in jumbo mode */
>  	if (jumbo) {
> +		int lock;
> +
>  		linkmode_clear_bit(ETHTOOL_LINK_MODE_Pause_BIT,
>  				   tp->phydev->advertising);
>  		linkmode_clear_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT,
>  				   tp->phydev->advertising);
> -		phy_start_aneg(tp->phydev);
> +
> +		if (!mutex_trylock(&tp->phydev->lock))
> +			lock = 0;
> +		else
> +			lock = 1;
> +
> +		_phy_start_aneg(tp->phydev);
> +
> +		if (lock)
> +			mutex_unlock(&tp->phydev->lock);
>  	}
>  }
>  

Hi Hau,
the deadlock issue has been reported by few users, and I submitted a fix already.
It's waiting to be applied.
