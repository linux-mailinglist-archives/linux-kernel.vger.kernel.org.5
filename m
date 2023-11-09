Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0853B7E6AD9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 13:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbjKIMwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 07:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjKIMwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 07:52:38 -0500
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F592D74;
        Thu,  9 Nov 2023 04:52:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1699534346; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=gkXhb4EAeN/8TB+P9e8EOU6kTSEni/p9SgHPiwIba8zSgXOavDS4udc2o8Fm+ZW0x4
    45mZWa2VAwztVxCHUqhhd5EgQWO4YtUpw8LDwShkZe0plP9wZ+jIUmaPT4tU4NtEHGod
    uf8Xxp4BI+OrjnJRn2rCBvtQt6rY194xajds0dqWhNJvVAUWN+EgbKb4pKaUsuecaUtJ
    pMvK5JqLIPdQ21At7H3usKv19sMAhskwoI5Qj9XmmkVo1Wz9942dXLT+OZs6ZkvcURFb
    jPL7tk87VPqKncf/Ib8NHTEEZ3hpxMc3u0LfeXyBHSFHC7ybGSrrLp6ft9BeC+LvpRxD
    FmnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1699534346;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=EwkKdMTXCxt30OJjQRKdnjrNwC6JgXG5wvnseqvKzpk=;
    b=kFri3/L/VvKjFBdepWFUGYMXUn5v+b1Ltre/O+x5f0u3NVJF/8+4XDkMIUhtbsp/5U
    hULjh8RBRUS7utLM96dhzayn0ChxdEeTjMYSeK7OXYVh57jxHKL7ye+4W0JQXEweVuJJ
    t3PawKfNBrLZ8g383OxhMyQiF00E3coUta8qkuX1ymYwmbU3PnhJvjN6nlW6P/ddN+hi
    +lMr3aM7kCMBs7giGTeDl34opIWYooGo32xGbSA4kORj0QDf5/2rHo3ErdzzRsOBA4dN
    rszK4hOIxNbn8L3sf8rEvlXmEQK6dYxXnMf4GQyP6gm3O3NetYdW0xV6bDwxdNdCAMyG
    L9jg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1699534346;
    s=strato-dkim-0002; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=EwkKdMTXCxt30OJjQRKdnjrNwC6JgXG5wvnseqvKzpk=;
    b=kizJ7ps0K5Z3sO37joGNtFt1KGEioSp7R1QriOEPGjiaBJnMY9DCgdaHRgZ6wlERZN
    No8EARKWyWDVZ/8Fckm48G+SfI/y80MmVawA2qqmZopW9uFF6Llx897Hi22zUnJIcYJd
    r/FPCvP+kZg7xnK1cuKjwx7svf/dry3Wm/FHnv7Y1eOMsHdexPe57cj5KuLg3v+8BFrC
    wIb2p04S+U6BiaQgQI6byVLGf3xZizyWWPxJAdDOSWdI/SKu/4wk//f7jSLH1KlyrIol
    EldylsCOd019f3qtYV7QWeH/OzEjyMNB+wo4cGDMKjrd8iSM/hMY1plLo2ecW5LjiwyO
    FGcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1699534346;
    s=strato-dkim-0003; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=EwkKdMTXCxt30OJjQRKdnjrNwC6JgXG5wvnseqvKzpk=;
    b=hnpFd1PFSoTgLU1Naz7N3Z/MVX2Kn58WY6RaY43YtgCNRyOCSjQi0xs+A1ZQhP3aeQ
    +RF4E6q0Hpb6xzlexNAA==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD2QzemV2tdlNlNRZBXiUw="
Received: from Munilab01-lab.micron.com
    by smtp.strato.de (RZmta 49.9.1 AUTH)
    with ESMTPSA id zd0181zA9CqPvYm
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 9 Nov 2023 13:52:25 +0100 (CET)
From:   Bean Huo <beanhuo@iokpp.de>
To:     avri.altman@wdc.com, bvanassche@acm.org, alim.akhtar@samsung.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        stanley.chu@mediatek.com, mani@kernel.org, quic_cang@quicinc.com,
        quic_asutoshd@quicinc.com, beanhuo@micron.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikebi@micron.com, lporzio@micron.com, Bean Huo <beanhuo@iokpp.de>
Subject: [PATCH v1 0/2] Add UFS RTC support
Date:   Thu,  9 Nov 2023 13:52:15 +0100
Message-Id: <20231109125217.185462-1-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

*** BLURB HERE ***

Bean Huo (2):
  scsi: ufs: core: Add UFS RTC support
  scsi: ufs: core: Add sysfs node for UFS RTC update

 drivers/ufs/core/ufs-sysfs.c | 31 ++++++++++++
 drivers/ufs/core/ufshcd.c    | 92 ++++++++++++++++++++++++++++++++++++
 include/ufs/ufs.h            | 20 ++++++++
 include/ufs/ufshcd.h         |  2 +
 4 files changed, 145 insertions(+)

-- 
2.34.1

