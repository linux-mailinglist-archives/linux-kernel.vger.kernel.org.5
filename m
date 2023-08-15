Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7F177D0EC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 19:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238822AbjHORXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 13:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238844AbjHORXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 13:23:33 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEAB51BD2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 10:23:02 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-991c786369cso762735066b.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 10:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692120100; x=1692724900;
        h=in-reply-to:content-language:references:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=StR+EmKA7BsuS3UE5UP084n9Jk6cl004ctN+UiK0eP8=;
        b=hZnOVP9g4SqDAgQ++bsRTnnPPdS5gfclGq3dZ1TPZ5aIdJCWWphFIsMHV8BRkaAtAu
         0LZwI3nC6Xwkr4sW/ltUbN+eIyXgCs9AcPRbXoCgrQ5znY6Vv/5Usdpw3w6+gxnWsB9L
         Oa5muz/Ga60T0sEedTWkoQ4ar6W/1T9OlYHGefvWQV6wbiVKfo25WqhN5H9tJXoJm4Xs
         Fkup+2kJLgsZhMxppQ8kBZiz8hMvz7ppifDE3JKeihvPsu7PVl+5t5JSZvr0h0aryIQr
         yi0PrvRWacQazB4rl6KIy+nT+Tr8krscY8q+e9NSqVsPpQOtMZoWjcAOBOoZCPovjRy6
         WHXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692120100; x=1692724900;
        h=in-reply-to:content-language:references:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=StR+EmKA7BsuS3UE5UP084n9Jk6cl004ctN+UiK0eP8=;
        b=aaIX0BqZ1lSx8HVrlYzmomh/dHQnicFErvfroVCo4rLAhFWdoSluWU4S79XxAZvSfi
         zgjDqyTe5IrWdlA7dwU5DzF1x5f8pl53Q1PJq8BTAVicr+ZoUfV3fw8QyfTt0J+oEzXm
         S/8/mH/5aR4Kk9wMPuLOy++hJrx8zF2lkcWNn+6Y1RsXqrhh2EhIsJcYoXk61Ca41GGK
         0ieRadzM68G/af9n5lgXpl0qGaNxhuJAEUkwmqE9YFgUDjuKBt9O47vmC7vu8XYyvv+0
         YTWqngdcP0quOE3sS+OWyMQxaNtJW7VycjZj93LucBG2POo3++EwVhXrHcGgvuyOyVLg
         yFcQ==
X-Gm-Message-State: AOJu0YyfV61Ejpdwa9TMAvi32hMbY+u2Do4KJ5GXmS7yeLT7eezZc9MI
        5F9StS592P7f4eUPbNahRUBFqf/xy8BzJZ98
X-Google-Smtp-Source: AGHT+IEKwEOIIlh3BPvKhBc+ZvWJLc19y+XWN52KjRyBQKnROyY+oBpxaxfux78gerKPJ/khwAuvnQ==
X-Received: by 2002:a17:906:224b:b0:99d:ddae:f5d4 with SMTP id 11-20020a170906224b00b0099dddaef5d4mr845008ejr.44.1692120099538;
        Tue, 15 Aug 2023 10:21:39 -0700 (PDT)
Received: from ?IPV6:2a02:908:8b3:1840:3b18:d442:101d:d282? ([2a02:908:8b3:1840:3b18:d442:101d:d282])
        by smtp.gmail.com with ESMTPSA id a10-20020a170906244a00b00992d70f8078sm7250847ejb.106.2023.08.15.10.21.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 10:21:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------T30xKVBGOWQAtqsLhirPfOz0"
Message-ID: <d55fc4d3-015d-8cc2-417e-e92aa4687ca2@gmail.com>
Date:   Tue, 15 Aug 2023 19:21:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Maxim Schwalm <maxim.schwalm@gmail.com>
Subject: Re: [PATCH 02/11] drm/bridge: tc358768: Fix bit updates
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Francesco Dolcini <francesco@dolcini.it>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Aradhya Bhatia <a-bhatia1@ti.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>
References: <20230804-tc358768-v1-0-1afd44b7826b@ideasonboard.com>
 <20230804-tc358768-v1-2-1afd44b7826b@ideasonboard.com>
 <cd5d39a2-4f4c-419a-8137-d2719135e205@gmail.com>
 <241937b4-1ef8-abad-7c4a-b26bfab86a3a@ideasonboard.com>
 <92396880-edb5-d8e0-4fcf-54aeaa2b40d7@gmail.com>
 <52151daa-90af-a6c0-9b03-f69081321253@ideasonboard.com>
