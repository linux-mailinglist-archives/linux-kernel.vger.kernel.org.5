Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4EE6800378
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 07:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377485AbjLAGAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 01:00:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjLAGAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 01:00:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DC21703
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 22:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701410410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c5UCSvcRKtd6d2j+BMVs/9VlfhZGRPUwVUQBSZyn2JA=;
        b=h89/9ypn+tqpelQK6Ah1mGU1Pcrr2ZQo/nVFu7VGZI5Tf3aMmA1N2NE5bxSl4+pqAy3Dox
        1w/yW8WyrvpzFOGuelcieEaKzA69onPjXC1M7SfDCaifOoZT6cJDtuCAWWEGlWEuT/QT/n
        FKxut0sA7X+T78zKG8tsLlMDSQ7yHZA=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-ux07uRhNMsiPXZJHIQy7zQ-1; Fri, 01 Dec 2023 01:00:08 -0500
X-MC-Unique: ux07uRhNMsiPXZJHIQy7zQ-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5c6072bc218so207618a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 22:00:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701410407; x=1702015207;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c5UCSvcRKtd6d2j+BMVs/9VlfhZGRPUwVUQBSZyn2JA=;
        b=n+cOM3rpoX6u72pFNFAQ2SBOWBTlPboa9mi9VU4MDqGn5Ci8gJqHIeDT1cvf/Dwnje
         mju8MDvUswoGfADfnk3WZhv/qeVDKHu9Ms8Mo6L+h5xo+VvgmSKoSMpM+cfUb23PSS4v
         eFOu9mw0RRRj/9H3jn9fHSlyK02Q12L6n25OF2E99WhrYOlOSDKL0pLrTK3cSvlMbCeY
         Gd9pV2/61A7L+rysO2Geuo15ZTgcgbB0ZNrDMfLQLpPpYkt3ZmWBV+KCyhPr6T2nGJLS
         erHcmK2ZoS8Fd23XcBOg8p2YMiRnXzqhifXU60L1bOnBbFr5vwEtbWD3x9Lblfp5fhxv
         Mh/g==
X-Gm-Message-State: AOJu0YzYmJ8DGXkPqgy4uzqL48Gb19v2QsHJLiPnpL4sjc2aASuZisCJ
        38N1Q5pz3tcX06xtJcbyahUt2K15Rgr38iTJtsTVWXE5jkj9ju3B8O/31PAuvmKxVVXH9DxhI5x
        4I2fi8x+JHI6o7sUHTLpJEQ/z
X-Received: by 2002:a17:90a:1656:b0:286:49cb:ef22 with SMTP id x22-20020a17090a165600b0028649cbef22mr3583844pje.24.1701410407249;
        Thu, 30 Nov 2023 22:00:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFL0i6C+nvuHJfXZFwprm/4fHEbJS8k0eoF9pHdZq0wQukG9xOm1Bqg4VmjooU3zZwm9Y4lw==
X-Received: by 2002:a17:90a:1656:b0:286:49cb:ef22 with SMTP id x22-20020a17090a165600b0028649cbef22mr3583751pje.24.1701410405567;
        Thu, 30 Nov 2023 22:00:05 -0800 (PST)
Received: from localhost ([240d:1a:c0d:9f00:3342:3fe3:7275:954])
        by smtp.gmail.com with ESMTPSA id z8-20020a17090ab10800b002865028e17csm1039533pjq.9.2023.11.30.22.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 22:00:05 -0800 (PST)
Date:   Fri, 01 Dec 2023 15:00:01 +0900 (JST)
Message-Id: <20231201.150001.994919262711540315.syoshida@redhat.com>
To:     edumazet@google.com
Cc:     willemdebruijn.kernel@gmail.com, pabeni@redhat.com,
        davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ipv4: ip_gre: Handle skb_pull() failure in
 ipgre_xmit()
From:   Shigeru Yoshida <syoshida@redhat.com>
In-Reply-To: <CANn89i+u6tFJQKESV9DH-HypezVV7Ux+XhnyFGLd833PR9Qpyw@mail.gmail.com>
References: <CANn89iLxEZAjomWEW4GFJds6kyd6Zf+ed9kx6eVsaQ57De6gMw@mail.gmail.com>
        <20231130.230329.2023533070545022513.syoshida@redhat.com>
        <CANn89i+u6tFJQKESV9DH-HypezVV7Ux+XhnyFGLd833PR9Qpyw@mail.gmail.com>
