Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D537C73E6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 19:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379568AbjJLROU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 13:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344032AbjJLROS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 13:14:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B1BB7;
        Thu, 12 Oct 2023 10:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697130857; x=1728666857;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=+kAdPo/Z6+eAGi2QKVMiAx1RGQ0rZ1BP8aVDOjEZL9k=;
  b=AKuD/k9S1GcKDPd+MONB17mg8y/mH82LwceWOafJC3icC5ZwhVd0QOFf
   /KTkHnqdDUekrRRifNpNJEdJDqJY6DuDjl+NSVy4/c+bvZuFRvrBTUC7B
   JzKu72vRfPPLM98HDFnuoms7lJd5QrNuW+XOySzWVTJSkbiFTwnoR7xOe
   NldbWTfSeQAfryg4v4nr8ANFJOZRsKd37GTHl8tbgO/gYWkt1Gwx3PEc+
   uXdDo5b2W1xIqnqCRX7D4uTggz9j1AjNF5JdtePq6B5wmKUk7wjqXukUk
   Z6WSSOCc+FjRrjA795yMGOE0LlV5o7/V/JnkvNoVP2W5SzC9mbmhoXwSn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="416028230"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="416028230"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 10:13:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="820217109"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="820217109"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 10:13:40 -0700
Received: from [10.54.75.156] (debox1-desk1.jf.intel.com [10.54.75.156])
        by linux.intel.com (Postfix) with ESMTP id C161B580919;
        Thu, 12 Oct 2023 10:13:39 -0700 (PDT)
Message-ID: <fcd4ae3492b8bf08ec637a3405228efd2913921d.camel@linux.intel.com>
Subject: Re: [PATCH V3 03/16] platform/x86/intel/vsec: Use cleanup.h
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, rajvi.jingar@linux.intel.com
Date:   Thu, 12 Oct 2023 10:13:39 -0700
In-Reply-To: <114e1cc4-f129-b6cd-a83b-7d822cde178@linux.intel.com>
References: <20231012023840.3845703-1-david.e.box@linux.intel.com>
         <20231012023840.3845703-4-david.e.box@linux.intel.com>
         <114e1cc4-f129-b6cd-a83b-7d822cde178@linux.intel.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTEwLTEyIGF0IDE3OjQ2ICswMzAwLCBJbHBvIErDpHJ2aW5lbiB3cm90ZToK
