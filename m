Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3818776E30A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbjHCI1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbjHCI1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:27:08 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BFF1BF9;
        Thu,  3 Aug 2023 01:24:36 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3736wXS5024241;
        Thu, 3 Aug 2023 08:23:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=6L+Hc3W81ZyuNI/v3f6fIFyjOKpvOIgXQ0T8pUgtihs=;
 b=AyR+nkGJ3+dzU7Dt5I2fsn9WOq8+K6xi0bdsC2Koke1J+ho3+aQ7hQxa7B911bM3QfM1
 Rc+mlc8z3T7ady1qWkLefPgiKghu+799akKXbGZFNvOWYKGDelIwu7uA1n8JljPqLRJi
 Ozvsb9EDkBeJZ2b/wvGxrc94BHTsrdZpFp3rVgRrjvTaOf9KVpqUK2XLBOd/lFdIVk3k
 FI2vXx5OA9Xcrws3qOIWu6idOccYTeLUXmixPpgLawiJSe9enLVmjwjXlmWXXpfis65u
 OIbTHqGRmo+3TzKGL8ZsdrlqolkSs/jJnABXXw8X6o4c+BvqeDXskd+bGrhy27Ps+s7S Eg== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s7n93jb58-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Aug 2023 08:23:24 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3738NNNM024095
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 3 Aug 2023 08:23:23 GMT
Received: from hu-gurus-sd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 3 Aug 2023 01:23:21 -0700
From:   Guru Das Srinagesh <quic_gurus@quicinc.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Nicolas Schier" <nicolas@fjasle.eu>,
        Kees Cook <keescook@chromium.org>,
        "Bjorn Andersson" <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, Will Deacon <will@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <quic_pkondeti@quicinc.com>, <u.kleine-koenig@pengutronix.de>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>
Subject: [PATCH v2 0/1] Add add-maintainer.py script
Date:   Thu, 3 Aug 2023 01:23:15 -0700
Message-ID: <cover.1691049436.git.quic_gurus@quicinc.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4hRBLHCEHBkVt6oDw5CVW5xFK6eKPSee
X-Proofpoint-ORIG-GUID: 4hRBLHCEHBkVt6oDw5CVW5xFK6eKPSee
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-03_06,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 bulkscore=0 mlxlogscore=635 spamscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308030073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

Please try out this script with `--verbosity debug` for verifying that it's
doing "the right thing". I've tested this with a patch series from various
subsystems to ensure variety of maintainers and lists output and found it to be
doing what it is supposed to do.

I referred to the following links during development of this script:
- https://stackoverflow.com/questions/4427542/how-to-do-sed-like-text-replace-with-python
- https://stackoverflow.com/questions/4146009/python-get-list-indexes-using-regular-expression
- https://stackoverflow.com/questions/10507230/insert-line-at-middle-of-file-with-python

v1 -> v2:
- Added set-union logic based on Pavan's comments [1] and Bjorn's early suggestion
- Expanded audience and added more mailing lists to get more review comments and feedback

[1] https://lore.kernel.org/lkml/63764b84-3ebd-4081-836f-4863af196228@quicinc.com/

Guru Das Srinagesh (1):
  scripts: Add add-maintainer.py

 scripts/add-maintainer.py | 113 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 113 insertions(+)
 create mode 100755 scripts/add-maintainer.py

-- 
2.40.0

