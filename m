Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A207F206A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 23:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjKTWcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 17:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjKTWcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 17:32:17 -0500
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0E4CF;
        Mon, 20 Nov 2023 14:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1700519534; x=1732055534;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rDQlZ5oeaeLfue7DbNqiYyQWKb1Fe9Vhhje9JX7Eq+g=;
  b=MOXJB84cbgYxyNn+6oXM1qkjmlqGh3NDqirVjkwPlEfh0epRuFypnWZd
   s9budsKefoLt5iPaPN7Axbs/AvBwHfnPvjVeKkUDT5wP+twP2vtRCwN34
   LmRujsZK0HjAzwonYXpAFKS8nhh+vunzbdEyeaaoSdD7xa7kiATkMwSGB
   4=;
X-IronPort-AV: E=Sophos;i="6.04,214,1695686400"; 
   d="scan'208";a="167328892"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-f323d91c.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 22:32:12 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
        by email-inbound-relay-pdx-2b-m6i4x-f323d91c.us-west-2.amazon.com (Postfix) with ESMTPS id E2B5140D40;
        Mon, 20 Nov 2023 22:32:11 +0000 (UTC)
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:41508]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.48.37:2525] with esmtp (Farcaster)
 id 4a95383a-4603-4337-8fb7-0a86e23bc394; Mon, 20 Nov 2023 22:32:10 +0000 (UTC)
X-Farcaster-Flow-ID: 4a95383a-4603-4337-8fb7-0a86e23bc394
Received: from EX19D012UWC002.ant.amazon.com (10.13.138.165) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 20 Nov 2023 22:32:10 +0000
Received: from EX19D012UWC002.ant.amazon.com (10.13.138.165) by
 EX19D012UWC002.ant.amazon.com (10.13.138.165) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 20 Nov 2023 22:32:10 +0000
Received: from EX19D012UWC002.ant.amazon.com ([fe80::afb2:a509:3c85:23c6]) by
 EX19D012UWC002.ant.amazon.com ([fe80::afb2:a509:3c85:23c6%5]) with mapi id
 15.02.1118.039; Mon, 20 Nov 2023 22:32:10 +0000
From:   "Ashley, William" <wash@amazon.com>
To:     "Ashley, William" <wash@amazon.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: armv8pmu: Pending overflow interrupt is discarded when perf event
 is disabled
Thread-Topic: armv8pmu: Pending overflow interrupt is discarded when perf
 event is disabled
