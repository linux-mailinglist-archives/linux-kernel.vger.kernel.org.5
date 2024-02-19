Return-Path: <linux-kernel+bounces-71298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE8F85A320
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0BC5B21D47
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6088A2E3EB;
	Mon, 19 Feb 2024 12:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SpKOWzp5"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721492D04A
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 12:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708345453; cv=none; b=tjfQWSZIYR6Udj917T+mnzoYahDev8rB3IYARh9zi1BEPnZCJskczOP89Aw1SVcUQnhiaGCwJ1Cqpm/eRZetd7ZZNQbAJg6FUtgq+KEaMqET72c3rknai1jq0wNrJkJqaQJiPDQpXfvlR1j4PVFXX0l6aOeBaq8GWi1tN+XNrtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708345453; c=relaxed/simple;
	bh=q7kf0whgXcirJVeruAHMZBr5UEsfnDtk33GcQY+sNuw=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=on2sLG3Px2UK68/Pu3VCQkdkRueMI+f5qcTuwfOXYsacD91K4B8AHqAv7cRlVcd7s9NUkHNmhCbS0hPyRkCoi+9rdRAv0SagOzORuySMiD3dZf/zQsR0Ids1H0ky7U5syev1BodsyGJ6V1/3Ij+qtwS6SBVsGeFP/gqujqIQh5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SpKOWzp5; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41263e8b7f8so8264295e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 04:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1708345450; x=1708950250; darn=vger.kernel.org;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TruoVls7dqvGRsbKe5zz3jfKgNKKjOR8b53xJSvDp4s=;
        b=SpKOWzp5o3Z4v6lTjNcgbDOnwEB+csDUirkmLsxJNGplFcBACZJOblu0rl+IMNSkUG
         7rbKcWgvHarb5h7G247Rhz+mbbXDVq8w/Va+x1w3ZyRxjO9xtqjl/4+5az06zuH68oxR
         KsCsDMY3jQIDGyj86mRs18UW1Q6T9vr83LxoMxFLoDNeDrGSTZ/WNzew+wJhHyVYI9Fn
         mjy+WFijd77bKZI2lLJurfLfSFYRpAs++lB7dHdZq11EicD1uUdfvqT6q3VPAX//h/xJ
         fiLEfSgytjo1P238901YDvKpcjQC3sE2tcCP4XONDlN0QQBl9kYit4hqDoH1fb1RzyAp
         aFAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708345450; x=1708950250;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TruoVls7dqvGRsbKe5zz3jfKgNKKjOR8b53xJSvDp4s=;
        b=N3t1agAphfNvJ3Tc7/Rhu8zCVfww6CIPNN9zbZFaAbc/WTUWLaENOyQ3a8pDEmMQrt
         UyEFjbQ8vNufjVUF60xe6Ak+jCevKnISo1XZyiqa0IItPQ0jwynunnmBSOKMtbHhP95h
         4eGi2fJOe9q6d22tYkGGBYEJGwphi3FYdrltykl/iXF5hz5NXCCxAlkBwzd5cydDe6JJ
         8q/HYF8WgRwxDMqBIhTqSHJbt5aAW4Vk0+zsOXAZ/ovOK1+j9DKTGsmLlfz490D9WlS2
         odz2XB6QMoELG0SW00Bwy60EsQ4NaVpKzf5pVr1coTvHxWMVlZOTTWDO1POklYKQu6fq
         Y5Xw==
X-Gm-Message-State: AOJu0YzUIgz7BlyihUP9jsq7GLmxgSOjxPPmF5lsVDrMREyie5/cDqJ8
	DTYmH9NoeeEPGFUNzHUne7tPu7U6lHhQfySF6IiiEFF1pqYUFFnD8DtnLhik+jIxdwrSfEoT60d
	2
X-Google-Smtp-Source: AGHT+IHj35qyr5InXd+1elMWoLQLFt4ASBpVvjFHXab1GcPX7vglcCTKTBvwUNfNtUbdBxa/wXkSTA==
X-Received: by 2002:adf:fcc8:0:b0:33d:146a:d74a with SMTP id f8-20020adffcc8000000b0033d146ad74amr8812506wrs.22.1708345449766;
        Mon, 19 Feb 2024 04:24:09 -0800 (PST)
Received: from ?IPV6:2001:a61:1366:6801:d8:8490:cf1a:3274? ([2001:a61:1366:6801:d8:8490:cf1a:3274])
        by smtp.gmail.com with ESMTPSA id m2-20020a5d6a02000000b0033d071c0477sm10173526wru.59.2024.02.19.04.24.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 04:24:09 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------t9GZuSDJlD9zIs0PpIOh3i30"
Message-ID: <b0a28cf4-93f4-47a6-b9fe-af82eacfd970@suse.com>
Date: Mon, 19 Feb 2024 13:24:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ZDI-CAN-22273: New Vulnerability Report
Content-Language: en-US
To: "zdi-disclosures@trendmicro.com" <zdi-disclosures@trendmicro.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "valentina.manea.m@gmail.com" <valentina.manea.m@gmail.com>,
 "shuah@kernel.org" <shuah@kernel.org>, "i@zenithal.me" <i@zenithal.me>
