Return-Path: <linux-kernel+bounces-1099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB62814A57
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E5251C23E3A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551C43067E;
	Fri, 15 Dec 2023 14:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XX0wmRWv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62B430D0F
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 14:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BFCVOsN019654;
	Fri, 15 Dec 2023 14:19:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=xpliHVSpfscPd7wALQimqNirWo6JrkKpJV/sEDbpaJY=; b=XX
	0wmRWvkXv4qUevzZar7BbirBT65F52Bn2Xrm2X6kJ0zDg9+76+T/g1zrku6wMuFa
	zQz0xjueCzSPtPcBKt4KKbZMYyw6lHHi+mnwvLkLpAp3peNMQbtMoow26PZvlkV7
	nx+V0uideKPagW3bSEMEcXmd3HZUkYXF4XntDsZVcRSnHuURwMtuJ4f7lAEdrMzr
	GewpBT7igq/A7Vp5asny7eWBxjOLw14JK8HeAuTez0qAA4BADtfPQ47KOaRj5vUx
	KNtNSkdpsARD3LiQi5CSgNKnNnPDpHbun9PvDzQX2cBhNIdbn+QOM4XAYCj0lV4S
	ZapU+nTylr8RWBVETBQA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v081t26v8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 14:19:17 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BFEJHvv015115
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 14:19:17 GMT
Received: from [10.216.43.184] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 15 Dec
 2023 06:19:14 -0800
Message-ID: <ff008c9d-9d3b-e834-e062-01d5fed36637@quicinc.com>
Date: Fri, 15 Dec 2023 19:48:50 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Maple tree implementation for irq descriptor management
To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
CC: <sdonthineni@nvidia.com>, <tglx@linutronix.de>,
        Andrew Morton
	<akpm@linux-foundation.org>,
        <maple-tree@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <660d8a0d-d490-ab0b-0bd1-e497fc7df1fc@quicinc.com>
 <20231213193558.zwqppxa4ap7xvrfr@revolver>
Content-Language: en-US
From: Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20231213193558.zwqppxa4ap7xvrfr@revolver>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: XLknPNzQXMn19JRS4BbLzlpxLJDtct9H
X-Proofpoint-GUID: XLknPNzQXMn19JRS4BbLzlpxLJDtct9H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 impostorscore=0 adultscore=0 malwarescore=0 suspectscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312150098

Hi @Liam,

On 12/14/2023 1:05 AM, Liam R. Howlett wrote:
> * Mukesh Ojha <quic_mojha@quicinc.com> [231213 10:46]:
>> Hi All,
>>
>> We are facing an issue in maple tree implementation for irq descriptor
>> where while allocating a new descriptor in irq_create_mapping(index=300) it
>> gets interrupted and get stuck in infinite loop inside
>> mtree_lookup_walk()=>ma_dead_node(index=287) due to dead node
>> (0xFFFFFF8819DECF00) and it is the same node where earlier call
>> for creating descriptor is about to added.
> 
> What kernel version?

6.5

> 
> There was an issue with the tree a while back which could result in this
> happening [1], although I was never successful in causing it or seeing
> it before now.
> 
> Looking though the dump below, it appears that you do not have the
> patches in [1] as they should prevent the node from being marked dead
> until the new node exists in the tree.  Note that this occurs in your
> case in splitting of the node which should be fixed in the last patch of
> the series.
> 
> [1] https://lore.kernel.org/all/20230804165951.2661157-3-Liam.Howlett@oracle.com/T/#u

Thanks for the prompt response, yes these patches are missing.
Let me apply them and try.

