Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE21804578
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 04:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344159AbjLEDFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 22:05:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234848AbjLEDFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 22:05:47 -0500
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD3EBF;
        Mon,  4 Dec 2023 19:05:50 -0800 (PST)
X-UUID: b1ae75138d6e4ab4b5b51354363fe8e4-20231205
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:8ce5544b-bf9c-4849-94e4-0899eb8f545b,IP:5,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:-15
X-CID-INFO: VERSION:1.1.33,REQID:8ce5544b-bf9c-4849-94e4-0899eb8f545b,IP:5,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-15
X-CID-META: VersionHash:364b77b,CLOUDID:805d4afd-4a48-46e2-b946-12f04f20af8c,B
        ulkID:231204205248UVJ6B54Y,BulkQuantity:4,Recheck:0,SF:24|17|19|44|66|102,
        TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,
        OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-UUID: b1ae75138d6e4ab4b5b51354363fe8e4-20231205
X-User: chentao@kylinos.cn
Received: from [172.20.15.254] [(116.128.244.169)] by mailgw
        (envelope-from <chentao@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1111733163; Tue, 05 Dec 2023 11:05:43 +0800
Message-ID: <d8b80a17-df0b-459c-ae0a-397693f6a443@kylinos.cn>
Date:   Tue, 5 Dec 2023 11:05:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 iwl-next] i40e: Use correct buffer size in
 i40e_dbg_command_read
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, jeffrey.t.kirsher@intel.com,
        shannon.nelson@amd.com, kunwu.chan@hotmail.com,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>
References: <20231204014455.2444734-1-chentao@kylinos.cn>
 <81dbf657-6513-4a8c-a0a9-5a98951c8356@intel.com>
Content-Language: en-US
From:   Kunwu Chan <chentao@kylinos.cn>
In-Reply-To: <81dbf657-6513-4a8c-a0a9-5a98951c8356@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,
Thanks for your reply.

It's my bad, I'll follow your suggestion in v4 patch:
1. keep 'buf' as it defined before.
2. resolve memory leak as your suggestion.
3. make 'bytes_not_copied' as a return value for error path.

Thanks again,
Kunwu
On 2023/12/4 20:51, Alexander Lobakin wrote:
> This is unneeded.
