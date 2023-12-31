Return-Path: <linux-kernel+bounces-13714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCC1820B8B
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 15:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AC45281CB8
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 14:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D5E8F5A;
	Sun, 31 Dec 2023 14:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="soTq0bXs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75358C00
	for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 14:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d44200b976so23745345ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 06:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1704033694; x=1704638494; darn=vger.kernel.org;
        h=in-reply-to:from:references:to:content-language:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qR7AisN034tfmeU3hSsmuMRULlU7xZ0vyPrtC2ltO3U=;
        b=soTq0bXsLkR6reIsO5ipiDfL6LK5+0kdh95RZDrUaHZ4GOB1Rqd8vieDP+xh2FTMbp
         Oc3DnUK7XIHsbiXpDBE4eDTRKXEWbG91zHNH7H6LeHYBXNLTbw/vrMB1plWCwpO3IEgN
         JBBKZT716irQvCqQ/vKW1HeDDJm/InJkz9W3T+uj114lNJCVsxvz3pDdZalw7iARCTQi
         mOyk8teKIdgZaIeErLpvvO2dhshiebViDRzyig07C5iEKh4tef9m/4G+FldAU6IRs5AF
         6zdyzmQRu2KAt/dW5EAMZZNoaPgMYzI2LoKqzCW6N32r2AWSI3QAOfQ7OcqbAVPmwj7m
         oklw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704033694; x=1704638494;
        h=in-reply-to:from:references:to:content-language:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qR7AisN034tfmeU3hSsmuMRULlU7xZ0vyPrtC2ltO3U=;
        b=VLLXFsTNL9nlFAIYO0yE6WE5YBity780luIa9BplXZ/P6AejivwDQZquRiwRgStSGQ
         dezNe7j/ip3nf5YLGW7AGT3QsFYOLR03t/QQ9R1Jt8pjXJ8KNzgY8sVvyKxu58wJUCbK
         rDURJGwg95AFzqIv0YPMmkPOlAdTEjV5mhZ9KEQVtE/VjRxjNtDBOjVTp6vY7+Pf/DQN
         DxKXpE5hMxo8zv6LzFhyXzWOjD9CAkeBniCjl7kA9ajW4wZF/wX3wXIivcqNw2Wec/Hf
         JdvHNsr+eAKuHZ4m8KwN/Tl4sgFrHVH/lvOqZvm7fDmMPWkLyFYSXS7qoPZsgXi39lyi
         /4ag==
X-Gm-Message-State: AOJu0Yz1O2I8MKBE+ZfnuygIHBrF2EW/lcQM3F/giYLEBqV3apvbs9P9
	pfePv1njJPtJxJGDN8UCEQ8M/kC4nDd2
X-Google-Smtp-Source: AGHT+IF9fCo869OPerxGiV4aR4UhHkT+IVuzo9JZhyWTyq1IwddqMeNHMqAwNLfqk6RA6DEYZyYtzw==
X-Received: by 2002:a05:6a20:7819:b0:194:9dff:4458 with SMTP id a25-20020a056a20781900b001949dff4458mr5500319pzg.3.1704033693912;
        Sun, 31 Dec 2023 06:41:33 -0800 (PST)
Received: from ?IPV6:2804:7f1:e2c0:aba3:7663:8830:3d6b:aa9f? ([2804:7f1:e2c0:aba3:7663:8830:3d6b:aa9f])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902854500b001d49f61cb64sm4310348plo.262.2023.12.31.06.41.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Dec 2023 06:41:33 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------09loKEO8TzhvggEzUJHk0On0"
Message-ID: <360d5a75-b06a-4b52-ba6c-e24a0bffa530@mojatatu.com>
Date: Sun, 31 Dec 2023 11:41:29 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [net?] general protection fault in hfsc_tcf_block
Content-Language: en-US
To: syzbot <syzbot+0039110f932d438130f9@syzkaller.appspotmail.com>,
 davem@davemloft.net, edumazet@google.com, jhs@mojatatu.com,
 jiri@resnulli.us, kuba@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, pctammela@mojatatu.com,
 syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
References: <0000000000007fbc8c060dcc3a5c@google.com>
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <0000000000007fbc8c060dcc3a5c@google.com>

This is a multi-part message in MIME format.
--------------09loKEO8TzhvggEzUJHk0On0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/12/2023 08:04, syzbot wrote:
> HEAD commit:    c2b2ee36250d bridge: cfm: fix enum typo in br_cc_ccm_tx_pa..
> git tree:       net-next
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17a8c0f6e80000

#syz test
--------------09loKEO8TzhvggEzUJHk0On0
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-net-sched-We-should-only-add-appropriate-qdiscs-bloc.patch"
Content-Disposition: attachment;
 filename*0="0001-net-sched-We-should-only-add-appropriate-qdiscs-bloc.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBlNjMzNDA3MDdjZTg1Zjg2MDhlM2MzYWUzY2VjMTM0MGVmMTdlZWRlIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBWaWN0b3IgTm9ndWVpcmEgPHZpY3RvckBtb2phdGF0
