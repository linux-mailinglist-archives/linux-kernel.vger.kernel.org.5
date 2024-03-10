Return-Path: <linux-kernel+bounces-98360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0678E877922
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 00:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 381BA1C20BAA
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 23:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028DB3FBAA;
	Sun, 10 Mar 2024 23:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FdFFelsP"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BCF3FB8F;
	Sun, 10 Mar 2024 23:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710111893; cv=none; b=lZiauyz0t59gF4FPOr4X1A2PvKbxoBhWOv1OEQGxhSXAymXTNRQibd58xUvXUkjXD5njEoOfMq4F+y9suguvrkdVXr1PrBDzw0IykRb/NpXX7F2lw8pah1Gj2fPSFI8OVjdOqfzSefoPDXN1k8j8SHJjz0WhGu2hZhONjqWuTgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710111893; c=relaxed/simple;
	bh=3deoi1dz/9rrMHhHol7hX3O1aGEGYFwkoUwtYX7HpsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XMl0vTth+lRxuvDmXMiSNhtnXhSYC0GezuL5gCxrrGNNfjvGXKKESijxuR/UDgw79YjPm4uE4MuGMvCNhz5XAevgnrQuj3tAsdIycRtMW9IUr/XStpU4VhqVtUyC+4aWyMplZIAAkC8U3abSHUmRUlmBZpzxDPOuLxMbTMZvFzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FdFFelsP; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42ALJuM1022407;
	Sun, 10 Mar 2024 23:04:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=FKQZhHRbg04CeOY97HhsLHc+b14tooDJProa0dZcdi0=;
 b=FdFFelsPvYJNUz9MIWCWblkI5PetwBAfuHvJHudLpFeiCbepSmNM5iDThCu0BZULsiPj
 GGbCapbyKXa7ZluNHF1dQQL7+Ump2dB5wXLp+gJyk2ZPCTEhSqNErL3fX0wTnJtaVWvg
 dtxaCpoBxtPNAuhu+iPpRo0dFvi0jCUWZj3ueW0VYnmAKct9FrB4caimnpvGD6mHHnx+
 5fgVsJ7zTHKMG1U06aZqXYvifIgnLu1vqZKntlmpK/rbA2i+bYdQhy2laMBNWSFvje9w
 VEKP+han/mNgF0ra2H6Q3HbWaEHmLibPEhdIFDyQBPK9Ra3kWziRliDnYsuCkJEbP45+ ww== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrepcsutf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 10 Mar 2024 23:04:31 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42AJ0OX6004954;
	Sun, 10 Mar 2024 23:04:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wre750ne1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 10 Mar 2024 23:04:30 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42AN4TSA006839;
	Sun, 10 Mar 2024 23:04:29 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3wre750ndq-1;
	Sun, 10 Mar 2024 23:04:29 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
        Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
        Arnd Bergmann <arnd@kernel.org>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        James Bottomley <JBottomley@Parallels.com>,
        Krishna Gudipati <kgudipat@brocade.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 1/2] [v2] scsi: bfa: fix function pointer type mismatch for hcb_qe->cbfn
Date: Sun, 10 Mar 2024 19:04:17 -0400
Message-ID: <171010474751.3838281.8712464657263840713.b4-ty@oracle.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240222124433.2046570-1-arnd@kernel.org>
References: <20240222124433.2046570-1-arnd@kernel.org>
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
 definitions=2024-03-10_14,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403100187
X-Proofpoint-ORIG-GUID: oHMrMV1ectl8yYs5raoshDwvzWqfMMkn
X-Proofpoint-GUID: oHMrMV1ectl8yYs5raoshDwvzWqfMMkn

On Thu, 22 Feb 2024 13:44:06 +0100, Arnd Bergmann wrote:

> Some callback functions used here take a boolean argument, others
> take a status argument. This breaks KCFI type checking, so clang
> now warns about the function pointer cast:
> 
> drivers/scsi/bfa/bfad_bsg.c:2138:29: error: cast from 'void (*)(void *, enum bfa_status)' to 'bfa_cb_cbfn_t' (aka 'void (*)(void *, enum bfa_boolean)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]
> 
> Assuming the code is actually correct here and the callers always match
> the argument types of the callee, rework this to replace the explicit
> cast with a union of the two pointer types. This does not change the
> behavior of the code, so if something is actually broken here, a larger
> rework may be necessary.
> 
> [...]

Applied to 6.9/scsi-queue, thanks!

[1/2] scsi: bfa: fix function pointer type mismatch for hcb_qe->cbfn
      https://git.kernel.org/mkp/scsi/c/b69600231f75
[2/2] scsi: bfa: fix function pointer type mismatch for state machines
      https://git.kernel.org/mkp/scsi/c/37126399da15

-- 
Martin K. Petersen	Oracle Linux Engineering

