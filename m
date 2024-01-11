Return-Path: <linux-kernel+bounces-23797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2497C82B1DE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBDC4B219B7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E804CDE8;
	Thu, 11 Jan 2024 15:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jRrSRa2A"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5B84CB25
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 15:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704987150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KzKa5s33X3IKu2M/hTuWcesIvEV9ZEphom5s5UiSxgA=;
	b=jRrSRa2AAkb6V2K9aKQGknAXkV+JWzufk448BsaeZdq7BFl1dOTE+rNDB5q0+zA/c6ZGXj
	kSFAMovBomsEYfC3CcnjXw+vffMmid3cXduFHAH6mSWr/X9w2dDFE4mImfJzxWSi4SSD2K
	xdUfiPAJY0FbKBR7ePmM4fO0ruKJFZQ=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-q4DkJja3PaCIqnEumt1lAQ-1; Thu, 11 Jan 2024 10:32:28 -0500
X-MC-Unique: q4DkJja3PaCIqnEumt1lAQ-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1d44a50ab19so12090975ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 07:32:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704987148; x=1705591948;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KzKa5s33X3IKu2M/hTuWcesIvEV9ZEphom5s5UiSxgA=;
        b=QlHfOcV0XgBH5djzc/ETQ6jv6jbh2oyW724HAMxhtbP9UJrtbpNp6HvUg/FN/s75xK
         R8857mc77tUyCcFSeiAdhTW5O417fcGgPjBrDCr/x13PBC8RFSqmnOUd0TKPLC0jTqnd
         GAY02YrkqZ/5eXB1YhKCKjkN/qJ1CFy27ArWUviVlHkhP59AhDZRg7KvEGKF5pqcUB5v
         OkTCv2XJ68VmmTA+Rqqfa9YKVSWryCjp6xeEqiM6eyS9o/pVoYN5vgIvg1L7j0idxEDO
         3iYv8Ypa2ECa9p0ex2MTk6XrU+XenfEKOTntBuGaXrNAjwsVo9JWm1jhX4yU2ETy2HWh
         obuA==
X-Gm-Message-State: AOJu0Yzi9wEjkhLna0VoxhQSDmPHdDuHOtfb6ijaqk59IuNIsYjx69PF
	35Nd2svsz73Kei/Zlh7ZUyYT1ZQhePYSb2UhjcHgKYsrzTd1kC946DMWsqeBbNUNrLPGQq8Y9QE
	xkXIpwBUpmE+uG9gUd3DSNMa/efhlhBYt
X-Received: by 2002:a17:902:db04:b0:1d3:f36a:9d21 with SMTP id m4-20020a170902db0400b001d3f36a9d21mr2604377plx.4.1704987147873;
        Thu, 11 Jan 2024 07:32:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFbn18LxwZvVOyuJQJGtvaDTZ6vhKK8BhyP+hkC6mfTUc/QgQYyoPY7OXXHe7LVU1236f3k7A==
X-Received: by 2002:a17:902:db04:b0:1d3:f36a:9d21 with SMTP id m4-20020a170902db0400b001d3f36a9d21mr2604348plx.4.1704987147537;
        Thu, 11 Jan 2024 07:32:27 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id kh4-20020a170903064400b001d4c9c9be42sm1295127plb.151.2024.01.11.07.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 07:32:26 -0800 (PST)
Message-ID: <3400ff3fbcd6f310f777be8cceddb253246b87fa.camel@redhat.com>
Subject: Re: [PATCH v5 RESEND 0/5] Regather scattered PCI-Code
From: Philipp Stanner <pstanner@redhat.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, 
 Johannes Berg <johannes@sipsolutions.net>, Randy Dunlap
 <rdunlap@infradead.org>, NeilBrown <neilb@suse.de>,  John Sanpe
 <sanpeqf@gmail.com>, Kent Overstreet <kent.overstreet@gmail.com>, Niklas
 Schnelle <schnelle@linux.ibm.com>, Dave Jiang <dave.jiang@intel.com>,
 Uladzislau Koshchanka <koshchanka@gmail.com>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, David Gow <davidgow@google.com>, Kees Cook
 <keescook@chromium.org>, Rae Moar <rmoar@google.com>, Geert Uytterhoeven
 <geert@linux-m68k.org>, "wuqiang.matt" <wuqiang.matt@bytedance.com>, Yury
 Norov <yury.norov@gmail.com>, Jason Baron <jbaron@akamai.com>, Thomas
 Gleixner <tglx@linutronix.de>, Marco Elver <elver@google.com>, Andrew
 Morton <akpm@linux-foundation.org>, Ben Dooks <ben.dooks@codethink.co.uk>,
 dakr@redhat.com, linux-kernel@vger.kernel.org,  linux-pci@vger.kernel.org,
 linux-arch@vger.kernel.org, stable@vger.kernel.org
