Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 086FC80B36D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 10:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjLIJXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 04:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjLIJXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 04:23:06 -0500
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D361A1;
        Sat,  9 Dec 2023 01:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702113792; x=1733649792;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lpm2Ec+ZtdRX2kOQhYV7jvujbxIe5cPFY0JvY5kUk9c=;
  b=Lgp4zW9vPqnWu+5BgIrNkexul6HCw3nsFWnHsU4/F+1GH8WnLYuP1Ue6
   FJVbF9P1wPl8IogmL1Aih+DGe0a3e8h868rIjebeCVhIBSmcYoI8BBbtn
   3H87a3Ob/yoAmprw5lNVo3g4QF58nRLhC7eKbHqrIxpbm9xm6jNPQP7L4
   0=;
X-IronPort-AV: E=Sophos;i="6.04,262,1695686400"; 
   d="scan'208";a="620750035"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-a65ebc6e.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2023 09:23:10 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
        by email-inbound-relay-iad-1e-m6i4x-a65ebc6e.us-east-1.amazon.com (Postfix) with ESMTPS id 08E546967A;
        Sat,  9 Dec 2023 09:23:08 +0000 (UTC)
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:36158]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.194:2525] with esmtp (Farcaster)
 id 40036f68-c748-404a-9e97-d8ad31b4c886; Sat, 9 Dec 2023 09:23:08 +0000 (UTC)
X-Farcaster-Flow-ID: 40036f68-c748-404a-9e97-d8ad31b4c886
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 9 Dec 2023 09:23:08 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sat, 9 Dec
 2023 09:23:06 +0000
Message-ID: <b32fe3b6-9123-4c20-864b-5282c8dea567@amazon.com>
Date:   Sat, 9 Dec 2023 10:23:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] initramfs: Expose retained initrd as sysfs file
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC:     Linux Documentation <linux-doc@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Jan_H=2E_Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        James Gowans <jgowans@amazon.com>
References: <20231207235654.16622-1-graf@amazon.com>
 <ZXPkL1jyXwGH11gJ@archie.me>
