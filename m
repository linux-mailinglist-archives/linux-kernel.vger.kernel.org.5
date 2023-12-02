Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B22801DA3
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 17:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbjLBQCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 11:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjLBQCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 11:02:40 -0500
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F7C129;
        Sat,  2 Dec 2023 08:02:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1701532957; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Mba3yLAjCNFN7TqM72UcT1PMiLw9ZXaBS2xqGvH78aK8Hl+6X8mflR1GWCHqAG/7xD
    1DLWcgFSTuV9xMPmbmnWEwtaSW6dZQb5gcWfF5bx3rQtNcsuRDNyTrm21QImt+00zOmq
    eD/FASXU84pJaLxHx8TASklrjELJ+Vmty3IdY1jCccMK5ugzvvJkgSgIrOU/46RmDWQ9
    cDINKgHyOWpj3/qy7binNyLz5OsfhYxMFZtFXSVT7qE47WFiAG53O5LZ8Ok/80VXYOIE
    KOUj8YcNaQcFjSAk8lW9YDBZ3OVkzf+FvJHqlqLVdTlpAFyz4wXJ5sgojm0OGEvCsqEm
    Lkdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1701532957;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=LXKxrrhtGIdXauUihykJ3ZGi4SIcrDZSrwSO/TvC4Oo=;
    b=ODzoh84ksfgwMb9aSMragqnT8XX6liHGt5ku8/5t8d8JWKCq8VsvR2EGKQnxFUgeJd
    ghYwX9S/eHkkylsNortdk4Oz6tTsCaHYMA/0O21Z5VWDgwJtE/8UMUv2s7IwiS4CPqKF
    +7WK1RjnQ+5+DwlJJBANIgjfHVQLOqwNToiV1oyBwvDBFHqg6aKGdvmZmHbYVKrglq7L
    owlHc7NUq+2ZjMtxNyS0UR79Wn2BGWrpx246osVKopV7wNH/FKyKBoRzY5vX5nSAUdda
    LLt+Dpvtw3ANaSdsPWnW4aVNZc0S4iHjXEVcNlRob4LoLCdc6Imj0M9Pj+sM7iP2MhUe
    mOBw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1701532957;
    s=strato-dkim-0002; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=LXKxrrhtGIdXauUihykJ3ZGi4SIcrDZSrwSO/TvC4Oo=;
    b=Gh/IHCFqM4S5DlacBKMim1vyXribJAccuk4yE7ZSxw74ci97EpitZ8dXN/udVyekei
    pShUDfaqDADl//WDQ4s+zSo85T518F5KHXd2u10rvLZTIUj/MSUo9rKDgA6jbwTI3yv+
    aoxYEVFVWnBx70Zh+dP9LItdEdc5LJQyR3utTN/mXqmna2XyJIlKOS31RHYoqPwYLq5a
    aHkPMZoK2Bp+x0YH5c3bC9EnKKNkWkeq7x3yI2Eyc9W7WyqDRLwX0vb8ak4xxIwQDfld
    FZ7mq67MbNrT9HtoWl/jupWFtt7H0l4PqTPauCEU0cQS6TuK/KoT0+1rYuiUTa142lC8
    9Img==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1701532957;
    s=strato-dkim-0003; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=LXKxrrhtGIdXauUihykJ3ZGi4SIcrDZSrwSO/TvC4Oo=;
    b=QuZ8Rm4VFE+VZSd4CmmrFKBkaWnuOGl1Y+r72uxypq6e3YgLSUUHq+6FfzzkTzVTiu
    tlwC2OQCKTtPEHWC9BBg==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD1QLj68UeUr1+U0BfWsYLe+bQusZClHgu6POSIuOZDSGI3MA01fA=="
Received: from Munilab01-lab.speedport.ip
    by smtp.strato.de (RZmta 49.9.7 AUTH)
    with ESMTPSA id z8d451zB2G2a5CI
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sat, 2 Dec 2023 17:02:36 +0100 (CET)
From:   Bean Huo <beanhuo@iokpp.de>
To:     avri.altman@wdc.com, bvanassche@acm.org, alim.akhtar@samsung.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com, mani@kernel.org,
        quic_cang@quicinc.com, quic_asutoshd@quicinc.com,
        beanhuo@micron.com, thomas@t-8ch.de
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikebi@micron.com, lporzio@micron.com, Bean Huo <beanhuo@iokpp.de>
Subject: [PATCH v3 0/3] Add UFS RTC support
Date:   Sat,  2 Dec 2023 17:02:24 +0100
Message-Id: <20231202160227.766529-1-beanhuo@iokpp.de>
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

 Documentation/ABI/testing/sysfs-driver-ufs |  7 ++
 drivers/ufs/core/ufs-sysfs.c               | 31 +++++++
 drivers/ufs/core/ufshcd.c                  | 96 +++++++++++++++++++++-
 include/ufs/ufs.h                          | 15 ++++
 include/ufs/ufshcd.h                       |  4 +
 5 files changed, 149 insertions(+), 4 deletions(-)

-- 
2.34.1

