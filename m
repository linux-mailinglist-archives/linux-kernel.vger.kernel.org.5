Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A567D0C6F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 11:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376764AbjJTJ54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 05:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376740AbjJTJ5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 05:57:55 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE21D57
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 02:57:53 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-581d487f8dbso328096eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 02:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1697795872; x=1698400672; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:subject:from:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Q9N6S4ALX+SZJhAz9hRlr3013WbG++jkjP2TtqUytBg=;
        b=ShEoFWWw9YHDgs1aUj+UZ9uojJHNbZgzlzPtV+5oxXhINRtLxwcU/jf+WG9VINMXrk
         pV7vEOIwmZ1/gQacIYrTo+CdttoWp/RBzwt4+XkMrUYXWZ3/rhgqI1wfJAdVtLuE1xXu
         UC/Rg154hYrEqL9Iy0m7cSLJYXFO4b97O43ss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697795872; x=1698400672;
        h=in-reply-to:references:cc:to:subject:from:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q9N6S4ALX+SZJhAz9hRlr3013WbG++jkjP2TtqUytBg=;
        b=Dtbtwya69e0qIVYR1N96lGDp5yDFihjXM5Is/Sdsm17Ce7t6CoTrlBdcWUqHGNWnt/
         Bsxp2PkWk61S93S9dTKVQjYA82zMYsPbP9KxrUh+3qti3H8cuVfof7FLHDRDH4tO8HwZ
         sm8oTH5IJJesv5VmVdIYFPCb3PO75mwPSDxbzYRYCRXicBR6xkCZZPYrHR+tv4rA6kmG
         qIv/2BlI8lZIgTtpiI1nCjSKKSF5wQSMXRrVZsoV50E/LIp4BhUd1QZYSqnlTdCRt7x+
         X5uxLJiD7kl+ksnZfLP6u+HcSCB6PwRnRxjVQBRD/CH17ELQ9OfH0aLIjTABI1KQHJw9
         FVRg==
X-Gm-Message-State: AOJu0Yy2Y2DhU5gpHgPzkw4hLhtr6qZqh8p9UHdhXAQgmX3UeLeqncrc
        wOAb+8k132gj1/NcR1Sztyp3wQ==
X-Google-Smtp-Source: AGHT+IFUbpqHvs869DvUI+W6878d202lKWhUGicgkA9tikXHzo3MHGtm9heIwFUuHb6POSpVtZgK7A==
X-Received: by 2002:a05:6358:2812:b0:166:dcf6:cd82 with SMTP id k18-20020a056358281200b00166dcf6cd82mr1324679rwb.14.1697795872401;
        Fri, 20 Oct 2023 02:57:52 -0700 (PDT)
Received: from [192.168.178.137] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a6-20020aa78e86000000b0068fd026b496sm1163371pfr.46.2023.10.20.02.57.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 02:57:47 -0700 (PDT)
Message-ID: <d55c968a-d953-67d7-cdff-f856422607f5@broadcom.com>
Date:   Fri, 20 Oct 2023 11:57:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: Re: [PATCH 1/5] [brcmfmac] Add support for encoding/decoding 6g
 chanspecs
To:     Daniel Berlin <dberlin@dberlin.org>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>
Cc:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, linux-kernel@vger.kernel.org
References: <cover.1697650207.git.dberlin@dberlin.org>
 <0b95944fcf047b3ec83cecb0c65ca24de43810fd.1697650207.git.dberlin@dberlin.org>
In-Reply-To: <0b95944fcf047b3ec83cecb0c65ca24de43810fd.1697650207.git.dberlin@dberlin.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000e5f7a1060822e7bd"
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000e5f7a1060822e7bd
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/19/2023 3:42 AM, Daniel Berlin wrote:
> This patch adds support for 6G chanspecs, as part of adding 6G and
> 802.11ax support.
> 
> I added the correct values for the upcoming 320mhz as well so that the
> info is complete.

Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>> 
Signed-off-by: Daniel Berlin <dberlin@dberlin.org>
> ---
>   .../broadcom/brcm80211/brcmutil/d11.c         | 46 +++++++++++++++----
>   .../broadcom/brcm80211/include/brcmu_d11.h    | 46 +++++++++++++------
>   .../broadcom/brcm80211/include/brcmu_wifi.h   | 27 ++++++++---
>   3 files changed, 89 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmutil/d11.c b/drivers/net/wireless/broadcom/brcm80211/brcmutil/d11.c
> index 1e2b1e487eb7..faf7eeeeb2d5 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmutil/d11.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmutil/d11.c

[...]

> @@ -117,7 +127,9 @@ static void brcmu_d11n_decchspec(struct brcmu_chan *ch)
>   		}
>   		break;
>   	default:
> -		WARN_ONCE(1, "Invalid chanspec 0x%04x\n", ch->chspec);
> +		WARN_ONCE(1,
> +			  "Invalid chanspec - unknown 11n bandwidth 0x%04x\n",
> +			  ch->chspec);

