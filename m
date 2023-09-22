Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89D17AA6FE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 04:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjIVC2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 22:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjIVC17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 22:27:59 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC966192
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 19:27:51 -0700 (PDT)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230922022748epoutp04ecb066e78d95db5cbeebb401110ad987~HF4pyAyh83231232312epoutp04U
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 02:27:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230922022748epoutp04ecb066e78d95db5cbeebb401110ad987~HF4pyAyh83231232312epoutp04U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695349668;
        bh=NGa5OGxo5RVDzGu+ZrGtp7FeoN4edCqHbGJ9tpz0C6E=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=rbMkffvPxsXPDTh/Ef59HCPi2V3lPDead2ni6yJIGZWOBcZ1itjogCtM1DFqQsujC
         3rTZ7BctPh4wieJWzLaTq50XF2FShhAcczKyh/r1FxdiBoSH/Ezb1IwGc3B+9h1unm
         A8XyKL9jojSpkOrOyK5FkqzPklwpG1MhEXxQTtYE=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230922022747epcas1p1f131fcb113246de442a91104a865cd5c~HF4pQuSbf2642126421epcas1p1b;
        Fri, 22 Sep 2023 02:27:47 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.38.240]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4RsGQC1JLyz4x9Q2; Fri, 22 Sep
        2023 02:27:47 +0000 (GMT)
X-AuditID: b6c32a36-0d9ff700000025af-1c-650cfba3db91
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        93.D3.09647.3ABFC056; Fri, 22 Sep 2023 11:27:47 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH v2] vmscan: add trace events for lru_gen
Reply-To: jaewon31.kim@samsung.com
Sender: =?UTF-8?B?6rmA7J6s7JuQ?= <jaewon31.kim@samsung.com>
From:   =?UTF-8?B?6rmA7J6s7JuQ?= <jaewon31.kim@samsung.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        "T.J. Mercier" <tjmercier@google.com>
CC:     =?UTF-8?B?6rmA7J6s7JuQ?= <jaewon31.kim@samsung.com>,
        "yuzhao@google.com" <yuzhao@google.com>,
        "kaleshsingh@google.com" <kaleshsingh@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20230921122244.1cbf2d57@gandalf.local.home>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230922022746epcms1p323c50015241eb01311e7e10579fd4c6c@epcms1p3>
Date:   Fri, 22 Sep 2023 11:27:46 +0900
X-CMS-MailID: 20230922022746epcms1p323c50015241eb01311e7e10579fd4c6c
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMJsWRmVeSWpSXmKPExsWy7bCmnu7i3zypBu2N7BZz1q9hs1i9ydei
        e/NMRove96+YLJr2zWS3uLxrDpvFvTX/WS2OrD/LYrGv4wGTxbv1X9gsZjf2MVq8m/CF1YHH
        4/Cb98weO2fdZfdo2XeL3WPBplKPTZ8msXucmPGbxaNvyypGjzMLjrB7fN4kF8AZlW2TkZqY
        klqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZA3SxkkJZYk4pUCgg
        sbhYSd/Opii/tCRVISO/uMRWKbUgJafArECvODG3uDQvXS8vtcTK0MDAyBSoMCE7407fA7aC
        h9YVE1+9ZmtgnC/UxcjJISFgItG3fwlLFyMXh5DADkaJ6Q9nsHUxcnDwCghK/N0hDFIjLGAj
        Mft6ExOILSSgJHH2xxV2iLi1xP5FM8DibAKWEttvTmQEsUUEAiX6vqxjA5nJLDCBReLlwsOs
        EMt4JWa0P2WBsKUlti/fCtbACdQ8904vI0RcVOLm6rfsMPb7Y/Oh4iISrffOMkPYghIPfu5m
        hJnz5/hzNgi7WGJZ5wMmCLtGYsW5VVBxc4mGtyvBbF4BX4m2MwfAalgEVCX+/H8HdZuLxIz1
        HWAzmQXkJba/ncMMCgdmAU2J9bv0IUoUJXb+ngtVwifx7msP3Fs75j2BWqsm0fLsK1RcRuLv
        v2dQtofE7Fe3mSDh/JtRovHnRfYJjAqzEEE9C8nmWQibFzAyr2IUSy0ozk1PLTYsMILHbnJ+
        7iZGcOrVMtvBOOntB71DjEwcjIcYJTiYlUR4kz9xpQrxpiRWVqUW5ccXleakFh9iNAX6eSKz
        lGhyPjD555XEG5pYGpiYGZlYGFsamymJ88553JsiJJCeWJKanZpakFoE08fEwSnVwMQisODT
        9j/n/wpFJDm/5mz71+3qnef/PtXpuG0gV/qm921vH8fXbA59GP1OuOiJVcHchANeuv4PW1Uu
        /XFteqNjYCXy8VR/lPaXnxYWSbJ/Q702zRIrPtBttl77UMqz/jW3Wjd+vdd6q5b3dPvMDral
        0V+ezTy2Y6N7Vaae2fL49PnLHp/e4FYRdWXSXUX+3qfvzvxn3hRmHPRk07JkG9UNkhkJa6qT
        Dv9dkqKaMaFk7/wkzmdbL/L/n/WZZ4tx8b5zL/Z8vLesQ6ZILvrE874UroXLP1m9511Yv1Xu
        1VZeTffIACmhsl5p4bJHAQfjZX9rN+b85P8tWJV1bOqsHV+W5DR9VnxyOiA641lCspsSS3FG
        oqEWc1FxIgBP9sjGRgQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230921061944epcas1p2f8a022282709da12840b33c0f5898b5f
