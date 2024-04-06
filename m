Return-Path: <linux-kernel+bounces-133763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF76C89A84F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 03:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85CB71F22439
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 01:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B98171C4;
	Sat,  6 Apr 2024 01:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T6PPfuHf"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82532125DC;
	Sat,  6 Apr 2024 01:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712368773; cv=none; b=UmGgOCSbsmjSwYasqCRdjMOwXhgBdNgYZOZJnYBaLjpyyIZoand2s0PGWSV85UwA4C+2MiuN9GLsGxqzU5/9Giw8IwSeLemHeu7nC4xAirHdje6SQ8tGD7BEeNEqAD254zDTU3SL97ILFruuLI0hKeMJIMg3zSLvte1+t1YpqQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712368773; c=relaxed/simple;
	bh=Z7VCcSKqAqefSjmsmcNaIRDZm19lO+XBUKel61A0WCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QIgFQxe6UyQe8tAvtOdm62BIwTtAONmK0TJcz5ySKj0lD1aw+ds4NJWzBnmypvturarQ1CpuYuviEO/ozHI2RQHgrCh8Sr993+86Oh63zBUkvh56XvIhLya8wVlKvgFu+4n+JZVbzNKY+NuZxK/p5FFrOPXD+vkrMwBjSnyJbx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T6PPfuHf; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4361iHBc024192;
	Sat, 6 Apr 2024 01:58:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=JrIVJnIlZ2irb8MalvkujLN8fFv5qjkoRcrej4VnBOg=;
 b=T6PPfuHfv4wO2CsQJIDJyrUJ9U2FuDP/9WpbDqwyrZUZybylCYcJk6LXZS5oud+/xsec
 oCrw1jMQ9WC3TwOovHJ4fx8FWR4TVcrLWaP5WhBpWDU66L4B0YRatiSYsEEf9d0AZ1yz
 n7kQQSQEgSbs+LHSrC44XWYJGd1w4wG9314OoT4n6WS/C4HNSyIm6/dtc5EcYgIEuHYt
 Hp++3KDhOy0oSxXy4+/KwCEx1Ymw59+ABw6UFPas6zFlULcxQN2NJW885CMncAQQKZtO
 6BZG8AUajMswFVssE9uCvrbIazeIkUp/qNI71AeJxOO3fHwF8QX0z1Z7iTZ5D/6SaYu0 Ww== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xaw02006w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 06 Apr 2024 01:58:56 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4361XVQd032535;
	Sat, 6 Apr 2024 01:58:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xavu3rer6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 06 Apr 2024 01:58:55 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4361wqvb000912;
	Sat, 6 Apr 2024 01:58:54 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3xavu3repx-3;
	Sat, 06 Apr 2024 01:58:54 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: Quinn Tran <qutran@marvell.com>, Dan Carpenter <dan.carpenter@linaro.org>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        Larry Wisneski <Larry.Wisneski@marvell.com>,
        Duane Grigsby <duane.grigsby@marvell.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] scsi: qla2xxx: Fix off by one in qla_edif_app_getstats()
Date: Fri,  5 Apr 2024 21:58:33 -0400
Message-ID: <171236847476.2627662.10581186530455800083.b4-ty@oracle.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <5c125b2f-92dd-412b-9b6f-fc3a3207bd60@moroto.mountain>
References: <5c125b2f-92dd-412b-9b6f-fc3a3207bd60@moroto.mountain>
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
 definitions=2024-04-06_01,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 bulkscore=0 mlxlogscore=635 mlxscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404060013
X-Proofpoint-ORIG-GUID: 6Q3V5RB-qL-JeDFNg1it--MnBuCI3wtO
X-Proofpoint-GUID: 6Q3V5RB-qL-JeDFNg1it--MnBuCI3wtO

On Tue, 02 Apr 2024 12:56:54 +0300, Dan Carpenter wrote:

> The app_reply->elem[] array is allocated earlier in this function and it
> has app_req.num_ports elements.  Thus this > comparison needs to be >=
> to prevent memory corruption.
> 
> 

Applied to 6.9/scsi-fixes, thanks!

[1/1] scsi: qla2xxx: Fix off by one in qla_edif_app_getstats()
      https://git.kernel.org/mkp/scsi/c/4406e4176f47

-- 
Martin K. Petersen	Oracle Linux Engineering

