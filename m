Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A841080F9F0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 23:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377686AbjLLWIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 17:08:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbjLLWIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 17:08:40 -0500
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1A8B3;
        Tue, 12 Dec 2023 14:08:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1702418917; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=IaL+LtM/3sr6O7C1Kk7kUq5UUfMeWCAeOz5bfzNSfCDsRSpInihXPzis28eRbPjM8P
    9JrqzST3sg8YO9t1qIT6khqoPFxqIENVDj/hv741nRYUnwWMWYinxc0ItWFpa1FL1aIm
    xCCZU/qMpjxfv/qS3v2Sr1FSihqyMQQSZaXxsEjpP/k51H0iACsMFA58nsFkQfl1zvup
    PYN34+523OZCzmNWo+56ccj6KSUFqowZV5gtA6akO2rERDMk3c58yo7rNhlBAC45xloQ
    yIpzFMxfkIaDI1WuOACxNuo6h/khQwCSbG1sY0taiVAcpwi6ssxOJ7y1eiJN6GQc9w1l
    DoNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1702418917;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=7Ti5UcywgqFS+9CZzfTbKXKYv/LJc+sEGxe+xBAGoFo=;
    b=qfLzIDH3oMZhRbuvUDQYzmhq9OU/1l2aBqXjBiZRdXBRfNlKc7KHYcShl99xf6tisT
    JHepcRlFjgYn+/nAql3zTBd305542Ljhv5NQoa45Q+xOcrJ9wt2GR7wwIZYmR65dpiwK
    Zi+wZb50f5RTl+N+qncbp6oFYRjpHZlQLq54N59vgOFt2j3IzvZB1h1Us6a1Frt8Wowt
    dljGHTKk5pFuR307YOiTj8lqWth/oFbGEFqBxrRXCwT3gW1mozfSiRq1+hNqP4hWs0l4
    RMVPNqWaBPuZFCN3TY0Jjf1TF5GBZI8IDkpHx39Qk/He1liUJWQFMjXFtDr7KFxp6G7J
    IQPA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1702418917;
    s=strato-dkim-0002; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=7Ti5UcywgqFS+9CZzfTbKXKYv/LJc+sEGxe+xBAGoFo=;
    b=pqnSL8Fj5n3A/v8BqnxaxxW57LiBqBI3IddBFTg+rui2xw9kx9UlEl7bvbbl65jdTb
    /pfKBBqb3FVMP9t6/bwxlQsVqlRVV33uPHjyroPhy86UqjmzndPZm8Ax3vUdP7srVZbI
    OcILIAh+VWbR5CDwAmVF63rdIRvdhzNJJfQ3+4SOkSB6n61pflY8HgWqc7Qnj9YEE55S
    STJBs7xptY9QDJxZk3BW4gQDrLPYiv5YOmqlPCl63bCHTDQhDO45JBBOPCcgOtoQ22eP
    rvjibwQBik77AgtNmICXK3JJ71LCoHfW8nZwnkdQGC5d5yh4s+8y0WU1bekeDPCo/W17
    bbYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1702418917;
    s=strato-dkim-0003; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=7Ti5UcywgqFS+9CZzfTbKXKYv/LJc+sEGxe+xBAGoFo=;
    b=KjzdvV6smK54+DJV1mtGbUIEWgex8tEvdXBsPmoYP9LS4crwXfCv5g9csJuTqVrYVW
    QEeTRR9UGIo11QtXH4CQ==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD1QLj68UeUr1+U1krW49WPrbTU8waUHk0CK6S5K43N4UTp8lPg"
Received: from Munilab01-lab.speedport.ip
    by smtp.strato.de (RZmta 49.10.0 AUTH)
    with ESMTPSA id z4c2a6zBCM8aNVy
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 12 Dec 2023 23:08:36 +0100 (CET)
From:   Bean Huo <beanhuo@iokpp.de>
To:     avri.altman@wdc.com, bvanassche@acm.org, alim.akhtar@samsung.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com, mani@kernel.org,
        quic_cang@quicinc.com, quic_asutoshd@quicinc.com,
        beanhuo@micron.com, thomas@t-8ch.de
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikebi@micron.com, lporzio@micron.com, Bean Huo <beanhuo@iokpp.de>
Subject: [PATCH v5 0/3] Add UFS RTC support
Date:   Tue, 12 Dec 2023 23:08:22 +0100
Message-Id: <20231212220825.85255-1-beanhuo@iokpp.de>
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

Adding RTC support for embedded storage device UFS in its driver, it is
important for a few key reasons:

1. Helps with Regular Maintenance:
The RTC provides a basic way to keep track of time, making it useful for
scheduling routine maintenance tasks in the storage device. This includes
things like making sure data is spread
evenly across the storage to extend its life.

2. Figuring Out How Old Data Is:
The RTC helps the device estimate how long ago certain parts of the storage
were last used. This is handy for deciding when to do maintenance tasks to
keep the storage working well over time.

3. Making Devices Last Longer:
By using the RTC for regular upkeep, we can make sure the storage device lasts
longer and stays reliable. This is especially important for devices that need
to work well for a long time.

4.Fitting In with Other Devices:
The inclusion of RTC support aligns with existing UFS specifications (starting
from UFS Spec 2.0) and is consistent with the prevalent industry practice. Many
UFS devices currently on the market utilize RTC for internal timekeeping. By
ensuring compatibility with this widely adopted standard, the embedded storage
device becomes seamlessly integrable with existing hardware and software
ecosystems, reducing the risk of compatibility issues.

In short, adding RTC support to embedded storage device UFS helps with regular
upkeep, extends the device's life, ensures compatibility, and keeps everything
running smoothly with the rest of the system.

Changelog:
	v4--v5:
		1. Fix coding type issues in patch 2/3
		2. Move ufs_rtc_update_work init to ufshcd_init()
		3. Move ufshcd_state != UFSHCD_STATE_OPERATIONAL checkup out of ufshcd_is_ufs_dev_busy()
		4. Remove inline keyword
	v3--v4:
		1. Incorporate a check for "Current time precedes previous setting" in ufshcd_update_rtc()
		2. Eliminate redundant return value code in ufshcd_update_rtc().
        v2--v3:
                1. Move ufshcd_is_ufs_dev_busy() to the source file ufshcd.c in patch 1/3.
                2. Format commit statement in patch 2/3.
        v1--v2:
                1. Add a new patch "scsi: ufs: core: Add ufshcd_is_ufs_dev_busy()"
                2. RTC periodic update work is disabled by default
                3. Address several issues raised by Avri, Bart, and Thomas.

Bean Huo (3):
  scsi: ufs: core: Add ufshcd_is_ufs_dev_busy()
  scsi: ufs: core: Add UFS RTC support
  scsi: ufs: core: Add sysfs node for UFS RTC update

 Documentation/ABI/testing/sysfs-driver-ufs |   7 ++
 drivers/ufs/core/ufs-sysfs.c               |  31 +++++++
 drivers/ufs/core/ufshcd.c                  | 101 +++++++++++++++++++--
 include/ufs/ufs.h                          |  14 +++
 include/ufs/ufshcd.h                       |   4 +
 5 files changed, 151 insertions(+), 6 deletions(-)

-- 
2.34.1

