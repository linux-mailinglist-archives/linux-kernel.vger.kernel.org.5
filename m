Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05BDC7A883E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 17:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235970AbjITP0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 11:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235440AbjITP0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 11:26:05 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA7AAF;
        Wed, 20 Sep 2023 08:25:57 -0700 (PDT)
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38KE25ps030773;
        Wed, 20 Sep 2023 15:25:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=4TN4xDci4KhIxWUZX7GahFe+eG3YPSA3avGvps0DcbA=;
 b=LKGSGsNnymrDE0hgLbYO6aEINDrImntEKhMX0oLvd7R9gfcWwWzgqlLTFim3OLTIbCUR
 beQbYf48VNmMYamMxgQzCiPt/4jiI4mzyL4evGheWhzX9jHMK+OyY4/Zx7mO4cVbWmfL
 IcFi/fbl3oTxRMCuJMK8Q2Zm4ikciuEaqze1Sj3OJ3HnI1nUY9y5pAUxsKfTEGJLlS+9
 RVdgN/LSz2tuYXnGL1kdkdbWP2xAmhypkr5CsInCryEshzuAtAP+I7KH6O0L3+uqIosf
 xWDwGnoZXvvtXFnWVrojP5yI8MzCpFPNJxQo9pgqlRkDL+PfKFCsURBS8/Jc8LXogOw9 DA== 
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3t7rp3e3v8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 15:25:45 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 5A98F13195;
        Wed, 20 Sep 2023 15:25:44 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.39])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 98DF480B277;
        Wed, 20 Sep 2023 15:25:43 +0000 (UTC)
From:   charles.kearney@hpe.com
To:     charles.kearney@hpe.com, verdun@hpe.com, nick.hawkins@hpe.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] ARM: dts: hpe: BUG: Correct GXP register ranges
Date:   Wed, 20 Sep 2023 15:25:13 +0000
Message-Id: <20230920152514.3889174-1-charles.kearney@hpe.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: aGJvdPEZt0XzBl46690j8J3YpJwGH9wO
X-Proofpoint-GUID: aGJvdPEZt0XzBl46690j8J3YpJwGH9wO
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_05,2023-09-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 suspectscore=0 spamscore=0 impostorscore=0
 phishscore=0 mlxlogscore=406 bulkscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309200125
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Charles Kearney <charles.kearney@hpe.com>

Bug fix to correct memory ranges on GXP to include host registers. This 
corrects a issue where the host interrupt controller is not available.

Fixes: 53658de4fadb ARM: dts: Introduce HPE GXP Device tree

V2: 
 *added Fixes tag
 *removed irrelevant comment line
 *fixed range alignment

Charles Kearney (1):
  ARM: dts: hpe: BUG: Correct GXP register ranges

 arch/arm/boot/dts/hpe/hpe-gxp.dtsi | 37 +++++++++++++++---------------
 1 file changed, 19 insertions(+), 18 deletions(-)

-- 
2.25.1