Content-Language: en-US
In-Reply-To: <52151daa-90af-a6c0-9b03-f69081321253@ideasonboard.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------T30xKVBGOWQAtqsLhirPfOz0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 14.08.23 08:34, Tomi Valkeinen wrote:
> On 13/08/2023 03:23, Maxim Schwalm wrote:
>> Hi,
>>
>> On 11.08.23 19:02, Tomi Valkeinen wrote:
>>> On 11/08/2023 19:23, Péter Ujfalusi wrote:
>>>>
>>>>
>>>> On 04/08/2023 13:44, Tomi Valkeinen wrote:
>>>>> The driver has a few places where it does:
>>>>>
>>>>> if (thing_is_enabled_in_config)
>>>>> 	update_thing_bit_in_hw()
>>>>>
>>>>> This means that if the thing is _not_ enabled, the bit never gets
>>>>> cleared. This affects the h/vsyncs and continuous DSI clock bits.
>>>>
>>>> I guess the idea was to keep the reset value unless it needs to be flipped.
>>>>
>>>>>
>>>>> Fix the driver to always update the bit.
>>>>>
>>>>> Fixes: ff1ca6397b1d ("drm/bridge: Add tc358768 driver")
>>>>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>>>>> ---
>>>>>    drivers/gpu/drm/bridge/tc358768.c | 13 +++++++------
>>>>>    1 file changed, 7 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
>>>>> index bc97a837955b..b668f77673c3 100644
>>>>> --- a/drivers/gpu/drm/bridge/tc358768.c
>>>>> +++ b/drivers/gpu/drm/bridge/tc358768.c
>>>>> @@ -794,8 +794,8 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
>>>>>    		val |= BIT(i + 1);
>>>>>    	tc358768_write(priv, TC358768_HSTXVREGEN, val);
>>>>>    
>>>>> -	if (!(mode_flags & MIPI_DSI_CLOCK_NON_CONTINUOUS))
>>>>> -		tc358768_write(priv, TC358768_TXOPTIONCNTRL, 0x1);
>>>>> +	tc358768_write(priv, TC358768_TXOPTIONCNTRL,
>>>>> +		       (mode_flags & MIPI_DSI_CLOCK_NON_CONTINUOUS) ? 0 : BIT(0));
>>>>>    
>>>>>    	/* TXTAGOCNT[26:16] RXTASURECNT[10:0] */
>>>>>    	val = tc358768_to_ns((lptxcnt + 1) * dsibclk_nsk * 4);
>>>>> @@ -861,11 +861,12 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
>>>>>    	tc358768_write(priv, TC358768_DSI_HACT, hact);
>>>>>    
>>>>>    	/* VSYNC polarity */
>>>>> -	if (!(mode->flags & DRM_MODE_FLAG_NVSYNC))
>>>>> -		tc358768_update_bits(priv, TC358768_CONFCTL, BIT(5), BIT(5));
>>>>> +	tc358768_update_bits(priv, TC358768_CONFCTL, BIT(5),
>>>>> +			     (mode->flags & DRM_MODE_FLAG_PVSYNC) ? BIT(5) : 0);
>>>>
>>>> Was this the reverse before and should be:
>>>> (mode->flags & DRM_MODE_FLAG_PVSYNC) ? 0 : BIT(5)
>>>
>>> Bit 5 is 1 for active high vsync polarity. The test was previously
>>> !nvsync, i.e. the same as pvsync.
>>
>> this statement doesn't seem to be true, since this change causes a
>> regression on the Asus TF700T. Apparently, !nvsync is true and pvsync is
>> false in the present case.
> 
> panasonic_vvx10f004b00_mode in panel_simple.c doesn't seem to have mode 
> flags set. I would say that means the panel doesn't care about the sync 
> polarities (which obviously is not the case), but maybe there's an 
> assumption that if sync polarities are not set, the default is... 
> positive? But I can't find any mention about this.
> 
> Does it work for you if you set the polarities in 
> panasonic_vvx10f004b00_mode?

The panel seems to work with either negative or positive H-/Vsync in
conjunction with the attached patch from Thierry. Currently, the display
controller is unconditionally programmed for positive H-/Vsync though.
What should be done in this case?

BTW, the vendor kernel configures the display controller as well as the
bridge for negative H-/Vsync.

Best regards,
Maxim
--------------T30xKVBGOWQAtqsLhirPfOz0
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-drm-tegra-rgb-Parameterize-V-and-H-sync-polarities.patch"
Content-Disposition: attachment;
 filename*0="0001-drm-tegra-rgb-Parameterize-V-and-H-sync-polarities.patc";
 filename*1="h"
Content-Transfer-Encoding: base64

