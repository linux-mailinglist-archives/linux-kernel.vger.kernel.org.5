Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFF376A7E3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 06:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjHAEaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 00:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjHAEaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 00:30:06 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DA119AA;
        Mon, 31 Jul 2023 21:30:05 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3713mbCI002985;
        Tue, 1 Aug 2023 04:29:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=IOap6wsD2WqQR4ellZ9IGBrMpZkVB10AXGo2BYxY2nw=;
 b=hx2LgtyURDFAf0+dZrf7fmBz7Q7iGSSsxSYn3LJ5wlevROokUSC+gt4HHa8yjs330Mc7
 7SWxmiKGYrXDiBeS9H8zRMIBoD0v4doy2KvYS9UyGZzXGE8V2V77ubvtGkC3lG8nRO/c
 +flKcyFDAx5DSmHLwrrPtXE+0+YgnXKPE0rmgQ5dfhfgfh+T6qDZXz0Fz4likrAbHthZ
 LkmT4CNCSbtqli7KBJdPxP7MIUY3dmyrLjYoU/5suY/B9/Pj8+J43m0bH/S74iNWQn5M
 yONPlQyJUp5wOORCugLdtRGAjuZYdJassAlgItJlhkdzLhdCBC3YMhIWehPKUhQuVrga mg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s6d61j5us-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Aug 2023 04:29:47 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3714TkPt031214
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 1 Aug 2023 04:29:46 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 31 Jul 2023 21:29:42 -0700
Date:   Tue, 1 Aug 2023 09:59:39 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Mike Tipton <quic_mdtipton@quicinc.com>
CC:     <djakov@kernel.org>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <corbet@lwn.net>, <linux-pm@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_okukatla@quicinc.com>, <quic_viveka@quicinc.com>,
        <peterz@infradead.org>
Subject: Re: [PATCH v2 3/3] interconnect: Add debugfs test client
Message-ID: <84f3eae9-fe48-4098-9479-9f4cce216ff0@quicinc.com>
References: <20230731224247.10846-1-quic_mdtipton@quicinc.com>
 <20230731224247.10846-4-quic_mdtipton@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230731224247.10846-4-quic_mdtipton@quicinc.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: DFKK3bRc2GuZaDUIgMPFmx6E_UQ_gXUW
X-Proofpoint-ORIG-GUID: DFKK3bRc2GuZaDUIgMPFmx6E_UQ_gXUW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_01,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 phishscore=0 mlxlogscore=634 clxscore=1011 malwarescore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308010041
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 03:42:47PM -0700, Mike Tipton wrote:
> +static int icc_get_set(void *data, u64 val)
> +{
> +	struct debugfs_path *debugfs_path;
> +	char *src, *dst;
> +	int ret = 0;
> +
> +	mutex_lock(&debugfs_lock);
> +
> +	rcu_read_lock();
> +	src = rcu_dereference(src_node);
> +	dst = rcu_dereference(dst_node);
> +
> +	/*
> +	 * If we've already looked up a path, then use the existing one instead
> +	 * of calling icc_get() again. This allows for updating previous BW
> +	 * votes when "get" is written to multiple times for multiple paths.
> +	 */
> +	cur_path = get_path(src, dst);
> +	if (cur_path) {
> +		rcu_read_unlock();
> +		goto out;
> +	}
> +
> +	src = kstrdup(src, GFP_KERNEL);
> +	dst = kstrdup(dst, GFP_KERNEL);
> +	rcu_read_unlock();
> +

Blocking calls are not allowed from RCU critical section. So we would
need to replace GFP_KERNEL with GFP_ATOMIC.

> +	if (!src || !dst) {
> +		ret = -ENOMEM;
> +		goto err_free;
> +	}
> +
> +	cur_path = icc_get(&pdev->dev, src, dst);
> +	if (IS_ERR(cur_path)) {
> +		ret = PTR_ERR(cur_path);
> +		goto err_free;
> +	}
> +
> +	debugfs_path = kzalloc(sizeof(*debugfs_path), GFP_KERNEL);
> +	if (!debugfs_path) {
> +		ret = -ENOMEM;
> +		goto err_put;
> +	}
> +
> +	debugfs_path->path = cur_path;
> +	debugfs_path->src = src;
> +	debugfs_path->dst = dst;
> +	list_add_tail(&debugfs_path->list, &debugfs_paths);
> +
> +	goto out;
> +
> +err_put:
> +	icc_put(cur_path);
> +err_free:
> +	kfree(src);
> +	kfree(dst);
> +out:
> +	mutex_unlock(&debugfs_lock);
> +	return ret;
> +}