I don't think this provides more info. The WARN_ONCE() already prints 
code location and stack trace.

>   		break;
>   	}
>   
> @@ -129,7 +141,8 @@ static void brcmu_d11n_decchspec(struct brcmu_chan *ch)
>   		ch->band = BRCMU_CHAN_BAND_2G;
>   		break;
>   	default:
> -		WARN_ONCE(1, "Invalid chanspec 0x%04x\n", ch->chspec);
> +		WARN_ONCE(1, "Invalid chanspec - unknown 11n band 0x%04x\n",
> +			  ch->chspec);

ditto

>   		break;
>   	}
>   }
> @@ -156,7 +169,9 @@ static void brcmu_d11ac_decchspec(struct brcmu_chan *ch)
>   			ch->sb = BRCMU_CHAN_SB_U;
>   			ch->control_ch_num += CH_10MHZ_APART;
>   		} else {
> -			WARN_ONCE(1, "Invalid chanspec 0x%04x\n", ch->chspec);
> +			WARN_ONCE(1,
> +				  "Invalid chanspec - unknown 11ac channel distance 0x%04x\n",
> +				  ch->chspec);

ditto

>   		}
>   		break;
>   	case BRCMU_CHSPEC_D11AC_BW_80:
> @@ -177,7 +192,9 @@ static void brcmu_d11ac_decchspec(struct brcmu_chan *ch)
>   			ch->control_ch_num += CH_30MHZ_APART;
>   			break;
>   		default:
> -			WARN_ONCE(1, "Invalid chanspec 0x%04x\n", ch->chspec);
> +			WARN_ONCE(1,
> +				  "Invalid chanspec - unknown 11ac channel distance 0x%04x\n",
> +				  ch->chspec);

ditto

>   			break;
>   		}
>   		break;
> @@ -211,17 +228,24 @@ static void brcmu_d11ac_decchspec(struct brcmu_chan *ch)
>   			ch->control_ch_num += CH_70MHZ_APART;
>   			break;
>   		default:
> -			WARN_ONCE(1, "Invalid chanspec 0x%04x\n", ch->chspec);
> +			WARN_ONCE(1,
> +				  "Invalid chanspec - unknown 11ac channel distance 0x%04x\n",
> +				  ch->chspec);

ditto

