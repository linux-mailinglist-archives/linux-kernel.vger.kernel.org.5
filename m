Return-Path: <linux-kernel+bounces-13710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8BF820B7B
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 15:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAACB281E78
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 14:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12247611B;
	Sun, 31 Dec 2023 14:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="I5Rsre8W"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4408C63A7;
	Sun, 31 Dec 2023 14:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BV8QA1Z003121;
	Sun, 31 Dec 2023 14:08:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=/uM23a1DykmVUSnyJhKoNd/pLzJUVQGzc8LClp1i+c4=;
 b=I5Rsre8WTcCRXkQ3neHKlQoHtyml0m9oQc25vVZI9ObgJHsywbXvaE6E31wPWK043gPp
 tYgdPzOs7p7iyJQnte+0HK/iDw+KKyt3KzKVDA4+5z6/OmzBqvl9gM9HTNbgJHmBUh/M
 VD+L96k8ZS0uGZIXnpkyPUDASlZV4Nzx59pczon3gzCR/hjDzxBWrwg7CyvNK7E5BOVa
 NIJT4Qexzg/Mk2Z2OjoKQV2ofPFzllXgvkT75EgL4mp4YPbSWhmRXhwwmhTxfSC1RTxX
 gmlsAI+XbJC+aVQ61R09On0KAbph77pKf++Oe7S2UHzS08W3LM1mu9fpoQogDjkwpBl4 3w== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vak6f2ag3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 31 Dec 2023 14:08:05 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BVDxBEZ029654;
	Sun, 31 Dec 2023 14:08:04 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vak6f2afn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 31 Dec 2023 14:08:04 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BVDj9iA007335;
	Sun, 31 Dec 2023 14:08:03 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vaxhnjpae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 31 Dec 2023 14:08:03 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BVE82vO17433138
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 31 Dec 2023 14:08:03 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 95F0758058;
	Sun, 31 Dec 2023 14:08:02 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 545CA58057;
	Sun, 31 Dec 2023 14:08:01 +0000 (GMT)
Received: from lingrow.int.hansenpartnership.com (unknown [9.67.79.160])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 31 Dec 2023 14:08:01 +0000 (GMT)
Message-ID: <775642a320f7dae53d70610f265056bcdfd8ab13.camel@linux.ibm.com>
Subject: Re: scsi: ses: Move a label in ses_enclosure_data_process()
From: James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To: Markus Elfring <Markus.Elfring@web.de>, linux-scsi@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        "Martin K. Petersen"
	 <martin.petersen@oracle.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Date: Sun, 31 Dec 2023 09:07:59 -0500
In-Reply-To: <38dfe7b6-6d8b-4056-9943-12197c80f4d7@web.de>
References: <4616e325-e313-4078-9788-dd1e6e51b9e0@web.de>
	 <9d24844f30604f969ac10da456801f594ce72f2d.camel@linux.ibm.com>
	 <b65afa15-41e6-4d71-87bd-39fd688fa551@web.de>
	 <a35c6128d4449fec00238c909e5f6f45ebf4bcba.camel@linux.ibm.com>
	 <a3825ab2-8987-4b85-9db0-642035789c49@web.de>
	 <4018ab9225ecaf18501e54114a94217a58a8a57f.camel@linux.ibm.com>
	 <38dfe7b6-6d8b-4056-9943-12197c80f4d7@web.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: djWPtmrHUpMkdhmwwenP19MDP89Ifvn2
X-Proofpoint-GUID: vFr7PqRaRso_YZKBlAOYJp00uqQ-d7az
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-31_07,2023-12-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=15 clxscore=1015 mlxscore=15
 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 spamscore=15
 mlxlogscore=74 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2312310116

On Sat, 2023-12-30 at 15:25 +0100, Markus Elfring wrote:
> > > If you would dare to follow advice from goto chains in a strict
> > > way, I imagine that you can tend to stress the attention for more
> > > useful data processing a bit more than such a redundant function
> > > call.
> > 
> > It's about maintainability and simplicity.  Eliminating kfree(NULL)
> > doesn't simplify most code,
> 
> I find it easy to avoid such a call in the affected and concrete
> function implementation.

I find it easy to fall down stairs nowadays; that doesn't make it a
necessary or even desirable thing to do.

> >                             it just makes the exit paths more
> > complex
> 
> Where is undesirable software complexity here in the repositioning
> of the label “simple_populate” before the statement “buf = NULL;”?

We don't just apply patches because we can: code churn is inimical to
software maintenance and backporting, so every patch has an application
cost.  The value provided by any patch has to be greater than that
cost. kfree(NULL) is an expected operation so there's little value in
avoiding it and certainly not enough to overcome the patch application
cost.

James


