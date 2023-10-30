Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21437DBB4A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 15:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbjJ3OEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 10:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbjJ3OEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 10:04:09 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7B5C1;
        Mon, 30 Oct 2023 07:04:05 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-538e8eca9c1so7229614a12.3;
        Mon, 30 Oct 2023 07:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698674644; x=1699279444; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qt5VNnrZhkT8YwkXJ+TkOhYq+JeQbEwo9PeLT+R3kjE=;
        b=kPLEhRYlnb2N2Hid6FCXLbLc3GwvMIi+F6SNqIbW8prf8fhlcnfsr+nYWRZp4Ihewf
         eqpzdXPe5bHaQcCjyfFp2AZPkgVAUmf58IRZ4w3n0AMqs2qtWIwec0Yai0UhBBiqzkgN
         LuiFvge1LsUV7kRSvCW2SNqi2Fx/lKbWOcjOO48Nm9nmnYsyD1eSH3c5R8dkqN5Xbxmj
         CKpxqhLLatiLEiiQ2G01DxZjo7QaWcql2+2v+yr9cHcEXVQthFnlnHgGegP0w3KyJFDv
         LUNadRJOpWfl09ZsLd5HQoqjRNTo2Z+gIUSQnVoB6L/P81Kq/ACWD85oxSEdGzfYPWGD
         wNZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698674644; x=1699279444;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qt5VNnrZhkT8YwkXJ+TkOhYq+JeQbEwo9PeLT+R3kjE=;
        b=W4JdRJpKrfckPqrYlk0NDvRQOzwLm/ogEwQbkgLRH5MZCtGdySDT5XJGwkl6hlFwoP
         Xw5FBZ53h8mk8WFYOXzXVpyAUf8JLtriXaYyNVxjQ+A6NiJqXz542L6CgsG/E6wYG5hm
         QJ3zAdqnzNgHebjpzccAvhRlzc8HOjWEFBUz9ISTKfWeOhNYjfD2PStD2OE/wtl8ogZz
         z0XpZu3oW7kbHgBaBgpLZpU6OeRhvgNMYq40eaBUTAN6C9ZT6ThNcL75KoXoPRwVP4P7
         43rWZbYC6lsqQITmMCsQosw7A87FMZBSOU6KFjIVE2ub+OJPPiL5YHPgf6HTwY0M2XL8
         FItg==
X-Gm-Message-State: AOJu0Yxix6X8vWLF2bPiUN36ApKxGLIbEzrjRrIZJZbrP0wnP/bblIxa
        3kAJLU5cozUjwWbwfetcXVI=
X-Google-Smtp-Source: AGHT+IE3nQiZ67e/Wb//i3pdBi0hY0U3T8Y1GrCo+SrJxi3o5oYA6auTP73Syz2bn5kVoK/tcSGpAg==
X-Received: by 2002:a50:cd48:0:b0:540:31ef:80b6 with SMTP id d8-20020a50cd48000000b0054031ef80b6mr8260231edj.0.1698674643797;
        Mon, 30 Oct 2023 07:04:03 -0700 (PDT)
Received: from ?IPV6:2a01:c23:bc31:8900:5db7:a938:1060:35a3? (dynamic-2a01-0c23-bc31-8900-5db7-a938-1060-35a3.c23.pool.telefonica.de. [2a01:c23:bc31:8900:5db7:a938:1060:35a3])
        by smtp.googlemail.com with ESMTPSA id n27-20020a5099db000000b0053116e45317sm6278564edb.44.2023.10.30.07.04.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 07:04:03 -0700 (PDT)
Message-ID: <d0ec3a4a-f70e-4212-81e7-67a16c6dfaf4@gmail.com>
Date:   Mon, 30 Oct 2023 14:48:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/7] r8169: Coalesce RTL8411b PHY power-down recovery
 calls to reduce spinlock contention
Content-Language: en-US
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <jroedel@suse.de>,
        Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, nic_swsd@realtek.com,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Marco Elver <elver@google.com>
