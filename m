Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96AD57AF79C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 03:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjI0BIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 21:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234484AbjI0BGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 21:06:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F326199D;
        Tue, 26 Sep 2023 17:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695774020; x=1727310020;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=cSAYSnhrgZPLxFkZ2DRrVDBiyhXQaPSiLX/Dyb+4wiA=;
  b=mtKZCA3PdD9JPgaqEx+D/uo3OuMwojB+o8P9T0gkCtmkOkUNeRghZ9ra
   ufB/k8qbJZO8yI+NqU5PfQsjOjzyA6ujhojnBxhrYIQ7DtWqYtT9cvBF1
   X3voPqIPo7g/dZxLPweVgpFUVcQQTXxegYMsx+Utfpf3hIYjNoBG7tYxF
   tqq3B5kXnwAGPLSG0iA2suxzMGmIvoD1ReJ9PFjt+9C5khZoja4vl7Y8g
   JL73A+7Cn2Q0OTqN6K3NR1jJNSVJxbP97UaOFHFCjjSANe/pZ9Cyexb5p
   2z4HCwv/X/Ss60SugDfejtW8dDbyy+ijKtkuVLmf6xq46fxkeKcKrVU3h
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="385550318"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="385550318"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 17:20:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="819215920"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="819215920"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 17:20:20 -0700
Received: from rabakare-mobl3.amr.corp.intel.com (unknown [10.212.145.15])
        by linux.intel.com (Postfix) with ESMTP id AFB40580BBE;
        Tue, 26 Sep 2023 17:20:19 -0700 (PDT)
Message-ID: <7106078fedb5a58d8ca1e8dfb10245929d4dc269.camel@linux.intel.com>
Subject: Re: [PATCH 10/11] platform/x86/intel/pmc: Read low power mode
 requirements for MTL-M and MTL-P
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, rajvi.jingar@linux.intel.com
Date:   Tue, 26 Sep 2023 17:20:19 -0700
In-Reply-To: <a2f52dca-ffaf-31b0-c281-48fc193e6552@linux.intel.com>
References: <20230922213032.1770590-1-david.e.box@linux.intel.com>
         <20230922213032.1770590-11-david.e.box@linux.intel.com>
         <a2f52dca-ffaf-31b0-c281-48fc193e6552@linux.intel.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA5LTI2IGF0IDE5OjAzICswMzAwLCBJbHBvIErDpHJ2aW5lbiB3cm90ZToK
