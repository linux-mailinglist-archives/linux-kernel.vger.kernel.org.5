Return-Path: <linux-kernel+bounces-164342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBAF8B7C8E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4789F283F45
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC927176FB2;
	Tue, 30 Apr 2024 16:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="UNpWYu4Q"
Received: from mx0b-00823401.pphosted.com (mx0b-00823401.pphosted.com [148.163.152.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA14176FA1;
	Tue, 30 Apr 2024 16:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714493673; cv=none; b=QIpYZ3t2pjMyvupxyoBQQL5QUY/J/rmfe16ogIl37YxC4xFUKE3/rnYghvsqVNS61m3+T9x8x3RaBHTeeuH5nWlJR0Ci+qkum6+CIj3+EfceoJmtEF4jtB2KKSh6ALN41wwdor76IJbVTkH+ymeyRS896Y5J241U4JGFd7Dp+P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714493673; c=relaxed/simple;
	bh=jDRp8ZKc/ZI1h5C/iego2Wm5Y1Gpx7UAFijBltFFKrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MByyt9yYabsWDosRGQtOcSxpkaJxvqs5KRmL64iWkCNYt6FLkAFzLGzFiHT02LIrl3WcJP1d+KEctCBDRqIDFag8y6XxenKiUgsuNvfNE7Fg3xXPEmO3kBdu7OaRQJpFaSmg5Fache9BSd05gyca7McmOd4OEH+dGMlTBqFCBF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com; spf=pass smtp.mailfrom=motorola.com; dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b=UNpWYu4Q; arc=none smtp.client-ip=148.163.152.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355089.ppops.net [127.0.0.1])
	by mx0b-00823401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43U9WwMa008922;
	Tue, 30 Apr 2024 16:13:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=DKIM202306; bh=ZdSmt5zDcC89PDnHHr/a
	KSAriMvIJvGcEbgYXmtQydc=; b=UNpWYu4QnWd5olOAPBicmnEue67SUVLkf0ka
	hej0B9Lznq7inaCpw5pfRUbofR2BWXhYyg2QedyqvVXQkVpwaTaO1h3RkfA2BfXu
	+QNm9IT71yq+i3cpgluvvK9ADvbt8v1ilBSv9pvlL3Pyg9GNm0d4avZPpI66vVDV
	UJ/njm5gdvSKvRH+2kPvRYBEmiYntIYtw95xtt7TmYPKCGAZQI3tfTQ+SoUijpDg
	js8vJOUZAY+hkh7Oq/iu6q7dOkuOTMiQk7y9oxc+FkSIbZCUAZhLlw91lZWZ/pbF
	sBdABbaTaollpL2YbS4Z2pMRa3sSY8xeMnExwlsD8EvblqdEFg==
Received: from va32lpfpp03.lenovo.com ([104.232.228.23])
	by mx0b-00823401.pphosted.com (PPS) with ESMTPS id 3xtqvf9ftp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 16:13:59 +0000 (GMT)
Received: from ilclmmrp02.lenovo.com (ilclmmrp02.mot.com [100.65.83.26])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by va32lpfpp03.lenovo.com (Postfix) with ESMTPS id 4VTQHV5Msyz51Q9x;
	Tue, 30 Apr 2024 16:13:58 +0000 (UTC)
Received: from ilclasset02 (ilclasset02.mot.com [100.64.49.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mbland)
	by ilclmmrp02.lenovo.com (Postfix) with ESMTPSA id 4VTQHV3n4Wz3p6jp;
	Tue, 30 Apr 2024 16:13:58 +0000 (UTC)
Date: Tue, 30 Apr 2024 11:13:57 -0500
From: Maxwell Bland <mbland@motorola.com>
To: linux-mm@kvack.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Maxwell Bland <mbland@motorola.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ptdump: add intermediate directory support
Message-ID: <36faail77z762b6tnldswwe4yxbedx3gwi4n5reldwbkovb5kb@m5gz4a3yqxav>
References: <fik5ys53dbkpkl22o4s7sw7cxi6dqjcpm2f3kno5tyms73jm5y@buo4jsktsnrt>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fik5ys53dbkpkl22o4s7sw7cxi6dqjcpm2f3kno5tyms73jm5y@buo4jsktsnrt>
X-Proofpoint-GUID: ordh2vEURrLkI_4r9779MV_wQqbPnjan
X-Proofpoint-ORIG-GUID: ordh2vEURrLkI_4r9779MV_wQqbPnjan
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_09,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 adultscore=0 mlxscore=0 impostorscore=0 phishscore=0
 suspectscore=0 clxscore=1015 mlxlogscore=974 lowpriorityscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300115

On Tue, Apr 30, 2024 at 11:05:01AM GMT, Maxwell Bland wrote:
> v3:
>   - Added tabulation to delineate entries
>   - Fixed formatting issues with mailer and rebased to mm/linus
> 
> v2:
>   - Rebased onto linux-next/akpm (the incorrect branch)

Note that I am referring to
20240423121820.874441838-1-mbland@motorola.com
as the v1/v2 here.

The v1/v2 mailer malformatting will hopefully never happen again. I have
tested mailing this patch to myself and have confirmed it cleanly merges
to mm/linus. I ended up needing to compile mutt from scratch. ):

Also, I made these changes in order to compliment testing
20240220203256.31153-1-mbland@motorola.com
and
20240423095843.446565600-1-mbland@motorola.com
and figured they might be useful to include/merge before attempting to
merge the above more impactful changes.

