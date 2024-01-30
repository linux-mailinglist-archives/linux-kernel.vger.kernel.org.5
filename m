Return-Path: <linux-kernel+bounces-44268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D4C841FAF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D62D328758C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A703605B6;
	Tue, 30 Jan 2024 09:38:21 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B7936136;
	Tue, 30 Jan 2024 09:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706607500; cv=none; b=LuyZKXweldHVTb968rFr0kIdw6TBC2a1wmhWwPgg5g5sqipH42lQ3SVGNi6oSMylzC57WNu96f5PyEbp5KaGE+K5YldGEdZdoa9+GEbgATMsZs0U/rckQTAbRrWDYM/dhft7H6Le24C1Mw+vLsQ+qe/PVCJ70avnILddGJTJzOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706607500; c=relaxed/simple;
	bh=gvv19zqxW14BsujCAiUj0yEYiIAlglbjJLVslB9p7Yo=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=t43a3j9axYEUdsUXTC+NgddNwy+Gacr4th/86ykBBBOqc/Ho96/qfizJSAA6eYWNfZDNLEQdUhXUUrq+Q5vyDnHD07r73gw7rkE93kfXdW5GRehOwEDLflEk8ctDWTNhcmBceqVvUMwjhxEGulseTfwG8ZDpLny4mReMEQLBZpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40e775695c6so33268475e9.3;
        Tue, 30 Jan 2024 01:38:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706607497; x=1707212297;
        h=in-reply-to:autocrypt:from:references:cc:to:content-language
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hkhx57IqUhgUmW61bFGwsLZg9VvVbT6hgIKYxggshYQ=;
        b=E10tahkbEXEtgeoT3ZUuq8omdeA6+T5fFBTSPfwHFMAzXDHXYYPVOsUB9n1C2Emt6e
         pT0jZ7goeKdleF48WDt3M8Jl1+l16pDM6WTnIgntx802kXM5P36QvDeqhuFz/90B/pSX
         R5x04vJ+vhCJ6rRGSSIOnWVKrvHRcrOA2JfeZYNwg0Xua3gVMUgNPTvG+it2wZhlMFeJ
         T9V863/FRp0nUUB5ytbobiHdyM+Ow7GRvW2ZSYOU+35vicJVjCHy+wXLikP9tF5vkHcy
         vNhXqZCyMLgDCa9S0Uh664ScGDKJ2+2p8Ouqde4ByAT/SLkzbpyagEckXjhMoWbpQ1eM
         MjWg==
X-Gm-Message-State: AOJu0YzU6p6n8FL+BKWLHp9q6wWZeM8vWDWC3rXMrYcKUHHAk+nEhAo3
	gYRG6Et1BFUfJ3Mrg809crOiVjhPTQYReEbwezK/Xt1eRtCyYDrOy5IHthoUClU=
X-Google-Smtp-Source: AGHT+IGYr3MdaybWscCOTH/T04mAxBNauiLqa0dYBD9YvpvaFszbMQpZ0v+PlKPxAwjkgCXu3oPHBA==
X-Received: by 2002:a05:600c:a386:b0:40e:fb8f:debe with SMTP id hn6-20020a05600ca38600b0040efb8fdebemr3027123wmb.38.1706607496891;
        Tue, 30 Jan 2024 01:38:16 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id v1-20020a5d59c1000000b0033aeab6f75fsm5969690wry.79.2024.01.30.01.38.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 01:38:16 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------l5RfG1JWEc0zpM4e5O6H1wJy"
Message-ID: <040064c5-c285-4e02-b545-47c5085f0068@kernel.org>
Date: Tue, 30 Jan 2024 10:38:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: mxs-auart broken in v6.2 and onwards
Content-Language: en-US
To: Emil Kronborg <emil.kronborg@protonmail.com>, linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <miwgbnvy3hjpnricubg76ytpn7xoceehwahupy25bubbduu23s@om2lptpa26xw>
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <miwgbnvy3hjpnricubg76ytpn7xoceehwahupy25bubbduu23s@om2lptpa26xw>

