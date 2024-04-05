Return-Path: <linux-kernel+bounces-132299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CAC8992B4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 02:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 793D41C21DB1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 00:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7170479CE;
	Fri,  5 Apr 2024 00:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="cdHf16/q"
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1C063CF
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 00:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712278590; cv=none; b=VR8NKRshwe0zuBZgLK67w+mcIV4H6MQUFJj8RKXFCzx/RaGVRepWPS2omgdJtn0gm53xrh3JhW6M7awzm/UVO9+NJXogvSoufltRYg/I5opq6UYDrev5yfzsI8GtvpyXSau7Kw2J8D0mEpfTBXK/VYEPNO/HMf4ymTbjkVr6OPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712278590; c=relaxed/simple;
	bh=d2QTWIhRLklitVHu2Oh2ADoKsDCo73AL3mTjsvV9E/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=io6fJlgToVl2TfueO4P82UepeC6z8aBLWGfPoTmQo4PHpGP/XlrrvnUS0am+gCzIIfTD9XHEvvqJr2a5GHtzSoIfKodt0w3dwfx6NBRiVkFU7F9Szr1BN97Sao0ZQogoAmUlAAMVDwRU3UzvZc3n5xvYR96bbpjbD5ZplIQaNfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=cdHf16/q; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6003a.ext.cloudfilter.net ([10.0.30.151])
	by cmsmtp with ESMTPS
	id sPn3rQsV8PM1hsXsUrKVTc; Fri, 05 Apr 2024 00:56:22 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id sXsTr0OU5d4oesXsUrbilE; Fri, 05 Apr 2024 00:56:22 +0000
X-Authority-Analysis: v=2.4 cv=aYKqngot c=1 sm=1 tr=0 ts=660f4c36
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=4VnFru8p6tJF5H7f7NqpSA==:17
 a=IkcTkHD0fZMA:10 a=raytVjVEu-sA:10 a=wYkD_t78qR0A:10
 a=LXjggWPQbdiaP0PAf5wA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dMo9+qC7khZWpqLef3na1COCT0ZhcpCRolgSVK3QXHY=; b=cdHf16/qhI8JTbGUioMN8W8jaW
	TvWWbeDUNvI3jTbCp3P2ae2UdUHz78etxP0SVcLI+RTpVsBZGEceCq2O4WbiTBJWK9LjcD0HBTy5c
	NCCtcQK38GdT5ArT4AYsL/44ilwrMrw9O8qFqDXWgxMg+Romwx75T9MTOgDO15EjlyJuXEHU24deO
	+R09I1L1c5hehvYvogtOY82yP5XAemE06FC8fLoO5btjE6L1Z/BeVrGcJSPQAzrqx41HnY5iH0k/k
	40K3GeOl1mtqvcSNChRFr0UNtvLPP9bgbISuXJaVdoLy0c7ktrWr7SWBYV0FEEo941Av+pfxFThuW
	ImhVp4PA==;
Received: from [187.184.159.122] (port=19621 helo=[192.168.0.27])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rsXsR-004J8b-2u;
	Thu, 04 Apr 2024 19:56:20 -0500
Message-ID: <d6c9a04e-66e3-4010-9a35-fb5efc3f1af0@embeddedor.com>
Date: Thu, 4 Apr 2024 18:56:15 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5][next] integrity: Avoid -Wflex-array-member-not-at-end
 warnings
To: Mimi Zohar <zohar@linux.ibm.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Roberto Sassu <roberto.sassu@huawei.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <Zg7AoOh7CL5ZD/fe@neat>
 <27d36ec8e0539c5d6bc760de7305299a2142f9f1.camel@linux.ibm.com>
 <b3956fd36307d33ebbf0e4633e0d2389860cf720.camel@linux.ibm.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <b3956fd36307d33ebbf0e4633e0d2389860cf720.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.184.159.122
X-Source-L: No
X-Exim-ID: 1rsXsR-004J8b-2u
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.27]) [187.184.159.122]:19621
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfPMTxLRXdLC2IPQyHLnf3C1ljt1qI5P7GBuAE0SsmhY3injJyd4UgP94GJ9v8p9MpYsURKc+AWyOucg5EVepb7ueEm31NU4T74374F4r1oxKH7LwfZex
 t8FJjAkw4eTJg8SLLQMZiunrva0yDJ66ilIiLTngvI26TNh2GXqrIRnIsE4esmtg1cukdoYiCYRGPucNQTC9dBRCAmNm6/sxdXOSunSYTWJ9Pe3rCvpJqFHT


> "checkpatch.pl --strict" complains "CHECK: Alignment should match open
> parenthesis".  I'll queue the patch, but how about teaching checkpatch.pl to
> ignore __struct_group()?

I think this would do it:

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 9c4c4a61bc83..e229b97f17f6 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3958,7 +3958,7 @@ sub process {
                         my $rest = $2;

                         my $pos = pos_last_openparen($rest);
-                       if ($pos >= 0) {
+                       if ($pos >= 0 && $rest !~ /(__)?struct_group(_(tagged|attr))?(\()/) {
                                 $line =~ /^(\+| )([ \t]*)/;
                                 my $newindent = $2;

I'll send a proper patch. Thanks for the suggestion, Mimi.

--
Gustavo