From:   Alexander Graf <graf@amazon.com>
In-Reply-To: <ZXPkL1jyXwGH11gJ@archie.me>
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D033UWA002.ant.amazon.com (10.13.139.10) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ck9uIDA5LjEyLjIzIDA0OjUxLCBCYWdhcyBTYW5qYXlhIHdyb3RlOgo+IE9uIFRodSwgRGVjIDA3
LCAyMDIzIGF0IDExOjU2OjU0UE0gKzAwMDAsIEFsZXhhbmRlciBHcmFmIHdyb3RlOgo+PiBXaGVu
IHRoZSBrZXJuZWwgY29tbWFuZCBsaW5lIG9wdGlvbiAicmV0YWluX2luaXRyZCIgaXMgc2V0LCB3
ZSBkbyBub3QKPj4gZnJlZSB0aGUgaW5pdHJkIG1lbW9yeS4gSG93ZXZlciwgd2UgYWxzbyBkb24n
dCBleHBvc2UgaXQgdG8gYW55b25lIGZvcgo+PiBjb25zdW1wdGlvbi4gVGhhdCBsZWF2ZXMgdXMg
aW4gYSB3ZWlyZCBzaXR1YXRpb24gd2hlcmUgdGhlIG9ubHkgdXNlciBvZgo+PiB0aGlzIGZlYXR1
cmUgaXMgcHBjNjQgYW5kIGFybTY0IHNwZWNpZmljIGtleGVjIHRvb2xpbmcuCj4+Cj4+IFRvIG1h
a2UgaXQgbW9yZSBnZW5lcmFsbHkgdXNlZnVsLCB0aGlzIHBhdGNoIGFkZHMgYSBrb2JqZWN0IHRv
IHRoZQo+PiBmaXJtd2FyZSBvYmplY3QgdGhhdCBjb250YWlucyB0aGUgaW5pdHJkIGNvbnRleHQg
d2hlbiAicmV0YWluX2luaXRyZCIKPj4gaXMgc2V0LiBUaGF0IHdheSwgd2UgY2FuIGFjY2VzcyB0
aGUgaW5pdHJkIGFueSB0aW1lIGFmdGVyIGJvb3QgZnJvbQo+PiB1c2VyIHNwYWNlIGFuZCBmb3Ig
ZXhhbXBsZSBoYW5kIGl0IGludG8ga2V4ZWMgYXMgLS1pbml0cmQgcGFyYW1ldGVyCj4+IGlmIHdl
IHdhbnQgdG8gcmVib290IHRoZSBzYW1lIGluaXRyZC4gT3IgaW5zcGVjdCBpdCBkaXJlY3RseSBs
b2NhbGx5Lgo+Pgo+PiBXaXRoIHRoaXMgcGF0Y2ggYXBwbGllZCwgdGhlcmUgaXMgYSBuZXcgL3N5
cy9maXJtd2FyZS9pbml0cmQgZmlsZSB3aGVuCj4+IHRoZSBrZXJuZWwgd2FzIGJvb3RlZCB3aXRo
IGFuIGluaXRyZCBhbmQgInJldGFpbl9pbml0cmQiIGNvbW1hbmQgbGluZQo+PiBvcHRpb24gaXMg
c2V0Lgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBBbGV4YW5kZXIgR3JhZiA8Z3JhZkBhbWF6b24uY29t
Pgo+PiBUZXN0ZWQtYnk6IEJhZ2FzIFNhbmpheWEgPGJhZ2FzZG90bWVAZ21haWwuY29tPgo+Pgo+
PiAtLS0KPj4KPj4gdjEgLT4gdjI6Cj4+Cj4+ICAgIC0gUmV3b3JkIGNvbW1pdCBtZXNzYWdlIHRv
IGV4cGxhaW4gdGhlIG5ldyBmaWxlIHBhdGgKPj4gICAgLSBBZGQgYSBEb2N1bWVudGF0aW9uL0FC
SS90ZXN0aW5nL3N5c2ZzLWZpcm13YXJlLWluaXRyZCBmaWxlCj4+Cj4+IHYyIC0+IHYzOgo+Pgo+
PiAgICAtIE9ubHkgZXhwb3NlIGZpbGUgd2hlbiBpbml0cmQgaXMgcHJlc2VudCAoSmFtZXMgR293
YW5zKQo+PiAtLS0KPj4gICAuLi4vQUJJL3Rlc3Rpbmcvc3lzZnMtZmlybXdhcmUtaW5pdHJkICAg
ICAgICAgIHwgIDggKysrKysrKysKPj4gICAuLi4vYWRtaW4tZ3VpZGUva2VybmVsLXBhcmFtZXRl
cnMudHh0ICAgICAgICAgIHwgIDUgKysrLS0KPj4gICBpbml0L2luaXRyYW1mcy5jICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHwgMTggKysrKysrKysrKysrKysrKystCj4+ICAgMyBmaWxl
cyBjaGFuZ2VkLCAyOCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+PiAgIGNyZWF0ZSBt
b2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL0FCSS90ZXN0aW5nL3N5c2ZzLWZpcm13YXJlLWluaXRy
ZAo+Pgo+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9BQkkvdGVzdGluZy9zeXNmcy1maXJt
d2FyZS1pbml0cmQgYi9Eb2N1bWVudGF0aW9uL0FCSS90ZXN0aW5nL3N5c2ZzLWZpcm13YXJlLWlu
aXRyZAo+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NAo+PiBpbmRleCAwMDAwMDAwMDAwMDAuLjIwYmY3
Y2Y3N2ExOQo+PiAtLS0gL2Rldi9udWxsCj4+ICsrKyBiL0RvY3VtZW50YXRpb24vQUJJL3Rlc3Rp
bmcvc3lzZnMtZmlybXdhcmUtaW5pdHJkCj4+IEBAIC0wLDAgKzEsOCBAQAo+PiArV2hhdDoJCS9z
eXMvZmlybXdhcmUvaW5pdHJkCj4+ICtEYXRlOgkJRGVjZW1iZXIgMjAyMwo+PiArQ29udGFjdDoJ
QWxleGFuZGVyIEdyYWYgPGdyYWZAYW1hem9uLmNvbT4KPj4gK0Rlc2NyaXB0aW9uOgo+PiArCQlX
aGVuIHRoZSBrZXJuZWwgd2FzIGJvb3RlZCB3aXRoIGFuIGluaXRyZCBhbmQgdGhlCj4+ICsJCSJy
ZXRhaW5faW5pdHJkIiBvcHRpb24gaXMgc2V0IG9uIHRoZSBrZXJuZWwgY29tbWFuZAo+PiArCQls
aW5lLCAvc3lzL2Zpcm13YXJlL2luaXRyZCBjb250YWlucyB0aGUgY29udGVudHMgb2YgdGhlCj4+
ICsJCWluaXRyZCB0aGF0IHRoZSBrZXJuZWwgd2FzIGJvb3RlZCB3aXRoLgo+PiBkaWZmIC0tZ2l0
IGEvRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9rZXJuZWwtcGFyYW1ldGVycy50eHQgYi9Eb2N1
bWVudGF0aW9uL2FkbWluLWd1aWRlL2tlcm5lbC1wYXJhbWV0ZXJzLnR4dAo+PiBpbmRleCA2NTcz
MWIwNjBlM2YuLjUxNTc1Y2QzMTc0MSAxMDA2NDQKPj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9hZG1p
bi1ndWlkZS9rZXJuZWwtcGFyYW1ldGVycy50eHQKPj4gKysrIGIvRG9jdW1lbnRhdGlvbi9hZG1p
bi1ndWlkZS9rZXJuZWwtcGFyYW1ldGVycy50eHQKPj4gQEAgLTI0MzgsNyArMjQzOCw3IEBACj4+
ICAgCQkJYmV0d2VlbiB1bnJlZ2lzdGVyaW5nIHRoZSBib290IGNvbnNvbGUgYW5kIGluaXRpYWxp
emluZwo+PiAgIAkJCXRoZSByZWFsIGNvbnNvbGUuCj4+ICAgCj4+IC0Ja2VlcGluaXRyZAlbSFcs
QVJNXQo+PiArCWtlZXBpbml0cmQJW0hXLEFSTV0gU2VlIHJldGFpbl9pbml0cmQuCj4+ICAgCj4+
ICAgCWtlcm5lbGNvcmU9CVtLTkwsWDg2LElBLTY0LFBQQ10KPj4gICAJCQlGb3JtYXQ6IG5uW0tN
R1RQRV0gfCBubiUgfCAibWlycm9yIgo+PiBAQCAtNTU4MCw3ICs1NTgwLDggQEAKPj4gICAJCQlV
c2VmdWwgZm9yIGRldmljZXMgdGhhdCBhcmUgZGV0ZWN0ZWQgYXN5bmNocm9ub3VzbHkKPj4gICAJ
CQkoZS5nLiBVU0IgYW5kIE1NQyBkZXZpY2VzKS4KPj4gICAKPj4gLQlyZXRhaW5faW5pdHJkCVtS
QU1dIEtlZXAgaW5pdHJkIG1lbW9yeSBhZnRlciBleHRyYWN0aW9uCj4+ICsJcmV0YWluX2luaXRy
ZAlbUkFNXSBLZWVwIGluaXRyZCBtZW1vcnkgYWZ0ZXIgZXh0cmFjdGlvbi4gQWZ0ZXIgYm9vdCwg
aXQgd2lsbAo+PiArCQkJYmUgYWNjZXNzaWJsZSB2aWEgL3N5cy9maXJtd2FyZS9pbml0cmQuCj4+
ICAgCj4+ICAgCXJldGJsZWVkPQlbWDg2XSBDb250cm9sIG1pdGlnYXRpb24gb2YgUkVUQmxlZWQg
KEFyYml0cmFyeQo+PiAgIAkJCVNwZWN1bGF0aXZlIENvZGUgRXhlY3V0aW9uIHdpdGggUmV0dXJu
IEluc3RydWN0aW9ucykKPiBZb3UgbWF5IHdhbnQgdG8gYWRqdXN0IGRvY3VtZW50YXRpb24gdG8g
YWRkcmVzcyBteSB0ZXN0aW5nIFsxXS4gSW4gc3VtbWFyeSwKPiBvbmx5IHRoZSBmaXJzdCBpbml0
cmQgYmxvYiB0aGF0IHdhcyBwYXNzZWQgdG8gdGhlIGtlcm5lbCB3aWxsIGJlIGV4cG9zZWQKPiBp
biAvc3lzL2Zpcm13YXJlL2luaXRyZC4KCgogRnJvbSB0aGUga2VybmVsJ3MgcG9pbnQgb2Ygdmll
dywgdGhlcmUgaXMgb25seSBhIHNpbmdsZSBpbml0cmQgYmluYXJ5IAo6KS4gV2hldGhlciB5b3Vy
IGJvb3QgbG9hZGVyIGNvbmNhdGVuYXRlcyBtdWx0aXBsZSBhcmNoaXZlcyB0byBjcmVhdGUgCnRo
YXQgc2luZ2xlIG9uZSBvdXQgb2YgbXVsdGlwbGUgaW5kaXZpZHVhbCBmaWxlcyBpcyBhIGJvb3Qg
bG9hZGVyIAppbXBsZW1lbnRhdGlvbiBkZXRhaWwuCgpBbGV4CgoKCgoKQW1hem9uIERldmVsb3Bt
ZW50IENlbnRlciBHZXJtYW55IEdtYkgKS3JhdXNlbnN0ci4gMzgKMTAxMTcgQmVybGluCkdlc2No
YWVmdHNmdWVocnVuZzogQ2hyaXN0aWFuIFNjaGxhZWdlciwgSm9uYXRoYW4gV2Vpc3MKRWluZ2V0
cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hhcmxvdHRlbmJ1cmcgdW50ZXIgSFJCIDE0OTE3MyBCClNp
dHo6IEJlcmxpbgpVc3QtSUQ6IERFIDI4OSAyMzcgODc5CgoK

