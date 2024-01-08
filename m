Return-Path: <linux-kernel+bounces-19837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE13827508
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AACD1F2361E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06FF537E1;
	Mon,  8 Jan 2024 16:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HL8tnVM+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D4452F6C;
	Mon,  8 Jan 2024 16:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 408FD2Nu032201;
	Mon, 8 Jan 2024 16:25:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=7BtvbYPfzK5Tc5wemztcm
	NVEcPSSVbRXg2K0DQH70H0=; b=HL8tnVM+qpCC9dZrAVqV0bOAT2URW+mzvr7Wf
	ZehzEWqm19kc8OxLmrtRRQ5st+xF62RLuWiF8Xa8THosKHw3J9xXT9g3MN6zNzOk
	wO07+pmUpcowfpv5VOWE4j2UggAiJqWm4XHHpwUIhHGIO2SFy/6VX89p1GhqvGE3
	PtqBiJDHx0tFh9ccV4aw/Jtj3rYVsfhIxKIV32rc/z9z+mKLhjebAFKdblH7f9Rl
	qv21ETjP/omaF+w7DBNfuGN+SrkFdHvnYOb8A130H2bcbzJ8AOOARPnOLsBtBZ0j
	zIFWhaP7YkAid2lUydcXzA/lMTSWSyf/hFHsy3KytXtRmCBiQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vgfwjrpcx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 16:25:19 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 408GPIW7020674
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Jan 2024 16:25:18 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 8 Jan 2024 08:25:18 -0800
Date: Mon, 8 Jan 2024 08:25:16 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: Johan Hovold <johan@kernel.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Thinh Nguyen
	<Thinh.Nguyen@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Philipp Zabel
	<p.zabel@pengutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Krishna Kurapati PSSNV
	<quic_kriskura@quicinc.com>
Subject: Re: [PATCH 03/12] usb: dwc3: qcom: Merge resources from urs_usb
 device
Message-ID: <20240108162516.GH1315173@hu-bjorande-lv.qualcomm.com>
References: <20231016-dwc3-refactor-v1-0-ab4a84165470@quicinc.com>
 <20231016-dwc3-refactor-v1-3-ab4a84165470@quicinc.com>
 <ZV3WxwxmqH8wRo0A@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZV3WxwxmqH8wRo0A@hovoldconsulting.com>
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: pXTZRqHywNPisdlQCuK5blcXasM8QHJ5
X-Proofpoint-GUID: pXTZRqHywNPisdlQCuK5blcXasM8QHJ5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1011
 impostorscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 priorityscore=1501 mlxscore=0 malwarescore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401080139

On Wed, Nov 22, 2023 at 11:24:07AM +0100, Johan Hovold wrote:
> On Mon, Oct 16, 2023 at 08:11:11PM -0700, Bjorn Andersson wrote:
> > With some ACPI DSDT tables, such as the one found in SC8180X devices,
> > the USB resources are split between the URSn and it's child USBn device
> > nodes, in particular the interrupts are placed in the child nodes.
> > 
> > The solution that was chosen for handling this is to allocate a
> > platform_device from the child node and selectively pick interrupts
> > from the main platform_device, or from this created child device, when
> > creating the platform_device for the DWC3 core.
> > 
> > This does however not work with the upcoming change where the DWC3 core
> > is instantiated from the same platform_device as the glue, as the DRD
> > and host code will attempt to resolve their interrupts from the shared
> > device, and not the child device.
> > 
> > Work around this by merging the resources of the child device into the
> > glue device node, to present a single platform_device with all the
> > resources necessary.
> 
> Nice approach.
> 
> An alternative would be to drop ACPI support completely as Konrad
> suggested. Should simplify both this series and the multiport one.
> 
> Is anyone really using the ACPI support here anymore?
> 

At the introduction of SC8180X and the Lenovo Flex 5G we where able to
run the Debian installer off the ACPI support in the kernel.

Since then, at least the UFS support has regressed to the point that
this would no longer be possible - without anyone noticing.


I would like to see ACPI supported again in the future, but I can't
really argue for its existence currently. In the end the new flattened
code path is mostly shared with the ACPI path, so perhaps it makes sense
to drop the support after this refactor, perhaps not. I will re-evaluate
this.

