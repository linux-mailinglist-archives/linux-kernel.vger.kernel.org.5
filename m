Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41E5800276
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 05:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjLAERx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 23:17:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjLAERw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 23:17:52 -0500
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6651716;
        Thu, 30 Nov 2023 20:17:58 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1fadb9ac169so76189fac.0;
        Thu, 30 Nov 2023 20:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701404277; x=1702009077; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=TDN/fGOxF3LJOJ9JO74US7YL4e/4RmultsA3vElIFMQ=;
        b=O2qp1y3zYcW6ad17DURukxXwTNSJaPZrQz/nfQh63hnFR4YpfpD2ltAKmIJFKM2Ryy
         8x89ypoldW6i9umgq7i10SEecMZQEDtzyRbjryRJHeSIPoWuZY2mJBubOfHbpIiLjYzH
         rfVo26W74b3tOtGkWtIORAmqci674T48KveMMfLdZzgY1aT0jD3StYyRJ9AqmZfyBLsm
         PUr1oVbCsDhyvXcIdpNoFyGUuK/7ZgF0prBYpZ/JFHLJiLobaDQOd6tYwXuWVkQxiGSz
         1VfqeuLodHMfY9KyO3kYOMWSH/6LZ3N7p9q6zsU8cvL/i7mCoEueBVSRQKkc+aWOgtTP
         0Cew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701404277; x=1702009077;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TDN/fGOxF3LJOJ9JO74US7YL4e/4RmultsA3vElIFMQ=;
        b=REejF98N4lXYlGMXCsS7jSIHpDm1Du7nkCz5v73ydulpeSSjSnCL5DxH0vCLWT/hiN
         N8UgUkWFBAC9CMrxFErjh/F03NuYW7PiJmPLqF1NGO0JLpvH2VyzEAx0fdIQJ3Yrb59t
         i/GtVxE2NiOxUEcwO9k+0VIGgrfPBbv9jAeUAfjBMzpoZbHtNchsv8HNT1LO+O3jE78M
         LNipB+DMJdxqMidZu/Gwfk2lv+BbtAQM6ILxtmKuWjMrIK3S+FZ2jAJsqDvfHbOljtud
         zJ4oAXRWKPsOrD5Q/RC8hAJYqd4nRdAheqT8vK1zny2r3cKoiwefgicMWhHY6D719kWO
         tQFg==
X-Gm-Message-State: AOJu0YxZRP+UIGSPcHd4RXnagNvz8rHZcFS6LS9aMtNomcQ+S7l/te/e
        IhkfsdioR83hSlPi8NvTWSQ=
X-Google-Smtp-Source: AGHT+IEaVXQoCZ2LHfE3UaQHEp1SLEtlDFe4B3U/JpWvrz+d2Bc1q0UJGsdQqVBz/a64kaRdjYi8CA==
X-Received: by 2002:a05:6870:d88d:b0:1fa:25df:4031 with SMTP id oe13-20020a056870d88d00b001fa25df4031mr26189358oac.4.1701404277629;
        Thu, 30 Nov 2023 20:17:57 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id gb17-20020a056870671100b001f9fe9e05desm621658oab.36.2023.11.30.20.17.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 20:17:57 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <13fb95af-bf92-4539-bece-b3d1fecaadc3@roeck-us.net>
Date:   Thu, 30 Nov 2023 20:17:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/9] hwmon: (dell-smm) Add support for WMI SMM
 interface
