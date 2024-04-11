Return-Path: <linux-kernel+bounces-139685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1499F8A067C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE90B28C135
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD7213B5BC;
	Thu, 11 Apr 2024 03:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="focpLRK8"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFC96FD9;
	Thu, 11 Apr 2024 03:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712804862; cv=none; b=tiNDByeP+tswKuy10CyjpvxknhiYTVKNIKTmMP7XcAC5PCDrz+QXZLCieOyE5gflHcciPx8FL7pBaGC7y2aPG2joEIHed0R69+22EM6DKIKLy3X8x8PnPD5sA6dnB683lmNfWPhrSNtR/NrwApyq9vrOot6HR6hNPc3tJOrR1Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712804862; c=relaxed/simple;
	bh=eggrNPew7WL6+8TUTDGE22qpFFAVAMGKIys1efccoD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r2OmoKpHQVyxJrAr1cad8BjoXlQBt6RjqA47fFndKG+FIXCa2VJSWH0pYfSSjf9taEZ3EvU7wNdpx8LlTPZf3WY8vavPiJ8eZXjWZ8fyI7l1ycPqC+rvjx8gDNGRESohcHc5m1DQt6jIq0FDGvngXMbvG2oEZrW4H3CnphQmKwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=focpLRK8; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-434a76386feso28648291cf.1;
        Wed, 10 Apr 2024 20:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712804859; x=1713409659; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eggrNPew7WL6+8TUTDGE22qpFFAVAMGKIys1efccoD0=;
        b=focpLRK8Ok6fGnpHONLDbbzqckW/1POHiDVxpjW+rF5jUbnbFbEo89NS6aySZnMcbl
         YRRbFuu294B/D6OmlD6FveM7R6ehVWjcThUP2KiIHQxj3BXvTdGXcnpkZawrNtXOjnNF
         fsRBv9WCMMdqS/ODJBH7sbVHyXaC5WuXcTN0HqxuhU9jTYytcAlU0l2HrZPm0DJrqYpG
         UdgHi8KwxgUSiMo9rltiyOtkQdD475MNtBy3KfeEH7oQ0msBmNP4koWXyFTi5grX3vz5
         OiQULaLNH8U2EqS1TkvulMKB49EZEwL22IQMZatPNUWqF5KvnNVzkeIgY00g1Kbsj4j/
         acjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712804859; x=1713409659;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eggrNPew7WL6+8TUTDGE22qpFFAVAMGKIys1efccoD0=;
        b=vvbpc1v6IIxwSjUUeEeMMi35WKMvJoQfxaDs/htDi7h86UqzPlkpKXaPBUx5xVvAs5
         bOFS4kHQf6r8Obz+4VbYpV5jTIW074OYCRskQhzEiZ0R5/xwkCFjj+HV0xlImi3OpcLk
         /Fb5xfBSRE1XzzHd0qWxu3LC2oTubhYBdvZhNUvWcgcDi/ojq6cJbdksEzk45xYgBAi5
         xfuLoq1Fk2MR8ttZRaRGWOJrwaWBW5rgtD4E5FITPQ4lKWRKGDipaIuSC82NgsMdw2dp
         rEn4kip4d3fLCOMULEPCmqEitjIiu+h7cfErYLX0RKsucVGVrZKa8Ktqc9oyiFzrOv6I
         bjig==
X-Forwarded-Encrypted: i=1; AJvYcCX+Yoc9Gu0UxdLngx4LAqwIygM1WjaNBSH9Pph2RCOWZDEhhBts9oLOKfnveiYihiLord7kWgSV15FprnZbTgn3hVfrYX0FjUSU42A+bhgNUyl823NlOzd/a2z0chxznJC/dUABu33d
X-Gm-Message-State: AOJu0Yxc4Trb0H+8JgVcIIII4hJFuCKAag5R+Z8235Z+bGOkJBcravIV
	HO51Oh0+bD7Qy0RITjKO9KJo67scORB4qvVOs/BnqHXqzNVwfsvV
