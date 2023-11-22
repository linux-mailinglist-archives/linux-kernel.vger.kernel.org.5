Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79EFF7F4F15
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 19:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343917AbjKVSOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 13:14:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344138AbjKVRZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 12:25:40 -0500
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9DE1A8;
        Wed, 22 Nov 2023 09:25:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1700673927; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=abCgx4AF8it3rbnfV1rkZssmAYVuxPxpNERpKXRcA0114brrf2NN/jtthPMVkUlir2
    p7L0+S3P6rhPM88x02eb+718kVLMDhsiXlY+d2qnRxUDvXOxqWqtexYO8fCrNOiixAOa
    w2s8ELhyB+OSxQINUYPbLfeXIsXOdCSy5t7nKqlHr5uBqaZoCQbkbAxZxcRubrsXcunX
    p7SxHLHnjPLqmCHssI7gr5SsMt7OBA/650EPkYHgW32DrqLggt47rjBkj+TfvA8mMUGZ
    UhXUX0f5Wdho4XHVDQXZDYtbcQZx7acHls4Jc0IXLelPZI8Cn+GPLjPS/QgJlUK27d8X
    ajrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1700673927;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=kUUNqUyztDKZGEF+K7SzcTLAtx3TE3aCGIBy3VFBZl0=;
    b=Ah4+a+EeqUJNzIbz36S/NRai0/l/tqtAMUeBqxQnR9a00KZ7YLpFK/U2iIWkHHLE/S
    BR9b0eVw3W2Ojg7m8PpqHNaTPMYSbcBATseSkKH6jacHMeqrgTUwszNBrQ09NA0LfLqG
    HlUSjmr0SZMxQueVYBuXOrW5I1WEg47UOL0YNiNbs2QJrx4A7iFP7plNkjH7uGghaE4h
    N+nqkl/1I47WcLjjIEOctla9ghTGzFxCLFNzNYza0ts8QfQWfTdBhfsCkd8qCSxW7TZy
    sfQdKij17GDIPSQMJCUXGKge91x8yz/jYU/7c0LnqWr8S/qodwedZrTG+V4eP4upukyw
    Tbfw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1700673927;
    s=strato-dkim-0002; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=kUUNqUyztDKZGEF+K7SzcTLAtx3TE3aCGIBy3VFBZl0=;
    b=LSpCacYEM6qrK83dmCXUDdkfV0jMvpbmiO/0TQOe5Ee7sp2s4DLrPU9bQxpJiv5SA6
    1jvGC4IMhkWUAn41ql2r1e8PBR2en10gVFgupuFY12dZtRKQdJGbwI7negiGDsAuFyBE
    bwthb52PXQpAx6ARNcNCIfZuhC2NB88M1Yj15vm5B2Pde/Ir5JtUVghJVwVLrNwDCNMe
    zY7HG0N5Kz3feUdKckcVFW/eLqhWcJRgfu6e+ifaoz+JLgon3NxlDKtFgVT8IbIlwz42
    Bq9z2fDJBUYBUp092i5n82o4MoaHFlEvBAO61ZHnBbpr1hNLrlBj+44QoLj7k2ZUk/4N
    PtIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1700673927;
    s=strato-dkim-0003; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=kUUNqUyztDKZGEF+K7SzcTLAtx3TE3aCGIBy3VFBZl0=;
    b=CpJCIHqZMF9K0R+yRrOzdWx19RVFgMNDp9MN5tZD4KK418fN0P4p5m5z+L/m/aypg/
    I6Yug8PxlIcmW3Fb52Ag==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD2QzemV2tdlNlNRZBXiUw="
Received: from Munilab01-lab.micron.com
    by smtp.strato.de (RZmta 49.9.1 AUTH)
    with ESMTPSA id z758a5zAMHPQtqH
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 22 Nov 2023 18:25:26 +0100 (CET)
From:   Bean Huo <beanhuo@iokpp.de>
To:     avri.altman@wdc.com, bvanassche@acm.org, alim.akhtar@samsung.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com, mani@kernel.org,
        quic_cang@quicinc.com, quic_asutoshd@quicinc.com,
        beanhuo@micron.com, thomas@t-8ch.de
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikebi@micron.com, lporzio@micron.com, Bean Huo <beanhuo@iokpp.de>
Subject: [PATCH v2 0/3] Add UFS RTC support
Date:   Wed, 22 Nov 2023 18:25:09 +0100
Message-Id: <20231122172512.103748-1-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding RTC support for embedded storage device UFS in its driver, it is important for a few key
reasons:

1. Helps with Regular Maintenance:
The RTC provides a basic way to keep track of time, making it useful for scheduling routine
maintenance tasks in the storage device. This includes things like making sure data is spread
evenly across the storage to extend its life.

2. Figuring Out How Old Data Is:
The RTC helps the device estimate how long ago certain parts of the storage were last used.
This is handy for deciding when to do maintenance tasks to keep the storage working well over time.

3. Making Devices Last Longer:
By using the RTC for regular upkeep, we can make sure the storage device lasts longer and
stays reliable. This is especially important for devices that need to work well for a long
time.

4.Fitting In with Other Devices:
The inclusion of RTC support aligns with existing UFS specifications (starting from UFS Spec 2.0)
and is consistent with the prevalent industry practice. Many UFS devices currently on the market
utilize RTC for internal timekeeping. By ensuring compatibility with this widely adopted standard,
the embedded storage device becomes seamlessly integrable with existing hardware and software
ecosystems, reducing the risk of compatibility issues.

In short, adding RTC support to embedded storage device UFS helps with regular upkeep, extends
the device's life, ensures compatibility, and keeps everything running smoothly with the rest
of the system.

Changelog:
	v1--v2:
		1. Add a new patch "scsi: ufs: core: Add ufshcd_is_ufs_dev_busy()"
		2. RTC periodic update work is disabled by default
		3. Address several issues raised by Avri, Bart, and Thomas.


Bean Huo (3):
  scsi: ufs: core: Add ufshcd_is_ufs_dev_busy()
  scsi: ufs: core: Add UFS RTC support
  scsi: ufs: core: Add sysfs node for UFS RTC update

 Documentation/ABI/testing/sysfs-driver-ufs |  7 ++
 drivers/ufs/core/ufs-sysfs.c               | 31 ++++++++
 drivers/ufs/core/ufshcd.c                  | 90 ++++++++++++++++++++--
 include/ufs/ufs.h                          | 15 ++++
 include/ufs/ufshcd.h                       | 12 ++-
 5 files changed, 149 insertions(+), 6 deletions(-)

-- 
2.34.1