Date: Thu, 11 Jan 2024 16:32:07 +0100
In-Reply-To: <20240111145338.GA2173492@bhelgaas>
References: <20240111145338.GA2173492@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gVGh1LCAyMDI0LTAxLTExIGF0IDA4OjUzIC0wNjAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOgo+
IE9uIFRodSwgSmFuIDExLCAyMDI0IGF0IDA5OjU1OjM1QU0gKzAxMDAsIFBoaWxpcHAgU3Rhbm5l
ciB3cm90ZToKPiA+IFNlY29uZCBSZXNlbmQuIFdvdWxkIGJlIGNvb2wgaWYgc29tZW9uZSBjb3Vs
ZCB0ZWxsIG1lIHdoYXQgSSdsbAo+ID4gaGF2ZSB0bwo+ID4gZG8gc28gd2UgY2FuIGdldCB0aGlz
IG1lcmdlZC4gVGhpcyBpcyBibG9ja2luZyB0aGUgZm9sbG93dXAgd29yawo+ID4gSSd2ZQo+ID4g
Z290IGluIHRoZSBwaXBlCj4gCj4gVGhpcyBzZWVtcyBQQ0ktZm9jdXNlZCwgYW5kIEknbGwgbG9v
ayBhdCBtZXJnaW5nIHRoaXMgYWZ0ZXIgdjYuOC1yYzEKPiBpcyB0YWdnZWQgYW5kIHRoZSBtZXJn
ZSB3aW5kb3cgY2xvc2VzIChwcm9iYWJseSBKYW4gMjEpLsKgIFRoZW4gSSdsbAo+IHJlYmFzZSBp
dCB0byB2Ni44LXJjMSwgdGlkeSB0aGUgc3ViamVjdCBsaW5lcyB0byBsb29rIGxpa2UgdGhlIHJl
c3QKPiBvZiBkcml2ZXJzL3BjaS8sIGV0Yy4KCkNvb2whCgpKdXN0IHBpbmcgeW91IGlmIHlvdSBu
ZWVkIG1lIHRvIGRvIHNvbWV0aGluZwoKUmVnYXJkcywKUC4KCj4gCj4gPiBQaGlsaXBwIFN0YW5u
ZXIgKDUpOgo+ID4gwqAgbGliL3BjaV9pb21hcC5jOiBmaXggY2xlYW51cCBidWdzIGluIHBjaV9p
b3VubWFwKCkKPiA+IMKgIGxpYjogbW92ZSBwY2lfaW9tYXAuYyB0byBkcml2ZXJzL3BjaS8KPiA+
IMKgIGxpYjogbW92ZSBwY2ktc3BlY2lmaWMgZGV2cmVzIGNvZGUgdG8gZHJpdmVycy9wY2kvCj4g
PiDCoCBwY2k6IG1vdmUgZGV2cmVzIGNvZGUgZnJvbSBwY2kuYyB0byBkZXZyZXMuYwo+ID4gwqAg
bGliLCBwY2k6IHVuaWZ5IGdlbmVyaWMgcGNpX2lvdW5tYXAoKQo+ID4gCj4gPiDCoE1BSU5UQUlO
RVJTwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHzCoMKgIDEgLQo+ID4gwqBkcml2ZXJzL3BjaS9LY29uZmlnwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgNSArCj4gPiDCoGRyaXZlcnMvcGNpL01ha2VmaWxlwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDMgKy0KPiA+IMKgZHJpdmVy
cy9wY2kvZGV2cmVzLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCA0NTAK
PiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysKPiA+IMKgbGliL3BjaV9pb21hcC5jID0+IGRy
aXZlcnMvcGNpL2lvbWFwLmMgfMKgIDQ5ICstLQo+ID4gwqBkcml2ZXJzL3BjaS9wY2kuY8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDI0OSAtLS0tLS0tLS0tLS0t
LQo+ID4gwqBkcml2ZXJzL3BjaS9wY2kuaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB8wqAgMjQgKysKPiA+IMKgaW5jbHVkZS9hc20tZ2VuZXJpYy9pby5owqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMjcgKy0KPiA+IMKgaW5jbHVkZS9hc20tZ2VuZXJp
Yy9pb21hcC5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMjEgKysKPiA+IMKgbGliL0tjb25m
aWfCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
fMKgwqAgMyAtCj4gPiDCoGxpYi9NYWtlZmlsZcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMSAtCj4gPiDCoGxpYi9kZXZyZXMuY8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAyMDggKy0t
LS0tLS0tLS0tCj4gPiDCoGxpYi9pb21hcC5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAyOCArLQo+ID4gwqAxMyBmaWxlcyBjaGFuZ2Vk
LCA1NjYgaW5zZXJ0aW9ucygrKSwgNTAzIGRlbGV0aW9ucygtKQo+ID4gwqBjcmVhdGUgbW9kZSAx
MDA2NDQgZHJpdmVycy9wY2kvZGV2cmVzLmMKPiA+IMKgcmVuYW1lIGxpYi9wY2lfaW9tYXAuYyA9
PiBkcml2ZXJzL3BjaS9pb21hcC5jICg3NSUpCj4gCgo=


