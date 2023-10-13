Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440807C84B9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 13:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbjJMLnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 07:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbjJMLnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 07:43:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66064BD
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 04:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697197396; x=1728733396;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=cjQSuHkESKDK2+Dz14D9uSHBfQx2LBLIX5g/nIepDKI=;
  b=QCRC5ouxSvDWXGZBcRGmv1rRu0ifCDAw+Hv23USJ72WI7yODCQFFiTs0
   LOpNAy+o+aTbjxTbKJwyTTgT1QflxADA6bhn4hHcb6bW/zO719xnYRuK3
   jP6gIBIfI4vKCYEE1RhljXd3GeBah5QaPaCRXJPCu7959f3MRSBToD/Qf
   i+3gj5pJevv3Qwng1Q4DohEXToYaVOJOmHXOWNw7Z+FT+MXMR+hgolmYV
   DqsOsG/XdLr1W3vrXKwrAQskDDc3ML9lmd+LZbkaV5ADPSDRcEn3SF9N3
   sw0iJJwKZiFCHQ4YT0UNRCMWxYOo0giYWyxWfq0XNbmQQa7WUqjaOdBSU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="375511978"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="375511978"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 04:43:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="784127858"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="784127858"
Received: from dstacken-mobl1.ger.corp.intel.com (HELO [10.249.254.172]) ([10.249.254.172])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 04:43:12 -0700
Message-ID: <6876d2cddd0a32bb77f2bc5ef206f06107cef8e3.camel@linux.intel.com>
Subject: Re: [PATCH drm-misc-next v6 2/6] drm/gpuvm: add drm_gpuvm_flags to
 drm_gpuvm
From:   Thomas =?ISO-8859-1?Q?Hellstr=F6m?= 
        <thomas.hellstrom@linux.intel.com>
To:     Danilo Krummrich <dakr@redhat.com>, airlied@gmail.com,
        daniel@ffwll.ch, matthew.brost@intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, boris.brezillon@collabora.com,
        christian.koenig@amd.com, faith@gfxstrand.net
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 13 Oct 2023 13:43:09 +0200
In-Reply-To: <20231008233212.13815-3-dakr@redhat.com>
References: <20231008233212.13815-1-dakr@redhat.com>
         <20231008233212.13815-3-dakr@redhat.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_FILL_THIS_FORM_SHORT autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTEwLTA5IGF0IDAxOjMyICswMjAwLCBEYW5pbG8gS3J1bW1yaWNoIHdyb3Rl