References: <20231029183600.451694-1-mirsad.todorovac@alu.unizg.hr>
 <20231029183600.451694-2-mirsad.todorovac@alu.unizg.hr>
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
In-Reply-To: <20231029183600.451694-2-mirsad.todorovac@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.10.2023 19:35, Mirsad Goran Todorovac wrote:
> On RTL8411b the RX unit gets confused if the PHY is powered-down.
> This was reported in [0] and confirmed by Realtek. Realtek provided
> a sequence to fix the RX unit after PHY wakeup.
> 
> A series of about 130 r8168_mac_ocp_write() calls is performed to
> program the RTL registers for recovery.
> 
> With about 130 of these sequential calls to r8168_mac_ocp_write() this looks like
> a lock storm that will stall all of the cores and CPUs on the same memory controller
> for certain time I/O takes to finish.
> 
> In a sequential case of RTL register programming, a sequence of writes to the RTL
> registers can be coalesced under a same raw spinlock. This can dramatically decrease
> the number of bus stalls in a multicore or multi-CPU system:
> 
>     static void rtl_hw_start_8411_2(struct rtl8169_private *tp)
>     {
> 
>     ...
> 
>     /* The following Realtek-provided magic fixes an issue with the RX unit
>      * getting confused after the PHY having been powered-down.
>      */
> 
>     static const struct recover_8411b_info init_zero_seq[] = {
> 	{ 0xFC28, 0x0000 }, { 0xFC2A, 0x0000 }, { 0xFC2C, 0x0000 },
> 	...
>     };
> 
>     static const struct recover_8411b_info recover_seq[] = {
> 	{ 0xF800, 0xE008 }, { 0xF802, 0xE00A }, { 0xF804, 0xE00C },
> 	...
>     };
> 
>     static const struct recover_8411b_info final_seq[] = {
> 	{ 0xFC2A, 0x0743 }, { 0xFC2C, 0x0801 }, { 0xFC2E, 0x0BE9 },
> 	...
>     };
> 
>     r8168_mac_ocp_write_seq(tp, init_zero_seq);
>     mdelay(3);
>     r8168_mac_ocp_write(tp, 0xFC26, 0x0000);
>     r8168_mac_ocp_write_seq(tp, recover_seq);
>     r8168_mac_ocp_write(tp, 0xFC26, 0x8000);
>     r8168_mac_ocp_write_seq(tp, final_seq);
>     }
> 
> The hex data is preserved intact through s/r8168_mac_ocp_write[(]tp,/{ / and s/[)];/ },/
> functions that only changed the function names and the ending of the line, so the actual
> hex data is unchanged.
> 
> Note that the reason for the introduction of the original commit
> was to enable recovery of the RX unit on the RTL8411b which was confused by the
> powered-down PHY. This sequence of r8168_mac_ocp_write() calls amplifies the problem
> into a series of about 500+ memory bus locks, most waiting for the main MMIO memory
> read-modify-write under a LOCK. The memory barrier in RTL_W32 should suffice for
> the programming sequence to reach RTL NIC registers.
> 
> [0] https://bugzilla.redhat.com/show_bug.cgi?id=1692075
> 
> Fixes: fe4e8db0392a6 ("r8169: fix issue with confused RX unit after PHY power-down on RTL8411b")
> Cc: Heiner Kallweit <hkallweit1@gmail.com>
> Cc: Marco Elver <elver@google.com>
> Cc: nic_swsd@realtek.com
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Link: https://lore.kernel.org/lkml/20231028005153.2180411-1-mirsad.todorovac@alu.unizg.hr/
> Link: https://lore.kernel.org/lkml/20231028110459.2644926-1-mirsad.todorovac@alu.unizg.hr/
> Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
> ---
> v5:
>  added unlocked primitives to allow mac ocs modify grouping
>  applied coalescing of mac ocp writes/modifies for 8168ep and 8117
>  some formatting fixes to please checkpatch.pl
> 
> v4:
>  fixed complaints as advised by Heiner and checkpatch.pl
>  split the patch into five sections to be more easily manipulated and reviewed
>  introduced r8168_mac_ocp_write_seq()
>  applied coalescing of mac ocp writes/modifies for 8168H, 8125 and 8125B
> 
> v3:
>  removed register/mask pair array sentinels, so using ARRAY_SIZE().
>  avoided duplication of RTL_W32() call code as advised by Heiner.
> 
>  drivers/net/ethernet/realtek/r8169_main.c | 173 ++++++----------------
>  1 file changed, 46 insertions(+), 127 deletions(-)
> 

Patch it self looks good to me, just consider the comments regarding commit
message and Fixes tag for patch 1.
