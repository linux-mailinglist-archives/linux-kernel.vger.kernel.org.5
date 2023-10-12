Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8123E7C6871
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 10:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235490AbjJLIsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 04:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbjJLIsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 04:48:31 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBA9D62;
        Thu, 12 Oct 2023 01:48:29 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39C7wsFR030511;
        Thu, 12 Oct 2023 08:48:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=EjNwXNWyPPQx56lwNethXlrj7uVzLAOKH/elKpWEvnc=;
 b=WT6Zen/yG/HePZj+8sDvzSQBN4muTc4LpHkv5wjhzvdBGQxo0b6fLiP2ZutizIPP6xjg
 rktSXv4RAvCbZLygY3mgMI7LMWh6n/qSXMTsqLnj1ETk3lwD0L9l5LfytDix1CQLdQjE
 cf0VF/40/Lx5KHs3NLXVRNY+mHhS25kcLcdQdJSVH1ZHiDYHZyrGgXDUeZgc8im6JBj0
 ui2MOGQQTA5/FzIwLLWWEXaWrk9Gwai6KL398NogF7U/siN9F1UKZLo0e3R93gYSDXhi
 iLNMS02mAuTQmsAnyFpoPeUksYF0QptCv8aWtQ48JC2mcXWFEkQimVDHjpRHvzi7dxKO lw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tp9dp0fq4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 08:48:26 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39C8mPTF014669
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 08:48:25 GMT
Received: from [10.216.58.179] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 12 Oct
 2023 01:48:21 -0700
Message-ID: <fad5a7fb-cce1-46bc-a0af-72405c76d107@quicinc.com>
Date:   Thu, 12 Oct 2023 14:18:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] usb: gadget: ncm: Add support to update
 wMaxSegmentSize via configfs
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
To:     =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        onathan Corbet <corbet@lwn.net>,
        Linyu Yuan <quic_linyyuan@quicinc.com>,
        <linux-usb@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_ppratap@quicinc.com>,
        <quic_wcheng@quicinc.com>, <quic_jackp@quicinc.com>
References: <20231009142005.21338-1-quic_kriskura@quicinc.com>
 <20231009142005.21338-2-quic_kriskura@quicinc.com>
 <CANP3RGfEk2DqZ3biyN78ycQYbDxCEG+H1me2vnEYuwXkNdXnTA@mail.gmail.com>
 <CANP3RGcCpNOuVpdV9n0AFxZo-wsfwi8OfYgBk1WHNHaEd-4V-Q@mail.gmail.com>
 <CANP3RGdY4LsOA6U5kuccApHCzL0_jBnY=pLOYrUuYtMZFTvnbw@mail.gmail.com>
 <d19d9d08-c119-4991-b460-49925f601d15@quicinc.com>
Content-Language: en-US
In-Reply-To: <d19d9d08-c119-4991-b460-49925f601d15@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: UUH1rbL7Ry3iYl2STQt5A3KQzu16KWwR
X-Proofpoint-GUID: UUH1rbL7Ry3iYl2STQt5A3KQzu16KWwR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_04,2023-10-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=857 priorityscore=1501 spamscore=0 bulkscore=0
 mlxscore=0 clxscore=1015 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310120073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/10/2023 10:08 AM, Krishna Kurapati PSSNV wrote:
> 

>>
>> ^ is this a problem now if we have >1 gadget?
>> how does it work then?
> 
> 
> You are right. This would effect unwrap call and the wMaxSegmentSize is 
> used directly. Thanks for the catch. I didn't test with 2 NCM interfaces 
> and hence I wasn't able to find this bug. Perhaps changing this to 
> opts->max_segment_size would fix the implementation as unwrap would 
> anyways be called after bind.

Hi Maciej,

  How about the below diff:

---------

+/*
+ * Allow max segment size to be in parity with max_mtu possible
+ * for the interface.
+ */
+#define MAX_DATAGRAM_SIZE      GETHER_MAX_ETH_FRAME_LEN
+
  #define FORMATS_SUPPORTED      (USB_CDC_NCM_NTB16_SUPPORTED |  \
                                  USB_CDC_NCM_NTB32_SUPPORTED)

@@ -194,7 +200,6 @@ static struct usb_cdc_ether_desc ecm_desc = {
         /* this descriptor actually adds value, surprise! */
         /* .iMACAddress = DYNAMIC */
         .bmEthernetStatistics = cpu_to_le32(0), /* no statistics */
-       .wMaxSegmentSize =      cpu_to_le16(ETH_FRAME_LEN),
         .wNumberMCFilters =     cpu_to_le16(0),
         .bNumberPowerFilters =  0,
  };
@@ -1180,10 +1185,15 @@ static int ncm_unwrap_ntb(struct gether *port,
         struct sk_buff  *skb2;
         int             ret = -EINVAL;
         unsigned        ntb_max = 
le32_to_cpu(ntb_parameters.dwNtbOutMaxSize);
-       unsigned        frame_max = le16_to_cpu(ecm_desc.wMaxSegmentSize);
+       unsigned int    frame_max;
         const struct ndp_parser_opts *opts = ncm->parser_opts;
         unsigned        crc_len = ncm->is_crc ? sizeof(uint32_t) : 0;
         int             dgram_counter;
+       struct f_ncm_opts *ncm_opts;
+       const struct usb_function_instance *fi = port->func.fi;
+
+       ncm_opts = container_of(fi, struct f_ncm_opts, func_inst);
+       frame_max = ncm_opts->max_segment_size;

         /* dwSignature */
         if (get_unaligned_le32(tmp) != opts->nth_sign) {
@@ -1440,6 +1450,7 @@ static int ncm_bind(struct usb_configuration *c, 
struct usb_function *f)
          */
         if (!ncm_opts->bound) {
                 mutex_lock(&ncm_opts->lock);
+               ncm_opts->net->mtu = (ncm_opts->max_segment_size - 
ETH_HLEN);
                 gether_set_gadget(ncm_opts->net, cdev->gadget);
                 status = gether_register_netdev(ncm_opts->net);
                 mutex_unlock(&ncm_opts->lock);
@@ -1484,6 +1495,8 @@ static int ncm_bind(struct usb_configuration *c, 
struct usb_function *f)

         status = -ENODEV;

+       ecm_desc.wMaxSegmentSize = (__le16)ncm_opts->max_segment_size;
+

------

I can limit the max segment size to (Max MTU + ETH_HELN) and this would 
be logical to do. Also we can set the frame_max from ncm_opts itself 
while initializing it to 1514 (default value) during alloc_inst callback 
and nothing would break while still being backward compatible.

Let me know your thoughts on this.

Regards,
Krishna,
