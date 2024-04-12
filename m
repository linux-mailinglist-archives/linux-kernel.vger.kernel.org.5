Return-Path: <linux-kernel+bounces-141800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EAB8A2393
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 04:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99C521F2319A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 02:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DD6DDD3;
	Fri, 12 Apr 2024 02:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="neCPsQwj"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B566E5C82;
	Fri, 12 Apr 2024 02:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712887537; cv=none; b=T3/fsqAvb7vIGw31HBiLBW2yxx4gH18YvbVdzMqrlmcvUlWGBFUEmnoRBMMJZvkdLxd7klz0OWgV2YobXYJ5SbcMH0IRg2ch8JgmB19FuyY8jBL6gwWQkZ/4O9kq6wlDyNByjwJy0UV1Y0ABI1/eFoC23UTcoHyXat2ZSXDk7Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712887537; c=relaxed/simple;
	bh=c67OWbc0FQwn+fMvJlFAOQFrgjy63fuJ8gGXtl7R7S4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oOfmkVoesG5xOiu2qjlQwU4OV5TH8Eoy2utEt+2LcoYRuS0K1UMS5NZXmhszYR22UzuGd0rFnkp1yUEuWYpkI3PdoOApT2ZUIt6HySVz3r2hc7JGU1DPdtMa/CXDcAqiOPTQ3kQ7pWSgVme9SpZiR7PbWsV7oEluqO1mA1kE9+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=neCPsQwj; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43C23LPH018709;
	Fri, 12 Apr 2024 02:05:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=7uZ/rgJQqzyuvS657CoVjjcNyR5sXMhiDdhOGD/hVWI=;
 b=neCPsQwjovX2Ucp3/t364V50zvopZXNBwT51cGgvQeftUZ1tp4zeIQDDz9YdWm9t8FIL
 VslbCJ4SDkqlK0701x8qA0Pa2Q8Tao5x6uI+pO+84ZWwwIuk5+oUD8WJLe11h0sR7iOB
 d7SszXjyx3nwKGL/h7zleO07Gt7LD6ec4y5yYVwzkj81D4f2JM09dZ3XupMGd6DqtzAE
 Fa08XxTq65KL+bJoZ5TeOpJ0vxbeE5Yisi5E5W2PMuskxaGcuQwq6nNcYw+XaFt/I+Ku
 /G/vTGJpXN+7Z/4vECW4fToHUX+3eScrC1ahztwmd91kthYuLul9/m6PPg/b/UVURVOG ww== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xed4jsnw3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2024 02:05:32 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43BNYGfd040814;
	Fri, 12 Apr 2024 02:05:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xavugmd2h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2024 02:05:31 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43C25UFi013100;
	Fri, 12 Apr 2024 02:05:31 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3xavugmd1x-2;
	Fri, 12 Apr 2024 02:05:31 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: Khalid Aziz <khalid@gonehiking.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org, Colin Ian King <colin.i.king@gmail.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] scsi: FlashPoint: remove redundant assignment to pointer currTar_Info
Date: Thu, 11 Apr 2024 22:05:09 -0400
Message-ID: <171288602649.3729249.13878957139312882015.b4-ty@oracle.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240406155029.2593439-1-colin.i.king@gmail.com>
References: <20240406155029.2593439-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_14,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404120014
X-Proofpoint-GUID: eZuPTbeejVmeNfOxjXAtFfQXicvWsAw1
X-Proofpoint-ORIG-GUID: eZuPTbeejVmeNfOxjXAtFfQXicvWsAw1

On Sat, 06 Apr 2024 16:50:29 +0100, Colin Ian King wrote:

> Pointer currTar_Info is being assigned a value that is never read, it
> is being re-assigned a few lines later in the start of a following
> do-while loop. The assignment is redundant and can be removed.
> 
> 

Applied to 6.10/scsi-queue, thanks!

[1/1] scsi: FlashPoint: remove redundant assignment to pointer currTar_Info
      https://git.kernel.org/mkp/scsi/c/9bd8e41358a5

-- 
Martin K. Petersen	Oracle Linux Engineering

