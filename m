Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C599F76BEB7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 22:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjHAUs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 16:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjHAUsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 16:48:55 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA3F1982;
        Tue,  1 Aug 2023 13:48:53 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 371KExxM008438;
        Tue, 1 Aug 2023 20:48:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=qcppdkim1;
 bh=oJCS+x3JhjDoIexaW/EX09NVFqCt3LH9qSJgusuqsoU=;
 b=D/JbRKJ3+jjzbkQ7l/hu0Lxnfxe+tU59mhKAixs4RVch39TpCKe+4Wtfdh96yzbpKZHA
 oB6YRi5BtBin34HN2XV7aqaZ/mpVrZNfWJi80fbicczJBzc+VynfgEIsETnjTFpymMFH
 piu2KZrvn98AFzdaIb1duOGr75C1yK+B9g6qDxUYt4zI2t2VgYU/9HBN6IxqZs0qA7ds
 0N4ZB/rfRQ/1bGs9kAUWidSugyguLa+y8H5rVady7L42AW5DWe4LoBtGeH4krY2wOMDB
 QSJdJlcMGSYjQEuM/iP87EHaGftvcOr6hkA8haAOXL1mjSrw3R5QRm20gm3g+rfEW7Yq iA== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s75b30hyq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Aug 2023 20:48:29 +0000
Received: from pps.filterd (NASANPPMTA05.qualcomm.com [127.0.0.1])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 371Kcg7K031024;
        Tue, 1 Aug 2023 20:48:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA05.qualcomm.com (PPS) with ESMTP id 3s6g0pxy7p-1;
        Tue, 01 Aug 2023 20:48:28 +0000
Received: from NASANPPMTA05.qualcomm.com (NASANPPMTA05.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 371KjCpv006589;
        Tue, 1 Aug 2023 20:48:28 GMT
Received: from th-lint-014.qualcomm.com (th-lint-014.qualcomm.com [10.63.177.51])
        by NASANPPMTA05.qualcomm.com (PPS) with ESMTP id 371KmRkN010395;
        Tue, 01 Aug 2023 20:48:28 +0000
Received: by th-lint-014.qualcomm.com (Postfix, from userid 455663)
        id C5DDE6846; Tue,  1 Aug 2023 13:48:27 -0700 (PDT)
From:   Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
To:     "T . J . Alumbaugh" <talumbau@google.com>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        "mark . rutland @ arm . com" <mark.rutland@arm.com>,
        "will @ kernel . org" <will@kernel.org>,
        "virtualization @ lists . linux-foundation . org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-mm @ kvack . org" <linux-mm@kvack.org>,
        "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel @ lists . infradead . org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-arm-msm @ vger . kernel . org" <linux-arm-msm@vger.kernel.org>
Cc:     Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Sukadev Bhattiprolu <quic_sukadev@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Patrick Daly <quic_pdaly@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>
Subject: [RFC PATCH 0/2] vmrd: dynamic guest VM memory resizing daemon
Date:   Tue,  1 Aug 2023 13:47:12 -0700
Message-Id: <cover.1690836010.git.quic_sudaraja@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UkeaIKi4HYzp1e7cDt_v9jUSqjLTJGCW
X-Proofpoint-ORIG-GUID: UkeaIKi4HYzp1e7cDt_v9jUSqjLTJGCW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_19,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 mlxscore=0 spamscore=0 mlxlogscore=550 bulkscore=0 clxscore=1011
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308010185
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VM Memory Resizing Daemon (vmrd)

Initial idea of dynamic memory resizing for guest VMs was discussed here
in this thread below as a RFC.
https://lore.kernel.org/linux-arm-kernel/1bf30145-22a5-cc46-e583-25053460b105@redhat.com/T/

Posting the source-code for this userspace daemon written in native C++ as RFC
on such an approach for resizing the VM. We will be merging this into Github or
CodeLinaro after gathering all the review comments. The userspace daemon
registers to Linux kernel's PSI mechanism and it should work on any systems
running Linux with CONFIG_PSI enabled.

This daemon adds memory to guest VM when demand for memory increases,
and tracks for memory pressure going down as the usecase ends and frees
memory to release memory back to host proactively. virtio-mem is used
as interface for adding/removing memory in the guest VM.
More details on the detail and implementation in patch commit text and
RFC discuss thread mentioned above.

PATCH 2 shows the vendor specific implementation by Qualcomm on the memory
plugin interfaces for adding/removing memory to VM by using modified virtio-mem
driver, which uses mem-buf driver for communication between the VMs.
More details on PATCH 2.
This vendor specific implementation is shown just as a reference and different
user/vendor can have their own implementation.

We also intend to make these memory plugin interfaces generic so that we have an
upstream-friendly mechanism for lending memory from the host to guest VMs.
This is still on the works and wanted to seek upstream community's inputs on how
we can achieve this. This way, vmrd can run on any guest running Linux with
CONFIG_PSI and virtio-mem enabled which will be agnostic to the underlying 
Hypervisor.

Qualcomm has been using this daemon into its guest VMs for memory resizing.
This has been currently tested with Gunyah Hypervisor and not on any other
Hypervisor. Currently, the guest VM memory is resized by expanding Movable zone
only, since virtio-mem uses memory hotplug and Movable zone guarantees memory
blocks to be isolated and offlined. Next incremental patches of this feature
will be shared soon where both Normal and Movable zone can be resized, thereby
increasing headroom for both DMA (unmovable) and userspace (movable) memory.

Sudarshan Rajagopalan (2):
  vmrd: dynamic guest VM memory resizing daemon
  vmrd: add implementation of memory plugin interfaces

 Makefile.am |   14 +
 vmrd.cpp    | 1259 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 1273 insertions(+)
 create mode 100644 Makefile.am
 create mode 100644 vmrd.cpp

-- 
2.7.4

