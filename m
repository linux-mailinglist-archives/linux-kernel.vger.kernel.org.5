Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76ABD7D70A4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 17:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344432AbjJYPSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 11:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234261AbjJYPSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 11:18:15 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF47A128;
        Wed, 25 Oct 2023 08:18:13 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39PFI7FS025881;
        Wed, 25 Oct 2023 15:18:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=gUtsuZxLHLWPIpod6LwcGm0DrZ+N+DLIO5p2qxopLtU=;
 b=OlOAnoY+yEeQG2FixC8QoKHI7cZOZLDgzA3JTzC82ROxilm19SlWL19xjeqE8pHCU2kp
 lXsIJXe7ycagcGFwdqpOv21f/vzkJXO1K4PbXr3lrGJMVkFpj6/rNoA57vqbkBEWcLUc
 B8Ba/nN+0OXl+mUpqVomzLh8WNOjaLLvHGN8nPu4UW9XpJ87tuzav5FYc29Ty/7BmVTh
 tAfaGHshnEFcRqWe1++dLyMNvJU/P5eXHi7S/CoqxwJ6YNIjAvchKkeqccdxylKrBNxA
 AnYr6aZnv0XhFCjWFrPVvcVk2jDvdFrQHIDHtPyaHCMbF8lv8SF7J0GXS2RES1qP8Jku yA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ty5dpr6k8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 15:18:10 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39PFIApc026160;
        Wed, 25 Oct 2023 15:18:10 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ty5dpr66a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 15:18:07 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39PEtjMG012362;
        Wed, 25 Oct 2023 15:09:30 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tvup1xwdn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 15:09:30 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39PF9Trd16712290
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 15:09:30 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D24B58064;
        Wed, 25 Oct 2023 15:09:29 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 48BE458063;
        Wed, 25 Oct 2023 15:09:29 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.173.216])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 25 Oct 2023 15:09:28 +0000 (GMT)
Message-ID: <145a91c7044c08928646f65850a518febcf5a5ca.camel@linux.ibm.com>
Subject: Re: [PATCH v3] ima: detect changes to the backing overlay file
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Raul Rangel <rrangel@chromium.org>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 25 Oct 2023 11:09:28 -0400
In-Reply-To: <CAHQZ30BSD2c4WwUTARx9OeqTjusgq7te8OzwdUi6Qk+L=9vSgA@mail.gmail.com>
References: <20231025143906.133218-1-zohar@linux.ibm.com>
         <CAHQZ30BSD2c4WwUTARx9OeqTjusgq7te8OzwdUi6Qk+L=9vSgA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Zhcxv_qI73tR23OvSpxt9WB7cJpFQTF9
X-Proofpoint-GUID: _V7ikw0RDR4iOjIEoumI6dHHPmlHeX12
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_04,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 mlxscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 spamscore=0
 mlxlogscore=735 phishscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310250132
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-10-25 at 08:59 -0600, Raul Rangel wrote:
> On Wed, Oct 25, 2023 at 8:39 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > +               if (!IS_I_VERSION(backing_inode) ||
> > +                   backing_inode->i_sb->s_dev != iint->real_dev ||
> > +                   backing_inode->i_ino != iint->real_ino ||
> > +                   !inode_eq_iversion(backing_inode, iint->version)) {
> > +                       iint->flags &= ~IMA_DONE_MASK;
> > +                       iint->measured_pcrs = 0;
> > +               }
> > +       }
> > +
> Does this mean I need to mount ext4 with `-o iversion`? Or has it been
> enabled by default?

According to commit 1ff20307393e ("ext4: unconditionally enable the
i_version counter")  it's now enabled by default.
> 
> I can test this patch out sometime this week and verify it fixes the
> performance regression.
> 
> Thanks!

Much appreciated!

-- 
thanks,

Mimi