Content-Language: en-US
To:     Armin Wolf <W_Armin@gmx.de>, pali@kernel.org
Cc:     jdelvare@suse.com, hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231123004820.50635-1-W_Armin@gmx.de>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAlVcphcFCRmg06EACgkQyx8mb86fmYFg0RAA
 nzXJzuPkLJaOmSIzPAqqnutACchT/meCOgMEpS5oLf6xn5ySZkl23OxuhpMZTVX+49c9pvBx
 hpvl5bCWFu5qC1jC2eWRYU+aZZE4sxMaAGeWenQJsiG9lP8wkfCJP3ockNu0ZXXAXwIbY1O1
 c+l11zQkZw89zNgWgKobKzrDMBFOYtAh0pAInZ9TSn7oA4Ctejouo5wUugmk8MrDtUVXmEA9
 7f9fgKYSwl/H7dfKKsS1bDOpyJlqhEAH94BHJdK/b1tzwJCFAXFhMlmlbYEk8kWjcxQgDWMu
 GAthQzSuAyhqyZwFcOlMCNbAcTSQawSo3B9yM9mHJne5RrAbVz4TWLnEaX8gA5xK3uCNCeyI
 sqYuzA4OzcMwnnTASvzsGZoYHTFP3DQwf2nzxD6yBGCfwNGIYfS0i8YN8XcBgEcDFMWpOQhT
 Pu3HeztMnF3HXrc0t7e5rDW9zCh3k2PA6D2NV4fews9KDFhLlTfCVzf0PS1dRVVWM+4jVl6l
 HRIAgWp+2/f8dx5vPc4Ycp4IsZN0l1h9uT7qm1KTwz+sSl1zOqKD/BpfGNZfLRRxrXthvvY8
 BltcuZ4+PGFTcRkMytUbMDFMF9Cjd2W9dXD35PEtvj8wnEyzIos8bbgtLrGTv/SYhmPpahJA
 l8hPhYvmAvpOmusUUyB30StsHIU2LLccUPPOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAlVcpi8FCRmg08MACgkQyx8mb86fmYHNRQ/+
 J0OZsBYP4leJvQF8lx9zif+v4ZY/6C9tTcUv/KNAE5leyrD4IKbnV4PnbrVhjq861it/zRQW
 cFpWQszZyWRwNPWUUz7ejmm9lAwPbr8xWT4qMSA43VKQ7ZCeTQJ4TC8kjqtcbw41SjkjrcTG
 wF52zFO4bOWyovVAPncvV9eGA/vtnd3xEZXQiSt91kBSqK28yjxAqK/c3G6i7IX2rg6pzgqh
 hiH3/1qM2M/LSuqAv0Rwrt/k+pZXE+B4Ud42hwmMr0TfhNxG+X7YKvjKC+SjPjqp0CaztQ0H
 nsDLSLElVROxCd9m8CAUuHplgmR3seYCOrT4jriMFBtKNPtj2EE4DNV4s7k0Zy+6iRQ8G8ng
 QjsSqYJx8iAR8JRB7Gm2rQOMv8lSRdjva++GT0VLXtHULdlzg8VjDnFZ3lfz5PWEOeIMk7Rj
 trjv82EZtrhLuLjHRCaG50OOm0hwPSk1J64R8O3HjSLdertmw7eyAYOo4RuWJguYMg5DRnBk
 WkRwrSuCn7UG+qVWZeKEsFKFOkynOs3pVbcbq1pxbhk3TRWCGRU5JolI4ohy/7JV1TVbjiDI
 HP/aVnm6NC8of26P40Pg8EdAhajZnHHjA7FrJXsy3cyIGqvg9os4rNkUWmrCfLLsZDHD8FnU
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20231123004820.50635-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/23 16:48, Armin Wolf wrote:
> This patch series adds support for an alternative SMM calling
> backend to the dell-smm-hwmon driver. The reason for this is
> that on some modern machines, the legacy SMM calling interface
> does not work anymore and the SMM handler can be called over
> ACPI WMI instead.
> 
> The first four patches prepare the driver by allowing to
> specify different SMM calling backends, and by moving most of
> the DMI handling into i8k_init() so that the DMI tables can
> keep their __initconst attributes (the WMI SMM backend driver
> does not probe at module init time). The fifth patch does some
> minor cleanup, while the next three patches implement the new
> WMI SMM calling backend. The last patch adds the machine of
> the user who requested and tested the changes to the fan control
> whitelist.
> 
> If the driver does not detect the legacy SMM interface, either
> because the machine is not whitelisted or because the SMM handler
> does not react, it registers an WMI driver which will then bound
> to the WMI SMM interface and do the remaining initialization.
> 
> The deprecated procfs interface is not supported when using the
> WMI SMM calling backend for the following reason: the WMI driver
> can potentially be instantiated multiple times while the deprectated
> procfs interface cannot. This should not cause any regressions
> because on machines supporting only the WMI SMM interface, the
> driver would, until now, not load anyway.
> 
> All patches where tested on a Dell Inspiron 3505 and a Dell
> OptiPlex 7000.
> 

Series applied.

Thanks,
Guenter

