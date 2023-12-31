Return-Path: <linux-kernel+bounces-13711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 585C7820B7D
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 15:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A14F1C2138C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 14:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728D15390;
	Sun, 31 Dec 2023 14:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="GdPi/rcN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FA86111
	for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 14:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5ce6b5e3c4eso405273a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 06:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1704031827; x=1704636627; darn=vger.kernel.org;
        h=in-reply-to:from:references:to:content-language:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l2P8UJoxBQv0z0II8XtzeG8pYJ+EsqqcSqS8meWeRzI=;
        b=GdPi/rcNlhTL3UcRTd39Fa6R1fNdiPcYQUPIRBVcpE2rXyvcRv5fm4TCzYK7htVUh5
         yqZZRG8Qd0WJfx9Lzm/+p3b5U3WNkpw6oeCpgmM4SI0HZ6SmKxFLUEUIkrqELXudgTU8
         F68s0DM6KMAY6hGjbszgexdFCmsp8d3ycju4VASN09a37T3UmB3bkgmWdOrvas7R2Hwq
         ocpL2/6bw7Tk6a8/ukCp8TsYuMrr2NbXOdKSLf9i/A5Y/O/Qq2n2jUvNpjzBis4Cg80n
         jjB0cpurShtw+gUn02qpZs04x7+JHwI/VuRBhLvbyjCmGiPsthHCjaNS+47TmEOUEaXo
         Au2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704031827; x=1704636627;
        h=in-reply-to:from:references:to:content-language:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l2P8UJoxBQv0z0II8XtzeG8pYJ+EsqqcSqS8meWeRzI=;
        b=qo0CmmckdHRZXrl+4V+M4M2Cu8DIKsYau59pMBDDoXTrb8qFTnJcQE+XNee9+I/zwz
         OmnxTxsydOzblt479Yf/+NoAs5Ps/fZtLPz7nQFH4Fkzfbyd8q/WW6X7XnYSFx77h5HJ
         WLXpwoOxMC0OvCeRFAyTXcHR7v7e31F3kiywpUqJD1b8d7M4pfo1u/u+/Vu8AF3gyLSE
         9hpUnegNkyi1PvYR9GH2NPbUFp+0zZXXOCuGzMr1fgp35OWsPfmePjP1yHAWISnMdJyO
         FCczf4W8m9eFCuEDTEq1bvjEyMFU97XG4f6um9G5xNwiaV5WTz5nb+1hcemrVo3KRibK
         PplQ==
X-Gm-Message-State: AOJu0YwJvTalWhpRJzlPa5j4+HulJG10XgRvjiBoG06Pp5fEN5SJ4vRD
	enqtTPpw4TF70iGhcGTBGc5uA15LUbeq
X-Google-Smtp-Source: AGHT+IGmciecIxAsDwnBp+IrNvVwJ9Q+rs9NQPKL6Ki0bd6gGqUQvaO1ndNkfJdgnjXsycNjg0gilg==
X-Received: by 2002:a05:6a00:3a05:b0:6da:73b4:1c20 with SMTP id fj5-20020a056a003a0500b006da73b41c20mr384121pfb.29.1704031827521;
        Sun, 31 Dec 2023 06:10:27 -0800 (PST)
Received: from ?IPV6:2804:7f1:e2c0:aba3:7663:8830:3d6b:aa9f? ([2804:7f1:e2c0:aba3:7663:8830:3d6b:aa9f])
        by smtp.gmail.com with ESMTPSA id a1-20020a624d01000000b006d974d47a8csm18485013pfb.115.2023.12.31.06.10.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Dec 2023 06:10:27 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------uW7Kf7C5l765pwsBWEPcP16I"
Message-ID: <675e418f-ef2f-4bb7-9fde-337171aea92e@mojatatu.com>
Date: Sun, 31 Dec 2023 11:10:23 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [net?] general protection fault in qdisc_create
Content-Language: en-US
To: syzbot <syzbot+84339b9e7330daae4d66@syzkaller.appspotmail.com>,
 davem@davemloft.net, edumazet@google.com, jhs@mojatatu.com,
 jiri@resnulli.us, kuba@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, pctammela@mojatatu.com,
 syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
References: <0000000000007c85f5060dcc3a28@google.com>
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <0000000000007c85f5060dcc3a28@google.com>

This is a multi-part message in MIME format.
--------------uW7Kf7C5l765pwsBWEPcP16I
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/12/2023 08:04, syzbot wrote:
> HEAD commit:    c2b2ee36250d bridge: cfm: fix enum typo in br_cc_ccm_tx_pa..
> git tree:       net-next
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15fed8f6e80000

#syz test
--------------uW7Kf7C5l765pwsBWEPcP16I
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

--------------uW7Kf7C5l765pwsBWEPcP16I--

