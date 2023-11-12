Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364BB7E8F58
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 10:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjKLJeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 04:34:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKLJeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 04:34:00 -0500
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5922D51
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 01:33:57 -0800 (PST)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-280184b2741so3205236a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 01:33:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699781636; x=1700386436;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JSa3GcqvqKF7pvSJbic0yZpqaJa/32S7RhP/LfaTwNw=;
        b=MPVBqE35PC8JCWyAy0IKWqs3bpNDPQt6rHgtFpF14CAzacq7iJ3Nhld2gqFIfeNP0k
         QzJTAm4C76XgxABO6nbuQtTFtBVF8rIFnTGlUIXNcsQ0HtkVjijvNNXjoXq4dXgAJTt6
         Tq1bbsxH5n76/wpn8zkQShVke/rdHdlykCIbppADy/yLjnb7JlV9AqZqfPLwIaVPwPL4
         2fxedKSj1b111NBlgokV/7cwfiuPuFR9jZFI5cXNXEzW8jx75ZU5fXTS2ivKkPvyGCSd
         A9QZLq5JvssybtJb2fr74qHuEclJZGOHM5UbrevHtQzLc9PZTvRqbX7gVF8/0pWVW/nE
         fJJw==
X-Gm-Message-State: AOJu0Yy+JHigWW2XG9VQVu/nnRISXVtTJKPM+rB7NwukFznsrMocLlIu
        3CWEISFDbfPW95dOV3BYzLYMWTSqla7mdvfMGRdeu2A5yMs88XI=
X-Google-Smtp-Source: AGHT+IHL1V6cIIXF5c90HSA6ufv4XU77S0Cn5eFVYMW+Oy7L9BFduLCleePmSf0kCRFG8nHvarRuSOGlr5Ig5yvBN/tlHkG8FyNa
MIME-Version: 1.0
X-Received: by 2002:a17:90a:f0d7:b0:27d:81dd:b83a with SMTP id
 fa23-20020a17090af0d700b0027d81ddb83amr1110750pjb.4.1699781636654; Sun, 12
 Nov 2023 01:33:56 -0800 (PST)