References: <DM5PR0102MB347711AF2F5655852AC60BEB80DBA@DM5PR0102MB3477.prod.exchangelabs.com>
 <2023102134-reflux-saddling-c750@gregkh>
 <DM5PR0102MB3477B594C9D018BC884DF3E4804C2@DM5PR0102MB3477.prod.exchangelabs.com>
 <2024021605-disloyal-overlying-ed56@gregkh>
 <DM5PR0102MB3477B499A8A3292D6BFFBE80804C2@DM5PR0102MB3477.prod.exchangelabs.com>
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <DM5PR0102MB3477B499A8A3292D6BFFBE80804C2@DM5PR0102MB3477.prod.exchangelabs.com>

This is a multi-part message in MIME format.
--------------t9GZuSDJlD9zIs0PpIOh3i30
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 16.02.24 18:58, zdi-disclosures@trendmicro.com wrote:
> Hi Greg,
> Thanks for the update :)

Hi,

does this do the job?

	Regards
		Oliver

--------------t9GZuSDJlD9zIs0PpIOh3i30
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-usbip-get-new-count-before-dropping-the-old.patch"
Content-Disposition: attachment;
 filename="0001-usbip-get-new-count-before-dropping-the-old.patch"
Content-Transfer-Encoding: base64

RnJvbSBmN2VkODIxZGExM2ZhZTZjODBkNjVmOWMwZGJhNGM5MjY5NzA1MzVlIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBPbGl2ZXIgTmV1a3VtIDxvbmV1a3VtQHN1c2UuY29t
PgpEYXRlOiBNb24sIDE5IEZlYiAyMDI0IDEzOjIxOjQ0ICswMTAwClN1YmplY3Q6IFtQQVRD
SF0gdXNiaXA6IGdldCBuZXcgY291bnQgYmVmb3JlIGRyb3BwaW5nIHRoZSBvbGQKClRob3Nl
IGRldmljZXMgY2FuIGJlIGlkZW50aWNhbC4gSW4gdGhhdCBjYXNlIGRyb3BwaW5nCnRoZSBv
bGQgcmVmZXJlbmNlIGZpcnN0IGxlYWRzIHRvIGEgdXNlIGFmdGVyIGZyZWUuCgpTaWduZWQt
b2ZmLWJ5OiBPbGl2ZXIgTmV1a3VtIDxvbmV1a3VtQHN1c2UuY29tPgotLS0KIGRyaXZlcnMv
dXNiL3VzYmlwL3ZoY2lfaGNkLmMgfCAzICsrLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL3VzYmlw
L3ZoY2lfaGNkLmMgYi9kcml2ZXJzL3VzYi91c2JpcC92aGNpX2hjZC5jCmluZGV4IDgyNjUw
YzExZTQ1MS4uNzZmNjI5MDMxMDA1IDEwMDY0NAotLS0gYS9kcml2ZXJzL3VzYi91c2JpcC92
aGNpX2hjZC5jCisrKyBiL2RyaXZlcnMvdXNiL3VzYmlwL3ZoY2lfaGNkLmMKQEAgLTc1Nywx
MiArNzU3LDEzIEBAIHN0YXRpYyBpbnQgdmhjaV91cmJfZW5xdWV1ZShzdHJ1Y3QgdXNiX2hj
ZCAqaGNkLCBzdHJ1Y3QgdXJiICp1cmIsIGdmcF90IG1lbV9mbGFnCiAKIAkJc3dpdGNoIChj
dHJscmVxLT5iUmVxdWVzdCkgewogCQljYXNlIFVTQl9SRVFfU0VUX0FERFJFU1M6CisJCQlz
dHJ1Y3QgdXNiX2RldmljZSAqdWQgPSB2ZGV2LT51ZGV2OwogCQkJLyogc2V0X2FkZHJlc3Mg
bWF5IGNvbWUgd2hlbiBhIGRldmljZSBpcyByZXNldCAqLwogCQkJZGV2X2luZm8oZGV2LCAi
U2V0QWRkcmVzcyBSZXF1ZXN0ICglZCkgdG8gcG9ydCAlZFxuIiwKIAkJCQkgY3RybHJlcS0+
d1ZhbHVlLCB2ZGV2LT5yaHBvcnQpOwogCi0JCQl1c2JfcHV0X2Rldih2ZGV2LT51ZGV2KTsK
IAkJCXZkZXYtPnVkZXYgPSB1c2JfZ2V0X2Rldih1cmItPmRldik7CisJCQl1c2JfcHV0X2Rl
dih1ZCk7CiAKIAkJCXNwaW5fbG9jaygmdmRldi0+dWQubG9jayk7CiAJCQl2ZGV2LT51ZC5z
dGF0dXMgPSBWREVWX1NUX1VTRUQ7Ci0tIAoyLjQzLjAKCg==

--------------t9GZuSDJlD9zIs0PpIOh3i30--