> > -static struct platform_device *
> > -dwc3_qcom_create_urs_usb_platdev(struct device *dev)
> > +static int dwc3_qcom_acpi_merge_urs_resources(struct platform_device *pdev)
> >  {
> > +	struct device *dev = &pdev->dev;
> > +	struct list_head resource_list;
> > +	struct resource_entry *rentry;
> > +	struct resource *resources;
> >  	struct fwnode_handle *fwh;
> >  	struct acpi_device *adev;
> >  	char name[8];
> > +	int count;
> >  	int ret;
> >  	int id;
> > +	int i;
> >  
> >  	/* Figure out device id */
> >  	ret = sscanf(fwnode_get_name(dev->fwnode), "URS%d", &id);
> >  	if (!ret)
> > -		return NULL;
> > +		return -EINVAL;
> >  
> >  	/* Find the child using name */
> >  	snprintf(name, sizeof(name), "USB%d", id);
> >  	fwh = fwnode_get_named_child_node(dev->fwnode, name);
> >  	if (!fwh)
> > -		return NULL;
> > +		return 0;
> >  
> >  	adev = to_acpi_device_node(fwh);
> >  	if (!adev)
> > -		return NULL;
> > +		return -EINVAL;
> 
> This is currently leaking a reference to the fwnode, I fixed that up
> here:
> 
> 	https://lore.kernel.org/linux-usb/20231117173650.21161-4-johan+linaro@kernel.org/
> 
> > +	INIT_LIST_HEAD(&resource_list);
> > +
> > +	count = acpi_dev_get_resources(adev, &resource_list, NULL, NULL);
> > +	if (count <= 0)
> > +		return count;
> > +
> > +	count += pdev->num_resources;
> > +
> > +	resources = kcalloc(count, sizeof(*resources), GFP_KERNEL);
> > +	if (!resources) {
> > +		acpi_dev_free_resource_list(&resource_list);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	memcpy(resources, pdev->resource, sizeof(struct resource) * pdev->num_resources);
> > +	count = pdev->num_resources;
> > +	list_for_each_entry(rentry, &resource_list, node) {
> > +		/* Avoid inserting duplicate entries, in case this is called more than once */
> 
> Either shorten this one or make it a multiline comment to stay within 80
> chars.
> 
> > +		for (i = 0; i < count; i++) {
> 
> Should this not be pdev->num_resources?
> 

count is first used to denote the number of entries to allocate in the
new list, it's then reset to pdev->num_resources 3 lines above this and
after this list_for_each_entry() it would be the total number of
resources in the new list (which could be less than the allocated number
of items).

I can avoid reusing the variable, to clarify this - if I choose to keep
the ACPI support through the series.

> > +			if (resource_type(&resources[i]) == resource_type(rentry->res) &&
> > +			    resources[i].start == rentry->res->start &&
> > +			    resources[i].end == rentry->res->end)
> > +				break;
> > +		}
> > +
> > +		if (i == count)
> 
> Same here.
> 
> > +			resources[count++] = *rentry->res;
> > +	}
> >  
> > -	return acpi_create_platform_device(adev, NULL);
> > +	ret = platform_device_add_resources(pdev, resources, count);
> > +	if (ret)
> > +		dev_err(&pdev->dev, "failed to add resources\n");
> > +
> > +	acpi_dev_free_resource_list(&resource_list);
> > +	kfree(resources);
> > +
> > +	return ret;
> >  }
> >  
> >  static int dwc3_qcom_probe(struct platform_device *pdev)
> > @@ -817,6 +853,12 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
> >  			dev_err(&pdev->dev, "no supporting ACPI device data\n");
> >  			return -EINVAL;
> >  		}
> > +
> > +		if (qcom->acpi_pdata->is_urs) {
> > +			ret = dwc3_qcom_acpi_merge_urs_resources(pdev);
> > +			if (ret < 0)
> > +				goto clk_disable;
> 
> The clocks have not been enabled here, just return ret.
> 

Right.

Thanks,
Bjorn

> > +		}
> >  	}
> >  
> >  	qcom->resets = devm_reset_control_array_get_optional_exclusive(dev);
> > @@ -857,18 +899,6 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
> >  			qcom->acpi_pdata->qscratch_base_offset;
> >  		parent_res->end = parent_res->start +
> >  			qcom->acpi_pdata->qscratch_base_size;
> > -
> > -		if (qcom->acpi_pdata->is_urs) {
> > -			qcom->urs_usb = dwc3_qcom_create_urs_usb_platdev(dev);
> > -			if (IS_ERR_OR_NULL(qcom->urs_usb)) {
> > -				dev_err(dev, "failed to create URS USB platdev\n");
> > -				if (!qcom->urs_usb)
> > -					ret = -ENODEV;
> > -				else
> > -					ret = PTR_ERR(qcom->urs_usb);
> > -				goto clk_disable;
> > -			}
> > -		}
> >  	}
> >  
> >  	qcom->qscratch_base = devm_ioremap_resource(dev, parent_res);
> 
> Johan