Date:   Sun, 12 Nov 2023 01:33:56 -0800
In-Reply-To: <000000000000f5ce160602f29dd6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a60a8a0609f14025@google.com>
Subject: Re: [syzbot] Re: [syzbot] [btrfs?] memory leak in btrfs_ref_tree_mod
From:   syzbot <syzbot+d66de4cbf532749df35f@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rm9yIGFyY2hpdmFsIHB1cnBvc2VzLCBmb3J3YXJkaW5nIGFuIGluY29taW5nIGNvbW1hbmQgZW1h
aWwgdG8KbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZy4KCioqKgoKU3ViamVjdDogUmU6IFtz
eXpib3RdIFtidHJmcz9dIG1lbW9yeSBsZWFrIGluIGJ0cmZzX3JlZl90cmVlX21vZApBdXRob3I6
IGJyYWdhdGhlbWFuaWNrMDkwOEBnbWFpbC5jb20KCg0KT24gMTIvMTEvMjMgMTQ6NTMsIHN5emJv
dCB3cm90ZToNCj4gSGVsbG8sDQo+DQo+IHN5emJvdCB0cmllZCB0byB0ZXN0IHRoZSBwcm9wb3Nl
ZCBwYXRjaCBidXQgdGhlIGJ1aWxkL2Jvb3QgZmFpbGVkOg0KPg0KPiBmYWlsZWQgdG8gYXBwbHkg
cGF0Y2g6DQo+IGNoZWNraW5nIGZpbGUgZnMvYnRyZnMvcmVmLXZlcmlmeS5jDQo+IEh1bmsgIzEg
RkFJTEVEIGF0IDc5MS4NCj4gSHVuayAjMiBGQUlMRUQgYXQgODAwLg0KPiAyIG91dCBvZiAyIGh1
bmtzIEZBSUxFRA0KPg0KPg0KPg0KPiBUZXN0ZWQgb246DQo+DQo+IGNvbW1pdDogICAgICAgICAx
YjkwN2QwNSBNZXJnZSB0YWcgJzYuNy1yYy1zbWIzLWNsaWVudC1maXhlcy1wYXJ0Micgb2YuLg0K
PiBnaXQgdHJlZTogICAgICAgdXBzdHJlYW0NCj4ga2VybmVsIGNvbmZpZzogIGh0dHBzOi8vc3l6
a2FsbGVyLmFwcHNwb3QuY29tL3gvLmNvbmZpZz94PTJiZjg5NjJlNGY3OTg0ZjQNCj4gZGFzaGJv
YXJkIGxpbms6IGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL2J1Zz9leHRpZD1kNjZkZTRj
YmY1MzI3NDlkZjM1Zg0KPiBjb21waWxlcjoNCj4gcGF0Y2g6ICAgICAgICAgIGh0dHBzOi8vc3l6
a2FsbGVyLmFwcHNwb3QuY29tL3gvcGF0Y2guZGlmZj94PTE2ODQ1ZmUwZTgwMDAwDQo+DQojc3l6
IHRlc3QNCg0KLS0tIGEvZnMvYnRyZnMvcmVmLXZlcmlmeS5jDQorKysgYi9mcy9idHJmcy9yZWYt
dmVyaWZ5LmMNCkBAIC03OTEsNiArNzkxLDcgQEAgaW50IGJ0cmZzX3JlZl90cmVlX21vZChzdHJ1
Y3QgYnRyZnNfZnNfaW5mbyAqZnNfaW5mbywNCiDCoMKgwqDCoCDCoMKgwqAgwqDCoMKgIGR1bXBf
cmVmX2FjdGlvbihmc19pbmZvLCByYSk7DQogwqDCoMKgwqAgwqDCoMKgIMKgwqDCoCBrZnJlZShy
ZWYpOw0KIMKgwqDCoMKgIMKgwqDCoCDCoMKgwqAga2ZyZWUocmEpOw0KK8KgwqDCoCDCoMKgwqAg
wqDCoMKgIGtmcmVlKHJlKTsNCiDCoMKgwqDCoCDCoMKgwqAgwqDCoMKgIGdvdG8gb3V0X3VubG9j
azsNCiDCoMKgwqDCoCDCoMKgwqAgfSBlbHNlIGlmIChiZS0+bnVtX3JlZnMgPT0gMCkgew0KIMKg
wqDCoMKgIMKgwqDCoCDCoMKgwqAgYnRyZnNfZXJyKGZzX2luZm8sDQpAQCAtODAwLDYgKzgwMSw3
IEBAIGludCBidHJmc19yZWZfdHJlZV9tb2Qoc3RydWN0IGJ0cmZzX2ZzX2luZm8gKmZzX2luZm8s
DQogwqDCoMKgwqAgwqDCoMKgIMKgwqDCoCBkdW1wX3JlZl9hY3Rpb24oZnNfaW5mbywgcmEpOw0K
IMKgwqDCoMKgIMKgwqDCoCDCoMKgwqAga2ZyZWUocmVmKTsNCiDCoMKgwqDCoCDCoMKgwqAgwqDC
oMKgIGtmcmVlKHJhKTsNCivCoMKgwqAgwqDCoMKgIMKgwqDCoCBrZnJlZShyZSk7DQogwqDCoMKg
wqAgwqDCoMKgIMKgwqDCoCBnb3RvIG91dF91bmxvY2s7DQogwqDCoMKgwqAgwqDCoMKgIH0NCg0K
QEAgLTgyMiw2ICs4MjQsNyBAQCBpbnQgYnRyZnNfcmVmX3RyZWVfbW9kKHN0cnVjdCBidHJmc19m
c19pbmZvICpmc19pbmZvLA0KIMKgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIGR1bXBfcmVm
X2FjdGlvbihmc19pbmZvLCByYSk7DQogwqDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAga2Zy
ZWUocmVmKTsNCiDCoMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCBrZnJlZShyYSk7DQorwqDC
oMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIGtmcmVlKHJlKTsNCiDCoMKgwqDCoCDCoMKgwqAgwqDC
oMKgIMKgwqDCoCBnb3RvIG91dF91bmxvY2s7DQogwqDCoMKgwqAgwqDCoMKgIMKgwqDCoCB9DQog
wqDCoMKgwqAgwqDCoMKgIMKgwqDCoCBleGlzdC0+bnVtX3JlZnMtLTsNCkBAIC04MzgsNiArODQx
LDcgQEAgaW50IGJ0cmZzX3JlZl90cmVlX21vZChzdHJ1Y3QgYnRyZnNfZnNfaW5mbyAqZnNfaW5m
bywNCiDCoMKgwqDCoCDCoMKgwqAgwqDCoMKgIGR1bXBfcmVmX2FjdGlvbihmc19pbmZvLCByYSk7
DQogwqDCoMKgwqAgwqDCoMKgIMKgwqDCoCBrZnJlZShyZWYpOw0KIMKgwqDCoMKgIMKgwqDCoCDC
oMKgwqAga2ZyZWUocmEpOw0KK8KgwqDCoCDCoMKgwqAgwqDCoMKgIGtmcmVlKHJlKTsNCiDCoMKg
wqDCoCDCoMKgwqAgwqDCoMKgIGdvdG8gb3V0X3VubG9jazsNCiDCoMKgwqDCoCDCoMKgwqAgfQ0K
IMKgwqDCoMKgIMKgwqDCoCBrZnJlZShyZWYpOw0KQEAgLTg0OSw2ICs4NTMsNyBAQCBpbnQgYnRy
ZnNfcmVmX3RyZWVfbW9kKHN0cnVjdCBidHJmc19mc19pbmZvICpmc19pbmZvLA0KIMKgwqDCoMKg
IMKgwqDCoCDCoMKgwqAgZHVtcF9yZWZfYWN0aW9uKGZzX2luZm8sIHJhKTsNCiDCoMKgwqDCoCDC
oMKgwqAgwqDCoMKgIGtmcmVlKHJlZik7DQogwqDCoMKgwqAgwqDCoMKgIMKgwqDCoCBrZnJlZShy
YSk7DQorwqDCoMKgIMKgwqDCoCDCoMKgwqAga2ZyZWUocmUpOw0KIMKgwqDCoMKgIMKgwqDCoCDC
oMKgwqAgZ290byBvdXRfdW5sb2NrOw0KIMKgwqDCoMKgIMKgwqDCoCB9DQogwqDCoMKgwqAgfQ0K
QEAgLTg4MSw2ICs4ODYsOCBAQCBpbnQgYnRyZnNfcmVmX3RyZWVfbW9kKHN0cnVjdCBidHJmc19m
c19pbmZvICpmc19pbmZvLA0KIMKgwqDCoMKgIH0NCiDCoMKgwqDCoCBsaXN0X2FkZF90YWlsKCZy
YS0+bGlzdCwgJmJlLT5hY3Rpb25zKTsNCiDCoMKgwqDCoCByZXQgPSAwOw0KK8KgwqDCoCBrZnJl
ZShyYSk7DQorwqDCoMKgIGtmcmVlKHJlKTsNCiDCoG91dF91bmxvY2s6DQogwqDCoMKgwqAgc3Bp
bl91bmxvY2soJmZzX2luZm8tPnJlZl92ZXJpZnlfbG9jayk7DQogwqBvdXQ6DQoNCg==
