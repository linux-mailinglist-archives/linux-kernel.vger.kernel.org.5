Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3697A6CEC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 23:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbjISV1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 17:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjISV1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 17:27:17 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C686AF;
        Tue, 19 Sep 2023 14:27:12 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38JLI8tw014268;
        Tue, 19 Sep 2023 21:26:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=68AgrexPregETfFQddb2tg2lqkA5lx4XXIB3X7Nu8mo=;
 b=P/o6xqElaR2vT+YHOh//0M6Es4H0r8iYC7ftNmUaJA3WgdWROEU3PswJJGXyXryG3h9f
 x3JAeKPN6Ji+aeGTmDWw/AIYfQj8+SceMHunome11xpEn1GM6Z49u6dI8fCUXXgFJRlQ
 Hp1g/Bi0Bx3OI3B4N3tHlREOHoYOF9m5LdtCp3bdy87pt10MonFgehlyHb9IN5pqVAV0
 hHh+1yggeyW2SKvLEQBUeLsKzJEO+GpA3nJ0JDXlDMh1cZ9bS6U9kutrzP619ToVKOfT
 s4KFplNUwIhCSleCuQvRtY7HSb/i8AxxCYS1xo4OUMyuA66YYW1AJl3PPULN8811PEMJ dA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t6mtsc1sp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Sep 2023 21:26:51 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38JLQpva018900
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Sep 2023 21:26:51 GMT
Received: from [10.110.39.29] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 19 Sep
 2023 14:26:50 -0700
Message-ID: <fa296712-c816-0b58-46b6-8db74cfef038@quicinc.com>
Date:   Tue, 19 Sep 2023 14:26:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v6 03/33] xhci: sideband: add initial api to register a
 sideband entity
Content-Language: en-US
To:     Hillf Danton <hdanton@sina.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>
References: <20230916001026.315-1-quic_wcheng@quicinc.com>
 <20230916090249.94-1-hdanton@sina.com>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <20230916090249.94-1-hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jOcSyysQDaCdg14xnKAE3BcAU8CKpTo9
X-Proofpoint-ORIG-GUID: jOcSyysQDaCdg14xnKAE3BcAU8CKpTo9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_12,2023-09-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 suspectscore=0 adultscore=0 mlxlogscore=646
 malwarescore=0 mlxscore=0 lowpriorityscore=0 spamscore=0 clxscore=1011
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309190182
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hillf,

On 9/16/2023 2:02 AM, Hillf Danton wrote:
> On Fri, 15 Sep 2023 17:09:56 -0700 Wesley Cheng <quic_wcheng@quicinc.com>
>> +static int
>> +xhci_ring_to_sgtable(struct xhci_sideband *sb, struct xhci_ring *ring, struct device *dev)
>> +{
>> +	struct sg_table	*sgt;
>> +	struct xhci_segment *seg;
>> +	struct page **pages;
>> +	unsigned int n_pages;
>> +	size_t sz;
>> +	int i;
>> +
>> +	sz = ring->num_segs * TRB_SEGMENT_SIZE;
>> +	n_pages = PAGE_ALIGN(sz) >> PAGE_SHIFT;
>> +	pages = kvmalloc_array(n_pages, sizeof(struct page *), GFP_KERNEL);
>> +	if (!pages)
>> +		return 0;
>> +
>> +	sgt = kzalloc(sizeof(struct sg_table), GFP_KERNEL);
>> +	if (!sgt) {
>> +		kvfree(pages);
>> +		return 0;
>> +	}
>> +
>> +	seg = ring->first_seg;
>> +
>> +	/*
>> +	 * Rings can potentially have multiple segments, create an array that
>> +	 * carries page references to allocated segments.  Utilize the
>> +	 * sg_alloc_table_from_pages() to create the sg table, and to ensure
>> +	 * that page links are created.
>> +	 */
>> +	for (i = 0; i < ring->num_segs; i++) {
>> +		pages[i] = vmalloc_to_page(seg->trbs);
>> +		seg = seg->next;
>> +	}
> 
> Given dma_pool_zalloc() in xhci_segment_alloc() and dma_alloc_coherent() in
> pool_alloc_page(), it is incorrect to get page from the cpu address returned
> by the dma alloc routine.

Thanks for the review.  That's true...at least on my particular platform 
it was working, because it looks like the cpu addr returned from those 
dma calls was going through the path where we call iommu_dma_alloc() --> 
iommu_dma_alloc_remap().  However, not every implementation will have 
IOMMU involved either.

I'll change the logic to below, so that we can fetch the pages based on 
the IOVA/DMA address.

	for (i = 0; i < ring->num_segs; i++) {
		dma_get_sgtable(dev, sgt, seg->trbs, seg->dma,
					TRB_SEGMENT_SIZE);
		pages[i] = sg_page(sgt->sgl);
		sg_free_table(sgt);
		seg = seg->next;
	}

Thanks
Wesley Cheng
