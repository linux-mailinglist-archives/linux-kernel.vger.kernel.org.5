Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68C17EB692
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 19:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233937AbjKNSqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 13:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjKNSql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 13:46:41 -0500
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CD1CC;
        Tue, 14 Nov 2023 10:46:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1699987588; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=nHAJqL7WD+8lCNtg+k61CXehK3efDai2PcvuJ2t/hgIAk6hewdCdBqr2maMNdnGCEc
    EyrwzkdPRgGPJgRoO+sBoUHRBgyCPgDp0lTxiJ3apXlQgCkWqcpM2g3pBmCNr+MYk0zq
    P2YquTmeIAKEfbN+kYbXH9SeDJtGksq2sTqzLTp0s2pRc93kAHRE5xi2OoA+nJ0AQRYu
    Sbi9Ea+1Pz59Tpza3RJFG739shnys6h3k23nfCteFY7y0AsFEbhrZoTNcb2i2439FK0D
    iUNv1sUUI/qeSuAcEBz/gQ3PNxnYWmo+zF+zw9PD54HORIGxWMSGy12UwDVycce0giS3
    mp9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1699987588;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=N/iIv0hHUw7EhLX30XqC2yE+1gKSJVpe6lZNznP65uE=;
    b=pXsJxBKpAem4Y4fqhV/FCRb6rAS3omXfUjjEH46WplJO704wmcP++W+2SlGHOOyAs1
    DIf/MyHlFyZASqWMxTZDPkHQpp31hdHz/S5dPfVgpU6CL1oQCkiT23hwt95zUbNNRM3T
    QVXrje8sAeWcb8cXG7uWGF0D5ofXKj4RyOrTUL+sRKyZUO4RYKU5aGehxU5k5rLEENLF
    m5G/cIlLDIJjj9m6GkhdmFRn75C/ccoyflzY52z3l4PRQ8pJmXkR1B8Eti+Vwk4/TqHj
    1Dfn+xiZZgjCWCNBIcVy4TXz7FoURl3Ksi4GVoS1s6fRPe6hL1Q7yx8jLduJkEtfVlZv
    VDtQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1699987588;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=N/iIv0hHUw7EhLX30XqC2yE+1gKSJVpe6lZNznP65uE=;
    b=oqDeLYYx20rgL1QG1nsScfL0KBrRVKCcGuO0R6itJRXd2dVYK/3YFBiKbu9CJd7KqD
    dF4G3w8AmgViK72F55Rr01Vzp0A+G6+0jqPGsx2p6tQAKqQX2Ghu0JDuAaK7HdGLcSsW
    hps8x+5Ru/esVkKDf9mLDPKWX5Yv30KEn7sk0KLw0aUvx/PLMw4FXG8UmnFIe4YKTZiQ
    bQn0lZcu6nBaakVZl7mLY+WjrWITw3WXCF74b6L5fvJzzFvgthQ4Vx9l1m7xXa3w+q3Z
    bmaz5Jz0I3cHz2pyP79/yU3WK2LK7GB+5q4sRL1wLrie2LDqA0BRFKpO2FxqlnLGPkGN
    M+rw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1699987588;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=N/iIv0hHUw7EhLX30XqC2yE+1gKSJVpe6lZNznP65uE=;
    b=zOjmcymcbOg9HOG8EaooPUHUZLBVIrl+XmylgNxgJ8lbPiIu+TLQ1ZS/g4sv8zhzva
    iZ3atkuezCwkvIMkADDw==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSeBwhhSxarlUcu05JCAPyj3VPAceccYJs0uz"
Received: from [10.176.235.177]
    by smtp.strato.de (RZmta 49.9.1 AUTH)
    with ESMTPSA id z758a5zAEIkRV9W
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 14 Nov 2023 19:46:27 +0100 (CET)
Message-ID: <e946d56d5f9fd8458043b579ab47e4d9f8e88b04.camel@iokpp.de>
Subject: Re: [PATCH v1 2/2] scsi: ufs: core: Add sysfs node for UFS RTC
 update
From:   Bean Huo <beanhuo@iokpp.de>
To:     Bart Van Assche <bvanassche@acm.org>, avri.altman@wdc.com,
        alim.akhtar@samsung.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        mani@kernel.org, quic_cang@quicinc.com, quic_asutoshd@quicinc.com,
        beanhuo@micron.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikebi@micron.com, lporzio@micron.com
Date:   Tue, 14 Nov 2023 19:46:27 +0100
In-Reply-To: <fb80565a-9b91-4125-ac50-f8469f27c3b8@acm.org>
References: <20231109125217.185462-1-beanhuo@iokpp.de>
         <20231109125217.185462-3-beanhuo@iokpp.de>
         <fb80565a-9b91-4125-ac50-f8469f27c3b8@acm.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart,


On Thu, 2023-11-09 at 10:07 -0800, Bart Van Assche wrote:
> On 11/9/23 04:52, Bean Huo wrote:
> > This patch introduces a sysfs node named 'rtc_update_ms' within the
> > kernel, enabling users to
> > adjust the RTC periodic update frequency to suit the specific
> > requirements of the system and
> > UFS. Also, this patch allows the user to disable periodic update
> > RTC=C2=A0 in the UFS idle time.
>=20
> Why is this behavior enabled by default instead of disabled by
> default?

No problem, I will disable it by default in the next version and let
customers choose on a case-by-case basis.

Kind regards,
Bean
