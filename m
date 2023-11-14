Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33CA67EB68A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 19:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233932AbjKNSnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 13:43:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjKNSnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 13:43:03 -0500
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926B1DF;
        Tue, 14 Nov 2023 10:43:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1699987372; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=AbXOG1RS3ZeB+EpjcvAmsmx9Eya5muSKWivMhKXVIvrK2boFdosVQoFvgp+Vlu7dkM
    L8/u7iCIruiM8gYc9988HiFSUpI5zHORM3qomLfaqdWZMR+wvrz31u+CJWqrmgf9kEHa
    nU0cwq9latwWZH7WxvhhLf1TH6+nEwFTZcpBPolDkjAcTSfV/UFG3Gvktl6s4lKERpu/
    0LgpUH2Jl2edP0R27R6F32VKZ6q/Wkp6GkUnf8aggw64kVyXSYvFh+RC+ALbGk/F2Z5Z
    sXZCZYXaSsKIdPf78JsIMXGqZjC5a8zqJSCWdZT8omIdG9jNYd399ho77sxfq94s280d
    MHdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1699987372;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=gf0ZqEVn7Tk4Q4eh2Whf+l4ARyu6ttahR+IkDoV/Oz0=;
    b=fqc+wD9gZ96vr50tL2W80qZ+E/tPbTnrcuii6307x9EcrYsH9+Ut4SHHYWgy/WxygX
    m+e5bXYUeszOV1wO6djwg9ybbzqoWzWUvOoWcdMHDvZD/AYhPPi8M+X2NnpOUFKvhqQr
    rC23+ezkZ2fGA5UStnTuIfQ1Sj3ASo0k8Ifb4sbURUWvQ7+LrD0JNAdQoi9ipnuCSblo
    v36Mgq83u24j+d1CZZY/p6AKbSUzhNz7iqWuVWL3n9A5DFuIkKmKzxcvQnNSzfFEenbf
    ts7cpZsN/f/1Lqf4dfeg3cLnXOBLUI3Lo2XLHRaTwzZ2wSOQu3mJMqZvT7bV4YcaZJ+f
    e46g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1699987372;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=gf0ZqEVn7Tk4Q4eh2Whf+l4ARyu6ttahR+IkDoV/Oz0=;
    b=khmsg+AfF/G+VfmTvsiy8zweqvJA8h0kLJvV2CnXuBgrf3ur13Y5NOUq/0JSfQydcv
    N0I8ue9tRRVkAEA9nAD1QZaXJp4bQNQsU4EcvVNkYsgYN/Y8G/3C27hOTpbV9LBG0n2i
    cJRcahPkleMri2pETQFQP/1ms8Fq3g3L1wHJng464xC+7YX12vFQFUKzglN+tZWfk7ga
    70bSrFuA6sek0tpp9SbsDvnsxgjQA5Z632QeAkU5GE9tLrSowYQ4WtZ+N2Ktdkhbk5ud
    tRHLDmja+2JOSnQJ6CZ10pqUloR451fBJcvcMhQ6pY05WHLgOlcxMuKZPKIVUR6tCljh
    llag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1699987372;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=gf0ZqEVn7Tk4Q4eh2Whf+l4ARyu6ttahR+IkDoV/Oz0=;
    b=4KXDFf0AXYfu6lnsxbNl1xu+i+mn2h474bUd8gzVFPoAmpKxuyDgKDyNoFhIjvzjI+
    vJIu3MDZTns1AW62FPCA==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSeBwhhSxarlUcu05JCAPyj3VPAceccYJs0uz"
Received: from [10.176.235.177]
    by smtp.strato.de (RZmta 49.9.1 AUTH)
    with ESMTPSA id z758a5zAEIgqV96
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 14 Nov 2023 19:42:52 +0100 (CET)
Message-ID: <1fab375b0c30851767613582a6f89f872c82aaa3.camel@iokpp.de>
Subject: Re: [PATCH v1 1/2] scsi: ufs: core: Add UFS RTC support
From:   Bean Huo <beanhuo@iokpp.de>
To:     Avri Altman <Avri.Altman@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "mani@kernel.org" <mani@kernel.org>,
        "quic_cang@quicinc.com" <quic_cang@quicinc.com>,
        "quic_asutoshd@quicinc.com" <quic_asutoshd@quicinc.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>
Cc:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mikebi@micron.com" <mikebi@micron.com>,
        "lporzio@micron.com" <lporzio@micron.com>
Date:   Tue, 14 Nov 2023 19:42:51 +0100
In-Reply-To: <DM6PR04MB6575E82B66D090CDD495BF69FCAFA@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20231109125217.185462-1-beanhuo@iokpp.de>
         <20231109125217.185462-2-beanhuo@iokpp.de>
         <DM6PR04MB6575E82B66D090CDD495BF69FCAFA@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Avri,=20


On Thu, 2023-11-09 at 15:09 +0000, Avri Altman wrote:
> > The objective of this patch is to incorporate Real Time Clock (RTC)
> > support in
> > Universal Flash Storage (UFS) device. This enhancement is crucial
> > for the
> > internal maintenance operations of the UFS device. The patch
> > enables the
> > device to handle both absolute and relative time information.
> > Furthermore, it
> > includes periodic task to update the RTC in accordance with the UFS
> > specification, ensuring the accuracy of RTC information for the
> > device's
> > internal processes.
> Maybe add some reference to qTimestamp and explain why RTC in seconds
> is still needed,
> when RTC in nanoseconds is already implemented?

Yes, I will add an explanation in the next version.

Kind regards,
Bean