X-Google-Smtp-Source: AGHT+IGWwIq8HaWfVhN9Y2PyoqZ2BZE2sKVkTeOP2o/oQySvdK+nxNfWcQlP5bDfKrsYNRKK2/LkAg==
X-Received: by 2002:ac8:588f:0:b0:434:5008:3bd3 with SMTP id t15-20020ac8588f000000b0043450083bd3mr4808251qta.23.1712804859101;
        Wed, 10 Apr 2024 20:07:39 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net. [108.48.157.169])
        by smtp.gmail.com with ESMTPSA id d24-20020ac85358000000b004364d940d3dsm338470qto.96.2024.04.10.20.07.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 20:07:38 -0700 (PDT)
Message-ID: <6665b819-bfae-00fa-64f7-5a7bbd586d4e@gmail.com>
Date: Wed, 10 Apr 2024 23:07:37 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3] clk: set initial best mux parent to current parent
 with CLK_MUX_ROUND_CLOSEST
Content-Language: en-US
To: Yang Xiwen <forbidden405@outlook.com>, Maxime Ripard <mripard@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lukasz Majewski <lukma@denx.de>,
 u-boot@lists.denx.de
References: <20240307-mux-v3-1-0885fc1ab2c9@outlook.com>
 <20240307-hot-hummingbird-of-atheism-87503c@houat>
 <SEZPR06MB6959882F5DA673456A3AA85D96202@SEZPR06MB6959.apcprd06.prod.outlook.com>
 <20240311-speedy-bat-of-art-4facfc@houat>
 <SEZPR06MB69597C834C90FE1FBA1F1D83962B2@SEZPR06MB6959.apcprd06.prod.outlook.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <SEZPR06MB69597C834C90FE1FBA1F1D83962B2@SEZPR06MB6959.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMy8xMi8yNCAwNDo1MiwgWWFuZyBYaXdlbiB3cm90ZToNCj4gT24gMy8xMS8yMDI0IDU6
