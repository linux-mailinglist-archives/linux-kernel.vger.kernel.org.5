Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82EB80D41E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 18:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235012AbjLKRik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 12:38:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235005AbjLKRij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 12:38:39 -0500
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB0C9B
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 09:38:45 -0800 (PST)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BBH6dL6029061;
        Mon, 11 Dec 2023 09:38:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=
        pfptdkimsnps; bh=l+kpSoS+PY72igUtxxPDUvvI4e9L7a6PJQDcJzTFarQ=; b=
        q5QYyErPlMHWcSYMM924Zi/VgHw657p2qE+UKjmvrGkbwGl+rkP3uJVO3HxcmX48
        PjhoIpzsgxpIAnYzzNDfhRYSwWiA3Nmpe5BJSTGeH09z5LhCg1oahGRco6DbAPfH
        y1i+vvAilTRq38aNkUL3CSOk1PDxNEg6tKV5PN5zanF2ouKG4wj2pIqRvOoDfypX
        S5ae/OoxhB3xDSFXnPhaBqLFT9tGKhBPERCme+9XduUNBNTglAYHAojX8wc4XCbS
        +iXjasOdIvswXlQkbGNCVFkCIz6tVcL7jEBRl3RAPn+CCwTtTSxN9cy2+7daysyy
        MgfvPj1CIfaDdJrFUO9CfA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3uvrc57edn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Dec 2023 09:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1702316317; bh=JNUrErkUi2w7A6JLLzwoHbrjSIgvAqABYx3IioDXalA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZDCqz2fBxFMPixxGYM3XvHyL6UFp9L7okEiXxBzvRNcY9E1wBzz4lcaMQaMLUWIUt
         Fwh4ZNQBL3Le+mGdQSwCafHb6n+syxZ8mvzBSxG+ieVMsKRJgQCwPhcXssY14JO7OF
         LDd8plQ1gargbMkKqwlnSq+sBvbwrLrAZEWAMl4Bevfd+8DVNWF//k47L9hLRwp+73
         QjDuQi3/CMTHhL9nDotFz2yje2bOgVeFR9ImTdfil02gsSHZgfa7TTxnADDZgHHr6Z
         Gk+6rYKQR6giqg1B+04ajTfpDtzYwNf2CZvTTCEyjN8f5endeo/RIM+raNT3zBBbyU
         tJKcivJsKgT8g==
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 581DA40528;
        Mon, 11 Dec 2023 17:38:36 +0000 (UTC)
Received: from SNPS-o0WHuHJU73.internal.synopsys.com (snps-o0whuhju73.internal.synopsys.com [10.116.104.46])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client did not present a certificate)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 23388A0091;
        Mon, 11 Dec 2023 17:38:34 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Pavel.Kozlov@synopsys.com
To:     Vineet Gupta <vgupta@kernel.org>,
        linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] ARC updates
Date:   Mon, 11 Dec 2023 21:38:20 +0400
Message-Id: <20231211173820.30330-1-kozlov@synopsys.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231209003307.480051-1-vgupta@kernel.org>
References: <20231209003307.480051-1-vgupta@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 3kUDZ4YFpW3-JLE8akvzP_khzdMzivjX
X-Proofpoint-GUID: 3kUDZ4YFpW3-JLE8akvzP_khzdMzivjX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 clxscore=1011 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312110145
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vineet,

> A pile of accrued changes, compile tested only.
> Please test.

> Thx,
> -Vineet

I'm testing you patches. At first glance everything is fine, no obvious
regressions.

But I've found an ARC build issue with the latest upstream source
(tag: v6.7-rc5). It is not linked with your updates.
The build issue occurs when the CONFIG_TRANSPARENT_HUGEPAGE option
is enabled:

| ../fs/proc/task_mmu.c: In function ‘pagemap_scan_thp_entry’:
| ../fs/proc/task_mmu.c:2115:28: error: ‘HPAGE_SIZE’ undeclared (first use in this function); did you mean ‘PAGE_SIZE’?
|  2115 |         if (end != start + HPAGE_SIZE) {
|       |                            ^~~~~~~~~~
|       |                            PAGE_SIZE
| ../fs/proc/task_mmu.c:2115:28: note: each undeclared identifier is reported only once for each function it appears in
| make[4]: *** [../scripts/Makefile.build:243: fs/proc/task_mmu.o] Error 1
| make[3]: *** [../scripts/Makefile.build:480: fs/proc] Error 2

May be you could address this issue in your updates too?

Thanks
Pavel