PiBPbiBGcmksIDIyIFNlcCAyMDIzLCBEYXZpZCBFLiBCb3ggd3JvdGU6Cj4gCj4gPiBGcm9tOiBY
aSBQYXJkZWUgPHhpLnBhcmRlZUBpbnRlbC5jb20+Cj4gPiAKPiA+IEFkZCBzdXBwb3J0IHRvIHJl
YWQgdGhlIGxvdyBwb3dlciBtb2RlIHJlcXVpcmVtZW50cyBmb3IgTWV0ZW9yIExha2UgTSBhbmQK
PiA+IE1ldGVvciBMYWtlIFAuCj4gPiAKPiA+IFNpZ25lZC1vZmYtYnk6IFhpIFBhcmRlZSA8eGku
cGFyZGVlQGludGVsLmNvbT4KPiA+IFNpZ25lZC1vZmYtYnk6IERhdmlkIEUuIEJveCA8ZGF2aWQu
ZS5ib3hAbGludXguaW50ZWwuY29tPgo+ID4gLS0tCj4gPiDCoGRyaXZlcnMvcGxhdGZvcm0veDg2
L2ludGVsL3BtYy9tdGwuYyB8IDM5ICsrKysrKysrKysrKysrKysrKysrKysrLS0tLS0KPiA+IMKg
MSBmaWxlIGNoYW5nZWQsIDMzIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCj4gPiAKPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbC9wbWMvbXRsLmMKPiA+IGIv
ZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWwvcG1jL210bC5jCj4gPiBpbmRleCA3ODA4NzQxNDJh
OTAuLmMyYWM1MGNmZGQ1MSAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvcGxhdGZvcm0veDg2L2lu
dGVsL3BtYy9tdGwuYwo+ID4gKysrIGIvZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWwvcG1jL210
bC5jCj4gPiBAQCAtMTEsNiArMTEsMTMgQEAKPiA+IMKgI2luY2x1ZGUgPGxpbnV4L3BjaS5oPgo+
ID4gwqAjaW5jbHVkZSAiY29yZS5oIgo+ID4gwqAKPiA+ICsvKiBQTUMgU1NSQU0gUE1UIFRlbGVt
ZXRyeSBHVUlEUyAqLwo+ID4gKyNkZWZpbmUgU09DUF9MUE1fUkVRX0dVSUTCoMKgwqDCoMKgwqAw
eDI2MjUwMzAKPiA+ICsjZGVmaW5lIElPRU1fTFBNX1JFUV9HVUlEwqDCoMKgwqDCoMKgMHg0MzU3
NDY0Cj4gPiArI2RlZmluZSBJT0VQX0xQTV9SRVFfR1VJRMKgwqDCoMKgwqDCoDB4NTA3NzYxMgo+
ID4gKwo+ID4gK3N0YXRpYyBjb25zdCB1OCBNVExfTFBNX1JFR19JTkRFWFtdID0gezAsIDQsIDUs
IDYsIDgsIDksIDEwLCAxMSwgMTIsIDEzLAo+ID4gMTQsIDE1LCAxNiwgMjB9Owo+ID4gKwo+ID4g
wqAvKgo+ID4gwqAgKiBEaWUgTWFwcGluZyB0byBQcm9kdWN0Lgo+ID4gwqAgKiBQcm9kdWN0IFNP
Q0RpZSBJT0VEaWUgUENIRGllCj4gPiBAQCAtNDY1LDYgKzQ3Miw3IEBAIGNvbnN0IHN0cnVjdCBw
bWNfcmVnX21hcCBtdGxfc29jbV9yZWdfbWFwID0gewo+ID4gwqDCoMKgwqDCoMKgwqDCoC5scG1f
c3RzID0gbXRsX3NvY21fbHBtX21hcHMsCj4gPiDCoMKgwqDCoMKgwqDCoMKgLmxwbV9zdGF0dXNf
b2Zmc2V0ID0gTVRMX0xQTV9TVEFUVVNfT0ZGU0VULAo+ID4gwqDCoMKgwqDCoMKgwqDCoC5scG1f
bGl2ZV9zdGF0dXNfb2Zmc2V0ID0gTVRMX0xQTV9MSVZFX1NUQVRVU19PRkZTRVQsCj4gPiArwqDC
oMKgwqDCoMKgwqAubHBtX3JlZ19pbmRleCA9IE1UTF9MUE1fUkVHX0lOREVYLAo+ID4gwqB9Owo+
ID4gwqAKPiA+IMKgY29uc3Qgc3RydWN0IHBtY19iaXRfbWFwIG10bF9pb2VwX3BmZWFyX21hcFtd
ID0gewo+ID4gQEAgLTc4Miw2ICs3OTAsMTMgQEAgY29uc3Qgc3RydWN0IHBtY19yZWdfbWFwIG10
bF9pb2VwX3JlZ19tYXAgPSB7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgLmx0cl9zaG93X3N0cyA9IG10
bF9pb2VwX2x0cl9zaG93X21hcCwKPiA+IMKgwqDCoMKgwqDCoMKgwqAubHRyX2lnbm9yZV9vZmZz
ZXQgPSBDTlBfUE1DX0xUUl9JR05PUkVfT0ZGU0VULAo+ID4gwqDCoMKgwqDCoMKgwqDCoC5sdHJf
aWdub3JlX21heCA9IEFETF9OVU1fSVBfSUdOX0FMTE9XRUQsCj4gPiArwqDCoMKgwqDCoMKgwqAu
bHBtX251bV9tYXBzID0gQURMX0xQTV9OVU1fTUFQUywKPiA+ICvCoMKgwqDCoMKgwqDCoC5scG1f
cmVzX2NvdW50ZXJfc3RlcF94MiA9IFRHTF9QTUNfTFBNX1JFU19DT1VOVEVSX1NURVBfWDIsCj4g
PiArwqDCoMKgwqDCoMKgwqAubHBtX3Jlc2lkZW5jeV9vZmZzZXQgPSBNVExfTFBNX1JFU0lERU5D
WV9PRkZTRVQsCj4gPiArwqDCoMKgwqDCoMKgwqAubHBtX3ByaW9yaXR5X29mZnNldCA9IE1UTF9M
UE1fUFJJX09GRlNFVCwKPiA+ICvCoMKgwqDCoMKgwqDCoC5scG1fZW5fb2Zmc2V0ID0gTVRMX0xQ
TV9FTl9PRkZTRVQsCj4gPiArwqDCoMKgwqDCoMKgwqAubHBtX3N0c19sYXRjaF9lbl9vZmZzZXQg
PSBNVExfTFBNX1NUQVRVU19MQVRDSF9FTl9PRkZTRVQsCj4gPiArwqDCoMKgwqDCoMKgwqAubHBt
X3JlZ19pbmRleCA9IE1UTF9MUE1fUkVHX0lOREVYLAo+ID4gwqB9Owo+ID4gwqAKPiA+IMKgY29u
c3Qgc3RydWN0IHBtY19iaXRfbWFwIG10bF9pb2VtX3BmZWFyX21hcFtdID0gewo+ID4gQEAgLTky
Miw2ICs5MzcsMTMgQEAgY29uc3Qgc3RydWN0IHBtY19yZWdfbWFwIG10bF9pb2VtX3JlZ19tYXAg
PSB7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgLmx0cl9zaG93X3N0cyA9IG10bF9pb2VwX2x0cl9zaG93
X21hcCwKPiA+IMKgwqDCoMKgwqDCoMKgwqAubHRyX2lnbm9yZV9vZmZzZXQgPSBDTlBfUE1DX0xU
Ul9JR05PUkVfT0ZGU0VULAo+ID4gwqDCoMKgwqDCoMKgwqDCoC5sdHJfaWdub3JlX21heCA9IEFE
TF9OVU1fSVBfSUdOX0FMTE9XRUQsCj4gPiArwqDCoMKgwqDCoMKgwqAubHBtX3N0c19sYXRjaF9l
bl9vZmZzZXQgPSBNVExfTFBNX1NUQVRVU19MQVRDSF9FTl9PRkZTRVQsCj4gPiArwqDCoMKgwqDC
oMKgwqAubHBtX251bV9tYXBzID0gQURMX0xQTV9OVU1fTUFQUywKPiA+ICvCoMKgwqDCoMKgwqDC
oC5scG1fcHJpb3JpdHlfb2Zmc2V0ID0gTVRMX0xQTV9QUklfT0ZGU0VULAo+ID4gK8KgwqDCoMKg
wqDCoMKgLmxwbV9lbl9vZmZzZXQgPSBNVExfTFBNX0VOX09GRlNFVCwKPiA+ICvCoMKgwqDCoMKg
wqDCoC5scG1fcmVzX2NvdW50ZXJfc3RlcF94MiA9IFRHTF9QTUNfTFBNX1JFU19DT1VOVEVSX1NU
RVBfWDIsCj4gPiArwqDCoMKgwqDCoMKgwqAubHBtX3Jlc2lkZW5jeV9vZmZzZXQgPSBNVExfTFBN
X1JFU0lERU5DWV9PRkZTRVQsCj4gPiArwqDCoMKgwqDCoMKgwqAubHBtX3JlZ19pbmRleCA9IE1U
TF9MUE1fUkVHX0lOREVYLAo+ID4gwqB9Owo+ID4gwqAKPiA+IMKgI2RlZmluZSBQTUNfREVWSURf
U09DTcKgMHg3ZTdmCj4gPiBAQCAtOTI5LDE2ICs5NTEsMTkgQEAgY29uc3Qgc3RydWN0IHBtY19y
ZWdfbWFwIG10bF9pb2VtX3JlZ19tYXAgPSB7Cj4gPiDCoCNkZWZpbmUgUE1DX0RFVklEX0lPRU3C
oDB4N2ViZgo+ID4gwqBzdGF0aWMgc3RydWN0IHBtY19pbmZvIG10bF9wbWNfaW5mb19saXN0W10g
PSB7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgewo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoC5kZXZpZCA9IFBNQ19ERVZJRF9TT0NNLAo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoC5tYXAgPSAmbXRsX3NvY21fcmVnX21hcCwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAuZ3VpZMKgwqDCoD0gU09DUF9MUE1fUkVRX0dVSUQsCj4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgLmRldmlkwqDCoD0gUE1DX0RFVklEX1NPQ00sCj4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLm1hcMKgwqDCoMKgPSAmbXRsX3NvY21fcmVnX21h
cCwKPiA+IMKgwqDCoMKgwqDCoMKgwqB9LAo+ID4gwqDCoMKgwqDCoMKgwqDCoHsKPiA+IC3CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAuZGV2aWQgPSBQTUNfREVWSURfSU9FUCwKPiA+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAubWFwID0gJm10bF9pb2VwX3JlZ19tYXAsCj4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLmd1aWTCoMKgwqA9IElPRVBfTFBNX1JF
UV9HVUlELAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5kZXZpZMKgwqA9IFBN
Q19ERVZJRF9JT0VQLAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5tYXDCoMKg
wqDCoD0gJm10bF9pb2VwX3JlZ19tYXAsCj4gPiDCoMKgwqDCoMKgwqDCoMKgfSwKPiA+IMKgwqDC
oMKgwqDCoMKgwqB7Cj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLmRldmlkID0g
UE1DX0RFVklEX0lPRU0sCj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLm1hcCA9
ICZtdGxfaW9lbV9yZWdfbWFwCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLmd1
aWTCoMKgwqA9IElPRU1fTFBNX1JFUV9HVUlELAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoC5kZXZpZMKgwqA9IFBNQ19ERVZJRF9JT0VNLAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoC5tYXDCoMKgwqDCoD0gJm10bF9pb2VtX3JlZ19tYXAKPiA+IMKgwqDCoMKg
wqDCoMKgwqB9LAo+ID4gwqDCoMKgwqDCoMKgwqDCoHt9Cj4gPiDCoH07Cj4gPiBAQCAtMTAxMiw1
ICsxMDM3LDcgQEAgaW50IG10bF9jb3JlX2luaXQoc3RydWN0IHBtY19kZXYgKnBtY2RldikKPiA+
IMKgwqDCoMKgwqDCoMKgwqBkZXZfZGJnKCZwbWNkZXYtPnBkZXYtPmRldiwgImlnbm9yaW5nIEdC
RSBMVFJcbiIpOwo+ID4gwqDCoMKgwqDCoMKgwqDCoHBtY19jb3JlX3NlbmRfbHRyX2lnbm9yZShw
bWNkZXYsIDMpOwo+ID4gwqAKPiA+ICvCoMKgwqDCoMKgwqDCoHJldCA9IHBtY19jb3JlX3NzcmFt
X2dldF9scG1fcmVxcyhwbWNkZXYpOwo+ID4gKwo+IAo+IFVudXNlZCByZXR1cm4gdmFsdWU/PwoK
R29vZCBjYXRjaC4KCj4gCj4gPiDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIDA7Cj4gPiDCoH0KPiA+
IAo+IAoK

