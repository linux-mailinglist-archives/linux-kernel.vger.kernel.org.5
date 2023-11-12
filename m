Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857307E8F77
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 11:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjKLKQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 05:16:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKLKQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 05:16:49 -0500
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89072D5B
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 02:16:46 -0800 (PST)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-27ffe79ec25so3199015a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 02:16:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699784206; x=1700389006;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=szfYGuq6xLkwMb4SwvSEBi6GZzm4ffU+BRqEBByqr/c=;
        b=t0O4anP9rMInViSKhRLz8FPGjSHiBwQZbHhGKKNYXEleQGadmAyuqML5SVkyiP8jOE
         IDocRLGEw1NQRCpxjAzTuIrH0/YXWUjnewluyoRFVfOI/TYfC3P2b66/Kq7oy8wpMd9W
         VCebQGVKADLBg1tyeBVKKBzCOFdbNUBlAatu0DaoJzOsNsQBQ/bcIUB+U+/GieiAiTRr
         VlQ3HxIRvOChcSCOxSgN+E0Rkauat1vQuXZsg7eKJdtJl2rs4LIH7Fi0dzJRptHmTW3s
         hVtRBUh/18S4ZKeSith2w7QSelonUBHHQl0nw1j+CbyVQ+CncYrc90uk4KfPwEtxQDwi
         lwXA==
X-Gm-Message-State: AOJu0YwKdoMS5Gy/rGX9+IkPYVvWVDvJRUcY1LIh7llx3qJKmrDv1Rsb
        bWRvmkripZyIO8dqGdaqYdPLvf7WTv05GDUgZzavZAcg9NpBGaQ=
X-Google-Smtp-Source: AGHT+IETiCAAZgRiYSLTpm8P4U3iwb/zgf//JPwvX5gzIw8Fkh8VGXuFZVh6gIXQlsVbUbcbOVbF9zVKbI/V7vPsL8B2U3cewJj3
MIME-Version: 1.0
X-Received: by 2002:a17:90b:2dcc:b0:280:2f43:1f32 with SMTP id
 sk12-20020a17090b2dcc00b002802f431f32mr1135879pjb.2.1699784206560; Sun, 12
 Nov 2023 02:16:46 -0800 (PST)
