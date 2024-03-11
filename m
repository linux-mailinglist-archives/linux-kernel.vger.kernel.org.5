Return-Path: <linux-kernel+bounces-99572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FFF878A1F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FCEE1F218B6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 21:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3A956B81;
	Mon, 11 Mar 2024 21:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GsSAD3w7"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB61CA47
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 21:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710192869; cv=none; b=dG1G+Hkk5rJcTm9uNxXoiLo1v7UoCt9Efvdn6zcUEKT5wajzxFaJH6ETdZonqg2qW5op0y4/Vc6eAfgBa18AmGReVYruYyc+DcQe8p5Wjv63V62KBJuul2DoMupKgG00npYRAFmTzIMsiR/fTN4Fdpyuuuku42xByXbTeDOGnQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710192869; c=relaxed/simple;
	bh=uzQhki3TZLwS9pRJVIDLPEOGmIH8pLGWj8nfm3LeQTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b8ROFBcWyqXJAm823mLf25WYhsd2otH7iGtfxOH2CV5+DK3E2bNsbsieH4JYSR9HNlp/yAv9ROSFEfrTnBb7TDaHZMQ5XO7KNni3/7RLcxtLqtzr0wtFl+s0dlnXOnHW4PmlslJrsEXpYP4+RmT0f+MPHc6iIlZYEAYIXKD6SD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GsSAD3w7; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4132f780ee2so5647365e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 14:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710192865; x=1710797665; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AoyPbLE8gmCKUzlWjn5/O0DOw7C9hT1ZPXAyBMqR3Fc=;
        b=GsSAD3w7CJiFYpSAWww5aDT4pXeQzZKocbPeWKCg7feU3E4aLoa3pT0YbRvwbpMWEq
         3rVJprMaki/AzBMHQ/Dv4Wu0L7HIadMKeAwotSp0A7WyrKSvm1KFz4j7DaPCQj6OcyjZ
         F2nXD4MYfYU5d4gRYXQJyh/LAiLI3vy05FGZ3L61tXNqzJfloq0fiHEQuj40jHdeXkkE
         a3rjVvXado/+3T2liCOJcTPF8Il4Gc0gIaRgZEIJ2wTCwcRJeaZmlHWmfOSEPhgJYKJq
         Z5GNBj0vlNDEFqDJhDym37+JLTUyW4LO2z4A15pikQwOgrvN12ijJnI9dJw1LF9ywPCC
         5FJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710192865; x=1710797665;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AoyPbLE8gmCKUzlWjn5/O0DOw7C9hT1ZPXAyBMqR3Fc=;
        b=jTh9cmnWQlFvTOADk3b3EnI5Z5GmhXfCgAl3K6hw0U2e+MMFHQ0jM9GQ4C/rv78IHf
         JFwXaaSayliF5ATxS/aJUTjsOml7DE7uHMXEF1JBPYg7RPquKDo6Hr8iZstbunbCTBLI
         7FfSCuHgZ4gRVwxZ67P8PJbiHmirJj0uKCYyWWCz7fs0I+SFMhoBKyd1Xbai854ahMRU
         qVJuF/RdGhdvjrIA5ADRPLYAgMjOcitE3zA0QqTzjXueO/qMFu1K/myAYU6fFxNRIHkh
         6jB4c8yYWEY0ovzxyGniPLujOPSuC0BNcADdHsixwcm1gjefzaGnC1FXsxpNlLDKgLN6
         88MQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1aKcAtHVTpJoIUZH1HKXuqLAq+M6SM8OmuO1aq22q0dVjd4x1XNHqUnEKlcEom//N3rJg9Ya9qTbFKl7QdV36kESXDDIpMG1y2Q7V
X-Gm-Message-State: AOJu0Yz0XvI0ENMBV6rirXaTFFKP4hf9zVSdcGEFVKQYUI8/8xfg1nPH
	h64ewsnrtuft6825EktSRutUWoPCfb6vTif/AEKpKJB29W/tJBp1
X-Google-Smtp-Source: AGHT+IHeTsmiGAFRaMFvRUX0CuqRYgUclChkh7JV2jlmIrvs043PuYKtImihvBvshPA85fGUgQwnbg==
X-Received: by 2002:a05:600c:35c8:b0:413:1619:a78 with SMTP id r8-20020a05600c35c800b0041316190a78mr7101556wmq.4.1710192865153;
        Mon, 11 Mar 2024 14:34:25 -0700 (PDT)
