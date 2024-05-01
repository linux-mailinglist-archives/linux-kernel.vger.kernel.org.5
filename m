Return-Path: <linux-kernel+bounces-165708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DE68B9005
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 21:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C09541F22D71
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 19:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51EE816131A;
	Wed,  1 May 2024 19:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="axSUFWsB"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E83EAF6;
	Wed,  1 May 2024 19:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714591419; cv=none; b=SUga2qzeIiBOsscheiPcaMkJmI2CHGRP1FX2GqiqQpHXLZ8doi7qTgZRUkhlXlQ10ko88ag6o3WNCCtId8dzPEbuEp7swptOnQmxIbBDSC4mit1JfiWgtqXJ1auF6G8wclWhQ/7/4b54HW7k6ugZVloGGgvAVaUoI3iqWdL5bxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714591419; c=relaxed/simple;
	bh=WgZXapr0v/CdZ4lJn13J0ptgvUQhGg3IHPNnu6AmuXQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=XhhRd8no13IjEZfmyJsRAOYuALVJZHgsxLrmabURaQKynBab1JzZlXwYST+XVrfCKX7nwpSH4FZB4gdYEa0sdrFHgu7oh8b8kyOU2U4WqWxD6N5M70Ql4i8Nm2Ead2abSxJkCjLb4cFP29PQgyVk9Uev0RDhSP7CsxJTfHMuXZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=axSUFWsB; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714591395; x=1715196195; i=markus.elfring@web.de;
	bh=/OzIEN8wYE8/xcGiwbU+dTt00S833gZJ8vZlKH2nXNM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=axSUFWsB4NOlK4yB+jQ+wR92elH6D45V0USLzzge2n8VkSoRSNgwCr594VQ2cL1a
	 woA0rQaDX2c01haPFMjvY3QU9qjNTHvDC1v66KvtRGUT/PfAsIpNBryAebsgbeO54
	 /AxC7bq3AxTBOelxif+w4R0Gf81PWiCdfMJZ4vfCVIrP6Ew+S/Ek7SNIJaH7iLjoV
	 nMiBa+lpdmTHABtzlobPQo8dCWJHiKPD8M0WWEHKk0A//EBJyHHfACCnunKH9GstG
	 unzEPXXADB1sn60H5RKFsyMqVVOlpMXRtbM40mSSYWGVazdRjAfZlHo9/Xht5UFqc
	 r6J++oxUkWysNJBvnA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MSqXM-1sDu8b0cJy-00URfx; Wed, 01
 May 2024 21:23:15 +0200
Message-ID: <44d81ab4-e3e8-4552-ba0c-209adb53aa21@web.de>
Date: Wed, 1 May 2024 21:23:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Li Zhijian <lizhijian@fujitsu.com>, linux-cxl@vger.kernel.org,
 kernel-janitors@vger.kernel.org,
 Alison Schofield <alison.schofield@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Vishal Verma <vishal.l.verma@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240428030748.318985-1-lizhijian@fujitsu.com>
Subject: Re: [PATCH] cxl/region: Fix cxlr_pmem leaks
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240428030748.318985-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XEvMWRPs4OkmQfzTBKzTarEa4TnOG7EMBSHd7V4F8Fbt+EmT2R6
 lo5wtWziM0498hgVReKPl8EviA9vt1VdyPaIL1Vr9vvK1WqXmRR5gvlyDndncwod0JUrydn
 3KJ/3Ur0rFK/wKbgea1ZsPDQHqxca9IzxFwu475Pg94EdXVSIOtjRcKnBSQj9NP9WlkEiUC
 IpXWeNxGOE83J02oN1dEw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:19MG9NbR1DQ=;wLcBwn45VN2Z/0qpaigxH8Rs44Y
 AHD83VXPZJnK9DW/AE1HWPxEbaGEERu/pHKJOMjIlUPoLFJOFhHJIuJEiQA0SIeSn5nMk1Dvk
 gVpycZkOX+u8El+0Egp5t25jSBu3dVN0EyvH3h4FJf1JbwL4f68Y3BPD04ewS745x1eEgI5pu
 +NQVHVA4NYORMcR+E1iwy4XpA0mqNo2dpvA7+142/a1pSQpfjN0k3bwYJPVEMfvfXUa5QXP9N
 8dA21Uh2Bc+w3Wqg7La1Ng+OfwOiNCGpAqIKqs8wMceFI0Iadmtl6t3xP1ffWhoKOwBKG1Uwv
 RCIYIp5Kxzq3ba8bFJ6rgTNvf8adqMnACVIT/LaSbbFkFvWwDeDSt2cYH+DKTHUKXzR40OjV/
 qSHKPjV7JW6oCjmgb6um0bkbWyo3M5ZLS0gJP2O8nPBFpR3eo2/9xGuf/N/avhLRja7r+Nw3k
 CH/0tEasuQlRBuKkViOc957H400HcLNfsy1AEWZ8ySHFaiDVlVOeM/fSP/mI/DroQVCSGr5zA
 2I7hZ43LgtqMgDYpP3uq+RDv0YmgBwVo4fb8/nnM3MjQXgZFYgvz5KluMFAkWBHfReXQgC5bL
 EAF2hq22XvtEuJP3j57AE5e1O9H3wixt753Hz6bEhK11FV0hlsNlkJWiHVhnHWPrargpA3D1W
 0xm1xx774jxjERjk1Td15iMdssDDCyNRvKQqiUdIAFHjUlYbNWzHXQSkUNj2A4tmrgV8OYEV2
 dM7eoNu5u+9WDq/SpkWt0hCAxAB6rNMW9dcCpzx1gjLIujZtgIMs+0C9yZyuNfIA4dAJ1DjDs
 nNL3Bxhl/8wgx31NW1lfwHP9oGD8deNLusoyRSWZfDDpI=

> Before this error path, cxlr_pmem pointed to a kzalloc() memory, free
> it to avoid this memory leaking.

Can the following wording be a bit nicer?

   The local variable =E2=80=9Ccxlr_pmem=E2=80=9D referred to dynamically =
allocated memory.
   Free it in one error case before it is reset to an error pointer.


Would the summary phrase =E2=80=9CFix a memory leak in cxl_pmem_region_all=
oc()=E2=80=9D
be more appropriate here?

Regards,
Markus

