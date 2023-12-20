Return-Path: <linux-kernel+bounces-7049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3E881A0FC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65BED2815FB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C9538F9A;
	Wed, 20 Dec 2023 14:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="G0hcqa/f"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2985638DDC;
	Wed, 20 Dec 2023 14:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BKDrT0d024048;
	Wed, 20 Dec 2023 14:19:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=TkYb/4DF5JuuftB1DBBCZGJSXJ4lwaNv+h8XVPO0QIY=;
 b=G0hcqa/fSCqNhm/57B/32HWVwyiMZubPlJLc7sEtSoPRn38n/yNqs3C+en7FgGj4b3b8
 ygREYN3iUkGZTuHocZ+Zaq+fV1lqLXxufVXMPki4ngqQ+wOJs9tdHAy/EoLfER7+sDuI
 crY36iIBWqvhCBsSeGXJgkRYKBtKxMWWVaWw3Lv1y88WdK9YqXQ0EhQeRyr+VttJz9DT
 c6VEHUarWG6D8Q0z4tMLxZXUPnQFtBI1JyH68cCd5BXyqdSG48nlearO+q/I79O8TZdU
 1SznemnWP7zrKkzflz9usPBLBStOPVxBEd+sGIqt/WtuPXdqB5ZgE1qSB9sjMLx0N9uE EQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v41hx0wv9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 14:19:23 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BKDsM3K027005;
	Wed, 20 Dec 2023 14:19:22 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v41hx0wuq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 14:19:22 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BKDLP18004856;
	Wed, 20 Dec 2023 14:19:22 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3v1pkyxyjx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 14:19:22 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BKEJLRo38404718
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Dec 2023 14:19:21 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 905115804B;
	Wed, 20 Dec 2023 14:19:21 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D498A58059;
	Wed, 20 Dec 2023 14:19:20 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.116.58])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 Dec 2023 14:19:20 +0000 (GMT)
Message-ID: <d7826ddcd6db86773b57ffe603df9b18d95a5252.camel@linux.ibm.com>
Subject: Re: [PATCH v2 0/3] evm: disable EVM on overlayfs
From: Mimi Zohar <zohar@linux.ibm.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-unionfs@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Seth
 Forshee <sforshee@kernel.org>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>
Date: Wed, 20 Dec 2023 09:19:20 -0500
In-Reply-To: <20231220-komprimieren-kooperativ-cdb5e8803ce0@brauner>
References: <20231219175206.12342-1-zohar@linux.ibm.com>
	 <20231220-komprimieren-kooperativ-cdb5e8803ce0@brauner>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yc77YjAOFM9d7ZCNE54es3Cm62roTOBW
X-Proofpoint-GUID: RQVNBkl7O8JO40O_WJWtFu95bjBJn_M4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-20_07,2023-12-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=780 bulkscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312200102

On Wed, 2023-12-20 at 13:35 +0100, Christian Brauner wrote:
> On Tue, Dec 19, 2023 at 12:52:03PM -0500, Mimi Zohar wrote:
> > EVM verifies the existing 'security.evm' value, before allowing it
> > to be updated.  The EVM HMAC and the original file signatures contain
> > filesystem specific metadata (e.g. i_ino, i_generation and s_uuid).
> > 
> > This poses a challenge when transitioning from the lower backing file
> > to the upper backing file.
> > 
> > Until a complete solution is developed, disable EVM on overlayfs.
> > 
> > Changelog v2:
> > Addressed Amir's comments:
> > - Simplified security_inode_copy_up_xattr() return.
> > - Identified filesystems that don't support EVM based on a new SB_I flag.
> 
> We're wasting a flag for a single filesystem but we do have enough of
> them left so I think this is ok,

Thanks, Christian.

> 
> Reviewed-by: Christian Brauner <brauner@kernel.org>


