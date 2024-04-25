Return-Path: <linux-kernel+bounces-157922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 747208B189D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 03:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E9342851A4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 01:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF33014F78;
	Thu, 25 Apr 2024 01:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G0yQHlKk"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936FB10A22;
	Thu, 25 Apr 2024 01:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714010247; cv=none; b=s6xbdH5S4vM5dGc6VMpiH1GOEKAAUTYVU0uyZK2R0l19TDXpLI6wUTubMf4xURRwltBFq9x56jlWwW6kEOjUpbJDKq/gtOqZzyMbdwtALuO0FkIJ0OWiUCE+IZK7avvDVhU5hTXam75crz9mIXdfVthjYZ/p4OHgWoDrYE0T3aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714010247; c=relaxed/simple;
	bh=GFwBey0ELYBbyHcOlUzpa4YU6RHi6rcY3S+oRp1aqRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pDbg2jApQx6ZwQ0MJOIODReDbGKLsVmPu+hi2lvsjahV0u5T9MoGArgHSrbH0H2Rku+ij+mhIEeHtJB/Vgr0eGyI3IabQgOpzX6aWOXIwChAoWEPv+z7ld0GDqbHI68/F00HT9wE2f54ssF1YsWifK7h493jfrfjdU2Ma3ekHbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=G0yQHlKk; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43P0jnsR002216;
	Thu, 25 Apr 2024 01:57:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=Nixv7R5PyqvQwZ7kQgX2W3JO52ycqr82/Ox7/vasezA=;
 b=G0yQHlKkhIgrQqR8/Ei4A/GT8ZTJ6qpF/roaitckN786+wiO0LxR28+nUmsNV14GyvTV
 75UOmhlySSqAByInx8H39vtkQ1T+LitR7qw/6lenE/7hn7hNCd7625qcj9KRYzAD27rz
 2blNpnTssiO3Rdjfn3EdrUKymDrOuNTxHBo4GKGxHLXd/c9L6fJQ3TBYq7TYk5yJlxtB
 OwrKNCgxqDkyJaxS5Ndx7On+c+rRKDmn+ZL8qvufDJOYKZ5+Fei50gMfYzEVCdtXYUkX
 5weyrAm+O/mIDlYguvLYtpPd5G4HIaTsoYGyGDe1M7nrRhLdKV03ES6Vg2t7HNRHMoD/ Fg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm4g4hhfg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2024 01:57:13 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43P03cIV025274;
	Thu, 25 Apr 2024 01:57:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xm45fyh1p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2024 01:57:13 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43P1vCuN009586;
	Thu, 25 Apr 2024 01:57:12 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3xm45fyh1b-2;
	Thu, 25 Apr 2024 01:57:12 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: "James E . J . Bottomley" <jejb@linux.ibm.com>,
        Avri Altman <avri.altman@wdc.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Bart Van Assche <bvanassche@acm.org>, Bean Huo <beanhuo@micron.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/1] Remove support for legacy UFS
Date: Wed, 24 Apr 2024 21:57:01 -0400
Message-ID: <171362345479.571343.1760746828189584636.b4-ty@oracle.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240410183720.908-1-avri.altman@wdc.com>
References: <20240410183720.908-1-avri.altman@wdc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_01,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=858
 mlxscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404250012
X-Proofpoint-GUID: LegbeAIOl7VUF6cmdT60jeDND5ujceKC
X-Proofpoint-ORIG-GUID: LegbeAIOl7VUF6cmdT60jeDND5ujceKC

On Wed, 10 Apr 2024 21:37:18 +0300, Avri Altman wrote:

> UFS1.0 and UFS1.1, published in the early 2010s, were more of a proof of
> concept rather than a mature functional spec. Toshiba was the only
> device manufacturer with the most accomplished phy team to come up with
> a small UFS1.0 device. Alas, there were no commercial platforms it can
> be paired with. Even UFS2.0 that was published in 2013, didn't really
> make it to the market: too moot to take effect. It's not until UFS2.1
> that was published in 2016, were a myriad of devices and platforms
> flooded the market. Designated to mobile devices, dictates a rapid short
> lives for those platforms. Hence, we can safely remove those pre-UFS2.0
> pieces of code.
> 
> [...]

Applied to 6.10/scsi-queue, thanks!

[1/1] scsi: ufs: Remove support for old UFSHCI versions
      https://git.kernel.org/mkp/scsi/c/a33a502d50fd

-- 
Martin K. Petersen	Oracle Linux Engineering