References: <20230921122244.1cbf2d57@gandalf.local.home>
        <20230921062206.14429-1-jaewon31.kim@samsung.com>
        <CABdmKX1V-yPF260gORh-0LFkL+bDfPhOJteiwBjg1v6rYgrvgg@mail.gmail.com>
        <CGME20230921061944epcas1p2f8a022282709da12840b33c0f5898b5f@epcms1p3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On Thu, 21 Sep 2023 09:12:30 -0700                                                                                                                                                                               
>"T.J. Mercier" <tjmercier@google.com> wrote:                                                                                                                                                                     
>                                                                                                                                                                                                                 
>> > +       TP_fast_assign(                                                                                                                                                                                      
>> > +               __entry->nid = nid;                                                                                                                                                                          
>> > +               __entry->nr_reclaimed = nr_reclaimed;                                                                                                                                                        
>> > +               __entry->nr_dirty = stat->nr_dirty;                                                                                                                                                          
>> > +               __entry->nr_writeback = stat->nr_writeback;                                                                                                                                                  
>> > +               __entry->nr_congested = stat->nr_congested;                                                                                                                                                  
>> > +               __entry->nr_immediate = stat->nr_immediate;                                                                                                                                                  
>> > +               __entry->nr_activate0 = stat->nr_activate[0];                                                                                                                                                
>> > +               __entry->nr_activate1 = stat->nr_activate[1];                                                                                                                                                
>> > +               __entry->nr_ref_keep = stat->nr_ref_keep;                                                                                                                                                    
>> > +               __entry->nr_unmap_fail = stat->nr_unmap_fail;                                                                                                                                                
>> > +               __entry->priority = priority;                                                                                                                                                                
>> > +               __entry->reclaim_flags = trace_reclaim_flags(file);                                                                                                                                          
>> > +       ),                                                                                                                                                                                                   
>> > +                                                                                                                                                                                                            
>> > +       TP_printk("nid=%d nr_reclaimed=%ld nr_dirty=%ld nr_writeback=%ld nr_congested=%ld nr_immediate=%ld nr_activate_anon=%d nr_activate_file=%d nr_ref_keep=%ld nr_unmap_fail=%ld priority=%d flags=%s",  
>>                                                                                                                                                                                                                
>> Many of these values are unsigned so I think many of these format                                                                                                                                              
>> specifiers should be %lu instead of %ld.                                                                                                                                                                       

Hello T.J.
Thank you for your comment 
As you expected I got this from the legacy lru trace.
I've changed as you recommended.
Actually I changed isolate_mode, too. Please let me know if this is not actually needed.

--- a/include/trace/events/vmscan.h
+++ b/include/trace/events/vmscan.h
@@ -367,7 +367,7 @@ TRACE_EVENT_CONDITION(mm_vmscan_lru_gen_scan,
         * classzone is previous name of the highest_zoneidx.
         * Reason not to change it is the ABI requirement of the tracepoint.
         */
-       TP_printk("isolate_mode=%d classzone=%d order=%d nr_requested=%lu nr_scanned=%lu nr_skipped=%lu nr_taken=%lu lru=%s",
+       TP_printk("isolate_mode=%u classzone=%d order=%d nr_requested=%lu nr_scanned=%lu nr_skipped=%lu nr_taken=%lu lru=%s",
                __entry->isolate_mode,
                __entry->highest_zoneidx,
                __entry->order,
@@ -525,7 +525,7 @@ TRACE_EVENT(mm_vmscan_lru_gen_evict,
                __entry->reclaim_flags = trace_reclaim_flags(file);
        ),
 
-       TP_printk("nid=%d nr_reclaimed=%ld nr_dirty=%ld nr_writeback=%ld nr_congested=%ld nr_immediate=%ld nr_activate_anon=%d nr_activate_file=%d nr_ref_keep=%ld nr_unmap_fail=%ld priority=%d flags=%s",
+       TP_printk("nid=%d nr_reclaimed=%lu nr_dirty=%lu nr_writeback=%lu nr_congested=%lu nr_immediate=%lu nr_activate_anon=%u nr_activate_file=%u nr_ref_keep=%lu nr_unmap_fail=%lu priority=%d flags=%s",
                __entry->nid, __entry->nr_reclaimed,
                __entry->nr_dirty, __entry->nr_writeback,
                __entry->nr_congested, __entry->nr_immediate,

>                                                                                                                                                                                                                 
>Other than this, from the tracing POV:                                                                                                                                                                           
>                                                                                                                                                                                                                 
>Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>                                                                                                                                                       


Hello Steven
I've appreciated your Reviewed-by, let me take this on my next v3 patch.

>                                                                                                                                                                                                                 
>-- Steve                                                                                                                                                                                                         
