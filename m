Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2C47840F1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 14:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235750AbjHVMjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 08:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235038AbjHVMjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 08:39:47 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91231BD;
        Tue, 22 Aug 2023 05:39:45 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37MBQbx0023635;
        Tue, 22 Aug 2023 12:39:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=ShQtI3Qulu5M7ZDAEBurAe4TC7mDadyAhyOEXcxg10o=;
 b=o6IKlo5vlwleMKMRQlemEPSsm7BXKPCgheGYvW7eFKCOVfoeURR0FmcZfoE1SjxA2OUY
 cbCAe99cLqM4jmZxW9dKpFJP2WMl6OeIPXOTf0ckI5coS4hLmYjKR5pm8y0iW2TXtb7I
 YGsU9mzlAqPq/au1pm/fw6rEDcNJSBISQu1AngBRLTeg5t6XQ3VmcE0XXgH/ysl5YQ14
 4MWmx4wAVb0/A8wtuUsXYA4RpLuCqTlp1OtgebxI74m/bcRoU/Oyjmubj11MPwT48XFb
 inlLurfY41ieIs4kZSOsmZUSUwZf9/2qiIksMwyBOf63HEIVp8uG6/jo/w6VCN1d1TQP uA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3smgeq19sr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 12:39:41 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37MCdep2032516
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 12:39:40 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Tue, 22 Aug 2023 05:39:36 -0700
Date:   Tue, 22 Aug 2023 18:09:33 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Ninad Naik <quic_ninanaik@quicinc.com>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <psodagud@quicinc.com>,
        <quic_ppareek@quicinc.com>, <quic_kprasan@quicinc.com>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <kernel@quicinc.com>
Subject: Re: [RFC PATCH 1/1] soc: qcom: Add driver to read secondary
 bootloader (XBL) log
Message-ID: <d0f663e7-cee4-451e-9b28-99ba7e6f674a@quicinc.com>
References: <20230822121512.8631-1-quic_ninanaik@quicinc.com>
 <20230822121512.8631-2-quic_ninanaik@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230822121512.8631-2-quic_ninanaik@quicinc.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9jsfzIm52FOzxHnwb7NhOapuUXg_PkiX
X-Proofpoint-ORIG-GUID: 9jsfzIm52FOzxHnwb7NhOapuUXg_PkiX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-22_11,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308220095
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 05:45:12PM +0530, Ninad Naik wrote:
> Qualcomm secondary bootloader (XBL) boot log holds information to
> identify various firmware configuration currently set on the SoC.
> The XBL log is stored in a predefined reserved memory region.
> 
> This drivers provides a way to print XBL logs on the console. To
> do so, it provides a debugfs entry which captures the logs stored
> in this reserved memory region. This entry can now be used to read
> and print the XBL logs to console.
> 
> User can use the below command to print XBL log to console:
>         cat /sys/kernel/debug/xbl_log
> 
> Signed-off-by: Ninad Naik <quic_ninanaik@quicinc.com>
> ---

For a single patch, cover letter may not be needed. The under cut
portion (this area) of the patch can be used to present the additional
details.

>  drivers/soc/qcom/Kconfig        |  13 +++
>  drivers/soc/qcom/Makefile       |   1 +
>  drivers/soc/qcom/dump_xbl_log.c | 139 ++++++++++++++++++++++++++++++++
>  3 files changed, 153 insertions(+)
>  create mode 100644 drivers/soc/qcom/dump_xbl_log.c
> 

[...]

> +static int map_addr_range(struct device_node **parent, const char *name,
> +			  struct xbl_log_data *xbl_data)
> +{
> +	struct device_node *node;
> +	struct resource res;
> +	int ret;
> +
> +	node = of_find_node_by_name(*parent, name);
> +	if (!node)
> +		return -ENODEV;
> +
> +	ret = of_address_to_resource(node, 0, &res);
> +	if (ret) {
> +		dev_err(xbl_data->dev, "Failed to parse memory region\n");
> +		return ret;
> +	}
> +	of_node_put(node);
> +
> +	if (!resource_size(&res)) {
> +		dev_err(xbl_data->dev, "Failed to parse memory region size\n");
> +		return -ENODEV;
> +	}
> +
> +	xbl_data->buf_size = resource_size(&res) - 1;
> +	xbl_data->xbl_buf = devm_memremap(xbl_data->dev, res.start,
> +					  xbl_data->buf_size, MEMREMAP_WB);
> +	if (!xbl_data->xbl_buf) {
> +		dev_err(xbl_data->dev, "%s: memory remap failed\n", name);
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +static int xbl_log_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct xbl_log_data *xbl_data;
> +	struct device_node *parent;
> +	int ret;
> +
> +	xbl_data = devm_kzalloc(dev, sizeof(*xbl_data), GFP_KERNEL);
> +	if (!xbl_data)
> +		return -ENOMEM;
> +
> +	xbl_data->dev = &pdev->dev;
> +	platform_set_drvdata(pdev, xbl_data);
> +
> +	parent = of_find_node_by_path("/reserved-memory");
> +	if (!parent) {
> +		dev_err(xbl_data->dev, "reserved-memory node missing\n");
> +		return -ENODEV;
> +	}
> +

You would need to present the Device Tree binding document for this. For
ex: pls see 
Documentation/devicetree/bindings/reserved-memory/qcom,cmd-db.yaml 

> +	ret = map_addr_range(&parent, "uefi-log", xbl_data);
> +	if (ret)
> +		goto put_node;
> +
> +	xbl_data->dbg_data.data = xbl_data->xbl_buf;
> +	xbl_data->dbg_data.size = xbl_data->buf_size;
> +	xbl_data->dbg_file = debugfs_create_blob("xbl_log", 0400, NULL,
> +						 &xbl_data->dbg_data);
> +	if (IS_ERR(xbl_data->dbg_file)) {
> +		dev_err(xbl_data->dev, "failed to create debugfs entry\n");
> +		ret = PTR_ERR(xbl_data->dbg_file);
> +	}
> +
> +put_node:
> +	of_node_put(parent);
> +	return ret;
> +}
> +
> +static int xbl_log_remove(struct platform_device *pdev)
> +{
> +	struct xbl_log_data *xbl_data = platform_get_drvdata(pdev);
> +
> +	debugfs_remove_recursive(xbl_data->dbg_file);
> +	return 0;
> +}
> +
> +static struct platform_driver xbl_log_driver = {
> +	.probe = xbl_log_probe,
> +	.remove = xbl_log_remove,
> +	.driver = {
> +		   .name = "xbl-log",
> +		   },
> +};
> +
> +static struct platform_device xbl_log_device = {
> +	.name = "xbl-log",
> +};
> +
> +static int __init xbl_log_init(void)
> +{
> +	int ret = 0;
> +
> +	ret = platform_driver_register(&xbl_log_driver);
> +	if (!ret) {
> +		ret = platform_device_register(&xbl_log_device);
> +		if (ret)
> +			platform_driver_unregister(&xbl_log_driver);
> +	}
> +	return ret;
> +}
> +

The platform device registration, the resource parsing can be completely
avoided by adding your compatible entry to reserved_mem_matches
structure defined in drivers/of/platform.c . There are some Qualcomm SoC
devices also present in that list.

> +static void __exit xbl_log_exit(void)
> +{
> +	platform_device_unregister(&xbl_log_device);
> +	platform_driver_unregister(&xbl_log_driver);
> +}
> +
> +module_init(xbl_log_init);
> +module_exit(xbl_log_exit);
> +
> +MODULE_DESCRIPTION("Qualcomm Technologies, Inc. (QTI) XBL log driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.41.0
> 