PiBPbiBXZWQsIDExIE9jdCAyMDIzLCBEYXZpZCBFLiBCb3ggd3JvdGU6Cj4gCj4gPiBVc2UgY2xl
YW51cC5oIGhlbHBlcnMgdG8gaGFuZGxlIGNsZWFudXAgb2YgcmVzb3VyY2VzIGluCj4gPiBpbnRl
bF92c2VjX2FkZF9kZXYoKSBhZnRlciBmYWlsdXJlcy4KPiA+IAo+ID4gU2lnbmVkLW9mZi1ieTog
RGF2aWQgRS4gQm94IDxkYXZpZC5lLmJveEBsaW51eC5pbnRlbC5jb20+Cj4gPiAtLS0KPiA+IFYz
IC0gTmV3IHBhdGNoLgo+ID4gCj4gPiDCoGRyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsL3ZzZWMu
YyB8IDE3ICsrKysrKysrKystLS0tLS0tCj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRp
b25zKCspLCA3IGRlbGV0aW9ucygtKQo+ID4gCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wbGF0
Zm9ybS94ODYvaW50ZWwvdnNlYy5jCj4gPiBiL2RyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsL3Zz
ZWMuYwo+ID4gaW5kZXggMTU4NjZiN2QzMTE3Li5mMDNhYjg5YWI3YzAgMTAwNjQ0Cj4gPiAtLS0g
YS9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbC92c2VjLmMKPiA+ICsrKyBiL2RyaXZlcnMvcGxh
dGZvcm0veDg2L2ludGVsL3ZzZWMuYwo+ID4gQEAgLTE1LDYgKzE1LDcgQEAKPiA+IMKgCj4gPiDC
oCNpbmNsdWRlIDxsaW51eC9hdXhpbGlhcnlfYnVzLmg+Cj4gPiDCoCNpbmNsdWRlIDxsaW51eC9i
aXRzLmg+Cj4gPiArI2luY2x1ZGUgPGxpbnV4L2NsZWFudXAuaD4KPiA+IMKgI2luY2x1ZGUgPGxp
bnV4L2RlbGF5Lmg+Cj4gPiDCoCNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4KPiA+IMKgI2luY2x1
ZGUgPGxpbnV4L2lkci5oPgo+ID4gQEAgLTE1NSwxMCArMTU2LDEwIEBAIEVYUE9SVF9TWU1CT0xf
TlNfR1BMKGludGVsX3ZzZWNfYWRkX2F1eCwgSU5URUxfVlNFQyk7Cj4gPiDCoHN0YXRpYyBpbnQg
aW50ZWxfdnNlY19hZGRfZGV2KHN0cnVjdCBwY2lfZGV2ICpwZGV2LCBzdHJ1Y3QKPiA+IGludGVs
X3ZzZWNfaGVhZGVyICpoZWFkZXIsCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBpbnRlbF92c2VjX3BsYXRmb3JtX2lu
Zm8gKmluZm8pCj4gPiDCoHsKPiA+IC3CoMKgwqDCoMKgwqDCoHN0cnVjdCBpbnRlbF92c2VjX2Rl
dmljZSAqaW50ZWxfdnNlY19kZXY7Cj4gPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgaW50ZWxfdnNl
Y19kZXZpY2UgX19mcmVlKGtmcmVlKSAqaW50ZWxfdnNlY19kZXYgPSBOVUxMOwo+ID4gwqDCoMKg
wqDCoMKgwqDCoHN0cnVjdCByZXNvdXJjZSAqcmVzLCAqdG1wOwo+ID4gwqDCoMKgwqDCoMKgwqDC
oHVuc2lnbmVkIGxvbmcgcXVpcmtzID0gaW5mby0+cXVpcmtzOwo+ID4gLcKgwqDCoMKgwqDCoMKg
aW50IGk7Cj4gPiArwqDCoMKgwqDCoMKgwqBpbnQgcmV0LCBpOwo+ID4gwqAKPiA+IMKgwqDCoMKg
wqDCoMKgwqBpZiAoIWludGVsX3ZzZWNfc3VwcG9ydGVkKGhlYWRlci0+aWQsIGluZm8tPmNhcHMp
KQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gLUVJTlZBTDsKPiA+
IEBAIC0xNzgsMTAgKzE3OSw4IEBAIHN0YXRpYyBpbnQgaW50ZWxfdnNlY19hZGRfZGV2KHN0cnVj
dCBwY2lfZGV2ICpwZGV2LAo+ID4gc3RydWN0IGludGVsX3ZzZWNfaGVhZGVyICpoZQo+ID4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gLUVOT01FTTsKPiA+IMKgCj4gPiDC
oMKgwqDCoMKgwqDCoMKgcmVzID0ga2NhbGxvYyhoZWFkZXItPm51bV9lbnRyaWVzLCBzaXplb2Yo
KnJlcyksIEdGUF9LRVJORUwpOwo+ID4gLcKgwqDCoMKgwqDCoMKgaWYgKCFyZXMpIHsKPiA+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBrZnJlZShpbnRlbF92c2VjX2Rldik7Cj4gPiAr
wqDCoMKgwqDCoMKgwqBpZiAoIXJlcykKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgcmV0dXJuIC1FTk9NRU07Cj4gPiAtwqDCoMKgwqDCoMKgwqB9Cj4gPiDCoAo+ID4gwqDCoMKg
wqDCoMKgwqDCoGlmIChxdWlya3MgJiBWU0VDX1FVSVJLX1RBQkxFX1NISUZUKQo+ID4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBoZWFkZXItPm9mZnNldCA+Pj0gVEFCTEVfT0ZGU0VU
X1NISUZUOwo+ID4gQEAgLTIwOCw4ICsyMDcsMTIgQEAgc3RhdGljIGludCBpbnRlbF92c2VjX2Fk
ZF9kZXYoc3RydWN0IHBjaV9kZXYgKnBkZXYsCj4gPiBzdHJ1Y3QgaW50ZWxfdnNlY19oZWFkZXIg
KmhlCj4gPiDCoMKgwqDCoMKgwqDCoMKgZWxzZQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBpbnRlbF92c2VjX2Rldi0+aWRhID0gJmludGVsX3ZzZWNfaWRhOwo+ID4gwqAKPiA+
IC3CoMKgwqDCoMKgwqDCoHJldHVybiBpbnRlbF92c2VjX2FkZF9hdXgocGRldiwgTlVMTCwgaW50
ZWxfdnNlY19kZXYsCj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbnRlbF92c2VjX25hbWUoaGVhZGVyLT5pZCkpOwo+
ID4gK8KgwqDCoMKgwqDCoMKgcmV0ID0gaW50ZWxfdnNlY19hZGRfYXV4KHBkZXYsIE5VTEwsIGlu
dGVsX3ZzZWNfZGV2LAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGludGVsX3ZzZWNfbmFtZShoZWFkZXItPmlkKSk7Cj4g
PiArCj4gPiArwqDCoMKgwqDCoMKgwqBub19mcmVlX3B0cihpbnRlbF92c2VjX2Rldik7Cj4gPiAr
Cj4gPiArwqDCoMKgwqDCoMKgwqByZXR1cm4gcmV0Owo+IAo+IFNvIGlmIGludGVsX3ZzZWNfYWRk
X2F1eCgpIHJldHVybmVkIGFuIGVycm9yLCBpbnRlbF92c2VjX2RldiB3b24ndCBiZSAKPiBmcmVl
ZCBiZWNhdXNlIG9mIHRoZSBjYWxsIGNhbGwgdG8gbm9fZnJlZV9wdHIoKSBiZWZvcmUgcmV0dXJu
LiBJIHRoYXQncyAKPiBub3Qgd2hhdCB5b3UgaW50ZW5kZWQ/CgpJdCB3aWxsIGhhdmUgYmVlbiBm
cmVlZCBpZiBpbnRlbF92c2VjX2FkZF9hdXgoKSBmYWlscy4gSXQncyBhIGxpdHRsZSBtZXNzeS4g
VGhhdApmdW5jdGlvbiBjcmVhdGVzIHRoZSBhdXhkZXYgYW5kIGFzc2lnbnMgdGhlIHJlbGVhc2Ug
ZnVuY3Rpb24gd2hpY2ggd2lsbCBmcmVlCmludGVsX3ZzZWNfZGV2IHdoZW4gdGhlIGRldmljZSBp
cyByZW1vdmVkLiBCdXQgdGhlcmUgYXJlIGZhaWx1cmUgcG9pbnRzIHRoYXQKd2lsbCBhbHNvIGlu
dm9rZSB0aGUgcmVsZWFzZSBmdW5jdGlvbi4gQmVjYXVzZSBvZiB0aGlzLCBmb3IgYWxsIHRoZSBm
YWlsdXJlCnBvaW50cyBpbiB0aGF0IGZ1bmN0aW9uIHdlIGZyZWUgaW50ZWxfdnNlY19kZXYgc28g
dGhhdCBpdCdzIHN0YXRlIGRvZXNuJ3QgbmVlZAp0byBiZSBxdWVzdGlvbmVkIGhlcmUuIFRoaXMg
aGFwcGVucyBleHBsaWNpdGx5IGlmIHRoZSBmYWlsdXJlIGlzIGJlZm9yZQphdXhpbGlhcnlfZGV2
aWNlX2luaXQoKSwgb3IgdGhyb3VnaCB0aGUgcmVsZWFzZSBmdW5jdGlvbiBpbnZva2VkIGJ5CmF1
eGlsaWFyeV9kZXZpY2VfdW5pbml0KCkgaWYgYWZ0ZXIuCgpEYXZpZAoKPiAKCg==