RnJvbSBlZmM0ZjkxMDhiM2Y0NGQzZTAwMTQ2YmRiOTdjOTA2ZjE1ZTJhMDY4IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBUaGllcnJ5IFJlZGluZyA8dHJlZGluZ0BudmlkaWEu
Y29tPgpEYXRlOiBNb24sIDMgQXVnIDIwMTUgMTM6MzQ6MzYgKzAyMDAKU3ViamVjdDogW1BB
VENIXSBkcm0vdGVncmE6IHJnYjogUGFyYW1ldGVyaXplIFYtIGFuZCBILXN5bmMgcG9sYXJp
dGllcwoKVGhlIHBvbGFyaXRpZXMgb2YgdGhlIFYtIGFuZCBILXN5bmMgc2lnbmFscyBhcmUg
ZW5jb2RlZCBhcyBmbGFncyBpbiB0aGUKZGlzcGxheSBtb2RlLCBzbyB1c2UgdGhlIGV4aXN0
aW5nIGluZm9ybWF0aW9uIHRvIHNldHVwIHRoZSBzaWduYWxzIGZvcgp0aGUgUkdCIGludGVy
ZmFjZS4KClNpZ25lZC1vZmYtYnk6IFRoaWVycnkgUmVkaW5nIDx0cmVkaW5nQG52aWRpYS5j
b20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL3RlZ3JhL3JnYi5jIHwgMTggKysrKysrKysrKysr
KysrLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vdGVncmEvcmdiLmMgYi9kcml2ZXJz
L2dwdS9kcm0vdGVncmEvcmdiLmMKaW5kZXggNzk1NjZjOWVhOGZmLi5jY2U0MjJjMmQ2YTYg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS90ZWdyYS9yZ2IuYworKysgYi9kcml2ZXJz
L2dwdS9kcm0vdGVncmEvcmdiLmMKQEAgLTk5LDYgKzk5LDcgQEAgc3RhdGljIHZvaWQgdGVn
cmFfcmdiX2VuY29kZXJfZGlzYWJsZShzdHJ1Y3QgZHJtX2VuY29kZXIgKmVuY29kZXIpCiAK
IHN0YXRpYyB2b2lkIHRlZ3JhX3JnYl9lbmNvZGVyX2VuYWJsZShzdHJ1Y3QgZHJtX2VuY29k
ZXIgKmVuY29kZXIpCiB7CisJc3RydWN0IGRybV9kaXNwbGF5X21vZGUgKm1vZGUgPSAmZW5j
b2Rlci0+Y3J0Yy0+c3RhdGUtPmFkanVzdGVkX21vZGU7CiAJc3RydWN0IHRlZ3JhX291dHB1
dCAqb3V0cHV0ID0gZW5jb2Rlcl90b19vdXRwdXQoZW5jb2Rlcik7CiAJc3RydWN0IHRlZ3Jh
X3JnYiAqcmdiID0gdG9fcmdiKG91dHB1dCk7CiAJdTMyIHZhbHVlOwpAQCAtMTA4LDEwICsx
MDksMjEgQEAgc3RhdGljIHZvaWQgdGVncmFfcmdiX2VuY29kZXJfZW5hYmxlKHN0cnVjdCBk
cm1fZW5jb2RlciAqZW5jb2RlcikKIAl2YWx1ZSA9IERFX1NFTEVDVF9BQ1RJVkUgfCBERV9D
T05UUk9MX05PUk1BTDsKIAl0ZWdyYV9kY193cml0ZWwocmdiLT5kYywgdmFsdWUsIERDX0RJ
U1BfREFUQV9FTkFCTEVfT1BUSU9OUyk7CiAKLQkvKiBYWFg6IHBhcmFtZXRlcml6ZT8gKi8K
KwkvKiBjb25maWd1cmUgSC0gYW5kIFYtc3luYyBzaWduYWwgcG9sYXJpdGllcyAqLwogCXZh
bHVlID0gdGVncmFfZGNfcmVhZGwocmdiLT5kYywgRENfQ09NX1BJTl9PVVRQVVRfUE9MQVJJ
VFkoMSkpOwotCXZhbHVlICY9IH5MVlNfT1VUUFVUX1BPTEFSSVRZX0xPVzsKLQl2YWx1ZSAm
PSB+TEhTX09VVFBVVF9QT0xBUklUWV9MT1c7CisKKwlpZiAobW9kZS0+ZmxhZ3MgJiBEUk1f
TU9ERV9GTEFHX1BIU1lOQykKKwkJdmFsdWUgJj0gfkxIU19PVVRQVVRfUE9MQVJJVFlfTE9X
OworCisJaWYgKG1vZGUtPmZsYWdzICYgRFJNX01PREVfRkxBR19OSFNZTkMpCisJCXZhbHVl
IHw9IExIU19PVVRQVVRfUE9MQVJJVFlfTE9XOworCisJaWYgKG1vZGUtPmZsYWdzICYgRFJN
X01PREVfRkxBR19QVlNZTkMpCisJCXZhbHVlICY9IH5MVlNfT1VUUFVUX1BPTEFSSVRZX0xP
VzsKKworCWlmIChtb2RlLT5mbGFncyAmIERSTV9NT0RFX0ZMQUdfTlZTWU5DKQorCQl2YWx1
ZSB8PSBMVlNfT1VUUFVUX1BPTEFSSVRZX0xPVzsKKwogCXRlZ3JhX2RjX3dyaXRlbChyZ2It
PmRjLCB2YWx1ZSwgRENfQ09NX1BJTl9PVVRQVVRfUE9MQVJJVFkoMSkpOwogCiAJLyogWFhY
OiBwYXJhbWV0ZXJpemU/ICovCi0tIAoyLjM5LjIKCg==

--------------T30xKVBGOWQAtqsLhirPfOz0--