Date:   Sun, 12 Nov 2023 02:16:46 -0800
In-Reply-To: <000000000000f5ce160602f29dd6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d3b4b30609f1d94d@google.com>
Subject: Re: [syzbot] Re: [syzbot] [btrfs?] memory leak in btrfs_ref_tree_mod
From:   syzbot <syzbot+d66de4cbf532749df35f@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rm9yIGFyY2hpdmFsIHB1cnBvc2VzLCBmb3J3YXJkaW5nIGFuIGluY29taW5nIGNvbW1hbmQgZW1h
aWwgdG8KbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZy4KCioqKgoKU3ViamVjdDogUmU6IFtz
eXpib3RdIFtidHJmcz9dIG1lbW9yeSBsZWFrIGluIGJ0cmZzX3JlZl90cmVlX21vZApBdXRob3I6
IGJyYWdhdGhlbWFuaWNrMDkwOEBnbWFpbC5jb20KCiNzeXogdGVzdCANCmh0dHBzOi8vZ2l0Lmtl
cm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdCANCjI1
YWEwYmViYmE3Mg0KDQotLS0gYS9mcy9idHJmcy9yZWYtdmVyaWZ5LmMNCisrKyBiL2ZzL2J0cmZz
L3JlZi12ZXJpZnkuYw0KQEAgLTc5MSw2ICs3OTEsNyBAQCBpbnQgYnRyZnNfcmVmX3RyZWVfbW9k
KHN0cnVjdCBidHJmc19mc19pbmZvICpmc19pbmZvLA0KIMKgwqDCoMKgIMKgwqDCoCDCoMKgwqAg
ZHVtcF9yZWZfYWN0aW9uKGZzX2luZm8sIHJhKTsNCiDCoMKgwqDCoCDCoMKgwqAgwqDCoMKgIGtm
cmVlKHJlZik7DQogwqDCoMKgwqAgwqDCoMKgIMKgwqDCoCBrZnJlZShyYSk7DQorwqDCoMKgIMKg
wqDCoCDCoMKgwqAga2ZyZWUocmUpOw0KIMKgwqDCoMKgIMKgwqDCoCDCoMKgwqAgZ290byBvdXRf
dW5sb2NrOw0KIMKgwqDCoMKgIMKgwqDCoCB9IGVsc2UgaWYgKGJlLT5udW1fcmVmcyA9PSAwKSB7
DQogwqDCoMKgwqAgwqDCoMKgIMKgwqDCoCBidHJmc19lcnIoZnNfaW5mbywNCkBAIC04MDAsNiAr
ODAxLDcgQEAgaW50IGJ0cmZzX3JlZl90cmVlX21vZChzdHJ1Y3QgYnRyZnNfZnNfaW5mbyAqZnNf
aW5mbywNCiDCoMKgwqDCoCDCoMKgwqAgwqDCoMKgIGR1bXBfcmVmX2FjdGlvbihmc19pbmZvLCBy
YSk7DQogwqDCoMKgwqAgwqDCoMKgIMKgwqDCoCBrZnJlZShyZWYpOw0KIMKgwqDCoMKgIMKgwqDC
oCDCoMKgwqAga2ZyZWUocmEpOw0KK8KgwqDCoCDCoMKgwqAgwqDCoMKgIGtmcmVlKHJlKTsNCiDC
oMKgwqDCoCDCoMKgwqAgwqDCoMKgIGdvdG8gb3V0X3VubG9jazsNCiDCoMKgwqDCoCDCoMKgwqAg
fQ0KQEAgLTgyMiw2ICs4MjQsNyBAQCBpbnQgYnRyZnNfcmVmX3RyZWVfbW9kKHN0cnVjdCBidHJm
c19mc19pbmZvICpmc19pbmZvLA0KIMKgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIGR1bXBf
cmVmX2FjdGlvbihmc19pbmZvLCByYSk7DQogwqDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAg
a2ZyZWUocmVmKTsNCiDCoMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCBrZnJlZShyYSk7DQor
wqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIGtmcmVlKHJlKTsNCiDCoMKgwqDCoCDCoMKgwqAg
wqDCoMKgIMKgwqDCoCBnb3RvIG91dF91bmxvY2s7DQogwqDCoMKgwqAgwqDCoMKgIMKgwqDCoCB9
DQogwqDCoMKgwqAgwqDCoMKgIMKgwqDCoCBleGlzdC0+bnVtX3JlZnMtLTsNCkBAIC04MzgsNiAr
ODQxLDcgQEAgaW50IGJ0cmZzX3JlZl90cmVlX21vZChzdHJ1Y3QgYnRyZnNfZnNfaW5mbyAqZnNf
aW5mbywNCiDCoMKgwqDCoCDCoMKgwqAgwqDCoMKgIGR1bXBfcmVmX2FjdGlvbihmc19pbmZvLCBy
YSk7DQogwqDCoMKgwqAgwqDCoMKgIMKgwqDCoCBrZnJlZShyZWYpOw0KIMKgwqDCoMKgIMKgwqDC
oCDCoMKgwqAga2ZyZWUocmEpOw0KK8KgwqDCoCDCoMKgwqAgwqDCoMKgIGtmcmVlKHJlKTsNCiDC
oMKgwqDCoCDCoMKgwqAgwqDCoMKgIGdvdG8gb3V0X3VubG9jazsNCiDCoMKgwqDCoCDCoMKgwqAg
fQ0KIMKgwqDCoMKgIMKgwqDCoCBrZnJlZShyZWYpOw0KQEAgLTg0OSw2ICs4NTMsNyBAQCBpbnQg
YnRyZnNfcmVmX3RyZWVfbW9kKHN0cnVjdCBidHJmc19mc19pbmZvICpmc19pbmZvLA0KIMKgwqDC
oMKgIMKgwqDCoCDCoMKgwqAgZHVtcF9yZWZfYWN0aW9uKGZzX2luZm8sIHJhKTsNCiDCoMKgwqDC
oCDCoMKgwqAgwqDCoMKgIGtmcmVlKHJlZik7DQogwqDCoMKgwqAgwqDCoMKgIMKgwqDCoCBrZnJl
ZShyYSk7DQorwqDCoMKgIMKgwqDCoCDCoMKgwqAga2ZyZWUocmUpOw0KIMKgwqDCoMKgIMKgwqDC
oCDCoMKgwqAgZ290byBvdXRfdW5sb2NrOw0KIMKgwqDCoMKgIMKgwqDCoCB9DQogwqDCoMKgwqAg
fQ0KQEAgLTg4MSw2ICs4ODYsOCBAQCBpbnQgYnRyZnNfcmVmX3RyZWVfbW9kKHN0cnVjdCBidHJm
c19mc19pbmZvICpmc19pbmZvLA0KIMKgwqDCoMKgIH0NCiDCoMKgwqDCoCBsaXN0X2FkZF90YWls
KCZyYS0+bGlzdCwgJmJlLT5hY3Rpb25zKTsNCiDCoMKgwqDCoCByZXQgPSAwOw0KK8KgwqDCoCBr
ZnJlZShyYSk7DQorwqDCoMKgIGtmcmVlKHJlKTsNCiDCoG91dF91bmxvY2s6DQogwqDCoMKgwqAg
c3Bpbl91bmxvY2soJmZzX2luZm8tPnJlZl92ZXJpZnlfbG9jayk7DQogwqBvdXQ6DQoNCg==
