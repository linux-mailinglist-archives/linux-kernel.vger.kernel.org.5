Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD007A9658
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjIURHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjIURGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:06:33 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CAF4493;
        Thu, 21 Sep 2023 10:04:05 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38LAbsbV008389;
        Thu, 21 Sep 2023 10:47:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to : sender :
 content-transfer-encoding : mime-version; s=pp1;
 bh=tC0z5s3RdP9QagJBrQju/hCR80f7lEFVYo0jybcVgTM=;
 b=HdWa/AEjA4+xZ3TUtE1VtWYjY1c7NEir8CR9mzXEm2zoafqm/DVkf4mvOuZFnL75iZCX
 AsPKuAf8lorZYFJoJ6/BEZqu1vvAqfvLZzWN66caULCp6WZdvh+2gdfj5J8gS7M0JPuv
 XEth5u3wftn+eKwsb1O7WVix3oWTH46u8txnpr5MGRvKIQ8JAdTFtYDcTqeaLm+1sm5g
 FIH7kUQ0QN8Ga5ZH1FkWpSixRzSAjek2u3V6tkm0yVPFuh9HlOULIMNzZEPrHCBMt0c9
 4cQvpGDkYOrIw9cFgoY77x9MopU2xWsQm27hBpRrUgNPIXQIdDqIFRF5xWovlK+ZvO90 OA== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t848tfpq9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Sep 2023 10:47:53 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38L9g03G016432;
        Thu, 21 Sep 2023 10:47:52 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t5sd2ffs1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Sep 2023 10:47:52 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38LAllZM28639826
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Sep 2023 10:47:47 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C4C082004B;
        Thu, 21 Sep 2023 10:47:47 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B169220043;
        Thu, 21 Sep 2023 10:47:47 +0000 (GMT)
Received: from p1gen4-pw042f0m (unknown [9.196.32.213])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu, 21 Sep 2023 10:47:47 +0000 (GMT)
Received: from bblock by p1gen4-pw042f0m with local (Exim 4.96)
        (envelope-from <bblock@linux.ibm.com>)
        id 1qjHDm-001qiu-1v;
        Thu, 21 Sep 2023 12:47:46 +0200
Date:   Thu, 21 Sep 2023 12:47:46 +0200
From:   Benjamin Block <bblock@linux.ibm.com>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     Steffen Maier <maier@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        James Bottomley <James.Bottomley@suse.de>,
        Swen Schillig <swen@vnet.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mailing List linux-scsi <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] scsi: zfcp: Fix a potential double free in
 zfcp_port_enqueue
Message-ID: <20230921104746.GG10864@p1gen4-pw042f0m.fritz.box>
References: <20230921063915.7703-1-dinghao.liu@zju.edu.cn>
 <20230921102102.GF10864@p1gen4-pw042f0m.fritz.box>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20230921102102.GF10864@p1gen4-pw042f0m.fritz.box>
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4HTqd0pstE7eD7KZs3X4dIgUVQj2m89p
X-Proofpoint-ORIG-GUID: 4HTqd0pstE7eD7KZs3X4dIgUVQj2m89p
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-21_07,2023-09-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 mlxlogscore=940
 suspectscore=0 clxscore=1011 bulkscore=0 malwarescore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309210092
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 12:21:02PM +0200, Benjamin Block wrote:
> Hello Liu Dinghao,
> 
> good find.

Oh, also, please put linux-scsi on the CC list. Patches to zfcp go via
linux-scsi, not linux-s390.

> 
> On Thu, Sep 21, 2023 at 02:39:15PM +0800, Dinghao Liu wrote:
> > When device_register() fails, zfcp_port_release() will be called
> > after put_device(). As a result, the zfcp_ccw_adapter_put() after
> > err_out is redundant because it will be called in the call-back
> > function zfcp_port_release(). Remove it from this error path.
> 
> So the reference on the adapter object is doubly put, which may
> lead to a premature free of the adapter object itself. Please mention that
> either in the subject, or description; it makes it easier to see what exactly
> breaks at a glance.
> 
> > 
> > Fixes: f3450c7b9172 ("[SCSI] zfcp: Replace local reference counting with common kref")
> > Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> > ---
> >  drivers/s390/scsi/zfcp_aux.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/s390/scsi/zfcp_aux.c b/drivers/s390/scsi/zfcp_aux.c
> > index df782646e856..489e6239dedf 100644
> > --- a/drivers/s390/scsi/zfcp_aux.c
> > +++ b/drivers/s390/scsi/zfcp_aux.c
> > @@ -552,7 +552,7 @@ struct zfcp_port *zfcp_port_enqueue(struct zfcp_adapter *adapter, u64 wwpn,
> >  
> >  	if (device_register(&port->dev)) {
> >  		put_device(&port->dev);
> > -		goto err_out;
> > +		return ERR_PTR(retval);
> 
> I'd rather have a new label at the bottom, in front of the return that is
> already there, and jump to that, instead of a different function exit point.
> 
> >  	}
> >  
> >  	write_lock_irq(&adapter->port_list_lock);
> > -- 
> > 2.17.1
> > 

-- 
Best Regards, Benjamin Block        /        Linux on IBM Z Kernel Development
IBM Deutschland Research & Development GmbH    /   https://www.ibm.com/privacy
Vors. Aufs.-R.: Gregor Pillen         /         Geschäftsführung: David Faller
Sitz der Ges.: Böblingen     /    Registergericht: AmtsG Stuttgart, HRB 243294