-Mukesh
> 
> Thanks,
> Liam
> 
>>
>>
>>    (struct maple_node *)0xFFFFFF8819DECF00 = 0xFFFFFF8819DECF00 -> (
>>      parent = 0xFFFFFF8819DECF00,
>>      slot = (0x0, 0x011E, 0x011F, 0x0120, 0x0121, 0x0122, 0x0123, 0x0124,
>> 0x0125, 0x0126, 0x0127, 0x0128, 0x0129, 0x012A, 0x012B, 0xFFFFFF8813125600,
>> 0xFFFFFF8828BC6E00, 0xFFFFFF8821A4C800, 0x
>>      pad = 0xFFFFFF8819DECF00,
>>      rcu = (next = 0x0, func = 0x011E),
>>      piv_parent = 0x011F,
>>      parent_slot = 32,
>>      type = maple_dense = 0,
>>      slot_len = 33,
>>      ma_flags = 0,
>>      mr64 = (
>>        parent = 0xFFFFFF8819DECF00,
>>        pivot = (0, 286, 287, 288, 289, 290, 291, 292, 293, 294, 295, 296,
>> 297, 298, 299),
>>        slot = (0xFFFFFF8813125600, 0xFFFFFF8828BC6E00, 0xFFFFFF8821A4C800,
>> 0xFFFFFF8815595A00, 0xFFFFFF8815594400, 0xFFFFFF8815596800,
>> 0xFFFFFF8815597E00, 0xFFFFFF88155B7C00, 0xFFFFFF881559400
>>        pad = (0xFFFFFF8813125600, 0xFFFFFF8828BC6E00, 0xFFFFFF8821A4C800,
>> 0xFFFFFF8815595A00, 0xFFFFFF8815594400, 0xFFFFFF8815596800,
>> 0xFFFFFF8815597E00, 0xFFFFFF88155B7C00, 0xFFFFFF8815594000
>>        meta = (end = 0, gap = 0)),
>>      ma64 = (
>>        parent = 0xFFFFFF8819DECF00,
>>        pivot = (0, 286, 287, 288, 289, 290, 291, 292, 293),
>>        slot = (0x0126, 0x0127, 0x0128, 0x0129, 0x012A, 0x012B,
>> 0xFFFFFF8813125600, 0xFFFFFF8828BC6E00, 0xFFFFFF8821A4C800,
>> 0xFFFFFF8815595A00),
>>        gap = (18446743558671647744, 18446743558671656960,
>> 18446743558671662592, 18446743558671793152, 18446743558671646720,
>> 18446743558671650304, 18446743558800159744, 18446743558759686144, 18
>>        meta = (end = 0, gap = 118)),
>>      alloc = (total = 18446743558747508480, node_count = 0, request_count =
>> 0, slot = (0x011E, 0x011F, 0x0120, 0x0121, 0x0122, 0x0123, 0x0124, 0x0125,
>> 0x0126, 0x0127, 0x0128, 0x0129, 0x012A, 0
>>
>> Backtrace:
>>
>> -000|mtree_lookup_walk(inline)
>>      |  max = 18446744073709551615
>>      |  next = 0xFFFFFF881B197C1C
>>      |  offset = 2
>>      |  node = 0xFFFFFF881B197C00
>>      |  type = maple_arange_64
>> -000|mtree_load(mt = ?, index = 287)
>>      |  index = 287
>>      |  mas = (tree = 0xFFFFFFC081EB3EC0, index = 287, last = 287, node =
>> 0xFFFFFF881B197C1C, min = 0, max = 18446744073709551615, alloc = 0x0, depth
>> = 1, offset = 0, mas_flags = 0)
>>      |  entry = 0x0
>> -001|irq_to_desc(inline)
>> -001|generic_handle_irq(irq = ?)
>>      |  irq = ?
>> -002|NSX:0x0::0xFFFFFFC07A0E0500(asm)
>> -003|__handle_irq_event_percpu(:desc = 0xFFFFFF8807D18600)
>>      |  desc = 0xFFFFFF8807D18600
>>      |  __already_done = FALSE
>>      |  irq = 17
>>      |  retval = IRQ_NONE
>>      |  res = IRQ_NONE
>> -004|handle_irq_event_percpu(inline)
>>      |  desc = 0xFFFFFF8807D18600
>>      |  retval = IRQ_NONE
>> -004|handle_irq_event(:desc = 0xFFFFFF8807D18600)
>>      |  desc = 0xFFFFFF8807D18600
>>      |  ret = IRQ_NONE
>> -005|handle_fasteoi_irq(desc = 0xFFFFFF8807D18600)
>>      |  desc = 0xFFFFFF8807D18600
>>      |  chip = 0xFFFFFFC081F21288
>> -006|generic_handle_irq_desc(inline)
>> -006|handle_irq_desc(inline)
>> -006|generic_handle_domain_irq(domain = ?, :hwirq = 261)
>>      |  domain = ?
>>      |  hwirq = 261
>> -007|__gic_handle_irq(inline)
>>      |  irqnr = 261
>> -007|__gic_handle_irq_from_irqson(inline)
>>      |  is_nmi = FALSE
>>      |  irqnr = 261
>> -007|gic_handle_irq()
>> -008|call_on_irq_stack(asm)
>> -009|do_interrupt_handler(inline)
>>      |  regs = 0xFFFFFFC082142DB0
>>      |  old_regs = 0x0
>> -009|__el1_irq(inline)
>>      |  regs = 0xFFFFFFC082142DB0
>> -009|el1_interrupt(regs = 0xFFFFFFC082142DB0, handler = 0xFFFFFFC0800100F8)
>>      |  regs = 0xFFFFFFC082142DB0
>>      |  handler = 0xFFFFFFC0800100F8
>> -010|el1h_64_irq_handler(regs = ?)
>>      |  regs = ?
>> -011|el1h_64_irq(asm)
>>   -->|exception
>> -012|__memcpy(asm)
>> -013|mas_mab_cp(:mas = 0xFFFFFFC0821434A8, :mas_start = 80, mas_end = ?,
>> b_node = 0xFFFFFFC082143108, :mab_start = 80)
>>      |  mas = 0xFFFFFFC0821434A8
>>      |  mas_start = 0
>>      |  b_node = 0xFFFFFFC082143108
>>      |  mab_start = 0
>>      |  gaps = 0x0
>>      |  node = 0xFFFFFF88118A8900
>>      |  mt = maple_arange_64
>>      |  __fortify_size = 32
>>      |  __p_size = 18446744073709551615
>>      |  __p_size_field = 18446744073709551615
>>      |  __q_size = 0
>> -014|mast_fill_bnode(:mast = 0xFFFFFFC0821430C8, :mas = 0xFFFFFFC0821434A8,
>> :skip = 1)
>>      |  mast = 0xFFFFFFC0821430C8 -> (
>>      |    orig_l = 0xFFFFFFC082143000,
>>      |    orig_r = 0xFFFFFFC082142FC0,
>>      |    l = 0xFFFFFFC082143080 -> (
>>      |      tree = 0xFFFFFFC081EB3EC0,
>>      |      index = 300,
>>      |      last = 300,
>>      |      node = 0xFFFFFF881409570C,
>>      |      min = 285,
>>      |      max = 293,
>>      |      alloc = 0xFFFFFF8814094600,
>>      |      depth = 3,
>>      |      offset = 4,
>>      |      mas_flags = 0),
>>      |    m = 0x0,
>>      |    r = 0xFFFFFFC082143040 -> (
>>      |      tree = 0xFFFFFFC081EB3EC0,
>>      |      index = 300,
>>      |      last = 300,
>>      |      node = 0xFFFFFF881409510C,
>>      |      min = 294,
>>      |      max = 18446744073709551615,
>>      |      alloc = 0xFFFFFF8814094600,
>>      |      depth = 3,
>>      |      offset = 15,
>>      |      mas_flags = 0),
>>      |    free = 0xFFFFFFC082142FA8,
>>      |    destroy = 0x0,
>>      |    bn = 0xFFFFFFC082143108)
>>      |  mas = 0xFFFFFFC0821434A8
>>      |  skip = 1
>>      |  split = 0
>>      |  old = 0x0
>> -015|mas_split(inline)
>>      |  mas = 0xFFFFFFC0821434A8
>>      |  mast = (orig_l = 0xFFFFFFC082143000, orig_r = 0xFFFFFFC082142FC0, l =
>> 0xFFFFFFC082143080, m = 0x0, r = 0xFFFFFFC082143040, free =
>> 0xFFFFFFC082142FA8, destroy = 0x0, bn = 0xFFFFFFC082143108)
>>      |  l_mas = (tree = 0xFFFFFFC081EB3EC0, index = 300, last = 300, node =
>> 0xFFFFFF881409570C, min = 285, max = 293, alloc = 0xFFFFFF8814094600, depth
>> = 3, offset = 4, mas_flags = 0)
>>      |  r_mas = (tree = 0xFFFFFFC081EB3EC0, index = 300, last = 300, node =
>> 0xFFFFFF881409510C, min = 294, max = 18446744073709551615, alloc =
>> 0xFFFFFF8814094600, depth = 3, offset = 15, mas_flags = 0)
>>      |  prev_l_mas = (tree = 0xFFFFFFC081EB3EC0, index = 300, last = 300,
>> node = 0x1, min = 0, max = 18446744073709551615, alloc = 0x0, depth = 0,
>> offset = 0, mas_flags = 0)
>>      |  prev_r_mas = (tree = 0xFFFFFFC081EB3EC0, index = 300, last = 300,
>> node = 0x1, min = 0, max = 18446744073709551615, alloc = 0x0, depth = 0,
>> offset = 0, mas_flags = 0)
>>      |  mat = (head = 0xFFFFFF8819DECF0C, tail = 0xFFFFFF8819DECF0C, mtree =
>> 0xFFFFFFC081EB3EC0)
>>      |  mid_split = 0
>> -015|mas_commit_b_node(inline)
>>      |  b_type = maple_leaf_64
>>      |  node = 0x0
>> -015|mas_wr_bnode(inline)
>>      |  b_node = (
>>      |    parent = 0x0,
>>      |    pivot = (239, 254, 269, 284, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
>> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
>>      |    slot = (0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
>> 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
>> 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0),
>>      |    padding = (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
>> 0, 0),
>>      |    gap = (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
>> 0),
>>      |    b_end = 4,
>>      |    type = maple_leaf_64)
>> -015|mas_wr_modify(:wr_mas = 0xFFFFFFC082143408)
>> -016|mas_wr_store_entry(:wr_mas = 0xFFFFFFC082143408)
>>      |  wr_mas = 0xFFFFFFC082143408 -> (
>>      |    mas = 0xFFFFFFC0821434A8 -> (
>>      |      tree = 0xFFFFFFC081EB3EC0,
>>      |      index = 300,
>>      |      last = 300,
>>      |      node = 0xFFFFFF88118A891C,
>>      |      min = 225,
>>      |      max = 18446744073709551615,
>>      |      alloc = 0xFFFFFF8814094600,
>>      |      depth = 3,
>>      |      offset = 2,
>>      |      mas_flags = 0),
>>      |    node = 0xFFFFFF8819DECF00,
>>      |    r_min = 300,
>>      |    r_max = 0xFFFFFFFFFFFFFFFF,
>>      |    type = maple_leaf_64,
>>      |    offset_end = 15,
>>      |    node_end = 15,
>>      |    pivots = 0xFFFFFF8819DECF08 -> 0,
>>      |    end_piv = 0xFFFFFFFFFFFFFFFF,
>>      |    slots = 0xFFFFFF8819DECF80 -> 0xFFFFFF8813125600 -> ,
>>      |    entry = 0xFFFFFF8848A27A00,
>>      |    content = 0x0)
>>      |  mas = 0x0
>> -017|mas_store_gfp(:mas = 0xFFFFFFC0821434A8, :entry = 0xFFFFFF8848A27A00,
>> :gfp = 3264)
>>      |  mas = 0xFFFFFFC0821434A8
>>      |  entry = 0xFFFFFF8848A27A00
>>      |  gfp = 3264
>>      |  wr_mas = (mas = 0xFFFFFFC0821434A8, node = 0xFFFFFF8819DECF00, r_min
>> = 300, r_max = 18446744073709551615, type = maple_leaf_64, offset_end = 15,
>> node_end = 15, pivots = 0xFFFFFF8819DECF08, end_piv = 18446744073709551615,
>> slots = 0xFFFFFF8819DECF80, entry = 0xFFFFFF8848A27A00, content = 0x0)
>> -018|irq_insert_desc(inline)
>>      |  desc = 0xFFFFFF8848A27A00
>>      |  mas = (tree = 0xFFFFFFC081EB3EC0, index = 300, last = 300, node =
>> 0xFFFFFF88118A891C, min = 225, max = 18446744073709551615, alloc =
>> 0xFFFFFF8814094600, depth = 3, offset = 2, mas_flags = 0)
>> -018|alloc_descs(inline)
>>      |  start = 300
>>      |  node = -1
>>      |  affinity = 0x0
>>      |  owner = 0x0
>>      |  desc = 0xFFFFFF8848A27A00
>> -018|__irq_alloc_descs(irq = ?, from = ?, :cnt = 1, node = ?, owner = 0x0,
>> :affinity = 0x0)
>>      |  cnt = 1
>>      |  owner = 0x0
>>      |  start = 300
>> -019|irq_domain_alloc_descs(inline)
>>      |  virq = -1
>>      |  cnt = 1
>>      |  hwirq = 0
>>      |  node = -1
>>      |  affinity = 0x0
>> -019|irq_create_mapping_affinity_locked(inline)
>>      |  domain = 0xFFFFFF885BFF6840
>>      |  hwirq = 0
>>      |  affinity = 0x0
>>      |  virq = 0
>> -019|irq_create_mapping_affinity(domain = 0xFFFFFF885BFF6840, hwirq = 0,
>> affinity = 0x0)
>>      |  domain = 0xFFFFFF885BFF6840
>>      |  hwirq = 0
>>      |  affinity = 0x0
>> -020|NSX:0x0::0xFFFFFFC07AE32720(asm)
>> -021|NSX:0x0::0xFFFFFFC07AC9AB38(asm)
>> -022|NSX:0x0::0xFFFFFFC07B3E49F4(asm)
>> -023|call_driver_probe(inline)
>>      |  dev = 0xFFFFFF8848951848
>>      |  drv = 0xFFFFFFC07AFD90C0
>>      |  ret = 0
>> -023|really_probe(:dev = 0xFFFFFF8848951848, :drv = 0xFFFFFFC07AFD90C0)
>>      |  dev = 0xFFFFFF8848951848
>>      |  drv = 0xFFFFFFC07AFD90C0
>>      |  link_ret = 0
>>      |  test_remove = FALSE
>> -024|__driver_probe_device(drv = 0xFFFFFFC07AFD90C0, :dev =
>> 0xFFFFFF8848951848)
>>      |  drv = 0xFFFFFFC07AFD90C0
>>      |  dev = 0xFFFFFF8848951848
>>      |  ret = 0
>> -025|driver_probe_device(drv = 0xFFFFFFC07AFD90C0, :dev =
>> 0xFFFFFF8848951848)
>>      |  drv = 0xFFFFFFC07AFD90C0
>>      |  dev = 0xFFFFFF8848951848
>>      |  trigger_count = 783
>>      |  ret = 0
>> -026|__device_attach_driver(drv = 0xFFFFFFC07AFD90C0, :_data =
>> 0xFFFFFFC0821437E8)
>>      |  drv = 0xFFFFFFC07AFD90C0
>>      |  _data = 0xFFFFFFC0821437E8
>>      |  data = 0xFFFFFFC0821437E8
>>      |  dev = 0xFFFFFF8848951848
>>      |  ret = ???
>> -027|bus_for_each_drv(bus = ?, :start = 0xFFFFFFC0821437E0, :data =
>> 0xFFFFFFC0821437E8, fn = 0xFFFFFFC08089C798)
>>      |  data = 0xFFFFFFC0821437E8
>>      |  fn = 0xFFFFFFC08089C798
>>      |  i = (i_klist = 0xFFFFFF881ED5C6C8, i_cur = 0xFFFFFF8823649968)
>>      |  sp = 0xFFFFFF881ED5C600
>>      |  error = 0
>> -028|__device_attach(dev = 0xFFFFFF8848951848)
>>      |  dev = 0xFFFFFF8848951848
>>      |  async = FALSE
>>      |  ret = 0
>>      |  data = (dev = 0xFFFFFF8848951848, check_async = TRUE, want_async =
>> FALSE, have_async = FALSE)
>> -029|device_initial_probe(dev = 0xFFFFFF8848951848)
>>      |  dev = 0xFFFFFF8848951848
>> -030|bus_probe_device(:dev = 0xFFFFFF8848951848)
>>      |  dev = 0xFFFFFF8848951848
>>      |  sp = 0xFFFFFF881ED5C600
>>      |  sif = 0x0
>> -031|device_add(:dev = 0xFFFFFF8848951848)
>>      |  dev = 0xFFFFFF8848951848
>>      |  sp = 0x0
>>      |  parent = 0xFFFFFF8851B70080
>>      |  class_intf = 0x0
>>      |  error = 0
>>      |  glue_dir = 0x0
>> -032|device_register(dev = 0xFFFFFF8848951848)
>>      |  dev = 0xFFFFFF8848951848
>> -033|NSX:0x0::0xFFFFFFC07B3E3944(asm)
>> -034|NSX:0x0::0xFFFFFFC07B3E3C20(asm)
>> -035|NSX:0x0::0xFFFFFFC07B6B5148(asm)
>> -036|platform_probe(:_dev = 0xFFFFFF8848956010)
>>      |  _dev = 0xFFFFFF8848956010
>>      |  drv = 0xFFFFFFC07B299648
>>      |  ret = 0
>> -037|call_driver_probe(inline)
>>      |  dev = 0xFFFFFF8848956010
>>      |  drv = 0xFFFFFFC07B299678
>>      |  ret = 0
>> -037|really_probe(:dev = 0xFFFFFF8848956010, :drv = 0xFFFFFFC07B299678)
>>      |  dev = 0xFFFFFF8848956010
>>      |  drv = 0xFFFFFFC07B299678
>>      |  link_ret = 0
>>      |  test_remove = FALSE
>> -038|__driver_probe_device(drv = 0xFFFFFFC07B299678, :dev =
>> 0xFFFFFF8848956010)
>>      |  drv = 0xFFFFFFC07B299678
>>      |  dev = 0xFFFFFF8848956010
>>      |  ret = 0
>> -039|driver_probe_device(drv = 0xFFFFFFC07B299678, :dev =
>> 0xFFFFFF8848956010)
>>      |  drv = 0xFFFFFFC07B299678
>>      |  dev = 0xFFFFFF8848956010
>>      |  trigger_count = 781
>>      |  ret = 0
>> -040|__device_attach_driver(drv = 0xFFFFFFC07B299678, :_data =
>> 0xFFFFFFC082143BA8)
>>      |  drv = 0xFFFFFFC07B299678
>>      |  _data = 0xFFFFFFC082143BA8
>>      |  data = 0xFFFFFFC082143BA8
>>      |  dev = 0xFFFFFF8848956010
>>      |  ret = ???
>> -041|bus_for_each_drv(bus = ?, :start = 0xFFFFFFC082143BA0, :data =
>> 0xFFFFFFC082143BA8, fn = 0xFFFFFFC08089C798)
>>      |  data = 0xFFFFFFC082143BA8
>>      |  fn = 0xFFFFFFC08089C798
>>      |  i = (i_klist = 0xFFFFFF8804034AC8, i_cur = 0xFFFFFF8821B45068)
>>      |  sp = 0xFFFFFF8804034A00
>>      |  error = 0
>> -042|__device_attach(dev = 0xFFFFFF8848956010)
>>      |  dev = 0xFFFFFF8848956010
>>      |  async = FALSE
>>      |  ret = 0
>>      |  data = (dev = 0xFFFFFF8848956010, check_async = TRUE, want_async =
>> FALSE, have_async = FALSE)
>> -043|device_initial_probe(dev = 0xFFFFFF8848956010)
>>      |  dev = 0xFFFFFF8848956010
>> -044|bus_probe_device(:dev = 0xFFFFFF8848956010)
>>      |  dev = 0xFFFFFF8848956010
>>      |  sp = 0xFFFFFF8804034A00
>>      |  sif = 0x0
>> -045|device_add(:dev = 0xFFFFFF8848956010)
>>      |  dev = 0xFFFFFF8848956010
>>      |  sp = 0x0
>>      |  parent = 0xFFFFFF8851BCE410
>>      |  class_intf = 0x0
>>      |  error = 0
>>      |  glue_dir = 0x0
>> -046|platform_device_add(pdev = 0xFFFFFF8848956000)
>>      |  pdev = 0xFFFFFF8848956000
>> -047|NSX:0x0::0xFFFFFFC07B73DD48(asm)
>> -048|process_one_work(:worker = 0xFFFFFF880300AF00, work =
>> 0xFFFFFF8833434930)
>>      |  worker = 0xFFFFFF880300AF00
>>      |  work = 0xFFFFFF8833434930
>>      |  pool = 0xFFFFFF8B7DCAA180
>>      |  pwq = 0xFFFFFF8B7DCAE600
>>      |  collision = 0x0
>>      |  work_data = 18446743573308827141
>> -049|worker_thread(:__worker = 0xFFFFFF880300AF00)
>>      |  __worker = 0xFFFFFF880300AF00
>>      |  worker = 0x0
>>      |  pool = 0xFFFFFF8B7DCAA180
>> -050|kthread(_create = 0xFFFFFF8803290240)
>>      |  _create = 0xFFFFFF8803290240
>>      |  param = (sched_priority = 0)
>>      |  create = 0x0
>>      |  data = 0xFFFFFF880300AF00
>>      |  threadfn = 0x0
>>      |  ret = ???
>>      |  self = 0xFFFFFF88030D8180
>>      |  done = 0xFFFFFFC082133CB8
>> -051|ret_from_fork(asm)
>>   ---|end of frame
>>
>> -Mukesh

