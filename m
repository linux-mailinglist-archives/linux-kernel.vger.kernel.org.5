Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E807894B1
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 10:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbjHZIIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 04:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbjHZII3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 04:08:29 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A2F19A2;
        Sat, 26 Aug 2023 01:08:27 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37Q87r7w003397;
        Sat, 26 Aug 2023 08:07:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=RuSklkcagBLFU5of9raSa21FtXCQIuorKx7luzbnnl0=;
 b=aBxIdvzNoBAL37ndhKAZQv6z1J23K1ha9jUjsaQ3tOYGsM8KCjTFFSoflRRYp3tm928h
 lt3bzxKpOJ3CfGOm7juet6QnrKCfaVjcUuH7msLvQHiHgMaZEBHPeuQapqa9njA/Hx81
 7Zti+bxb/T+TUW5U+BpLXa90Y8IRWOzFpJlVe9ouHKn6ctM+szV1soQtdSjaSvdXMXkx
 6dXfXw/Vt563EL39b2lsbkYzlzQSvzOpmnNeY+ggJS1fCKU6ZwtfTrarlUYXo8gTCHb+
 0fR77TJMXFn1Sc6H7ckDrCEx+DrzCD5YasR/f2j5PWud8rfY8HgrcAcHC6N+megXsMe9 lw== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sq8by8b4k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 26 Aug 2023 08:07:52 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37Q87qQk000990
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 26 Aug 2023 08:07:52 GMT
Received: from hu-gurus-sd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Sat, 26 Aug 2023 01:07:49 -0700
From:   Guru Das Srinagesh <quic_gurus@quicinc.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Nicolas Schier" <nicolas@fjasle.eu>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        "Bjorn Andersson" <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, Will Deacon <will@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <quic_pkondeti@quicinc.com>
CC:     <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>,
        <workflows@vger.kernel.org>, <tools@linux.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        "Guru Das Srinagesh" <quic_gurus@quicinc.com>
Subject: [PATCH v3 0/1] Add add-maintainer.py script
Date:   Sat, 26 Aug 2023 01:07:41 -0700
Message-ID: <cover.1693037031.git.quic_gurus@quicinc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1CRp--2K1yfb6_mGSw-4Xgx5GqXzDMlf
X-Proofpoint-ORIG-GUID: 1CRp--2K1yfb6_mGSw-4Xgx5GqXzDMlf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-26_05,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0
 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0 clxscore=1011
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308260074
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When pushing patches to upstream, the `get_maintainer.pl` script is used to
determine whom to send the patches to. Instead of having to manually process
the output of the script, add a wrapper script to do that for you.

The add-maintainer.py script adds maintainers (and mailing lists) to a patch,
editing it in-place. It also optionally undoes this operation if so desired.

Please try out this script with `--verbosity debug` for verifying that it's
doing "the right thing". I've tested this with a patch series from various
subsystems to ensure variety of maintainers and lists output and found it to be
behaving as expected. For an example output of this script, please see [1].

Thanks to Bjorn for being a sounding board to this idea and for his valuable
suggestions.

I referred to these links [2][3][4] during development of this script.

Apropos workflow:

Thanks to Krzysztof for sharing his workflow - I found his suggestion to use
git branch description as cover letter [5] particularly useful. Incorporating
that into the ideal workflow envisioned [6] for this script, we get:

    1. Do `git config format.coverFromDescription subject`
    2. Do `git branch --edit-description` and write cover letter
    3. Generate patches using `git format-patch --cover-letter -n --thread -v<N>`
    4. Run `add-maintainer.py` on the above patches
    5. `git send-email` the patches.

b4 is an amazing tool whose `b4 prep --auto-to-cc` does part of what this
script does, but with the above workflow, we have an in-tree solution to the
basic problem of preparing patches to be sent to LKML.  For multiple patchsets,
all one will need to do is to increment `-v` while git-formatting patches and
make corresponding changes to the cover letter via step #2 as necessary!

Changelog:

(v2 -> v3)
- Change patches nargs * -> + (Nicolas)
- Add entry in MAINTAINERS and add self as maintainer (Pavan)
- Bail out early if file does not exist (Pavan)
- Change From: line determination logic (Nicolas)
  - Look for From: line and stop at the first occurrence of it - don't search
    entire file
- Wrap the get_maintainer.pl call with a try-except block.
- Use a better (arguably so) email validation regex
- Don't disallow multiple "From:" in patch:
  - When the change is authored by someone other than the person generating the
    patch, there will be two "From: <email address>" lines in the patch. This
    is very valid, so don't error out.
- Reviewers also go in To: in addition to Maintainers.
- Add new "--undo" flag to undo effects of this script on a patch (tested)

(v1 -> v2)
- Added set-union logic based on Pavan's comments [7] and Bjorn's early suggestion
- Expanded audience and added more mailing lists to get more review comments and feedback

[1] https://lore.kernel.org/lkml/20230824214436.GA22659@quicinc.com/
[2] https://stackoverflow.com/questions/4427542/how-to-do-sed-like-text-replace-with-python
[3] https://stackoverflow.com/questions/4146009/python-get-list-indexes-using-regular-expression
[4] https://stackoverflow.com/questions/10507230/insert-line-at-middle-of-file-with-python
[5] https://lore.kernel.org/lkml/6f475c9b-dc0e-078e-9aa2-d876a1e02467@linaro.org/
[6] https://lore.kernel.org/lkml/20230816171538.GB26279@quicinc.com/
[7] https://lore.kernel.org/lkml/63764b84-3ebd-4081-836f-4863af196228@quicinc.com/

Guru Das Srinagesh (1):
  scripts: Add add-maintainer.py

 MAINTAINERS               |   5 ++
 scripts/add-maintainer.py | 164 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 169 insertions(+)
 create mode 100755 scripts/add-maintainer.py

-- 
2.41.0

