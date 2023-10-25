Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8607D72CA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 20:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjJYSB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 14:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjJYSB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 14:01:27 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1DBE5;
        Wed, 25 Oct 2023 11:01:25 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39PHnfac028294;
        Wed, 25 Oct 2023 18:01:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=S3E5OHSsLvkSVq5CBpCHcR3UqUEpCAQogTfCqA8nkoI=;
 b=NkxwAAV73nFNwisl1U7c7ShrD0ZiV0v10tv73aQyGMS7Iu/mzxOyofjEYdDvW5rQmUNU
 VwjWgkbfn00aK6qBIG4os1uUllKPysr5Pc5O9+59H1DcQ24X0azrMncw5uwSOX2OefZG
 H57cHeL4TmIn2CvsNI+o5wZvzAqvCsGrZmkf9EAAuBNChabRpy78CcMjjOS5oO9XeE0K
 jz9Z+0ag9BZJZAI6RN9bLWdc0JsUS/kMSoGAsp64CM/P/nvg7oO4mubtAcuOTIsmu1tA
 F7ip9WpOCKR6Gj7JVYzwFV0oqAM84Opd05JFaG/VvgBDe4bF6bPbtHTcGto0yVk/aAJT HA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ty7rt8dfq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 18:01:18 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39PHoU2t030652;
        Wed, 25 Oct 2023 18:01:18 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ty7rt8df7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 18:01:18 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39PHZj84012336;
        Wed, 25 Oct 2023 18:01:17 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tvup1yyce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 18:01:17 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
        by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39PI1GWr48955848
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 18:01:17 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C86C758054;
        Wed, 25 Oct 2023 18:01:16 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2353B5805F;
        Wed, 25 Oct 2023 18:01:16 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.watson.ibm.com (unknown [9.31.99.90])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 25 Oct 2023 18:01:16 +0000 (GMT)
Message-ID: <488442598c3703760ed6182426ed891f85fe0a1a.camel@linux.ibm.com>
Subject: Re: [PATCH v3] ima: detect changes to the backing overlay file
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Raul Rangel <rrangel@chromium.org>,
        Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 25 Oct 2023 14:01:15 -0400
In-Reply-To: <485C9C57-ABF1-4618-81D1-345597A1B9FA@oracle.com>
References: <20231025143906.133218-1-zohar@linux.ibm.com>
         <485C9C57-ABF1-4618-81D1-345597A1B9FA@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DW2-vXhn9iiqXKfJd9Zt7NUDllj0fqj2
X-Proofpoint-GUID: GVfTRXIF0kpJbO-msQSx2OnkmbDpG0Ib
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_07,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 suspectscore=0 adultscore=0 mlxlogscore=987
 bulkscore=0 clxscore=1015 malwarescore=0 spamscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310250156
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-10-25 at 16:27 +0000, Eric Snowberg wrote:
> 
> > On Oct 25, 2023, at 8:39 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> > 
> > Commit 18b44bc5a672 ("ovl: Always reevaluate the file signature for
> > IMA") forced signature re-evaulation on every file access.
> > 
> > Instead of always re-evaluating the file's integrity, detect a change
> > to the backing file, by comparing the cached file metadata with the
> > backing file's metadata.  Verifying just the i_version has not changed
> > is insufficient.  In addition save and compare the i_ino and s_dev
> > as well.
> > 
> > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> 
> I ran the file integrity tests that originally uncovered the need for 
> "Commit 18b44bc5a672 ("ovl: Always reevaluate the file signature for 
> IMA”). When the backing file is changed, file integrity remains.  For that 
> part, feel free to add:
> 
> Tested-by: Eric Snowberg <eric.snowberg@oracle.com>

Thanks!

Mimi

