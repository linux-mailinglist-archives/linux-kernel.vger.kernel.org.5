Return-Path: <linux-kernel+bounces-127017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4F38945DC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 22:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42BB71C217ED
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 20:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496FB53E01;
	Mon,  1 Apr 2024 20:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nGZNDbmO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5DF3D9E;
	Mon,  1 Apr 2024 20:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712002005; cv=none; b=abBfyFhnpoaTF9ux6HcpqfXRIaiNDYp0+24iiiy8hFQkVoi0rvSKSmSqHbI2tlCzHxTfpwawaAvx/aOiiiqeioy4IEnW4YW9PzS2eyD7HOlvOLRpcSj7zVL9JRy/FV8gGqYXKVw/8GFm4VdlQyFZZfWdG+Pe+ho52YSEPQ3wfwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712002005; c=relaxed/simple;
	bh=hHQRXmo2aZ/DOP23EIK2Ayp/OQTbGs67h/enIjBg6/c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cZkFV/r3+tH/bqwV/12wHAXLMjLXCq7nHEfwu4XnFkBuvtsYNlDAA0OJGaDAzkxqOvIutlsZ/aH5RVeH2OPat2iqEj+i19MdA0G2Ad7JUe7CnBxdI2tz3RXhWVFGe2s2qK0UeUGK/LwVBkvqnDgX1i/28BfM0ior9J47R/SIG58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nGZNDbmO; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712002004; x=1743538004;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=hHQRXmo2aZ/DOP23EIK2Ayp/OQTbGs67h/enIjBg6/c=;
  b=nGZNDbmOOFRVN5WdC4fDO9BYJPrGEV6qMdy9tHNizOBb0C4MSnCtLMhc
   Mo5i851uLX+iIaC8DHIZ1+LI4rtQ6sqOgUocj6vN8PGaKRl+dLTB9KBuB
   TbDj/XPHLjrOVJ7BEFY3P1cbGA45H8JwapU/5MpvjZQI5q6WJ6WHEHOe/
   2+A2es3Xm88QHg5Guv9NeMwjcm5gKIhbVLIoZE87FNYCSZrHDD/SYSZng
   l0yASq+cBKDbxwMCism4d2n2p6B/ww2FYDd/tMAIrnaulrEVMvjJhbu8Q
   okONkpZbt5b9+2zKg4+VtfyTRRwLGPe1MmffUlSohioITVkkJwmpmXldX
   w==;
X-CSE-ConnectionGUID: Ccqx6x5SS7a3GywE7GAH6w==
X-CSE-MsgGUID: BT8j6hYqSke2r26mSlI2mA==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="18594648"
X-IronPort-AV: E=Sophos;i="6.07,173,1708416000"; 
   d="scan'208";a="18594648"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 13:06:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,173,1708416000"; 
   d="scan'208";a="17637588"
Received: from spandruv-desk1.amr.corp.intel.com ([10.209.0.212])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 13:06:43 -0700
Message-ID: <509b52f28a911bc11f21c217e20e769bd094f24d.camel@linux.intel.com>
Subject: Re: [PATCH v1 1/6] cpufreq: intel_pstate: Fold
 intel_pstate_max_within_limits() into caller
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM
 <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Date: Mon, 01 Apr 2024 13:06:42 -0700
