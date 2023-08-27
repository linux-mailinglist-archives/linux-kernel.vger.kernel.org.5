Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73E078A14F
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 22:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjH0UAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 16:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjH0UAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 16:00:30 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13B4D2;
        Sun, 27 Aug 2023 13:00:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1693166421; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=n29KMFT9LUqXMTiGfrcgZ1WJVfcU1UqvoI0j9MaUZImMLFUxsNUM+zrYz60blZFsvS
    2Aoy9IaDqKIlLjz4EqN6br/gwJzb91ifyEgk9AIA8NU7B5RKWRQzlidkUVDucPuTPKDC
    cZj9SxfdbSlyBrPvdD3X6GSDmCgxgj+nF8yAjUdbKcMhwkNmkDNtzir/LJF4U4hrGdeE
    kFig1NEZoyrs4eI2XuvqzsFwlriBsbxlIMKRcvDv3eQqpQeSj8wTJh34mAgKSEZXQcWj
    QTwBKWSuIDysKsGNvQAXwBO6I6UkZxcyfxSAYLJVLM/HK/ZwcyoP3u5sAP4qUH/aLXpV
    LFZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1693166421;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=mG2dNTCAT3TkiRlma4d9c7u6MnfchdUbkVvUaliYrxM=;
    b=BDGbq4+Q8Ow4fkTMgqmu94hoki2hTX5adwgNXKCF7XHArzgHEn7UkLEnJUkI4eeQF8
    aWdKWT/QyzvWt9N38W/Xqalutmp63p0xb8fdiO6X+KiecMLE2mMPo5ef8KN80vg9qeur
    XR8Zm2LFuE+hBSWB8Lvnyxu6JiyTBKh0jtTpHFC/G40So9B1u01ZX5fCLW+YT4BRCS3e
    bFZOhqOPkb9jDWoS2n6iHt5boCLJwz2VR6pOXXBVkcEbgT39d39L3V5pI4bicIMjy/0Q
    0Krt24GvJ4TuU7HAasOmyfFo/ZIwGEwhfozF3RMUw9yaFULRPmsDYhjUNj7CKmbOGhrO
    E0wQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1693166421;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=mG2dNTCAT3TkiRlma4d9c7u6MnfchdUbkVvUaliYrxM=;
    b=WvFKObwi6YYRc+MjIika6C5Bw1YBTRSoy5CVm064YwEiNY/JQP1w24idc1WnQlPVTH
    dHGYvvU6dANmzcJ+QpMQYNSQx0J0qpDhb3ZItjQuDT+qJUuyu5HSWIgqrF17q6hUQZ+x
    zed8HQxmXWhHcTKz3i2+5iaT/sqk9qnb8vosF8nmdrxu9fkDqsx3mTGeR52Lg1rRgudd
    HidTPgiJZ7GLiIuBqCsaW4SUvTOi7cyV4ScrSXW8I6uwEirr2cZK9XwxEmEDtS83iXRk
    YMKzoS1jNXcj4Bh1UKs4t06/OdRUsSL6+GEFGLIMZltf4mvIwUxdrEpIvq338fblr2p2
    ZzfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1693166421;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=mG2dNTCAT3TkiRlma4d9c7u6MnfchdUbkVvUaliYrxM=;
    b=MeWcSVOHaCGVmaBpk9Cq+dIEZdga/MMADUnmSUsWVNrbeGI1jhwcbVARkzstqHBKYY
    npC/LtE1gSTom9V99lBw==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSeBwhhSxarlUcu05JyMI1zXvWpofGAXgHo0XWHKDlYAejwGNCCoGOq4Rv11P+DncSQ=="
Received: from p200300c58732de590d9d761da94f5319.dip0.t-ipconnect.de
    by smtp.strato.de (RZmta 49.8.1 AUTH)
    with ESMTPSA id z2ebaaz7RK0JFjo
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 27 Aug 2023 22:00:19 +0200 (CEST)
Message-ID: <07a52c7643215c2dedd541df60c1a8499666f24a.camel@iokpp.de>
Subject: Re: [PATCH v1 0/2] Changes for UFS advanced RPMB
From:   Bean Huo <beanhuo@iokpp.de>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com,
        asutoshd@codeaurora.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        cang@codeaurora.org, jonghwi.rha@samsung.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 27 Aug 2023 22:00:19 +0200
In-Reply-To: <20230809181847.102123-1-beanhuo@iokpp.de>
References: <20230809181847.102123-1-beanhuo@iokpp.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-08-09 at 20:18 +0200, Bean Huo wrote:
>=20
> Bean Huo (2):
> =C2=A0 scsi: ufs: core: Add advanced RPMB support where UFSHCI 4.0 does
> not
> =C2=A0=C2=A0=C2=A0 support EHS length in UTRD
> =C2=A0 scsi: ufs: core: No need to update UPIU.header.flags and lun in
> =C2=A0=C2=A0=C2=A0 advanced RPMB handler
>=20
> =C2=A0drivers/ufs/core/ufs_bsg.c |=C2=A0 3 +--
> =C2=A0drivers/ufs/core/ufshcd.c=C2=A0 | 14 ++++++++++----
> =C2=A02 files changed, 11 insertions(+), 6 deletions(-)
>=20


Hi Martin and Bart,

what's opinion of this series of patch??

Bean
