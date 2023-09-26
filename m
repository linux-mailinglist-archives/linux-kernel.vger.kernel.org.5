Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71577AEC15
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 14:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234519AbjIZMDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 08:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233884AbjIZMDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 08:03:02 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E431E6;
        Tue, 26 Sep 2023 05:02:53 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38QBGOHk009562;
        Tue, 26 Sep 2023 12:02:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=2a8ACoHIsGvcVxr5BZ9tsHiiT+SNT7xd5y69XlnJqQY=;
 b=J7lTwAphiiWiKHxu+WgZCtz2LozTWomlVQwehhqeNAdNpUmUsFkHrS3dJSiElv3CEPZd
 nEEQI4YoHvSE9BecfzfnLaH8/WEssbfNvTjMUQO1rZVgW3Q3RC25ExS3yMlsckIOb7yv
 NBO6sME/INbBey7rW0sPumiS/UQ5mHPkk62FkAcfRoml7BWL1kSreVihFdquCOsLXMFR
 Cs5LvoZ4UOxVsP9DiHcw32CabcGmYd8ZqjQTcERWLNt7XGnUorrV3JLxPEfQqdzlUXzz
 cHtfU2uE4kVEb1SjY5xbUnS5rVCkjJX78HZbLxZdtTlc5ek7zgbPyTnhPBDPay8EMyH9 Tg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tb72sk4kf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 12:02:22 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38QC2Ln2010849
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 12:02:21 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Tue, 26 Sep 2023 05:02:13 -0700
Date:   Tue, 26 Sep 2023 17:32:10 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Guru Das Srinagesh <quic_gurus@quicinc.com>
CC:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Nicolas Schier" <nicolas@fjasle.eu>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        "Bjorn Andersson" <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, Will Deacon <will@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <quic_pkondeti@quicinc.com>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>, <workflows@vger.kernel.org>,
        <tools@linux.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v3 1/1] scripts: Add add-maintainer.py
Message-ID: <d0711242-df00-45c7-962f-841f7cefa7e3@quicinc.com>
References: <cover.1693037031.git.quic_gurus@quicinc.com>
 <141b9fcab2208ace3001df4fc10e3dfd42b9f5d9.1693037031.git.quic_gurus@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <141b9fcab2208ace3001df4fc10e3dfd42b9f5d9.1693037031.git.quic_gurus@quicinc.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NatgBplqSlxKxQknsktnvf_838ZElKmd
X-Proofpoint-ORIG-GUID: NatgBplqSlxKxQknsktnvf_838ZElKmd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_07,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1011
 malwarescore=0 adultscore=0 mlxlogscore=661 spamscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309260104
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 26, 2023 at 01:07:42AM -0700, Guru Das Srinagesh wrote:
> +def gather_maintainers_of_file(patch_file):
> +    all_entities_of_patch = dict()
> +
> +    # Run get_maintainer.pl on patch file
> +    logging.info("GET: Patch: {}".format(os.path.basename(patch_file)))
> +    cmd = ['scripts/get_maintainer.pl']
> +    cmd.extend([patch_file])
> +
> +    try:
> +        p = subprocess.run(cmd, stdout=subprocess.PIPE, check=True)
> +    except:
> +        sys.exit(1)
> +
> +    logging.debug("\n{}".format(p.stdout.decode()))
> +
> +    entries = p.stdout.decode().splitlines()
> +
> +    maintainers = []
> +    lists = []
> +    others = []
> +
> +    for entry in entries:
> +        entity = entry.split('(')[0].strip()
> +        if any(role in entry for role in ["maintainer", "reviewer"]):
> +            maintainers.append(entity)
> +        elif "list" in entry:
> +            lists.append(entity)
> +        else:
> +            others.append(entity)
> +
> +    all_entities_of_patch["maintainers"] = set(maintainers)
> +    all_entities_of_patch["lists"] = set(lists)
> +    all_entities_of_patch["others"] = set(others)
> +
> +    return all_entities_of_patch
> +

FYI, there are couple of issues found while playing around.

- Some entries in MAINTAINERS could be "supporter"
- When names contain ("company"), the script fails to extract name.

Thanks,
Pavan

diff --git a/scripts/add-maintainer.py b/scripts/add-maintainer.py
index 5a5cc9482b06..6aa5e7941172 100755
--- a/scripts/add-maintainer.py
+++ b/scripts/add-maintainer.py
@@ -29,8 +29,8 @@ def gather_maintainers_of_file(patch_file):
     others = []

     for entry in entries:
-        entity = entry.split('(')[0].strip()
-        if any(role in entry for role in ["maintainer", "reviewer"]):
+        entity = entry.rsplit('(', 1)[0].strip()
+        if any(role in entry for role in ["maintainer", "reviewer", "supporter"]):
             maintainers.append(entity)
         elif "list" in entry:
             lists.append(entity)


Thanks,
Pavan