This is a multi-part message in MIME format.
--------------l5RfG1JWEc0zpM4e5O6H1wJy
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 27. 01. 24, 22:35, Emil Kronborg wrote:
> After updating Linux on an i.MX28 board, serial communication over AUART
> broke. When I TX from the board and measure on the TX pin, it seems like
> the HW fifo is not emptied before the transmission is stopped. I
> bisected the bad commit to be 2d141e683e9a ("tty: serial: use
> uart_port_tx() helper"). Since it concerns multiple drivers, simply
> reverting it is not feasible. One solution would be to effectively
> revert the commit for just mxs-auart.c, but maybe you have a better
> idea? Any pointers is appreciated.

Hm, the tx stop handling is weird throughout mxs. What about the 
attached patch?

thanks,
-- 
js
suse labs

--------------l5RfG1JWEc0zpM4e5O6H1wJy
Content-Type: text/x-patch; charset=UTF-8; name="0001-mxs-fix.patch"
Content-Disposition: attachment; filename="0001-mxs-fix.patch"
Content-Transfer-Encoding: base64

RnJvbSAwZjViMTUzNzQ5NTNmMWU0YjY1NzIyYjNkYmJlZjljZTE0YTNjMDE4IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiAiSmlyaSBTbGFieSAoU1VTRSkiIDxqaXJpc2xhYnlA
a2VybmVsLm9yZz4KRGF0ZTogVHVlLCAzMCBKYW4gMjAyNCAxMDozNjozNSArMDEwMApTdWJq
ZWN0OiBbUEFUQ0hdIG14czogZml4CgpTaWduZWQtb2ZmLWJ5OiBKaXJpIFNsYWJ5IChTVVNF
KSA8amlyaXNsYWJ5QGtlcm5lbC5vcmc+Ci0tLQogZHJpdmVycy90dHkvc2VyaWFsL214cy1h
dWFydC5jIHwgIDUgKysrKy0KIGluY2x1ZGUvbGludXgvc2VyaWFsX2NvcmUuaCAgICB8IDEw
ICsrKysrKy0tLS0KIDIgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgNSBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwvbXhzLWF1YXJ0LmMg
Yi9kcml2ZXJzL3R0eS9zZXJpYWwvbXhzLWF1YXJ0LmMKaW5kZXggNDI0ZGI4NDY2NzU1Li5l
YzAxM2QxM2NjM2QgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdHR5L3NlcmlhbC9teHMtYXVhcnQu
YworKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwvbXhzLWF1YXJ0LmMKQEAgLTU5NCwxMyArNTk0
LDE2IEBAIHN0YXRpYyB2b2lkIG14c19hdWFydF90eF9jaGFycyhzdHJ1Y3QgbXhzX2F1YXJ0
X3BvcnQgKnMpCiAJCXJldHVybjsKIAl9CiAKLQlwZW5kaW5nID0gdWFydF9wb3J0X3R4KCZz
LT5wb3J0LCBjaCwKKwlwZW5kaW5nID0gdWFydF9wb3J0X3R4X25vX3N0b3AoJnMtPnBvcnQs
IGNoLAogCQkhKG14c19yZWFkKHMsIFJFR19TVEFUKSAmIEFVQVJUX1NUQVRfVFhGRiksCiAJ
CW14c193cml0ZShjaCwgcywgUkVHX0RBVEEpKTsKIAlpZiAocGVuZGluZykKIAkJbXhzX3Nl
dChBVUFSVF9JTlRSX1RYSUVOLCBzLCBSRUdfSU5UUik7CiAJZWxzZQogCQlteHNfY2xyKEFV
QVJUX0lOVFJfVFhJRU4sIHMsIFJFR19JTlRSKTsKKworCWlmICh1YXJ0X3R4X3N0b3BwZWQo
JnMtPnBvcnQpKQorICAgICAgICAgICAgICAgbXhzX2F1YXJ0X3N0b3BfdHgoJnMtPnBvcnQp
OwogfQogCiBzdGF0aWMgdm9pZCBteHNfYXVhcnRfcnhfY2hhcihzdHJ1Y3QgbXhzX2F1YXJ0
X3BvcnQgKnMpCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3NlcmlhbF9jb3JlLmggYi9p
bmNsdWRlL2xpbnV4L3NlcmlhbF9jb3JlLmgKaW5kZXggYzVmYTcyYzhmOTZlLi4xODI1NmZk
NzY1YzkgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvc2VyaWFsX2NvcmUuaAorKysgYi9p
bmNsdWRlL2xpbnV4L3NlcmlhbF9jb3JlLmgKQEAgLTc2OSw3ICs3NjksNyBAQCBzdHJ1Y3Qg
dWFydF9kcml2ZXIgewogCiB2b2lkIHVhcnRfd3JpdGVfd2FrZXVwKHN0cnVjdCB1YXJ0X3Bv
cnQgKnBvcnQpOwogCi0jZGVmaW5lIF9fdWFydF9wb3J0X3R4KHVwb3J0LCBjaCwgdHhfcmVh
ZHksIHB1dF9jaGFyLCB0eF9kb25lLCBmb3JfdGVzdCwgICAgICBcCisjZGVmaW5lIF9fdWFy
dF9wb3J0X3R4KHVwb3J0LCBjaCwgdHhfcmVhZHksIHB1dF9jaGFyLCBzaG91bGRfc3RvcCwg
dHhfZG9uZSwgZm9yX3Rlc3QsICAgICAgXAogCQlmb3JfcG9zdCkJCQkJCQkgICAgICBcCiAo
ewkJCQkJCQkJCSAgICAgIFwKIAlzdHJ1Y3QgdWFydF9wb3J0ICpfX3BvcnQgPSAodXBvcnQp
OwkJCQkgICAgICBcCkBAIC03OTksNyArNzk5LDcgQEAgdm9pZCB1YXJ0X3dyaXRlX3dha2V1
cChzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0KTsKIAlpZiAocGVuZGluZyA8IFdBS0VVUF9DSEFS
UykgewkJCQkJICAgICAgXAogCQl1YXJ0X3dyaXRlX3dha2V1cChfX3BvcnQpOwkJCQkgICAg
ICBcCiAJCQkJCQkJCQkgICAgICBcCi0JCWlmIChwZW5kaW5nID09IDApCQkJCQkgICAgICBc
CisJCWlmIChzaG91bGRfc3RvcCAmJiBwZW5kaW5nID09IDApCQkJCQkgICAgICBcCiAJCQlf
X3BvcnQtPm9wcy0+c3RvcF90eChfX3BvcnQpOwkJCSAgICAgIFwKIAl9CQkJCQkJCQkgICAg
ICBcCiAJCQkJCQkJCQkgICAgICBcCkBAIC04MzQsNyArODM0LDcgQEAgdm9pZCB1YXJ0X3dy
aXRlX3dha2V1cChzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0KTsKICAqLwogI2RlZmluZSB1YXJ0
X3BvcnRfdHhfbGltaXRlZChwb3J0LCBjaCwgY291bnQsIHR4X3JlYWR5LCBwdXRfY2hhciwg
dHhfZG9uZSkgKHsgXAogCXVuc2lnbmVkIGludCBfX2NvdW50ID0gKGNvdW50KTsJCQkJCSAg
ICAgIFwKLQlfX3VhcnRfcG9ydF90eChwb3J0LCBjaCwgdHhfcmVhZHksIHB1dF9jaGFyLCB0
eF9kb25lLCBfX2NvdW50LAkgICAgICBcCisJX191YXJ0X3BvcnRfdHgocG9ydCwgY2gsIHR4
X3JlYWR5LCBwdXRfY2hhciwgdHJ1ZSwgdHhfZG9uZSwgX19jb3VudCwJICAgICAgXAogCQkJ
X19jb3VudC0tKTsJCQkJCSAgICAgIFwKIH0pCiAKQEAgLTg0OCw4ICs4NDgsMTAgQEAgdm9p
ZCB1YXJ0X3dyaXRlX3dha2V1cChzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0KTsKICAqIFNlZSB1
YXJ0X3BvcnRfdHhfbGltaXRlZCgpIGZvciBtb3JlIGRldGFpbHMuCiAgKi8KICNkZWZpbmUg
dWFydF9wb3J0X3R4KHBvcnQsIGNoLCB0eF9yZWFkeSwgcHV0X2NoYXIpCQkJXAotCV9fdWFy
dF9wb3J0X3R4KHBvcnQsIGNoLCB0eF9yZWFkeSwgcHV0X2NoYXIsICh7fSksIHRydWUsICh7
fSkpCisJX191YXJ0X3BvcnRfdHgocG9ydCwgY2gsIHR4X3JlYWR5LCBwdXRfY2hhciwgdHJ1
ZSwgKHt9KSwgdHJ1ZSwgKHt9KSkKIAorI2RlZmluZSB1YXJ0X3BvcnRfdHhfbm9fc3RvcChw
b3J0LCBjaCwgdHhfcmVhZHksIHB1dF9jaGFyKQkJXAorCV9fdWFydF9wb3J0X3R4KHBvcnQs
IGNoLCB0eF9yZWFkeSwgcHV0X2NoYXIsIGZhbHNlLCAoe30pLCB0cnVlLCAoe30pKQogLyoK
ICAqIEJhdWQgcmF0ZSBoZWxwZXJzLgogICovCi0tIAoyLjQzLjAKCg==

--------------l5RfG1JWEc0zpM4e5O6H1wJy--