Thread-Index: AQHaG+B2preRGLMobEe2ogRfnSWcUrCDZnWA
Date:   Mon, 20 Nov 2023 22:32:10 +0000
Message-ID: <EBAF38AB-2BE5-425F-8A52-DDCB0B390309@amazon.com>
References: <950001BD-490C-4BAC-8EEA-CDB9F7C4ADFC@amazon.com>
In-Reply-To: <950001BD-490C-4BAC-8EEA-CDB9F7C4ADFC@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.106.239.31]
Content-Type: text/plain; charset="utf-8"
Content-ID: <70AE45BED0D9DF488927A8495E1F11EB@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkaW5nIGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZyBhbmQgbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZywNCnNvcnJ5IGZvciB0aGUgbm9pc2UuDQoNCg0K77u/T24gMTEv
MjAvMjMsIDEyOjM2IFBNLCAiQXNobGV5LCBXaWxsaWFtIiA8d2FzaEBhbWF6b24uY29tIDxtYWls
dG86d2FzaEBhbWF6b24uY29tPj4gd3JvdGU6DQoNCg0KQW4gaXNzdWUgWzFdIHdhcyBvcGVuZWQg
aW4gdGhlIHJyLWRlYnVnZ2VyIHByb2plY3QgcmVwb3J0aW5nIG9jY2FzaW9uYWwgbWlzc2VkDQpw
ZXJmIGV2ZW50IG92ZXJmbG93IHNpZ25hbHMgb24gYXJtNjQuIEkndmUgYmVlbiBkaWdnaW5nIGlu
dG8gdGhpcyBhbmQgdGhpbmsgSQ0KdW5kZXJzdGFuZCB3aGF0J3MgaGFwcGVuaW5nLCBidXQgd2Fu
dGVkIHRvIGNvbmZpcm0gbXkgdW5kZXJzdGFuZGluZy4NCg0KDQpUaGUgYXR0YWNoZWQgZXhhbXBs
ZSBhcHBsaWNhdGlvbiwgZGVyaXZlZCBmcm9tIGFuIHJyLWRlYnVnZ2VyIHRlc3QgY2FzZSwgcmVw
b3J0cw0Kd2hlbiB0aGUgdmFsdWUgb2YgYSBjb3VudGVyIGRvZXNuJ3QgaW5jcmVhc2UgYnkgdGhl
IGV4cGVjdGVkIHBlcmlvZCArLy0gc29tZQ0KdG9sZXJhbmNlLiBXaGVuIGl0IGlzIHBpbmctcG9u
Z2VkIGJldHdlZW4gY29yZXMgKGUuZy4gd2l0aCB0YXNrc2V0KSBhdCBhIGhpZ2gNCmZyZXF1ZW5j
eSwgaXQgZnJlcXVlbnRseSByZXBvcnRzIGluY3JlYXNlcyBvZiB+MnggdGhlIGV4cGVjdGVkLiBJ
J3ZlIGNvbmZpcm1lZA0KdGhpcyBzYW1lIGJlaGF2aW9yIG9uIGtlcm5lbHMgNS40LCA1LjEwLCA2
LjEgYW5kIDYuNS4NCg0KDQpJIGZvdW5kIGFybXY4cG11X2Rpc2FibGVfaW50ZW5zIFsyXSB0aGF0
IGlzIGNhbGxlZCBhcyBwYXJ0IG9mIGV2ZW50DQpkZS1zY2hlZHVsaW5nIGFuZCBjb250YWlucw0K
LyogQ2xlYXIgdGhlIG92ZXJmbG93IGZsYWcgaW4gY2FzZSBhbiBpbnRlcnJ1cHQgaXMgcGVuZGlu
Zy4gKi8NCndyaXRlX3Btb3ZzY2xyKG1hc2spOw0Kd2hpY2ggcmVzdWx0cyBpbiBhbnkgcGVuZGlu
ZyBvdmVyZmxvdyBpbnRlcnJ1cHQgYmVpbmcgZHJvcHBlZC4gSSBhZGRlZCBzb21lDQpkZWJ1ZyBv
dXRwdXQgaGVyZSBhbmQgaW5kZWVkIHRoZXJlIGlzIGEgY29ycmVsYXRpb24gb2YgdGhpcyBiaXQg
YmVpbmcgaGlnaCBhdA0KdGhlIHBvaW50IG9mIHRoZSBhYm92ZSBjb2RlIGFuZCB0aGUgcmVwcm9k
dWNlciBpZGVudGlmeWluZyBhIG1pc3NlZCBzaWduYWwuDQoNCg0KVGhpcyBiZWhhdmlvciBkb2Vz
IG5vdCBvY2N1ciB3aXRoIHBzZXVkby1OTUlzIChpcnFjaGlwLmdpY3YzX3BzZXVkb19ubWk9MSkN
CmVuYWJsZWQuDQoNCg0KV2hlbiBhbiBldmVudCBpcyBub3QgYmVpbmcgZXhwbGljaXRseSB0b3Ju
IGRvd24gKGUuZy4gYmVpbmcgY2xvc2VkKSwgdGhpcyBzZWVtcw0KbGlrZSBhbiB1bmRlc2lyYWJs
ZSBiZWhhdmlvci4gSSBoYXZlbid0IGF0dGVtcHRlZCB0byBkZW1vIGl0IHlldCwgYnV0IEkgc3Vz
cGVjdA0KYW4gYXBwbGljYXRpb24gZGlzYWJsaW5nIGFuIGV2ZW50IHRlbXBvcmFyaWx5IGNvdWxk
IG9jY2FzaW9uYWxseSBzZWUgdGhlIHNhbWUNCm1pc3NlZCBvdmVyZmxvdyBzaWduYWxzLiBJcyBt
eSB1bmRlcnN0YW5kaW5nIGhlcmUgY29ycmVjdD8gRG9lcyBhbnlvbmUgaGF2ZQ0KdGhvdWdodHMg
b24gaG93IHRoaXMgY291bGQgYmUgYWRkcmVzc2VkIHdpdGhvdXQgY3JlYXRpbmcgb3RoZXIgaXNz
dWVzPw0KDQoNClsxXSBodHRwczovL2dpdGh1Yi5jb20vcnItZGVidWdnZXIvcnIvaXNzdWVzLzM2
MDcgPGh0dHBzOi8vZ2l0aHViLmNvbS9yci1kZWJ1Z2dlci9yci9pc3N1ZXMvMzYwNz4NClsyXSBo
dHRwczovL2dpdGh1Yi5jb20vdG9ydmFsZHMvbGludXgvYmxvYi9jNDJkOWVlZWY4ZTViYTkyOTJl
ZGEzNmZkOGUzYzExZjM1ZWUwNjVjL2RyaXZlcnMvcGVyZi9hcm1fcG11djMuYyNMNjUyQzIwLUw2
NTJDNDMgPGh0dHBzOi8vZ2l0aHViLmNvbS90b3J2YWxkcy9saW51eC9ibG9iL2M0MmQ5ZWVlZjhl
NWJhOTI5MmVkYTM2ZmQ4ZTNjMTFmMzVlZTA2NWMvZHJpdmVycy9wZXJmL2FybV9wbXV2My5jI0w2
NTJDMjAtTDY1MkM0Mz4NCg0KDQoNCg0KDQoNCg0K