dS5jb20+CkRhdGU6IFRodSwgMjggRGVjIDIwMjMgMTM6MTg6NDkgKzAwMDAKU3ViamVjdDog
W1BBVENIIG5ldC1uZXh0IDEvMV0gbmV0L3NjaGVkOiBXZSBzaG91bGQgb25seSBhZGQgYXBw
cm9wcmlhdGUgcWRpc2NzCiBibG9ja3MgdG8gcG9ydHMnIHhhcnJheQoKV2Ugc2hvdWxkIG9u
bHkgYWRkIHFkaXNjcyB0byB0aGUgYmxvY2tzIHBvcnRzJyB4YXJyYXkgaW4gaW5ncmVzcyB0
aGF0CnN1cHBvcnQgaW5ncmVzc19ibG9ja19zZXQvZ2V0IG9yIGluIGVncmVzcyB0aGF0IHN1
cHBvcnQKZWdyZXNzX2Jsb2NrX3NldC9nZXQuCgpGaXhlczogOTEzYjQ3ZDM0MjRlICgibmV0
L3NjaGVkOiBJbnRyb2R1Y2UgdGMgYmxvY2sgbmV0ZGV2IHRyYWNraW5nIGluZnJhIikKClNp
Z25lZC1vZmYtYnk6IFZpY3RvciBOb2d1ZWlyYSA8dmljdG9yQG1vamF0YXR1LmNvbT4KUmV2
aWV3ZWQtYnk6IEphbWFsIEhhZGkgU2FsaW0gPGpoc0Btb2phdGF0dS5jb20+Ci0tLQogbmV0
L3NjaGVkL3NjaF9hcGkuYyB8IDM0ICsrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0t
LS0KIDEgZmlsZSBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9uZXQvc2NoZWQvc2NoX2FwaS5jIGIvbmV0L3NjaGVkL3NjaF9hcGku
YwppbmRleCAyOTkwODZiYjYyMDUuLjQyNmJlODEyNzZmMSAxMDA2NDQKLS0tIGEvbmV0L3Nj
aGVkL3NjaF9hcGkuYworKysgYi9uZXQvc2NoZWQvc2NoX2FwaS5jCkBAIC0xMTg3LDIzICsx
MTg3LDI5IEBAIHN0YXRpYyBpbnQgcWRpc2NfYmxvY2tfYWRkX2RldihzdHJ1Y3QgUWRpc2Mg
KnNjaCwgc3RydWN0IG5ldF9kZXZpY2UgKmRldiwKIAlzdHJ1Y3QgdGNmX2Jsb2NrICpibG9j
azsKIAlpbnQgZXJyOwogCi0JYmxvY2sgPSBjbF9vcHMtPnRjZl9ibG9jayhzY2gsIFRDX0hf
TUlOX0lOR1JFU1MsIE5VTEwpOwotCWlmIChibG9jaykgewotCQllcnIgPSB4YV9pbnNlcnQo
JmJsb2NrLT5wb3J0cywgZGV2LT5pZmluZGV4LCBkZXYsIEdGUF9LRVJORUwpOwotCQlpZiAo
ZXJyKSB7Ci0JCQlOTF9TRVRfRVJSX01TRyhleHRhY2ssCi0JCQkJICAgICAgICJpbmdyZXNz
IGJsb2NrIGRldiBpbnNlcnQgZmFpbGVkIik7Ci0JCQlyZXR1cm4gZXJyOworCWlmIChzY2gt
Pm9wcy0+aW5ncmVzc19ibG9ja19nZXQpIHsKKwkJYmxvY2sgPSBjbF9vcHMtPnRjZl9ibG9j
ayhzY2gsIFRDX0hfTUlOX0lOR1JFU1MsIE5VTEwpOworCQlpZiAoYmxvY2spIHsKKwkJCWVy
ciA9IHhhX2luc2VydCgmYmxvY2stPnBvcnRzLCBkZXYtPmlmaW5kZXgsIGRldiwKKwkJCQkJ
R0ZQX0tFUk5FTCk7CisJCQlpZiAoZXJyKSB7CisJCQkJTkxfU0VUX0VSUl9NU0coZXh0YWNr
LAorCQkJCQkgICAgICAgImluZ3Jlc3MgYmxvY2sgZGV2IGluc2VydCBmYWlsZWQiKTsKKwkJ
CQlyZXR1cm4gZXJyOworCQkJfQogCQl9CiAJfQogCi0JYmxvY2sgPSBjbF9vcHMtPnRjZl9i
bG9jayhzY2gsIFRDX0hfTUlOX0VHUkVTUywgTlVMTCk7Ci0JaWYgKGJsb2NrKSB7Ci0JCWVy
ciA9IHhhX2luc2VydCgmYmxvY2stPnBvcnRzLCBkZXYtPmlmaW5kZXgsIGRldiwgR0ZQX0tF
Uk5FTCk7Ci0JCWlmIChlcnIpIHsKLQkJCU5MX1NFVF9FUlJfTVNHKGV4dGFjaywKLQkJCQkg
ICAgICAgIkVncmVzcyBibG9jayBkZXYgaW5zZXJ0IGZhaWxlZCIpOwotCQkJZ290byBlcnJf
b3V0OworCWlmIChzY2gtPm9wcy0+ZWdyZXNzX2Jsb2NrX2dldCkgeworCQlibG9jayA9IGNs
X29wcy0+dGNmX2Jsb2NrKHNjaCwgVENfSF9NSU5fRUdSRVNTLCBOVUxMKTsKKwkJaWYgKGJs
b2NrKSB7CisJCQllcnIgPSB4YV9pbnNlcnQoJmJsb2NrLT5wb3J0cywgZGV2LT5pZmluZGV4
LCBkZXYsCisJCQkJCUdGUF9LRVJORUwpOworCQkJaWYgKGVycikgeworCQkJCU5MX1NFVF9F
UlJfTVNHKGV4dGFjaywKKwkJCQkJICAgICAgICJFZ3Jlc3MgYmxvY2sgZGV2IGluc2VydCBm
YWlsZWQiKTsKKwkJCQlnb3RvIGVycl9vdXQ7CisJCQl9CiAJCX0KIAl9CiAKLS0gCjIuMjUu
MQoK

--------------09loKEO8TzhvggEzUJHk0On0--

