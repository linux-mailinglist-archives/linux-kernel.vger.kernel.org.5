Return-Path: <linux-kernel+bounces-155807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2C08AF767
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 21:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 365FFB22554
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E66D1420C9;
	Tue, 23 Apr 2024 19:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="Iin+LlOm"
Received: from mx0b-00823401.pphosted.com (mx0b-00823401.pphosted.com [148.163.152.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277881411E2;
	Tue, 23 Apr 2024 19:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713900728; cv=none; b=Y/Eok9mWmCFra0y2rNs1YM5F5nSYe7l4Y0gIvQ/GAA1Z5jivkxEZPmXfTdngL3DA1K+zUqpEruA2pLUixN6lDG6midlwUs9rOD9Wl7tl9+AZ5S5hI3x9oNHgrIW2euGGnOl5pHke4VEdL9SucM0vaXF1r1GLAGULrNvL1qoS9JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713900728; c=relaxed/simple;
	bh=EgUh4iK6CYsYpcMCA5bOtog4JrRakvo89I69ZahpA3M=;
	h=Message-Id:To:Cc:From:Date:Subject:In-Reply-To; b=cFupCDNcvoy5dXN37Ual6qldpDI6xuDSV2fBwF8bYbm7GOErAANSl1qVBeE/TLW5G4dI/eWoyF98M9ETRsavfEe7xuJtHALnSGSLr+oB4sgT1XxznXkfDH7RSEJhqcUWMS30/GOMms7s48kAjhAIgXuneoHEBNIqoKzNiYuVA7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com; spf=pass smtp.mailfrom=motorola.com; dkim=fail (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b=Iin+LlOm reason="signature verification failed"; arc=none smtp.client-ip=148.163.152.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355090.ppops.net [127.0.0.1])
	by m0355090.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 43NE715Z029344;
	Tue, 23 Apr 2024 19:31:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	message-id:to:cc:from:date:subject:in-reply-to; s=DKIM202306;
	 bh=tW3m6nSWVatsjcP9+T7sFcFeJDIlOFZMeAMcHc2ZWHs=; b=Iin+LlOmE5gp
	xj98fzurwf8QQCR9qiNuT3MmHuA16WIXO0SVX9ikQfeeIVupywSIFtxB2pN4t+sW
	KTCt9tmFm4XnpigImNHv1p6Wg8BfBBXfsT50l1lweiUanYzdZizjMqC8cyUmpnrm
	dCqiLS0fcfeZB55N1nn4jI+tbZ9zvOHqFuJQtXqyJT3TXiZgiB5gA4Nw7b+0gHuY
	HZLV28rEbaHRUIdEki/2PM+j1UwVLz8DVPqoF4W9QHrV16RTm8X7WYl97Qd5TMXw
	oUCBt4VRVO4G//4i52sfWeOg/k0XSFoxwZqVehLCjse1eau19hAf1pwQhFIFDpit
	GZaK0d0Zvg==
Received: from va32lpfpp02.lenovo.com ([104.232.228.22])
	by m0355090.ppops.net (PPS) with ESMTPS id 3xpefe8qty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 19:31:46 +0000 (GMT)
Received: from va32lmmrp01.lenovo.com (va32lmmrp01.mot.com [10.62.177.113])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by va32lpfpp02.lenovo.com (Postfix) with ESMTPS id 4VPC0y1xnSz4x2l5;
	Tue, 23 Apr 2024 19:31:46 +0000 (UTC)
Received: from ilclasset02.mot.com (ilclasset02.mot.com [100.64.49.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mbland)
	by va32lmmrp01.lenovo.com (Postfix) with ESMTPSA id 4VPC0y1pC2z2WV3m;
	Tue, 23 Apr 2024 19:31:46 +0000 (UTC)
Message-Id: <20240423142906.757347928-1-mbland@motorola.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Maxwell Bland <mbland@motorola.com>
	Jonathan Corbet" <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Will Deacon <will@kernel.org>, Maxwell Bland <mbland@motorola.com>,
        Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org
From: Maxwell Bland <mbland@motorola.com>
Date: Tue, 23 Apr 2024 14:29:06 -0500
Subject: [PATCH] ptdump: add non-leaf descriptor support
In-Reply-To: <20240423110435.c84aa2a0e4cb5a17fb1ab18d@linux-foundation.org>
X-Proofpoint-GUID: ICnA4gE9fTmQjpcC09vGvIMK_0KWtHso
X-Proofpoint-ORIG-GUID: ICnA4gE9fTmQjpcC09vGvIMK_0KWtHso
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-23_16,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 suspectscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=638
 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404230045
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Tue, 23 Apr 2024 11:04:35 -0700, Andrew Morton wrote:
> I was going to queue this while awaiting acks from arm people, but
> there's a large reject in Documentation/arch/arm64/ptdump.rst.  Please
> update to latest mainline?

ACK, thank you. I have rebased and submitted a revision at

20240423142307.495726312-1-mbland@motorola.com

Maxwell