X-Mailer: Mew version 6.9 on Emacs 29.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBUaHUsIDMwIE5vdiAyMDIzIDE1OjA1OjM4ICswMTAwLCBFcmljIER1bWF6ZXQgd3JvdGU6
DQo+IE9uIFRodSwgTm92IDMwLCAyMDIzIGF0IDM6MDPigK9QTSBTaGlnZXJ1IFlvc2hpZGEgPHN5
b3NoaWRhQHJlZGhhdC5jb20+IHdyb3RlOg0KPj4NCj4+IE9uIFdlZCwgMjkgTm92IDIwMjMgMTA6
NTY6NDcgKzAxMDAsIEVyaWMgRHVtYXpldCB3cm90ZToNCj4+ID4gT24gV2VkLCBOb3YgMjksIDIw
MjMgYXQgMjo1MeKAr0FNIFNoaWdlcnUgWW9zaGlkYSA8c3lvc2hpZGFAcmVkaGF0LmNvbT4gd3Jv
dGU6DQo+PiA+Pg0KPj4gPj4gT24gTW9uLCAyNyBOb3YgMjAyMyAxMDo1NTowMSAtMDUwMCwgV2ls
bGVtIGRlIEJydWlqbiB3cm90ZToNCj4+ID4+ID4gU2hpZ2VydSBZb3NoaWRhIHdyb3RlOg0KPj4g
Pj4gPj4gSW4gaXBncmVfeG1pdCgpLCBza2JfcHVsbCgpIG1heSBmYWlsIGV2ZW4gaWYgcHNrYl9p
bmV0X21heV9wdWxsKCkgcmV0dXJucw0KPj4gPj4gPj4gdHJ1ZS4gRm9yIGV4YW1wbGUsIGFwcGxp
Y2F0aW9ucyBjYW4gY3JlYXRlIGEgbWFsZm9ybWVkIHBhY2tldCB0aGF0IGNhdXNlcw0KPj4gPj4g
Pj4gdGhpcyBwcm9ibGVtIHdpdGggUEZfUEFDS0VULg0KPj4gPj4gPg0KPj4gPj4gPiBJdCBtYXkg
ZmFpbCBiZWNhdXNlIGJlY2F1c2UgcHNrYl9pbmV0X21heV9wdWxsIGRvZXMgbm90IGFjY291bnQg
Zm9yDQo+PiA+PiA+IHR1bm5lbC0+aGxlbi4NCj4+ID4+ID4NCj4+ID4+ID4gSXMgdGhhdCB3aGF0
IHlvdSBhcmUgcmVmZXJyaW5nIHRvIHdpdGggbWFsZm9ybWVkIHBhY2tldD8gQ2FuIHlvdQ0KPj4g
Pj4gPiBlbG9ib3JhdGUgYSBiaXQgb24gaW4gd2hpY2ggd2F5IHRoZSBwYWNrZXQgaGFzIHRvIGJl
IG1hbGZvcm1lZCB0bw0KPj4gPj4gPiByZWFjaCB0aGlzPw0KPj4gPj4NCj4+ID4+IFRoYW5rIHlv
dSB2ZXJ5IG11Y2ggZm9yIHlvdXIgcHJvbXB0IGZlZWRiYWNrLg0KPj4gPj4NCj4+ID4+IEFjdHVh
bGx5LCBJIGZvdW5kIHRoaXMgcHJvYmxlbSBieSBydW5uaW5nIHN5emthbGxlci4gU3l6a2FsbGVy
DQo+PiA+PiByZXBvcnRlZCB0aGUgZm9sbG93aW5nIHVuaW5pdC12YWx1ZSBpc3N1ZSAoSSB0aGlu
ayB0aGUgcm9vdCBjYXVzZSBvZg0KPj4gPj4gdGhpcyBpc3N1ZSBpcyB0aGUgc2FtZSBhcyB0aGUg
b25lIEVyaWMgbWVudGlvbmVkKToNCj4+ID4NCj4+ID4gWWVzLCBJIGFsc28gaGF2ZSBhIHNpbWls
YXIgc3l6Ym90IHJlcG9ydCAoYnV0IG5vIHJlcHJvIHlldCkgSSBhbQ0KPj4gPiByZWxlYXNpbmcg
aXQgcmlnaHQgbm93Lg0KPj4gPg0KPj4gPj4NCj4+ID4+ID09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+PiA+PiBCVUc6IEtNU0FOOiB1bmluaXQt
dmFsdWUgaW4gX19ncmVfeG1pdCBuZXQvaXB2NC9pcF9ncmUuYzo0NjkgW2lubGluZV0NCj4+ID4+
IEJVRzogS01TQU46IHVuaW5pdC12YWx1ZSBpbiBpcGdyZV94bWl0KzB4ZGY0LzB4ZTcwIG5ldC9p
cHY0L2lwX2dyZS5jOjY2Mg0KPj4gPj4gIF9fZ3JlX3htaXQgbmV0L2lwdjQvaXBfZ3JlLmM6NDY5
IFtpbmxpbmVdDQo+PiA+Pg0KPj4gPg0KPj4gPg0KPj4gPg0KPj4gPj4gVGhlIHNpbXBsaWZpZWQg
dmVyc2lvbiBvZiB0aGUgcmVwcm8gaXMgc2hvd24gYmVsb3c6DQo+PiA+Pg0KPj4gPj4gI2luY2x1
ZGUgPGxpbnV4L2lmX2V0aGVyLmg+DQo+PiA+PiAjaW5jbHVkZSA8c3lzL2lvY3RsLmg+DQo+PiA+
PiAjaW5jbHVkZSA8bmV0aW5ldC9ldGhlci5oPg0KPj4gPj4gI2luY2x1ZGUgPG5ldC9pZi5oPg0K
Pj4gPj4gI2luY2x1ZGUgPHN5cy9zb2NrZXQuaD4NCj4+ID4+ICNpbmNsdWRlIDxuZXRpbmV0L2lu
Lmg+DQo+PiA+PiAjaW5jbHVkZSA8c3RyaW5nLmg+DQo+PiA+PiAjaW5jbHVkZSA8dW5pc3RkLmg+
DQo+PiA+PiAjaW5jbHVkZSA8c3RkaW8uaD4NCj4+ID4+ICNpbmNsdWRlIDxzdGRsaWIuaD4NCj4+
ID4+ICNpbmNsdWRlIDxsaW51eC9pZl9wYWNrZXQuaD4NCj4+ID4+DQo+PiA+PiBpbnQgbWFpbih2
b2lkKQ0KPj4gPj4gew0KPj4gPj4gICAgICAgICBpbnQgcywgczEsIHMyLCBkYXRhID0gMDsNCj4+
ID4+ICAgICAgICAgc3RydWN0IGlmcmVxIGlmcjsNCj4+ID4+ICAgICAgICAgc3RydWN0IHNvY2th
ZGRyX2xsIGFkZHIgPSB7IDAgfTsNCj4+ID4+ICAgICAgICAgdW5zaWduZWQgY2hhciBtYWNfYWRk
cltdID0gezB4MSwgMHgyLCAweDMsIDB4NCwgMHg1LCAweDZ9Ow0KPj4gPj4NCj4+ID4+ICAgICAg
ICAgcyA9IHNvY2tldChBRl9QQUNLRVQsIFNPQ0tfREdSQU0sIDB4MzAwKTsNCj4+ID4+ICAgICAg
ICAgczEgPSBzb2NrZXQoQUZfUEFDS0VULCBTT0NLX1JBVywgMHgzMDApOw0KPj4gPj4gICAgICAg
ICBzMiA9IHNvY2tldChBRl9ORVRMSU5LLCBTT0NLX1JBVywgMCk7DQo+PiA+Pg0KPj4gPj4gICAg
ICAgICBzdHJjcHkoaWZyLmlmcl9uYW1lLCAiZ3JlMCIpOw0KPj4gPj4gICAgICAgICBpb2N0bChz
MiwgU0lPQ0dJRklOREVYLCAmaWZyKTsNCj4+ID4+DQo+PiA+PiAgICAgICAgIGFkZHIuc2xsX2Zh
bWlseSA9IEFGX1BBQ0tFVDsNCj4+ID4+ICAgICAgICAgYWRkci5zbGxfaWZpbmRleCA9IGlmci5p
ZnJfaWZpbmRleDsNCj4+ID4+ICAgICAgICAgYWRkci5zbGxfcHJvdG9jb2wgPSBodG9ucygwKTsN
Cj4+ID4+ICAgICAgICAgYWRkci5zbGxfaGF0eXBlID0gQVJQSFJEX0VUSEVSOw0KPj4gPj4gICAg
ICAgICBhZGRyLnNsbF9wa3R0eXBlID0gUEFDS0VUX0hPU1Q7DQo+PiA+PiAgICAgICAgIGFkZHIu
c2xsX2hhbGVuID0gRVRIX0FMRU47DQo+PiA+PiAgICAgICAgIG1lbWNweShhZGRyLnNsbF9hZGRy
LCBtYWNfYWRkciwgRVRIX0FMRU4pOw0KPj4gPj4NCj4+ID4+ICAgICAgICAgc2VuZHRvKHMxLCAm
ZGF0YSwgMSwgMCwgKHN0cnVjdCBzb2NrYWRkciAqKSZhZGRyLCBzaXplb2YoYWRkcikpOw0KPj4g
Pj4NCj4+ID4+ICAgICAgICAgcmV0dXJuIDA7DQo+PiA+PiB9DQo+PiA+Pg0KPj4gPj4gVGhlIHJl
cHJvIHNlbmRzIGEgMS1ieXRlIHBhY2tldCB0aGF0IGRvZXNuJ3QgaGF2ZSB0aGUgY29ycmVjdCBJ
UA0KPj4gPj4gaGVhZGVyLiBJIG1lYW50IHRoaXMgYXMgIm1hbGZvcm1lZCBwYWNoZXQiLCBidXQg
dGhhdCBtaWdodCBiZSBhIGJpdA0KPj4gPj4gY29uZnVzaW5nLCBzb3JyeS4NCj4+ID4+DQo+PiA+
PiBJIHRoaW5rIHRoZSBjYXVzZSBvZiB0aGUgdW5pbml0LXZhbHVlIGFjY2VzcyBpcyB0aGF0IGlw
Z3JlX3htaXQoKQ0KPj4gPj4gcmVhbGxvY2F0ZXMgdGhlIHNrYiB3aXRoIHNrYl9jb3dfaGVhZCgp
IGFuZCBjb3BpZXMgb25seSB0aGUgMS1ieXRlDQo+PiA+PiBkYXRhLCBzbyBhbnkgSVAgaGVhZGVy
IGFjY2VzcyB0aHJvdWdoIGB0bmxfcGFyYW1zYCBjYW4gY2F1c2UgdGhlDQo+PiA+PiBwcm9ibGVt
Lg0KPj4gPj4NCj4+ID4+IEF0IGZpcnN0IEkgdHJpZWQgdG8gbW9kaWZ5IHBza2JfaW5ldF9tYXlf
cHVsbCgpIHRvIGRldGVjdCB0aGlzIHR5cGUgb2YNCj4+ID4+IHBhY2tldCwgYnV0IEkgZW5kZWQg
dXAgZG9pbmcgdGhpcyBwYXRjaC4NCj4+ID4NCj4+ID4gRXZlbiBhZnRlciB5b3VyIHBhdGNoLCBf
X3NrYl9wdWxsKCkgY291bGQgY2FsbCBCVUcoKSBhbmQgY3Jhc2guDQo+PiA+DQo+PiA+IEkgd291
bGQgc3VnZ2VzdCB1c2luZyB0aGlzIGZpeCBpbnN0ZWFkLg0KPj4NCj4+IFRoYW5rIHlvdSBmb3Ig
eW91ciBjb21tZW50Lg0KPj4NCj4+IFlvdXIgcGF0Y2ggZW5zdXJlcyB0aGF0IHNrYl9wdWxsKCkg
Y2FuIHB1bGwgdGhlIHJlcXVpcmVkIHNpemUsIHNvIGl0DQo+PiBsb29rcyBnb29kIHRvIG1lLiBB
bHNvLCBJIGhhdmUgdGVzdGVkIHlvdXIgc3VnZ2VzdGVkIHBhdGNoIHdpdGggdGhlDQo+PiByZXBy
byBhbmQgY29uZmlybWVkIHRoYXQgaXQgZml4ZXMgdGhlIGlzc3VlLg0KPj4NCj4gDQo+IFRoaXMg
aXMgZ3JlYXQsIHBsZWFzZSBjb29rL3NlbmQgYSBWMiB3aXRoIHRoaXMgdXBkYXRlZCBwYXRjaC4N
Cj4gDQo+IEkgd2lsbCBhZGQgYSAnUmV2aWV3ZWQtYnk6IEVyaWMgRHVtYXpldCA8ZWR1bWF6ZXRA
Z29vZ2xlLmNvbT4nIHRoZW4uDQoNClRoYW5rcywgRXJpYyEgSSdsbCBzZW5kIGEgdjIgcGF0Y2gg
c29vbi4NCg0KU2hpZ2VydQ0KDQo+IA0KPiBUaGFua3MuDQo+IA0K