MzQgUE0sIE1heGltZSBSaXBhcmQgd3JvdGU6DQo+PiBPbiBUaHUsIE1hciAwNywgMjAyNCBh
dCAwNzoxODowNVBNICswODAwLCBZYW5nIFhpd2VuIHdyb3RlOg0KPj4+IE9uIDMvNy8yMDI0
IDQ6NDggUE0sIE1heGltZSBSaXBhcmQgd3JvdGU6DQo+Pj4+IEhpLA0KPj4+Pg0KPj4+PiBP
biBUaHUsIE1hciAwNywgMjAyNCBhdCAxMDowMzo1MEFNICswODAwLCBZYW5nIFhpd2VuIHZp
YSBCNCBSZWxheSB3cm90ZToNCj4+Pj4+IEZyb206IFlhbmcgWGl3ZW4gPGZvcmJpZGRlbjQw
NUBvdXRsb29rLmNvbT4NCj4+Pj4+DQo+Pj4+PiBPcmlnaW5hbGx5LCB0aGUgaW5pdGlhbCBj
bG9jayByYXRlIGlzIGhhcmRjb2RlZCB0byAwLCB0aGlzIGNhbiBsZWFkIHRvDQo+Pj4+PiBz
b21lIHByb2JsZW0gd2hlbiBzZXR0aW5nIGEgdmVyeSBzbWFsbCByYXRlIHdpdGggQ0xLX01V
WF9ST1VORF9DTE9TRVNULg0KPj4+Pj4NCj4+Pj4+IEZvciBleGFtcGxlLCBpZiB0aGUgbG93
ZXN0IHBvc3NpYmxlIHJhdGUgcHJvdmlkZWQgYnkgdGhlIG11eCBpcyAxMDAwSHosDQo+Pj4+
PiBzZXR0aW5nIGEgcmF0ZSBiZWxvdyA1MDBIeiB3aWxsIGZhaWwsIGJlY2F1c2Ugbm8gY2xv
Y2sgY2FuIHByb3ZpZGUgYQ0KPj4+Pj4gYmV0dGVyIHJhdGUgdGhhbiB0aGUgbm9uLWV4aXN0
YW50IDBIei4gQnV0IGl0IHNob3VsZCBzdWNjZWVkIHdpdGggMTAwMEh6DQo+Pj4+PiBiZWlu
ZyBzZXQuDQo+Pj4+Pg0KPj4+Pj4gU2V0dGluZyB0aGUgaW5pdGlhbCBiZXN0IHBhcmVudCB0
byBjdXJyZW50IHBhcmVudCBjb3VsZCBzb2x2ZSB0aGlzIGJ1Zy4NCj4+Pj4+DQo+Pj4+PiBT
aWduZWQtb2ZmLWJ5OiBZYW5nIFhpd2VuIDxmb3JiaWRkZW40MDVAb3V0bG9vay5jb20+DQo+
Pj4+IEkgZG9uJ3QgdGhpbmsgaXQgd291bGQgYmUgdGhlIHdheSB0byBnby4gVGhlIGJpZ2dl
c3QgaXNzdWUgdG8gbWUgaXMgdGhhdA0KPj4+PiBpdCdzIGluY29uc2lzdGVudCwgYW5kIG9u
bHkgY2hhbmdpbmcgdGhlIGJlaGF2aW91ciBmb3IgYSBnaXZlbiBmbGFnDQo+Pj4+IGRvZXNu
J3Qgc29sdmUgdGhhdC4NCj4+Pg0KPj4+IEkgdGhpbmsgdGhlIGN1cnJlbnQgYmVoYXZpb3Ig
aXMgb2RkIGJ1dCBjb25mb3JtcyB0byB0aGUgZG9jdW1lbnQgaWYNCj4+PiBDTEtfTVVYX1JP
VU5EX0NMT1NFU1QgaXMgbm90IHNwZWNpZmllZC4NCj4+IGNsa19tdXhfZGV0ZXJtaW5lX3Jh
dGVfZmxhZ3MgaXNuJ3QgZG9jdW1lbnRlZCwgYW5kIHRoZSBkZXRlcm1pbmVfcmF0ZQ0KPj4g
Y2xrX29wcyBkb2N1bWVudGF0aW9uIGRvZXNuJ3QgbWVudGlvbiBpdCBjYW4gcmV0dXJuIGFu
IGVycm9yLg0KPj4NCj4+PiBJZiBpIHVuZGVyc3RhbmQgY29ycmVjdGx5LCB0aGUgZGVmYXVs
dCBiZWhhdmlvciBvZiBtdXggY2xvY2tzIGlzIHRvDQo+Pj4gc2VsZWN0IHRoZSBjbG9zZXN0
IHJhdGUgbG93ZXIgdGhhbiByZXF1ZXN0ZWQgcmF0ZSwgYW5kDQo+Pj4gQ0xLX01VWF9ST1VO
RF9DTE9TRVNUIHJlbW92ZXMgdGhlICJsb3dlciB0aGFuIiBsaW1pdGF0aW9uLCB3aGljaCBp
cw0KPj4+IHdoYXQgdGhpcyB2ZXJzaW9uIHRyaWVzIHRvIGFjY29tcGxpc2guDQo+PiBUaGUg
c2l0dWF0aW9uIGlzIG5vdCBhcyBjbGVhci1jdXQgYXMgeW91IG1ha2UgaXQgdG8gYmUsIHVu
Zm9ydHVuYXRlbHkuDQo+PiBUaGUgZGV0ZXJtaW5lX3JhdGUgY2xrX29wcyBpbXBsZW1lbnRh
dGlvbiBzdGF0ZXM6DQo+Pg0KPj4gwqDCoCBHaXZlbiBhIHRhcmdldCByYXRlIGFzIGlucHV0
LCByZXR1cm5zIHRoZSBjbG9zZXN0IHJhdGUgYWN0dWFsbHkNCj4+IMKgwqAgc3VwcG9ydGVk
IGJ5IHRoZSBjbG9jaywgYW5kIG9wdGlvbmFsbHkgdGhlIHBhcmVudCBjbG9jayB0aGF0IHNo
b3VsZCBiZQ0KPj4gwqDCoCB1c2VkIHRvIHByb3ZpZGUgdGhlIGNsb2NrIHJhdGUuDQo+Pg0K
Pj4gU28gQ0xLX01VWF9ST1VORF9DTE9TRVNUIHNob3VsZG4ndCBleGlzdCwgYmVjYXVzZSB0
aGF0J3Mgd2hhdA0KPj4gZGV0ZXJtaW5lX3JhdGUgZXhwZWN0cyBzbyBpdCBzaG91bGQgYWx3
YXlzIGJlIHRoZXJlLg0KPj4NCj4+IE5vdywgdGhlICJhY3R1YWxseSBzdXBwb3J0ZWQgYnkg
dGhlIGNsb2NrIiBjYW4gYmUgaW50ZXJwcmV0ZWQgaW4NCj4+IG11bHRpcGxlIHdheXMsIGFu
ZCBtb3N0IGltcG9ydGFudGx5LCBkb2Vzbid0IHN0YXRlIHdoYXQgdGhlIGJlaGF2aW91ciBp
cw0KPj4gaWYgd2UgY2FuJ3QgZmluZCBhIHJhdGUgYWN0dWFsbHkgc3VwcG9ydGVkIGJ5IHRo
ZSBjbG9jay4NCj4+DQo+PiBCdXQgbm93LCB0aGlzIHNpdHVhdGlvbiBoYXMgYmVlbiBhbWJp
Z3VvdXMgZm9yIGEgd2hpbGUgYW5kIHRodXMgZHJpdmVycw0KPj4ga2luZCBvZiByZWxpZWQg
b24gdGhhdCBhbWJpZ3VpdHkuDQo+Pg0KPj4gU28gdGhlIHdheSB0byBmaXggaXQgdXAgaXM6
DQo+Pg0KPj4gwqDCoCAtIEFzc2VzcyB3aGF0IGRyaXZlcnMgYXJlIHJlbHlpbmcgb24NCj4+
IMKgwqAgLSBEb2N1bWVudCB0aGUgY3VycmVudCBiZWhhdmlvdXIgaW4gY2xrX29wcyBkZXRl
cm1pbmVfcmF0ZQ0KPiANCj4gDQo+ICBGcm9tIG15IGludmVzdGlnYXRpb24sIGl0J3MgdG90
YWxseSBhIG1lc3MsIGVzcGVjaWFsbHkgZm9yIHBsYXRmb3JtIGNsayBkcml2ZXJzIChQTEwp
LiBTb21lIGRyaXZlcnMgYWx3YXlzIHJvdW5kIGRvd24sIHRoZSBvdGhlcnMgcm91bmQgdG8g
bmVhcmVzdCwgd2l0aCBvciB3aXRob3V0IGEgc3BlY2lmaWMgZmxhZyB0byBzd2l0Y2ggYmV0
d2VlbiB0aGVtLCBkZXBlbmQgb24gdGhlIGRpdmlzaW9uIGZ1bmN0aW9ucyB0aGV5IGNob29z
ZS4gRml4aW5nIGFsbCBvZiB0aGVtIHNlZW1zIG5lZWRzIHF1aXRlIGEgbG90IG9mIHRpbWUg
YW5kIHdvdWxkIHByb2JhYmx5IGludHJvZHVjZSBzb21lIHJlZ3Jlc3Npb25zLg0KPiANCj4g
V2UnZCBwcm9iYWJseSBvbmx5IGhhdmUgdG8gc2F5IGJvdGggcm91bmRpbmcgdG8gbmVhcmVz
dCBhbmQgcm91bmRpbmcgZG93biBhcmUgYWNjZXB0YWJsZSwgdGhvdWdoIGVpdGhlciBvbmUg
aXMgcHJlZmVycmVkLg0KDQoNCj4+IMKgwqAgLSBNYWtlIGNsa19tdXhfZGV0ZXJtaW5lX3Jh
dGVfZmxhZ3MgY29uc2lzdGVudCB3aXRoIHRoYXQNCj4gDQo+IA0KPiBJIHRoaW5rIHdlIG11
c3Qga2VlcCBleGlzdGluZyBmbGFncyBhbmQgZG9jdW1lbnQgdGhlIGN1cnJlbnQgYmVoYXZp
b3IgY29ycmVjdGx5IGJlY2F1c2Ugb2YgdGhlIG1hc3NpdmUgZXhpc3RpbmcgdXNlcnMgb2Yg
Y2xrX211eC4NCj4gDQo+IA0KPiBUaGF0J3Mgd2h5IGknbSBnb2luZyB0byBvbmx5IGZpeCBD
TEtfTVVYX1JPVU5EX0NMT1NFU1QgdXNlcnMuIEhvcGVmdWxseSBpdCB3b24ndCBjYXVzZSB0
b28gbWFueSByZWdyZXNzaW9ucy4NCj4gDQo+IA0KPj4gwqDCoCAtIFJ1biB0aGF0IHRocm91
Z2gga2VybmVsY2kgdG8gbWFrZSBzdXJlIHdlIGRvbid0IGhhdmUgYW55IHJlZ3Jlc3Npb24N
Cj4gDQo+IA0KPiBXZSBkb24ndC4gSSBydW4gJ3Rvb2xzL3Rlc3Rpbmcva3VuaXQva3VuaXQu
cHkgcnVuIC0ta3VuaXRjb25maWcgZHJpdmVycy9jbGsvLmt1bml0Y29uZmlnJyBlYWNoIHRp
bWUgYmVmb3JlIGkgc2VuZCBwYXRjaGVzLg0KPiANCj4gDQo+IE92ZXIgYWxsLCBpdCBzZWVt
cyBxdWl0ZSBhIGxvdCBvZiB3b3JrIGhlcmUuDQo+IA0KPiANCj4+DQo+PiBNYXhpbWUNCj4g
DQo+IA0KPiBUaGUgc2l0dWF0aW9uIGhlcmUgYmVjb21lcyBldmVuIG1vcmUgY29tcGxleCB3
aGVuIGl0IGNvbWVzIHRvIFUtQm9vdCBjbGsgZnJhbWV3b3JrLiBUaGV5IGNob3NlIHNsaWdo
dGx5IGRpZmZlcmVudCBwcm90b3R5cGVzIGFuZCBzdGF0ZWQgY2xrX3NldF9yYXRlKCkgY2Fu
IGZhaWwgd2l0aCAtdmUuIA0KDQpNYXliZSB5b3UgbWVhbiBjbGtfZ2V0X3JhdGU/IFNldHRp
bmcgYSByYXRlIGNhbiBhbHdheXMgZmFpbCBkdWUgdG8gdGhlDQpuYXR1cmUgb2YgY2xvY2tz
Li4uDQoNClBlcnNvbmFsbHksIEkgYW0gbm90IHRlcnJpYmx5IGF0dGFjaGVkIHRvIHRoZSBB
UEkgKGFzIG5vdCBtYW55IGNhbGxlcnMNCmhhbmRsZSBlcnJvcnMgY29ycmVjdGx5KSwgYnV0
IEkgaGF2ZSBub3QgaGFkIHRoZSB0aW1lIHJlY2VudGx5IHRvIGRvIGFueQ0KY2xlYW51cC4N
Cg0KSXQncyBhIGdyZWF0IGJ1cmRlbiBmb3IgY2xrIGRyaXZlciBhdXRob3JzIGFuZCBtYWlu
dGFpbmVycyB3aGVuIHRoZXkgdHJ5IHRvIHBvcnQgdGhlaXIgZHJpdmVycyB0byBVLUJvb3Qu
IExldCdzIENjIFUtQm9vdCBjbGsgbWFpbnRhaW5lcnMgYXMgd2VsbCwgYW5kIHNlZSBob3cg
d2UgY2FuIHJlc29sdmUgdGhlIG1lc3MgaGVyZS4NCj4gDQoNClJlZ2FyZGluZyByb3VuZGlu
ZyBtb2RlLCBJTU8gaXQgaXMgYmV0dGVyIHRvIGxldCBkcml2ZXIgYXV0aG9ycyBwaWNrDQp3
aGF0ZXZlciBpcyBjb252ZW5pZW50LiBSb3VuZCBjbG9zZXN0IGlzIGJlc3QsIGJ1dCB0aGVy
ZSBtYXkgYmUgY29kZSBzaXplDQpzYXZpbmdzIGZvciByb3VuZCBsb3dlc3Qgb3Igc29tZSBv
dGhlciBzY2hlbWUuIFsxXSBoYXMgdGhlIGN1cnJlbnQNCnJlY29tbWVuZGF0aW9uLCB3aGlj
aCBpcyB0byBwdW50IGFuZCBsZXQgdGhlIGNhbGxlciB1c2Ugcm91bmRfcmF0ZSBpZg0KdGhl
eSBhY3R1YWxseSBjYXJlLg0KDQotLVNlYW4NCg0KWzFdIGh0dHBzOi8vc291cmNlLmRlbngu
ZGUvdS1ib290L2N1c3RvZGlhbnMvdS1ib290LWNsay8tL2Jsb2IvYThkYzQ5NjVmMDlkMjhh
NTljMTU2NDM3NjczZGRiNjY4NjBjODQ3ZS9pbmNsdWRlL2Nsay11Y2xhc3MuaCNMMTQzDQo=


