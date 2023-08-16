Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A194B77DAE2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 09:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242299AbjHPHEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 03:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242261AbjHPHEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 03:04:11 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6340F1FCE;
        Wed, 16 Aug 2023 00:04:09 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37G6wH5g018435;
        Wed, 16 Aug 2023 07:03:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : content-type :
 mime-version; s=pp1; bh=JRiEwG7CGAIwUuGxv6cswmnrQS0AldAPoI7yGXpgWgY=;
 b=O3aDDuYqblqU2ow4KXHkowrbrKcpbFLAIEDT7DzfJtDf7OrzA3/f1/0927eO8jdgbBg/
 inigcHl7nc5bFh3AQMtv/3kLaqp2u414YiQJtdr/tZIZqETkRnoLq/HPO+33N7a54CL4
 EQvWs7I9ZIbPJcRccVCBwTXeDgzoPYqoj7tlPUO+cZFWsROJvvoIdWPMKWD79hORmFVd
 JQx324Oyy5j57ZD3DKP3MdPuMDLoa4JvxkSL2y80b0s2uSXCoYr7a+6DDSNMAn5/KWlm
 fMPmIYKEOC+aD5RwZILE1rfksPIUKMiD+jY9r5U4s5eofcHl5CkeaV2xIoEnBrCWstNJ YQ== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sgsn984kx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 07:03:58 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37G40GHT013425;
        Wed, 16 Aug 2023 07:03:58 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sepmjt3vy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 07:03:57 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37G73t6d62587154
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Aug 2023 07:03:55 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED10E2004B;
        Wed, 16 Aug 2023 07:03:54 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A71FD20040;
        Wed, 16 Aug 2023 07:03:54 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 16 Aug 2023 07:03:54 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        linux-kbuild@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-s390@vger.kernel.org, Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: linux-next-2023-0815: s390/block/dasd: build error
References: <95b176a2-3670-1e89-c8f6-86b094eebc4c@infradead.org>
Date:   Wed, 16 Aug 2023 09:03:54 +0200
In-Reply-To: <95b176a2-3670-1e89-c8f6-86b094eebc4c@infradead.org> (Randy
        Dunlap's message of "Tue, 15 Aug 2023 22:34:19 -0700")
Message-ID: <yt9d350jbh9h.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cjURwvIYWuHXhR9BbhXBbvstXJsiOinV
X-Proofpoint-ORIG-GUID: cjURwvIYWuHXhR9BbhXBbvstXJsiOinV
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_04,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=994
 mlxscore=0 impostorscore=0 clxscore=1011 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308160063
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:

> I have spent some time on this but I don't see where the problem is.
>
> ERROR: modpost: "bdev_mark_dead" [drivers/s390/block/dasd_mod.ko] undefined!
>
> CONFIG_BLOCK=y, bdev.o is built and contains the missing symbol.
>
> Full randconfig file is attached.
>
> Hopefully I'm just overlooking something.

The EXPORT_SYMBOL_GPL is surrounded by #ifdef CONFIG_DASD, but i think
it should be '#ifdef CONFIG_DASD_MODULE'. This was introduced by

381f678306ce ("block: consolidate __invalidate_device and fsync_bdev")

There was already a thread about this:

https://www.spinics.net/lists/linux-btrfs/msg138633.html

regards,
Sven
