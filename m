Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D420B776720
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 20:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbjHISWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 14:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjHISWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 14:22:05 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E8AA3;
        Wed,  9 Aug 2023 11:22:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1691605138; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=XM4sr2CAYdhjssDICKDMRF5ZfstZlvok/UwBedCxUO2BvIX0CTmddYEdzKdR346awf
    EwUL67Q7+uB+ovWirm0/qQzk8/3ho7hffXB33YX+/yl+d61hrzc6g7uwAOumol1W3+SE
    Q5BIsFI/t4gLInQNlpwacHspw6NjGxd27n1p6Ga5WyvLCe3x9RhbGCykJq9CK3xcEktj
    H7VmqF7NodHCB04yV6uMT0ni+5PelDDwvCGY+A/2NJ8PpMWn7WvL9SgIXwRcQZSrrRw6
    Q11X2bnO7zfluADApepsd1zr9zdtSmQA0v1sex3hM82ZdYAYjJNVcyVwU7nEHVW0c0dk
    EPNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1691605138;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=akOL4x92l/R4AJBfp0LVm9K4HuoWtw92adyC60DXSDI=;
    b=FlZyQqaEIjHokMB1O3YEEe9fN0lkBPIFYdbuzrbfAT9GjZkr0xsbVDhRXc9Wz1QKg/
    Iz97cOd6hR/6oGQdaoREeGw7GdQhWVxmF8ZhdPTQDjF3hPjzgA6ot/cPyytL5vbbILLS
    ZyYAQ4rxF63js0vcYvjmeGvZ1DXe+972QUTxaAklZW6IMNQysBuGn3NDfHrqO2H+SNvr
    iZ4PWuPkdbDpQGgICjCSqjenobXlQTQboFGrkqBtZsIy8hVQa/9DYON0sRykS7rAaop+
    xIdfWc3h28LGFTVL0ZdzM+75AZcT27GFTskoKZ+J1b+i1wHBIwBgcsupVrrvkmyp2GrA
    3X/Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1691605138;
    s=strato-dkim-0002; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=akOL4x92l/R4AJBfp0LVm9K4HuoWtw92adyC60DXSDI=;
    b=ZEAkR+394O8qX1L1g/S9gIKe/rHmWWMT0V8fUGcNPx1l2M7hhyNJ9Qt1Ilo+dW2VF7
    KA/+0mB3CZks36k9P15QY9MeYwxLRkKY+RICJFO26Sr7E4GGtFV8NymXcAdw8lV4T/ZJ
    x8jw/o9hyvCzC/gBF7R7W79qYEFmJYiqY8mTzjUzfuUqwbNysXwUcgSQvDRo2z4NNfij
    /Q4sCTZ+nPKypZd7nKp3G4qD415kdxPmrCPnn5VFTEKqxRVVbKQBe+lL7CheJ/T4Vfau
    2pz6xDKmQScggMV7WYDoTvvm1D36DJdzzXbQbDbgjY1B6KEPhxNnhRfhZVQwEcffWNjj
    ub8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1691605138;
    s=strato-dkim-0003; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=akOL4x92l/R4AJBfp0LVm9K4HuoWtw92adyC60DXSDI=;
    b=yoHzjYe+FxjKBxX2dHgrY1pSYRbMykMPPaJdKBnqyeoN0f9PopR3B9ScA1VC7LOLRK
    XMS5O8braDlm5lC8JMBw==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD1QLj68UeUr1+U1B7WtoHeqrQNqrexjtNBJQI8izfAF0DFZj1zmA=="
Received: from blinux.speedport.ip
    by smtp.strato.de (RZmta 49.6.6 AUTH)
    with ESMTPSA id z12fdaz79IIuh6y
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 9 Aug 2023 20:18:56 +0200 (CEST)
From:   Bean Huo <beanhuo@iokpp.de>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com,
        asutoshd@codeaurora.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        cang@codeaurora.org, jonghwi.rha@samsung.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bean Huo <beanhuo@iokpp.de>
Subject: [PATCH v1 0/2] Changes for UFS advanced RPMB
Date:   Wed,  9 Aug 2023 20:18:45 +0200
Message-Id: <20230809181847.102123-1-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Bean Huo (2):
  scsi: ufs: core: Add advanced RPMB support where UFSHCI 4.0 does not
    support EHS length in UTRD
  scsi: ufs: core: No need to update UPIU.header.flags and lun in
    advanced RPMB handler

 drivers/ufs/core/ufs_bsg.c |  3 +--
 drivers/ufs/core/ufshcd.c  | 14 ++++++++++----
 2 files changed, 11 insertions(+), 6 deletions(-)

-- 
2.34.1

