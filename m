Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0246676C44E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 06:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbjHBEzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 00:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjHBEzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 00:55:12 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A26D19B0
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 21:55:11 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3724V3nZ031126;
        Wed, 2 Aug 2023 04:54:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=W7Q1EkTTaydnUGVxKA6+xlWAeQKWpiKN2B1NWyFP50k=;
 b=AlU9jo4z4C96qZXNZybhzXDdHlXIrZQx5ZAYu+6uCI5UpPNgLbvndTiPjUnx6EjNKRNX
 +drTAVANjJ9dg3GlVNlMQgOpw/48cUcZ2uyfzvlNiICncAD50UOChbJe5AqtjmnaIWu3
 cY6zmcBP5skXx7adI2z0Y3x4GvFixjqj0LqZAPQbUv6mtvEjj46DVgsT7CS7MGrXilyz
 ah1K2Dr/4jePj5qDkj4SDJ4gZqdk8pXUGJAhuB/0reOFwQ6LiKnqlX5yZwxHRGG/cOWs
 EqmvDkPvb7E/7H01YCjRvl/t/qZ+rx0DKFevkLGbCwAqVEe4MbJZY4VbuYW32ehpD8hU QA== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s6rhatxmb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Aug 2023 04:54:38 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3724saCN007929
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Aug 2023 04:54:36 GMT
Received: from hu-gurus-sd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 1 Aug 2023 21:54:36 -0700
From:   Guru Das Srinagesh <quic_gurus@quicinc.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Nicolas Schier" <nicolas@fjasle.eu>,
        Kees Cook <keescook@chromium.org>,
        "Bjorn Andersson" <andersson@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>
Subject: [PATCH 0/1] Add add-maintainer.py script
Date:   Tue, 1 Aug 2023 21:54:28 -0700
Message-ID: <cover.1690951441.git.quic_gurus@quicinc.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wjMzQP87mhDAhNfuglvP4GcCSn-FVdjY
X-Proofpoint-ORIG-GUID: wjMzQP87mhDAhNfuglvP4GcCSn-FVdjY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_01,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0
 bulkscore=0 phishscore=0 mlxlogscore=458 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308020044
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When pushing patches to upstream, the `get_maintainer.pl` script is used to
determine whom to send the patches to. Instead of having to manually process
the output of the script, add a wrapper script to do that for you.

The add-maintainer.py script adds maintainers (and mailing lists) to a patch,
editing it in-place.

Thanks to Bjorn for being a sounding board to this idea and for his valuable
suggestions.

I referred to the following links during development of this script:
- https://stackoverflow.com/questions/4427542/how-to-do-sed-like-text-replace-with-python
- https://stackoverflow.com/questions/4146009/python-get-list-indexes-using-regular-expression
- https://stackoverflow.com/questions/10507230/insert-line-at-middle-of-file-with-python


Guru Das Srinagesh (1):
  scripts: Add add-maintainer.py

 scripts/add-maintainer.py | 82 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100755 scripts/add-maintainer.py


base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
-- 
2.40.0

