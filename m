Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E1B7A6181
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 13:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbjISLlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 07:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjISLlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 07:41:15 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9474BBA
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 04:41:09 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38JBau1Y009162;
        Tue, 19 Sep 2023 11:40:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=0CjLTwvQt2avDiPPhOs+5gCjFArR4GRZZxmHyoi/VIM=;
 b=edJ5YQvbeOzTAr9JLjdJ/YKxdb21fB1m2H5UHMNM/GSDRHWX9OpOuVguUijhwyDsBqdF
 B989CkMiFdaND6/R9ExmuY2jDdr3PsNILsi6dKRfpq4ax8oHQDJMUGCNiWYLFgT8INSy
 4xV9hezp1ynS61VolI2HRtmHIsfJ6i+PX5Cqq2L9Ne7aOEcbXLV65++dqrlpVXy/7WY4
 ei64sgkCMU0d/kp+hnzGB5hoxkbE1UMt15qrxK2y2tlQLigHjKcAZdYjjohm/40PqPp9
 6tX6fcdeJ4RZL1TCA+JHUCxqDNkImwIZkI5sRCu72+Cxt6oOs4AWUEovO6LcsOUV80w+ XQ== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t7454smc1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Sep 2023 11:40:58 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38JBR4Rr018130;
        Tue, 19 Sep 2023 11:40:56 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t5ppsmaef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Sep 2023 11:40:56 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38JBeswZ21955276
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Sep 2023 11:40:54 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BD0642004B;
        Tue, 19 Sep 2023 11:40:54 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4C9AF20043;
        Tue, 19 Sep 2023 11:40:54 +0000 (GMT)
Received: from [9.171.62.55] (unknown [9.171.62.55])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 19 Sep 2023 11:40:54 +0000 (GMT)
Message-ID: <75212b6925df202fb75357e2e4f4a59d138b7375.camel@linux.ibm.com>
Subject: Re: [PATCH v3 13/13] comedi: add HAS_IOPORT dependencies again
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Ian Abbott <abbotti@mev.co.uk>, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 19 Sep 2023 13:40:53 +0200
In-Reply-To: <20230913170712.111719-14-abbotti@mev.co.uk>
References: <20230913164013.107520-1-abbotti@mev.co.uk>
         <20230913170712.111719-1-abbotti@mev.co.uk>
         <20230913170712.111719-14-abbotti@mev.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: e-dxNO_9L-FA1tnXxsnAHA4UqA1maCL1
X-Proofpoint-ORIG-GUID: e-dxNO_9L-FA1tnXxsnAHA4UqA1maCL1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_06,2023-09-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 mlxlogscore=515
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309190098
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-09-13 at 18:07 +0100, Ian Abbott wrote:
> In a future patch HAS_IOPORT=3Dn will result in inb()/outb() and friends
> not being declared. We thus need to add HAS_IOPORT as dependency for
> those drivers using them.
>=20
> This was previously done in commit b5c75b68b7de ("comedi: add HAS_IOPORT
> dependencies"), but that has been reverted because it made it impossible
> to select configuration options for several comedi drivers.  This is a
> do-over that avoids that.
>=20
> Since the original patch, modifications have been made to various comedi
> modules so that they can still be built even if the port I/O functions
> have not been declared, so the configuration options for building those
> modules no longer need to depend on HAS_IOPORT.
>=20
> Make the COMEDI_ISA_DRIVERS menu option (which allows configuration
> options for ISA and PC/104 drivers to be selected) depend on HAS_IOPORT,
> and also depend on ISA || ISA_BUS || PC104.
>=20
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> Co-developed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Cc: Arnd Bergmann <arnd@kernel.org>
> Cc: Niklas Schnelle <schnelle@linux.ibm.com>
> Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
> ---
> v2: N/A.
> v3: N/A.

I just gave this another try with the rest of my series including the
disablement of the I/O port accessors. I tried both allmodconfig and
allyesconfig on s390x and both seem fine. Also definitely see the
comedi driver's without HAS_IOPORT dependeny being built.

Thanks,
Niklas
