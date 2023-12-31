Return-Path: <linux-kernel+bounces-13713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E57820B88
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 15:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB0B6281CBC
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 14:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C8463A4;
	Sun, 31 Dec 2023 14:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="KRqWpjQ+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C755390
	for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 14:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-204a16df055so3866690fac.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 06:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1704033519; x=1704638319; darn=vger.kernel.org;
        h=in-reply-to:from:references:to:content-language:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S3jlfX/acsXRbE1jQGJiF+EZ7saJnyUNQwYGkrWyxSE=;
        b=KRqWpjQ+q0YWsvhcx7rT9clnlk9Rqx5kFmk9jrIy4l+Iv73dh+aQeaQtlosEa8ff8Q
         h07A7HMUwq3CkMs6+TFmka1zcO2ksNKEGQxFIOUPTFjqE6umPX3i0S/xAj/s0NiNEyEa
         4Il530JlxG/kfY6CIMK0LPKCeDSDNH+aWuLT813PRTZR0XfYxmInU3gjBCQvkCueQR6r
         r8FkYWoye1MgDgHoQlnUmWIoWKCFr7thJMR40PskwgjWhfDvpL7EwQth/y5y+RzyvBLa
         wBsonpI7ClVsHyIUeSRnAB9j9laktPQoAPIajtJ4+63t6Dn8fw/PhFEt313UGm8Wu45K
         Um2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704033519; x=1704638319;
        h=in-reply-to:from:references:to:content-language:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S3jlfX/acsXRbE1jQGJiF+EZ7saJnyUNQwYGkrWyxSE=;
        b=CUGDXYop1QSdu37+/ADeHQw9TAlswDwSa7EORHUiLt3+sl2+MMpVU+2KxMs9e1lI20
         3jQ1EmFbynIsth3p/TFk9XAALsLprUu3fcSxP3BeiQSFxRbTd+t9/5jTB4vfHhbubX39
         v+qyf0z2fDBsZlW9gPnWw64KY0s0VS6sPyzC7cb+dLgbF9s/0uLmY1zr1bzHW1+KkImK
         VEviSn14uZrPa2se7Sx+AROw1QRP3IBikTBSd3B9XIPyq/HrOmCqtrMhRGff/8Gc90VF
         THVNppaJFHmArgbkFRvUFNamR1RHM+eHJn5AROoUGzyB8SnImKxqy4Act5LQqXFQ8W/B
         L+0Q==
X-Gm-Message-State: AOJu0YwpMMtbGRFOXSJoxXt8+fWlF6QBmE1E/cS90aq8muhziP7kd/UC
	qaukGhMRbj1c36wZJ5YPWl3Ws8TfbVx84I7XVzMEEhAZ0w==
X-Google-Smtp-Source: AGHT+IGkQI6QFAES3yF+uanwJaEOmyL4aTmFIl6kwcl6mgPc86a+v0UsJKGg2jWU6RALp7xst8FYuA==
X-Received: by 2002:a05:6358:5e06:b0:174:f1b3:a29c with SMTP id q6-20020a0563585e0600b00174f1b3a29cmr10792362rwn.4.1704033519213;
        Sun, 31 Dec 2023 06:38:39 -0800 (PST)
Received: from ?IPV6:2804:7f1:e2c0:aba3:7663:8830:3d6b:aa9f? ([2804:7f1:e2c0:aba3:7663:8830:3d6b:aa9f])
        by smtp.gmail.com with ESMTPSA id sm18-20020a17090b2e5200b002868abc0e6dsm23728840pjb.11.2023.12.31.06.38.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Dec 2023 06:38:38 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------DZCjMqNSLymT7pgbPgIO0S5l"
Message-ID: <1882b96d-0625-4702-b496-161b387d089f@mojatatu.com>
Date: Sun, 31 Dec 2023 11:38:35 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [net?] general protection fault in htb_tcf_block
Content-Language: en-US
To: syzbot <syzbot+806b0572c8d06b66b234@syzkaller.appspotmail.com>,
 davem@davemloft.net, edumazet@google.com, jhs@mojatatu.com,
 jiri@resnulli.us, kuba@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, pctammela@mojatatu.com,
 syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
References: <00000000000082f2f2060dcc3a92@google.com>
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <00000000000082f2f2060dcc3a92@google.com>

This is a multi-part message in MIME format.
--------------DZCjMqNSLymT7pgbPgIO0S5l
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/12/2023 08:04, syzbot wrote:
> HEAD commit:    c2b2ee36250d bridge: cfm: fix enum typo in br_cc_ccm_tx_pa..
> git tree:       net-next
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1041287ee80000

#syz test
--------------DZCjMqNSLymT7pgbPgIO0S5l
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

--------------DZCjMqNSLymT7pgbPgIO0S5l--

