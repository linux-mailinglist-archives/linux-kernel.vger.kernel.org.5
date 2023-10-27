Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13777D9123
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 10:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235310AbjJ0IUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 04:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235172AbjJ0ITl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 04:19:41 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9D11B1;
        Fri, 27 Oct 2023 01:19:29 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39R5iDAF022000;
        Fri, 27 Oct 2023 08:18:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=U2jPQiitFVM26G6KYP5UKWx7emnQxyGLbRHndRrIBA0=;
 b=2dC5944YFbItnaMhsIYOEvwpRV4tcwYrqdWOpPh1TT/Hu2Hh73Z3O/gENdp5ZfzJi6fg
 YioQ76kDHUBP2R7NDdKfczVvC4CZeIilRxoHwbM86676ClEdLqtrG57A4ptPVUOTDcXg
 OWL7wzZLqzVq9QRVn0fpTUaztW3E3XwPDrbVXpRsUeOQt94AJuODBxlFOB8AKxDnl+v9
 jUN9XeJtIvR63xQs/qbGLWUTdhWmTJ3CocmyXMT7mMdydgRmH6jCXNG6PURYTJ83F8ln
 ZTTQwKTaYxMqekMUufLLC5CGWsMr3Yl+HkRZhgV7qE+hIjJjFrCyV9+kurbI6axiHyu1 vw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tyx3ngwuc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Oct 2023 08:18:43 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39R6HWAp009159;
        Fri, 27 Oct 2023 08:18:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tywqjeb5g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Oct 2023 08:18:42 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39R8Ig9J028975;
        Fri, 27 Oct 2023 08:18:42 GMT
Received: from t460-2.nl.oracle.com (dhcp-10-175-63-126.vpn.oracle.com [10.175.63.126])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3tywqjeb1g-1;
        Fri, 27 Oct 2023 08:18:41 +0000
From:   Vegard Nossum <vegard.nossum@oracle.com>
To:     linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Jani Nikula <jani.nikula@intel.com>, linux-kernel@vger.kernel.org,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Alex Shi <alexs@kernel.org>, Armin Wolf <W_Armin@gmx.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Fangrui Song <maskray@google.com>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        gaochao <gaochao49@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Hu Haowen <src.res.211@gmail.com>,
        Iwona Winiarska <iwona.winiarska@intel.com>,
        Julien Panis <jpanis@baylibre.com>,
        =?UTF-8?q?Ricardo=20Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Rui Li <me@lirui.org>, SeongJae Park <sj@kernel.org>,
        Stephan Mueller <smueller@chronox.de>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Wu XiangCheng <bobwxc@email.cn>,
        Yanteng Si <siyanteng@loongson.cn>
Subject: [PATCH RFC 00/11] use toctree :caption: for ToC headings
Date:   Fri, 27 Oct 2023 10:18:19 +0200
Message-Id: <20231027081830.195056-1-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_06,2023-10-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=995 mlxscore=0
 spamscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310270071
X-Proofpoint-ORIG-GUID: 5n8XoDvp4eVjVNc4RjObMxsMmhX2I6dg
X-Proofpoint-GUID: 5n8XoDvp4eVjVNc4RjObMxsMmhX2I6dg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch series replaces some instances of 'class:: toc-title' with
toctree's :caption: attribute, see the last patch in the series for
some more rationale/explanation.

There are some dependencies here: the first patch is necessary for the
headings in following patches to be styled correctly with the alabaster
theme (rtd_sphinx already has it), and the last patch depends on most
of the previous patches to not use the old .toc-title class anymore.

Assuming people agree with the general direction, I thought maybe the
easiest thing would be to collect maintainer acks in this round and
then for me to resubmit everything to the documentation tree/maintainer
in one go.


Vegard

---

Vegard Nossum (11):
  docs: style toctree captions as headings
  doc: userspace-api: properly format ToC headings
  media: admin-guide: properly format ToC heading
  crypto: doc: properly format ToC headings
  Documentation: dev-tools: properly format ToC headingss
  docs: driver-api: properly format ToC headings
  input: docs: properly format ToC headings
  doc: misc-device: properly format ToC heading
  media: doc: properly format ToC headings
  docs: use toctree :caption: and move introduction
  docs: remove .toc-title class

 Documentation/admin-guide/media/index.rst     | 10 +---------
 Documentation/crypto/api.rst                  |  5 +----
 Documentation/crypto/index.rst                |  5 +----
 Documentation/dev-tools/index.rst             |  5 +----
 Documentation/driver-api/index.rst            |  5 +----
 Documentation/driver-api/media/index.rst      |  7 +------
 Documentation/driver-api/mei/index.rst        |  7 +------
 Documentation/driver-api/pci/index.rst        |  5 +----
 Documentation/input/input_kapi.rst            |  5 +----
 Documentation/input/input_uapi.rst            |  5 +----
 Documentation/input/joydev/index.rst          |  5 +----
 Documentation/misc-devices/index.rst          |  5 +----
 Documentation/process/development-process.rst | 19 +++++++++----------
 Documentation/sphinx-static/custom.css        |  3 +++
 .../sphinx-static/theme_overrides.css         |  5 -----
 .../it_IT/process/development-process.rst     | 19 +++++++++----------
 .../translations/zh_CN/dev-tools/index.rst    |  5 +----
 .../zh_CN/driver-api/gpio/index.rst           |  3 +--
 .../translations/zh_CN/driver-api/index.rst   |  5 +----
 .../zh_CN/process/development-process.rst     |  5 ++---
 .../zh_CN/userspace-api/index.rst             |  5 +----
 .../zh_TW/process/development-process.rst     |  5 ++---
 Documentation/userspace-api/index.rst         |  5 +----
 .../userspace-api/media/cec/cec-api.rst       |  7 +------
 .../userspace-api/media/drivers/index.rst     |  7 +------
 .../userspace-api/media/dvb/dvbapi.rst        |  7 +------
 Documentation/userspace-api/media/index.rst   |  7 +------
 .../media/mediactl/media-controller.rst       |  7 +------
 .../media/rc/remote_controllers.rst           |  7 +------
 .../userspace-api/media/v4l/v4l2.rst          |  7 +------
 30 files changed, 49 insertions(+), 148 deletions(-)

-- 
2.34.1