In-Reply-To: <3297274.aeNJFYEL58@kreacher>
References: <13494237.uLZWGnKmhe@kreacher> <3297274.aeNJFYEL58@kreacher>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gTW9uLCAyMDI0LTAzLTI1IGF0IDE4OjAxICswMTAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToKPiBGcm9tOiBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsLmoud3lzb2NraUBpbnRlbC5jb20+
Cj4gCj4gRm9sZCBpbnRlbF9wc3RhdGVfbWF4X3dpdGhpbl9saW1pdHMoKSBpbnRvIGl0cyBvbmx5
IGNhbGxlci4KPiAKPiBObyBmdW5jdGlvbmFsIGltcGFjdC4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBS
YWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsLmoud3lzb2NraUBpbnRlbC5jb20+CkFja2VkLWJ5OiBT
cmluaXZhcyBQYW5kcnV2YWRhIDxzcmluaXZhcy5wYW5kcnV2YWRhQGxpbnV4LmludGVsLmNvbT4K
Cj4gLS0tCj4gwqBkcml2ZXJzL2NwdWZyZXEvaW50ZWxfcHN0YXRlLmMgfMKgwqAgMTMgKysrKy0t
LS0tLS0tLQo+IMKgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMo
LSkKPiAKPiBJbmRleDogbGludXgtcG0vZHJpdmVycy9jcHVmcmVxL2ludGVsX3BzdGF0ZS5jCj4g
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PQo+IC0tLSBsaW51eC1wbS5vcmlnL2RyaXZlcnMvY3B1ZnJlcS9pbnRlbF9wc3Rh
dGUuYwo+ICsrKyBsaW51eC1wbS9kcml2ZXJzL2NwdWZyZXEvaW50ZWxfcHN0YXRlLmMKPiBAQCAt
MjAxMiwxNCArMjAxMiw2IEBAIHN0YXRpYyB2b2lkIGludGVsX3BzdGF0ZV9zZXRfbWluX3BzdGF0
ZSgKPiDCoMKgwqDCoMKgwqDCoMKgaW50ZWxfcHN0YXRlX3NldF9wc3RhdGUoY3B1LCBjcHUtPnBz
dGF0ZS5taW5fcHN0YXRlKTsKPiDCoH0KPiDCoAo+IC1zdGF0aWMgdm9pZCBpbnRlbF9wc3RhdGVf
bWF4X3dpdGhpbl9saW1pdHMoc3RydWN0IGNwdWRhdGEgKmNwdSkKPiAtewo+IC3CoMKgwqDCoMKg
wqDCoGludCBwc3RhdGUgPSBtYXgoY3B1LT5wc3RhdGUubWluX3BzdGF0ZSwgY3B1LQo+ID5tYXhf
cGVyZl9yYXRpbyk7Cj4gLQo+IC3CoMKgwqDCoMKgwqDCoHVwZGF0ZV90dXJib19zdGF0ZSgpOwo+
IC3CoMKgwqDCoMKgwqDCoGludGVsX3BzdGF0ZV9zZXRfcHN0YXRlKGNwdSwgcHN0YXRlKTsKPiAt
fQo+IC0KPiDCoHN0YXRpYyB2b2lkIGludGVsX3BzdGF0ZV9nZXRfY3B1X3BzdGF0ZXMoc3RydWN0
IGNwdWRhdGEgKmNwdSkKPiDCoHsKPiDCoMKgwqDCoMKgwqDCoMKgaW50IHBlcmZfY3RsX21heF9w
aHlzID0gcHN0YXRlX2Z1bmNzLmdldF9tYXhfcGh5c2ljYWwoY3B1LQo+ID5jcHUpOwo+IEBAIC0y
NTk0LDEyICsyNTg2LDE1IEBAIHN0YXRpYyBpbnQgaW50ZWxfcHN0YXRlX3NldF9wb2xpY3koc3Ry
dWMKPiDCoMKgwqDCoMKgwqDCoMKgaW50ZWxfcHN0YXRlX3VwZGF0ZV9wZXJmX2xpbWl0cyhjcHUs
IHBvbGljeS0+bWluLCBwb2xpY3ktCj4gPm1heCk7Cj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgaWYg
KGNwdS0+cG9saWN5ID09IENQVUZSRVFfUE9MSUNZX1BFUkZPUk1BTkNFKSB7Cj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGludCBwc3RhdGUgPSBtYXgoY3B1LT5wc3RhdGUubWluX3Bz
dGF0ZSwgY3B1LQo+ID5tYXhfcGVyZl9yYXRpbyk7Cj4gKwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgLyoKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIE5PSFpf
RlVMTCBDUFVzIG5lZWQgdGhpcyBhcyB0aGUgZ292ZXJub3IgY2FsbGJhY2sKPiBtYXkgbm90Cj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBiZSBpbnZva2VkIG9uIHRoZW0uCj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKi8KPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGludGVsX3BzdGF0ZV9jbGVhcl91cGRhdGVfdXRpbF9ob29rKHBvbGljeS0+
Y3B1KTsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaW50ZWxfcHN0YXRlX21heF93
aXRoaW5fbGltaXRzKGNwdSk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHVwZGF0
ZV90dXJib19zdGF0ZSgpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpbnRlbF9w
c3RhdGVfc2V0X3BzdGF0ZShjcHUsIHBzdGF0ZSk7Cj4gwqDCoMKgwqDCoMKgwqDCoH0gZWxzZSB7
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpbnRlbF9wc3RhdGVfc2V0X3VwZGF0
ZV91dGlsX2hvb2socG9saWN5LT5jcHUpOwo+IMKgwqDCoMKgwqDCoMKgwqB9Cj4gCj4gCj4gCgo=


