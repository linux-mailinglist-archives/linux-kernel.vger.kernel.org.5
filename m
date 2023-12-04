Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7AE5802A44
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 03:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234346AbjLDC14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 21:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjLDC1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 21:27:55 -0500
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E6BC1
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 18:27:59 -0800 (PST)
X-UUID: a156a3a52da548fca377d46206efd6dc-20231204
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:58783b7a-b7ad-4933-98ae-b467bde845a3,IP:10,
        URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
        ION:release,TS:-10
X-CID-INFO: VERSION:1.1.33,REQID:58783b7a-b7ad-4933-98ae-b467bde845a3,IP:10,UR
        L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-10
X-CID-META: VersionHash:364b77b,CLOUDID:5fb5c560-c89d-4129-91cb-8ebfae4653fc,B
        ulkID:231204102756QBXUMQUM,BulkQuantity:0,Recheck:0,SF:19|44|66|38|24|17|1
        02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: a156a3a52da548fca377d46206efd6dc-20231204
X-User: chentao@kylinos.cn
Received: from [172.21.13.26] [(116.128.244.171)] by mailgw
        (envelope-from <chentao@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1655860228; Mon, 04 Dec 2023 10:27:53 +0800
Message-ID: <2a0d2c32-5548-445e-a67e-db48157685d7@kylinos.cn>
Date:   Mon, 4 Dec 2023 10:27:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] powerpc/mm: Fix null-pointer dereference in
 pgtable_cache_add
Content-Language: en-US
To:     Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        christophe.leroy@csgroup.eu
Cc:     kunwu.chan@hotmail.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20231130090953.2322490-1-chentao@kylinos.cn>
 <87cyvq1b2f.fsf@mail.lhotse>
From:   Kunwu Chan <chentao@kylinos.cn>
In-Reply-To: <87cyvq1b2f.fsf@mail.lhotse>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sure,i'll follow your suggestion in v3 patch:
1. set new to NULL
2. add a 'if' judgment before 'kmem_cache_create'

Thanks,
Kunwu

On 2023/12/1 18:17, Michael Ellerman wrote:
> avoid two calls to panic
