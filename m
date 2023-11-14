Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E244B7EB686
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 19:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbjKNSkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 13:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbjKNSkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 13:40:10 -0500
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6595D122;
        Tue, 14 Nov 2023 10:40:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1699987197; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=cwnel0gPyF0y4+jLhmnqs6/cqT2dpS/xO+ya4/3GAT/UZVbxPSM/3VPcNKN+Sf3ss0
    kLHjlKUUm3Ie59wDO1Mw3sRqPptk1trQYXxwa0GTl9AufpPhbIU+FliKYnFnYjZ6Vy81
    NOmskmzFyN6RTqO+k5rMIIDeJyEgXvVSXF+/5XrxIko7/pOBuzfj0Yt5aHi3vAOIjU7M
    wQJgaWx8/8DuyW8b8jfzgvhLOQ/6++gjx9QXDzqNo8F+DwomFl8HYC3aaKbc8ft3rtih
    rErR700GIu2Wf7bqpZwSUGJfWaX+O61Kh00mCVx8OeJur05MYNSdyIYgcfJkFFYLU2S0
    RGOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1699987197;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Bb4uL1LHVeGU3JdGj9+KxPxQvKiBHHtyuVWiXB6woIE=;
    b=bxz4+7wNzqRVxMT+YRQ7zHhq5L9fzCcnIFym70GBgKtGhzOC/7AllrwwzqM6N6Pl37
    KisCJY2PXTeNz+jZPOLcC8AMUBZ4aJSRNl/jIxYrcnip39Ql5ObQ4tXOuUCcACGuIZPB
    nWbHleZjSQA9b2br+NqXrbkp9v+Bri43uSfpOEN/koGDNf+NDYBT8fVLhLK9kmWQT+de
    z7b3bd2YXGLcPVbUZcJ0W6KXUZ3h/2Vzrvozs+u8W/PvSRavDFU55Im5lrpUDmgbMm5G
    ZiZzNFAg9Kf3w5b+M/k9uOCkEt4wvjsTobE09x8LoWL4PVX8NhJajVHUNEavkHEGV7HO
    5V7A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1699987197;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Bb4uL1LHVeGU3JdGj9+KxPxQvKiBHHtyuVWiXB6woIE=;
    b=lQ6LyeFlPzKHQJpPD5pXlNoDa73MZh255yYWF95/QPpc8KcoKHK+frX3kXbuxPuGep
    NoU3fQADDRAU6C5gKVdAFPXQJJZbjEaWDjBNYJf1i4lUJ9QdVC5rvp+W6P/6TagA3EBR
    cRl+7a65wHH/xn8/F2lAJJVUvt+JLxinz7LfRYwtOvKC6orVaLMccdazudf6AVLzfp60
    PuvroklZvAIPhdAqFkp+7mwv5YYVP8xd7oj/Q0H1o6i5YaRrsvBmUeBsWvkA26ktI1dE
    mKZ9JUCSGBzGrqJ0hflkkpeI2ECTqvftXMj7aoPB7wyNAGn1uB2Hh0oCKee2i/kI583/
    LDbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1699987197;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Bb4uL1LHVeGU3JdGj9+KxPxQvKiBHHtyuVWiXB6woIE=;
    b=VSc/LCKxOZzmPq29BvZzG0Y9r/eV431XPQbN/8E3pIa/5MVpisKx2UGiCHL0CKhL1g
    uFW0XNeRSoOrbZu9QnAg==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSeBwhhSxarlUcu05JCAPyj3VPAceccYJs0uz"
Received: from [10.176.235.177]
    by smtp.strato.de (RZmta 49.9.1 AUTH)
    with ESMTPSA id z758a5zAEIdtV8q
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 14 Nov 2023 19:39:55 +0100 (CET)
Message-ID: <5e4f204e1ab2bb5f146b81e9809231f3a17c162f.camel@iokpp.de>
Subject: Re: [PATCH v1 2/2] scsi: ufs: core: Add sysfs node for UFS RTC
 update
From:   Bean Huo <beanhuo@iokpp.de>
To:     Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Cc:     avri.altman@wdc.com, bvanassche@acm.org, alim.akhtar@samsung.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        stanley.chu@mediatek.com, mani@kernel.org, quic_cang@quicinc.com,
        quic_asutoshd@quicinc.com, beanhuo@micron.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikebi@micron.com, lporzio@micron.com
Date:   Tue, 14 Nov 2023 19:39:55 +0100
In-Reply-To: <f1fe8b99-bf57-4243-90bb-665c3bb4e0e4@t-8ch.de>
References: <20231109125217.185462-1-beanhuo@iokpp.de>
         <20231109125217.185462-3-beanhuo@iokpp.de>
         <f1fe8b99-bf57-4243-90bb-665c3bb4e0e4@t-8ch.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVGhvbWFzLCAKCgpPbiBUaHUsIDIwMjMtMTEtMDkgYXQgMTU6MDUgKzAxMDAsIFRob21hcyBX
ZWnDn3NjaHVoIHdyb3RlOgo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHNjaGVk
dWxlX2RlbGF5ZWRfd29yaygmaGJhLT51ZnNfcnRjX2RlbGF5ZWRfd29yaywKPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbXNlY3NfdG9famlmZmllcyhoYgo+ID4gYS0+
ZGV2X2luZm8ucnRjX3VwZGF0ZV9wZXJpb2QpKTsKPiAKPiBXaGF0IGFib3V0IHRoZSBvdGhlciB3
b3JrIHRoYXQgaGFzIGFscmVhZHkgYmVlbiBzY2hlZHVsZWQ/CgpJIGRvbid0IHF1aXRlIHVuZGVy
c3RhbmQgeW91ciBjb25jZXJuIGhlcmUsICBJIG5lZWQgdG8gc2NoZWR1bGUgdGhlCndvcmsgd2hl
biBuZWVkZWQgYmVjYXVzZSBvZiByZXN1bWVfcGVyaW9kX3VwZGF0ZS4KCldvcmsgbWF5IGhhdmUg
YmVlbiBzY2hlZHVsZWQsIGJ1dCB0aGF0J3Mgb2theSwgdGhlcmUgd2lsbCBiZSBvbmUgbW9yZQpS
VEMgdXBkYXRlIGFzIGV4cGVjdGVkLgoKS2luZCByZWdhcmRzLApCZWFuCg==