Received: from [192.168.1.101] ([129.0.78.235])
        by smtp.gmail.com with ESMTPSA id l2-20020a05600c4f0200b00412a31d2e2asm10416778wmq.32.2024.03.11.14.34.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 14:34:24 -0700 (PDT)
Message-ID: <b9cc75d2-3e06-43d6-8b70-38d1c97124d2@gmail.com>
Date: Mon, 11 Mar 2024 22:34:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] staging: wlan-ng: p80211conv: fix indentation
 problems, introduced by previous commit
Content-Language: en-US
To: Philipp Hortmann <philipp.g.hortmann@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: outreachy@lists.linux.dev
References: <Ze9Ie67PCSvBU+og@MOLeToid>
 <6d643351-8924-4c86-9fb5-9951e016f5db@gmail.com>
From: "Felix N. Kimbu" <felixkimbu1@gmail.com>
In-Reply-To: <6d643351-8924-4c86-9fb5-9951e016f5db@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thank for you the feedback Philipp, I have checked

and corrected the checkpatch warnings.


Signed-off-by: Felix N. Kimbu <felixkimbu1@gmail.com>
---
  drivers/staging/wlan-ng/p80211conv.c | 14 +++++++-------
  1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/wlan-ng/p80211conv.c 
b/drivers/staging/wlan-ng/p80211conv.c
index a0413928a843..e48a80df87a6 100644
--- a/drivers/staging/wlan-ng/p80211conv.c
+++ b/drivers/staging/wlan-ng/p80211conv.c
@@ -186,9 +186,9 @@ int skb_ether_to_p80211(struct wlandevice *wlandev, 
u32 ethconv,
          if (!p80211_wep->data)
              return -ENOMEM;
          decrypt_check = wep_encrypt(wlandev, skb->data, p80211_wep->data,
-                                      skb->len,
-                                    wlandev->hostwep & 
HOSTWEP_DEFAULTKEY_MASK,
-                                    p80211_wep->iv, p80211_wep->icv);
+                        skb->len,
+                        wlandev->hostwep & HOSTWEP_DEFAULTKEY_MASK,
+                        p80211_wep->iv, p80211_wep->icv);
          if (decrypt_check) {
              netdev_warn(wlandev->netdev,
                      "Host en-WEP failed, dropping frame (%d).\n",
@@ -306,10 +306,10 @@ int skb_p80211_to_ether(struct wlandevice 
*wlandev, u32 ethconv,
              return 1;
          }
          decrypt_check = wep_decrypt(wlandev, skb->data + 
payload_offset + 4,
-                                    payload_length - 8, -1,
-                                    skb->data + payload_offset,
-                                    skb->data + payload_offset +
-                                    payload_length - 4);
+                        payload_length - 8, -1,
+                        skb->data + payload_offset,
+                        skb->data + payload_offset +
+                        payload_length - 4);
          if (decrypt_check) {
              /* de-wep failed, drop skb. */
              netdev_dbg(netdev, "Host de-WEP failed, dropping frame 
(%d).\n",
-- 
2.34.1

On 3/11/24 20:31, Philipp Hortmann wrote:
> On 3/11/24 19:07, Felix N. Kimbu wrote:
>> This change renames the local variable foo to decrypt_check in functions
>> skb_ether_to_p80211(...) and skb_p80211_to_ether(...), giving intuitive
>> meaning to the identifier.
>>
>> It also indents the parameters to match the the opening parentheses.
>>
>> Signed-off-by: Felix N. Kimbu <felixkimbu1@gmail.com>
>
> Hi Felix,
>
> I think the subject names the subsystem "staging" and then the driver 
> which is "wlan-ng" the file can follow but you cannot omit the driver 
> name.
>
>
> Please check the following checkpatch warnings:
> File Nr: 0    Patch: ../../../Downloads/20240311-[PATCH] staging_ 
> p80211conv_ Rename local foo to decrypt_check-15036.txt
> WARNING: Possible repeated word: 'the'
> #11:
> It also indents the parameters to match the the opening parentheses.
>
> ERROR: code indent should use tabs where possible
> #41: FILE: drivers/staging/wlan-ng/p80211conv.c:189:
> +^I^I^I^I  ^I^I^I^I^Iskb->len,$
>
> WARNING: please, no space before tabs
> #41: FILE: drivers/staging/wlan-ng/p80211conv.c:189:
> +^I^I^I^I  ^I^I^I^I^Iskb->len,$
>
> CHECK: Alignment should match open parenthesis
> #41: FILE: drivers/staging/wlan-ng/p80211conv.c:189:
> +        decrypt_check = wep_encrypt(wlandev, skb->data, 
> p80211_wep->data,
> +                                      skb->len,
>
> WARNING: line length of 115 exceeds 100 columns
> #42: FILE: drivers/staging/wlan-ng/p80211conv.c:190:
> +                                    wlandev->hostwep & 
> HOSTWEP_DEFAULTKEY_MASK,
>
> WARNING: line length of 105 exceeds 100 columns
> #43: FILE: drivers/staging/wlan-ng/p80211conv.c:191:
> +                                    p80211_wep->iv, p80211_wep->icv);
>
> CHECK: Alignment should match open parenthesis
> #72: FILE: drivers/staging/wlan-ng/p80211conv.c:309:
> +        decrypt_check = wep_decrypt(wlandev, skb->data + 
> payload_offset + 4,
> +                                    payload_length - 8, -1,
>
> total: 1 errors, 4 warnings, 2 checks, 58 lines checked
>
> Thanks for your support.
>
> Bye Philipp
>
>
>> ---
>>   drivers/staging/wlan-ng/p80211conv.c | 30 ++++++++++++++--------------
>>   1 file changed, 15 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/staging/wlan-ng/p80211conv.c 
>> b/drivers/staging/wlan-ng/p80211conv.c
>> index 8336435eccc2..a0413928a843 100644
>> --- a/drivers/staging/wlan-ng/p80211conv.c
>> +++ b/drivers/staging/wlan-ng/p80211conv.c
>> @@ -93,7 +93,7 @@ int skb_ether_to_p80211(struct wlandevice *wlandev, 
>> u32 ethconv,
>>       struct wlan_ethhdr e_hdr;
>>       struct wlan_llc *e_llc;
>>       struct wlan_snap *e_snap;
>> -    int foo;
>> +    int decrypt_check;
>>         memcpy(&e_hdr, skb->data, sizeof(e_hdr));
>>   @@ -185,14 +185,14 @@ int skb_ether_to_p80211(struct wlandevice 
>> *wlandev, u32 ethconv,
>>           p80211_wep->data = kmalloc(skb->len, GFP_ATOMIC);
>>           if (!p80211_wep->data)
>>               return -ENOMEM;
>> -        foo = wep_encrypt(wlandev, skb->data, p80211_wep->data,
>> -                  skb->len,
>> -                  wlandev->hostwep & HOSTWEP_DEFAULTKEY_MASK,
>> -                  p80211_wep->iv, p80211_wep->icv);
>> -        if (foo) {
>> +        decrypt_check = wep_encrypt(wlandev, skb->data, 
>> p80211_wep->data,
>> +                                      skb->len,
>> +                                    wlandev->hostwep & 
>> HOSTWEP_DEFAULTKEY_MASK,
>> +                                    p80211_wep->iv, p80211_wep->icv);
>> +        if (decrypt_check) {
>>               netdev_warn(wlandev->netdev,
>>                       "Host en-WEP failed, dropping frame (%d).\n",
>> -                    foo);
>> +                    decrypt_check);
>>               kfree(p80211_wep->data);
>>               return 2;
>>           }
>> @@ -265,7 +265,7 @@ int skb_p80211_to_ether(struct wlandevice 
>> *wlandev, u32 ethconv,
>>       struct wlan_llc *e_llc;
>>       struct wlan_snap *e_snap;
>>   -    int foo;
>> +    int decrypt_check;
>>         payload_length = skb->len - WLAN_HDR_A3_LEN - WLAN_CRC_LEN;
>>       payload_offset = WLAN_HDR_A3_LEN;
>> @@ -305,15 +305,15 @@ int skb_p80211_to_ether(struct wlandevice 
>> *wlandev, u32 ethconv,
>>                      "WEP frame too short (%u).\n", skb->len);
>>               return 1;
>>           }
>> -        foo = wep_decrypt(wlandev, skb->data + payload_offset + 4,
>> -                  payload_length - 8, -1,
>> -                  skb->data + payload_offset,
>> -                  skb->data + payload_offset +
>> -                  payload_length - 4);
>> -        if (foo) {
>> +        decrypt_check = wep_decrypt(wlandev, skb->data + 
>> payload_offset + 4,
>> +                                    payload_length - 8, -1,
>> +                                    skb->data + payload_offset,
>> +                                    skb->data + payload_offset +
>> +                                    payload_length - 4);
>> +        if (decrypt_check) {
>>               /* de-wep failed, drop skb. */
>>               netdev_dbg(netdev, "Host de-WEP failed, dropping frame 
>> (%d).\n",
>> -                   foo);
>> +                   decrypt_check);
>>               wlandev->rx.decrypt_err++;
>>               return 2;
>>           }
>