>   			break;
>   		}
>   		break;
>   	case BRCMU_CHSPEC_D11AC_BW_8080:
>   	default:
> -		WARN_ONCE(1, "Invalid chanspec 0x%04x\n", ch->chspec);
> +		WARN_ONCE(1,
> +			  "Invalid chanspec - unknown 11ac channel bandwidth 0x%04x\n",
> +			  ch->chspec);
>   		break;
>   	}
>   
>   	switch (ch->chspec & BRCMU_CHSPEC_D11AC_BND_MASK) {
> +	case BRCMU_CHSPEC_D11AC_BND_6G:
> +		ch->band = BRCMU_CHAN_BAND_6G;
> +		break;
>   	case BRCMU_CHSPEC_D11AC_BND_5G:
>   		ch->band = BRCMU_CHAN_BAND_5G;
>   		break;

[...]

> diff --git a/drivers/net/wireless/broadcom/brcm80211/include/brcmu_d11.h b/drivers/net/wireless/broadcom/brcm80211/include/brcmu_d11.h
> index f6344023855c..bb48b7442062 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/include/brcmu_d11.h
> +++ b/drivers/net/wireless/broadcom/brcm80211/include/brcmu_d11.h
> @@ -69,24 +69,44 @@
>   #define  BRCMU_CHSPEC_D11AC_SB_UU	BRCMU_CHSPEC_D11AC_SB_LUU
>   #define  BRCMU_CHSPEC_D11AC_SB_L	BRCMU_CHSPEC_D11AC_SB_LLL
>   #define  BRCMU_CHSPEC_D11AC_SB_U	BRCMU_CHSPEC_D11AC_SB_LLU
> +/* channel sideband indication for frequency >= 240MHz */
> +#define BRCMU_CHSPEC_D11AC_320_SB_MASK	0x0780
> +#define BRCMU_CHSPEC_D11AC_320_SB_SHIFT	7
> +#define BRCMU_CHSPEC_D11AC_SB_LLLL	0x0000
> +#define BRCMU_CHSPEC_D11AC_SB_LLLU	0x0080
> +#define BRCMU_CHSPEC_D11AC_SB_LLUL	0x0100
> +#define BRCMU_CHSPEC_D11AC_SB_LLUU	0x0180
> +#define BRCMU_CHSPEC_D11AC_SB_LULL	0x0200
> +#define BRCMU_CHSPEC_D11AC_SB_LULU	0x0280
> +#define BRCMU_CHSPEC_D11AC_SB_LUUL	0x0300
> +#define BRCMU_CHSPEC_D11AC_SB_LUUU	0x0380
> +#define BRCMU_CHSPEC_D11AC_SB_ULLL	0x0400
> +#define BRCMU_CHSPEC_D11AC_SB_ULLU	0x0480
> +#define BRCMU_CHSPEC_D11AC_SB_ULUL	0x0500
> +#define BRCMU_CHSPEC_D11AC_SB_ULUU	0x0580
> +#define BRCMU_CHSPEC_D11AC_SB_UULL	0x0600
> +#define BRCMU_CHSPEC_D11AC_SB_UULU	0x0680
> +#define BRCMU_CHSPEC_D11AC_SB_UUUL	0x0700
> +#define BRCMU_CHSPEC_D11AC_SB_UUUU	0x0780

These are WCC specific, but I think it is okay to have these definitions 
here.

>   #define BRCMU_CHSPEC_D11AC_BW_MASK	0x3800
>   #define BRCMU_CHSPEC_D11AC_BW_SHIFT	11
> -#define  BRCMU_CHSPEC_D11AC_BW_5	0x0000
> -#define  BRCMU_CHSPEC_D11AC_BW_10	0x0800
> -#define  BRCMU_CHSPEC_D11AC_BW_20	0x1000
> -#define  BRCMU_CHSPEC_D11AC_BW_40	0x1800
> -#define  BRCMU_CHSPEC_D11AC_BW_80	0x2000
> -#define  BRCMU_CHSPEC_D11AC_BW_160	0x2800
> -#define  BRCMU_CHSPEC_D11AC_BW_8080	0x3000
> -#define BRCMU_CHSPEC_D11AC_BND_MASK	0xc000
> -#define BRCMU_CHSPEC_D11AC_BND_SHIFT	14
> -#define  BRCMU_CHSPEC_D11AC_BND_2G	0x0000
> -#define  BRCMU_CHSPEC_D11AC_BND_3G	0x4000
> -#define  BRCMU_CHSPEC_D11AC_BND_4G	0x8000
> -#define  BRCMU_CHSPEC_D11AC_BND_5G	0xc000
> +#define BRCMU_CHSPEC_D11AC_BW_10    0x0800
> +#define BRCMU_CHSPEC_D11AC_BW_20    0x1000
> +#define BRCMU_CHSPEC_D11AC_BW_40    0x1800
> +#define BRCMU_CHSPEC_D11AC_BW_80    0x2000
> +#define BRCMU_CHSPEC_D11AC_BW_160   0x2800
> +#define BRCMU_CHSPEC_D11AC_BW_320   0x0000

320MHz is 802.11be. No need to add this already, but not a biggy.

> +#define BRCMU_CHSPEC_D11AC_BW_8080  0x3000
> +#define BRCMU_CHSPEC_D11AC_BND_MASK 0xc000
> +#define BRCMU_CHSPEC_D11AC_BND_SHIFT 14
> +#define BRCMU_CHSPEC_D11AC_BND_2G   0x0000
> +#define BRCMU_CHSPEC_D11AC_BND_4G   0x8000
> +#define BRCMU_CHSPEC_D11AC_BND_5G   0xc000
> +#define BRCMU_CHSPEC_D11AC_BND_6G   0x4000
>   
>   #define BRCMU_CHAN_BAND_2G		0
>   #define BRCMU_CHAN_BAND_5G		1
> +#define BRCMU_CHAN_BAND_6G		2
>   
>   enum brcmu_chan_bw {
>   	BRCMU_CHAN_BW_20,


--000000000000e5f7a1060822e7bd
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
bpIzNUky46LXMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBhdgSfSodryRUNNWcQ
t/g6MlcKDpFa1kFVFuCuhXMLnjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yMzEwMjAwOTU3NTJaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAISp+D9O9znoEFsn5jL8mi4YsTLDkoUROm4SZ
MwcybDahRKMdk5Z+gJYQhIxX/CJ522fCnM1NpjRt3s1fn8wBn5lsc8z/7jt//YArtGA0Duwo5NBE
h04v9z3Q6TmEtXLA2l3kSzCyS6/+3DQZwo8O6aSOgGuaxrRvJdntOu2v4CQ8bqE/TkSfD7HQH3xk
k6aS7Zbj2mb4anwSqi5SqTi4A4GeRUU8bWg05cQZCEtC4ZfvzkZspNkN4pUN+VZuF6Y3J/HN9SxB
/st58Zt++2/vI0A2n5ctedu7pYRwytqxj7Yxdx/qteHAMm0XnA9qbpHCEFpn/iooh+ff6heKNxiz
vA==
--000000000000e5f7a1060822e7bd--