Ogo+IEludHJvZHVjZSBmbGFncyBmb3Igc3RydWN0IGRybV9ncHV2bSwgdGhpcyByZXF1aXJlZCBi
eSBzdWJzZXF1ZW50Cj4gY29tbWl0cy4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBEYW5pbG8gS3J1bW1y
aWNoIDxkYWtyQHJlZGhhdC5jb20+Cj4gLS0tCj4gwqBkcml2ZXJzL2dwdS9kcm0vZHJtX2dwdXZt
LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCA0ICsrKy0KPiDCoGRyaXZlcnMvZ3B1L2RybS9u
b3V2ZWF1L25vdXZlYXVfdXZtbS5jIHzCoCAyICstCj4gwqBpbmNsdWRlL2RybS9kcm1fZ3B1dm0u
aMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDE3ICsrKysrKysrKysrKysrKystCj4g
wqAzIGZpbGVzIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4gCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9kcm1fZ3B1dm0uYwo+IGIvZHJpdmVycy9ncHUv
ZHJtL2RybV9ncHV2bS5jCj4gaW5kZXggZWJkYTlkNTk0MTY1Li42MzY4ZGZkYmU5ZGQgMTAwNjQ0
Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2RybV9ncHV2bS5jCj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2RybV9ncHV2bS5jCj4gQEAgLTcwMyw2ICs3MDMsNyBAQCBFWFBPUlRfU1lNQk9MX0dQTChk
cm1fZ3B1dm1fcm9vdF9vYmplY3RfYWxsb2MpOwo+IMKgICogQGdwdXZtOiBwb2ludGVyIHRvIHRo
ZSAmZHJtX2dwdXZtIHRvIGluaXRpYWxpemUKPiDCoCAqIEByX29iajogdGhlIHJvb3QgJmRybV9n
ZW1fb2JqZWN0IHByb3ZpZGluZyB0aGUgR1BVVk0ncyBjb21tb24KPiAmZG1hX3Jlc3YKPiDCoCAq
IEBuYW1lOiB0aGUgbmFtZSBvZiB0aGUgR1BVIFZBIHNwYWNlCj4gKyAqIEBmbGFnczogdGhlICZk
cm1fZ3B1dm1fZmxhZ3MgZm9yIHRoaXMgR1BVVk0KCk5JVDogSXQgbG9va3MgbGlrZSBrZXJuZWxk
b2MgZ3VpZGVsaW5lcyByZWNvbW1lbmRzIHVzaW5nICZlbnVtCmRybV9ncHV2bV9mbGFncyBpbiBu
ZXcgIGNvZGUKCj4gwqAgKiBAc3RhcnRfb2Zmc2V0OiB0aGUgc3RhcnQgb2Zmc2V0IG9mIHRoZSBH
UFUgVkEgc3BhY2UKPiDCoCAqIEByYW5nZTogdGhlIHNpemUgb2YgdGhlIEdQVSBWQSBzcGFjZQo+
IMKgICogQHJlc2VydmVfb2Zmc2V0OiB0aGUgc3RhcnQgb2YgdGhlIGtlcm5lbCByZXNlcnZlZCBH
UFUgVkEgYXJlYQo+IEBAIC03MTYsNyArNzE3LDcgQEAgRVhQT1JUX1NZTUJPTF9HUEwoZHJtX2dw
dXZtX3Jvb3Rfb2JqZWN0X2FsbG9jKTsKPiDCoCAqLwo+IMKgdm9pZAo+IMKgZHJtX2dwdXZtX2lu
aXQoc3RydWN0IGRybV9ncHV2bSAqZ3B1dm0sIHN0cnVjdCBkcm1fZ2VtX29iamVjdAo+ICpyX29i
aiwKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29uc3QgY2hhciAqbmFtZSwKPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29uc3QgY2hhciAqbmFtZSwgZW51bSBkcm1fZ3B1dm1f
ZmxhZ3MgZmxhZ3MsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1NjQgc3RhcnRfb2Zm
c2V0LCB1NjQgcmFuZ2UsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1NjQgcmVzZXJ2
ZV9vZmZzZXQsIHU2NCByZXNlcnZlX3JhbmdlLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgY29uc3Qgc3RydWN0IGRybV9ncHV2bV9vcHMgKm9wcykKPiBAQCAtNzI5LDYgKzczMCw3IEBA
IGRybV9ncHV2bV9pbml0KHN0cnVjdCBkcm1fZ3B1dm0gKmdwdXZtLCBzdHJ1Y3QKPiBkcm1fZ2Vt
X29iamVjdCAqcl9vYmosCj4gwqDCoMKgwqDCoMKgwqDCoGdwdXZtLT5tbV9yYW5nZSA9IHJhbmdl
Owo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoGdwdXZtLT5uYW1lID0gbmFtZSA/IG5hbWUgOiAidW5r
bm93biI7Cj4gK8KgwqDCoMKgwqDCoMKgZ3B1dm0tPmZsYWdzID0gZmxhZ3M7Cj4gwqDCoMKgwqDC
oMKgwqDCoGdwdXZtLT5vcHMgPSBvcHM7Cj4gwqDCoMKgwqDCoMKgwqDCoGdwdXZtLT5yX29iaiA9
IHJfb2JqOwo+IMKgCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9ub3V2ZWF1L25vdXZl
YXVfdXZtbS5jCj4gYi9kcml2ZXJzL2dwdS9kcm0vbm91dmVhdS9ub3V2ZWF1X3V2bW0uYwo+IGlu
ZGV4IDRkZWE4NDdlZjk4OS4uOTNhZDJiYTdlYzhiIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9ub3V2ZWF1L25vdXZlYXVfdXZtbS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL25vdXZl
YXUvbm91dmVhdV91dm1tLmMKPiBAQCAtMTg0Myw3ICsxODQzLDcgQEAgbm91dmVhdV91dm1tX2lu
aXQoc3RydWN0IG5vdXZlYXVfdXZtbSAqdXZtbSwKPiBzdHJ1Y3Qgbm91dmVhdV9jbGkgKmNsaSwK
PiDCoMKgwqDCoMKgwqDCoMKgdXZtbS0+a2VybmVsX21hbmFnZWRfYWRkciA9IGtlcm5lbF9tYW5h
Z2VkX2FkZHI7Cj4gwqDCoMKgwqDCoMKgwqDCoHV2bW0tPmtlcm5lbF9tYW5hZ2VkX3NpemUgPSBr
ZXJuZWxfbWFuYWdlZF9zaXplOwo+IMKgCj4gLcKgwqDCoMKgwqDCoMKgZHJtX2dwdXZtX2luaXQo
JnV2bW0tPmJhc2UsIHJfb2JqLCBjbGktPm5hbWUsCj4gK8KgwqDCoMKgwqDCoMKgZHJtX2dwdXZt
X2luaXQoJnV2bW0tPmJhc2UsIHJfb2JqLCBjbGktPm5hbWUsIDAsCj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgTk9VVkVBVV9WQV9TUEFDRV9TVEFSVCwKPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBOT1VWRUFVX1ZBX1NQ
QUNFX0VORCwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBr
ZXJuZWxfbWFuYWdlZF9hZGRyLCBrZXJuZWxfbWFuYWdlZF9zaXplLAo+IGRpZmYgLS1naXQgYS9p
bmNsdWRlL2RybS9kcm1fZ3B1dm0uaCBiL2luY2x1ZGUvZHJtL2RybV9ncHV2bS5oCj4gaW5kZXgg
MGFlYzE0ZDhiMjU5Li4xMzUzOWYzMmMyZTIgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS9kcm0vZHJt
X2dwdXZtLmgKPiArKysgYi9pbmNsdWRlL2RybS9kcm1fZ3B1dm0uaAo+IEBAIC0xODMsNiArMTgz
LDE2IEBAIHN0YXRpYyBpbmxpbmUgYm9vbCBkcm1fZ3B1dmFfaW52YWxpZGF0ZWQoc3RydWN0Cj4g
ZHJtX2dwdXZhICp2YSkKPiDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIHZhLT5mbGFncyAmIERSTV9H
UFVWQV9JTlZBTElEQVRFRDsKPiDCoH0KPiDCoAo+ICsvKioKPiArICogZW51bSBkcm1fZ3B1dm1f
ZmxhZ3MgLSBmbGFncyBmb3Igc3RydWN0IGRybV9ncHV2bQo+ICsgKi8KPiArZW51bSBkcm1fZ3B1
dm1fZmxhZ3Mgewo+ICvCoMKgwqDCoMKgwqDCoC8qKgo+ICvCoMKgwqDCoMKgwqDCoCAqIEBEUk1f
R1BVVk1fVVNFUkJJVFM6IHVzZXIgZGVmaW5lZCBiaXRzCj4gK8KgwqDCoMKgwqDCoMKgICovCj4g
K8KgwqDCoMKgwqDCoMKgRFJNX0dQVVZNX1VTRVJCSVRTID0gKDEgPDwgMCksCgpCSVQoMCkKCj4g
K307Cj4gKwo+IMKgLyoqCj4gwqAgKiBzdHJ1Y3QgZHJtX2dwdXZtIC0gRFJNIEdQVSBWQSBNYW5h
Z2VyCj4gwqAgKgo+IEBAIC0yMDEsNiArMjExLDExIEBAIHN0cnVjdCBkcm1fZ3B1dm0gewo+IMKg
wqDCoMKgwqDCoMKgwqAgKi8KPiDCoMKgwqDCoMKgwqDCoMKgY29uc3QgY2hhciAqbmFtZTsKPiDC
oAo+ICvCoMKgwqDCoMKgwqDCoC8qKgo+ICvCoMKgwqDCoMKgwqDCoCAqIEBmbGFnczogdGhlICZk
cm1fZ3B1dm1fZmxhZ3Mgb2YgdGhpcyBHUFVWTQplbnVtPwo+ICvCoMKgwqDCoMKgwqDCoCAqLwo+
ICvCoMKgwqDCoMKgwqDCoGVudW0gZHJtX2dwdXZtX2ZsYWdzIGZsYWdzOwo+ICsKPiDCoMKgwqDC
oMKgwqDCoMKgLyoqCj4gwqDCoMKgwqDCoMKgwqDCoCAqIEBtbV9zdGFydDogc3RhcnQgb2YgdGhl
IFZBIHNwYWNlCj4gwqDCoMKgwqDCoMKgwqDCoCAqLwo+IEBAIC0yNDYsNyArMjYxLDcgQEAgc3Ry
dWN0IGRybV9ncHV2bSB7Cj4gwqB9Owo+IMKgCj4gwqB2b2lkIGRybV9ncHV2bV9pbml0KHN0cnVj
dCBkcm1fZ3B1dm0gKmdwdXZtLCBzdHJ1Y3QgZHJtX2dlbV9vYmplY3QKPiAqcl9vYmosCj4gLcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb25zdCBjaGFyICpuYW1lLAo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29uc3QgY2hhciAqbmFtZSwgZW51
bSBkcm1fZ3B1dm1fZmxhZ3MgZmxhZ3MsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgdTY0IHN0YXJ0X29mZnNldCwgdTY0IHJhbmdlLAo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHU2NCByZXNlcnZlX29mZnNldCwgdTY0IHJlc2VydmVfcmFu
Z2UsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29uc3Qgc3RydWN0
IGRybV9ncHV2bV9vcHMgKm9wcyk7CgpSZXZpZXdlZC1ieTogVGhvbWFzIEhlbGxzdHLDtm0gPHRo
b21hcy5oZWxsc3Ryb21AbGludXguaW50ZWwuY29tPgoK

